local this = {}
local _accessoryTpl = L_GameTpl:getAccessoryTpl()
local _petTpl = L_GameTpl:getPetTpl()
local _heroTpl = L_GameTpl:getHeroTpl()
local _mountTpl = L_GameTpl:getMountTpl()
local _systemFiltercontentTpl = L_GameTpl:getSystemFiltercontentTpl()
local _systemFiltertypeTpl = L_GameTpl:getSystemFiltertypeTpl()
local _librarySeriesTpl = L_GameTpl:getLibrarySeriesTpl()
local _soulessenceTpl = L_GameTpl:getSoulessenceTpl()
local _petTalentTpl = L_GameTpl:getPetTalentTpl()

local function convertIdListToEnumIdIfNeeded(typeId, idList)
  local tpl_filterType = _systemFiltertypeTpl:getTplById(typeId)
  if not tpl_filterType then
    return idList
  end
  local filterKey = _systemFiltertypeTpl:getFilterKey(tpl_filterType)
  local filterTable = _systemFiltertypeTpl:getFilterTable(tpl_filterType)
  if filterKey ~= "id" or filterTable ~= "system_filterContent" then
    return idList
  end
  local paraList = {}
  for i, v in pairs(idList) do
    local tpl_systemFilterContent = _systemFiltercontentTpl:getTplById(v)
    if tpl_systemFilterContent then
      local enumId = _systemFiltercontentTpl:getEnumId(tpl_systemFilterContent)
      if enumId and enumId ~= 0 then
        table.insert(paraList, enumId)
      else
        table.insert(paraList, v)
      end
    else
      table.insert(paraList, v)
    end
  end
  return paraList
end

local function getFilterOptionValueByIndex(typeId, index)
  local tplFilterType = _systemFiltertypeTpl:getTplById(typeId)
  if not tplFilterType then
    return
  end
  local filterContent = _systemFiltertypeTpl:getFilterContent(tplFilterType)
  local filterTable = _systemFiltertypeTpl:getFilterTable(tplFilterType)
  local filterKey = _systemFiltertypeTpl:getFilterKey(tplFilterType)
  local config
  if not table.isEmpty(filterContent) then
    config = L_Config:getConfigDirectly(filterTable, filterContent[index])
  else
    local configList = L_Config:getConfigDirectly(filterTable)
    config = configList and configList[index]
  end
  return config and config[filterKey]
end

local Type2Func_filter = {
  [L_Const.resType.accessory] = "getAccessoryFilterKey",
  [L_Const.resType.hero] = "getHeroFilterKey",
  [L_Const.resType.pet] = "getPetFilterKey",
  [L_Const.resType.soulEssence] = "getSoulEssenceFilterKey"
}

function this:getFilterKey(itemType, keyDic, itemId, guid)
  if keyDic[L_SortFilterConst.FilterType.All] then
    return {}
  end
  if Type2Func_filter[itemType] then
    return self[Type2Func_filter[itemType]](self, keyDic, itemId, guid)
  else
    errorf("类型" .. itemType .. "代码未补充，优先找策划确认是否配置正确并找程序接入了")
  end
end

function this:getAccessoryFilterKey(keyDic, itemId, guid)
  local serverData = guid and C_AccessoryMgr:getAccessory(guid) or {}
  local res = {}
  for typeId, idList in pairs(keyDic) do
    local compareValue
    if typeId == L_SortFilterConst.FilterType.Suit then
      local tpl_item = _accessoryTpl:getTplById(itemId)
      compareValue = _accessoryTpl:getSetId(tpl_item)
    elseif typeId == L_SortFilterConst.FilterType.EquipStatus then
      compareValue = math.isEmpty(serverData.wearHero) and L_SortFilterConst.FilterId.IsNotEquipped or L_SortFilterConst.FilterId.IsEquipped
    elseif typeId == L_SortFilterConst.FilterType.EquipQuality then
      local tpl_item = _accessoryTpl:getTplById(itemId)
      compareValue = _accessoryTpl:getRarity(tpl_item)
    elseif typeId == L_SortFilterConst.FilterType.LevelStatus then
      compareValue = C_AccessoryMgr:getIsMaxLevel(guid) and L_SortFilterConst.FilterId.MaxLevel or L_SortFilterConst.FilterId.NotMaxLevel
    elseif typeId == L_SortFilterConst.FilterType.LockedStatus then
      compareValue = serverData.bLock and L_SortFilterConst.FilterId.Locked or L_SortFilterConst.FilterId.UnLocked
    elseif typeId == L_SortFilterConst.FilterType.CollectProcess then
      compareValue = L_LibraryBookStore:getCollectProcess(guid)
    elseif typeId == L_SortFilterConst.FilterType.BookTag then
      compareValue = _librarySeriesTpl:getTplById(guid).category
    elseif typeId == L_SortFilterConst.FilterType.ItemRarity then
      compareValue = L_ItemTplManager:getItemConfig(itemId, guid).quality
    end
    if compareValue == nil then
      errorf("筛选主题" .. typeId .. "在装备代码未补充，优先找策划确认是否配置正确并找程序接入了")
    end
    local node, index = table.ipairsFind(idList, function(value)
      if typeId == L_SortFilterConst.FilterType.BookTag then
        for k, v in pairs(compareValue) do
          if v == value then
            return true
          end
        end
        return false
      else
        return value == compareValue
      end
    end)
    local keyName = L_SortFilterConst.FilterTypeKeyName[typeId]
    if keyName then
      res[keyName] = index ~= nil
    end
  end
  return res
end

function this:getPetFilterKey(keyDic, itemId, guid)
  local tpl_item = _petTpl:getTplById(itemId)
  local res = {}
  local pet = L_PetStore:getPetItem(guid)
  for typeId, idList in pairs(keyDic) do
    local compareValue, isTable
    if typeId == L_SortFilterConst.FilterType.Element then
      idList = convertIdListToEnumIdIfNeeded(typeId, idList)
      compareValue = _petTpl:getElement(tpl_item)
      isTable = true
    elseif typeId == L_SortFilterConst.FilterType.MoveType then
      idList = convertIdListToEnumIdIfNeeded(typeId, idList)
      local tpl_mount = _mountTpl:getTplById(itemId)
      compareValue = _mountTpl:getMoveType(tpl_mount)
      isTable = true
    elseif typeId == L_SortFilterConst.FilterType.QiBoGrade then
      idList = convertIdListToEnumIdIfNeeded(typeId, idList)
      local _, temp = L_PetStore:getPetGradeNew(guid)
      compareValue = temp
    elseif typeId == L_SortFilterConst.FilterType.QiBoSpecial then
      compareValue = pet:getIsSpecialPet() and L_SortFilterConst.FilterId.PetSpeical or L_SortFilterConst.FilterId.PetNormal
    elseif typeId == L_SortFilterConst.FilterType.QiBoBoxMode then
      compareValue = L_SortFilterConst.FilterId.QiBoBoxMode
    elseif typeId == L_SortFilterConst.FilterType.QiBoQuality then
      local tpl_petTalent = pet and _petTalentTpl:getTplById(pet.petTalentId)
      compareValue = tpl_petTalent and _petTalentTpl:getFilterContentId(tpl_petTalent) or 0
    elseif typeId == L_SortFilterConst.FilterType.QiBoSpecialType then
      compareValue = {}
      if pet:getIsSpecialPet() then
        local value = getFilterOptionValueByIndex(typeId, 1)
        if value ~= nil then
          table.insert(compareValue, value)
        end
      end
      if not math.isEmpty(pet.colorMatId) then
        local value = getFilterOptionValueByIndex(typeId, 2)
        if value ~= nil then
          table.insert(compareValue, value)
        end
      end
      if pet:hasFlashGene() then
        local value = getFilterOptionValueByIndex(typeId, 3)
        if value ~= nil then
          table.insert(compareValue, value)
        end
      end
      isTable = true
    elseif typeId == L_SortFilterConst.FilterType.BattleTag then
      idList = convertIdListToEnumIdIfNeeded(typeId, idList)
      compareValue = _petTpl:getBattleTag(tpl_item)
      isTable = true
    elseif typeId == L_SortFilterConst.FilterType.LockedStatus then
      local isLocked = pet and pet.is_lock == true
      compareValue = isLocked and L_SortFilterConst.FilterId.Locked or L_SortFilterConst.FilterId.UnLocked
    end
    if compareValue == nil then
      errorf("筛选主题" .. typeId .. "在宠物代码未补充，优先找策划确认是否配置正确并找程序接入了")
    end
    local node, index = table.ipairsFind(idList, function(value)
      if isTable then
        local node2, index2 = table.ipairsFind(compareValue, function(value2)
          return value2 == value
        end)
        return index2 ~= nil
      else
        return value == compareValue
      end
    end)
    local keyName = L_SortFilterConst.FilterTypeKeyName[typeId]
    if keyName then
      res[keyName] = index ~= nil
    end
  end
  return res
end

function this:getHeroFilterKey(keyDic, itemId, guid)
  local tpl_item = _heroTpl:getTplById(itemId)
  local serverData = guid and L_HeroStore:getHero(guid) or {}
  local res = {}
  for typeId, idList in pairs(keyDic) do
    local compareValue, isTable
    if typeId == L_SortFilterConst.FilterType.Element then
      compareValue = _heroTpl:getElement(tpl_item)
    elseif typeId == L_SortFilterConst.FilterType.Profession then
      compareValue = _heroTpl:getPosition(tpl_item)
    end
    if compareValue == nil then
      errorf("筛选主题" .. typeId .. "在角色代码未补充，优先找策划确认是否配置正确并找程序接入了")
    end
    local node, index = table.ipairsFind(idList, function(value)
      if isTable then
        local node2, index2 = table.ipairsFind(compareValue, function(value2)
          return value2 == value
        end)
        return index2 ~= nil
      else
        return value == compareValue
      end
    end)
    local keyName = L_SortFilterConst.FilterTypeKeyName[typeId]
    if keyName then
      res[keyName] = index ~= nil
    end
  end
  return res
end

function this:getSoulEssenceFilterKey(keyDic, itemId, guid)
  local tpl_item = _soulessenceTpl:getTplById(itemId)
  local res = {}
  for typeId, idList in pairs(keyDic) do
    local compareValue
    if typeId == L_SortFilterConst.FilterType.SpiritionRarity then
      compareValue = _soulessenceTpl:getRarity(tpl_item)
    end
    if compareValue == nil then
      errorf("筛选主题" .. typeId .. "在装备代码未补充，优先找策划确认是否配置正确并找程序接入了")
    end
    local node, index = table.ipairsFind(idList, function(value)
      return value == compareValue
    end)
    local keyName = L_SortFilterConst.FilterTypeKeyName[typeId]
    if keyName then
      res[keyName] = index ~= nil
    end
  end
  return res
end

return this
