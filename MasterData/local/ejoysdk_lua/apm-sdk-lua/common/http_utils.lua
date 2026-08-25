local JSON = require("ejoysdk_lua.apm-sdk-lua.common.json_utils")
local M = {}
M.__index = M

function M.cal_oss_access_url(resp_body)
  if type(resp_body) == "table" then
    return resp_body.data
  end
  if type(resp_body) == "string" then
    local body = JSON.decode(resp_body)
    local oss_access_url = body and body.data or ""
    return oss_access_url
  end
  return ""
end

return M
