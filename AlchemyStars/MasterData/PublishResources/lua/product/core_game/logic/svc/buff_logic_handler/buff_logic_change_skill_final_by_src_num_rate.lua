_class("BuffLogicChangeSkillFinalBySrcNumRate", BuffLogicBase)
BuffLogicChangeSkillFinalBySrcNumRate = BuffLogicChangeSkillFinalBySrcNumRate

function BuffLogicChangeSkillFinalBySrcNumRate:Constructor(buffInstance, logicParam)
  self._srcNum = logicParam.srcNum or {}
  self._srcNumRate = logicParam.srcNumRate
  self._effectList = logicParam.effectList
  self._entity = buffInstance._entity
end

function BuffLogicChangeSkillFinalBySrcNumRate:DoLogic(notify)
  local sourceEntity = self:GetEntity()
  if sourceEntity:HasPet() then
    sourceEntity = sourceEntity:Pet():GetOwnerTeamEntity()
  end
  local boardServiceLogic = self._world:GetService("BoardLogic")
  local posList = boardServiceLogic:GetGridPosByPieceType(self._srcNum)
  local pieceCount = table.count(posList)
  local promoteRate = pieceCount * self._srcNumRate
  if promoteRate == 0 then
    return
  end
  for _, paramType in ipairs(self._effectList) do
    self._buffLogicService:ChangeSkillFinalParam(self._entity, self:GetBuffSeq(), paramType, promoteRate)
  end
end

_class("BuffLogicRemoveSkillFinalBySrcNumRate", BuffLogicBase)
BuffLogicRemoveSkillFinalBySrcNumRate = BuffLogicRemoveSkillFinalBySrcNumRate

function BuffLogicRemoveSkillFinalBySrcNumRate:Constructor(buffInstance, logicParam)
  self._entity = buffInstance._entity
  self._effectList = logicParam.effectList
end

function BuffLogicRemoveSkillFinalBySrcNumRate:DoLogic()
  for _, paramType in ipairs(self._effectList) do
    self._buffLogicService:RemoveSkillFinalParam(self._entity, self:GetBuffSeq(), paramType)
  end
end
