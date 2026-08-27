local ActivityCharDunConfig = {}
ActivityCharDunConfig.chaDunID = {
  python = 10001,
  kuro = 10002,
  haze = 10003,
  nora = 10004,
  magnhilda = 10005,
  helix = 10006,
  zangyin = 10007,
  millau = 10008
}
ActivityCharDunConfig.prefabCfg = {
  [ActivityCharDunConfig.chaDunID.python] = {
    preName = "CharDunPython",
    preClass = "Game.ActivityHeroGrow.UI.UINCharDunPython"
  },
  [ActivityCharDunConfig.chaDunID.kuro] = {
    preName = "CharDunKuro",
    preClass = "Game.ActivityHeroGrow.UI.UINCharDunKuro"
  },
  [ActivityCharDunConfig.chaDunID.haze] = {
    preName = "CharDunHaze",
    preClass = "Game.ActivityHeroGrow.UI.UINCharDunHaze"
  },
  [ActivityCharDunConfig.chaDunID.nora] = {
    preName = "CharDunNora",
    preClass = "Game.ActivityHeroGrow.UI.UINCharDunNora"
  },
  [ActivityCharDunConfig.chaDunID.magnhilda] = {
    preName = "CharDunMagnhilda",
    preClass = "Game.ActivityHeroGrow.UI.UINCharDunMagnhilda"
  },
  [ActivityCharDunConfig.chaDunID.helix] = {
    preName = "CharDunHelix",
    preClass = "Game.ActivityHeroGrow.UI.UINCharDunHelix"
  },
  [ActivityCharDunConfig.chaDunID.zangyin] = {
    preName = "CharDunZangYin",
    preClass = "Game.ActivityHeroGrow.UI.UINCharDunZangYin"
  },
  [ActivityCharDunConfig.chaDunID.millau] = {
    preName = "CharDunMillau",
    preClass = "Game.ActivityHeroGrow.UI.UINCharDunMillau"
  }
}
ActivityCharDunConfig.reddotType = {
  dailyTaskCom = "dailyTaskCom",
  dailyTaskNew = "dailyTaskNew",
  lvReward = "lvReward",
  challengeNew = "challengeNew"
}
ActivityCharDunConfig.reddotIsRedType = {
  [ActivityCharDunConfig.reddotType.dailyTaskCom] = true
}
return ActivityCharDunConfig
