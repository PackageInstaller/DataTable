local E = require("ejoysdk_lua.ejoysdk")
local BaseModel = require("ejoysdk_lua.user_center.agst_token_oversea_model")
local MODEL_NAME = "AGST_TOKEN_LX"
local M = BaseModel:Inherit(MODEL_NAME)
local TAG = "agst_token_lx"

function M.get_ios_agst_info(cb)
  BaseModel.get_ios_agst_info(function(result)
    if not result or "" == result then
      result = nil
      local agst_ios_pid = E.Sysinfo.utdid()
      if agst_ios_pid then
        E.LOG.debug(TAG, "get_ios_token si:" .. agst_ios_pid)
        result = M.build_agst_info(agst_ios_pid, "", 2)
      end
    end
    E.LOG.debug(TAG, {get_ios_token = result})
    cb(result)
  end)
end

M.get_windows_agst_info = M.get_ios_agst_info
M.get_harmonyos_agst_info = M.get_ios_agst_info
M.get_douyin_agst_info = M.get_ios_agst_info
M.get_weixin_agst_info = M.get_ios_agst_info
return M
