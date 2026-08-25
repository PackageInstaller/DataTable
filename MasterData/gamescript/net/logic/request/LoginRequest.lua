local table = _ENV.table
local LoginRequest = System.NewClass("LoginRequest", ProtoBase)

function LoginRequest:GenToken(conn, account)
  Logger.Info("%s.GenToken: conn: %s, account: %s", self.__name, conn, account)
  local res = NetworkMgr.Instance:Call(conn, "hall.gen_token", {account = account})
  if not res or res.code ~= 200 then
    return false, res
  end
  return true, res
end

function LoginRequest:UserLogin(conn, token, uid)
  local reqLogin = {}
  reqLogin.token = token
  if uid then
    reqLogin.ctx = {uid = uid}
  end
  Logger.Info("%s.UserLogin: conn: %s, token: %s", self.__name, conn, table.tostring(reqLogin))
  local resLogin = NetworkMgr.Instance:Call(conn, "hall.login", reqLogin)
  if 0 ~= resLogin.code and resLogin.code ~= 200 then
    return false, resLogin
  end
  return true, resLogin
end

function LoginRequest:ActorLogin(conn, envInfo, sdkUserInfo)
  Logger.Info("%s.ActorLogin(): conn:%s envInfo:%s, sdkUserInfo:%s", self.__name, conn, envInfo, sdkUserInfo)
  local data, errcode = NetworkMgr.Instance.Login:Login(envInfo, sdkUserInfo)
  return data, errcode
end

return LoginRequest
