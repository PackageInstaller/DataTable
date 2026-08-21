_class("BuffLogicChangeSuperChainCount", BuffLogicBase)
BuffLogicChangeSuperChainCount = BuffLogicChangeSuperChainCount

function BuffLogicChangeSuperChainCount:Constructor(buffInstance, logicParam)
  self._addValue = logicParam.addValue or 0
end

function BuffLogicChangeSuperChainCount:DoLogic(notify)
  local teamEntity
  if self._entity:HasTeam() then
    teamEntity = self._entity
  elseif self._entity:HasPet() then
    teamEntity = self._entity:Pet():GetOwnerTeamEntity()
  end
  if teamEntity then
    local cpt = teamEntity:Attributes()
    local modifyID = self._buffInstance:BuffSeq()
    cpt:Modify("SuperChainCountAddValue", self._addValue, modifyID)
  end
end

_class("BuffLogicRemoveChangeSuperChainCount", BuffLogicBase)
BuffLogicRemoveChangeSuperChainCount = BuffLogicRemoveChangeSuperChainCount

function BuffLogicRemoveChangeSuperChainCount:Constructor(buffInstance, logicParam)
end

function BuffLogicRemoveChangeSuperChainCount:DoLogic(notify)
  local teamEntity
  if self._entity:HasTeam() then
    teamEntity = self._entity
  elseif self._entity:HasPet() then
    teamEntity = self._entity:Pet():GetOwnerTeamEntity()
  end
  if teamEntity then
    local cpt = teamEntity:Attributes()
    local modifyID = self._buffInstance:BuffSeq()
    cpt:RemoveModify("SuperChainCountAddValue", modifyID)
  end
end
