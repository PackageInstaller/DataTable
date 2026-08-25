local typeof = _ENV.typeof
local UIAnimationController = CS.Z1Client.UIAnimationController
local AwakerWeaponComp, Super = System.NewComponent("AwakerWeaponComp")

function AwakerWeaponComp:ctor(uiNode, model)
  Super.ctor(self)
  self.ui = UI_Awaker_Panel_Weapon_MainResource(uiNode)
  self.awakerModel = model
  self.selectedWeapon = Vue.ref(nil)
end

function AwakerWeaponComp:OnBind(binder)
  self.binder = binder
  self:_OnBindPreviewUIVisable()
  
  local function refineSuccessCallback()
    self.ui.UI_Awaker_Weapon_Intensity01:SetActive(true)
    self.ui.UI_Awaker_Weapon_Intensity02:SetActive(true)
    binder:BindTimer(0.1, 1, nil, function()
      self.ui.UI_Awaker_Weapon_Intensity01:SetActive(false)
      self.ui.UI_Awaker_Weapon_Intensity02:SetActive(false)
    end)
  end
  
  local weaponSlotType = CommonDefine.WeaponSlotType
  self.primaryWeaponSlotModel = binder:createModel(WeaponSlotModel, self.awakerModel, weaponSlotType.Primary)
  self.secondaryWeaponSlotModel = binder:createModel(WeaponSlotModel, self.awakerModel, weaponSlotType.Secondary)
  local model = binder:createModel(AwakerWeaponModel, self.awakerModel, self.primaryWeaponSlotModel, self.secondaryWeaponSlotModel, refineSuccessCallback)
  self.weaponModel = model
  local itemModel = binder:createModel(CommonIconItemModel)
  self.itemModel = itemModel
  binder:BindComponent(WeaponSlotComp(self.ui.UI_Awaker_Panel_Weapon_Main_Item1, self.awakerModel, self.primaryWeaponSlotModel, self.weaponModel))
  binder:BindComponent(WeaponSlotComp(self.ui.UI_Awaker_Panel_Weapon_Main_Item2, self.awakerModel, self.secondaryWeaponSlotModel, self.weaponModel))
  self.mainWeaponDetailModel = binder:createModel(WeaponDetailModel, model.weapon, self.awakerModel)
  local enhanceMtrlSlotsModel = binder:createModel(WeaponEnhanceMaterialSlotsModel, self.mainWeaponDetailModel)
  local displayType = CommonDefine.WeaponEnhance.DetailPanelType_1
  binder:BindComponent(WeaponMainDetailComp(self.ui.UI_Awaker_Item_Weapon_Entrance, self.mainWeaponDetailModel, displayType))
  local leftWeaponDetailModel = binder:createModel(WeaponDetailModel, model.weapon, self.awakerModel)
  displayType = CommonDefine.WeaponEnhance.DetailPanelType_1
  binder:BindComponent(WeaponMainDetailComp(self.ui.Group_Weapon_Detail_1, leftWeaponDetailModel, displayType))
  local rightWeaponDetailModel = binder:createModel(WeaponDetailModel, model.weapon, self.awakerModel)
  binder:BindToRaw(function(_, weapon)
    leftWeaponDetailModel:SetWeapon(weapon)
    self.mainWeaponDetailModel:SetWeapon(model.weapon)
    local exp = enhanceMtrlSlotsModel:GetTotalExp()
    self.mainWeaponDetailModel:UpdateEnhancePreview(exp)
  end, function()
    return model.weapon
  end)
  displayType = CommonDefine.WeaponEnhance.DetailPanelType_2
  binder:BindComponent(WeaponMainDetailComp(self.ui.UI_Awaker_Item_Weapon_Entrance_2, rightWeaponDetailModel, displayType))
  binder:BindToText(self.ui.Text_Awaker_Name, function()
    local tid = self.awakerModel.selectAwakerId
    local name = self.awakerModel:GetAwakerTitle(tid)
    return name
  end)
  binder:BindToImage(self.ui.Image_Awaker_Career_Icon, function()
    local tid = self.awakerModel.selectAwakerId
    local config = self.awakerModel:GetAwakerConfig(tid)
    if not config then
      return ""
    end
    local iconPath = self.awakerModel:GetSchoolIcon(config.School)
    return iconPath
  end)
  self.weaponRefineModel = binder:createModel(WeaponRefineModel, model.weapon, model)
  self.enhanceComp = binder:BindComponent(WeaponEnhanceComp(self.ui.UI_Awaker_Item_Weapon_Strengthen, self.mainWeaponDetailModel, self.weaponRefineModel, enhanceMtrlSlotsModel))
  CommonDefine.enhanceComp = self.enhanceComp
  binder:BindToText(self.ui.Text_Equipped, function()
    do return LT.Text end
    return LT.Text, "TrinketEquipped"
  end)
  self.uiAnimController = self.ui.uiNode:GetComponent(typeof(UIAnimationController))
  binder:BindToRaw(function(_, playRefineAnim)
    if not playRefineAnim then
      return
    end
    self.uiAnimController:PlayState("UI_Awaker_Weapon_Intensity_Group_WeaponShake", function()
      self.weaponRefineModel:SetPlayRefineAnim(false)
    end)
  end, function()
    do return self.weaponRefineModel.IsPlayRefineAnim end
    return self.weaponRefineModel.IsPlayRefineAnim, self.weaponRefineModel
  end)
  binder:SetText(self.ui.Text_Unequip_Hint, LT.Text("WeaponUnequip_2"))
  binder:BindToVisible(self.ui.Text_Unequip_Hint, function()
    local weaponList = model:GetWeaponList()
    return 0 == model.weapon.tid and 0 == #weaponList and self.awakerModel.page ~= CommonDefine.AwakerPage.WeaponEnhance and self.awakerModel.page ~= CommonDefine.AwakerPage.Weapon
  end)
  binder:SetText(self.ui.Text_No_Weapon, LT.Text("WeaponListEmpty"))
  binder:BindToVisible(self.ui.Text_No_Weapon, function()
    if self.awakerModel.page == CommonDefine.AwakerPage.WeaponChange then
      return 0 == #model:GetWeaponList()
    end
    return false
  end)
  binder:BindToVisible(self.ui.Text_None, function()
    if self.awakerModel.page == CommonDefine.AwakerPage.WeaponRefine then
      return 0 == #model:GetWeaponList()
    end
    return false
  end)
  binder:BindToRaw(function(_, rightWeaponUid)
    if nil == rightWeaponUid then
      return
    end
    if 0 == rightWeaponUid then
      self.mainWeaponDetailModel:SetWeapon(CommonDefine.DummyWeapon.Weapon)
      rightWeaponDetailModel:SetWeapon(CommonDefine.DummyWeapon.Weapon)
      return
    end
    local rightWeapon = ItemDataUtils.GetItemByUid(rightWeaponUid)
    if nil == rightWeapon then
      return
    end
    if self.awakerModel.page ~= CommonDefine.AwakerPage.WeaponEnhance then
      self.mainWeaponDetailModel:SetWeapon(rightWeapon)
      self.weaponRefineModel:SetWeapon(rightWeapon)
      model:SetCurrDisplayWeapon(rightWeaponUid)
    end
    rightWeaponDetailModel:SetWeapon(rightWeapon)
  end, function()
    do return model.GetRightWeaponUid end
    return model.GetRightWeaponUid, model
  end)
  binder:BindToRaw(function(childBinder, tid)
    if 0 == tid then
      self.ui.Image_Weapon_Large:SetActive(false)
      self.ui.Image_Weapon_Quality:SetActive(false)
      return
    end
    self.ui.Image_Weapon_Large:SetActive(true)
    self.ui.Image_Weapon_Quality:SetActive(true)
    if self.awakerModel.page ~= CommonDefine.AwakerPage.WeaponEnhance then
      local weaponConfig = DT.Item[tid]
      childBinder:BindComponent(AwakerWeaponPrefab(self.ui.Image_Weapon_Large, weaponConfig.SpIcon, 0.8))
      local frame = DT.ItemQuality[weaponConfig.Quality].PaitingFrame
      if frame then
        self.ui.Image_Weapon_Quality:SetActive(true)
        childBinder:SetImage(self.ui.Image_Weapon_Quality, frame)
      else
        self.ui.Image_Weapon_Quality:SetActive(false)
      end
    end
  end, function()
    local uid = model:GetRightWeaponUid()
    if not uid or 0 == uid then
      return 0
    end
    local weaponItem = ItemDataUtils.GetItemByUid(uid)
    if nil == weaponItem then
      return 0
    end
    return weaponItem.tid
  end)
  binder:BindToImage(self.ui.Image_Avatar, function()
    local awakerTid = self.awakerModel.selectAwakerId
    do return AwakerDataUtils.GetLittleIcon end
    return AwakerDataUtils.GetLittleIcon, awakerTid
  end)
  binder:BindToRaw(function(_, equiped)
    self.ui.Image_Equipped:SetActive(equiped)
    self.ui.Btn_Contrast:SetActive(not equiped)
  end, function()
    do return model.IsRightWeaponEquiped end
    return model.IsRightWeaponEquiped, model
  end)
  binder:BindToVisible(self.ui.RootEquippedContrast, function()
    local tid = model.weapon.tid
    return tid and tid > 0
  end)
  local wepaonScrollRect = self.ui.ScrollView_Weapon_Main:GetComponent(typeof(CS.UnityEngine.UI.ScrollRect))
  local initPos = CS.UnityEngine.Vector2(0.5, 1)
  binder:BindToRaw(function(_, page, oldPage)
    self.ui.UI_Awaker_Panel_Weapon_Main_Item1:SetActive(page == CommonDefine.AwakerPage.Weapon)
    self.ui.UI_Awaker_Panel_Weapon_Main_Item2:SetActive(page == CommonDefine.AwakerPage.Weapon)
    self.ui.Weapon_Item_Center:SetActive(page == CommonDefine.AwakerPage.WeaponChange or page == CommonDefine.AwakerPage.WeaponEnhance or page == CommonDefine.AwakerPage.WeaponRefine)
    self.ui.Btn_Recommend_Equip:SetActive(page == CommonDefine.AwakerPage.Weapon)
    local hasWeapon = #model:GetWeaponList() > 0
    self.ui.Btn_Enhance_Root:SetActive(page == CommonDefine.AwakerPage.WeaponChange and hasWeapon)
    if page == CommonDefine.AwakerPage.Weapon then
      local weapon = self.mainWeaponDetailModel.weapon
      if weapon.enhanceLevel <= 0 then
        self.ui.Btn_Change_2:SetActive(true)
      end
      model:SetSelectedChangeWeaponUid(nil)
      if model.contrastOn then
        model:ToggleContrast()
      end
    elseif page == CommonDefine.AwakerPage.WeaponChange then
      wepaonScrollRect.normalizedPosition = initPos
      if 0 == model.weapon.tid then
        local list = model:GetWeaponList()
        if #list > 0 then
          model:SetSelectedChangeWeaponUid(list[1].uid)
        end
      end
    end
    if oldPage == CommonDefine.AwakerPage.WeaponRefine then
      model:SetSelectedRefineMaterialUid(nil)
      model:SetShowTipUid(0)
    elseif oldPage == CommonDefine.AwakerPage.Weapon or nil == oldPage then
      self.ui.UI_Awaker_Item_Weapon_Entrance:SetActive(false)
    end
    self.ui.Image_Avatar_Root:SetActive(page == CommonDefine.AwakerPage.WeaponChange)
  end, function()
    return self.awakerModel.page
  end)
  binder:BindToVisible(self.ui.Btn_TakeOff_All_Equip, function()
    return self.awakerModel.page == CommonDefine.AwakerPage.Weapon and (self.primaryWeaponSlotModel:HasWeapon() or self.secondaryWeaponSlotModel:HasWeapon())
  end)
  binder:BindToRaw(function(_, value)
    self.ui.Btn_Enhance:SetActive(value)
    self.ui.Btn_Equip_2:SetActive(value)
    self.ui.Btn_Enhance_2:SetActive(value)
    if self.awakerModel.page == CommonDefine.AwakerPage.WeaponEnhance then
      self.enhanceComp:ClearMtrlSlots()
      self.ui.Btn_Change_2:SetActive(false)
    else
      self.ui.Btn_Change_2:SetActive(not value)
    end
  end, function()
    if not self.awakerModel:HasOwnedAwaker(self.awakerModel.selectAwakerId) then
      return false
    end
    if self.awakerModel.page == CommonDefine.AwakerPage.WeaponEnhance then
      return false
    end
    local weapon = self:_GetCurrWeapon(model)
    if nil == weapon then
      return true
    end
    return weapon.enhanceLevel > 0
  end)
  binder:BindToCircularListView(self.ui.ScrollView_Weapon_Main, function()
    local list = model:GetWeaponList()
    return list
  end, function(childBinder, obj, index)
    local list = model:GetWeaponList()
    local value = list[index]
    
    local function IsSelected()
      if self.awakerModel.page == CommonDefine.AwakerPage.WeaponRefine then
        return model.selectedRefineMaterialUid == value.uid
      end
    end
    
    local function OnClick(tid, uid)
      if not tid or not uid then
        return
      end
      if self.awakerModel.page == CommonDefine.AwakerPage.WeaponRefine then
        model:SetShowTipUid(uid)
      end
      itemModel:SetChosenItemUid(uid)
      if self.awakerModel.page == CommonDefine.AwakerPage.WeaponChange then
        model:SetSelectedChangeWeaponUid(uid)
      elseif self.awakerModel.page == CommonDefine.AwakerPage.WeaponRefine then
        model:SetSelectedRefineMaterialUid(uid)
      end
    end
    
    local function IsLastClicked()
      if self.awakerModel.page == CommonDefine.AwakerPage.WeaponChange then
        return model.selectedChangeWeaponUid == value.uid
      elseif self.awakerModel.page == CommonDefine.AwakerPage.WeaponRefine then
        return value.uid == model.showTipUid
      end
    end
    
    local function mockOwnerCheck()
      local awaker = itemModel:GetItemOwner(value.uid)
      if awaker and 0 ~= awaker then
        local changeFormAwaker = AwakerDataUtils.GetChangerForm(awaker)
        if awaker == self.awakerModel.selectAwakerId or changeFormAwaker == self.awakerModel.selectAwakerId then
          return self.awakerModel.selectAwakerId
        end
      end
      return nil
    end
    
    local itemData = {
      tid = value.tid,
      uid = value.uid,
      model = itemModel,
      selectedFunc = IsSelected,
      clickFrameShowFunc = IsLastClicked,
      callback = OnClick,
      mockOwner = mockOwnerCheck
    }
    childBinder:BindComponent(WeaponIconItem(obj, itemData, self.awakerModel, self.weaponModel, self.primaryWeaponSlotModel, self.secondaryWeaponSlotModel))
  end)
  binder:BindToAnimator(self.ui.Group_Sort_List, function(_, animator, show)
    AnimatorUtils.SetStateEndInBehavior(animator, "Close", function()
      binder:SetActive(self.ui.Group_Sort_List, false)
    end)
    local name = show and "Open" or "Close"
    if "Open" == name then
      return
    end
    local state = string.format("Base Layer.%s", name)
    AnimatorUtils.PlayState(animator, state)
  end, nil, function()
    return model.sortTypeShow
  end)
  binder:BindToZ1Toggle(self.ui.Btn_Trinket, nil, function(isOn)
    model:SetSortTypeShow(isOn)
    if isOn then
      binder:SetActive(self.ui.Group_Sort_List, true)
    end
  end, function()
    return model.sortTypeShow
  end)
  binder:BindToVisible(self.ui.Btn_Mask_Tip, function()
    return model.sortTypeShow
  end)
  binder:BindButtonClick(self.ui.Btn_Mask_Tip, function()
    if model.sortTypeShow then
      model:SetSortTypeShow(false)
    end
  end)
  binder:BindButtonClick(self.ui.Btn_Sort, function()
    model:SetSortOrder()
  end)
  binder:BindToText(self.ui.Text_2_Normal, function()
    local sortOrder = model.sortOrder
    do return model.GetSortOrderName, model end
    return model.GetSortOrderName, model, sortOrder
  end)
  binder:BindToText(self.ui.Text_1_Select, function()
    do return model.GetWeaponSortTypeName, model end
    return model.GetWeaponSortTypeName, model, model.sortType
  end)
  binder:BindToText(self.ui.Text_1_Normal, function()
    do return model.GetWeaponSortTypeName, model end
    return model.GetWeaponSortTypeName, model, model.sortType
  end)
  binder:BindToCircularListView(self.ui.ScrollView_Sort_List, function()
    return model.sortTypeList
  end, function(childBinder, obj, index)
    local sortTypeInfo = model.sortTypeList[index]
    local sortTypeName = sortTypeInfo.name
    
    local function IsSelected()
      return model.sortType == index
    end
    
    local function OnClick(sortType)
      if not sortType then
        return
      end
      model:SetSortType(sortType)
      model:SetSortTypeShow(false)
    end
    
    local itemData = {
      tid = index,
      name = sortTypeName,
      selectedFunc = IsSelected,
      callback = OnClick
    }
    childBinder:BindComponent(CommonFilterListItem(obj, itemData))
  end)
  
  local function refineFunc()
    local selectedWeapon = model:GetSelectedChangeWeapon()
    if nil == selectedWeapon then
      model:SetSelectedChangeWeaponUid(model.weapon.uid)
      selectedWeapon = model:GetSelectedChangeWeapon()
    end
    if 5 == selectedWeapon.level and 0 == selectedWeapon.level then
      Alert.Show(10484)
      return
    end
    self.awakerModel:SetAwakerPage(CommonDefine.AwakerPage.WeaponRefine)
    self.ui.UI_Awaker_Item_Weapon_Refine:SetActive(true)
    self.ui.UI_Awaker_Popup_Weapon_Change:SetActive(false)
    self.weaponRefineModel:SetWeapon(selectedWeapon)
  end
  
  local function changeFunc()
    if self.awakerModel.page == CommonDefine.AwakerPage.Weapon then
      self.awakerModel:SetAwakerPage(CommonDefine.AwakerPage.WeaponChange)
      model:SetSelectedChangeWeaponUid(model.weapon.uid)
    else
      local selectedWeapon = model:GetSelectedChangeWeapon()
      if not selectedWeapon then
        Alert.Show(10584)
        return
      end
      if selectedWeapon.awaker ~= nil and 0 ~= selectedWeapon.awaker then
        local awakerConfig = DT.AwakerConfig[selectedWeapon.awaker]
        local weaponConfig = DT.Item[selectedWeapon.tid]
        local desc = LT.Textf(DT.TipsType[20049].Desc, LT.Text(weaponConfig.Name), LT.Text(awakerConfig.Title))
        Alert.Show(20049, nil, function()
          model:ReqChangeWeapon(function()
            Alert.Show(10498)
          end)
        end, nil, desc)
      else
        model:ReqChangeWeapon(function()
          Alert.Show(10498)
        end)
      end
    end
  end
  
  binder:BindToVisible(self.ui.Group_Contrast, function()
    return model.contrastOn
  end)
  binder:BindZ1Button(self.ui.Btn_Enhance, function()
    local selectedWeapon = model:GetSelectedChangeWeapon()
    if selectedWeapon then
      self.enhanceWeaponUid = selectedWeapon.uid
    end
    self.awakerModel:SetAwakerPage(CommonDefine.AwakerPage.WeaponEnhance)
  end, function()
    return CommonDefine.BtnType.Normal
  end, function()
    do return LT.Text end
    return LT.Text, "Refine"
  end)
  binder:BindZ1Button(self.ui.Btn_Enhance_2, function()
    local selectedWeapon = model:GetSelectedChangeWeapon()
    if not selectedWeapon then
      Alert.Show(10597)
      return
    end
    self.enhanceWeaponUid = selectedWeapon.uid
    self.awakerModel:SetAwakerPage(CommonDefine.AwakerPage.WeaponEnhance)
  end, function()
    return CommonDefine.BtnType.Normal
  end, function()
    do return LT.Text end
    return LT.Text, "Refine"
  end)
  
  local function redPointFunc()
    if self.awakerModel.page == CommonDefine.AwakerPage.Weapon then
      local awakerTid = self.awakerModel.selectAwakerId
      if RedPointDataUtils.HasAwakerWeaponRed(awakerTid) then
        return RedPointDataUtils.RedAttrType.Red
      end
    end
  end
  
  binder:BindZ1Button(self.ui.Btn_Change, changeFunc, function()
    return CommonDefine.BtnType.Normal
  end, function()
    do return LT.Text end
    return LT.Text, "RoleDetailsEquipDetails_Btn_Change"
  end)
  binder:BindZ1Button(self.ui.Btn_Change_2, changeFunc, function()
    return CommonDefine.BtnType.Normal
  end, function()
    do return LT.Text end
    return LT.Text, "RoleDetailsEquipDetails_Btn_Change"
  end, redPointFunc, nil, nil)
  binder:BindZ1Button(self.ui.Btn_TakeOff_All_Equip, function()
    Alert.Show(20092, nil, function()
      model:ReqUnequipAllWeapons(function()
        self.ui.Btn_TakeOff_All_Equip:SetActive(false)
      end)
    end)
  end)
  binder:BindZ1Button(self.ui.Btn_Recommend_Equip, function()
    if not self.primaryWeaponSlotModel:HasWeapon() or not self.secondaryWeaponSlotModel:HasWeapon() then
      model:EquipRecommendWeapon()
    else
      Alert.Show(10701)
    end
  end, function()
    return CommonDefine.BtnType.High
  end, function()
    do return LT.Text end
    return LT.Text, "Weapon_Suggest_Btn"
  end, function()
    local awakerTid = self.awakerModel.selectAwakerId
    if RedPointDataUtils.HasAwakerWeaponRed(awakerTid) then
      return RedPointDataUtils.RedAttrType.Red
    end
  end)
  binder:BindZ1Button(self.ui.Btn_Equip_2, changeFunc, function()
    return CommonDefine.BtnType.Normal
  end, function()
    do return LT.Text end
    return LT.Text, "RoleDetailsEquipDetails_Btn_PutOn"
  end)
  binder:BindZ1Button(self.ui.Btn_Unequip, function()
    model:ReqUnequipWeapon(function()
      self.awakerModel:SetAwakerPage(CommonDefine.AwakerPage.Weapon)
    end)
  end, function()
    return CommonDefine.BtnType.Normal
  end, function()
    do return LT.Text end
    return LT.Text, "RoleDetailsEquipDetails_Btn_Remove"
  end)
  binder:BindZ1Button(self.ui.Btn_Unequip_2, function()
    model:ReqUnequipWeapon(function()
      self.awakerModel:SetAwakerPage(CommonDefine.AwakerPage.Weapon)
    end)
  end, function()
    return CommonDefine.BtnType.Normal
  end, function()
    do return LT.Text end
    return LT.Text, "RoleDetailsEquipDetails_Btn_Remove"
  end)
  binder:BindToVisible(self.ui.Btn_Contrast, function()
    do return model.IsContrastVisible end
    return model.IsContrastVisible, model
  end)
  binder:BindButtonClick(self.ui.Btn_Contrast, function()
    model:ToggleContrast()
  end)
  binder:BindToText(self.ui.Text_Contrast, function()
    do return model.GetContrastText end
    return model.GetContrastText, model
  end)
  binder:BindButtonClick(self.ui.Btn_Hide_Contrast, function()
    model:ToggleContrast()
  end)
  binder:BindToRaw(function(_, state)
    if state == CommonDefine.WeaponBtnState.ShowEquip then
      local hasWeapon = #model:GetWeaponList() > 0
      self.ui.Btn_Equip_Root:SetActive(hasWeapon)
      self.ui.Btn_Change:SetActive(false)
      self.ui.Btn_Change_2_Root:SetActive(false)
      self.ui.Btn_Unequip:SetActive(false)
      self.ui.Btn_Unequip_2:SetActive(false)
    elseif state == CommonDefine.WeaponBtnState.ShowUnequip then
      self.ui.Btn_Equip_Root:SetActive(false)
      self.ui.Btn_Change:SetActive(false)
      self.ui.Btn_Change_2_Root:SetActive(false)
      local showUnequipStype_1 = true
      local weapon = self:_GetCurrWeapon(model)
      if weapon then
        showUnequipStype_1 = weapon.enhanceLevel > 0
      end
      self.ui.Btn_Unequip:SetActive(showUnequipStype_1)
      self.ui.Btn_Unequip_2:SetActive(not showUnequipStype_1)
    elseif state == CommonDefine.WeaponBtnState.ShowChange then
      self.ui.Btn_Equip_Root:SetActive(false)
      self.ui.Btn_Change:SetActive(true)
      self.ui.Btn_Change_2_Root:SetActive(true)
      self.ui.Btn_Unequip:SetActive(false)
      self.ui.Btn_Unequip_2:SetActive(false)
    elseif state == CommonDefine.WeaponBtnState.ShowNone then
      self.ui.Btn_Equip_Root:SetActive(false)
      self.ui.Btn_Change:SetActive(false)
      self.ui.Btn_Change_2_Root:SetActive(false)
      self.ui.Btn_Unequip:SetActive(false)
      self.ui.Btn_Unequip_2:SetActive(false)
    end
  end, function()
    do return model.GetButtonState end
    return model.GetButtonState, model
  end)
  binder:BindEvent(EventMgr.Instance.OnAwakerPageClosed, System.fn(self, self._OnAwakerPageClosed))
end

function AwakerWeaponComp:ScrollWeaponListToCurrSelected()
  local list = self.weaponModel:GetWeaponList()
  for idx, value in ipairs(list) do
    if value.uid == self.enhanceWeaponUid then
      self.weaponModel:SetSelectedChangeWeaponUid(value.uid)
      self.binder:CircularScrollTo(self.ui.ScrollView_Weapon_Main, idx)
      return
    end
  end
  self.enhanceWeaponUid = nil
end

function AwakerWeaponComp:_OnAwakerPageClosed(page)
  if page == CommonDefine.AwakerPage.WeaponChange then
    self.ui.Group_Select:SetActive(false)
    self.ui.UI_Awaker_Popup_Weapon_Change:SetActive(false)
  elseif page == CommonDefine.AwakerPage.WeaponEnhance then
    self.ui.UI_Awaker_Item_Weapon_Strengthen:SetActive(false)
  end
end

function AwakerWeaponComp:_GetCurrWeapon(model)
  if self.awakerModel.page == CommonDefine.AwakerPage.Weapon then
    return model.weapon
  elseif self.awakerModel.page == CommonDefine.AwakerPage.WeaponChange or self.awakerModel.page == CommonDefine.AwakerPage.WeaponRefine then
    do return model.GetSelectedChangeWeapon end
    return model.GetSelectedChangeWeapon, model
  end
end

function AwakerWeaponComp:OnUnbind()
  Super.OnUnbind(self)
end

function AwakerWeaponComp:_OnBindPreviewUIVisable()
  self.binder:BindToVisible(self.ui.Group_Btn, function()
    if table.next(AwakerDataUtils.GetMockAwakerMap()) then
      return false
    end
    return self.awakerModel.page == CommonDefine.AwakerPage.Weapon or self.awakerModel.page == CommonDefine.AwakerPage.WeaponChange
  end)
end

return AwakerWeaponComp
