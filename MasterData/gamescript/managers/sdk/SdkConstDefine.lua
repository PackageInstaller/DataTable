local Readonly = System.readonly
local M = {}
M.SdkFuncListener = Readonly({
  AcquireListener = "acquire_listener",
  AuthListener = "auth_listener",
  GetServerList = "get_server_list_listener",
  Logout = "logout_listener"
}, "SdkConstDefine.SdkFuncListener")
do return Readonly, M end
return Readonly, M, "SdkConstDefine"
