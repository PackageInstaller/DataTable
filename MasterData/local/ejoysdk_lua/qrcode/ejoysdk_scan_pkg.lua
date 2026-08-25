local M = {}
M.ENV = {DEBUG = "debug", RELEASE = "release"}
M.URL_BASE = {
  URL = "https://account.lingxigames.com/m#/"
}
M.URL_BASE_DEBUG = {
  URL = "http://account-lingxi-daily.alibaba.net/m#/"
}
M.URL_PATH = {SCAN = "iosScan"}
local l_env

function M.set_env(env)
  l_env = env
end

local function get_env()
  if l_env then
    return l_env
  end
  local EI = require("ejoysdk_lua.ejoysdk_init")
  do return end
  return EI.env
end

function M.get_url(server)
  local url
  local _env = get_env()
  if _env == M.ENV.RELEASE then
    url = M.URL_BASE.URL .. M.URL_PATH[server]
  else
    url = M.URL_BASE_DEBUG.URL .. M.URL_PATH[server]
  end
  return url
end

return M
