local E = require("ejoysdk_lua.ejoysdk")
local JF_LUA_CONFIG = require("ejoysdk_lua.jf.jf_lua_config")
local M = {}
local roleId = ""
local roleName = ""
local serverId = ""
local serverName = ""

function M.fill_role_info_params(event_log)
  local params = event_log.params or {}
  params.roleId = roleId or ""
  params.roleName = roleName or ""
  params.serverId = serverId or ""
  params.serverName = serverName or ""
  event_log.params = params
end

function M.fill_event_log(event_log)
  event_log.src = "hysdk"
  local event_name = event_log.event
  if event_name == JF_LUA_CONFIG.EVENT_NAMES.SDK_START_UP_SUCCESS or event_name == JF_LUA_CONFIG.EVENT_NAMES.SDK_INSTALL or event_name == JF_LUA_CONFIG.EVENT_NAMES.SDK_START_UP then
    M.fill_ext_base_params(event_log)
  end
  return event_log
end

function M.update_role_info(params)
  params = params or {}
  roleId = params.player_id or ""
  roleName = params.player_name or ""
  serverId = params.server_id or ""
  serverName = params.server_name or ""
end

function M.fill_params(event_params, cb)
  local ES = require("ejoysdk_lua.ejoysdk_stat")
  ES.get_jf_format_data(event_params.event_name, event_params.params, function(event_log)
    M.fill_event_log(event_log)
    cb(event_log)
  end)
end

function M.is_field_in_white_list(target_filed_name)
  local white_privacy_fields = JF_LUA_CONFIG.get_white_privacy_fields()
  if not white_privacy_fields or next(white_privacy_fields) == nil then
    return true
  end
  for _, white_field in pairs(white_privacy_fields) do
    if target_filed_name == white_field then
      return true
    end
  end
end

function M.get_brand()
  if M.is_field_in_white_list("brand") then
    do return end
    return E.Sysinfo.brand, "brand"
  else
    return ""
  end
end

function M.get_model()
  if M.is_field_in_white_list("model") then
    do return end
    return E.Sysinfo.model, "model"
  else
    return ""
  end
end

function M.get_os_version()
  if M.is_field_in_white_list("fr") then
    do return end
    return E.Sysinfo.os_version, "fr"
  else
    return ""
  end
end

function M.get_cpu_model()
  if M.is_field_in_white_list("cpu") then
    do return end
    return E.Sysinfo.get_cpu_model, "cpu"
  else
    return ""
  end
end

function M.get_memory()
  if M.is_field_in_white_list("ramSize") then
    return E.Sysinfo.memory().Total
  else
    return ""
  end
end

function M.get_country()
  if M.is_field_in_white_list("country") then
    do return end
    return E.Sysinfo.country, "country"
  else
    return ""
  end
end

function M.get_res()
  if -1 == E.Sysinfo.screen_width() or -1 == E.Sysinfo.screen_height() then
    return ""
  else
    return tostring(E.Sysinfo.screen_width()) .. "*" .. tostring(E.Sysinfo.screen_height())
  end
end

function M.fill_ext_base_params(event_log)
  local devInfo = event_log.envInfo.devInfo
  devInfo.brand = M.get_brand()
  devInfo.model = M.get_model()
  devInfo.hw_machine = ""
  devInfo.fr = M.get_os_version()
  devInfo.res = M.get_res()
  devInfo.cpuModel = M.get_cpu_model()
  devInfo.ramSize = M.get_memory()
  devInfo.oglVer = ""
  devInfo.net = ""
  devInfo.ip = ""
  devInfo.country = M.get_country()
  devInfo.language = E.Sysinfo.language()
end

return M
