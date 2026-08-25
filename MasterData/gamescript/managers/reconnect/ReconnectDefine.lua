local ReconnectDefine = {}
ReconnectDefine.State = {
  StartUp = "StartUp",
  Reconnect = "Reconnecting",
  WaitConnectRet = "WaitConnectRet",
  WaitResCheckRet = "WaitResCheckRet",
  Stop = "Stop"
}
ReconnectDefine.Ret = {
  Discount = "discount",
  Success = "success",
  Reconnect = "reconnect",
  Failed = "failed",
  ChooseConnect = "chooseConnect",
  ReturnLogin = "returnLogin",
  LoginSuccess = "LoginSuccess"
}
return ReconnectDefine
