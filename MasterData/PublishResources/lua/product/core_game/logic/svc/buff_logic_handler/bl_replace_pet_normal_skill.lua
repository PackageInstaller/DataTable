_class("BuffLogicReplacePetNormalSkill", BuffLogicBase)
BuffLogicReplacePetNormalSkill = BuffLogicReplacePetNormalSkill

function BuffLogicReplacePetNormalSkill:Constructor(buffInstance, logicParam)
  self._skillList = logicParam.skillList
  self._layerType = logicParam.layerType or self._buffInstance:GetBuffEffectType()
end

function BuffLogicReplacePetNormalSkill:DoLogic()
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
  local skillInfoComponent = self._entity:SkillInfo()
  skillInfoComponent:SetNormalSkillID(skillID)
end
