require("main_state_sys")
_class("WaveResultAwardApplySystem", MainStateSystem)
WaveResultAwardApplySystem = WaveResultAwardApplySystem

function WaveResultAwardApplySystem:_GetMainStateID()
  return GameStateID.WaveResultAwardApply
end

function WaveResultAwardApplySystem:_OnMainStateEnter(TT)
  local battleStatCmpt = self._world:BattleStat()
  local relicID, isOpening, partnerID = battleStatCmpt:GetWaveWaitApplyAward()
  battleStatCmpt:ClearWaveWaitApplyAward()
  local switchState = WaveResultAwardNextStateType.None
  if isOpening then
    switchState = WaveResultAwardNextStateType.WaitInput
  elseif partnerID == 0 then
    switchState = WaveResultAwardNextStateType.WaveSwitch
  end
  Log.debug("[MiniMaze] WaveResultAwardApplySystem relicID: ", relicID, " partnerID: ", partnerID, " isOpen ", isOpening, " switchState: ", switchState)
  local applyRelicID, relicBuffs = self:_DoLogicApplyRelic(relicID, switchState)
  if applyRelicID then
    self:_DoRenderApplyRelic(TT, applyRelicID, relicBuffs, switchState)
  end
  local applyPartnerID, petInfo, matchPet, petRes, hp, maxHP = self:_DoLogicAddPartner(partnerID)
  if applyPartnerID then
    self:_DoRenderAddPartner(TT, applyPartnerID, petInfo, matchPet, petRes, hp, maxHP)
  end
  self._world:EventDispatcher():Dispatch(GameEventType.WaveResultAwardApplyFinish, isOpening and 2 or 1)
end

function WaveResultAwardApplySystem:_DoLogicApplyRelic(relicID, switchState)
  local battleSvc = self._world:GetService("Battle")
  return battleSvc:ApplyRelic(relicID, switchState)
end

function WaveResultAwardApplySystem:_DoLogicAddPartner(partnerID)
  local partnerService = self._world:GetService("PartnerLogic")
  Log.debug("[MiniMaze] ChooseMiniMazeWaveAwardCommandHandler:AddPartner partnerID: ", partnerID)
  return partnerService:CreatePartner(partnerID)
end

function WaveResultAwardApplySystem:_DoRenderApplyRelic(TT, applyRelicID, relicBuffs, switchState)
end

function WaveResultAwardApplySystem:_DoRenderAddPartner(TT, applyPartnerID, petInfo, matchPet, petRes, hp, maxHP)
end
