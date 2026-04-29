require("luckland_notify_type")
_class("LuckLandNotifyBase", Object)
LuckLandNotifyBase = LuckLandNotifyBase

function LuckLandNotifyBase:Constructor(entity)
  self._notifyEntity = entity
end

function LuckLandNotifyBase:GetNotifyType()
end

function LuckLandNotifyBase:GetNotifyEntity()
  return self._notifyEntity
end

function LuckLandNotifyBase:GetNotifyParams()
  return self._params
end

_class("LLNTPetEnter", LuckLandNotifyBase)
LLNTPetEnter = LLNTPetEnter

function LLNTPetEnter:GetNotifyType()
  return LuckLandNotifyType.PetEnter
end

_class("LLNTPetTurnStart", LuckLandNotifyBase)
LLNTPetTurnStart = LLNTPetTurnStart

function LLNTPetTurnStart:GetNotifyType()
  return LuckLandNotifyType.PetTurnStart
end

_class("LLNTPetTurn", LuckLandNotifyBase)
LLNTPetTurn = LLNTPetTurn

function LLNTPetTurn:GetNotifyType()
  return LuckLandNotifyType.PetTurn
end

_class("LLNTPetTurnEnd", LuckLandNotifyBase)
LLNTPetTurnEnd = LLNTPetTurnEnd

function LLNTPetTurnEnd:GetNotifyType()
  return LuckLandNotifyType.PetTurnEnd
end

_class("LLNTBackpackTurn", LuckLandNotifyBase)
LLNTBackpackTurn = LLNTBackpackTurn

function LLNTBackpackTurn:GetNotifyType()
  return LuckLandNotifyType.BackpackTurn
end

_class("LLNTBuildingTurn", LuckLandNotifyBase)
LLNTBuildingTurn = LLNTBuildingTurn

function LLNTBuildingTurn:GetNotifyType()
  return LuckLandNotifyType.BuildingTurn
end

_class("LLNTCountDown", LuckLandNotifyBase)
LLNTCountDown = LLNTCountDown

function LLNTCountDown:GetNotifyType()
  return LuckLandNotifyType.CountDown
end

_class("LLNTDefeatMonster", LuckLandNotifyBase)
LLNTDefeatMonster = LLNTDefeatMonster

function LLNTDefeatMonster:GetNotifyType()
  return LuckLandNotifyType.DefeatMonster
end

_class("LLNTMonsterTurnStart", LuckLandNotifyBase)
LLNTMonsterTurnStart = LLNTMonsterTurnStart

function LLNTMonsterTurnStart:GetNotifyType()
  return LuckLandNotifyType.MonsterTurnStart
end

_class("LLNTMonsterTurn", LuckLandNotifyBase)
LLNTMonsterTurn = LLNTMonsterTurn

function LLNTMonsterTurn:GetNotifyType()
  return LuckLandNotifyType.MonsterTurn
end

_class("LLNTMonsterAttackEnd", LuckLandNotifyBase)
LLNTMonsterAttackEnd = LLNTMonsterAttackEnd

function LLNTMonsterAttackEnd:GetNotifyType()
  return LuckLandNotifyType.MonsterAttackEnd
end

_class("LLNTMonsterEnter", LuckLandNotifyBase)
LLNTMonsterEnter = LLNTMonsterEnter

function LLNTMonsterEnter:GetNotifyType()
  return LuckLandNotifyType.MonsterEnter
end

_class("LLNTSelectPet", LuckLandNotifyBase)
LLNTSelectPet = LLNTSelectPet

function LLNTSelectPet:GetNotifyType()
  return LuckLandNotifyType.SelectPet
end

_class("LLNTDeletePet", LuckLandNotifyBase)
LLNTDeletePet = LLNTDeletePet

function LLNTDeletePet:Constructor(notifyEntity, delEntity, sourceEntity)
  self._params = {delEntity, sourceEntity}
end

function LLNTDeletePet:GetNotifyType()
  return LuckLandNotifyType.DeletePet
end

_class("LLNTGetPet", LuckLandNotifyBase)
LLNTGetPet = LLNTGetPet

function LLNTGetPet:GetNotifyType()
  return LuckLandNotifyType.GetPet
end

_class("LLNTBuildingUpgrade", LuckLandNotifyBase)
LLNTBuildingUpgrade = LLNTBuildingUpgrade

function LLNTBuildingUpgrade:GetNotifyType()
  return LuckLandNotifyType.BuildingUpgrade
end
