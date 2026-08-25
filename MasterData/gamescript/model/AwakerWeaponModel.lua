local AwakerPage = CommonDefine.AwakerPage

local function createAwakerModelState(awakerModel, primaryWeaponSlotModel, secondaryWeaponSlotModel, refineSuccessCallback)
  local state = {}
  state.currSelectedWeaponSlotType = CommonDefine.WeaponSlotType.Primary
  state.page = CommonDefine.AwakerWeaponPage.View
  state.sortType = CommonDefine.AwakerWeaponSortType.Quality
  state.sortOrder = CommonDefine.SortOrder.Descend
  state.sortTypeShow = false
  if refineSuccessCallback then
    function state.refineSuccessCallback()
      return refineSuccessCallback
    end
  end
  state.awakerModel = awakerModel
  state.primaryWeaponSlotModel = primaryWeaponSlotModel
  state.secondaryWeaponSlotModel = secondaryWeaponSlotModel
  
  function state.awakerTid()
    return awakerModel.selectAwakerId
  end
  
  state.showTipUid = 0
  
  function state.weaponConfig()
    if state.awakerModel:HasOwnedAwaker(state.awakerTid) then
      local awaker = state.awakerModel:GetAwakerData(state.awakerTid)
      do return AwakerDataUtils.GetWeaponConfig, awaker end
      return AwakerDataUtils.GetWeaponConfig, awaker, state.currSelectedWeaponSlotType
    end
  end
  
  function state.weapon()
    local dummyWeapon = CommonDefine.DummyWeapon.Weapon
    if state.awakerModel:HasOwnedAwaker(state.awakerTid) then
      local awaker = state.awakerModel:GetAwakerData(state.awakerTid)
      return AwakerDataUtils.GetWeapon(awaker, state.currSelectedWeaponSlotType) or dummyWeapon
    else
      return dummyWeapon
    end
  end
  
  local function _GetUnselectedSlotType()
    if state.currSelectedWeaponSlotType == CommonDefine.WeaponSlotType.Primary then
      return CommonDefine.WeaponSlotType.Secondary
    elseif state.currSelectedWeaponSlotType == CommonDefine.WeaponSlotType.Secondary then
      return CommonDefine.WeaponSlotType.Primary
    end
  end
  
  function state.weaponList()
    local list = {}
    local lockedList = {}
    for _, v in pairs(DataCenter.itemData.BagItemData) do
      local config = ItemDataUtils.GetItemConfig(v.tid)
      if config.Type == CommonDefine.ItemType.Weapon then
        if state.awakerModel.page == AwakerPage.WeaponRefine then
          if v.locked then
            table.insert(lockedList, v)
          else
            table.insert(list, v)
          end
        else
          table.insert(list, v)
        end
      end
    end
    if state.awakerModel.page == AwakerPage.WeaponChange then
      local awakerTid = state.awakerModel.selectAwakerId
      local awaker = state.awakerModel:GetAwakerData(awakerTid)
      local unselectedSlotType = _GetUnselectedSlotType()
      local unselectedSlot = AwakerDataUtils.GetWeaponSlotDataWithType(awaker, unselectedSlotType)
      if not unselectedSlot.unlocked or 0 == unselectedSlot.weaponUid then
        list = AwakerTrinketDataUtils.WeaponSort(list, state.sortType, state.sortOrder)
      else
        list = AwakerTrinketDataUtils.WeaponSortForWeaponChange(list, state.sortType, state.sortOrder, unselectedSlot.weaponUid)
      end
    else
      list = AwakerTrinketDataUtils.WeaponSort(list, state.sortType, state.sortOrder)
      lockedList = AwakerTrinketDataUtils.WeaponSort(lockedList, state.sortType, state.sortOrder)
      for _, v in ipairs(lockedList) do
        table.insert(list, v)
      end
    end
    return list
  end
  
  state.changeWeaponList = state.weaponList
  
  function state.refineMaterialList()
    if state.selectedChangeWeaponUid == nil then
      return {}
    end
    local selectedWeapon = ItemDataUtils.GetItemByUid(state.selectedChangeWeaponUid)
    if not selectedWeapon then
      return {}
    end
    local list = {}
    for _, v in ipairs(state.weaponList) do
      if (nil == v.awaker or 0 == v.awaker) and v.uid ~= state.selectedChangeWeaponUid and v.tid == selectedWeapon.tid then
        table.insert(list, v)
      end
    end
    return list
  end
  
  function state.sortTypeList()
    do return end
    return AwakerTrinketDataUtils.GetWeaponSortDataTable, nil
  end
  
  state.selectedCostItemGroup = {}
  
  function state.curSelectItemNum()
    local rst = 0
    for _, selectItem in pairs(state.selectedCostItemGroup) do
      rst = rst + selectItem.num
    end
    return rst
  end
  
  state.selectedChangeWeaponUid = nil
  state.selectedRefineMaterialUid = nil
  state.contrastOn = false
  return state
end

local function createAwakerModelViews(data)
  local views = {}
  
  function views:GetCurrSelectedWeaponSlotType()
    return self.currSelectedWeaponSlotType
  end
  
  function views:GetWeaponList()
    if self.awakerModel.page == AwakerPage.WeaponRefine then
      return self.refineMaterialList or {}
    elseif self.awakerModel.page == AwakerPage.WeaponChange then
      return self.changeWeaponList or {}
    else
      return {}
    end
  end
  
  function views:GetWeaponlevel()
    return self.weapon.level
  end
  
  function views:GetCurrDisplayWeaponMtrlList()
    local rst = {}
    if self.currDisplayWeaponUid == nil then
      return rst
    end
    local selectedWeapon = ItemDataUtils.GetItemByUid(self.currDisplayWeaponUid)
    if not selectedWeapon then
      return rst
    end
    for _, v in ipairs(self.weaponList) do
      if (nil == v.awaker or 0 == v.awaker) and v.uid ~= self.currDisplayWeaponUid and v.tid == selectedWeapon.tid then
        table.insert(rst, v)
      end
    end
    local weaponQuality = DT.Item[selectedWeapon.tid].Quality
    local weaponLevelUpCostItemGroup = DT.GetOriginalConstant("Weapon_LeveUp_CommonMaterial")
    for _, itemTid in pairs(weaponLevelUpCostItemGroup) do
      local itemCfg = DT.Item[itemTid]
      local itemData = ItemDataUtils.GetItemByTid(itemTid)
      if weaponQuality == itemCfg.Quality and itemData then
        table.insert(rst, itemData)
      end
    end
    table.sort(rst, function(a, b)
      local aCfg = DT.Item[a.tid]
      local bCfg = DT.Item[b.tid]
      if aCfg.Type ~= bCfg.Type then
        return aCfg.Type == "Weapon"
      end
      if not a.locked and b.locked then
        return true
      end
      if not b.locked and a.locked then
        return false
      end
      local aRefineLevel = a.level or 0
      local bRefineLevel = b.level or 0
      return aRefineLevel < bRefineLevel
    end)
    return rst
  end
  
  function views:GetButtonState()
    if self.awakerModel.page == AwakerPage.Weapon or self.awakerModel.page == AwakerPage.WeaponEnhance then
      return CommonDefine.WeaponBtnState.ShowNone
    end
    if 0 == self.weapon.tid then
      return CommonDefine.WeaponBtnState.ShowEquip
    end
    if self.awakerModel.page == AwakerPage.WeaponChange then
      if self.selectedChangeWeaponUid == self.weapon.uid then
        return CommonDefine.WeaponBtnState.ShowUnequip
      else
        return CommonDefine.WeaponBtnState.ShowChange
      end
    end
    return CommonDefine.WeaponBtnState.ShowNone
  end
  
  function views:GetSelectedChangeWeapon()
    do return ItemDataUtils.GetItemByUid end
    return ItemDataUtils.GetItemByUid, self.selectedChangeWeaponUid
  end
  
  function views:GetRightWeaponUid()
    local rightWeaponUid = self.selectedChangeWeaponUid
    if self.awakerModel.page == AwakerPage.Weapon then
      rightWeaponUid = self.weapon.uid
    end
    return rightWeaponUid
  end
  
  function views:GetWeaponSortTypeName(sortType)
    do return AwakerTrinketDataUtils.GetWeaponSortTypeName end
    return AwakerTrinketDataUtils.GetWeaponSortTypeName, sortType
  end
  
  function views:IsContrastVisible()
    if self.awakerModel.page ~= AwakerPage.WeaponChange then
      return false
    end
    local rightWeapon = self:GetRightWeaponUid()
    return rightWeapon ~= self.weapon.uid
  end
  
  function views:IsRightWeaponEquiped()
    local rightWeapon = self:GetRightWeaponUid()
    return rightWeapon == self.weapon.uid
  end
  
  function views:GetContrastText()
    return self.contrastOn and LT.Text("收起") or LT.Text("对比")
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
  
  function views:GetDropdownData(itemClickCallback, onOrderTypeClick)
    local dropdownList = {}
    for index, sortType in ipairs(self.sortTypeList) do
      local data = {
        text = self:GetSortTypeName(sortType),
        index = index
      }
      table.insert(dropdownList, data)
    end
    return dropdownList
  end
  
  function views:GetSelectedRefineMaterialUid()
    return self.selectedRefineMaterialUid
  end
  
  function views:HasOwner()
    return self.weapon.awaker ~= nil and 0 ~= self.weapon.awaker
  end
  
  function views:GetAwakerIcon()
    if self.weapon.awaker == nil or 0 == self.weapon.awaker then
      return ""
    end
    local awakerId = self.weapon.awaker
    if not AwakerDataUtils.IsAwakerShow(awakerId) then
      awakerId = AwakerDataUtils.GetChangerForm(awakerId)
    end
    do return AwakerDataUtils.GetLittleIcon end
    return AwakerDataUtils.GetLittleIcon, self.weapon.awaker
  end
  
  function views:GetSelectedChangeWeaponByUid(uid)
    for _, itemData in pairs(data.selectedCostItemGroup) do
      if itemData.uid == uid then
        return itemData
      end
    end
    return nil
  end
  
  return views
end

local function createAwakerModelActions(data)
  local actions = {}
  
  function actions:SelectWeaponSlot(slotType)
    data.currSelectedWeaponSlotType = slotType
  end
  
  function actions:SetPage(page)
    data.page = page
  end
  
  function actions:SetSortType(sortType)
    data.sortType = sortType
  end
  
  function actions:SetSortOrder(order)
    if order then
      data.sortOrder = order
      return
    end
    local new = CommonDefine.SortOrder.Descend
    if new == data.sortOrder then
      new = CommonDefine.SortOrder.Ascend
    end
    data.sortOrder = new
  end
  
  function actions:SetSortTypeShow(sortTypeShow)
    if nil == sortTypeShow then
      sortTypeShow = false
    end
    data.sortTypeShow = sortTypeShow
  end
  
  function actions:SetSelectedChangeWeaponUid(weaponUid)
    data.selectedChangeWeaponUid = weaponUid
  end
  
  function actions:SetSelectedRefineMaterialUid(weaponUid)
    data.selectedRefineMaterialUid = weaponUid
  end
  
  function actions:SetShowTipUid(uid)
    if not uid then
      return
    end
    data.showTipUid = uid
  end
  
  function actions:ToggleContrast()
    data.contrastOn = not data.contrastOn
  end
  
  function actions:EquipRecommendWeapon()
    local awaker = data.awakerModel:GetAwakerData(data.awakerTid)
    local weaponSlotTypes = {
      CommonDefine.WeaponSlotType.Primary,
      CommonDefine.WeaponSlotType.Secondary
    }
    local emptySlotTypes = {}
    local equipedWeaponCfgs = {}
    for _, slotType in ipairs(weaponSlotTypes) do
      local slot = AwakerDataUtils.GetWeaponSlotDataWithType(awaker, slotType)
      if slot.unlocked then
        if 0 == slot.weaponUid then
          table.insert(emptySlotTypes, slotType)
        else
          local weapon = ItemDataUtils.GetItemByUid(slot.weaponUid)
          table.insert(equipedWeaponCfgs, DT.Item[weapon.tid])
        end
      end
    end
    if #emptySlotTypes > 0 then
      local result = {hasWeaponEquiped = false}
      data:_EquipRecommendWeapon(emptySlotTypes, 1, equipedWeaponCfgs, result, function()
        if result.hasWeaponEquiped then
          Alert.Show(10471)
        else
          Alert.Show(10636)
        end
      end)
    end
  end
  
  function actions:_EquipRecommendWeapon(emptySlotTypes, index, equipedWeaponCfgs, result, finishCallback)
    local awakerCfg = DT.AwakerConfig[data.awakerTid]
    for _, tid in ipairs(awakerCfg.RecommendWeapon) do
      local recommendWeapons = {}
      data:_RetrieveFreeWeapons(tid, recommendWeapons)
      if #recommendWeapons > 0 then
        table.sort(recommendWeapons, function(a, b)
          return a.level > b.level
        end)
        local uid
        if 0 == #equipedWeaponCfgs then
          uid = recommendWeapons[1].uid
        else
          local weapon = recommendWeapons[1]
          local weaponCfg = DT.Item[weapon.tid]
          if data:_NotSameID(weaponCfg, equipedWeaponCfgs) then
            local ssrWeaponLimit = DT.GetConstant("SSRWeaponNumLimit")
            if ssrWeaponLimit > 1 or 1 == ssrWeaponLimit and data:_OnlyOneSSR(weaponCfg, equipedWeaponCfgs) then
              uid = weapon.uid
            end
          end
        end
        if uid then
          data:_ReqChangeWeapon(emptySlotTypes[index], uid, function()
            result.hasWeaponEquiped = true
            if index == #emptySlotTypes then
              finishCallback()
            else
              local weapon = ItemDataUtils.GetItemByUid(uid)
              table.insert(equipedWeaponCfgs, DT.Item[weapon.tid])
              data:_EquipRecommendWeapon(emptySlotTypes, index + 1, equipedWeaponCfgs, result, finishCallback)
            end
          end)
          return
        end
      end
    end
    for _, weapon in ipairs(data.weaponList) do
      if 0 == weapon.awaker then
        local uid
        if 0 == #equipedWeaponCfgs then
          uid = weapon.uid
        else
          local weaponCfg = DT.Item[weapon.tid]
          if data:_NotSameID(weaponCfg, equipedWeaponCfgs) then
            local ssrWeaponLimit = DT.GetConstant("SSRWeaponNumLimit")
            if ssrWeaponLimit > 1 or 1 == ssrWeaponLimit and data:_OnlyOneSSR(weaponCfg, equipedWeaponCfgs) then
              uid = weapon.uid
            end
          end
        end
        if uid then
          data:_ReqChangeWeapon(emptySlotTypes[index], uid, function()
            result.hasWeaponEquiped = true
            if index == #emptySlotTypes then
              finishCallback()
            else
              local weapon = ItemDataUtils.GetItemByUid(uid)
              table.insert(equipedWeaponCfgs, DT.Item[weapon.tid])
              data:_EquipRecommendWeapon(emptySlotTypes, index + 1, equipedWeaponCfgs, result, finishCallback)
            end
          end)
          return
        end
      end
    end
    if index == #emptySlotTypes then
      finishCallback()
    else
      data:_EquipRecommendWeapon(emptySlotTypes, index + 1, equipedWeaponCfgs, result, finishCallback)
    end
  end
  
  function actions:_NotSameID(weaponCfg, equipedWeaponCfgs)
    for _, cfg in ipairs(equipedWeaponCfgs) do
      if cfg.ID == weaponCfg.ID then
        return false
      end
    end
    return true
  end
  
  function actions:_OnlyOneSSR(weaponCfg, equipedWeaponCfgs)
    local hasEquipedSSR = false
    for _, cfg in ipairs(equipedWeaponCfgs) do
      if cfg.Quality == "Orange" then
        hasEquipedSSR = true
        break
      end
    end
    if hasEquipedSSR and weaponCfg.Quality == "Orange" then
      return false
    else
      return true
    end
  end
  
  function actions:_RetrieveFreeWeapons(tid, results)
    for _, weapon in ipairs(data.weaponList) do
      if weapon.tid == tid and (not weapon.awaker or 0 == weapon.awaker) then
        table.insert(results, weapon)
      end
    end
  end
  
  function actions:_RetrieveTheFirstFreeWeapon()
    for _, weapon in ipairs(data.weaponList) do
      if 0 == weapon.awaker then
        return weapon
      end
    end
  end
  
  function actions:ReqChangeWeapon(onChanged)
    data:_ReqChangeWeapon(self.currSelectedWeaponSlotType, self.selectedChangeWeaponUid, function()
      if data.contrastOn then
        self:ToggleContrast()
      end
      if onChanged then
        onChanged()
      end
    end)
  end
  
  function actions:_ReqChangeWeapon(slotType, weaponUid, callback)
    ProtoManager.Instance:ReqServer("GameRequest", "OnPutOnWeapon", function()
      local awaker = data.awakerModel:GetAwakerData(data.awakerTid)
      local weaponSlot = AwakerDataUtils.GetWeaponSlotDataWithType(awaker, slotType)
      weaponSlot.weaponUid = weaponUid
      AudioManager.Instance:PostSoundEvent("Play_UI_Ani_L_IngCard")
      if callback then
        callback()
      end
    end, function()
    end, data.awakerTid, slotType, weaponUid)
  end
  
  function actions:ReqUnequipWeapon(callback)
    ProtoManager.Instance:ReqServer("GameRequest", "OnTakeOffWeapon", function()
      if callback then
        callback()
      end
    end, function()
    end, data.awakerTid, self.currSelectedWeaponSlotType)
  end
  
  function actions:ReqUnequipAllWeapons(callback)
    local weaponSlotTypes = {}
    local awaker = data.awakerModel:GetAwakerData(data.awakerTid)
    for _, slotType in pairs(CommonDefine.WeaponSlotType) do
      local weaponSlot = AwakerDataUtils.GetWeaponSlotDataWithType(awaker, slotType)
      if weaponSlot.weaponUid > 0 then
        table.insert(weaponSlotTypes, slotType)
      end
    end
    ProtoManager.Instance:ReqServer("GameRequest", "OnTakeOffAllWeapons", function()
      if callback then
        callback()
      end
    end, function()
    end, data.awakerTid, weaponSlotTypes)
  end
  
  function actions:SetCurrDisplayWeapon(uid)
    data.currDisplayWeaponUid = uid
  end
  
  function actions:SetSelectedCostItemGroup(group)
    if not group then
      return
    end
    data.selectedCostItemGroup = group
  end
  
  function actions:AddSelectedCostItemGroup(uid, weapon)
    if not uid then
      return
    end
    if #data.selectedCostItemGroup == CommonDefine.RefineMtrlSlotCount then
      local selectData = self:GetSelectedChangeWeaponByUid(uid)
      if not selectData then
        Alert.Show(10712)
        return
      end
    end
    local levelAdd = 0
    for _, itemInfo in ipairs(data.selectedCostItemGroup) do
      local item = ItemDataUtils.GetItemByUid(itemInfo.uid)
      local itemCfg = DT.Item[item.tid]
      if itemCfg.Type == "Weapon" then
        levelAdd = levelAdd + (item.level + 1) * (itemInfo.num or 1)
      else
        levelAdd = levelAdd + (itemInfo.num or 1)
      end
    end
    local refineStageMaxLevel = DT.GetConstant("WeaponRefineSkillParaNum") + DT.GetConstant("WeaponRefineAttrNum")
    if refineStageMaxLevel <= weapon.level + levelAdd then
      Alert.Show(10713)
      return
    end
    local selectData = self:GetSelectedChangeWeaponByUid(uid)
    if not selectData then
      table.insert(data.selectedCostItemGroup, {uid = uid, num = 1})
      return
    end
    local itemNum = ItemDataUtils.GetItemByUid(uid).num
    if itemNum < selectData.num + 1 then
      return
    end
    self:UpdateSelectedCostItemGroup(selectData.uid, selectData.num + 1)
  end
  
  function actions:SubSelectedCostItemGroup(uid)
    if not uid then
      return
    end
    local selectData = self:GetSelectedChangeWeaponByUid(uid)
    if not selectData then
      return
    end
    if selectData.num > 1 then
      self:UpdateSelectedCostItemGroup(selectData.uid, selectData.num - 1)
    else
      self:RemoveSelectedCostItemGroupByUid(uid)
    end
  end
  
  function actions:UpdateSelectedCostItemGroup(uid, num)
    if not num then
      return
    end
    for key, itemData in pairs(data.selectedCostItemGroup) do
      if itemData.uid == uid then
        data.selectedCostItemGroup[key] = {uid = uid, num = num}
      end
    end
  end
  
  function actions:RemoveSelectedCostItemGroupByUid(uid)
    if not uid then
      return
    end
    for key, itemData in pairs(data.selectedCostItemGroup) do
      if itemData.uid == uid then
        table.remove(data.selectedCostItemGroup, key)
        break
      end
    end
  end
  
  return actions
end

local function onSetup(binder, model)
end

local AwakerWeaponModel = Vue.model("AwakerWeaponModel", createAwakerModelState):views(createAwakerModelViews):actions(createAwakerModelActions):setup(onSetup)
return AwakerWeaponModel
