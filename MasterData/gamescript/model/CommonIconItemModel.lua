local ItemType = CommonDefine.ItemType

local function createCommonIconItemModelState()
  local state = {}
  state.itemDataMap = nil
  state.chosenUid = 0
  
  function state.chosenItemData()
    local uid = state.chosenUid
    if not uid or 0 == uid then
      return nil
    end
    do return state.GetDataByUid, state end
    return state.GetDataByUid, state, uid
  end
  
  state.multiChosenUidMap = {}
  return state
end

local function createCommonIconItemModelViews(data)
  local views = {}
  
  function views:GetChosenUid()
    return data.state
  end
  
  function views:AddToMultiChosenUidMap(uid, num)
    if not uid then
      return
    end
    local itemData = data.multiChosenUidMap[uid]
    if itemData then
      Logger.Debug("道具已被选中")
      return
    end
    if not itemData then
      itemData = {uid = uid}
      data.multiChosenUidMap[uid] = itemData
    end
    itemData.num = num or itemData.num or 0
  end
  
  function views:UpdateMultiChosenMapData(uid, num)
    if not uid or not num then
      Logger.Debug("参数错误, uid:%s, num:%s", uid, num)
      return
    end
    local itemData = data.multiChosenUidMap[uid]
    if not itemData then
      return
    end
    itemData.num = num
    if itemData.num <= 0 then
      data.multiChosenUidMap[uid] = nil
    end
  end
  
  function views:GetItemType(tid)
    do return ItemDataUtils.GetItemType end
    return ItemDataUtils.GetItemType, tid
  end
  
  function views:GetDataByUid(uid)
    if not uid or 0 == uid then
      return nil
    end
    if data.itemDataMap then
      return data.itemDataMap[uid]
    end
    do return ItemDataUtils.GetItemByUid end
    return ItemDataUtils.GetItemByUid, uid
  end
  
  function views:GetDataByTid(tid)
    if not tid then
      Logger.Error("Error Parameter: nil")
      return
    end
    if data.itemDataMap then
      for _, itemData in pairs(data.itemDataMap) do
        if itemData and itemData.tid == tid then
          return itemData
        end
      end
      Logger.Debug("注意, 有自定义数据池, 却找不到对应数据, tid ==>", tid)
    end
    do return ItemDataUtils.GetItemByTid end
    return ItemDataUtils.GetItemByTid, tid, tid, pairs(data.itemDataMap)
  end
  
  function views:GetItemNumByTid(tid)
    if data.itemDataMap then
      for _, itemData in pairs(data.itemDataMap) do
        if itemData and itemData.tid == tid then
          return itemData.num or 0
        end
      end
      Logger.Debug("注意, 有自定义数据池, 却找不到对应数据, tid ==>", tid)
    end
    do return ItemDataUtils.GetItemNum end
    return ItemDataUtils.GetItemNum, tid, tid, pairs(data.itemDataMap)
  end
  
  function views:GetIcon(tid)
    if not tid then
      Logger.Error("Error Parameter: nil")
      return
    end
    do return ItemDataUtils.GetIcon end
    return ItemDataUtils.GetIcon, tid
  end
  
  function views:GetIsCanUse(uid)
    local item = ItemDataUtils.GetItemByUid(uid)
    if not item then
      return
    end
    local cfg = DT.Item[item.tid]
    if cfg.Type == CommonDefine.ItemType.Material then
      if cfg.SubType == CommonDefine.ItemSubType.FastPromotion then
        return true
      end
    elseif cfg.Type == CommonDefine.ItemType.Special then
      return true
    end
  end
  
  function views:GetAwakerSmallIcon(tid)
    if not tid or "" == tid then
      return ""
    end
    do return AwakerDataUtils.GetLittleIcon end
    return AwakerDataUtils.GetLittleIcon, tid
  end
  
  function views:GetAwakerCircleHeadIcon(tid)
    local icon = AwakerDataUtils.GetCircleHeadIcon(tid)
    return icon
  end
  
  function views:GetAwakerName(tid)
    do return AwakerDataUtils.GetAwakerName end
    return AwakerDataUtils.GetAwakerName, tid
  end
  
  function views:GetCurWeaponRefineLevel()
    if 0 == data.chosenUid or data.chosenUid == nil then
      return 0
    end
    do return self.GetWeaponRefineLevelByUid, self end
    return self.GetWeaponRefineLevelByUid, self, data.chosenUid
  end
  
  function views:GetWeaponRefineLevelByUid(uid)
    local itemData = self:GetDataByUid(uid)
    if not itemData then
      Logger.Info("找不到数据:", uid, debug.traceback())
      return 0
    end
    local itemType = self:GetItemType(itemData.tid)
    if itemType ~= ItemType.Weapon then
      return 0
    end
    return itemData.level or 0
  end
  
  function views:GetWeaponEnhanceLevelByUid(uid)
    local itemData = self:GetDataByUid(uid)
    if not itemData then
      Logger.Info("找不到数据:", uid, debug.traceback())
      return 0
    end
    local itemType = self:GetItemType(itemData.tid)
    if itemType ~= ItemType.Weapon then
      return 0
    end
    return itemData.enhanceLevel or 0
  end
  
  function views:GetCurTrinketLevel()
    if 0 == data.chosenUid or data.chosenUid == nil then
      return 0
    end
    do return self.GetTrinketLevelByUid, self end
    return self.GetTrinketLevelByUid, self, data.chosenUid
  end
  
  function views:GetTrinketLevelByUid(uid)
    local itemData = self:GetDataByUid(uid)
    if not itemData then
      Logger.Info("找不到数据:", uid)
      return 0
    end
    local itemType = self:GetItemType(itemData.tid)
    if itemType ~= ItemType.Trinket then
      return 0
    end
    return itemData.level or 0
  end
  
  function views:GetItemOwner(uid)
    local itemData = self:GetDataByUid(uid)
    if not itemData then
      Logger.Info("找不到数据:", uid)
      return 0
    end
    local itemType = ItemDataUtils.GetItemType(itemData.tid)
    if itemType ~= ItemType.Weapon and itemType ~= ItemType.Trinket then
      return nil
    end
    return itemData.awaker
  end
  
  function views:GetItemQualityImage(tid)
    do return ItemDataUtils.GetQualityFramePath end
    return ItemDataUtils.GetQualityFramePath, tid
  end
  
  function views:GetItemLocked(uid)
    do return ItemDataUtils.GetItemLocked end
    return ItemDataUtils.GetItemLocked, uid
  end
  
  function views:IsItemNew(uid)
    if not uid or 0 == uid then
      return false
    end
    local redData = RedPointDataUtils.GetRedDataByTid(RedPointDataUtils.RedType.Item, uid)
    if nil == redData then
      return false
    end
    return 1 == redData.isNew
  end
  
  return views
end

local function createCommonIconItemModelActions(data)
  local actions = {}
  
  function actions:SetChosenItemUid(uid)
    if not uid then
      Logger.Error("Error parameter: nil")
      return
    end
    data.chosenUid = uid
  end
  
  function actions:ReqRemoveNew(uid)
    local isNew = data:IsItemNew(uid)
    if not isNew then
      return
    end
    RedPointDataUtils.ReqRemoveData(RedPointDataUtils.RedType.Item, RedPointDataUtils.RedAttrType.IsNew, uid)
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

local CommonIconItemModel = Vue.model("CommonIconItemModel", createCommonIconItemModelState):views(createCommonIconItemModelViews):actions(createCommonIconItemModelActions):setup(onSetup)
return CommonIconItemModel
