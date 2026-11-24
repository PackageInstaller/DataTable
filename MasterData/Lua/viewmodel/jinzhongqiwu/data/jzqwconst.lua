JZQWConst = {}
JZQWConst.ShopEventIDName = "JZQWShop"
JZQWConst.GameAtlasName = "JinZhongQiWu"
JZQWConst.MedalActivityID = "32101"
JZQWConst.QuestEventID = "JZQW"
JZQWConst.ParticularSceneImage = "ui_hd_jzqw_xs_cj_3a"
JZQWConst.FirstChapter = "101"
JZQWConst.FinalManifestoID = "2"
JZQWConst.RoleMoveSpeed = 150
JZQWConst.ScrollMoveSpeed = 200
JZQWConst.TipsWaitTime = 10
JZQWConst.ChapterJumpWaitTime = 60
JZQWConst.GameObjScale = 0.83
JZQWConst.TalkTypewriterTime = 1
JZQWConst.TalkTypewriterSpeed = 12
JZQWConst.TalkLineWaitTime = 0.5
JZQWConst.TalkClickWaitTime = 0.5
JZQWConst.TalkBubbleMaxWidth = 350
JZQWConst.RoleTalkBubbleOffset = {
    Left = {-30, 0},
    Right = {30, 0}
}
JZQWConst.NpcTalkBubbleOffset = {
    Left = {-10, 0},
    Right = {10, 0}
}
JZQWConst.TalkSpeaker = {
    Npc = 0,
    Role = 1
}

JZQWConst.IntroAnimTime = 1.5
JZQWConst.IntroSceneAnimTime = 0.93
JZQWConst.RedPoint = {
    Home = "18400",
    Pass = "18401",
    Dungeon = "18408",
    Novel = "18403",
    Game = "18404",
    Repeat = "18402",
    MainLineDungeon = "18405",
    HardDungeon = "18406",
    Task = "18407"
}


JZQWConst.PageType = {
    Dungeon = 1,
    Novel = 2,
    Game = 3
}


JZQWConst.EventType = {
    Repeat = "JZQW1",
    MainLine = "JZQW2",
    Hard = "JZQW3",
    Play = "JZQW5",
    Novel = "JZQW4"
}


JZQWConst.PassNumType = {
    Novel = 1,
    Repeat = 2,
    Play = 3,
    MainLine = 4,
    Hard = 5
}


JZQWConst.SceneStatus = {
    None = 0,
    Unlock = 1,
    UnlockShow = 2
}


JZQWConst.EventStatus = {
    None = -1,
    Unlock = 0,
    Finish = 1,
    Other = 2
}


JZQWConst.ChapterStatus = {
    None = 0,
    Unlock = 1,
    Finish = 2
}


JZQWConst.TaskItemType = {
    Chapter = 1,
    Event = 2,
    Reward = 3
}



JZQWConst.CombineType = {
    None = 1,
    Props = 2,
    Obj = 3
}



JZQWConst.ActivateObjStatus = {
    Unlock = 0,
    InteractEnd1 = 1,
    InteractEnd2 = 2,
    InteractEnd3 = 3,
    InteractEnd4 = 4,
    InteractEnd5 = 5,
    Default = -1
}



JZQWConst.ActivateType = {
    Props = 1,
    NPC = 2
}



JZQWConst.InteractType = {
    Talk = 1,
    Pick = 2,
    Interact = 3,
    Commit = 4,
    ChangeScene = 5,
    MoreTalk = 6,
}

JZQWConst.InteractFlagName = {
    [JZQWConst.InteractType.Talk] = "ui_hd_jzqw_jm_dt_cz_icon1",
    [JZQWConst.InteractType.Pick] = "ui_hd_jzqw_jm_dt_cz_icon3",
    [JZQWConst.InteractType.Interact] = "ui_hd_jzqw_jm_dt_cz_icon3",
    [JZQWConst.InteractType.Commit] = "ui_hd_jzqw_jm_dt_cz_icon2",
    [JZQWConst.InteractType.ChangeScene] = "ui_hd_jzqw_jm_dt_cz_icon2"
}



JZQWConst.PropsOperateState = {
    Default = 1,
    NoneOperate = 2,
    Selected = 3,
    Combine = 4
}


JZQWConst.PropsOperateType = {
    Use = 1,
    Combine = 2,
    Look = 3,
    Cancel = 4
}


JZQWConst.DataReportType = {
    Event = 0,
    Chapter = 1,
    Novel = 2,
    Scene = 3,
    Npc = 4
}

JZQWConst.TextLan = {
    TextLan1 = "LangGlobalLan_LangGlobal_name_31215",
    TextLan2 = "LangGlobalLan_LangGlobal_name_31216",
    TextLan3 = "LangGlobalLan_LangGlobal_name_31217",
    TextLan4 = "LangGlobalLan_LangGlobal_name_31218",
    TextLan5 = "LangGlobalLan_LangGlobal_name_31219",
    TextLan6 = "LangGlobalLan_LangGlobal_name_31228",
    TextLan7 = "LangGlobalLan_LangGlobal_name_31229",
    TextLan8 = "LangGlobalLan_LangGlobal_name_31230",
    TextLan9 = "LangGlobalLan_LangGlobal_name_31231",
    TextLan10 = "LangGlobalLan_LangGlobal_name_31232",
    InteractName = {
        [JZQWConst.InteractType.Talk] = "LangGlobalLan_LangGlobal_name_31220",
        [JZQWConst.InteractType.Pick] = "LangGlobalLan_LangGlobal_name_31221",
        [JZQWConst.InteractType.Commit] = "LangGlobalLan_LangGlobal_name_31222",
        [JZQWConst.InteractType.Interact] = "LangGlobalLan_LangGlobal_name_31223",
        [JZQWConst.InteractType.ChangeScene] = "LangGlobalLan_LangGlobal_name_31224"
    }
}