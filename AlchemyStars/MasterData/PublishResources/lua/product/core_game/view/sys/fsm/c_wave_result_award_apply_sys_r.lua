require("wave_result_award_apply_system")
_class("ClientWaveResultAwardApplySystem_Render", WaveResultAwardApplySystem)
ClientWaveResultAwardApplySystem_Render = ClientWaveResultAwardApplySystem_Render

function ClientWaveResultAwardApplySystem_Render:_DoRenderApplyRelic(TT, applyRelicID, relicBuffs, switchState)
  Log.debug("[MiniMaze] _DoRenderApplyRelic applyRelicID: ", applyRelicID)
  local data = DataAddRelicResult:New(applyRelicID, relicBuffs, switchState)
  local svc = self._world:GetService("PlayBuff")
  svc:PlayBuffSeqs(TT, data:GetBuffSeqList())
end

function ClientWaveResultAwardApplySystem_Render:_DoRenderAddPartner(TT, applyPartnerID, petInfo, matchPet, petRes, hp, maxHP)
  Log.debug("[MiniMaze] _DoRenderApplyRelic _DoRenderAddPartner: ", applyPartnerID)
  local renderPartnerService = self._world:GetService("PartnerRender")
  local data = DataAddPartnerResult:New(applyPartnerID, petInfo, matchPet, petRes, hp, maxHP)
  renderPartnerService:AddPartnerRender(TT, data)
end
