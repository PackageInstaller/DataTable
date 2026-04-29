require("auto_fight_service")

function AutoFightService:_CheckCondition_PetJiero()
  local keyValue = 9999
  local battleStatCmpt = self._world:BattleStat()
  local curRound = battleStatCmpt:GetLevelTotalRoundCount()
  local isFirstRound = battleStatCmpt:IsFirstRound()
  local lsvcFeature = self._world:GetService("FeatureLogic")
  if lsvcFeature and lsvcFeature:CanAddCard() then
    if isFirstRound then
      local checkCount = 3
      local firstRoundEnough = false
      local teamEntity = self._world:Player():GetCurrentTeamEntity()
      if teamEntity then
        local teamEntityID = teamEntity:GetID()
        firstRoundEnough = lsvcFeature:GetAutoFightFirstRoundDrawCardEnough(teamEntityID)
      end
      local bEnough = lsvcFeature:HasEnoughSameCard(checkCount)
      if firstRoundEnough or bEnough then
        keyValue = 9999
        local teamEntity = self._world:Player():GetCurrentTeamEntity()
        if teamEntity then
          local teamEntityID = teamEntity:GetID()
          lsvcFeature:SetAutoFightFirstRoundDrawCardEnough(teamEntityID, true)
        end
      else
        keyValue = -1
      end
    else
      local teamEntity = self._world:Player():GetCurrentTeamEntity()
      if teamEntity then
        local teamEntityID = teamEntity:GetID()
        local curRoundTimes = lsvcFeature:GetDrawCardTimes(teamEntityID, curRound)
        if curRoundTimes then
          keyValue = curRoundTimes
        end
      end
    end
  end
  return keyValue
end

function AutoFightService:_CheckCondition_PetLingEn(caster, skillID)
  local keyValue = 9999
  local isMulti, index = self:_CheckIsMultiActiveSkill(caster, skillID)
  if isMulti == false then
    return 0
  end
  local otherSkillIndex = 0
  if index == 1 then
    otherSkillIndex = 2
  elseif index == 2 then
    otherSkillIndex = 1
  else
    return keyValue
  end
  local skillInfoCmpt = caster:SkillInfo()
  local otherSkillID = skillInfoCmpt:GetSkillIDByIndex(otherSkillIndex)
  local ready = self._utilSvc:GetPetSkillReadyAttr(caster, otherSkillID)
  if ready ~= 1 then
    return 0
  end
  local curLayerCount = 0
  local cfgLayerCount = 0
  local skillConfigData = self._configService:GetSkillConfigData(skillID)
  local policyParam = skillConfigData:GetAutoFightPickPosPolicyParam()
  if policyParam then
    local layerType = policyParam.layerType
    local svc = self._world:GetService("BuffLogic")
    curLayerCount = svc:GetBuffLayer(caster, layerType)
    cfgLayerCount = policyParam.layerCountSkill
  end
  if index == 1 and curLayerCount >= cfgLayerCount then
    keyValue = 0
  elseif index == 2 and curLayerCount < cfgLayerCount then
    keyValue = 0
  end
  return keyValue
end

function AutoFightService:_CheckCondition_LegendEnergy(caster)
  local keyValue = 0
  local attributesCmpt = caster:Attributes()
  if attributesCmpt then
    keyValue = attributesCmpt:GetAttribute("LegendPower")
  end
  return keyValue
end
