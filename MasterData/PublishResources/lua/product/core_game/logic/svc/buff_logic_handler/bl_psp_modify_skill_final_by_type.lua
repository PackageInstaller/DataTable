_class("BuffLogicPSPModifySkillFinalByType", BuffLogicBase)
BuffLogicPSPModifySkillFinalByType = BuffLogicPSPModifySkillFinalByType

function BuffLogicPSPModifySkillFinalByType:Constructor(buffInstance, logicParam)
  self._modifyValue = logicParam.modifyValue or 0
  self._modifyType = logicParam.modifyType or 0
  self._buffInstance._effectList = logicParam.effectList
  self._entity = buffInstance._entity
end

function BuffLogicPSPModifySkillFinalByType:DoLogic()
  local popStarProSvc = self._world:GetService("PopStarProLogic")
  if not popStarProSvc then
    return
  end
  local count = popStarProSvc:GetCountByModifyType(self._modifyType)
  local val = self._modifyValue * count
  local curModifyVal = self._buffLogicService:GetModifyValueByID(self._entity, "CampSkillFinalParam", self:GetBuffSeq())
  val = val + curModifyVal
  for _, paramType in ipairs(self._buffInstance._effectList) do
    self._buffLogicService:ChangeSkillFinalParam(self._entity, self:GetBuffSeq(), paramType, val)
  end
end

_class("BuffLogicUndoPSPModifySkillFinalByType", BuffLogicBase)
BuffLogicUndoPSPModifySkillFinalByType = BuffLogicUndoPSPModifySkillFinalByType

function BuffLogicUndoPSPModifySkillFinalByType:Constructor(buffInstance, logicParam)
  self._entity = buffInstance._entity
end

function BuffLogicUndoPSPModifySkillFinalByType:DoLogic()
  for _, paramType in ipairs(self._buffInstance._effectList) do
    self._buffLogicService:RemoveSkillFinalParam(self._entity, self:GetBuffSeq(), paramType)
  end
end
