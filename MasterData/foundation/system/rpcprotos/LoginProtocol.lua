local LoginProtocol = System.NewClass("LoginProtocol")
RPC("S", "S", "I", "B")

function LoginProtocol.Login(userName, password, a, b)
  return "ok"
end

RPC("S", "S", "I", "B")

function LoginProtocol.Login4(userName, password, a, b)
  return "ok"
end

RPC("S", "S", "I", "B")

function LoginProtocol:Login2(userName, password, a, b)
  self.Login1()
  return "ok"
end

RPC("S", "S", "I", "B")

function LoginProtocol:Login1(self, userName, password, a, b)
  return "ok"
end

return LoginProtocol
