_class("BuffResultAddPetLegendPowerByHP", BuffResultBase)
BuffResultAddPetLegendPowerByHP = BuffResultAddPetLegendPowerByHP

function BuffResultAddPetLegendPowerByHP:Constructor(pstID, power, ready, previouslyReady)
  self._petPstID = pstID
  self._curPower = power
  self._ready = ready
  self._previouslyReady = previouslyReady
end

function BuffResultAddPetLegendPowerByHP:GetPetPstID()
  return self._petPstID
end

function BuffResultAddPetLegendPowerByHP:GetCurrentPower()
  return self._curPower
end

function BuffResultAddPetLegendPowerByHP:IsSkillReady()
  return self._ready
end

function BuffResultAddPetLegendPowerByHP:IsPreviouslyReady()
  return self._previouslyReady
end

function BuffResultAddPetLegendPowerByHP:RequireNTPowerReady(petEntityID)
  self._petEntityID = petEntityID
  self._requireNTPowerReady = true
end

function BuffResultAddPetLegendPowerByHP:GetPetEntityID()
  return self._petEntityID
end

function BuffResultAddPetLegendPowerByHP:IsNTPowerReadyRequired()
  return self._requireNTPowerReady
end
