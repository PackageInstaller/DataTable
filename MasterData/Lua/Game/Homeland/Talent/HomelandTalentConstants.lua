---@class HomelandTalentConstants
local HomelandTalentConstants = {}

HomelandTalentConstants.CurrencyId = 4119001

HomelandTalentConstants.RedPointName = "HomelandTalent.RedPoint"

---@alias HomelandTalentConstants.NodeNames string
HomelandTalentConstants.NodeNames = {
    Cell      = "Cell",
    LabelNode = "LabelNode",
    CellEmpty = "CellEmpty",
}

---@alias HomelandTalentConstants.EventNames string
HomelandTalentConstants.EventNames = {
    RequestSuccess   = "HomelandTalent.RequestSuccess",
    CloseDetailPopup = "HomelandTalent.CloseDetailPopup",
}

---@alias HomelandTalentConstants.PrefabPath string
HomelandTalentConstants.PrefabPath = {
    HomelandTalentDetailsPopup = "Prefabs/Homeland/HomelandTalentDetailsPopup.prefab"
}

---@alias HomelandTalentConstants.EnvPath string
HomelandTalentConstants.EnvPath = {
    HomelandTalentDisplayCell       = "Game.Homeland.Talent.HomelandTalentDisplayCell",
    HomelandTalentDisplayLabelNode  = "Game.Homeland.Talent.HomelandTalentDisplayLabelNode",
    -- HomelandTalentPositionSmallNode = "Game.Homeland.Talent.HomelandTalentPositionSmallNode",
    HomelandTalentPositionNode = "Game.Homeland.Talent.HomelandTalentPositionNode",
    -- HomelandTalentPositionBigNode   = "Game.Homeland.Talent.HomelandTalentPositionBigNode",
    HomelandTalentDetailsPopup      = "Game.Homeland.Talent.HomelandTalentDetailsPopup",
}

---@alias HomelandTalentConstants.LineEffectName string
HomelandTalentConstants.LineEffectName = {
    UP_UnLock = "UIFX_Line_UP_UnLock",
    Center_UnLock = "UIFX_Line_Center_UnLock",
    Down_UnLock = "UIFX_Line_Down_UnLock",
    UP_Locked = "UIFX_Line_UP_Locked",
    Center_Locked = "UIFX_Line_Center_Locked",
    Down_Locked = "UIFX_Line_Down_Locked",
}

HomelandTalentConstants.LineEffectNameConf = {
    --- key 线的个数        
    [1]             = {
        {UnLock = HomelandTalentConstants.LineEffectName.Center_UnLock, Lock = HomelandTalentConstants.LineEffectName.Center_Locked},
    },
    [2]             = {
        {UnLock = HomelandTalentConstants.LineEffectName.UP_UnLock, Lock = HomelandTalentConstants.LineEffectName.UP_Locked},
        {UnLock = HomelandTalentConstants.LineEffectName.Down_UnLock, Lock = HomelandTalentConstants.LineEffectName.Down_Locked},
    },
    [3]             = {
        {UnLock = HomelandTalentConstants.LineEffectName.UP_UnLock, Lock = HomelandTalentConstants.LineEffectName.UP_Locked},
        {UnLock = HomelandTalentConstants.LineEffectName.Center_UnLock, Lock = HomelandTalentConstants.LineEffectName.Center_Locked},
        {UnLock = HomelandTalentConstants.LineEffectName.Down_UnLock, Lock = HomelandTalentConstants.LineEffectName.Down_Locked},
    },
}

---@alias HomelandTalentConstants.AnimNames string
HomelandTalentConstants.AnimNames = {
    Line_Red             = "HomelandTalentDisplayDialog_Line_Red",
    Line_Green           = "HomelandTalentDisplayDialog_Line_Green",
    Line_Blue            = "HomelandTalentDisplayDialog_Line_Blue",

    SmallNodeBlue        = "HomelandTalentPositionSmallNode_TalentType_Blue",
    SmallNodeGreen       = "HomelandTalentPositionSmallNode_TalentType_Green",
    SmallNodeRed         = "HomelandTalentPositionSmallNode_TalentType_Red",
    SmallNodeLock        = "HomelandTalentPositionSmallNode_Lock",
    SmallNodeMax         = "HomelandTalentPositionSmallNode_Max",
    SmallNodeActive      = "HomelandTalentPositionSmallNode_Active",
    SmallNodeActiveUnmet = "HomelandTalentPositionSmallNode_Active_Unmet",

    BigNodeBlue          = "HomelandTalentPositionBigNode_TalentType_Blue",
    BigNodeGreen         = "HomelandTalentPositionBigNode_TalentType_Green",
    BigNodeRed           = "HomelandTalentPositionBigNode_TalentType_Red",
    BigNodeLock          = "HomelandTalentPositionBigNode_Lock",
    BigNodeMax           = "HomelandTalentPositionBigNode_Max",
    BigNodeActive        = "HomelandTalentPositionBigNode_Active",
    BigNodeActiveUnmet   = "HomelandTalentPositionBigNode_Active_Unmet",

    HomelandTalentDetailsPopup_Choose = "HomelandTalentDetailsPopup_Choose",
    HomelandTalentDetailsPopup_Cancel = "HomelandTalentDetailsPopup_Cancel",

}

---@alias HomelandTalentConstants.TalentNodeStatus integer
HomelandTalentConstants.TalentNodeStatus = {
    Lock        = 1,
    ActiveUnmet = 2,
    Active      = 3,
    Max         = 4,
    SystemLock  = 5,
}

return HomelandTalentConstants