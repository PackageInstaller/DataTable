_class("BuffLogicChangePetActiveSkill", BuffLogicBase)
BuffLogicChangePetActiveSkill = BuffLogicChangePetActiveSkill

function BuffLogicChangePetActiveSkill:Constructor(buffInstance, logicParam)
  self._skillList = logicParam.skillList
  self._layerType = logicParam.layerType or self._buffInstance:GetBuffEffectType()
  self._replaceOriSkillID = logicParam.replaceOriSkillID
  self._refreshMaxPower = logicParam.refreshMaxPower
end

function BuffLogicChangePetActiveSkill:DoLogic()
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
  local curSkillID = skillInfoComponent:GetActiveSkillID()
  if skillID == curSkillID then
    return
  end
  if self._replaceOriSkillID and curSkillID ~= self._replaceOriSkillID then
    return
  end
  skillInfoComponent:SetActiveSkillID(skillID)
  if self._refreshMaxPower then
    local configService = self._world:GetService("Config")
    local activeSkillConfigData = configService:GetSkillConfigData(skillID)
    if activeSkillConfigData then
      local skillTriggerType = activeSkillConfigData:GetSkillTriggerType()
      if skillTriggerType == SkillTriggerType.Energy then
        local skillTriggerParam = activeSkillConfigData:GetSkillTriggerParam()
        local utilData = self._world:GetService("UtilData")
        utilData:SetPetMaxPowerAttr(self._entity, skillTriggerParam, skillID)
      end
    end
  end
  local buffResult = BuffResultChangePetActiveSkill:New(curMarkLayer, skillID)
  return buffResult
end
