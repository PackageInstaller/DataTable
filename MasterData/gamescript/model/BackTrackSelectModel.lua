local function modelState(itemId)
  local state = {}
  
  state.curTab = CommonDefine.BackTrackType.NormalAwaker
  state.itemId = itemId
  
  function state.awakerList()
    local list = {}
    if state.curTab == CommonDefine.BackTrackType.Weapon then
      return {}
    end
    local normalAwakerList = DT.GetOriginalConstant("BacktrackItemAwakers")
    local freeBackAwakerList = BackTrackDataUtils.GetFreeBackAwakerList()
    local collectNoraml = state.curTab == CommonDefine.BackTrackType.NormalAwaker
    local awakerMap = AwakerDataUtils.GetAwakerDataMap()
    for awakerId, awakerData in pairs(awakerMap) do
      if not AwakerDataUtils.HasOwnedAwaker(awakerId) then
      elseif BackTrackDataUtils.IsAwakerOpen(awakerId) then
      elseif table.contains(freeBackAwakerList, awakerId) then
      else
        local isNormalAwaker = table.contains(normalAwakerList, awakerId)
        if collectNoraml and isNormalAwaker then
          table.insert(list, awakerData)
        elseif not collectNoraml and not isNormalAwaker then
          table.insert(list, awakerData)
        end
      end
    end
    local defaultOrder = CommonDefine.SortOrder.Descend
    table.sort(list, function(a, b)
      local schoolSortA = AwakerDataUtils.GetSchoolSortValue(a.tid)
      local schoolSortB = AwakerDataUtils.GetSchoolSortValue(b.tid)
      if schoolSortA == schoolSortB then
        local potencySortA = a.potencyLevel
        local potencySortB = b.potencyLevel
        if potencySortA == potencySortB then
          local levelSortA = a.level
          local levelSortB = b.level
          if levelSortA == levelSortB then
            local default = 1
            local qualitySortA = AwakerDataUtils.GetQualitySort(a.tid) or default
            local qualitySortB = AwakerDataUtils.GetQualitySort(b.tid) or default
            if qualitySortA == qualitySortB then
              local aSortId = AwakerDataUtils.GetAwakerSortId(a.tid)
              local bSortId = AwakerDataUtils.GetAwakerSortId(b.tid)
              do return AwakerDataUtils.Compare, aSortId, bSortId end
              return AwakerDataUtils.Compare, aSortId, bSortId, CommonDefine.SortOrder.Ascend
            else
              do return AwakerDataUtils.Compare, qualitySortA, qualitySortB end
              return AwakerDataUtils.Compare, qualitySortA, qualitySortB, defaultOrder, bSortId, CommonDefine.SortOrder.Ascend
            end
          else
            do return AwakerDataUtils.Compare, levelSortA, levelSortB end
            return AwakerDataUtils.Compare, levelSortA, levelSortB, defaultOrder, qualitySortA, qualitySortB, defaultOrder, bSortId, CommonDefine.SortOrder.Ascend
          end
        else
          do return AwakerDataUtils.Compare, potencySortA, potencySortB end
          return AwakerDataUtils.Compare, potencySortA, potencySortB, defaultOrder, levelSortB, defaultOrder, qualitySortA, qualitySortB, defaultOrder, bSortId, CommonDefine.SortOrder.Ascend
        end
      else
        do return AwakerDataUtils.Compare, schoolSortA, schoolSortB end
        return AwakerDataUtils.Compare, schoolSortA, schoolSortB, CommonDefine.SortOrder.Ascend, potencySortB, defaultOrder, levelSortB, defaultOrder, qualitySortA, qualitySortB, defaultOrder, bSortId, CommonDefine.SortOrder.Ascend
      end
    end)
    return list
  end
  
  function state.weaponList()
    local list = {}
    local BacktrackItemWeaponsList = DT.GetOriginalConstant("BacktrackItemWeapons")
    for _, weaponId in ipairs(BacktrackItemWeaponsList) do
      local uidMap = ItemDataUtils.GetItemUidMap(weaponId)
      if uidMap then
        local weaponItem
        for uid, _ in pairs(uidMap) do
          local tempItem = ItemDataUtils.GetItemByUid(uid)
          if nil == weaponItem then
            weaponItem = tempItem
          elseif tempItem.level > weaponItem.level then
            weaponItem = tempItem
          end
        end
        if weaponItem and not BackTrackDataUtils.IsWeaponOpen(weaponId, weaponItem.uid) then
          table.insert(list, weaponItem)
        end
      end
    end
    local defaultOrder = CommonDefine.SortOrder.Descend
    table.sort(list, function(a, b)
      do return AwakerTrinketDataUtils.SortByLevel, a, b end
      return AwakerTrinketDataUtils.SortByLevel, a, b, defaultOrder
    end)
    return list
  end
  
  return state
end

local function modelView(data)
  local view = {}
  
  function view:GetCurTab()
    return self.curTab
  end
  
  function view:GetCurAwakerId()
    return self.awakerId
  end
  
  function view:GetCurWeaponUid()
    return self.weaponUid
  end
  
  function view:GetCurWeaponTid()
    return self.weaponTid
  end
  
  function view:GetChooseTid()
    if data.curTab == CommonDefine.BackTrackType.NormalAwaker or data.curTab == CommonDefine.BackTrackType.UniqueAwaker then
      do return self.GetCurAwakerId end
      return self.GetCurAwakerId, self
    else
      do return self.GetCurWeaponUid end
      return self.GetCurWeaponUid, self
    end
  end
  
  return view
end

local function modelAction(data)
  local action = {}
  
  function action:SetCurTab(tab)
    data.curTab = tab
  end
  
  function action:SetCurAwakerId(awakerId)
    data.awakerId = awakerId
  end
  
  function action:SetCurWeaponUid(uid)
    data.weaponUid = uid
  end
  
  function action:SetCurWeaponTid(tid)
    data.weaponTid = tid
  end
  
  return action
end

local function onSetup(_, _)
end

do return Vue.model("BackTrackSelectModel", modelState):views(modelView):actions(modelAction).setup, (Vue.model("BackTrackSelectModel", modelState):views(modelView):actions(modelAction)) end
return Vue.model("BackTrackSelectModel", modelState):views(modelView):actions(modelAction).setup, Vue.model("BackTrackSelectModel", modelState):views(modelView):actions(modelAction), onSetup
