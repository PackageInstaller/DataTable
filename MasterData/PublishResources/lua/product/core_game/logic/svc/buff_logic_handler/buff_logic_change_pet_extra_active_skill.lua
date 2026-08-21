_class("BuffLogicChangePetExtraActiveSkill", BuffLogicBase)
BuffLogicChangePetExtraActiveSkill = BuffLogicChangePetExtraActiveSkill

function BuffLogicChangePetExtraActiveSkill:Constructor(buffInstance, logicParam)
  self._oriSkillID = logicParam.oriSkillID
  self._oriSkillIndex = logicParam.oriSkillIndex
  self._skillList = logicParam.skillList
  self._layerType = logicParam.layerType or self._buffInstance:GetBuffEffectType()
end

function BuffLogicChangePetExtraActiveSkill:DoLogic()
  local skillID
  local curMarkLayer = self._buffLogicService:GetBuffLayer(self._entity, self._layerType) or 1
  if table.count(self._skillList) == 1 then
    skillID = self._skillList[1]
  else
    if curMarkLayer > #self._skillList then
      curMarkLayer = #self._skillList
    end
    skillID = self._skillList[curMarkLayer]
  end
  if not skillID then
    return
  end
  local skillInfoComponent = self._entity:SkillInfo()
  local oriSkillList = skillInfoComponent:GetExtraActiveSkillIDList()
  local checkOriSkillId = self._oriSkillID
  if self._oriSkillIndex then
    checkOriSkillId = oriSkillList[self._oriSkillIndex]
  end
  local newSkillList = {}
  local hasOriSkill = false
  for index, oriSkillID in ipairs(oriSkillList) do
    if oriSkillID == checkOriSkillId then
      hasOriSkill = true
      table.insert(newSkillList, skillID)
    else
      table.insert(newSkillList, oriSkillID)
    end
  end
  if not hasOriSkill then
    return
  end
  skillInfoComponent:SetExtraActiveSkillIDList(newSkillList)
  local buffResult = BuffResultChangePetExtraActiveSkill:New(checkOriSkillId, skillID)
  return buffResult
end
