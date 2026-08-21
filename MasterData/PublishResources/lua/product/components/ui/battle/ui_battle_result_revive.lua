_class("UIBattleResultRevive", UIController)
UIBattleResultRevive = UIBattleResultRevive

function UIBattleResultRevive:OnShow(uiParams)
end

function UIBattleResultRevive:OnHide()
end

function UIBattleResultRevive:OKOnClick()
  GameGlobal.GameRecorder():RecordAction(GameRecordAction.UIInput, {
    ui = "UIBattleResultRevive",
    input = "OKOnClick",
    args = {}
  })
  GameGlobal:GetInstance():ExitCoreGame()
  local matchResult = self:_GetMatchResult()
  if MatchType.MT_ExtMission == matchResult.m_nMatchType then
    local matchModule = GameGlobal.GetModule(MatchModule)
    local enterData = matchModule:GetMatchEnterData()
    local missionInfo = enterData:GetMissionCreateInfo()
    local extMissionModule = GameGlobal.GetModule(ExtMissionModule)
    local stageid
    local extState = extMissionModule:UI_GetExtMissionState(missionInfo.m_nExtMissionID)
    local cfg_ext_mission = Cfg.cfg_extra_mission[missionInfo.m_nExtMissionID]
    if cfg_ext_mission then
      local stagelist = cfg_ext_mission.ExtTaskList
      if extState == EnumExtMissionState.Down then
        stageid = stagelist[1]
      else
        for i = 1, #stagelist do
          stageid = stagelist[i]
          local star = extMissionModule:UI_GetExtTaskState(missionInfo.m_nExtMissionID, stageid)
          if star <= 0 then
            break
          end
        end
      end
    else
      stageid = missionInfo.m_nExtTaskID
    end
    Log.debug("[match] UIBattleResultRevive:OnExitCoreGame SwitchState UIExtraMissionStage")
    self:SwitchState(UIStateType.UIExtraMissionStage, missionInfo.m_nExtMissionID, stageid)
  else
    self:SwitchState(UIStateType.UIDiscovery)
  end
end

function UIBattleResultRevive:CancelOnClick()
  GameGlobal.GameRecorder():RecordAction(GameRecordAction.UIInput, {
    ui = "UIBattleResultRevive",
    input = "CancelOnClick",
    args = {}
  })
  self:CloseDialog()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.CancelReborn)
end

function UIBattleResultRevive:_GetMatchResult()
  local gameMatchModule = self:GetModule(GameMatchModule)
  local matchResult = UI_MatchResult:New()
  matchResult = gameMatchModule:GetMachResult()
  return matchResult
end
