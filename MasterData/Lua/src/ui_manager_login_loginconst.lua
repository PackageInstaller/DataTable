L_LoginConst = {}
L_LoginConst.VerifyType = {
  Register = 1,
  Login = 2,
  ResetPassword = 102,
  OldPhone = 103,
  NewPhone = 203
}
L_LoginConst.VerifyCodeUseType = {
  Register = 1,
  Login = 2,
  ResetPassword = 3,
  VerifyPhone = 4
}
L_LoginConst.AgeLevel = {
  Unknown = 0,
  Tier0to8 = 1,
  Tier8to16 = 2,
  Tier16to18 = 3,
  Tier18 = 4
}
L_LoginConst.VerifyDesc = {
  [L_LoginConst.VerifyType.Register] = function()
    return L_WordsTpl:getValue("MSG_RequestVerify_Register")
  end,
  [L_LoginConst.VerifyType.Login] = function()
    return L_WordsTpl:getValue("MSG_RequestVerify_Login")
  end,
  [L_LoginConst.VerifyType.ResetPassword] = function()
    return L_WordsTpl:getValue("MSG_RequestVerify_ResetPassword")
  end,
  [L_LoginConst.VerifyType.OldPhone] = function()
    return L_WordsTpl:getValue("MSG_RequestVerify_OldPhone")
  end,
  [L_LoginConst.VerifyType.NewPhone] = function()
    return L_WordsTpl:getValue("MSG_RequestVerify_NewPhone")
  end
}
L_LoginConst.PlatformStatusSuccess = 1000
L_LoginConst.UnderageLoginFailed = 1100
L_LoginConst.IndexDefaultMaster = 1
L_LoginConst.SaveKeyHasRead = "[Platform]HasReadAgreement"
