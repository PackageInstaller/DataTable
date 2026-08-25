local WeaponRefineComp, Super = System.NewComponent("WeaponRefineComp")

function WeaponRefineComp:ctor(uiNode, model)
  Super.ctor(self)
  self.ui = UI_Awaker_Item_Weapon_RefiningResource(uiNode)
  self.model = model
  self.level = Vue.ref(0)
  self.playStarAnim = false
  self.refineStage1MaxLevel = DT.GetConstant("WeaponRefineSkillParaNum")
  self.refineStage2MaxLevel = DT.GetConstant("WeaponRefineAttrNum")
  self.refineStageMaxLevel = self.refineStage1MaxLevel + self.refineStage2MaxLevel
  self.refineStage1Stars = AwakerBreakthroughStars(self.ui.RootStars, self.refineStage1MaxLevel)
  self.typeDefine = {
    curr = 0,
    next = 1,
    after = 2
  }
  self.levelAndDescDisplayType = Vue.ref(self.typeDefine.curr)
end

function WeaponRefineComp:OnBind(binder)
  self.binder = binder
  local model = self.model
  local itemModel = binder:createModel(CommonIconItemModel)
  binder:BindToText(self.ui.Text_Weapon_Name, function()
    do return model.GetWeaponName end
    return model.GetWeaponName, model
  end)
  binder:BindToVisible(self.ui.RootBtns, function()
    return self.model:GetWeaponlevel() < self.refineStageMaxLevel
  end)
  binder:BindZ1Button(self.ui.Btn_Current, function()
    self:_UpdateRefineLevelAndDesc(true)
  end, function()
    if self.levelAndDescDisplayType.value == self.typeDefine.curr then
      return CommonDefine.BtnType.High
    end
    return CommonDefine.BtnType.Normal
  end)
  binder:BindToVisible(self.ui.Btn_Next, function()
    return 0 == model:GetAwakerWeaponModel().curSelectItemNum
  end)
  binder:BindZ1Button(self.ui.Btn_Next, function()
    self:_UpdateRefineLevelAndDesc(true, 1)
  end, function()
    if self.levelAndDescDisplayType.value == self.typeDefine.next then
      return CommonDefine.BtnType.High
    end
    return CommonDefine.BtnType.Normal
  end)
  binder:BindToVisible(self.ui.Btn_After, function()
    return model:GetAwakerWeaponModel().curSelectItemNum > 0
  end)
  binder:BindZ1Button(self.ui.Btn_After, function()
    self:_UpdateRefineLevelAndDesc()
  end, function()
    if self.levelAndDescDisplayType.value == self.typeDefine.after then
      return CommonDefine.BtnType.High
    end
    return CommonDefine.BtnType.Normal
  end)
  
  local function _UpdateRefineLevelAndDesc(mtrlNum)
    if mtrlNum > 0 then
      self:_UpdateRefineLevelAndDesc()
    else
      self:_UpdateRefineLevelAndDesc(true)
    end
  end
  
  binder:BindToRaw(function()
    local num = model:GetAwakerWeaponModel().curSelectItemNum
    _UpdateRefineLevelAndDesc(num)
  end, function()
    do return model.GetWeaponlevel end
    return model.GetWeaponlevel, model
  end)
  binder:BindToRaw(function(_, num)
    _UpdateRefineLevelAndDesc(num)
  end, function()
    return model:GetAwakerWeaponModel().curSelectItemNum
  end)
  binder:BindToRaw(function()
    local num = model:GetAwakerWeaponModel().curSelectItemNum
    _UpdateRefineLevelAndDesc(num)
  end, function()
    return model.weapon
  end)
  local awakerWeaponModel = model:GetAwakerWeaponModel()
  
  local function onMtrlSlotClick()
    self:OpenMaterialSelectPanel(binder, itemModel)
  end
  
  binder:BindComponent(WeaponRefineMtrlSlotComp(self.ui.MtrlSlot_1, 1, awakerWeaponModel, onMtrlSlotClick))
  binder:BindComponent(WeaponRefineMtrlSlotComp(self.ui.MtrlSlot_2, 2, awakerWeaponModel, onMtrlSlotClick))
  binder:BindComponent(WeaponRefineMtrlSlotComp(self.ui.MtrlSlot_3, 3, awakerWeaponModel, onMtrlSlotClick))
  binder:BindComponent(WeaponRefineMtrlSlotComp(self.ui.MtrlSlot_4, 4, awakerWeaponModel, onMtrlSlotClick))
  binder:BindButtonClick(self.ui.Btn_Fast, function()
    self:_BatchSelectMtrls()
  end)
  binder:BindToRaw(function(_, isMax)
    self.ui.Image_Full:SetActive(isMax)
    self.ui.Group_Warning:SetActive(isMax)
    self.ui.Btn_Refine:SetActive(not isMax)
    self.ui.RootCost:SetActive(not isMax)
  end, function()
    do return model.IsLevelMax end
    return model.IsLevelMax, model
  end)
  binder:BindToText(self.ui.Text_Coin_Count, function()
    do return model.GetMonenyDesc end
    return model.GetMonenyDesc, model
  end)
  binder:SetActive(self.ui.Image_Coin_Icon, self.model:IsCostMoney())
  binder:BindZ1Button(self.ui.Btn_Refine, function()
    self:_Refine()
  end, function()
    if model:IsMoneyEnough() and #model:GetSelectedMaterial() > 0 then
      return CommonDefine.BtnType.High
    else
      return CommonDefine.BtnType.Unclickable
    end
  end)
  local itemDetailTipsModel = binder:createModel(CommonItemDetailTipsModel)
  self.itemDetailTipsModel = itemDetailTipsModel
  binder:BindToRaw(function(itemBinder, nVal, _)
    self.ui.UI_Common_Item_Detail:SetActive(0 ~= nVal)
    if 0 == nVal then
      return
    end
    local itemData = ItemDataUtils.GetItemByUid(nVal)
    itemDetailTipsModel:SetItemDataMap({itemData})
    itemDetailTipsModel:SetChosenItemTid(itemData.tid)
    itemDetailTipsModel:SetChosenItemUid(nVal)
    itemBinder:BindComponent(CommonItemDetailTipsItem(self.ui.UI_Common_Item_Detail, nil, itemDetailTipsModel, nil, nil, nil, nil, nil, nil, nil, true))
  end, function()
    return awakerWeaponModel.showTipUid
  end)
  binder:BindButtonClick(self.ui.Btn_Mtrl_Panel_Mask, function()
    self:CloseMtrlSelectionPanel()
  end)
  self.backTrackCom = binder:BindComponent(WeaponBackTrackCom(self.ui, self.model))
end

function WeaponRefineComp:SetBackTrackCallBack(func)
  if self.backTrackCom then
    self.backTrackCom:SetBackTrackCallBack(func)
  end
end

function WeaponRefineComp:_UpdateRefineLevelAndDesc(withoutMtrls, levelAdd)
  if withoutMtrls then
    self.levelAndDescDisplayType.value = levelAdd and self.typeDefine.next or self.typeDefine.curr
  else
    self.levelAndDescDisplayType.value = self.typeDefine.after
  end
  local currLevel = self.model:GetWeaponlevel()
  local numMtrls = withoutMtrls and 0 or self.model:GetAwakerWeaponModel().curSelectItemNum
  levelAdd = levelAdd or 0
  local selectedMtrls = withoutMtrls and {} or self.model:GetAwakerWeaponModel().selectedCostItemGroup
  for _, mtrl in ipairs(selectedMtrls) do
    local item = ItemDataUtils.GetItemByUid(mtrl.uid)
    if item then
      levelAdd = levelAdd + (item.level + 1) * (mtrl.num or 1)
    end
  end
  local maxLevel = self.refineStageMaxLevel
  local expectedLevel = math.min(currLevel + levelAdd, maxLevel)
  local title = 0 == levelAdd and LT.Text("CurrRefineLevelEffect") or LT.Text("NextRefineLevelEffect")
  self.binder:SetText(self.ui.Text_Effect, title)
  for idx = 1, self.refineStage1Stars:NumStars() do
    if expectedLevel >= idx then
      self.refineStage1Stars:TurnOn(idx)
    else
      self.refineStage1Stars:TurnOff(idx)
    end
  end
  local stage2Level = expectedLevel - self.refineStage1MaxLevel
  if stage2Level > 0 then
    self.ui.RootLevel:SetActive(true)
    self.binder:SetText(self.ui.Text_Level, stage2Level)
  else
    self.ui.RootLevel:SetActive(false)
  end
  local weaponCfg = self.model.weaponConfig
  if weaponCfg then
    local attriID = weaponCfg.WeaponSubAttribute[1]
    local attriBaseValue = weaponCfg.WeaponSubAttribute[2]
    local attriConfig = DT.ActorAttrType[attriID]
    local attriFactor = CommonDefine.WeaponRefineAttrFactor[weaponCfg.Quality] or 0
    self.binder:SetImage(self.ui.Image_Attribute_Icon, attriConfig.Icon)
    self.binder:SetText(self.ui.Text_Attribute_Name, LT.Text(attriConfig.Text))
    if 0 == numMtrls or expectedLevel <= self.refineStage1MaxLevel then
      self.ui.Text_Attribute_CurrValue:SetActive(true)
      self.ui.Text_Attribute_NextValue:SetActive(false)
      self:_SetAttribute(attriID, attriFactor, attriBaseValue, math.max(expectedLevel - self.refineStage1MaxLevel, 0), self.ui.Text_Attribute_CurrValue)
    else
      self.ui.Text_Attribute_CurrValue:SetActive(false)
      self.ui.Text_Attribute_NextValue:SetActive(true)
      self:_SetAttribute(attriID, attriFactor, attriBaseValue, expectedLevel - self.refineStage1MaxLevel, self.ui.Text_Attribute_NextValue)
    end
  end
  local desc = self.model:GetLevelDesc(expectedLevel)
  self.binder:SetText(self.ui.Text_Introduce, desc)
  StrUtils.SetPreferredHeight(self.ui.Text_Introduce)
end

function WeaponRefineComp:_SetAttribute(attriID, attriFactor, attriBaseValue, refineStage2Level, ui)
  local attriCfg = DT.ActorAttrType[attriID]
  local attriValue = attriBaseValue + (attriCfg.Equivalency or 0) * attriFactor * refineStage2Level
  attriValue = ItemDataUtils.RemoveDotZero(attriValue)
  if attriCfg.Percentage then
    attriValue = attriValue .. "%"
  end
  self.binder:SetText(ui, attriValue)
end

function WeaponRefineComp:_BindMtrlListView(binder, itemModel)
  local awakerWeaponModel = self.model:GetAwakerWeaponModel()
  local mtrlList = awakerWeaponModel:GetCurrDisplayWeaponMtrlList()
  self.ui.Group_No_Trinket:SetActive(0 == #mtrlList)
  if self.listBinder then
    self.listBinder:teardown()
  end
  self.listBinder = binder:BindToCircularListView(self.ui.ScrollView_Items, function()
    return mtrlList
  end, function(childBinder, obj, index)
    local value = mtrlList[index]
    local bagItemData = ItemDataUtils.GetItemByUid(value.uid)
    
    local function IsSelected()
      do return awakerWeaponModel.GetSelectedChangeWeaponByUid, awakerWeaponModel end
      return awakerWeaponModel.GetSelectedChangeWeaponByUid, awakerWeaponModel, value.uid
    end
    
    local function OnClick(tid, uid)
      if not tid or not uid then
        return
      end
      itemModel:SetChosenItemUid(uid)
      local countBefore = 0
      local selectData = awakerWeaponModel:GetSelectedChangeWeaponByUid(uid)
      if selectData then
        countBefore = selectData.num
      end
      awakerWeaponModel:AddSelectedCostItemGroup(uid, self.model.weapon)
      local countAfter = 0
      selectData = awakerWeaponModel:GetSelectedChangeWeaponByUid(uid)
      if selectData then
        countAfter = selectData.num
      end
      if awakerWeaponModel.showTipUid ~= uid then
        awakerWeaponModel:SetShowTipUid(uid)
      elseif countBefore == countAfter then
        awakerWeaponModel:SetShowTipUid(0)
      end
    end
    
    local function btnSubFunc()
      awakerWeaponModel:SubSelectedCostItemGroup(value.uid)
      if awakerWeaponModel.showTipUid == value.uid then
        local selectData = awakerWeaponModel:GetSelectedChangeWeaponByUid(value.uid)
        if not selectData or 0 == selectData.num then
          awakerWeaponModel:SetShowTipUid(0)
        end
      end
    end
    
    local function selectNumFunc()
      local selectData = awakerWeaponModel:GetSelectedChangeWeaponByUid(value.uid)
      return selectData and selectData.num or 0
    end
    
    local function IsLastClicked()
      return value.uid == awakerWeaponModel.showTipUid
    end
    
    local itemData = {
      tid = value.tid,
      uid = value.uid,
      model = itemModel,
      selectedFunc = IsSelected,
      clickFrameShowFunc = IsLastClicked,
      callback = OnClick,
      btnSubFunc = btnSubFunc,
      selectNumFunc = selectNumFunc,
      showMultiSelect = bagItemData.num > 1
    }
    childBinder:BindComponent(CommonIconItem(obj, itemData))
  end)
  self.ui.UI_Awaker_Popup_Trinket_Tip:SetActive(false)
end

function WeaponRefineComp:IsShowingMtrlSelectionPanel()
  return self.ui.UI_Awaker_Popup_Jewelry.activeSelf
end

function WeaponRefineComp:HideMtrlSelectionPanel()
  local awakerWeaponModel = self.model:GetAwakerWeaponModel()
  awakerWeaponModel:SetShowTipUid(0)
  self.ui.UI_Awaker_Popup_Jewelry:SetActive(false)
  EventMgr.Instance.OnShowAwakerWeaponRefineList:Dispatch(false)
  awakerWeaponModel:SetSelectedCostItemGroup({})
end

function WeaponRefineComp:RefreshSelectWeapon()
  local awakerWeaponModel = self.model:GetAwakerWeaponModel()
  awakerWeaponModel:SetSelectedChangeWeaponUid(self.model.weapon.uid)
  if self.model.weapon.level == CommonDefine.ItemMaxLevel then
    return
  end
end

function WeaponRefineComp:SetRefineLevel(level)
  if nil == level then
    return
  end
  self.level.value = level
end

function WeaponRefineComp:SetPlayStarAnim(playAnim)
  self.playStarAnim = playAnim
end

function WeaponRefineComp:CloseMtrlSelectionPanel()
  local awakerWeaponModel = self.model:GetAwakerWeaponModel()
  if awakerWeaponModel.showTipUid > 0 then
    awakerWeaponModel:SetShowTipUid(0)
  else
    self.ui.UI_Awaker_Popup_Jewelry:SetActive(false)
    EventMgr.Instance.OnShowAwakerWeaponRefineList:Dispatch(false)
    UIBackCommandStack.Remove(tostring(self))
  end
end

function WeaponRefineComp:_CreateBackCommand()
  return {
    uiPanel = tostring(self),
    Execute = function()
      local awakerWeaponModel = self.model:GetAwakerWeaponModel()
      if awakerWeaponModel.showTipUid > 0 then
        awakerWeaponModel:SetShowTipUid(0)
        UIBackCommandStack.Push(self:_CreateBackCommand())
      else
        self.ui.UI_Awaker_Popup_Jewelry:SetActive(false)
        EventMgr.Instance.OnShowAwakerWeaponRefineList:Dispatch(false)
      end
    end
  }
end

function WeaponRefineComp:OnUnbind()
  Super.OnUnbind(self)
  UIBackCommandStack.Remove(tostring(self))
  if self.timer then
    self.binder:StopTimer(self.timer)
  end
end

function WeaponRefineComp:OpenMaterialSelectPanel(binder, itemModel)
  self:_BindMtrlListView(binder, itemModel)
  self.ui.UI_Awaker_Popup_Jewelry:SetActive(true)
  EventMgr.Instance.OnShowAwakerWeaponRefineList:Dispatch(true)
  UIBackCommandStack.Push(self:_CreateBackCommand())
end

function WeaponRefineComp:_Refine()
  if not self.model:IsMoneyEnough() then
    Alert.Show(10462)
    return
  end
  local materialGroup = self.model:GetSelectedMaterial()
  if 0 == #materialGroup then
    Alert.Show(10475)
    return
  end
  
  local function confirmFunc()
    local hasCommonRefineMtrl = false
    for _, mtrl in pairs(materialGroup) do
      local mtrlItem = ItemDataUtils.GetItemByUid(mtrl.uid)
      if mtrlItem.tid == CommonDefine.CommonRefineMtrlTid then
        hasCommonRefineMtrl = true
        break
      end
    end
    if hasCommonRefineMtrl then
      Alert.Show(20108, nil, function()
        self:_DoRefine(materialGroup)
      end)
    else
      self:_DoRefine(materialGroup)
    end
  end
  
  if self.model:HasLockedCostItem() then
    Alert.Show(20155, nil, confirmFunc)
  else
    confirmFunc()
  end
end

function WeaponRefineComp:_DoRefine(materialGroup)
  local levelAdd = 0
  local haveStrengthenedWeapon = false
  for _, mtrl in pairs(materialGroup) do
    local mtrlItem = ItemDataUtils.GetItemByUid(mtrl.uid)
    if mtrlItem.level > 0 then
      haveStrengthenedWeapon = true
    end
    levelAdd = levelAdd + (mtrlItem.level + 1) * (mtrl.num or 1)
  end
  local maxLevel = self.refineStageMaxLevel
  local oldLevel = self.model.weapon.level
  if haveStrengthenedWeapon then
    local desc
    local newLevel = oldLevel + levelAdd
    if maxLevel < newLevel then
      desc = LT.Textf(DT.TipsType[20051].Desc, maxLevel)
      Alert.Show(20051, nil, function()
        self.model:ReqRefineWeapon(function(itemList)
          self:HideMtrlSelectionPanel()
          EventMgr.Instance.OnWeaponRefineSuccessList:Dispatch()
          self.timer = self.binder:BindTimer(1.5, 0, nil, function()
            UIManager.Instance:Reopen(Urls.AwakerWeaponRefineSuccessPanel, self.model, oldLevel, maxLevel, itemList)
          end)
        end)
      end, nil, desc, nil)
    else
      desc = LT.Textf(DT.TipsType[20050].Desc, newLevel)
      Alert.Show(20050, nil, function()
        self.model:ReqRefineWeapon(function(itemList)
          self:HideMtrlSelectionPanel()
          EventMgr.Instance.OnWeaponRefineSuccessList:Dispatch()
          self.timer = self.binder:BindTimer(1.5, 0, nil, function()
            UIManager.Instance:Reopen(Urls.AwakerWeaponRefineSuccessPanel, self.model, oldLevel, newLevel, itemList)
          end)
        end)
      end, nil, desc, nil)
    end
  else
    local newLevel = math.min(oldLevel + levelAdd, maxLevel)
    self.model:ReqRefineWeapon(function(itemList)
      self:HideMtrlSelectionPanel()
      EventMgr.Instance.OnWeaponRefineSuccessList:Dispatch()
      self.timer = self.binder:BindTimer(1.5, 0, nil, function()
        UIManager.Instance:Reopen(Urls.AwakerWeaponRefineSuccessPanel, self.model, oldLevel, newLevel, itemList)
      end)
    end)
  end
end

function WeaponRefineComp:_BatchSelectMtrls()
  local currLevel = self.model:GetWeaponlevel()
  local numLevelsCanUpgrade = self.refineStageMaxLevel - currLevel
  local numSlotsCanUse = CommonDefine.RefineMtrlSlotCount
  local awakerWeaponModel = self.model:GetAwakerWeaponModel()
  for _, mtrl in ipairs(awakerWeaponModel.selectedCostItemGroup) do
    local item = ItemDataUtils.GetItemByUid(mtrl.uid)
    local levelAdd = (item.level + 1) * (mtrl.num or 1)
    numLevelsCanUpgrade = numLevelsCanUpgrade - levelAdd
    numSlotsCanUse = numSlotsCanUse - 1
  end
  local isInputOtherMaterial = false
  local mtrlList = awakerWeaponModel:GetCurrDisplayWeaponMtrlList()
  for _, mtrl in ipairs(mtrlList) do
    local mtrlCfg = DT.Item[mtrl.tid]
    if numLevelsCanUpgrade <= 0 then
      break
    end
    local item = ItemDataUtils.GetItemByUid(mtrl.uid)
    if item.awaker and item.awaker > 0 then
    else
      if awakerWeaponModel:GetSelectedChangeWeaponByUid(mtrl.uid) then
        if mtrlCfg.Type == "Weapon" then
          goto lbl_94
        end
      elseif numSlotsCanUse <= 0 then
        goto lbl_94
      end
      if mtrlCfg.Type == "Weapon" then
        awakerWeaponModel:AddSelectedCostItemGroup(mtrl.uid, self.model.weapon)
        local levelAdd = (item.level + 1) * (mtrl.num or 1)
        numLevelsCanUpgrade = numLevelsCanUpgrade - levelAdd
        numSlotsCanUse = numSlotsCanUse - 1
      end
    end
    ::lbl_94::
  end
  if numSlotsCanUse >= CommonDefine.RefineMtrlSlotCount and not isInputOtherMaterial then
    Alert.Show(10756)
  end
end

return WeaponRefineComp
