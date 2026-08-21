_class("BuffLogicAddRecoveryUpByTeam", BuffLogicBase)
BuffLogicAddRecoveryUpByTeam = BuffLogicAddRecoveryUpByTeam

function BuffLogicAddRecoveryUpByTeam:Constructor(buffInstance, logicParam)
  self._recoveryRate = logicParam.recoveryRate or 0
  self._maxRecoveryRate = logicParam.maxRecoveryRate
  self._modifyPetAttribute = logicParam.modifyPetAttribute or 0
end

function BuffLogicAddRecoveryUpByTeam:DoLogic(notify)
  local petEntity = self._entity
  local eTeam = petEntity:Pet():GetOwnerTeamEntity()
  local matchType = self._world:MatchType()
  if self._world:MatchType(GetMatchTypeType.SeasonMazeWorldBoss) == MatchType.MT_SeasonMaze and petEntity:HasPetPstID() then
    eTeam = petEntity
  end
  local cAttrTeam = eTeam:Attributes()
  local nRateTeamHP = cAttrTeam:GetCurrentHP() / cAttrTeam:CalcMaxHp()
  local nFinalRecoveryUpRate = (1 - nRateTeamHP) * 100 * self._recoveryRate
  if nFinalRecoveryUpRate > self._maxRecoveryRate then
    nFinalRecoveryUpRate = self._maxRecoveryRate
  end
  local modifyEntity = eTeam
  if self._modifyPetAttribute == 1 then
    modifyEntity = self._entity
  end
  modifyEntity:Attributes():Modify("AddBloodRate", nFinalRecoveryUpRate, self:GetBuffSeq())
end

_class("BuffLogicRemoveRecoveryUpByTeam", BuffLogicBase)
BuffLogicRemoveRecoveryUpByTeam = BuffLogicRemoveRecoveryUpByTeam

function BuffLogicRemoveRecoveryUpByTeam:Constructor(buffInstance, logicParam)
  self._modifyPetAttribute = logicParam.modifyPetAttribute or 0
end

function BuffLogicRemoveRecoveryUpByTeam:DoLogic()
  local eBeneficiary = self._entity:Pet():GetOwnerTeamEntity()
  if self._modifyPetAttribute == 1 then
    eBeneficiary = self._entity
  end
  eBeneficiary:Attributes():RemoveModify("AddBloodRate", self:GetBuffSeq())
end
