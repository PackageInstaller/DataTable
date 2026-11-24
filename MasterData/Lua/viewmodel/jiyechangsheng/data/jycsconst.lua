JYCSConst = {}
JYCSConst.ShopEventIDName = "JYCSShop"
JYCSConst.TaskEventIDName = "JYCSSTask"
JYCSConst.ShopCharacterID = "W0182"
JYCSConst.AtlasName = "JiYeChangSheng"
JYCSConst.MedalActivityID = "33101"
JYCSConst.QuestEventID = "JYCS"
JYCSConst.DungeonBuffName = "jiyechangsheng"
JYCSConst.EmptyIconEventID = "JYCS5001"
JYCSConst.OperateRollTime = 0.5
JYCSConst.LoseCloseTime = 3
JYCSConst.SuccessCloseTime = 3
JYCSConst.RoleMoveDelay = 0.8
JYCSConst.RoleRotateDelay = 0.2
JYCSConst.IntroAnimTime = 1.5
JYCSConst.RedPoint = {
    Home = "18600",
    Pass = "18601",
    Dungeon = "18607",
    Novel = "18603",
    Game = "18404",
    Repeat = "18602",
    MainLineDungeon = "18605",
    HardDungeon = "18604",
    Task = "18606"
}


JYCSConst.PageType = {
    Dungeon = 1,
    Novel = 2,
    Game = 3
}


JYCSConst.EventType = {
    Repeat = "JYCS1",
    MainLine = "JYCS2",
    Hard = "JYCS3",
    Play = "JYCS5",
    Novel = "JYCS4"
}


JYCSConst.PassNumType = {
    Novel = 1,
    Repeat = 2,
    Play = 3,
    MainLine = 4,
    Hard = 5
}

JYCSConst.EventTypeMapIndex = {
    ["JYCS1"] = 2,
    ["JYCS2"] = 4,
    ["JYCS3"] = 5,
    ["JYCS5"] = 3,
    ["JYCS4"] = 1
}


JYCSConst.SceneStatus = {
    None = 0,
    Unlock = 1,
    UnlockShow = 2
}


JYCSConst.EventStatus = {
    None = -1,
    Unlock = 0,
    Finish = 1,
    Other = 2
}


JYCSConst.GameCommonPopupType = {
    Event = 1,
    Roll = 2,
    LatestCal = 3,
    ExistBattle = 4,
}


JYCSConst.GameEventPopupType = {
    Lose = 1,
    Success = 2
}


JYCSConst.BlockStatus = {
    Default = 1,
    Finish = 2
}


JYCSConst.MapEventType = {
    Select = 0,
    Danger = 1,
    Move = 2,
    Score = 3,
    Battle = 4,
    Empty = 5,
    Finish = 6,
    RunFight = 7
}


JYCSConst.EventNeedStep = {
    NormalRoll = 1,
    CostRoll = 2,
    IgnoreMonsterRound = 3
}

JYCSConst.MaxEventChainCount = 20


JYCSConst.GameStep = {
    None = 0,
    PlayerMove = 1,
    PlayerMoveEnd = 2,
    TriggerEvent = 3,
    TriggerEventEnd = 4,
    MonsterMove = 5,
    MonsterMoveEnd = 6,
    PassEnd = 7
}

JYCSConst.TextLan = {}