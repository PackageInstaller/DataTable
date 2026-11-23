Match3Const = {}

Match3Const.StandardLine = 8
Match3Const.CellSize = 75
Match3Const.ConfigColFields = {"Column1", "Column2", "Column3", "Column4", "Column5", "Column6", "Column7", "Column8"}
Match3Const.FallSpeed = 0.1
Match3Const.EliminatedWaitTime = 0.3
Match3Const.SwapSuccessTime = 0.3
Match3Const.SwapFaildTime = 0.5
Match3Const.SuperColorBallTime = 3



Match3Const.BornAnimName = "ani_Match3GameMainViewModel_ElementCell_born"
Match3Const.ComboAnimName = "ani_ani_Match3GameMainViewModel_root_EffectGroup_Combo"
Match3Const.XingYunAnimName = "ani_Match3GameMainViewModel_root_EffectGroup_Xingyun"
Match3Const.GameSuccAniName = "ani_Match3GameResultPopup_root_EffectGroup"
Match3Const.GameSuccAniEndName = "ani_Match3GameResultPopup_root_EffectGroup_end"
Match3Const.GameRewardAniName = "ani_Match3GameResultPopup_root_RewardGroup"
Match3Const.GameFaildAniName = "ani_Match3GameResultPopup_root_FailedObj"





Match3Const.ElementType = {
    None = 0,
    Normal1 = 1001,
    Normal2 = 1002,
    Normal3 = 1003,
    Normal4 = 1004,
    Normal5 = 1005,
    Horizontal = 2001,
    Vertical = 2002,
    WoodenBox = 2003,
    ColorBall = 2004,
    SuperColorBall = 2005,
    Ice = 2006,
Bomb = 2007
}


Match3Const.ElementType2ID = {
    [Match3Const.ElementType.Normal1] = 1001,
    [Match3Const.ElementType.Normal2] = 1002,
    [Match3Const.ElementType.Normal3] = 1003,
    [Match3Const.ElementType.Normal4] = 1004,
    [Match3Const.ElementType.Normal5] = 1005,
    [Match3Const.ElementType.Horizontal] = 2001,
    [Match3Const.ElementType.Vertical] = 2001,
    [Match3Const.ElementType.Ice] = 2002,
    [Match3Const.ElementType.WoodenBox] = 2003,
    [Match3Const.ElementType.ColorBall] = 2004,
    [Match3Const.ElementType.SuperColorBall] = 2005
}



Match3Const.PropType = {
Eliminate = 3001,
Swap = 3002,
Reshuffle = 3003
}


Match3Const.UsePropType2Event = {
    [Match3Const.PropType.Eliminate] = UIEventConst.UseEliminateProp,
    [Match3Const.PropType.Swap] = UIEventConst.UseSwapProp,
    [Match3Const.PropType.Reshuffle] = UIEventConst.UseReshuffleProp
}


Match3Const.GameStatus = {
    None = 0,
    Started = 1,
    Matching = 2,
    Comboing = 3,
    Calculating = 4,
    GameEnd = 5
}


Match3Const.ResultType = {
    None = 0,
    Victory = 1,
    Failed = 2
}


Match3Const.UsePropsFaildReason = {
    Success = 1,
NotEnough = 2,
NoneGoalElement = 3
}


Match3Const.PassUnlockType = {
    None = 0,
PrePassScore = 1,
ActivityDelayTime = 2
}


Match3Const.AnimTimeCalType = {
Max = 1,
Sum = 2
}


Match3Const.EliminateType = {
    None = 0,
ManualSwap = 1,
SpecialTrigger = 2
}


Match3Const.ComboStatus = {
    Start = 1,
    Comboing = 2,
    End = 3,
}

Match3Const.Neighbor = {
    {0, -1},
    {-1, 0},
    {1, 0},
    {0, 1}
}

Match3Const.AudioName = {
    "eliminate_combo",
    "eliminate_fire",
    "eliminate_hole",
    "eliminate_knife",
    "eliminate_pop",
    "eliminate_select",
    "eliminate_lost",
    "eliminate_win",
    "eliminate_error"
}

Match3Const.AudioNameIndex = {
    EliminateCombo = 1,
    EliminateFire = 2,
    EliminateHole = 3,
    EliminateKnife = 4,
    EliminatePop = 5,
    EliminateSelect = 6,
    EliminateLost = 7,
    EliminateWin = 8,
    EliminateSwapFail = 9
}



Match3Const.SpecialTypeMap = {
    [Match3Const.ElementType.None] = 3,
    [Match3Const.ElementType.Horizontal] = 4,
    [Match3Const.ElementType.Vertical] = 4,
    [Match3Const.ElementType.ColorBall] = 5,
    [Match3Const.ElementType.SuperColorBall] = 7
}

function Match3Const.GeneralUID()
    if not Match3Const.CurUID then
        Match3Const.CurUID = 10000000
    end
    Match3Const.CurUID = Match3Const.CurUID + 1
    return Match3Const.CurUID
end

function Match3Const.PlaySound(nameIndex)
    local name = Match3Const.AudioName[nameIndex]
    local path = string.format("%sUI/Match3Game/%s.mp3", Path.audio_PATH, name)
    AudioMgr.Singleton:PlayUISFX(path)
end