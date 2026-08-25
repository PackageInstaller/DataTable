local E = require("ejoysdk_lua.ejoysdk")
local G = require("ejoysdk_lua.ejoysdk_gangplank")
local Vendor = require("ejoysdk_lua.vendors.vendor")
local EM = require("ejoysdk_lua.ejoysdk_module")
local CHANNEL = "SENTRY"
local M = Vendor:Inherit(CHANNEL)
local infoTableMap = {}
local infoTableArray = {}
local TAG = EM.MODULE.SENTRY .. "log_upload"
local configTable = {}
local logUrlTable = {
  single = "https://log-forward.ejoy.com/v1/log",
  multi = "https://log-forward.ejoy.com/v1/logs"
}
local defautConfigTable = {
  appid = "",
  secret = "",
  product = "",
  log_info_limit = 20
}

function M.init(config, cb)
  assert(config)
  assert(type(config.appid) == "string" and 0 ~= #config.appid)
  assert("string" == type(config.secret) and 0 ~= #config.secret)
  configTable = config or defautConfigTable
  if config and not config.log_info_limit then
    configTable.log_info_limit = defautConfigTable.log_info_limit
  end
  if config and "string" == type(config.log_url_domain) and 0 ~= #config.log_url_domain then
    local domain = string.gsub(config.log_url_domain, "^[%s]*(.-)[%s]*$", "%1")
    logUrlTable.single = "https://" .. domain .. "/v1/log"
    logUrlTable.multi = "https://" .. domain .. "/v1/logs"
  end
  cb(true)
end

local sign_src = {
  "account",
  "environment",
  "level",
  "msg",
  "os",
  "product",
  "role",
  "server",
  "timestamp",
  "ver"
}

local function setup_http_params(level, msg, tags, extra_params)
  local info = {}
  local userInfo = G.user_info()
  local uid = "nil"
  if userInfo then
    uid = userInfo.uid
  end
  info.account = uid or "nil"
  info.environment = E.CONFIG.get_config("product")
  info.level = level or " "
  info.msg = msg or " "
  info.os = _ejoysdk.os()
  info.product = configTable.product or configTable.product_code
  local playerInfo = G.player_info()
  local roleId = "nil"
  local serverId = "nil"
  if playerInfo then
    roleId = playerInfo.player_id
    serverId = playerInfo.server_id
  end
  info.role = roleId
  info.server = serverId
  info.timestamp = tostring(os.time())
  local tempVersion = E.Sysinfo:app_version_name()
  if type(tempVersion) == "string" and 0 ~= #tempVersion then
    info.ver = tempVersion
  else
    info.ver = "0"
  end
  local utdid = E.Sysinfo.utdid()
  local utdidValid = utdid and type(utdid) == "string" and 0 ~= #utdid
  local tagsInfo = tags or {}
  if not tagsInfo.utdid and utdidValid then
    tagsInfo.utdid = utdid
  end
  info.tags = tagsInfo
  info.ext = extra_params
  info.appid = configTable.appid
  assert(info.environment)
  assert(info.product)
  assert(info.role)
  assert(info.server)
  return info
end

local function sign_logs(info)
  info = info or {}
  local secret = configTable.secret
  local sign_str = ""
  for _, sign_node in ipairs(sign_src) do
    sign_str = sign_str .. sign_node .. (info[sign_node] or " ")
  end
  sign_str = sign_str .. "\n" .. secret
  local value = _ejoysdk_crypt.hmac_sha1(secret, sign_str)
  local resultBase64 = _ejoysdk_crypt.base64encode(value)
  info.sign = resultBase64
end

local function send_log_to_sentry_server(params, url)
  E.LOG.debug(TAG, "sentry------http - start")
  url = url or logUrlTable.single
  E.HTTP.post(url, {
    trace = true,
    acceptable = E.HTTP.CT_JSON
  }, E.HTTP.CT_JSON, params, function(resp)
    E.LOG.debug(TAG, "sentry------http - end")
    if resp.status == 200 then
      E.LOG.debug(TAG, " log upload success")
    else
      E.LOG.debug(TAG, " http error, resp.status = " .. tostring(resp.status))
    end
  end)
end

function M.sentry_log_error_event(msg, tags, extra_params)
  local info = setup_http_params("Error", msg, tags, extra_params)
  sign_logs(info)
  send_log_to_sentry_server(info)
end

function M.sentry_log_warning_event(msg, tags, extra_params)
  local info = setup_http_params("Warning", msg, tags, extra_params)
  sign_logs(info)
  send_log_to_sentry_server(info)
end

function M.sentry_log_info_event(msg, tags, extra_params)
  if 0 == #infoTableArray then
    infoTableMap = setup_http_params()
    sign_logs(infoTableMap)
  end
  local info = {}
  info.ext = extra_params
  info.level = "Info"
  info.msg = msg
  info.tags = tags
  info.timestamp = tostring(os.time())
  local length = #infoTableArray
  table.insert(infoTableArray, info)
  local tableLimit = configTable.log_info_limit
  if tableLimit <= length + 1 then
    M.sentry_log_info_sent_all_cache()
  end
end

function M.sentry_log_info_sent_all_cache()
  if 0 == #infoTableArray then
    return
  end
  infoTableMap.logs = infoTableArray
  send_log_to_sentry_server(infoTableMap, logUrlTable.multi)
  infoTableMap = {}
  infoTableArray = {}
end

return M
