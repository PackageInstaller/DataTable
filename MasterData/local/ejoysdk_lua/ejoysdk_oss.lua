local E = require("ejoysdk_lua.ejoysdk")
local TAG = "album#ejoysdk_oss"
local M = {}
local HTTP = E.HTTP
M.FILE_TYPE = {
  image = "image/*",
  video = "video/*",
  audio = "audio/*",
  text = "text/*"
}
M.INPUT_TYPE = {DATA = "data", PATH = "path"}
M.SUPPORT_SIGN_VERSION = {"v4"}
local OSS_ERR_MAP = {
  FieldItemTooLong = 4001,
  InvalidArgument = 4002,
  InvalidDigest = 4003,
  EntityTooLarge = 4004,
  InvalidEncryptionAlgorithmError = 4005,
  IncorrectNumberOfFilesInPOSTRequest = 4006,
  FileAlreadyExists = 4091,
  KmsServiceNotEnabled = 4031,
  FileImmutable = 4092
}

local function read_file_content(file_path_name)
  local data
  if E.Sysinfo.os() == "ios" then
    data = E.sync_call("read_file", file_path_name)
  else
    data = _ejoysdk.lread(file_path_name)
  end
  return data
end

local function parse_xml_key(content, key)
  local start_key = "<" .. key .. ">"
  local end_key = "</" .. key .. ">"
  local start_index = string.find(content, start_key)
  local end_index = string.find(content, end_key)
  if start_index and end_index then
    do return string.sub, content, start_index + #start_key end
    return string.sub, content, start_index + #start_key, end_index - 1
  end
end

local function parse_oss_err_msg(status, err_msg)
  if err_msg then
    E.LOG.debug(TAG, "parse_oss_err_msg" .. err_msg)
    local oss_code = parse_xml_key(err_msg, "Code")
    local message = parse_xml_key(err_msg, "Message")
    if oss_code and message then
      message = tostring(oss_code) .. " : " .. tostring(message)
      local code = OSS_ERR_MAP[oss_code] or status
      return code, message
    end
  end
  return status, err_msg
end

function M.upload_file(file, file_type, media_type, oss_params, cb)
  local file_content = file
  if file_type == M.INPUT_TYPE.PATH then
    file_content = read_file_content(file)
  end
  if file_content and media_type and oss_params and oss_params.host then
    local url = "http://" .. tostring(oss_params.host)
    local headers = {}
    headers.Date = os.date("%a, %d %b %Y %X GMT")
    local params = {headers = headers}
    local form_data = E.HTTP.FormData.New()
    if oss_params.auth_version and oss_params.auth_version == "v4" then
      form_data:add_simple_part("x-oss-signature-version", oss_params["x-oss-signature-version"])
      form_data:add_simple_part("x-oss-credential", oss_params["x-oss-credential"])
      form_data:add_simple_part("x-oss-date", oss_params["x-oss-date"])
      form_data:add_simple_part("x-oss-signature", oss_params["x-oss-signature"])
    else
      form_data:add_simple_part("OSSAccessKeyId", oss_params.accessid)
      form_data:add_simple_part("Signature", oss_params.signature)
    end
    form_data:add_simple_part("policy", oss_params.policy)
    form_data:add_simple_part("key", oss_params.key)
    form_data:add_simple_part("Expires", oss_params.expire)
    form_data:add_simple_part("x-oss-object-acl", oss_params["x-oss-object-acl"])
    form_data:add_simple_part("callback", oss_params.callback)
    form_data:add_part("file", file_content, media_type, nil, oss_params.file_name)
    HTTP.post(url, params, form_data:content_type(), form_data:build(), function(resp)
      if resp.status == 200 then
        E.LOG.debug(TAG, "oss_upload succ")
        E.log(resp)
        cb(true, resp.body)
      else
        E.LOG.debug(TAG, "oss_upload fail")
        E.log(resp)
        local code, msg = parse_oss_err_msg(resp.status, tostring(resp.body))
        cb(false, code, msg)
      end
    end)
  else
    E.LOG.debug(TAG, "input params is invalid")
    local body = {
      code = -1,
      msg = "input params is invalid"
    }
    cb(false, -1, body)
  end
end

M.SCALE_TYPE = {
  LFIT = "lfit",
  MFIT = "mfit",
  FILL = "fill",
  PAD = "pad",
  FIXED = "fixed"
}

function M.get_thumb_url(key, thumb_config)
  local scale_type = thumb_config.scale_type or M.SCALE_TYPE.FILL
  local thumb_config_params = "image/resize,m_" .. tostring(scale_type)
  local width = thumb_config.width
  local height = thumb_config.height
  local pad_color = thumb_config.pad_color
  if nil == width and nil == height then
    return key
  end
  if width then
    thumb_config_params = thumb_config_params .. ",w_" .. tostring(width)
  end
  if height then
    thumb_config_params = thumb_config_params .. ",h_" .. tostring(height)
  end
  if scale_type == M.SCALE_TYPE.PAD and pad_color then
    thumb_config_params = thumb_config_params .. ",color_" .. tostring(pad_color)
  end
  return key .. "?x-oss-process=" .. thumb_config_params
end

return M
