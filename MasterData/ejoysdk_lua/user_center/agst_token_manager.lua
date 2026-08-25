local E = require("ejoysdk_lua.ejoysdk")
local compat = require("ejoysdk_lua.compat.ejoysdk_compat")
local compat_string = compat.string
local EM = require("ejoysdk_lua.ejoysdk_module")
local OVERSEA_AGST_MODEL = require("ejoysdk_lua.user_center.agst_token_oversea_model")
local LX_AGST_MODEL = require("ejoysdk_lua.user_center.agst_token_lx_model")
local BASE_MODEL = require("ejoysdk_lua.user_center.agst_token_model_base")
local M = {}
local TAG = EM.MODULE.USER_CENTER .. "agst_token_mgr"
local AGST_EXT_TYPE = 0
local is_init = false
local agst_model

local function init_agst_model()
  if agst_model then
    return agst_model
  end
  local is_overseas = E.CONFIG.get_config(E.CONFIG.KEY.MULTI_REGIONS_ENABLED)
  if true == is_overseas then
    agst_model = OVERSEA_AGST_MODEL
  else
    agst_model = LX_AGST_MODEL
  end
  agst_model.init()
end

function M.init()
  if is_init then
    return
  end
  init_agst_model()
  is_init = true
end

function M.build_agst_token(pid, ext, ver)
  local timestamp = E.time()
  E.LOG.debug(TAG, "agst# login pid: " .. tostring(pid) .. " ,ext: " .. tostring(ext) .. ", time:" .. tostring(timestamp))
  local agst_ver = ver or BASE_MODEL.AGST_VERSION
  E.LOG.debug(TAG, "agst# token version " .. agst_ver)
  local pack = compat_string.pack("<Bs1I4Bs1", agst_ver, pid, timestamp, AGST_EXT_TYPE, ext)
  do return _ejoysdk_crypt.base64encode end
  return _ejoysdk_crypt.base64encode, pack, pid, timestamp, AGST_EXT_TYPE, ext, timestamp
end

function M.get_token(cb)
  if not is_init then
    E.LOG.debug(TAG, "get_token not init now start init")
    M.init()
  end
  E.LOG.debug(TAG, "get_token start")
  agst_model:get_agst_pid_ext_info(function(info)
    if info then
      local pid = info[BASE_MODEL.KEY.PID] or ""
      local ext = info[BASE_MODEL.KEY.EXT] or ""
      local ver = info[BASE_MODEL.KEY.VER] or BASE_MODEL.AGST_VERSION
      local agst_token = M.build_agst_token(pid, ext, ver)
      cb(agst_token)
    else
      E.LOG.warn(TAG, "get_token failed, pid ext info is nil")
      cb(nil)
    end
  end)
end

function M.clear_token()
  agst_model.clear_token()
end

return M
