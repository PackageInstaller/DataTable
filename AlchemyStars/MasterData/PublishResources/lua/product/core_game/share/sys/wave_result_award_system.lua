require("main_state_sys")
_class("WaveResultAwardSystem", MainStateSystem)
WaveResultAwardSystem = WaveResultAwardSystem

function WaveResultAwardSystem:_GetMainStateID()
  return GameStateID.WaveResultAward
end

function WaveResultAwardSystem:_OnMainStateEnter(TT)
  local choosePartnerFun, choosePartners, choseRelics
  local talentSvc = self._world:GetService("Talent")
  local openingChoose = talentSvc:NeedChooseOpeningRelic()
  if openingChoose then
    local groupID, count = talentSvc:GetChooseRelicParam()
    choseRelics = self:_DoLogicRandomRelic(groupID, count)
  else
    choosePartners = self:_DoLogicCalcChoosePartner()
    choseRelics = self:_DoLogicRandomRelic()
  end
  if choosePartners then
    function choosePartnerFun(choosenRelicID)
      self:_DoRenderShowChoosePartner(TT, choosePartners, choosenRelicID)
    end
  end
  if choseRelics then
    self:_DoRenderShowChooseRelic(TT, choseRelics, choosePartnerFun, openingChoose)
  else
    if choosePartnerFun then
      choosePartnerFun(0)
    else
    end
  end
end

function WaveResultAwardSystem:_DoLogicCalcChoosePartner()
  local partnerService = self._world:GetService("PartnerLogic")
  return partnerService:_CalcChoosePartner()
end

function WaveResultAwardSystem:_DoLogicRandomRelic(groupID, count)
  local battleSvc = self._world:GetService("Battle")
  return battleSvc:CalcRandomRelic(groupID, count)
end

function WaveResultAwardSystem:_DoRenderShowChoosePartner(TT, choosePartners, choosenRelicID)
end

function WaveResultAwardSystem:_DoRenderShowChooseRelic(TT, chooseRelics, openingChoose)
end
