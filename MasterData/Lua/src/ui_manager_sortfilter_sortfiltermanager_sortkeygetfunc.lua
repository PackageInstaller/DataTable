local this = {}
local _systemSorttypeTpl = L_GameTpl:getSystemSorttypeTpl()
local _accessoryTpl = L_GameTpl:getAccessoryTpl()
local _soulessenceTpl = L_GameTpl:getSoulessenceTpl()
local _petTpl = L_GameTpl:getPetTpl()
local _commonItemTpl = L_GameTpl:getCommonItemTpl()
local _foodTpl = L_GameTpl:getFoodTpl()
local _heroTpl = L_GameTpl:getHeroTpl()
local Type2Func_sort = {
  [L_Const.resType.accessory] = "getAccessorySortKey",
  [L_Const.resType.soulEssence] = "getSoulEssenceSortKey",
  [L_Const.resType.pet] = "getPetSortKey",
  [L_Const.resType.commonItem] = "getCommonItemSortKey",
  [L_Const.resType.hero] = "getHeroSortKey",
  [L_Const.resType.heroEncyclopedia] = "getHeroEncyclopediaSortKey"
}

function this:getSortKey(itemType, keyList, itemId, guid)
  if Type2Func_sort[itemType] then
    return self[Type2Func_sort[itemType]](self, keyList, itemId, guid)
  else
    errorf("资源大类型" .. itemType .. "代码未补充，优先找策划确认是否配置正确并找程序接入了")
  end
end

function this:getAccessorySortKey(keyList, itemId, guid)
  local serverData = guid and C_AccessoryMgr:getAccessory(guid) or {}
  local tpl_item = _accessoryTpl:getTplById(itemId)
  local res = {}
  for i, keyTypeId in ipairs(keyList) do
    local tpl_sortKey = _systemSorttypeTpl:getTplById(keyTypeId)
    local sortType, sortPara = table.unpack(_systemSorttypeTpl:getSortPara(tpl_sortKey))
    local value
    if sortType == L_SortFilterConst.SortType.Level then
      value = serverData.level
    elseif sortType == L_SortFilterConst.SortType.Quality then
      value = _accessoryTpl:getRarity(tpl_item)
    elseif sortType == L_SortFilterConst.SortType.EquipSetId then
      value = _accessoryTpl:getSetId(tpl_item)
    elseif sortType == L_SortFilterConst.SortType.ConfigId then
      value = itemId
    elseif sortType == L_SortFilterConst.SortType.ServerId then
      value = guid
    elseif sortType == L_SortFilterConst.SortType.EquipBattleInfo then
      value = guid and C_AccessoryMgr:LuaTryGetServerDataMergeAttrDicValue(guid, sortPara) or 0
      local keyName = string.concat(L_SortFilterConst.SortTypeKeyName[sortType], sortPara)
      res[keyName] = value
    elseif sortType == L_SortFilterConst.SortType.isEquipped then
      value = math.isEmpty(serverData.wearHero) and 1 or 0
    elseif sortType == L_SortFilterConst.SortType.isEquippedBySelf then
      value = serverData.wearHero == C_AccessoryMgr:getCurSelectHeroUid() and 1 or 0
    end
    if value == nil then
      errorf("排序类型" .. sortType .. "在装备代码未补充，优先找策划确认是否配置正确并找程序接入了")
    end
    res[L_SortFilterConst.SortTypeKeyName[sortType]] = value or 0
  end
  return res
end

function this:getSoulEssenceSortKey(keyList, itemId, guid)
  local serverData = guid and C_SoulEssenceMgr:getsoulessenceItem(guid) or {}
  local tpl_item = _soulessenceTpl:getTplById(itemId)
  local res = {}
  for i, keyTypeId in ipairs(keyList) do
    local tpl_sortKey = _systemSorttypeTpl:getTplById(keyTypeId)
    local sortType, sortPara = table.unpack(_systemSorttypeTpl:getSortPara(tpl_sortKey))
    local value
    if sortType == L_SortFilterConst.SortType.Level then
      value = serverData.level
    elseif sortType == L_SortFilterConst.SortType.Quality then
      value = _soulessenceTpl:getRarity(tpl_item)
    elseif sortType == L_SortFilterConst.SortType.ConfigId then
      value = itemId
    elseif sortType == L_SortFilterConst.SortType.ServerId then
      value = guid
    elseif sortType == L_SortFilterConst.SortType.Star then
      value = serverData.star
    elseif sortType == L_SortFilterConst.SortType.Rank then
      value = C_SoulEssenceMgr:getIsInBreakState(guid) and 0 or 1
    elseif sortType == L_SortFilterConst.SortType.isEquipped then
      value = math.isEmpty(serverData.wearHero) and 0 or 1
    elseif sortType == L_SortFilterConst.SortType.IsUnlock then
      value = false
    end
    if value == nil then
      errorf("排序类型" .. sortType .. "在灵子代码未补充，优先找策划确认是否配置正确并找程序接入了")
    end
    res[L_SortFilterConst.SortTypeKeyName[sortType]] = value or 0
  end
  return res
end

function this:getHeroSortKey(keyList, itemId, guid)
  local serverData = guid and L_HeroStore:getHero(guid) or {}
  local tpl_item = _heroTpl:getTplById(itemId)
  local res = {}
  for i, keyTypeId in ipairs(keyList) do
    local tpl_sortKey = _systemSorttypeTpl:getTplById(keyTypeId)
    local sortType, sortPara = table.unpack(_systemSorttypeTpl:getSortPara(tpl_sortKey))
    local value
    if sortType == L_SortFilterConst.SortType.Level then
      value = L_HeroStore:getHeroLevel(serverData)
    elseif sortType == L_SortFilterConst.SortType.Rank then
      value = L_HeroStore:getHeroRank(serverData)
    elseif sortType == L_SortFilterConst.SortType.Quality then
      value = _heroTpl:getRarity(tpl_item)
    elseif sortType == L_SortFilterConst.SortType.ConfigId then
      value = itemId
    elseif sortType == L_SortFilterConst.SortType.ServerId then
      value = guid
    elseif sortType == L_SortFilterConst.SortType.DisplayPos then
      local page = L_UI:getPage("pageDisplayHero")
      value = table.keyOf(page.cls:getSelectHero(), guid) or math.maxinteger
    elseif sortType == L_SortFilterConst.SortType.CurEditPosIndex then
      local curEditPosIndex = L_FormationManager:getFocusIndex()
      local heroPosInFormation = L_FormationStore:getHeroPlaceInTeam(L_FormationManager:getRuntimeFormationType(), L_FormationManager:getRuntimeFormationIndex(), guid)
      value = curEditPosIndex == heroPosInFormation and 1 or 0
    end
    if value == nil then
      errorf("排序类型" .. sortType .. "在英雄代码未补充，优先找策划确认是否配置正确并找程序接入了")
    end
    res[L_SortFilterConst.SortTypeKeyName[sortType]] = value or 0
  end
  return res
end

function this:getPetSortKey(keyList, itemId, guid)
  local serverData = guid and L_PetStore:getPetItem(guid) or {}
  local tpl_item = _petTpl:getTplById(itemId)
  local res = {}
  for i, keyTypeId in ipairs(keyList) do
    local tpl_sortKey = _systemSorttypeTpl:getTplById(keyTypeId)
    local sortType, sortPara = table.unpack(_systemSorttypeTpl:getSortPara(tpl_sortKey))
    local value
    if sortType == L_SortFilterConst.SortType.Level then
      value = serverData.lv
    elseif sortType == L_SortFilterConst.SortType.ConfigId then
      value = itemId
    elseif sortType == L_SortFilterConst.SortType.ServerId then
      value = guid
    elseif sortType == L_SortFilterConst.SortType.Satiety then
      value = serverData.satiety
    elseif sortType == L_SortFilterConst.SortType.MountSpeed then
      value = L_MountManager:getMountSpeed(guid)
    elseif sortType == L_SortFilterConst.SortType.MountMaxSpeed then
      value = L_MountManager:getMountSpeed(guid, 1)
    elseif sortType == L_SortFilterConst.SortType.MountRouletteSlotId then
      value = serverData.roulette_pos
    elseif sortType == L_SortFilterConst.SortType.IsInMountRoulette then
      value = math.isEmpty(serverData.roulette_pos) and 0 or 1
    elseif sortType == L_SortFilterConst.SortType.IsUnlock then
      local isRideUnlock = L_MountManager:getIsMountUnlock(guid)
      value = isRideUnlock and 1 or 0
    elseif sortType == L_SortFilterConst.SortType.QiBoGrade then
      value = L_PetStore:getPetGradeNew(guid)
    elseif sortType == L_SortFilterConst.SortType.CurEditPosIndex then
      local curEditPosIndex = L_FormationManager:getFocusIndex()
      local petPosInFormation = L_FormationStore:getPetPlaceInTeam(L_FormationManager:getRuntimeFormationType(), L_FormationManager:getRuntimeFormationIndex(), guid)
      value = curEditPosIndex == petPosInFormation and 1 or 0
    elseif sortType == L_SortFilterConst.SortType.MountGamePlayStatus then
      local status = serverData:getGameplayStatus()
      if status == L_Const.PetState.PET_WORKING or status == L_Const.PetState.PET_RESTING or status == L_Const.PetState.PET_HUB then
        value = 1
      elseif status == L_Const.PetState.PET_HERO then
        value = 2
      elseif status == L_Const.PetState.PET_NORMAL then
        value = 3
      else
        value = 0
      end
    end
    if value == nil then
      errorf("排序类型" .. sortType .. "在宠物代码未补充，优先找策划确认是否配置正确并找程序接入了")
    end
    res[L_SortFilterConst.SortTypeKeyName[sortType]] = value or 0
  end
  return res
end

function this:getCommonItemSortKey(keyList, itemId, guid)
  local tpl_item = _commonItemTpl:getTplById(itemId)
  local res = {}
  for i, keyTypeId in ipairs(keyList) do
    local tpl_sortKey = _systemSorttypeTpl:getTplById(keyTypeId)
    local sortType, sortPara = table.unpack(_systemSorttypeTpl:getSortPara(tpl_sortKey))
    local value
    if sortType == L_SortFilterConst.SortType.Satiety then
      local tpl_food = _foodTpl:getTplById(itemId)
      if tpl_food then
        value = _foodTpl:getSatietyScore(tpl_food)
      end
    elseif sortType == L_SortFilterConst.SortType.ConfigId then
      value = itemId
    elseif sortType == L_SortFilterConst.SortType.ServerId then
      value = guid or itemId
    end
    if value == nil then
      errorf("排序类型" .. sortType .. "在commonItem代码未补充，优先找策划确认是否配置正确并找程序接入了")
    end
    res[L_SortFilterConst.SortTypeKeyName[sortType]] = value or 0
  end
  return res
end

function this:getHeroEncyclopediaSortKey(keyList, itemId, guid)
  local tpl_item = _heroTpl:getTplById(itemId)
  local res = {}
  for i, keyTypeId in ipairs(keyList) do
    local tpl_sortKey = _systemSorttypeTpl:getTplById(keyTypeId)
    local sortType, sortPara = table.unpack(_systemSorttypeTpl:getSortPara(tpl_sortKey))
    local value
    if sortType == L_SortFilterConst.SortType.ConfigId then
      value = itemId
    elseif sortType == L_SortFilterConst.SortType.IsUnlock then
      if L_HeroStore:getHasHero(itemId) then
        value = 1
      else
        value = 0
      end
    elseif sortType == L_SortFilterConst.SortType.Quality then
      value = _heroTpl:getRarity(tpl_item)
    elseif sortType == L_SortFilterConst.SortType.Element then
      value = _heroTpl:getElement(tpl_item)
    end
    if value == nil then
      errorf("排序类型" .. sortType .. "在英雄图鉴代码未补充，优先找策划确认是否配置正确并找程序接入了")
    end
    res[L_SortFilterConst.SortTypeKeyName[sortType]] = value or 0
  end
  return res
end

return this
