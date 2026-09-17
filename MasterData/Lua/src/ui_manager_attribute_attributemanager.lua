local this = class("attributeManager", G_EventManagerBase)
local _battleInfoTpl = L_GameTpl:getBattleInfoTpl()
local _petInheritanceTpl = L_GameTpl:getPetAttributeinheritanceTpl()
local _heroInterimTpl = L_GameTpl:getHeroInterimTpl()
local attModule = {
  heroConfig = 1,
  weapon = 2,
  accessory = 3,
  starGifts = 4,
  favorability = 5,
  star = 6,
  worldBuff = 7
}

function this:getMergeHeroAtt(heroId, attModuleList)
  local heroData = L_HeroStore:getHero(heroId)
  return self:getMergeHeroAttByHero(heroData, attModuleList)
end

function this:getMergeHeroAttByHero(hero, attModuleList, debug)
  attModuleList = attModuleList or {}
  if table.isEmpty(attModuleList) then
    for i, v in pairs(attModule) do
      table.insert(attModuleList, v)
    end
  end
  local res = {}
  local descRes = {}
  for i, module in pairs(attModuleList) do
    local data = {}
    if module == attModule.heroConfig then
      data = self:parseHeroConfigAttByHero(hero)
    elseif module == attModule.weapon then
      data = self:parseWeaponAttByHero(hero)
    elseif module == attModule.accessory then
      data = self:parseAccessoryAttByHero(hero)
    elseif module == attModule.starGifts then
      data = self:parseHeroStarGiftsAttByHero(hero)
    elseif module == attModule.favorability then
      data = self:parseFavorabilityAttByHero(hero)
    elseif module == attModule.star then
      data = self:parseStarAttByHero(hero)
    elseif module == attModule.worldBuff then
      data = self:parseWorldBuffAttr(hero)
    end
    self:mergeAttDic(res, data)
    if debug then
      self:mergeDebugAttrDesc(descRes, data, module)
    end
  end
  return res, descRes
end

function this:mergeDebugAttrDesc(dicA, dicB, module)
  if dicB then
    local keyDesc
    if module == attModule.heroConfig then
      keyDesc = "ui_heroRole_01"
    elseif module == attModule.weapon then
      keyDesc = "ui_heroRole_02"
    elseif module == attModule.accessory then
      keyDesc = "ui_heroRole_03"
    elseif module == attModule.starGifts then
      keyDesc = "ui_heroRole_04"
    elseif module == attModule.favorability then
      keyDesc = "ui_heroRole_05"
    elseif module == attModule.star then
      keyDesc = ""
    end
    for k, v in pairs(dicB) do
      dicA[k] = (dicA[k] or "") .. " " .. L_WordsTpl:getValue(keyDesc) .. v
    end
  end
  return dicA
end

function this:getHeroAttValue(attDic, attId, debugDesc, heroGuid)
  local battleInfoId, value
  local debugStr = ""
  if _battleInfoTpl:getHasGroup(attId) then
    local tpl_tmp = _battleInfoTpl:getTplById(attId)
    local groupId = _battleInfoTpl:getGroupId(tpl_tmp)
    local group = _battleInfoTpl:getGroupById(attId)
    local basicId = _battleInfoTpl:getAttrVal(group[1])
    local perId = _battleInfoTpl:getAttrVal(group[2])
    local extraId = _battleInfoTpl:getAttrVal(group[3])
    attDic[basicId] = attDic[basicId] or 0
    attDic[perId] = attDic[perId] or 0
    attDic[extraId] = attDic[extraId] or 0
    battleInfoId = groupId
    value = attId == 5 and math.floor(attDic[basicId] + attDic[basicId] * attDic[perId] / 10000 + attDic[extraId]) or math.round(attDic[basicId] + attDic[basicId] * attDic[perId] / 10000 + attDic[extraId])
    if debugDesc then
      debugStr = debugStr .. L_WordsTpl:getValue("ui_heroRole_07") .. debugDesc[basicId]
      if not math.isEmpty(attDic[perId]) then
        debugStr = debugStr .. L_WordsTpl:getValue("ui_heroRole_08") .. debugDesc[perId]
      end
      if not math.isEmpty(attDic[extraId]) then
        debugStr = debugStr .. L_WordsTpl:getValue("ui_heroRole_09") .. debugDesc[extraId]
      end
    end
  else
    battleInfoId = attId
    value = math.floor(attDic[attId])
    debugStr = debugDesc and debugDesc[attId]
  end
  if heroGuid ~= nil then
    local battleValue = self:getAttributeValueInFormation(heroGuid, attId)
    if battleValue ~= nil then
      value = battleValue
    end
  end
  return battleInfoId, value, debugStr
end

function this:getAttributeValueInFormation(heroGuid, attrId)
  local hero = L_PlayerManager:getAllHeroCsEntity()[heroGuid]
  if hero then
    local aliveProperty = hero.data.aliveProperty
    local current = C_MyFloatUtility.GetFloat(aliveProperty:GetBattlePropertyCurrentValue(attrId))
    return attrId == 5 and math.floor(current) or math.round(current)
  end
  return nil
end

function this:getHeroAttSplitValue(attDic, attId, heroGuid, bUseTotalBaseValue, ignoreGroup)
  local battleInfoId, baseValue
  local addValue = 0
  local deal = false
  if _battleInfoTpl:getHasGroup(attId) then
    local tpl_tmp = _battleInfoTpl:getTplById(attId)
    local groupId = _battleInfoTpl:getGroupId(tpl_tmp)
    local group = _battleInfoTpl:getGroupById(attId)
    local basicId = _battleInfoTpl:getAttrVal(group[1])
    local perId = _battleInfoTpl:getAttrVal(group[2])
    local extraId = _battleInfoTpl:getAttrVal(group[3])
    attDic[basicId] = attDic[basicId] or 0
    attDic[perId] = attDic[perId] or 0
    attDic[extraId] = attDic[extraId] or 0
    battleInfoId = groupId
    baseValue = attDic[basicId]
    if bUseTotalBaseValue and heroGuid then
      local totalAttDic = L_HeroStore:getHeroPropertyMap(heroGuid)
      local baseValue = totalAttDic[basicId]
      if table.containsValue(L_Const.SpecialAttList, basicId) then
        baseValue = baseValue / 10000
      end
      addValue = math.floor(baseValue * attDic[perId] / 10000 + attDic[extraId])
    else
      addValue = math.floor(attDic[basicId] * attDic[perId] / 10000 + attDic[extraId])
    end
    deal = true
  else
    battleInfoId = attId
    baseValue = math.floor(attDic[attId] or 0)
  end
  if ignoreGroup and not deal and table.containsValue(L_Const.SpecialAttList, attId) then
    baseValue = math.floor(baseValue / 10000)
  end
  if not heroGuid and not bUseTotalBaseValue then
    local battleValue = self:getAttributeValueInFormation(heroGuid, attId)
    if battleValue ~= nil then
      local diff = battleValue - (baseValue + addValue)
      addValue = addValue + diff
    end
  end
  return battleInfoId, baseValue, addValue
end

function this:getAttValueByHeroGuid(heroGuid, attId)
  local mergeAttDic = self:getMergeHeroAtt(heroGuid)
  local id, value = self:getHeroAttValue(mergeAttDic, attId)
  return value
end

function this:getBaseValueDic(heroData)
  local mergeAttDic = self:getMergeHeroAttByHero(heroData, {
    attModule.heroConfig,
    attModule.weapon,
    attModule.starGifts
  })
  for k, v in pairs(mergeAttDic) do
    if _battleInfoTpl:getHasGroup(k) then
      local group = _battleInfoTpl:getGroupById(k)
      local perId = _battleInfoTpl:getAttrVal(group[2])
      local extraId = _battleInfoTpl:getAttrVal(group[3])
      mergeAttDic[perId] = 0
      mergeAttDic[extraId] = 0
    else
      mergeAttDic[k] = 0
    end
  end
  return mergeAttDic
end

function this:getAccessoryAttByHero(hero)
  local sourceData = self:parseAccessoryAttByHero(hero)
  local baseData = self:getBaseValueDic(hero)
  self:mergeAttDic(sourceData, baseData)
  for k, v in pairs(sourceData) do
    if _battleInfoTpl:getHasGroup(k) then
      local group = _battleInfoTpl:getGroupById(k)
      local basicId = _battleInfoTpl:getAttrVal(group[1])
      local perId = _battleInfoTpl:getAttrVal(group[2])
      local extraId = _battleInfoTpl:getAttrVal(group[3])
      if k == basicId then
        sourceData[k] = math.floor(sourceData[basicId] * sourceData[perId] / 10000 + sourceData[extraId])
      end
    end
  end
  for k, v in pairs(sourceData) do
    if _battleInfoTpl:getHasGroup(k) then
      local group = _battleInfoTpl:getGroupById(k)
      local perId = _battleInfoTpl:getAttrVal(group[2])
      local extraId = _battleInfoTpl:getAttrVal(group[3])
      if k == perId or k == extraId then
        sourceData[k] = 0
      end
    end
  end
  return sourceData
end

function this:parseHeroConfigAtt(heroId, heroLevel)
  local heroData = L_HeroStore:getHero(heroId)
  return self:parseHeroConfigAttByHero(heroData, heroLevel)
end

function this:parseHeroConfigAttByHero(heroData, heroLevel)
  heroLevel = heroLevel or L_HeroStore:getHeroLevel(heroData)
  local att = L_HeroManager:getHeroConfigProperty(heroData, heroLevel)
  return att
end

function this:parseWeaponAtt(heroId)
  local heroData = L_HeroStore:getHero(heroId)
  return self:parseWeaponAttByHero(heroData)
end

function this:parseWorldBuffAttr(heroData)
  local heroId = heroData.guid
  local curForType = L_FormationManager:getCurFormationType()
  local formation = L_FormationStore:getFormationTeam(curForType)
  local posData = L_FormationStore:getFormationPosData(curForType, formation.curFormationIndex)
  for _, guid in ipairs(posData) do
    if guid == heroId then
      local buffData = L_HomeBuffManager:getBuff(L_HomeConst.buffId.FORMATION_HERO_ATTRIBUTE)
      local res = {}
      for _, data in ipairs(buffData.buffParams) do
        res[data[1]] = res[data[1]] or 0
        res[data[1]] = res[data[1]] + data[2]
      end
      return res
    end
  end
  return {}
end

function this:parseWeaponAttByHero(heroData)
  if L_HeroStore:getIsTrail(heroData) then
    local trialId = C_DataUtil.GetUuid2ConfigId(L_HeroStore:getHeroGuid(heroData))
    local tpl_trial = _heroInterimTpl:getTplById(trialId)
    if not tpl_trial then
      errorf("没有该试用英雄的配置" .. trialId)
      return {}
    end
    if _heroInterimTpl:getSoulEssence(tpl_trial) == nil or #_heroInterimTpl:getSoulEssence(tpl_trial) == 0 then
      return {}
    end
    local att = C_SoulEssenceMgr:getConfigAttList(_heroInterimTpl:getSoulEssence(tpl_trial)[1], 1, 1)
    return att
  else
    local weaponGuid = L_HeroStore:getHeroSoulEssenceGuid(heroData)
    if weaponGuid ~= 0 then
      local att = C_SoulEssenceMgr:getAttListByGuid(weaponGuid)
      return att
    end
  end
  return {}
end

function this:parseFavorabilityAttByHero(heroData)
  if not heroData then
    return {}
  end
  return L_FavorabilityManager:getFavorabilityAttrs(heroData)
end

function this:parseStarAttByHero(heroData)
  if not heroData then
    return {}
  end
  return {}
end

function this:parseAccessoryAtt(heroId)
  local heroData = L_HeroStore:getHero(heroId)
  return self:parseAccessoryAttByHero(heroData)
end

function this:parseAccessoryAttByHero(heroData)
  if L_HeroStore:getIsTrail(heroData) then
    local trialId = C_DataUtil.GetUuid2ConfigId(L_HeroStore:getHeroGuid(heroData))
    local tpl_trial = _heroInterimTpl:getTplById(trialId)
    if not tpl_trial then
      errorf("没有该试用英雄的配置" .. trialId)
    end
    local trialAccessoryList = _heroInterimTpl:getAccessorySet(tpl_trial)
    return C_AccessoryMgr:getAccessoryListAttDic_trial(trialAccessoryList)
  else
    local accessoryList = L_HeroStore:getHeroAccessoryGuidList(heroData)
    return C_AccessoryMgr:getAccessoryListAttDic(accessoryList)
  end
end

function this:parseHeroStarGiftsAtt(heroId)
  local heroData = self:getHero(heroId)
  return self:parseHeroStarGiftsAtt(heroData)
end

function this:parseHeroStarGiftsAttByHero(heroData)
  local heroConfigId = L_HeroStore:getHeroConfigId(heroData)
  local heroRank = L_HeroStore:getHeroRank(heroData)
  local runes = L_HeroStore:getHeroRuneIds(heroData)
  local starGifts, special = L_HeroManager:getHeroStarGiftByHeroIdAndRank(heroConfigId, heroRank, runes)
  local att = self:mergeAttDic(starGifts, special)
  return att
end

local battleAttScore = {
  [L_Const.battleAtt.ATK] = 1.053,
  [L_Const.battleAtt.DEF] = 0.87,
  [L_Const.battleAtt.MDEF] = 0.87,
  [L_Const.battleAtt.MAXHP] = 0.067,
  [L_Const.battleAtt.SHOOT_HEALUP] = 444.444,
  [L_Const.battleAtt.NORMAL_SHOOTDMGUP] = 344.828,
  [L_Const.battleAtt.FIRE_SHOOTDMGUP] = 344.828,
  [L_Const.battleAtt.WIND_SHOOTDMGUP] = 344.828,
  [L_Const.battleAtt.EARTH_SHOOTDMGUP] = 344.828,
  [L_Const.battleAtt.WOOD_SHOOTDMGUP] = 344.828,
  [L_Const.battleAtt.ICE_SHOOTDMGUP] = 344.828,
  [L_Const.battleAtt.WATER_SHOOTDMGUP] = 344.828,
  [L_Const.battleAtt.ELEC_SHOOTDMGUP] = 344.828,
  [L_Const.battleAtt.LIGHT_SHOOTDMGUP] = 344.828,
  [L_Const.battleAtt.DARK_SHOOTDMGUP] = 344.828,
  [L_Const.battleAtt.CRI] = 512.821,
  [L_Const.battleAtt.CRI_DMG] = 256.41
}
local battleAttScoreExtra = {
  [L_Const.battleAtt.CRI] = -500,
  [L_Const.battleAtt.CRI_DMG] = -15000
}

function this:calcAttributeScore(property)
  local score = 0
  for i, v in pairs(property) do
    if battleAttScore[i] then
      local id, value = L_AttributeManager:getHeroAttValue(property, i)
      local tpl = _battleInfoTpl:getTplById(i)
      local isRatio = _battleInfoTpl:getIsRatio(tpl)
      if battleAttScoreExtra[i] then
        value = value + battleAttScoreExtra[i]
      end
      if isRatio == 0 then
        score = score + battleAttScore[i] * value
      else
        score = score + battleAttScore[i] * value / 10000
      end
    end
  end
  return math.floor(score)
end

function this:mergeAttDic(dicA, dicB)
  if dicB then
    for k, v in pairs(dicB) do
      if dicA[k] then
        dicA[k] = dicA[k] + v
      else
        dicA[k] = v
      end
    end
  end
  return dicA
end

function this:analyseResponse10000(data)
  local heros = data and data.bt_info and data.bt_info.entities[1] and data.bt_info.entities[1].heros
  if not heros then
    errorf("战斗没有英雄数据")
    return
  end
  printf("战斗属性分析++++++++")
  local _heroTpl = L_GameTpl:getHeroTpl()
  local _attrTpl = L_GameTpl:getBattleInfoTpl()
  local _petInfoTpl = L_GameTpl:getPetTpl()
  local _petLearingEnumTpl = L_GameTpl:getPetLearingEnumTpl()
  local property, propertyDesc, attrList, attrStrList, errorList, sHeroAttrs, sSpAttrs, sJeAttrs
  for _, hero in ipairs(heros) do
    local heroId = hero.hero_conf_id
    local nameStr = L_WordsTpl:getValue("ui_heroRole_10") .. heroId
    nameStr = nameStr .. " " .. _heroTpl:getName(_heroTpl:getTplById(heroId))
    local heroData = L_HeroStore:getHero(hero.hero_guid)
    property, propertyDesc = L_AttributeManager:getMergeHeroAttByHero(heroData, nil, true)
    attrList = {}
    attrStrList = {}
    errorList = {}
    sHeroAttrs = {}
    sSpAttrs = {}
    sJeAttrs = {}
    for _, attr in ipairs(hero.attrs.attrs) do
      sHeroAttrs[attr.attr_id] = attr.attr_val
    end
    for _, attr in ipairs(hero.winfo and hero.winfo.attrs.attrs or {}) do
      sSpAttrs[attr.attr_id] = attr.attr_val
    end
    for _, oinfo in ipairs(hero.oinfo or {}) do
      for _, attr in ipairs(oinfo.attrs and oinfo.attrs.attrs or {}) do
        sJeAttrs[attr.attr_id] = (sJeAttrs[attr.attr_id] or 0) + attr.attr_val
      end
    end
    for _, attr in ipairs(hero.suitSkills and hero.suitSkills.attrs.attrs or {}) do
      sJeAttrs[attr.attr_id] = (sJeAttrs[attr.attr_id] or 0) + attr.attr_val
    end
    for attrId, fValue in pairs(property) do
      local sValue = (sHeroAttrs[attrId] or 0) + (sSpAttrs[attrId] or 0) + (sJeAttrs[attrId] or 0)
      if sValue ~= 0 or fValue ~= 0 then
        local attrName = _attrTpl:getName(_attrTpl:getTplById(attrId))
        local str = attrId .. " " .. attrName .. L_WordsTpl:getValue("ui_heroRole_11") .. sValue .. L_WordsTpl:getValue("ui_heroRole_12") .. fValue
        str = str .. L_WordsTpl:getValue("ui_heroRole_13") .. propertyDesc[attrId]
        str = str .. L_WordsTpl:getValue("ui_heroRole_14") .. (sHeroAttrs[attrId] and " " .. L_WordsTpl:getValue("ui_heroRole_01") .. sHeroAttrs[attrId] or "")
        str = str .. (sSpAttrs[attrId] and " " .. L_WordsTpl:getValue("ui_heroRole_02") .. sSpAttrs[attrId] or "")
        str = str .. (sJeAttrs[attrId] and " " .. L_WordsTpl:getValue("ui_heroRole_03") .. sJeAttrs[attrId] or "")
        table.insert(attrList, {id = attrId, str = str})
        if sValue ~= fValue then
          table.insert(errorList, str)
        end
      end
    end
    table.sort(attrList, function(a, b)
      return a.id < b.id
    end)
    for i, data in ipairs(attrList) do
      attrStrList[i] = data.str
    end
    printf(nameStr, table.concat(attrStrList, [[


]]))
    for _, str in ipairs(errorList) do
      errorf(str)
    end
    local pet = hero.pinfo
    if pet then
      local petId = pet.config_id
      local petData = L_PetStore:getPetItem(heroData.pet_id)
      if petData.id ~= petId then
        errorf("英雄数据宠物id不对 前端" .. petData.id .. " 后端" .. petId)
      end
      nameStr = L_WordsTpl:getValue("ui_heroRole_18") .. petId
      local tpl = _petInfoTpl:getTplById(petId)
      if tpl then
        nameStr = nameStr .. " " .. _petInfoTpl:getName(tpl, petData:isSpecialPet())
      end
      local petPro, petProDesc = L_PetStore:getPetProperty(petData, nil, nil, true)
      property = {}
      propertyDesc = {}
      for i = 1, #_petLearingEnumTpl:getAllEnum() do
        local proId = _petLearingEnumTpl:getEnumNum(_petLearingEnumTpl:getTplById(i))
        property[proId] = L_PetStore:getPetAttFinalValue(petPro, proId)
        propertyDesc[proId] = petProDesc[i]
      end
      attrList = {}
      errorList = {}
      for _, attr in ipairs(pet.attrs.attrs) do
        local tpl = _petInheritanceTpl:getTplByAttrId(attr.attr_id)
        local bValue = attr.attr_val
        if tpl then
          local petAttrVal = _petInheritanceTpl:getPetAttrVal(tpl)
          if petAttrVal ~= attr.attr_id then
            for _, inheritance in ipairs(pet.attrs.attrs) do
              if inheritance.attr_id == petAttrVal then
                bValue = attr.attr_val + inheritance.attr_val
                break
              end
            end
          end
        end
        local fValue = property[attr.attr_id]
        if bValue ~= 0 or fValue ~= 0 then
          local attrName = _attrTpl:getName(_attrTpl:getTplById(attr.attr_id))
          local str = attr.attr_id .. " " .. attrName .. L_WordsTpl:getValue("ui_heroRole_11") .. bValue .. L_WordsTpl:getValue("ui_heroRole_12") .. (fValue and fValue or L_WordsTpl:getValue("ui_heroRole_21"))
          if fValue then
            str = str .. L_WordsTpl:getValue("ui_heroRole_22") .. (propertyDesc[attr.attr_id] or "")
          end
          table.insert(attrList, {
            id = attr.attr_id,
            str = str
          })
          if fValue and bValue and math.floor(bValue) ~= math.floor(fValue) then
            table.insert(errorList, str)
          end
        end
      end
      table.sort(attrList, function(a, b)
        return a.id < b.id
      end)
      attrStrList = {}
      for i, data in ipairs(attrList) do
        attrStrList[i] = data.str
      end
      printf(nameStr, table.concat(attrStrList, [[


]]))
      for _, str in ipairs(errorList) do
        errorf(str)
      end
    end
  end
end

function this:getPropertiesForDisplay(roleType, attDic, guid)
  local groups = {}
  for _, tpl in pairs(_battleInfoTpl.data) do
    local showType
    if roleType == L_Const.roleType.pet then
      showType = _battleInfoTpl:getPetShowType(tpl)
    else
      showType = _battleInfoTpl:getShowType(tpl)
    end
    if not math.isEmpty(showType) then
      if not groups[showType] then
        groups[showType] = {}
      end
      local order = _battleInfoTpl:getAttrVal(tpl)
      local sort
      if roleType == L_Const.roleType.pet then
        sort = _battleInfoTpl:getPetSort(tpl)
      else
        sort = _battleInfoTpl:getSort(tpl)
      end
      if not math.isEmpty(sort) then
        order = order + sort * 100000000
      end
      table.insert(groups[showType], {
        id = _battleInfoTpl:getAttrVal(tpl),
        guid = guid,
        order = order,
        roleType = roleType,
        attDic = attDic
      })
    end
  end
  local res = {}
  for k, v in pairs(groups) do
    table.insert(res, {
      groupId = k,
      properties = v,
      groupType = L_Const.propetyShowType.attribute
    })
  end
  table.sort(res, function(a, b)
    return a.groupId < b.groupId
  end)
  for _, v in ipairs(res) do
    table.sort(v.properties, function(a, b)
      return a.order < b.order
    end)
  end
  return res
end

function this:isSkillLocked(hero, skillId)
  local skillLevelTpl = L_GameTpl:getSkillLevelTpl()
  local serverData, i = table.ipairsFind(L_HeroManager:getHeroSystemSkillList(hero), function(v)
    return v.skillId == skillId
  end)
  if serverData.skillLevel == 1 then
    local tpl_skillLevel = skillLevelTpl:getTplByIdAndLevel(skillId, serverData.skillLevel)
    local targetLevel = skillLevelTpl:getHeroLevel(tpl_skillLevel)
    local targetRank = skillLevelTpl:getHeroRank(tpl_skillLevel)
    local isLockByLevel = targetLevel > L_HeroStore:getHeroLevel(hero)
    local isLockByRank = targetRank > L_HeroStore:getHeroRank(hero)
    if isLockByLevel or isLockByRank then
      return true
    end
  end
  return false
end

return this
