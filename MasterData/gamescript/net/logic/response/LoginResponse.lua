local RPC = System.RPC
local LoginResponse, Super = System.NewClass("Login", ProtoBase)

function LoginResponse:Startup()
  Super.Startup(self)
end

function LoginResponse:Shutdown()
  Super.Shutdown(self)
end

function LoginResponse:ClearData()
  Super.ClearData(self)
end

RPC("I", "S")

function LoginResponse:LoginConfirm(actorId, actorName)
  Logger.Info("LoginConfirm 登陆确认, %d, %s", actorId, actorName)
end

return LoginResponse
