---
--- 乱流幻境常量
--- Author: dawanfan
--- Date: 2024-1-17 10:51:03
---


---@class ConstantsFairyland
local ConstantsFairyland = {}

ConstantsFairyland.MirrorLevelName =  localize("镜像突破")

ConstantsFairyland.MirrorEnergyStage = {
    Max = 1000,
    Percent33 = 330,
    Percent66 = 660,
}

ConstantsFairyland.SelectNodeIndex = {
    Ball1 = 1,
    Ball2 = 2,
    Ball3 = 3,
    Ball4 = 4,
    Ball5 = 5,
    Mirror = 6
}

ConstantsFairyland.ProgressRewardState = {
    NotTrigger = 1,
    CanTake = 2,
    Taked = 3
}

ConstantsFairyland.Colors = {
    ["1"] = "Red",
    ["2"] = "Green",
    ["3"] = "Blue"
}

ConstantsFairyland.QuestStatus = {
    Close = 1,
    Open = 2,
    Finish = 3
}

ConstantsFairyland.ParameterKey = {
    SCENE_ID = 1,
    ROUND_NUM = 2,
    BATTLE_MAX_NUM = 3,
    BATTLE_RULE_ID = 4,
    TICKET_ID = 10,
    TICKET_LIMIT = 11,
    TICKET_RECOVER_TIME = 12
}


return ConstantsFairyland
