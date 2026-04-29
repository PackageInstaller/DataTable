require("buff_logic_base")
local ModifyAllFeatureSkillCdOffType = {Add = 1, Set = 2}
_enum("ModifyAllFeatureSkillCdOffType", ModifyAllFeatureSkillCdOffType)
_class("BuffLogicChangeAllFeatureSkillCdOff", BuffLogicBase)
BuffLogicChangeAllFeatureSkillCdOff = BuffLogicChangeAllFeatureSkillCdOff

function BuffLogicChangeAllFeatureSkillCdOff:Constructor(buffInstance, logicParam)
  self._modifyValue = logicParam.modValue or 1
  self._modifyType = logicParam.modType or ModifyAllFeatureSkillCdOffType.Add
  self._featureList = logicParam.featureList
end

function BuffLogicChangeAllFeatureSkillCdOff:DoLogic(notify)
  local lsvcFeature = self._world:GetService("FeatureLogic")
  if self._featureList then
    for _, featureType in ipairs(self._featureList) do
      local oldCdOff = lsvcFeature:GetSpecificFeatureSkillCdOff(featureType)
      local curCdOff = oldCdOff
      if self._modifyType == ModifyAllFeatureSkillCdOffType.Add then
        curCdOff = oldCdOff + self._modifyValue
      elseif self._modifyType == ModifyAllFeatureSkillCdOffType.Set then
        curCdOff = self._modifyValue
      end
      lsvcFeature:SetSpecificFeatureSkillCdOff(featureType, curCdOff)
    end
  else
    local oldCdOff = lsvcFeature:GetAllFeatureSkillCdOff()
    local curCdOff = oldCdOff
    if self._modifyType == ModifyAllFeatureSkillCdOffType.Add then
      curCdOff = oldCdOff + self._modifyValue
    elseif self._modifyType == ModifyAllFeatureSkillCdOffType.Set then
      curCdOff = self._modifyValue
    end
    lsvcFeature:SetAllFeatureSkillCdOff(curCdOff)
  end
end
