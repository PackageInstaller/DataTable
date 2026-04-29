_class("BuffLogicRandomChangePetVoice", BuffLogicBase)
BuffLogicRandomChangePetVoice = BuffLogicRandomChangePetVoice

function BuffLogicRandomChangePetVoice:Constructor(buffInstance, logicParam)
  self._prob = logicParam.prob
  self._voiceList = logicParam.voiceList
end

function BuffLogicRandomChangePetVoice:DoLogic()
  local teamEntity = self._world:Player():GetCurrentTeamEntity()
  local buffCmpt = teamEntity:BuffComponent()
  buffCmpt:SetBuffValue("RandomChangeAllPetVoiceProb", self._prob)
  buffCmpt:SetBuffValue("RandomChangeAllPetVoiceVoiceList", self._voiceList)
end

_class("BuffLogicRemoveRandomChangePetVoice", BuffLogicBase)
BuffLogicRemoveRandomChangePetVoice = BuffLogicRemoveRandomChangePetVoice

function BuffLogicRemoveRandomChangePetVoice:Constructor(buffInstance, logicParam)
end

function BuffLogicRemoveRandomChangePetVoice:DoLogic()
  local teamEntity = self._world:Player():GetCurrentTeamEntity()
  local buffCmpt = teamEntity:BuffComponent()
  buffCmpt:SetBuffValue("RandomChangeAllPetVoiceProb", nil)
  buffCmpt:SetBuffValue("RandomChangeAllPetVoiceVoiceList", nil)
end
