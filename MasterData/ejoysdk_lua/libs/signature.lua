local E = require("ejoysdk_lua.ejoysdk")
local JSON = require("ejoysdk_lua.ejoysdk_json")
local V = require("ejoysdk_lua.version")
local M = {}
local TAG = "base#signature"
local token_sign_maps = {}
local sign_debugable = false

local function get_sign(m_token)
  local sign_secret
  if m_token then
    sign_secret = token_sign_maps[m_token] and token_sign_maps[m_token].server_sercret
  end
  return sign_secret
end

M.SIGN = {MOMENT_TOKEN = 1, EJOY_TOKEN = 2}

local function sign_encode_header(header, token_type_key_str)
  if not header or type(header) ~= "table" then
    return "\n"
  end
  local encode_header = ""
  local k_list = {}
  local lower_header = {}
  for k, v in pairs(header) do
    table.insert(k_list, k:lower())
    lower_header[k:lower()] = v
  end
  if not next(k_list) then
    return "\n"
  end
  table.sort(k_list)
  for _, k_item in pairs(k_list) do
    if E.Utils.start_with(k_item, "ag-") or k_item == token_type_key_str then
      encode_header = encode_header .. tostring(k_item) .. ":" .. tostring(lower_header[k_item]) .. "\n"
    end
  end
  return encode_header
end

local function gen_salt(sign_secret, ag_sign_valid_time)
  local valid_time = 0
  if ag_sign_valid_time > 0 then
    valid_time = ag_sign_valid_time
  end
  local pos_list = {
    valid_time % 5,
    4,
    valid_time % 6,
    valid_time % 7,
    3,
    2
  }
  local salt = ""
  for _, index in ipairs(pos_list) do
    local pos = index + 1
    salt = salt .. string.sub(sign_secret, pos, pos)
  end
  return salt .. "jK" .. sign_secret
end

M.moment_support_sign_versions = {
  "1",
  "2",
  "3"
}
M.moment_sign_version = "1"
M.ejoy_sign_secret = "cd13R8mopbZhC+ors8oAs++gAXSOmdgLofc0xujmNz+m8LfIz16dwMj/MNx0pkytkD5HO4pXn7i7LnZK5n36Cg=="
M.ejoy_sign_version = "2"

function M.general_authorization(method, request_path, query, headers, body, _content_type, sign_token, token_type)
  local ej_signature = ""
  local sign_secret
  local token_type_key_str = ""
  local sign_version = "1"
  if token_type == M.SIGN.MOMENT_TOKEN then
    sign_secret = M.get_secret(sign_token)
    token_type_key_str = "moment-token"
    sign_version = M.moment_sign_version
  elseif token_type == M.SIGN.EJOY_TOKEN then
    sign_secret = M.ejoy_sign_secret
    token_type_key_str = "ejoy-token"
    sign_version = M.ejoy_sign_version
  end
  if sign_token and sign_secret then
    local method_str = method or "post"
    local request_path_str = request_path or ""
    local query_str = query or ""
    local body_str = ""
    if type(body) == "string" then
      body_str = body
    elseif type(body) == "table" then
      if _content_type == E.HTTP.CT_JSON then
        body_str = JSON.encode(body)
      elseif _content_type == E.HTTP.CT_URLENCODED then
        return
      end
    end
    headers = headers or {}
    if headers["ag-sign-time"] == nil then
      local sign_time = math.floor(E.time_ms() / 1000)
      if 0 == sign_time then
        sign_time = os.time()
      end
      headers["ag-sign-time"] = sign_time
      headers["ag-sign-valid-time"] = sign_time + 300
    end
    local header_str = sign_encode_header(headers, token_type_key_str)
    if "1" == sign_version then
      ej_signature = method_str:lower() .. request_path_str .. query_str .. "\n" .. header_str .. body_str .. "\n" .. sign_secret
    elseif "2" == sign_version then
      ej_signature = method_str:lower() .. query_str .. "\n" .. header_str .. body_str .. "\n" .. sign_secret
    else
      local ag_sign_valid_time = tonumber(headers["ag-sign-valid-time"]) or 0
      ej_signature = method_str:lower() .. query_str .. "\n" .. header_str .. body_str .. "\n" .. gen_salt(sign_secret, ag_sign_valid_time)
    end
    ej_signature = _ejoysdk_crypt.base64encode(_ejoysdk_crypt.sha1(ej_signature))
    if not ej_signature then
      E.LOG.error(TAG, "ej_signature is nil")
      return
    end
    ej_signature = "version:" .. tostring(sign_version) .. " signature:" .. ej_signature .. " caller:lua" .. tostring(V.LUA_VERSION)
    if sign_debugable then
      ej_signature = ej_signature .. " force_check:true"
    end
  end
  if "" ~= ej_signature then
    if token_type == M.SIGN.MOMENT_TOKEN then
      headers["moment-token-signature"] = ej_signature
    elseif token_type == M.SIGN.EJOY_TOKEN then
      headers["ejoy-token-signature"] = ej_signature
    end
  end
  return ej_signature
end

local function found_max_version(server_signature_versions, local_signature_versions)
  local ret_sign_version
  if 0 == #server_signature_versions then
    ret_sign_version = local_signature_versions[#local_signature_versions]
  else
    local find_max_version
    local client_maps = {}
    for _, v in ipairs(local_signature_versions) do
      client_maps[v] = true
    end
    for _, v in pairs(server_signature_versions) do
      if client_maps[v] then
        if nil == find_max_version then
          find_max_version = v
        elseif tonumber(v) > tonumber(find_max_version) then
          find_max_version = v
        end
      end
    end
    if nil == find_max_version then
      find_max_version = local_signature_versions[#local_signature_versions]
    end
    ret_sign_version = find_max_version
  end
  return ret_sign_version
end

function M.save_secret(client_private, m_token, exchange_data, signature_versions)
  if m_token and exchange_data and exchange_data.public_key then
    local server_public = _ejoysdk_crypt.base64decode(exchange_data.public_key)
    local server_sercret = _ejoysdk_crypt.dhsecret(server_public, client_private)
    token_sign_maps[m_token] = {
      server_sercret = _ejoysdk_crypt.base64encode(server_sercret),
      server_public = exchange_data.public_key,
      signature_versions = signature_versions
    }
    if signature_versions and type(signature_versions) == "table" then
      M.moment_sign_version = found_max_version(signature_versions, M.moment_support_sign_versions) or M.moment_support_sign_versions[#M.moment_support_sign_versions]
    else
      M.moment_sign_version = "1"
    end
  end
end

function M.get_secret(m_token)
  do return get_sign end
  return get_sign, m_token
end

function M.get_server_signature_versions(m_token)
  local _signature_versions
  if m_token then
    _signature_versions = token_sign_maps[m_token] and token_sign_maps[m_token].signature_versions
  end
  return _signature_versions
end

function M.set_debugable(_debugable)
  sign_debugable = _debugable
end

local prevent_replay_ag_sign_secret = "JC6fvxLQkNYQRk2FY&u7R58!rxJBFvjH4jkcu39fpkt4&BHTksLDweg8tdaZaHY5"

function M.general_prevent_replay_request(method, query, headers, body)
  if not method then
    E.LOG.debug(TAG, "method can not be nil")
    return nil
  end
  if type(headers) ~= "table" then
    E.LOG.debug(TAG, "headers is not table type")
    return nil
  end
  local sign_time = headers["ag-sign-time"]
  if not sign_time then
    sign_time = math.floor(E.time_ms() / 1000)
    if 0 == sign_time then
      sign_time = E.time()
      E.LOG.debug(TAG, "use E.time() instead----")
    end
    headers["ag-sign-time"] = sign_time
  end
  local sign_time_valid = headers["ag-sign-valid-time"]
  if not sign_time_valid then
    sign_time_valid = sign_time + 300
    headers["ag-sign-valid-time"] = sign_time_valid
  end
  headers["ag-signback"] = true
  local body_str = ""
  if type(body) == "string" then
    body_str = body
  elseif type(body) == "table" then
    body_str = JSON.encode(body) or ""
    E.LOG.debug(TAG, " encode body to string")
  end
  local random_num = headers["ag-nonce"]
  if not random_num then
    random_num = math.random(1, 100000000)
    headers["ag-nonce"] = random_num
    E.LOG.debug(TAG, "generate random number, ag-nonce = " .. tostring(random_num))
  end
  local header_string = sign_encode_header(headers, nil)
  local query_str = query or ""
  local full_str = method .. query_str .. "\n" .. header_string .. body_str .. "\n" .. prevent_replay_ag_sign_secret
  local signature_result = _ejoysdk_crypt.base64encode(_ejoysdk_crypt.sha1(full_str))
  headers["platform-req-signature"] = "version:2 signature:" .. signature_result
  return signature_result, random_num
end

function M.general_prevent_modify_response(headers, body)
  if not headers or type(headers) ~= "table" then
    E.LOG.debug(TAG, "header is not right, maybe it nil or not table type, type=" .. tostring(type(headers)))
    return nil
  end
  local body_str = ""
  if type(body) == "string" then
    body_str = body or ""
  elseif type(body) == "table" then
    body_str = JSON.encode(body) or ""
  end
  local header_string = sign_encode_header(headers, nil)
  local full_str = header_string .. body_str .. "\n" .. prevent_replay_ag_sign_secret
  local signature_result = _ejoysdk_crypt.base64encode(_ejoysdk_crypt.sha1(full_str))
  return signature_result
end

function M.sign_string_with_md5(sign_string)
  local md5_result
  if type(_ejoysdk_crypt.md5) == "function" then
    md5_result = _ejoysdk_crypt.md5(sign_string)
  elseif type(_ejoysdk_crypt.md5) == "table" and _ejoysdk_crypt.md5.sum then
    md5_result = _ejoysdk_crypt.hexencode(_ejoysdk_crypt.md5.sum(sign_string))
  end
  return md5_result
end

function M.sign_string_with_hmac_sha256(secret_key, sign_string)
  local result
  if _ejoysdk_crypt.hmac_sha256 then
    result = _ejoysdk_crypt.hexencode(_ejoysdk_crypt.hmac_sha256(secret_key, sign_string))
  end
  return result
end

return M
