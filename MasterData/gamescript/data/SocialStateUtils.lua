local SocialStateUtils = {}
local stageGroupType2OnlineStateMap = {
  [CommonDefine.StageGroupType.MainCopy] = SocialDefine.OnlineState.MainCopyInvestigate,
  [CommonDefine.StageGroupType.MaterialCopy] = SocialDefine.OnlineState.DailyCopy,
  [CommonDefine.StageGroupType.TrinketCopy] = SocialDefine.OnlineState.Copy,
  [CommonDefine.StageGroupType.DisposableSchoolTower] = SocialDefine.OnlineState.WeekChallenge,
  [CommonDefine.StageGroupType.AlternationSchoolTower] = SocialDefine.OnlineState.WeekChallenge,
  [CommonDefine.StageGroupType.DailyChallenge] = SocialDefine.OnlineState.DailyChallenge,
  [CommonDefine.StageGroupType.WeekBoss] = SocialDefine.OnlineState.WeeklyBoss
}
local urlToOnlineStateMap = {
  [Urls.ActivityMainPanel] = SocialDefine.OnlineState.Activity,
  [Urls.AwakerBasePanel] = SocialDefine.OnlineState.Awaker,
  [Urls.BattlePassMainPanel] = SocialDefine.OnlineState.Battlepass,
  [Urls.DungeonsMainView] = SocialDefine.OnlineState.Challenge,
  [Urls.CopyMainView] = SocialDefine.OnlineState.MainCopy,
  [Urls.MainShopPanel] = SocialDefine.OnlineState.Shop,
  [Urls.SummonPanel] = SocialDefine.OnlineState.Summon,
  [Urls.TaskMainPanel] = SocialDefine.OnlineState.Manual,
  [Urls.BagView] = SocialDefine.OnlineState.Bag,
  [Urls.AlchemyMainPanel] = SocialDefine.OnlineState.Alchemy,
  [Urls.TaskDispatchView] = SocialDefine.OnlineState.Dispatch,
  [Urls.MainPanelPVP] = SocialDefine.OnlineState.PreparePVP,
  [Urls.PVPRankPanel] = SocialDefine.OnlineState.PreparePVP,
  [Urls.PvPBattleMainPanel] = SocialDefine.OnlineState.PVP,
  [Urls.PVPCollectionListPanel] = SocialDefine.OnlineState.PreparePVP,
  [Urls.PvpCollectionMainView] = SocialDefine.OnlineState.PreparePVP,
  [Urls.PvPTeamBuildMainPanel] = SocialDefine.OnlineState.PreparePVP,
  [Urls.PvPTeamSingleBuildPanel] = SocialDefine.OnlineState.PreparePVP,
  [Urls.PvPTeamMultiBuildPanel] = SocialDefine.OnlineState.PreparePVP,
  [Urls.PvPMatchingPanel] = SocialDefine.OnlineState.PreparePVP,
  [Urls.PvPMatchRstPanel] = SocialDefine.OnlineState.PreparePVP,
  [Urls.MainPanel] = ""
}

function SocialStateUtils.SetPlayerStateByUI(topUI)
  if bg.battleData and bg.battleData.isMock then
    return
  end
  if 0 == (PlayerDataUtils.GetPlayerUid() or 0) then
    return
  end
  if SceneMgr.Instance:IsInTown() then
    SocialDataUtils.ReqOnSetState(urlToOnlineStateMap[topUI])
    return
  elseif Urls.PvPBattleMainPanel == topUI and Urls.PvPBattleTrainPanel ~= topUI then
    SocialDataUtils.ReqOnSetState(urlToOnlineStateMap[topUI])
  end
  local stageData = WorldStageManager.Instance:GetCurStageData()
  if not stageData then
    return
  end
  if table.contains({
    Urls.WorldStageMainPanel,
    Urls.DbgBattlePanel
  }, topUI) then
    local stageGroupId, stageId = stageData.groupId, stageData.stageId
    local stageGroupType = stageGroupId and DT.StageGroup[stageGroupId] and DT.StageGroup[stageGroupId].Type
    local state = stageGroupType2OnlineStateMap[stageGroupType] or ""
    SocialDataUtils.ReqOnSetState(SocialDataUtils.CreateFacadeStateStr(state, {stageId}))
  end
end

function SocialStateUtils.SetPlayerState(stateName)
  if bg.battleData and bg.battleData.isMock then
    return
  end
  if 0 == (PlayerDataUtils.GetPlayerUid() or 0) then
    return
  end
  SocialDataUtils.ReqOnSetState(stateName)
end

local StateNameMap = {
  [SocialDefine.OnlineState.PVPPwdMatching] = "MatchingPasswordBattle",
  [SocialDefine.OnlineState.PVPPwdDraft] = "ConductPasswordBattle2",
  [SocialDefine.OnlineState.PVPPwdPrebuilt] = "ConductPasswordBattle1"
}

function SocialStateUtils.GetStateDesc(stateKey)
  if StateNameMap[stateKey] then
    do return LT.Text end
    return LT.Text, StateNameMap[stateKey], nil
  end
  local langKey = "SocializeOnLineState_" .. stateKey
  if DT.LanguageConfig[langKey] then
    do return LT.Text end
    return LT.Text, langKey
  end
  do return LT.Text end
  return LT.Text, "SocialSystemStrollingAround"
end

return SocialStateUtils
