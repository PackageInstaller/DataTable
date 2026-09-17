local this = class("heroTpl")

function this:init(config)
  self.data = config
  local countCollect = 0
  for k, v in pairs(self.data) do
    if v.isCollect == 1 then
      countCollect = countCollect + 1
    end
  end
  self.totalCollect = countCollect
end

function this:getTplById(id)
  if self.data[id] == nil then
    if id == nil then
      errorf("heroTpl  is Null 配置不符合传值为空")
    else
      errorf("heroTpl  is Null 配置不符合 id" .. id)
    end
  end
  return self.data[id]
end

function this:getBackupSkillList(tpl)
  return tpl.backupSkillList
end

function this:getBaseAttributeId(tpl)
  return tpl.baseAttributeId
end

function this:getNations(tpl)
  return tpl.groups
end

function this:getFormationGap(tpl)
  return tpl.formationGap
end

function this:getFormationId(tpl)
  return tpl.formationId
end

function this:getCounterAttackRange(tpl)
  return tpl.counterAttackRange
end

function this:getPassiveSkillList(tpl)
  return tpl.passiveSkillList
end

function this:getId(tpl)
  return tpl.id
end

function this:getBattleWidth(tpl)
  return tpl.battleWidth
end

function this:getIsStopPlayer(tpl)
  return tpl.isStopPlayer
end

function this:getAttackRange(tpl)
  return tpl.attackRange
end

function this:getWeaponType(tpl)
  return tpl.weaponType
end

function this:getFormationWidth(tpl)
  return tpl.formationWidth
end

function this:getRarity(tpl)
  return tpl.rarity
end

function this:getStrategyPreference(tpl)
  return tpl.strategyPreference
end

function this:getAttackSkill(tpl)
  return tpl.attackSkill
end

function this:getBehavior(tpl)
  return tpl.behavior
end

function this:getSkillSystem(tpl)
  return tpl.skillSystem
end

function this:getIsCollect(tpl)
  return tpl.isCollect
end

function this:getTotalCollect()
  return self.totalCollect
end

function this:getSkillIndex(tpl, skillId)
  local skill = self:getSkillSystem(tpl)
  for i, v in ipairs(skill) do
    if skillId == v then
      return i - 1
    end
  end
end

function this:getPosition(tpl)
  return tpl.position
end

function this:getElement(tpl)
  return tpl.element
end

function this:getSubElement(tpl)
  return tpl.subElement
end

function this:getBehaviorFormation(tpl)
  return tpl.behaviorFormation
end

function this:getDec(tpl)
  return L_Config:provider(tpl.dec)
end

function this:getSkillList(tpl)
  return tpl.skillList
end

function this:getSkillBytesPath(tpl)
  return tpl.skillBytesPath
end

function this:getChaos(tpl)
  return tpl.chaos
end

function this:getName(tpl)
  return L_Config:provider(tpl.name)
end

function this:getFavor(tpl)
  return tpl.favor
end

function this:getMorale(tpl)
  return tpl.morale
end

function this:getWeaponDefault(tpl)
  return tpl.weaponDefault
end

function this:getLevelUpType(tpl)
  return tpl.levelUpType
end

function this:getFormationTraceRange(tpl)
  return tpl.formationTraceRange
end

function this:getCost(tpl)
  return tpl.cost
end

function this:getPropertyId(tpl)
  return tpl.propertyId
end

function this:getLifeskillDesc(tpl)
  return L_Config:provider(tpl.lifeskillDesc)
end

function this:getModelPath(tpl, index)
  local unitTpl = L_GameTpl:getUnitTpl()
  tpl = unitTpl:getTplById(tpl.unitId)
  return unitTpl:getModel(tpl, index)
end

function this:getUnitModelPath(tpl)
  return self:getModelPath(tpl, L_Const.avatarModelIndex.UnitModel)
end

function this:getAnimatorConfigPath(tpl, index)
  local unitTpl = L_GameTpl:getUnitTpl()
  tpl = unitTpl:getTplById(tpl.unitId)
  return unitTpl:getAnimatorConfig(tpl)
end

function this:getHeroConfigAtt(heroId, heroLevel, heroRank)
  local unitPropertyTpl = L_GameTpl:getUnitPropertyTpl()
  local templateHeroTpl = L_GameTpl:getTemplateHeroTpl()
  local templateValueTpl = L_GameTpl:getTemplateValueTpl()
  local propertyId = self:getPropertyId(self:getTplById(heroId))
  local propertyTpl = unitPropertyTpl:getTplById(propertyId)
  if not propertyTpl then
    C_MJLog.LogError("propertyTpl is nil id =" .. tostring(propertyId))
    return {}
  end
  local heroAttId = unitPropertyTpl:getBaseAttributeId(propertyTpl)
  local heroBaseAttId = templateHeroTpl:getBaseAttributeByRankAndLevel(heroRank, heroLevel)
  local baseTemplateTpl = templateValueTpl:getTplById(heroBaseAttId)
  if not baseTemplateTpl then
    C_MJLog.LogError("baseTemplateTpl is nil id =" .. tostring(heroBaseAttId))
  end
  local baseValue = templateValueTpl:getBaseAttribute(baseTemplateTpl)
  local factorTemplateTpl = templateValueTpl:getTplById(heroAttId)
  if not factorTemplateTpl then
    C_MJLog.LogError("factorTemplateTpl is nil id =" .. tostring(heroAttId))
  end
  local factorValue = templateValueTpl:getBaseAttribute(factorTemplateTpl)
  local newValue = {}
  for i, v in pairs(baseValue) do
    if factorValue[i] then
      local val = v * factorValue[i]
      if table.containsValue(L_Const.SpecialAttList, i) then
        newValue[i] = i == 5 and math.floor(val / 10000) or math.round(val / 10000)
      else
        newValue[i] = math.round(val)
      end
    end
  end
  return newValue
end

function this:getVoice(tpl)
  return tpl.voice
end

function this:getIsUsable(tpl)
  return tpl.isUsable == 1
end

function this:getMainElementld(tpl)
  return tpl.mainElementld
end

function this:getAerialSkillList(tpl)
  return tpl.aerialSkillList
end

function this:getFavor(tpl)
  return tpl.favor
end

function this:getEnglishName(tpl)
  return tpl.englishName
end

function this:getKiBoDuelHeroPrepareTransXZOffset(tpl)
  if not tpl.kiboDuelInfo or not tpl.kiboDuelInfo[1] then
    return C_Vector3(0, 0, 0)
  end
  return C_Vector3(tpl.kiboDuelInfo[1][1] or 0, 0, tpl.kiboDuelInfo[1][3] or 0)
end

function this:getKiBoDuelHeroPrepareTransYOffset(tpl)
  if not tpl.kiboDuelInfo or not tpl.kiboDuelInfo[1] then
    return C_Vector3(0, 0, 0)
  end
  return C_Vector3(0, tpl.kiboDuelInfo[1][2] or 0, 0)
end

function this:getKiBoDuelHeroPrepareTransOffset(tpl)
  if not tpl.kiboDuelInfo or not tpl.kiboDuelInfo[1] then
    return C_Vector3(0, 0, 0)
  end
  return C_Vector3(tpl.kiboDuelInfo[1][1] or 0, tpl.kiboDuelInfo[1][2] or 0, tpl.kiboDuelInfo[1][3] or 0)
end

function this:getKiBoDuelHeroPrepareTransEuler(tpl)
  if not tpl.kiboDuelInfo or not tpl.kiboDuelInfo[2] then
    return C_Vector3(0, 0, 0)
  end
  return C_Vector3(tpl.kiboDuelInfo[2][1] or 0, tpl.kiboDuelInfo[2][2] or 0, tpl.kiboDuelInfo[2][3] or 0)
end

function this:getKiBoDuelHeroPrepareTransScale(tpl)
  if not tpl.kiboDuelInfo or not tpl.kiboDuelInfo[3] then
    return C_Vector3(0, 0, 0)
  end
  return C_Vector3(tpl.kiboDuelInfo[3][1] or 0, tpl.kiboDuelInfo[3][2] or 0, tpl.kiboDuelInfo[3][3] or 0)
end

function this:getKiBoDuelFormationHeroTransXZOffset(tpl)
  if not tpl.kiboDuelFormation or not tpl.kiboDuelFormation[1] then
    return C_Vector3(0, 0, 0)
  end
  return C_Vector3(tpl.kiboDuelFormation[1][1] or 0, 0, tpl.kiboDuelFormation[1][3] or 0)
end

function this:getKiBoDuelFormationHeroTransYOffset(tpl)
  if not tpl.kiboDuelFormation or not tpl.kiboDuelFormation[1] then
    return C_Vector3(0, 0, 0)
  end
  return C_Vector3(0, tpl.kiboDuelFormation[1][2] or 0, 0)
end

function this:getKiBoDuelFormationHeroTransOffset(tpl)
  if not tpl.kiboDuelFormation or not tpl.kiboDuelFormation[1] then
    return C_Vector3(0, 0, 0)
  end
  return C_Vector3(tpl.kiboDuelFormation[1][1] or 0, tpl.kiboDuelFormation[1][2] or 0, tpl.kiboDuelFormation[1][3] or 0)
end

function this:getKiBoDuelFormationHeroTransEuler(tpl)
  if not tpl.kiboDuelFormation or not tpl.kiboDuelFormation[2] then
    return C_Vector3(0, 0, 0)
  end
  return C_Vector3(tpl.kiboDuelFormation[2][1] or 0, tpl.kiboDuelFormation[2][2] or 0, tpl.kiboDuelFormation[2][3] or 0)
end

function this:getKiBoDuelFormationHeroTransScale(tpl)
  if not tpl.kiboDuelFormation or not tpl.kiboDuelFormation[3] then
    return C_Vector3(0, 0, 0)
  end
  return C_Vector3(tpl.kiboDuelFormation[3][1] or 0, tpl.kiboDuelFormation[3][2] or 0, tpl.kiboDuelFormation[3][3] or 0)
end

function this:getKiBoDuelEnemyHeroTransXZOffset(tpl)
  if not tpl.kiboDuelEnemyInfo or not tpl.kiboDuelEnemyInfo[1] then
    return C_Vector3(0, 0, 0)
  end
  return C_Vector3(tpl.kiboDuelEnemyInfo[1][1] or 0, 0, tpl.kiboDuelEnemyInfo[1][3] or 0)
end

function this:getKiBoDuelEnemyHeroTransYOffset(tpl)
  if not tpl.kiboDuelEnemyInfo or not tpl.kiboDuelEnemyInfo[1] then
    return C_Vector3(0, 0, 0)
  end
  return C_Vector3(0, tpl.kiboDuelEnemyInfo[1][2] or 0, 0)
end

function this:getKiBoDuelEnemyHeroTransEuler(tpl)
  if not tpl.kiboDuelEnemyInfo or not tpl.kiboDuelEnemyInfo[2] then
    return C_Vector3(0, 0, 0)
  end
  return C_Vector3(tpl.kiboDuelEnemyInfo[2][1] or 0, tpl.kiboDuelEnemyInfo[2][2] or 0, tpl.kiboDuelEnemyInfo[2][3] or 0)
end

function this:getKiBoDuelEnemyHeroTransScale(tpl)
  if not tpl.kiboDuelEnemyInfo or not tpl.kiboDuelEnemyInfo[3] then
    return C_Vector3(0, 0, 0)
  end
  return C_Vector3(tpl.kiboDuelEnemyInfo[3][1] or 0, tpl.kiboDuelEnemyInfo[3][2] or 0, tpl.kiboDuelEnemyInfo[3][3] or 0)
end

function this:getPartyMainTransOffset(tpl)
  if not tpl.partyMain or not tpl.partyMain[1] then
    return nil
  end
  return C_Vector3(tpl.partyMain[1][1] or 0, tpl.partyMain[1][2] or 0, tpl.partyMain[1][3] or 0)
end

function this:getPartyMainTransEuler(tpl)
  if not tpl.partyMain or not tpl.partyMain[2] then
    return nil
  end
  return C_Vector3(tpl.partyMain[2][1] or 0, tpl.partyMain[2][2] or 0, tpl.partyMain[2][3] or 0)
end

function this:getPartyMainTransScale(tpl)
  if not tpl.partyMain or not tpl.partyMain[3] then
    return nil
  end
  return C_Vector3(tpl.partyMain[3][1] or 1, tpl.partyMain[3][2] or 1, tpl.partyMain[3][3] or 1)
end

function this:getPartyMainAction(tpl)
  local action = tpl.partyMainAction
  if type(action) == "table" then
    return action[1]
  end
  return action
end

function this:getBattleTag(tpl)
  return tpl.battleTag
end

function this:getFishAction(tpl)
  return tpl.fishAction
end

function this:getFishHero(curMainControlHero)
  local configId = L_HeroStore:getHeroConfigId(L_HeroStore:getHero(curMainControlHero))
  local tpl_hero = self:getTplById(configId)
  if tpl_hero.fishAction == L_FishingConst.HeroFishSize.None then
    tpl_hero = self:getTplById(L_GameUtil.getDefaultHeroId())
  end
  return tpl_hero.id, tpl_hero.fishAction
end

function this:getUIChargingParam(tpl)
  return tpl.uiChargingParam
end

function this:getGradeUpItem(heroId, heroGrade)
  local tpl = self:getTplById(heroId)
  if tpl and tpl.gradeUpItem then
    local index = heroGrade + 1
    if index <= #tpl.gradeUpItem then
      return tpl.gradeUpItem[index]
    else
      C_MJLog.LogWarning("星级超过6，返回第一个cost:" .. heroId)
      return tpl.gradeUpItem[1]
    end
  else
    C_MJLog.LogError("hero表找不到id:" .. heroId)
  end
  return nil
end

function this:getTimeTag(tpl)
  return tpl.timetag
end

function this:getHandbookHeroScale(tpl)
  return tpl.handbookheroScale / 10000
end

function this:getHandbookHeroPositionOffset(tpl)
  local list = tpl.handbookheroPositionOffset[1]
  return L_Vector3.new(list[1], list[2], list[3])
end

function this:getHandbookHeroRotation(tpl)
  local offset = tpl.handbookheroRotation[1]
  return L_Vector3.new(offset[1], offset[2], offset[3])
end

function this:getHeroRecommendPet(tpl)
  if not tpl or not tpl.formationPetsell then
    return
  end
  local petTable = {}
  for _, data in pairs(tpl.formationPetsell) do
    local type = data[1]
    local petId = data[2]
    if not petTable[type] then
      petTable[type] = {}
    end
    table.insert(petTable[type], petId)
  end
  return petTable
end

function this:getHeroGradeTemplate(tpl)
  return tpl.gradeTemplate
end

function this:getKiboId(tpl)
  return tpl.kiboId and tpl.kiboId[1]
end

return this
