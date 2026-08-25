local ACTION_UPDATE_STEP = "update_step"
local E, http, encapsulate, Apus
local ApusUpdateComp = {Inited = false}
local APUS_LOG_LEVEL = {
  Info = "INF",
  Error = "ERR",
  Critical = "CRI"
}
local APUS_ENV_TYPE = {
  P11221 = "-test",
  P11104 = "-test",
  P11222 = "-global",
  P11103 = ""
}
local APUS_ENV_DOMAIN = {
  P11221 = "ejoy",
  P11104 = "ejoy",
  P11222 = "qookkagames",
  P11103 = "ejoy"
}

function ApusUpdateComp.Init(init_params)
  if ApusUpdateComp.Inited then
    return
  end
  E = require("ejoysdk_lua.ejoysdk")
  http = E.HTTP
  encapsulate = require("ejoysdk_lua.apm-sdk-lua.reporter.otlp_http")
  local Apm = require("ejoysdk_lua.apm-sdk-lua.apm")
  Apm.init()
  if init_params and type(init_params) == "table" then
    for k, v in pairs(init_params) do
      ApusUpdateComp[k] = v
    end
  end
  if E then
    ApusUpdateComp.os = E.Sysinfo.os()
    ApusUpdateComp.bundle_version_name = E.Sysinfo.app_version_name()
    ApusUpdateComp.bundle_version_code = E.Sysinfo.app_version_code()
  end
  local log_config = {is_console = true, is_save = true}
  local log_level = E.LOG_LEVEL.debug
  E.set_log_level(log_level)
  E.LOG.enable_sdk_struct_log(true)
  E.open_log_with_config(log_config)
  ApusUpdateComp.Inited = true
end

function ApusUpdateComp.HasInit()
  return ApusUpdateComp.Inited
end

function ApusUpdateComp.UploadLog(event_name, message, args, log_level)
  if not (ApusUpdateComp.Inited and http) or not encapsulate then
    return
  end
  local res = {
    utdid = E and E.Sysinfo.utdid(),
    app_ver = ApusUpdateComp.app_res_ver,
    game_ver = ApusUpdateComp.patch_res_ver,
    env = ApusUpdateComp.product_code,
    os = ApusUpdateComp.os
  }
  local event_name_result = event_name
  args = args or {}
  for tagSymbol in string.gmatch(event_name, "%b{}") do
    local tag = string.match(tagSymbol, "%{(.+)}")
    if tagSymbol and args[tag] then
      event_name_result = string.gsub(event_name_result, tagSymbol, args[tag])
    end
  end
  args.res_key = ApusUpdateComp.local_res_key or "no_local_res_key"
  args.bundle_version_name = ApusUpdateComp.bundle_version_name
  args.bundle_version_code = ApusUpdateComp.bundle_version_code
  message = event_name_result .. ": " .. message
  local logs = {
    {
      body = {
        event_name = event_name,
        module = "app",
        message = message,
        args = args,
        level = log_level,
        timestamp = os.date("%Y-%m-%d %H:%M:%S", os.time())
      },
      type = "apm_log",
      timestamp = os.time()
    }
  }
  local req_body = encapsulate.build_otlp_logs_v2(res, logs)
  E.LOG.debug("apm_req_body", req_body)
  local product_code = string.upper(ApusUpdateComp.product_code)
  local env_type = product_code and APUS_ENV_TYPE[product_code]
  local env_domain = product_code and APUS_ENV_DOMAIN[product_code]
  E.LOG.debug("product_code, env_type, env_domain", product_code, env_type, env_domain)
  if product_code and env_type and env_domain then
    local url = string.format("https://apus-ingester%s.%s.com/%s/v1/logs", env_type, env_domain, product_code)
    
    local function cb(resp)
      if not resp then
        return
      end
      local status = tostring(resp.status)
      E.LOG.debug("[report]url=" .. url .. ", status=" .. status)
      if resp.status ~= 200 then
        E.LOG.error("[report]error sending " .. ",status:" .. status, ", body:", resp.body)
      end
    end
    
    http.post(url, {use_gzip = true}, E.HTTP.CT_JSON, req_body, cb)
  end
end

function ApusUpdateComp.UploadApusInfo(event_name, message, args)
  ApusUpdateComp.UploadLog(event_name, message, args, APUS_LOG_LEVEL.Info)
end

function ApusUpdateComp.UploadApusError(event_name, message, args)
  ApusUpdateComp.UploadLog(event_name, message, args, APUS_LOG_LEVEL.Error)
end

return ApusUpdateComp
