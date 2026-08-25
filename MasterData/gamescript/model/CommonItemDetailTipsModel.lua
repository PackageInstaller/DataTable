local ItemType = CommonDefine.ItemType
local tableInsert = table.insert
local MAX_LOCK_STAGE_JUMP_NUM = 3

local function createCommonItemDetailTipsModelState(uid)
  local state = {}
  state.itemDataMap = nil
  state.chosenUid = uid or 0
  state.isPreview = false
  state.showWeaponHave = false
  state.chosenTid = 0
  
  function state.chosenItemData()
    local chosenUid = state.chosenUid
    if not chosenUid or 0 == chosenUid then
      return nil
    end
    do return state.GetDataByUid, state end
    return state.GetDataByUid, state, chosenUid
  end
  
  function state.itemType()
    if not state.chosenItemData then
      return nil
    end
    local tid = state.chosenItemData.tid
    local config = ItemDataUtils.GetItemConfig(tid)
    if not config then
      Logger.Info("找不到配置:", tid)
      return nil
    end
    return config.Type
  end
  
  function state.itemSubType()
    if not state.chosenItemData then
      return nil
    end
    local tid = state.chosenItemData.tid
    local config = ItemDataUtils.GetItemConfig(tid)
    if not config then
      Logger.Info("找不到配置:", tid)
      return nil
    end
    return config.SubType
  end
  
  state.banLock = false
  return state
end

local function createCommonItemDetailTipsModelViews(data)
  local views = {}
  
  function views:GetDataByUid(uid)
    if not uid then
      return
    end
    if data.itemDataMap then
      return data.itemDataMap[uid]
    end
    do return ItemDataUtils.GetItemByUid end
    return ItemDataUtils.GetItemByUid, uid
  end
  
  function views:GetItemName()
    if not data.chosenItemData then
      return ""
    end
    do return ItemDataUtils.GetItemName end
    return ItemDataUtils.GetItemName, data.chosenItemData.tid
  end
  
  function views:GetItemTitleQualityFrame()
    if not data.chosenItemData then
      return ""
    end
    local boundCheckUid
    if not data.isPreview then
      boundCheckUid = data.chosenItemData.uid
    end
    do return ItemDataUtils.GetTitleQualityFramePath, data.chosenItemData.tid end
    return ItemDataUtils.GetTitleQualityFramePath, data.chosenItemData.tid, boundCheckUid
  end
  
  function views:GetItemBgQualityFrame()
    if not data.chosenItemData then
      return ""
    end
    local boundCheckUid
    if not data.isPreview then
      boundCheckUid = data.chosenItemData.uid
    end
    do return ItemDataUtils.GetBgQualityFramePath, data.chosenItemData.tid end
    return ItemDataUtils.GetBgQualityFramePath, data.chosenItemData.tid, boundCheckUid
  end
  
  function views:GetItemIcon()
    if not data.chosenItemData then
      return ""
    end
    do return ItemDataUtils.GetIcon end
    return ItemDataUtils.GetIcon, data.chosenItemData.tid
  end
  
  function views:GetItemGets()
    local rst = {}
    if not data.chosenItemData then
      return rst
    end
    local stageJumpGroup = {}
    local getsId2ItemIdMap = {}
    local itemGetsGroup = ItemDataUtils.GetItemGets(data.chosenItemData.tid)
    local itemGetsSortWeightMap = {}
    for idx, tid in ipairs(table.deepclone(itemGetsGroup)) do
      itemGetsSortWeightMap[tid] = idx
      getsId2ItemIdMap[tid] = data.chosenItemData.tid
      local cfg = DT.ItemGets[tid]
      if cfg.JumpFunc ~= CommonDefine.JumpFuncType.Stage then
        table.insert(rst, tid)
      else
        table.insert(stageJumpGroup, tid)
      end
    end
    table.sort(stageJumpGroup, function(a, b)
      local aOrder = DT.ItemGets[a].Order
      local bOrder = DT.ItemGets[b].Order
      return aOrder < bOrder
    end)
    local firstLockIdx = 0
    for idx, tid in pairs(stageJumpGroup) do
      local unlock = FuncJumpManager.Instance:CanJump(tid)
      if not unlock then
        firstLockIdx = idx
        break
      end
    end
    if 0 ~= firstLockIdx then
      table.insert(rst, stageJumpGroup[firstLockIdx])
    else
      firstLockIdx = #stageJumpGroup + 1
    end
    for i = 1, MAX_LOCK_STAGE_JUMP_NUM do
      if firstLockIdx - i > 0 then
        table.insert(rst, stageJumpGroup[firstLockIdx - i])
      end
    end
    table.sort(rst, function(a, b)
      local aUnlock = FuncJumpManager.Instance:CanJump(a, getsId2ItemIdMap[a]) and 1 or 0
      local bUnlock = FuncJumpManager.Instance:CanJump(b, getsId2ItemIdMap[b]) and 1 or 0
      if aUnlock == bUnlock then
        return itemGetsSortWeightMap[a] < itemGetsSortWeightMap[b]
      end
      return aUnlock > bUnlock
    end)
    return rst
  end
  
  function views:GetItemLocked()
    if not data.chosenItemData then
      return false
    end
    local itemType = ItemDataUtils.GetItemType(data.chosenItemData.tid)
    if itemType == ItemType.Weapon then
      return false
    end
    return data.chosenItemData.locked
  end
  
  function views:GetItemDesc()
    if data.specialDesc then
      return data.specialDesc
    end
    if not data.chosenItemData then
      return ""
    end
    local tid = data.chosenItemData.tid
    if ItemDataUtils.IsPayMoneyType(tid) then
      local config = ItemDataUtils.GetItemConfig(tid)
      if config then
        local payMoneyNum = ItemDataUtils.GetItemNum(CommonDefine.CurrencyType.PayMoney, true)
        local freePayMoneyNum = ItemDataUtils.GetItemNum(CommonDefine.CurrencyType.FreePayMoney, true)
        do return LT.Textf, config.Desc, payMoneyNum end
        return LT.Textf, config.Desc, payMoneyNum, freePayMoneyNum
      end
    end
    do return ItemDataUtils.GetItemDesc end
    return ItemDataUtils.GetItemDesc, tid, ItemDataUtils.GetItemNum(CommonDefine.CurrencyType.FreePayMoney, true), LT.Textf, config.Desc, payMoneyNum, freePayMoneyNum
  end
  
  function views:GetItemSubTypeName()
    if not data.chosenItemData then
      return ""
    end
    do return ItemDataUtils.GetItemSubTypeName end
    return ItemDataUtils.GetItemSubTypeName, data.chosenItemData.tid
  end
  
  function views:GetBackTrackItemExpiredTime()
    if data.chosenItemData then
      local cfg = DT.Item[data.chosenItemData.tid]
      if cfg.SubType == CommonDefine.ItemSubType.BackTrack then
        do return end
        return BackTrackDataUtils.GetEndTime, CommonDefine.ItemSubType.BackTrack
      end
    end
    return nil
  end
  
  function views:GetMainAttr()
    if not data.chosenItemData or data.isPreview then
      return
    end
    local mainAttr
    for _, attr in pairs(data.chosenItemData.attrs) do
      if attr and 1 == attr.index then
        mainAttr = attr
        break
      end
    end
    local attr = AwakerTrinketDataUtils.TrinketAttrToClientAttr(mainAttr)
    return attr
  end
  
  function views:GetMainAttrName()
    if not data.chosenItemData or data.isPreview then
      return ""
    end
    local tid = data.chosenItemData.tid
    if data.itemType == ItemType.Weapon then
      do return ItemDataUtils.GetWeaponAttrName end
      return ItemDataUtils.GetWeaponAttrName, tid
    elseif data.itemType == ItemType.Trinket then
      local attr = self:GetMainAttr()
      return attr and attr.name or ""
    end
    return ""
  end
  
  function views:GetMainAttrValue()
    if not data.chosenItemData or data.isPreview then
      return ""
    end
    local tid = data.chosenItemData.tid
    if data.itemType == ItemType.Weapon then
      do return ItemDataUtils.GetWeaponAttrValue end
      return ItemDataUtils.GetWeaponAttrValue, tid, nil, nil
    elseif data.itemType == ItemType.Trinket then
      local attr = self:GetMainAttr()
      local attrValue = attr and attr.count or ""
      if attr and attr.isPercent then
        attrValue = attrValue .. "%"
      end
      return attrValue
    end
    return ""
  end
  
  function views:GetItemStory()
    if not data.chosenItemData then
      return ""
    end
    do return ItemDataUtils.GetItemStory end
    return ItemDataUtils.GetItemStory, data.chosenItemData.tid
  end
  
  function views:GetItemLevel()
    if not data.chosenItemData then
      return 0
    end
    if data.itemType ~= ItemType.Weapon and data.itemType ~= ItemType.Trinket then
      return 0
    end
    if data.chosenItemData.level then
      return data.chosenItemData.level
    end
    if data.itemType == ItemType.Weapon then
      return 1
    end
    return 0
  end
  
  function views:GetWeaponDescList()
    local descList = {}
    if not data.chosenItemData then
      return descList
    end
    if data.itemType ~= ItemType.Weapon then
      return descList
    end
    local tid = data.chosenItemData.tid
    local level = self:GetItemLevel()
    local desc1 = SkillUtils.GetWeaponStateDesc(tid, level)
    if "" ~= desc1 then
      tableInsert(descList, desc1)
    end
    return descList
  end
  
  function views:ShowLockIcon()
    if data.banLock then
      return false
    end
    if data.isPreview then
      return false
    end
    if data.itemType == ItemType.Weapon then
      return false
    end
    return data.itemType == ItemType.Trinket
  end
  
  return views
end

local function createCommonItemDetailTipsModelActions(data)
  local actions = {}
  
  function actions:SetChosenItemUid(uid)
    if not uid then
      Logger.Error("Error parameter: nil")
      return
    end
    data.chosenUid = uid
  end
  
  function actions:SetSpecialDesc(desc)
    data.specialDesc = desc
  end
  
  function actions:SetChosenItemTid(tid)
    if not tid then
      Logger.Error("Error parameter: nil")
      return
    end
    data.chosenTid = tid
  end
  
  function actions:SetIsPreview(isPreview)
    data.isPreview = isPreview
  end
  
  function actions:SetShowWeaponHave(showWeaponHave)
    data.showWeaponHave = true == showWeaponHave
  end
  
  function actions:SetBanLock(banLock)
    data.banLock = banLock
  end
  
  function actions:ReqItemLock(lock, callback)
    if not data.chosenUid or 0 == data.chosenUid then
      return
    end
    EventMgr.Instance.OpenReqMask:Dispatch()
    local protoName = lock and "OnLockItem" or "OnUnlockItem"
    ProtoManager.Instance:ReqServer("GameRequest", protoName, function(lockState)
      if data.chosenItemData then
        data.chosenItemData.locked = lockState
        EventMgr.Instance.DecomposeLockStateEvent:Dispatch(data.chosenUid)
        GlobalDispatcher:Dispatch(NotifyId.OnBagItemDataChanged, data.chosenUid, data.chosenItemData.tid)
      end
      if callback then
        callback(lockState)
      end
    end, function()
    end, data.chosenUid)
  end
  
  function actions:SetItemDataMap(list)
    if not list or table.next(list) == nil then
      data.itemDataMap = nil
      return
    end
    data.itemDataMap = {}
    for _, itemData in pairs(list) do
      data.itemDataMap[itemData.uid] = itemData
    end
  end
  
  return actions
end

local function onSetup(_, _)
end

local CommonItemDetailTipsModel = Vue.model("CommonItemDetailTipsModel", createCommonItemDetailTipsModelState):views(createCommonItemDetailTipsModelViews):actions(createCommonItemDetailTipsModelActions):setup(onSetup)
return CommonItemDetailTipsModel
