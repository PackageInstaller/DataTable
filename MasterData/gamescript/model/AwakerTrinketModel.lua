local TrinketSortType = CommonDefine.AwakerTrinketSortType
local BtnType = CommonDefine.BtnType
local ItemType = CommonDefine.ItemType
local AwakerPage = CommonDefine.AwakerPage
local tableInsert = table.insert
local tableSort = table.sort
local TrinketFilterState = CommonDefine.TrinketFilterState

local function createAwakerTrinketModellState(awakerModel)
  local state = {}
  state.awakerModel = awakerModel
  state.selectPos = 0
  state.lastEquipUid = 0
  state.maskCompareButton = false
  state.sortType = TrinketSortType.Level
  state.sortTypeShow = false
  
  function state.sortTypeList()
    do return end
    return AwakerTrinketDataUtils.GetSortDataTable, nil
  end
  
  state.sortOrder = CommonDefine.SortOrder.Descend
  
  function state.showTrinketListPage()
    local page = state.awakerModel.page
    return page == AwakerPage.TrinketChange or page == AwakerPage.TrinketStrengthen
  end
  
  state.trinketShowList = {}
  state.selectTrinketUid = 0
  
  function state.selectTrinketTid()
    local uid = state.selectTrinketUid
    if 0 == uid then
      return 0
    end
    local data = state:GetTrinketDataByUid(uid)
    return data.tid
  end
  
  function state.equippedTrinketUid()
    local selectPos = state.selectPos
    local showTrinketListPage = state.showTrinketListPage
    if 0 == selectPos or not showTrinketListPage then
      return 0
    end
    local trinkets = state.trinkets
    for pos, trinket in pairs(trinkets) do
      if pos and pos == selectPos then
        return trinket.uid
      end
    end
    return 0
  end
  
  function state.equippedTrinketTid()
    local uid = state.equippedTrinketUid
    if 0 == uid then
      return 0
    end
    local data = state:GetTrinketDataByUid(uid)
    return data.tid
  end
  
  state.compareMode = false
  
  function state.trinkets()
    local awaker = state.awakerModel.selectAwakerData
    if not awaker then
      return {}
    end
    local trinketIds = awaker.trinkets
    if not trinketIds then
      return {}
    end
    local tmp = {}
    for pos, id in pairs(trinketIds) do
      local data = ItemDataUtils.GetItemByUid(id)
      tmp[pos] = data
    end
    local trinkets = tmp
    return trinkets
  end
  
  function state.currActiveSuitEffects()
    local trinkets = state.trinkets
    if not trinkets then
      return {}
    end
    local suitActiveMap = {}
    for _, trinket in pairs(trinkets) do
      local suitId = trinket.suitId
      local activeNum = suitActiveMap[suitId]
      if not activeNum then
        suitActiveMap[suitId] = 1
      else
        suitActiveMap[suitId] = activeNum + 1
      end
    end
    return suitActiveMap
  end
  
  function state.suitActiveTypeNum()
    local suitActiveMap = state.currActiveSuitEffects
    local num = 0
    for _, activeNum in pairs(suitActiveMap) do
      if activeNum >= 2 then
        num = num + 1
      end
    end
    return num
  end
  
  state.putOnBtnData = {
    text = function()
      local equippedTrinketUid = state.equippedTrinketUid
      local name = LT.Text("RoleDetailsEquipDetails_Btn_PutOn")
      local selectTrinketUid = state.selectTrinketUid
      local selectTrinketData = state:GetTrinketDataByUid(selectTrinketUid)
      if not selectTrinketData then
        return name
      end
      local selectHasAwaker = selectTrinketData.awaker and selectTrinketData.awaker > 0
      if equippedTrinketUid > 0 or selectHasAwaker then
        name = LT.Text("RoleDetailsEquipDetails_Btn_Replace")
        if equippedTrinketUid == selectTrinketUid then
          name = LT.Text("RoleDetailsEquipDetails_Btn_Remove")
        end
      end
      return name
    end,
    state = BtnType.High
  }
  
  function state.currActiveTrinketAttrs()
    local attrsActiveMap = {}
    local trinkets = state.trinkets
    if trinkets then
      for _, trinket in pairs(trinkets) do
        if not trinket.attrs then
        else
          for _, attr in pairs(trinket.attrs) do
            local curVal = attrsActiveMap[attr.attrId] or 0
            attrsActiveMap[attr.attrId] = curVal + attr.val
          end
        end
      end
    end
    local showAttrIds = AwakerDataUtils.GetSortedAttrIds(CommonDefine.AttrShowType.TrinketShow)
    local attrsArray = {}
    for _, attrId in ipairs(showAttrIds) do
      table.insert(attrsArray, AwakerTrinketDataUtils.TrinketAttrToClientAttr({
        attrId = attrId,
        val = attrsActiveMap[attrId] or 0
      }))
    end
    return attrsArray
  end
  
  state.filterMainAttrs = {}
  state.filterSubAttrs = {}
  state.filterParts = {}
  state.filterShow = false
  
  local function _filterSuits()
    local suits = {}
    local suitNumMap = ItemDataUtils.GetTrinketSuitNumMap()
    for suitId, _ in pairs(suitNumMap) do
      if 0 == suitId then
      elseif ItemDataUtils.TrinketShowTimeMatch(suitId) then
        table.insert(suits, suitId)
      end
    end
    table.sort(suits, function(a, b)
      return a < b
    end)
    return suits
  end
  
  function state.filterSuits()
    do return end
    return _filterSuits, nil
  end
  
  local suits = _filterSuits()
  local suitsMap = {}
  for i = 1, #suits do
    suitsMap[suits[i]] = TrinketFilterState.FilterDefault
  end
  state.filterSuitsMap = suitsMap
  for i = 1, CommonDefine.MaxEquipTrinketsNum do
    state.filterParts[i] = TrinketFilterState.FilterDefault
  end
  local showAttrIds = AwakerDataUtils.GetSortedAttrIds(CommonDefine.AttrShowType.TrinketShow)
  for i = 1, #showAttrIds do
    state.filterMainAttrs[showAttrIds[i]] = TrinketFilterState.FilterDefault
    state.filterSubAttrs[showAttrIds[i]] = TrinketFilterState.FilterDefault
  end
  
  function state.trinketFilterHaved()
    local attrIds = AwakerDataUtils.GetSortedAttrIds(CommonDefine.AttrShowType.TrinketShow)
    for i = 1, #attrIds do
      local hasMainAttr = state.filterMainAttrs[attrIds[i]] ~= TrinketFilterState.FilterDefault
      local hasSubAttr = state.filterSubAttrs[attrIds[i]] ~= TrinketFilterState.FilterDefault
      if hasMainAttr or hasSubAttr then
        return true
      end
    end
    if 0 == state.selectPos then
      for i = 1, CommonDefine.MaxEquipTrinketsNum do
        if state.filterParts[i] ~= TrinketFilterState.FilterDefault then
          return true
        end
      end
    end
    for suitId, st in pairs(state.filterSuitsMap) do
      if st ~= TrinketFilterState.FilterDefault then
        return true
      end
    end
    return false
  end
  
  return state
end

local function createAwakerTrinketModellViews(data)
  local views = {}
  
  function views:GetPosByCfgValue(cfgVal)
    return ItemDataUtils.TrinketPosMap[cfgVal]
  end
  
  function views:GetPosList(pos, withoutFilter)
    local trinketMap = ItemDataUtils.GetTrinketMapByPos(pos)
    local tmp = {}
    local selectAwakerId = data.awakerModel and data.awakerModel.selectAwakerId or 0 or 0
    local lastEquipUid = data.lastEquipUid
    local curEquipUid = 0
    local changeFormAwaker = 0
    if 0 ~= selectAwakerId then
      changeFormAwaker = AwakerDataUtils.GetChangerForm(selectAwakerId)
    end
    if not withoutFilter then
      for _, trinket in pairs(trinketMap) do
        if 0 ~= selectAwakerId then
          local owner = self:GetOwner(trinket.uid) or 0
          if owner == selectAwakerId or owner == changeFormAwaker then
            curEquipUid = trinket.uid
            lastEquipUid = 0
            break
          end
        end
      end
    end
    local equipUid = 0 ~= curEquipUid and curEquipUid or lastEquipUid
    local boundUid = 0
    if 0 ~= selectAwakerId and not table.next(AwakerDataUtils.GetMockAwakerMap()) then
      local boundUidTmp = AwakerDataUtils.GetBoundTrinketUid(selectAwakerId, pos)
      if 0 ~= boundUidTmp and ItemDataUtils.GetItemByUid(boundUidTmp) then
        boundUid = boundUidTmp
      end
    end
    for _, trinket in pairs(trinketMap) do
      if not AwakerTrinketDataUtils.IsTrinketVisibleInList(trinket.uid, equipUid) and trinket.uid ~= boundUid then
      elseif not withoutFilter then
        if 0 ~= equipUid and equipUid == trinket.uid or trinket.uid == boundUid then
          table.insert(tmp, trinket.uid)
        else
          local posIndex = ItemDataUtils.GetTrinketPosIndex(trinket)
          local mainAttr = AwakerTrinketDataUtils.GetMainAttr(trinket.uid)
          local subAttrs = AwakerTrinketDataUtils.GetSubAttrs(trinket.uid)
          local isSuitFilter = data:IsSuitFilter(trinket.suitId)
          local isPartFilter = data:IsPartFilter(posIndex)
          local isMainAttrFilter = data:IsMainAttrFilter(mainAttr.attrId)
          local isSubAttrFilter = data:IsSubAttrsFilter(subAttrs)
          if not (isSubAttrFilter and isSuitFilter and isPartFilter) or not isMainAttrFilter then
          else
            table.insert(tmp, trinket.uid)
          end
        end
      end
    end
    local sortType = data.sortType
    local sortOrder = data.sortOrder
    tmp = AwakerTrinketDataUtils.Sort(tmp, sortType, sortOrder)
    local list = tmp
    if 0 ~= equipUid then
      local index = -1
      for i = 1, #list do
        if list[i] == equipUid then
          index = i
          break
        end
      end
      if -1 ~= index then
        table.remove(list, index)
        table.insert(list, 1, equipUid)
      end
    end
    if 0 ~= boundUid and boundUid ~= equipUid then
      local boundIndex = -1
      for i = 1, #list do
        if list[i] == boundUid then
          boundIndex = i
          break
        end
      end
      if -1 ~= boundIndex then
        table.remove(list, boundIndex)
        table.insert(list, 1, boundUid)
      end
    end
    return list
  end
  
  function views:GetSortTypeName(sortType)
    do return AwakerTrinketDataUtils.GetSortTypeName end
    return AwakerTrinketDataUtils.GetSortTypeName, sortType
  end
  
  function views:GetSortOrderName(order)
    if not order then
      return ""
    end
    local key = "ActorString_Sort_Ascend"
    if order == CommonDefine.SortOrder.Descend then
      key = "ActorString_Sort_Descend"
    end
    do return LT.Text end
    return LT.Text, key
  end
  
  function views:GetFirstNotEmptyPos()
    for i = 1, 6 do
      local map = ItemDataUtils.GetTrinketMapByPos(i)
      if table.next(map) ~= nil then
        return i
      end
    end
    return 1
  end
  
  function views:GetSuitName(suitId)
    do return AwakerTrinketDataUtils.GetSuitName end
    return AwakerTrinketDataUtils.GetSuitName, suitId
  end
  
  function views:IsSuitGatherAll()
    local trinkets = data.trinkets
    local count = 0
    local suitId = trinkets[1] and trinkets[1].suitId or 0
    if 0 == suitId then
      return false
    end
    for _, trinket in pairs(trinkets) do
      if not trinket then
        return false
      end
      if trinket.suitId ~= suitId then
        return false
      end
      count = count + 1
    end
    return 6 == count
  end
  
  function views:GetSuitItemNum(suitId)
    local num = 0
    for pos = 1, CommonDefine.MaxEquipTrinketsNum do
      local uids = self:GetPosList(pos, true)
      for i = 1, #uids do
        local trinket = ItemDataUtils.GetItemByUid(uids[i])
        if trinket and trinket.suitId == suitId then
          num = num + 1
        end
      end
    end
    return num
  end
  
  function views:GetVisibleSuitItemNum(suitId)
    do return self.GetSuitItemNum, self end
    return self.GetSuitItemNum, self, suitId
  end
  
  function views:GetSuitIcon(suitId)
    do return AwakerTrinketDataUtils.GetSuitIcon end
    return AwakerTrinketDataUtils.GetSuitIcon, suitId
  end
  
  function views:GetActiveSuitEffectDescList()
    local suitActiveMap = data.currActiveSuitEffects
    local descList = {}
    for suitId, activeNum in pairs(suitActiveMap) do
      local suitConfig = DT.TrinketSuitEffect[suitId]
      local suitName = LT.Text(suitConfig.Name)
      local titleDesc = string.format("<TrinketSuitOn:%s (%s)>", suitName, activeNum)
      local tmp = {}
      for targetNum = 1, 6 do
        local descKey = string.format("SuitEffectDesc_%s", targetNum)
        local desc = suitConfig[descKey] and LT.Text(suitConfig[descKey])
        if desc then
          local suitActiveNum = targetNum
          local suitNumKey = string.format("SuitEffectNum_%s", targetNum)
          if suitConfig[suitNumKey] then
            suitActiveNum = suitConfig[suitNumKey]
          end
          if activeNum >= suitActiveNum then
            desc = LT.Textf("TrinketSuitEffect", suitActiveNum, desc)
            desc = string.format("<TrinketSuitOn:%s>", desc)
            local tmpData = {activeNum = suitActiveNum, desc = desc}
            tableInsert(tmp, tmpData)
          end
        end
      end
      tableSort(tmp, function(a, b)
        return a.activeNum < b.activeNum
      end)
      if #tmp > 0 then
        local descData = {
          suitEffectTitle = LT.Text(titleDesc),
          effectDescList = tmp,
          suitId = suitId,
          activeNum = activeNum
        }
        tableInsert(descList, descData)
      end
    end
    tableSort(descList, function(a, b)
      return #a.effectDescList > #b.effectDescList
    end)
    return descList
  end
  
  function views:GetTrinketDataByUid(uid)
    if not uid then
      return
    end
    if 0 == uid then
      return {}
    end
    do return ItemDataUtils.GetItemByUid end
    return ItemDataUtils.GetItemByUid, uid
  end
  
  function views:GetLevel(uid)
    if 0 == uid then
      return 0
    end
    local itemData = self:GetTrinketDataByUid(uid)
    if not itemData then
      Logger.Debug("找不到数据:", uid)
      return 0
    end
    local itemType = ItemDataUtils.GetItemType(itemData.tid)
    if itemType ~= ItemType.Trinket and itemType ~= ItemType.Weapon then
      return 0
    end
    return itemData.level
  end
  
  function views:GetItemType(tid)
    do return ItemDataUtils.GetItemType end
    return ItemDataUtils.GetItemType, tid
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
  
  function views:GetTrinketIcon(tid)
    if 0 == tid then
      return ""
    end
    do return ItemDataUtils.GetItemIcon end
    return ItemDataUtils.GetItemIcon, tid
  end
  
  function views:GetTrinketName(tid, withPosName)
    if 0 == tid then
      return ""
    end
    local name = ItemDataUtils.GetItemName(tid)
    if withPosName then
      local trinketInfo = ItemDataUtils.GetTrinketInfoByItemTid(tid)
      local pos = trinketInfo[1]
      name = string.format("%s · %s", name, pos)
    end
    return name
  end
  
  function views:GetMainAttr(uid)
    if not uid or 0 == uid then
      return {}
    end
    local mainAttr = AwakerTrinketDataUtils.GetMainAttr(uid)
    local attr = AwakerTrinketDataUtils.TrinketAttrToClientAttr(mainAttr)
    return attr
  end
  
  function views:GetSubAttrs(uid)
    if not uid or 0 == uid then
      return {}
    end
    local attrs = AwakerTrinketDataUtils.GetSubAttrs(uid)
    if not attrs then
      return {}
    end
    local subAttrs = {}
    for i = 1, #attrs do
      local subAttr = AwakerTrinketDataUtils.TrinketAttrToClientAttr(attrs[i])
      tableInsert(subAttrs, subAttr)
    end
    return subAttrs
  end
  
  function views:GetSubAttrMaxValue(tid)
    do return AwakerTrinketDataUtils.GetTrinketSubAttrMaxValue end
    return AwakerTrinketDataUtils.GetTrinketSubAttrMaxValue, tid
  end
  
  function views:GetSuitDescData(tid, activeNum, showActiveEffect)
    do return AwakerTrinketDataUtils.GetSuitDescData, tid, activeNum end
    return AwakerTrinketDataUtils.GetSuitDescData, tid, activeNum, showActiveEffect
  end
  
  function views:GetSuitActiveEffectNum(tid)
    if 0 == tid then
      return 0
    end
    local suitActiveMap = data.currActiveSuitEffects
    if not suitActiveMap or table.next(suitActiveMap) == nil then
      return 0
    end
    return suitActiveMap[tid] or 0
  end
  
  function views:GetTrinketStory(tid)
    if not tid or 0 == tid then
      return ""
    end
    do return ItemDataUtils.GetItemStory end
    return ItemDataUtils.GetItemStory, tid
  end
  
  function views:GetOwner(uid)
    if 0 == uid then
      return 0
    end
    do return ItemDataUtils.GetItemOwner end
    return ItemDataUtils.GetItemOwner, uid
  end
  
  function views:GetAwakerSmallIcon(tid)
    if not tid or 0 == tid then
      return ""
    end
    do return AwakerDataUtils.GetLittleIcon end
    return AwakerDataUtils.GetLittleIcon, tid
  end
  
  function views:GetCircleHeadIcon(tid)
    do return AwakerDataUtils.GetCircleHeadIcon end
    return AwakerDataUtils.GetCircleHeadIcon, tid
  end
  
  function views:GetAwakerName(tid)
    do return AwakerDataUtils.GetAwakerName end
    return AwakerDataUtils.GetAwakerName, tid
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
  
  function views:GetAwakerCircleHeadIcon(tid)
    local icon = AwakerDataUtils.GetCircleHeadIcon(tid)
    return icon
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
  
  function views:GetItemOwner(uid)
    do return ItemDataUtils.GetItemOwner end
    return ItemDataUtils.GetItemOwner, uid
  end
  
  function views:GetDataByUid(uid)
    if not uid then
      Logger.Error("Error Parameter: nil")
      return
    end
    if data.itemDataMap then
      return data.itemDataMap[uid]
    end
    do return ItemDataUtils.GetItemByUid end
    return ItemDataUtils.GetItemByUid, uid
  end
  
  function views:GetItemLocked(uid)
    if 0 == uid then
      return 0
    end
    do return ItemDataUtils.GetItemLocked end
    return ItemDataUtils.GetItemLocked, uid
  end
  
  function views:GetIcon(tid)
    if not tid then
      Logger.Error("Error Parameter: nil")
      return
    end
    do return ItemDataUtils.GetIcon end
    return ItemDataUtils.GetIcon, tid
  end
  
  function views:GetItemQualityImage(tid)
    do return ItemDataUtils.GetQualityFramePath end
    return ItemDataUtils.GetQualityFramePath, tid
  end
  
  function views:GetItemSubTypeName(tid)
    do return ItemDataUtils.GetItemSubTypeName end
    return ItemDataUtils.GetItemSubTypeName, tid
  end
  
  function views:IsSuitFilter(suitId)
    return data.filterSuitsMap[suitId] ~= TrinketFilterState.FilterExclude
  end
  
  function views:IsPartFilter(part)
    return data.filterParts[part] ~= TrinketFilterState.FilterExclude
  end
  
  function views:IsMainAttrFilter(attrId)
    return data.filterMainAttrs[attrId] ~= TrinketFilterState.FilterExclude
  end
  
  function views:IsSubAttrsFilter(subAttrs)
    local isAllDefault = true
    for k, v in pairs(data.filterSubAttrs) do
      if v ~= TrinketFilterState.FilterDefault then
        isAllDefault = false
      end
    end
    if isAllDefault then
      return true
    end
    for k, v in pairs(data.filterSubAttrs) do
      if v == TrinketFilterState.FilterExclude then
        for i = 1, #subAttrs do
          if subAttrs[i].attrId == k then
            return false
          end
        end
      end
    end
    local hitedFilterInclude = false
    for k, v in pairs(data.filterSubAttrs) do
      if v == TrinketFilterState.FilterInclude then
        hitedFilterInclude = true
        if 0 == #subAttrs then
          return false
        end
        for i = 1, #subAttrs do
          if subAttrs[i].attrId == k then
            return true
          end
        end
      end
    end
    if hitedFilterInclude then
      return false
    end
    return true
  end
  
  return views
end

local function createAwakerTrinketModellActions(data)
  local actions = {}
  
  function actions:SetSelectPos(posVal)
    local pos = 0
    if type(posVal) == "string" then
      pos = ItemDataUtils.TrinketPosMap[posVal]
    elseif type(posVal) == "number" then
      pos = posVal
    end
    for k, v in pairs(data.filterParts) do
      data.filterParts[k] = false
    end
    data.filterParts[pos] = true
    self:SetLastEquipUid(0)
    data.selectPos = pos
    self:UpdateTrinketShowList()
  end
  
  function actions:UpdateTrinketShowList()
    local selectPos = data.selectPos
    local curPage = data.awakerModel.page
    local showTrinketListPage = curPage == AwakerPage.TrinketChange or curPage == AwakerPage.TrinketStrengthen
    if not selectPos or 0 == selectPos or not showTrinketListPage then
      return {}
    end
    data.trinketShowList = self:GetPosList(selectPos)
  end
  
  function actions:SetLastEquipUid(uid)
    data.lastEquipUid = uid
  end
  
  function actions:SetSelectTrinketUid(uid)
    data.selectTrinketUid = uid or 0
  end
  
  function actions:AddTrinketToShowList(addList)
    if not addList then
      return
    end
    for _, trinket in ipairs(addList) do
      tableInsert(data.trinketShowList, trinket)
    end
  end
  
  function actions:SetCompareMode(state)
    if nil == state then
      state = false
    end
    data.compareMode = state
  end
  
  function actions:SetMaskCompareButton(state)
    if nil == state then
      state = false
    end
    data.maskCompareButton = state
  end
  
  function actions:SetSortType(sortType)
    if not sortType then
      return
    end
    data.sortType = sortType
    self:SetLastEquipUid(0)
    self:UpdateTrinketShowList()
  end
  
  function actions:SetSortOrder(order)
    if order then
      self:SetLastEquipUid(0)
      data.sortOrder = order
      self:UpdateTrinketShowList()
      return
    end
    local new = CommonDefine.SortOrder.Descend
    if new == data.sortOrder then
      new = CommonDefine.SortOrder.Ascend
    end
    data.sortOrder = new
    self:SetLastEquipUid(0)
    self:UpdateTrinketShowList()
  end
  
  function actions:SetSortTypeShow(show)
    if nil == show then
      show = false
    end
    data.sortTypeShow = show
  end
  
  function actions:EquipRecommendTrinket(awakerTid)
    EventMgr.Instance.OpenReqMask:Dispatch()
    ProtoManager.Instance:ReqServer("TrinketRequest", "OnRecommendTrinket", function()
      RedPointDataUtils.UpdateAwakerRed()
    end, function()
    end, awakerTid)
  end
  
  function actions:TakeOffAllTrinkets(awakerTid)
    EventMgr.Instance.OpenReqMask:Dispatch()
    ProtoManager.Instance:ReqServer("TrinketRequest", "OnTakeoffAllTrinket", function()
      RedPointDataUtils.UpdateAwakerRed()
    end, function()
    end, awakerTid)
  end
  
  function actions:ReqItemLock(uid, state)
    if not uid or 0 == uid then
      return
    end
    EventMgr.Instance.OpenReqMask:Dispatch()
    local protoName = state and "OnLockItem" or "OnUnlockItem"
    ProtoManager.Instance:ReqServer("GameRequest", protoName, function(lockState)
      local trinket = data:GetTrinketDataByUid(uid)
      if trinket then
        trinket.locked = lockState
      end
    end, function()
    end, uid)
  end
  
  function actions:ReqPutOnTrinket(awakerTid, uid, cb)
    if not awakerTid or not uid then
      return
    end
    local trinketData = data:GetTrinketDataByUid(uid)
    if not trinketData then
      Logger.Info("找不到饰品:", uid)
      return
    end
    local pos = AwakerTrinketDataUtils.GetTrinketPos(trinketData.tid)
    local posIndex = pos and ItemDataUtils.TrinketPosMap[pos] or nil
    local awakerData = AwakerDataUtils.GetAwakerData(awakerTid)
    local oldTrinketId
    if posIndex then
      oldTrinketId = awakerData.trinkets and awakerData.trinkets[posIndex] or nil
    end
    local trinketOldData
    if oldTrinketId then
      trinketOldData = data:GetTrinketDataByUid(oldTrinketId)
    end
    
    local function ReqPutOnTrinket()
      EventMgr.Instance.OpenReqMask:Dispatch()
      ProtoManager.Instance:ReqServer("TrinketRequest", "OnPutOnTrinket", function(svrData)
        Logger.Info(">>>>>> 穿戴/更换饰品请求成功:", table.tostring(svrData))
        if trinketOldData then
          trinketOldData.awaker = trinketData.awaker
        end
        trinketData.awaker = awakerTid
        RedPointDataUtils.UpdateAwakerRed()
        if cb then
          cb(svrData)
        end
      end, function(svrData)
        Logger.Info(">>>>>> 穿戴/更换饰品请求失败:", table.tostring(svrData))
      end, awakerTid, uid)
    end
    
    if trinketData.awaker and trinketData.awaker > 0 then
      local awakerTitle = data.awakerModel:GetAwakerTitle(trinketData.awaker)
      local itemName = data:GetTrinketName(trinketData.tid)
      local desc = LT.Textf(DT.TipsType[20049].Desc, itemName, awakerTitle)
      Alert.Show(20049, nil, ReqPutOnTrinket, nil, desc)
      return
    end
    ReqPutOnTrinket()
  end
  
  function actions:ReqPutOffTrinket(uid, cb)
    if not uid or 0 == uid then
      return
    end
    local trinketData = data:GetTrinketDataByUid(uid)
    if not trinketData then
      Logger.Info("找不到饰品:", uid)
      return
    end
    EventMgr.Instance.OpenReqMask:Dispatch()
    ProtoManager.Instance:ReqServer("TrinketRequest", "OnTakeoffTrinket", function(svrData)
      Logger.Info(">>>>>> 卸下饰品请求成功:", table.tostring(svrData))
      trinketData.awaker = 0
      data:SetLastEquipUid(uid)
      RedPointDataUtils.UpdateAwakerRed()
      if cb then
        cb(svrData)
      end
    end, function(svrData)
      Logger.Info(">>>>>> 卸下饰品请求失败:", table.tostring(svrData))
    end, uid)
  end
  
  function actions:SetDefaultChosenTrinket()
    local equippedTrinketUid = data.equippedTrinketUid
    local list = data.trinketShowList
    if equippedTrinketUid > 0 then
      self:SetSelectTrinketUid(equippedTrinketUid)
    else
      self:SetSelectTrinketUid(list[1])
      self:ReqRemoveNew(list[1])
    end
  end
  
  function actions:ReqRemoveNew(uid)
    local isNew = data:IsItemNew(uid)
    if not isNew then
      return
    end
    RedPointDataUtils.ReqRemoveData(RedPointDataUtils.RedType.Item, RedPointDataUtils.RedAttrType.IsNew, uid)
  end
  
  function actions:SetFilterShow(show)
    if nil == show then
      show = false
    end
    data.filterShow = show
  end
  
  function actions:SetSuitsFilter(suits)
    table.clear(data.filterSuitsMap)
    for k, v in pairs(suits) do
      data.filterSuitsMap[k] = v
    end
    self:HandleFiltersSelected(data.filterSuitsMap)
  end
  
  function actions:SetMainAttrsFilter(mainAttrs)
    table.clear(data.filterMainAttrs)
    for k, v in pairs(mainAttrs) do
      data.filterMainAttrs[k] = v
    end
    self:HandleFiltersSelected(data.filterMainAttrs)
  end
  
  function actions:SetSubAttrsFilter(subAttrs)
    table.clear(data.filterSubAttrs)
    for k, v in pairs(subAttrs) do
      data.filterSubAttrs[k] = v
    end
    self:HandleSubAttrFiltersSelected(data.filterSubAttrs)
  end
  
  function actions:SetPartsFilter(filterParts)
    table.clear(data.filterParts)
    for k, v in pairs(filterParts) do
      data.filterParts[k] = v
    end
    self:HandleFiltersSelected(data.filterParts)
  end
  
  function actions:CancelSuit(suitId)
    data.filterSuitsMap[suitId] = TrinketFilterState.FilterExclude
    self:HandleFiltersSelected(data.filterSuitsMap)
  end
  
  function actions:CancelMainAttr(attrId)
    data.filterMainAttrs[attrId] = TrinketFilterState.FilterExclude
    self:HandleFiltersSelected(data.filterMainAttrs)
  end
  
  function actions:CancelSubAttr(attrId)
    data.filterSubAttrs[attrId] = TrinketFilterState.FilterDefault
    self:HandleSubAttrFiltersSelected(data.filterSubAttrs)
  end
  
  function actions:SetPartFilter(part, state)
    data.filterParts[part] = state
    self:HandleFiltersSelected(data.filterParts)
  end
  
  function actions:ResetFilters()
    table.clear(data.filterMainAttrs)
    table.clear(data.filterSubAttrs)
    table.clear(data.filterParts)
    table.clear(data.filterSuitsMap)
    local suits = data.filterSuits
    for i = 1, #suits do
      data.filterSuitsMap[suits[i]] = TrinketFilterState.FilterDefault
    end
    for i = 1, CommonDefine.MaxEquipTrinketsNum do
      data.filterParts[i] = TrinketFilterState.FilterDefault
    end
    local showAttrIds = AwakerDataUtils.GetSortedAttrIds(CommonDefine.AttrShowType.TrinketShow)
    for i = 1, #showAttrIds do
      data.filterMainAttrs[showAttrIds[i]] = TrinketFilterState.FilterDefault
      data.filterSubAttrs[showAttrIds[i]] = TrinketFilterState.FilterDefault
    end
  end
  
  function actions:HandleFiltersSelected(filters)
    local existedInclude
    for k, v in pairs(filters) do
      if v == TrinketFilterState.FilterInclude then
        existedInclude = true
        break
      end
    end
    if not existedInclude then
      for k, v in pairs(filters) do
        filters[k] = TrinketFilterState.FilterDefault
      end
    else
      for k, v in pairs(filters) do
        if v ~= TrinketFilterState.FilterInclude then
          filters[k] = TrinketFilterState.FilterExclude
        end
      end
    end
  end
  
  function actions:HandleSubAttrFiltersSelected(filters)
    local isAllExclude = true
    for k, v in pairs(filters) do
      if v ~= TrinketFilterState.FilterExclude then
        isAllExclude = false
        break
      end
    end
    if isAllExclude then
      for k, v in pairs(filters) do
        filters[k] = TrinketFilterState.FilterDefault
      end
    end
  end
  
  return actions
end

local function onSetup(binder, model)
  model:UpdateTrinketShowList()
  binder:BindToRaw(function(_, n)
    if not n or 0 == n then
      return
    end
  end, function()
    return model.selectPos
  end)
  binder:BindToRaw(function(_, n, _)
    if not n then
      return
    end
    if n <= 0 then
      model:SetCompareMode(false)
    end
  end, function()
    if not model or not model.equippedTrinketUid then
      return 0
    end
    return model.equippedTrinketUid
  end)
  binder:BindToRaw(function(_, n, _)
    if not n then
      return
    end
    if n ~= AwakerPage.Trinket then
      model:SetCompareMode(false)
      model:SetSortTypeShow(false)
    end
    model:UpdateTrinketShowList()
  end, function()
    return model.awakerModel.page
  end)
end

local AwakerTrinketModel = Vue.model("AwakerTrinketModel", createAwakerTrinketModellState):views(createAwakerTrinketModellViews):actions(createAwakerTrinketModellActions):setup(onSetup)
return AwakerTrinketModel
