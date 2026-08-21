EnumChangeFeatureSkillPower = {
  AllFeatureType = 1,
  SpecificFeatureType = 2,
  RandomPopStarSkillFeature = 3
}
_enum("EnumChangeFeatureSkillPower", EnumChangeFeatureSkillPower)
_class("BuffLogicChangeFeatureSkillPower", BuffLogicBase)
BuffLogicChangeFeatureSkillPower = BuffLogicChangeFeatureSkillPower

function BuffLogicChangeFeatureSkillPower:Constructor(buffInstance, logicParam)
  self._modifyValue = logicParam.modifyValue or 0
  self._modifyType = logicParam.modifyType or EnumChangeFeatureSkillPower.AllFeatureType
  self._featureTypeList = logicParam.featureTypeList
  self._useNotifyValue = logicParam.useNotifyValue or 0
end

function BuffLogicChangeFeatureSkillPower:DoLogic(notify)
  local modifyValue = self._modifyValue
  if self._useNotifyValue == 1 and notify.GetCumulativeTriggerNum then
    modifyValue = notify:GetCumulativeTriggerNum()
  end
  local featureSkillPowerStateList = {}
  local world = self._buffInstance:World()
  local teamEntity = world:Player():GetLocalTeamEntity()
  if self._entity:HasTeam() then
    teamEntity = self._entity
  elseif self._entity:HasPet() then
    teamEntity = self._entity:Pet():GetOwnerTeamEntity()
  end
  local lsvcFeature = self._world:GetService("FeatureLogic")
  if lsvcFeature then
    local featureTypeList = {}
    if self._modifyType == EnumChangeFeatureSkillPower.AllFeatureType then
      featureTypeList = lsvcFeature:GetFeatureTypeList()
    elseif self._modifyType == EnumChangeFeatureSkillPower.SpecificFeatureType then
      featureTypeList = self._featureTypeList
    elseif self._modifyType == EnumChangeFeatureSkillPower.RandomPopStarSkillFeature then
      local allPopStarFeature = {}
      local allFeatureList = lsvcFeature:GetFeatureTypeList()
      for index, featureType in ipairs(allFeatureList) do
        if lsvcFeature:IsPopStarSkillFeature(featureType) then
          table.insert(allPopStarFeature, featureType)
        end
      end
      if 0 < #allPopStarFeature then
        local lsvcRandom = self._world:GetService("RandomLogic")
        local featureIndex = 1
        featureIndex = lsvcRandom:LogicRand(1, #allPopStarFeature)
        table.insert(featureTypeList, allPopStarFeature[featureIndex])
      end
    end
    for _, featureType in ipairs(featureTypeList) do
      local resultFeatureType, curPower, curReady = lsvcFeature:BuffChangeFeatureSkillPower(featureType, modifyValue)
      if resultFeatureType then
        local data = FeatureSkillCommonPowerData:New()
        data.power = curPower
        data.ready = curReady
        data.featureType = resultFeatureType
        table.insert(featureSkillPowerStateList, data)
      end
    end
  end
  if 0 < #featureSkillPowerStateList then
    local buffResult = BuffResultChangeFeatureSkillPower:New(featureSkillPowerStateList)
    return buffResult
  end
end
