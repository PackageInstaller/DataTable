require("pop_star_round_enter_system")
_class("PopStarRoundEnterSystem_Render", PopStarRoundEnterSystem)
PopStarRoundEnterSystem_Render = PopStarRoundEnterSystem_Render

function PopStarRoundEnterSystem_Render:_DoRenderTrapBeforePlayer(TT)
  local playAISvc = self._world:GetService("PlayAI")
  if playAISvc == nil then
    return
  end
  playAISvc:DoCommonRountine(TT)
end

function PopStarRoundEnterSystem_Render:_DoRenderShowPetUI(TT, curWaveRound)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.UpdateRoundCount, curWaveRound)
  local renderBattleService = self.world:GetService("RenderBattle")
  renderBattleService:ShowUIPetInfo(TT)
  self:_DoRenderGuidePlayer(TT)
end

function PopStarRoundEnterSystem_Render:_DoRenderGuidePlayer(TT)
  local guideService = self._world:GetService("Guide")
  local guideTaskId = guideService:Trigger(GameEventType.GuideRound, GuideRoundTurn.PlayerTurn)
  while not TaskHelper:GetInstance():IsTaskFinished(guideTaskId, true) do
    YIELD(TT)
  end
end

function PopStarRoundEnterSystem_Render:_DoRenderPlayerTurnBuff(TT, teamEntity, formerTeamOrder)
  if teamEntity == nil then
    return
  end
  local playBuffSvc = self._world:GetService("PlayBuff")
  playBuffSvc:PlayPlayerTurnBuff(TT, teamEntity, formerTeamOrder, false)
end

function PopStarRoundEnterSystem_Render:_DoRenderUpdatePetPower(TT, tNotifyArray)
  if not tNotifyArray or #tNotifyArray == 0 then
    return
  end
  local playBuffSvc = self._world:GetService("PlayBuff")
  for _, notify in ipairs(tNotifyArray) do
    playBuffSvc:PlayBuffView(TT, notify)
  end
end

function PopStarRoundEnterSystem_Render:_DoRenderSaveRoundBeginPlayerPos(TT, teamEntity)
  local playBuffSvc = self._world:GetService("PlayBuff")
  playBuffSvc:PlayBuffView(TT, NTSaveRoundBeginPlayerPosEnd:New(teamEntity))
end

function PopStarRoundEnterSystem_Render:_DoRenderFeatureOnRoundEnter(TT)
  local featureRSvc = self._world:GetService("FeatureRender")
  if featureRSvc then
    featureRSvc:DoFeatureOnRoundEnter(TT)
  end
end
