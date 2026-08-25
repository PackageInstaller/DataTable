local BASE_API = require("ejoysdk_lua.libs.base_api")
local vortex_api = BASE_API:New("vortex")
local EM = require("ejoysdk_lua.ejoysdk_module")
local _TAG = EM.MODULE.SERVER_API .. "vortex"
local M = {}

function M.get_rt_counter(rtc_id, cb)
  local body = {rtc_id = rtc_id}
  local opt = {use_moment_token = true}
  vortex_api:post("/client_api/get_rt_counter", {}, body, opt, cb)
end

return M
