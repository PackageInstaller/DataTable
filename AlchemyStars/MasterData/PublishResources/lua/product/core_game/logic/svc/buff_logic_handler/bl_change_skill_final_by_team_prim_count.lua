_class("BuffLogicChangeSkillFinalByTeamPrimaryTypeCount", BuffLogicBase)
BuffLogicChangeSkillFinalByTeamPrimaryTypeCount = BuffLogicChangeSkillFinalByTeamPrimaryTypeCount

function BuffLogicChangeSkillFinalByTeamPrimaryTypeCount:Constructor(buffInstance, logicParam)
  self._rates = logicParam.rates
  self._effectList = logicParam.effectList
  self._buffInstance.BuffLogicChangeSkillFinalByTargetEdgeDistance_RunCount = 0
end

function BuffLogicChangeSkillFinalByTeamPrimaryTypeCount:DoLogic()
  self._buffInstance._effectList = self._effectList
  local utilCalcSvc = self._world:GetService("UtilCalc")
  local primaryCount = utilCalcSvc:GetTeamPrimaryTypeCount(self._entity)
  local val = self._rates * primaryCount
  for _, paramType in ipairs(self._effectList) do
    self._buffLogicService:ChangeSkillFinalParam(self._entity, self:GetBuffSeq(), paramType, val)
  end
end

_class("BuffLogicUnDoChangeSkillFinalByTeamPrimaryTypeCount", BuffLogicBase)
BuffLogicUnDoChangeSkillFinalByTeamPrimaryTypeCount = BuffLogicUnDoChangeSkillFinalByTeamPrimaryTypeCount

function BuffLogicUnDoChangeSkillFinalByTeamPrimaryTypeCount:DoLogic()
  for _, paramType in pairs(self._buffInstance._effectList) do
    self._buffLogicService:RemoveSkillFinalParam(self._entity, self:GetBuffSeq(), paramType)
  end
end
