require("base_ins_r")
_class("JumpInstruction", BaseInstruction)
JumpInstruction = JumpInstruction

function JumpInstruction:Constructor(paramList)
  self._condition = paramList.condition
  self._gotoLabel = paramList["goto"]
  local strResult = paramList.result
  if strResult then
    self._result = tonumber(strResult) == 1
  else
    self._result = true
  end
  self._conditionParam = paramList.param
end

function JumpInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  local playSkillService = world:GetService("PlaySkill")
  local conditionHelper = playSkillService:GetSkillViewConditionHelper()
  local checkResult = conditionHelper:CheckCondition(self._condition, casterEntity, phaseContext, self._conditionParam)
  if checkResult == self._result then
    return self._gotoLabel
  end
  return nil
end
