_class("CallbackRet", Object)
CallbackRet = CallbackRet

function CallbackRet:Constructor()
  self.flag = -1
  self.desc = ""
  self.platform = 0
end

CallbackRet._proto = {
  [1] = {"flag", "int"},
  [2] = {"desc", "string"},
  [3] = {"platform", "int"}
}
_class("TokenRet", Object)
TokenRet = TokenRet

function TokenRet:Constructor()
  self.type = 0
  self.value = ""
  self.expiration = 0
end

TokenRet._proto = {
  [1] = {"type", "int"},
  [2] = {"value", "string"},
  [3] = {"expiration", "int64"}
}
_class("LoginRet", CallbackRet)
LoginRet = LoginRet

function LoginRet:Constructor()
  self.open_id = ""
  self.user_id = ""
  self.pf = ""
  self.pf_key = ""
  self.token = {}
end

LoginRet._proto = {
  [10] = {"open_id", "string"},
  [11] = {"user_id", "string"},
  [12] = {"pf", "string"},
  [13] = {"pf_key", "string"},
  [14] = {
    "token",
    "list<TokenRet>"
  }
}
