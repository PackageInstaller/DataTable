require("round_enter_system")
_class("RoundEnterSystem_Render", RoundEnterSystem)
RoundEnterSystem_Render = RoundEnterSystem_Render

function RoundEnterSystem_Render:_DoRenderShowPetTurnTips(TT)
  local renderEntitySvc = self._world:GetService("RenderEntity")
  if self._world:GetGameTurn() == GameTurnType.LocalPlayerTurn then
    renderEntitySvc:ShowUITurnTips(true)
  else
    renderEntitySvc:ShowUITurnTips(false)
  end
end

function RoundEnterSystem_Render:_DoRenderShowPetUI(TT, curWaveRound)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.UpdateRoundCount, curWaveRound)
  local renderBattleService = self.world:GetService("RenderBattle")
  renderBattleService:ShowUIPetInfo(TT)
  if GameSingle then
    return
  end
  self:_DoRenderGuidePlayer(TT)
end

function RoundEnterSystem_Render:_DoRenderPlayerTurnBuff(TT, teamEntity, formerTeamOrder)
  if teamEntity == nil then
    return
  end
  local utilDataSvc = self._world:GetService("UtilData")
  local gsmState = utilDataSvc:GetCurMainStateID()
  local playBuffService = self._world:GetService("PlayBuff")
  playBuffService:RefreshLockHPView(TT, gsmState)
  playBuffService:PlayPlayerTurnBuff(TT, teamEntity, formerTeamOrder, false)
  local renderBattleService = self._world:GetService("RenderBattle")
  renderBattleService:ChangeTeamLeaderRender(TT, teamEntity)
  if GameSingle then
    return
  end
  self:_DoRenderGuideBuffEnd(TT)
end

function RoundEnterSystem_Render:_DoRenderChessTurnBuff(TT)
  local playBuffService = self._world:GetService("PlayBuff")
  playBuffService:PlayChessTurnBuff(TT)
end

function RoundEnterSystem_Render:_DoRenderGuidePlayer(TT)
  local guideService = self._world:GetService("Guide")
  local utilStatSvc = self._world:GetService("UtilData")
  local guideTaskId = guideService:Trigger(GameEventType.GuideRound, GuideRoundTurn.PlayerTurn)
  while not TaskHelper:GetInstance():IsTaskFinished(guideTaskId, true) do
    YIELD(TT)
  end
end

function RoundEnterSystem_Render:_DoRenderUpdatePetPower(TT, tNotifyArray)
  if not tNotifyArray or #tNotifyArray == 0 then
    return
  end
  local playbfsvc = self._world:GetService("PlayBuff")
  for _, notify in ipairs(tNotifyArray) do
    playbfsvc:PlayBuffView(TT, notify)
  end
end

function RoundEnterSystem_Render:_DoRenderTrapBeforePlayer(TT)
  local playAISvc = self._world:GetService("PlayAI")
  if playAISvc == nil then
    return
  end
  playAISvc:DoCommonRountine(TT)
end

function RoundEnterSystem_Render:_DoRenderResetChessPetFinishState(TT)
  local chessSvcRender = self._world:GetService("ChessRender")
  local group = self._world:GetGroup(self._world.BW_WEMatchers.ChessPetRender)
  for i, v in ipairs(group:GetEntities()) do
    chessSvcRender:ShowChessPetCanMoveEffect(v:GetID())
  end
  self._world:EventDispatcher():Dispatch(GameEventType.ChessUIStateTransit, UIBattleWidgetChessState.FinishTurnOnly)
end

function RoundEnterSystem_Render:_DoRenderFeatureOnRoundEnter(TT)
  local featureSvcRender = self._world:GetService("FeatureRender")
  if featureSvcRender then
    featureSvcRender:DoFeatureOnRoundEnter(TT)
  end
end

function RoundEnterSystem_Render:_DoRenderFeatureOnRoundEnterEarly(TT)
  local featureSvcRender = self._world:GetService("FeatureRender")
  if featureSvcRender then
    featureSvcRender:DoFeatureOnRoundEnterEarly(TT)
  end
end

function RoundEnterSystem_Render:_DoRenderFeatureShowBanPetSkill(TT)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.FeatureShowBanPetSkill, true)
end

function RoundEnterSystem_Render:_DoRenderSaveRoundBeginPlayerPos(TT, teamEntity)
  self._world:GetService("PlayBuff"):PlayBuffView(TT, NTSaveRoundBeginPlayerPosEnd:New(teamEntity))
end

function RoundEnterSystem_Render:_DoRenderPunishmentRoundEnter(TT, damageInfo, isWarnRound)
  if isWarnRound then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.UpdateOutOfRoundPunish)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.ShowHideOutOfRoundPunishWarn, true)
    YIELD(TT, 2000)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.ShowHideOutOfRoundPunishWarn, false)
    return
  end
  if not damageInfo then
    return
  end
  GameGlobal.EventDispatcher():Dispatch(GameEventType.ShowHideOutOfRoundDamageWarning, false)
  YIELD(TT)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.ShowHideOutOfRoundDamageWarning, true)
  local eTeam = self._world:Player():GetLocalTeamEntity()
  local rsvcPlayDamage = self._world:GetService("PlayDamage")
  local taskID = rsvcPlayDamage:AsyncUpdateHPAndDisplayDamage(eTeam, damageInfo)
  while not TaskHelper:GetInstance():IsTaskFinished(taskID) do
    YIELD(TT)
  end
  GameGlobal.EventDispatcher():Dispatch(GameEventType.UpdateOutOfRoundPunish)
end

function RoundEnterSystem_Render:_DoRenderRefreshMonsterAntiActiveSkill(TT)
  local monsterGroup = self._world:GetGroup(self._world.BW_WEMatchers.MonsterID)
  for _, e in ipairs(monsterGroup:GetEntities()) do
    GameGlobal.EventDispatcher():Dispatch(GameEventType.UpdateAntiActiveSkill, e:GetID())
  end
end

function RoundEnterSystem_Render:_DoRenderGuideBuffEnd(TT)
  local guideService = self._world:GetService("Guide")
  local guideTaskId = guideService:Trigger(GameEventType.GuideRound, GuideRoundTurn.BuffEnd)
  while not TaskHelper:GetInstance():IsTaskFinished(guideTaskId, true) do
    YIELD(TT)
  end
end
