require("buff_logic_base")
_class("BuffLogicSetDmgParamSingleTypeSkillByOccupied", BuffLogicBase)
BuffLogicSetDmgParamSingleTypeSkillByOccupied = BuffLogicSetDmgParamSingleTypeSkillByOccupied

function BuffLogicSetDmgParamSingleTypeSkillByOccupied:Constructor(buffInstance, logicParam)
  self._gridNumToParamDic = logicParam.gridNumToParamDic
  self._defaultParam = logicParam.defaultParam
end

function BuffLogicSetDmgParamSingleTypeSkillByOccupied:DoLogic()
  local dmgParam = self._defaultParam
  if self._gridNumToParamDic then
    local holdEntity = self:GetEntity()
    local gridNum = holdEntity:BodyArea():GetAreaCount()
    if self._gridNumToParamDic[gridNum] then
      dmgParam = self._gridNumToParamDic[gridNum]
    end
  end
  if dmgParam then
    self._buffLogicService:ChangeDmgParamSingleTypeSkill(self:GetEntity(), self:GetBuffSeq(), dmgParam)
  end
end

function BuffLogicSetDmgParamSingleTypeSkillByOccupied:DoOverlap(logicParam)
  return self:DoLogic()
end

_class("BuffLogicResetDmgParamSingleTypeSkill", BuffLogicBase)
BuffLogicResetDmgParamSingleTypeSkill = BuffLogicResetDmgParamSingleTypeSkill

function BuffLogicResetDmgParamSingleTypeSkill:Constructor(buffInstance, logicParam)
end

function BuffLogicResetDmgParamSingleTypeSkill:DoLogic()
  self._buffLogicService:RemoveDmgParamSingleTypeSkill(self:GetEntity(), self:GetBuffSeq())
end
