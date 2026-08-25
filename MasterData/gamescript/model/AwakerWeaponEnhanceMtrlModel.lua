local Quality2ExpType = {
  Orange = "OrangeWeaponLevelUpExp",
  Purple = "PurpleWeaponLevelUpExp",
  Blue = "BlueWeaponLevelUpExp"
}

local function TotalExpOfLevel(targetLv, expType)
  if 1 == targetLv then
    return 0
  end
  local exp = 0
  for lv, cfg in ipairs(DT.WeaponLevelUpExp) do
    exp = exp + cfg[expType]
    if lv == targetLv - 1 then
      break
    end
  end
  return exp
end

local feedItemExpDict = {}
local feedItemExpList = DT.GetOriginalConstant("WeaponFeedItemsAndProvidedExperience")
for idx = 1, #feedItemExpList - 1, 2 do
  local tid = feedItemExpList[idx]
  local exp = feedItemExpList[idx + 1]
  feedItemExpDict[tid] = exp
end
local sortType_1 = LT.Text("WeaponEnhanceMtrlSortType_1")
local sortType_2 = LT.Text("WeaponEnhanceMtrlSortType_2")
local sortOrder_1 = LT.Text("ActorString_Sort_Ascend")
local sortOrder_2 = LT.Text("ActorString_Sort_Descend")
local currSortType = sortType_1
local currSortOrder = sortOrder_1

local function AscendingSorter(a, b)
  if a < b then
    return true
  end
  if b < a then
    return false
  end
end

local function DescendingSorter(a, b)
  if b < a then
    return true
  end
  if a < b then
    return false
  end
end

local function MtrlSorterDefault(a, b)
  local aCfg = ItemDataUtils.GetItemConfig(a.tid)
  local bCfg = ItemDataUtils.GetItemConfig(b.tid)
  local aQualSortID = CommonDefine.QualitySortID[aCfg.Quality]
  local bQualSortID = CommonDefine.QualitySortID[bCfg.Quality]
  if not a.item.locked and b.item.locked then
    return true
  end
  if not b.item.locked and a.item.locked then
    return false
  end
  if not a.isWeapon and b.isWeapon then
    return true
  end
  if not b.isWeapon and a.isWeapon then
    return false
  end
  if not a.isWeapon and not b.isWeapon then
    local aExp = feedItemExpDict[a.tid]
    local bExp = feedItemExpDict[b.tid]
    return aExp > bExp
  end
  if currSortType == sortType_1 then
    if currSortOrder == sortOrder_1 then
      local result = AscendingSorter(a.enhanceLevel, b.enhanceLevel)
      if nil ~= result then
        return result
      end
      result = AscendingSorter(aQualSortID, bQualSortID)
      if nil ~= result then
        return result
      end
    elseif currSortOrder == sortOrder_2 then
      local result = DescendingSorter(a.enhanceLevel, b.enhanceLevel)
      if nil ~= result then
        return result
      end
      result = DescendingSorter(aQualSortID, bQualSortID)
      if nil ~= result then
        return result
      end
    end
  elseif currSortType == sortType_2 then
    if currSortOrder == sortOrder_1 then
      local result = AscendingSorter(aQualSortID, bQualSortID)
      if nil ~= result then
        return result
      end
      result = AscendingSorter(a.enhanceLevel, b.enhanceLevel)
      if nil ~= result then
        return result
      end
    elseif currSortOrder == sortOrder_2 then
      local result = DescendingSorter(aQualSortID, bQualSortID)
      if nil ~= result then
        return result
      end
      result = DescendingSorter(a.enhanceLevel, b.enhanceLevel)
      if nil ~= result then
        return result
      end
    end
  end
  return aCfg.BaseSortID < bCfg.BaseSortID
end

local function MtrlSorterAutoFill(a, b)
  local aCfg = ItemDataUtils.GetItemConfig(a.tid)
  local bCfg = ItemDataUtils.GetItemConfig(b.tid)
  if not a.isWeapon and b.isWeapon then
    return true
  end
  if not b.isWeapon and a.isWeapon then
    return false
  end
  if not a.isWeapon and not b.isWeapon then
    local aExp = feedItemExpDict[a.tid]
    local bExp = feedItemExpDict[b.tid]
    return aExp > bExp
  end
  local result = AscendingSorter(a.enhanceLevel, b.enhanceLevel)
  if nil ~= result then
    return result
  end
  result = AscendingSorter(a.refineLevel, b.refineLevel)
  if nil ~= result then
    return result
  end
  return aCfg.BaseSortID < bCfg.BaseSortID
end

local function createModelState(mtrlSlotsModel, weaponDetailModel)
  local state = {}
  state.mtrls = {}
  state.mtrlSlotsModel = mtrlSlotsModel
  state.weaponDetailModel = weaponDetailModel
  state.sortTypeShow = false
  state.sortTypeList = {sortType_1, sortType_2}
  state.sortType = sortType_1
  state.sortOrderList = {sortOrder_1, sortOrder_2}
  state.sortOrder = sortOrder_1
  currSortType = state.sortType
  currSortOrder = state.sortOrder
  return state
end

local function createModelViews()
  local views = {}
  
  function views:GetMtrls()
    return self.mtrls
  end
  
  function views:GetCurrClickedMtrl()
    return self.currClickedMtrl
  end
  
  return views
end

local function createModelActions(data)
  local actions = {}
  
  function actions:ClearCurrClickedMtrl()
    data.currClickedMtrl = nil
  end
  
  function actions:CollectMtrls(sorter)
    data.mtrls = {}
    for _, item in pairs(DataCenter.itemData.BagItemData) do
      local feedItemExp = feedItemExpDict[item.tid]
      if feedItemExp then
        do
          local mtrl = data:_CreateMtrl(item, false, feedItemExp)
          table.insert(data.mtrls, mtrl)
        end
      else
        local cfg = ItemDataUtils.GetItemConfig(item.tid)
        if cfg.Type == CommonDefine.ItemType.Weapon and (not item.awaker or 0 == item.awaker) and item.uid ~= data.weaponDetailModel.weapon.uid then
          local exp = data:_GetWeaponExp(item, cfg)
          local mtrl = data:_CreateMtrl(item, true, exp)
          table.insert(data.mtrls, mtrl)
        end
      end
    end
    table.sort(data.mtrls, sorter or MtrlSorterDefault)
    local slots = data.mtrlSlotsModel:GetSlots()
    for _, mtrl in ipairs(data.mtrls) do
      for _, slot in ipairs(slots) do
        if mtrl.uid == slot.uid then
          mtrl.selectCount = slot.count
          break
        end
      end
    end
  end
  
  function actions:HasMtrlsOfType(mtrlType)
    if mtrlType == CommonDefine.WeaponEnhance.AutoMtrlType_1 then
      for _, mtrl in ipairs(data.mtrls) do
        if not mtrl.isWeapon then
          return true
        end
      end
    end
    if mtrlType == CommonDefine.WeaponEnhance.AutoMtrlType_2 then
      for _, mtrl in ipairs(data.mtrls) do
        if mtrl.isWeapon then
          local cfg = ItemDataUtils.GetItemConfig(mtrl.tid)
          if cfg.Quality == "White" or cfg.Quality == "Blue" then
            return true
          end
        end
      end
    end
    return false
  end
  
  function actions:_GetWeaponExp(weapon, cfg)
    local quality = cfg.Quality
    if "White" == quality then
      do return DT.GetConstant end
      return DT.GetConstant, "WhiteWeaponMaterialExperience", nil, nil, nil, nil, nil
    end
    local baseExp = 0
    if "Orange" == quality then
      baseExp = DT.GetConstant("SSRWeaponMaterialExperience")
    elseif "Purple" == quality then
      baseExp = DT.GetConstant("SRWeaponMaterialExperience")
    elseif "Blue" == quality then
      baseExp = DT.GetConstant("RWeaponMaterialExperience")
    end
    local expType = Quality2ExpType[quality]
    local enhanceExp = TotalExpOfLevel(weapon.enhanceLevel, expType) + weapon.exp
    local rate = DT.GetConstant("ExperienceConversionRate")
    do return math.ceil end
    return math.ceil, baseExp * weapon.level + enhanceExp * rate, enhanceExp * rate
  end
  
  function actions:_CreateMtrl(item, isWeapon, exp)
    return {
      item = item,
      tid = item.tid,
      uid = item.uid,
      count = item.num,
      selectCount = 0,
      isWeapon = isWeapon,
      refineLevel = item.level or 0,
      enhanceLevel = item.enhanceLevel or 0,
      exp = exp
    }
  end
  
  function actions:SetCurrClickedMtrl(uid)
    for _, mtrl in ipairs(data.mtrls) do
      if mtrl.uid == uid then
        data.currClickedMtrl = mtrl
        break
      end
    end
  end
  
  function actions:SelectMtrl(uid)
    for _, mtrl in ipairs(data.mtrls) do
      if mtrl.uid == uid then
        local result = data:MtrlsInSlotsCanReachLevelLimit()
        if result.canReach then
          if mtrl.selectCount > 0 then
            data.currClickedMtrl = mtrl
            break
          end
          data.currClickedMtrl = nil
          Alert.Show(10580)
          break
        end
        if not self.mtrlSlotsModel:HasFreeSlots() and 0 == mtrl.selectCount then
          if mtrl.selectCount > 0 then
            data.currClickedMtrl = mtrl
            break
          end
          data.currClickedMtrl = nil
          Alert.Show(10581)
          break
        end
        data.currClickedMtrl = mtrl
        if mtrl.selectCount ~= mtrl.count then
          mtrl.selectCount = mtrl.selectCount + 1
          if mtrl.selectCount > 1 then
            data.mtrlSlotsModel:UpdateMtrl(mtrl.tid, mtrl.uid, mtrl.selectCount, mtrl.exp)
            break
          end
          data:_PutMtrlIntoNextFreeSlot(mtrl)
        end
        break
      end
    end
  end
  
  function actions:UnselectMtrl(uid, doNotClearClicked)
    for _, mtrl in ipairs(data.mtrls) do
      if mtrl.uid == uid then
        mtrl.selectCount = math.max(mtrl.selectCount - 1, 0)
        if mtrl.selectCount > 0 then
          data.mtrlSlotsModel:UpdateMtrl(mtrl.tid, mtrl.uid, mtrl.selectCount, mtrl.exp)
          break
        end
        data.mtrlSlotsModel:RemoveMtrl(mtrl.tid)
        break
      end
    end
    if not doNotClearClicked and data.currClickedMtrl and data.currClickedMtrl.uid == uid and 0 == data.currClickedMtrl.selectCount then
      data.currClickedMtrl = nil
    end
  end
  
  function actions:FillSlotsWithMaterials()
    if not self.mtrlSlotsModel:HasFreeSlots() then
      Alert.Show(10581)
      return
    end
    data:CollectMtrls(MtrlSorterAutoFill)
    local mtrlType = data.mtrlSlotsModel:GetAutoSelectMtrlType()
    if not data:HasMtrlsOfType(mtrlType) then
      Alert.Show(10582)
      return
    end
    for _, mtrl in ipairs(data.mtrls) do
      if mtrlType == CommonDefine.WeaponEnhance.AutoMtrlType_1 then
        if not mtrl.isWeapon then
          if mtrl.selectCount > 0 then
            local result = data:MtrlsInSlotsCanReachLevelLimit(mtrl)
            if not result.canReach and result.count > 0 then
              local remainingCount = mtrl.count - mtrl.selectCount
              mtrl.selectCount = mtrl.selectCount + math.min(result.count, remainingCount)
              data:_UpdateMtrlInSlot(mtrl)
            end
          else
            local result = data:MtrlsInSlotsCanReachLevelLimit(mtrl)
            if not result.canReach and result.count > 0 then
              mtrl.selectCount = math.min(result.count, mtrl.count)
              data:_PutMtrlIntoNextFreeSlot(mtrl)
            end
          end
        end
      elseif mtrlType == CommonDefine.WeaponEnhance.AutoMtrlType_2 and mtrl.isWeapon and 0 == mtrl.selectCount then
        local mtrlCfg = ItemDataUtils.GetItemConfig(mtrl.tid)
        if CommonDefine.WeaponEnhanceAutoMtrlQuality[mtrlCfg.Quality] then
          local result = data:MtrlsInSlotsCanReachLevelLimit(mtrl)
          if not result.canReach and result.count > 0 then
            mtrl.selectCount = math.min(result.count, mtrl.count)
            data:_PutMtrlIntoNextFreeSlot(mtrl)
          end
        end
      end
    end
  end
  
  function actions:MtrlsInSlotsCanReachLevelLimit(mtrl)
    local currExp = data.weaponDetailModel:GetTotalEnhanceExp()
    local slotExp = data.mtrlSlotsModel:GetTotalExp()
    local totalExp = currExp + slotExp
    local expToLevelLimit = data.weaponDetailModel:GetTotalExpToEnhanceLevelLimit()
    if totalExp >= expToLevelLimit then
      return {canReach = true, count = 0}
    else
      local needExp = expToLevelLimit - totalExp
      local needCount = 0
      if mtrl then
        needCount = math.ceil(needExp / mtrl.exp)
      end
      return {canReach = false, count = needCount}
    end
  end
  
  function actions:_UpdateMtrlInSlot(mtrl)
    data.mtrlSlotsModel:UpdateMtrl(mtrl.tid, mtrl.uid, mtrl.selectCount, mtrl.exp)
  end
  
  function actions:_PutMtrlIntoNextFreeSlot(mtrl)
    if data.mtrlSlotsModel:HasFreeSlots() then
      data.mtrlSlotsModel:PutMtrlIntoNextFreeSlot(mtrl.tid, mtrl.uid, mtrl.isWeapon, mtrl.refineLevel, mtrl.enhanceLevel, mtrl.selectCount, mtrl.exp)
    end
  end
  
  function actions:SetSortTypeShow(sortTypeShow)
    if nil == sortTypeShow then
      sortTypeShow = false
    end
    data.sortTypeShow = sortTypeShow
  end
  
  function actions:SetSortType(sortType)
    data.sortType = sortType
    currSortType = data.sortType
  end
  
  function actions:SetSortOrder(sortOrder)
    data.sortOrder = sortOrder
    currSortOrder = data.sortOrder
  end
  
  function actions:SortMtrls()
    table.sort(data.mtrls, MtrlSorterDefault)
  end
  
  return actions
end

local function onSetup(_, _)
end

local AwakerWeaponEnhanceMtrlModel = Vue.model("AwakerWeaponEnhanceMtrlModel", createModelState):views(createModelViews):actions(createModelActions):setup(onSetup)
return AwakerWeaponEnhanceMtrlModel
