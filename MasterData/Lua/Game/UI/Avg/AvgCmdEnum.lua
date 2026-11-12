local AvgCmdEnum = {
  ConfigType = {
    ST = 1,
    BB = 2,
    BT = 3,
    CG = 4,
    PM = 5,
    GD = 6,
    DP = 7
  },
  Category = {
    stage = 1,
    character = 2,
    talk = 3,
    phone = 4,
    bubble = 5,
    choice = 6,
    audio = 7,
    etc = 8
  },
  BgColor = {
    blue = Color(0.368, 0.537, 0.705, 1),
    gray = Color(0.5, 0.5, 0.5, 1),
    green = Color(0, 0.75, 0.5, 1),
    pink = Color(1, 0, 1, 1),
    purpel = Color(0.5, 0, 0.75, 1),
    white = Color(1, 1, 1, 1),
    yellow = Color(1, 1, 0.5, 1),
    cyan = Color(0, 1, 1, 1)
  },
  ParamType = {
    bol = 1,
    num = 2,
    str = 3
  },
  ParamInputType = {
    ddIdx = 1,
    ddVal = 2,
    iptStr = 3,
    iptNum = 4,
    idChar = 5,
    idContact = 6,
    idRes = 7
  }
}
return AvgCmdEnum
