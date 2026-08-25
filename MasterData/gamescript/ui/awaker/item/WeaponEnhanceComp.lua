local WeaponEnhanceComp, Super = System.NewComponent("WeaponEnhanceComp")

function WeaponEnhanceComp:ctor(uiNode, model, refineModel, mtrlSlotsModel)
  Super.ctor(self)
  self.ui = UI_Awaker_Item_Weapon_StrengthenResource(uiNode)
  self.model = model
  self.refineModel = refineModel
  self.mtrlSlotsModel = mtrlSlotsModel
  self.breakthroughStars = AwakerBreakthroughStars(self.ui.RootStars, CommonDefine.WeaponEnhance.MaxBreakthroughStar)
end

function WeaponEnhanceComp:OnBind(binder)
  self.binder = binder
  self:_SetDisplayState(binder)
  self:_OnBindEnhanceUI(binder)
  self:_OnBindBreakthroughUI(binder)
  self:_OnBindRefineUI(binder)
  binder:BindToRaw(function(childBinder, refineOnly)
    if not refineOnly then
      self.ui.Toggle_Enhance:SetActive(true)
      self.ui.Toggle_Refine:SetActive(true)
      self.ui.Toggle_Backtrack:SetActive(true)
      self.ui.RootEnhance:SetActive(true)
      self.ui.RootRefine:SetActive(false)
      binder:SetZ1Toggle(self.ui.Toggle_Enhance, true)
      binder:BindToZ1Toggle(self.ui.Toggle_Enhance, nil, function(isOn)
        binder:SetZ1Toggle(self.ui.Toggle_Refine, not isOn)
        self.refineComp.ui.Image_Backtrace:SetActive(false)
        self.ui.RootEnhance:SetActive(isOn)
      end)
      binder:SetZ1Toggle(self.ui.Toggle_Refine, false)
      binder:BindToZ1Toggle(self.ui.Toggle_Refine, nil, function(isOn)
        binder:SetZ1Toggle(self.ui.Toggle_Enhance, not isOn)
        self.ui.RootRefine:SetActive(isOn)
        self.refineComp.ui.Image_Backtrace:SetActive(true)
        self:_RefreshSelectWeapon()
        if isOn then
          self.refineComp.ui.Image_Overlay:SetActive(true)
          self.mtrlSlotsModel:ClearSlots()
        end
      end)
    else
      self.ui.Toggle_Enhance:SetActive(false)
      self.ui.Toggle_Refine:SetActive(true)
      self.ui.RootEnhance:SetActive(false)
      self.ui.RootRefine:SetActive(true)
      self:_RefreshSelectWeapon()
      binder:BindToZ1Toggle(self.ui.Toggle_Refine, nil, function(isOn)
        binder:SetZ1Toggle(self.ui.Toggle_Enhance, not isOn)
        binder:SetZ1Toggle(self.ui.Toggle_Backtrack, not isOn)
        self.ui.RootRefine:SetActive(isOn)
        self.refineComp.ui.Image_Backtrace:SetActive(false)
        self:_RefreshSelectWeapon()
        if isOn then
          self.refineComp.ui.Image_Overlay:SetActive(true)
          self.mtrlSlotsModel:ClearSlots()
        end
      end)
      binder:SetZ1Toggle(self.ui.Toggle_Refine, true)
      childBinder:BindToRaw(function(cb2, weapon, o)
        if weapon and BackTrackDataUtils.IsWeaponOpen(weapon.tid, weapon.uid) then
          self.ui.Toggle_Backtrack:SetActive(true)
          cb2:SetZ1Toggle(self.ui.Toggle_Backtrack, false)
          cb2:BindToZ1Toggle(self.ui.Toggle_Backtrack, nil, function(isOn)
            cb2:SetZ1Toggle(self.ui.Toggle_Refine, not isOn)
            cb2:SetZ1Toggle(self.ui.Toggle_Enhance, not isOn)
            self.ui.RootRefine:SetActive(isOn)
            self.refineComp.ui.Image_Overlay:SetActive(false)
            self:_RefreshSelectWeapon()
            if isOn then
              RedPointDataUtils.RemoveBackTrackOnceRed(weapon.uid)
              self.refineComp.ui.Image_Backtrace:SetActive(true)
            end
          end)
          local ui = UI_Common_Toggle_ListResource(self.ui.Toggle_Backtrack)
          cb2:BindComponent(RedDotComponent(ui.Com_RedDot_UnSelect, CommonDefine.RedDotType.Dot, function()
            do return RedPointDataUtils.IsBackTrackShowRed end
            return RedPointDataUtils.IsBackTrackShowRed, weapon.uid
          end))
          cb2:BindComponent(RedDotComponent(ui.Com_RedDot_Select, CommonDefine.RedDotType.Dot, function()
            do return RedPointDataUtils.IsBackTrackShowRed end
            return RedPointDataUtils.IsBackTrackShowRed, weapon.uid
          end))
        else
          self.ui.Toggle_Backtrack:SetActive(false)
          self.refineComp.ui.Image_Backtrace:SetActive(false)
        end
      end, function()
        return self.model.weapon
      end)
    end
  end, function()
    do return self.model.RefineOnly end
    return self.model.RefineOnly, self.model
  end)
  local awakerModel = self.refineModel.awakerWeaponModel.awakerModel
  binder:BindToRaw(function(_, newPage, oldPage)
    if newPage == CommonDefine.AwakerPage.WeaponEnhance then
      self:ShowRefine()
      if self.model:HasOwner() then
        self.ui.Image_Small_Avatar:SetActive(true)
        binder:SetImage(self.ui.Image_Avatar, self.model:GetAwakerIcon())
      else
        self.ui.Image_Small_Avatar:SetActive(false)
      end
      local reachLevelLimit = self.model:IsReachEnhanceLevelLimit()
      local reachBreakthroughLimit = self.model:IsReachBreakthroughLimit()
      self.ui.Btn_BreakthroughPreview:SetActive(not reachLevelLimit and not reachBreakthroughLimit)
      self.model:CalcBreakthroughPreview()
      self:_SetBreakthroughUIDisplayState(binder, reachLevelLimit)
    end
    if oldPage == CommonDefine.AwakerPage.WeaponEnhance then
      self.ui.RootToggles:SetActive(true)
      self.refineComp:HideMtrlSelectionPanel()
    end
  end, function()
    return awakerModel.page
  end)
  local currencyList = DT.GetOriginalConstant("GeneralCultivationNeedCurreny")
  binder:BindComponent(CommonCurrencyGroupItem(self.ui.UI_Common_Item_Coin_Group, currencyList, false, true))
  binder:BindToText(self.ui.Text_Weapon_Name, function()
    do return self.model.GetWeaponName end
    return self.model.GetWeaponName, self.model
  end)
end

function WeaponEnhanceComp:ShowRefine()
  self.binder:SetZ1Toggle(self.ui.Toggle_Refine, true)
  self.ui.RootEnhance:SetActive(false)
  self.ui.RootRefine:SetActive(true)
  if self.refineComp then
    self.refineComp:HideMtrlSelectionPanel()
  end
end

function WeaponEnhanceComp:_RefreshSelectWeapon()
  if self.ui.RootRefine.activeSelf and self.refineComp then
    self.refineComp:HideMtrlSelectionPanel()
    self.refineComp:RefreshSelectWeapon()
  end
end

function WeaponEnhanceComp:_SetDisplayState(binder)
  binder:BindToRaw(function(_, reachLevelLimit)
    local text = reachLevelLimit and LT.Text("BreakThrough_Btn_Str") or LT.Text("Battle_Strengthen_Str")
    binder:SetText(self.ui.Toggle_Enhance_Text_1, text)
    binder:SetText(self.ui.Toggle_Enhance_Text_2, text)
    self.ui.RootStars:SetActive(reachLevelLimit)
    self.ui.Image_Progress:SetActive(not reachLevelLimit)
    self.ui.Image_Breakthrough_Level:SetActive(reachLevelLimit)
    self.ui.Image_Material:SetActive(not reachLevelLimit)
    self.ui.Image_Breakthrough_Material:SetActive(reachLevelLimit)
    self.ui.Weapon_Enhance_Attribute:SetActive(not reachLevelLimit)
    self.ui.Weapon_Breakthrough_Attribute:SetActive(reachLevelLimit)
    local reachBreakthroughLimit = self.model:IsReachBreakthroughLimit()
    self.ui.Btn_BreakthroughPreview:SetActive(not reachLevelLimit and not reachBreakthroughLimit)
    self.ui.Btn_Enhance:SetActive(not reachLevelLimit)
    self.ui.Image_Coin_Icon_Enhance:SetActive(not reachLevelLimit)
    self.ui.Image_Coin_Icon:SetActive(reachLevelLimit)
    self:_SetBreakthroughUIDisplayState(binder, reachLevelLimit)
  end, function()
    do return self.model.IsReachEnhanceLevelLimit end
    return self.model.IsReachEnhanceLevelLimit, self.model
  end)
end

function WeaponEnhanceComp:_SetBreakthroughUIDisplayState(binder, reachLevelLimit)
  if reachLevelLimit then
    if self.model:IsReachBreakthroughLimit() then
      self.ui.Image_Breakthrough_Level:SetActive(false)
      self.ui.Image_Breakthrough_Level_Max:SetActive(true)
      self.ui.Image_Breakthrough_Material:SetActive(false)
      self.ui.Image_Coin_Icon:SetActive(false)
      self.ui.Group_Warning:SetActive(true)
      binder:SetText(self.ui.Text_Warning, LT.Text("WeaponReachBreakthroughLimit"))
      self.ui.Btn_Breakthrough:SetActive(false)
    else
      self.ui.Image_Breakthrough_Level:SetActive(true)
      self.ui.Image_Breakthrough_Level_Max:SetActive(false)
      self.ui.Image_Breakthrough_Material:SetActive(true)
      self.ui.Image_Coin_Icon:SetActive(true)
      local playerLevel = DataCenter.playerData.DRole.level
      local requiredPlayerLevel = self.model:GetNextBreakthroughPlayerLevel()
      local playerLevelSatisfied = false
      if requiredPlayerLevel > 0 and playerLevel >= requiredPlayerLevel then
        playerLevelSatisfied = true
      end
      if not playerLevelSatisfied then
        self.ui.Group_Warning:SetActive(true)
        binder:SetText(self.ui.Text_Warning, LT.Textf("WeaponBreakthroughPlayerLevelRequire", requiredPlayerLevel))
        self.ui.Btn_Breakthrough:SetActive(false)
      else
        self.ui.Group_Warning:SetActive(false)
        self.ui.Btn_Breakthrough:SetActive(true)
      end
    end
  else
    self.ui.Image_Breakthrough_Level:SetActive(false)
    self.ui.Image_Breakthrough_Level_Max:SetActive(false)
    self.ui.Image_Breakthrough_Material:SetActive(false)
    self.ui.Image_Coin_Icon:SetActive(false)
    self.ui.Group_Warning:SetActive(false)
    self.ui.Btn_Breakthrough:SetActive(false)
  end
end

function WeaponEnhanceComp:_OnBindEnhanceUI(binder)
  binder:BindToRaw(function(_, levelPreview)
    binder:SetText(self.ui.Text_Enhance_Level_Before, "Lv." .. levelPreview.before)
    if levelPreview.after > 0 and levelPreview.after ~= levelPreview.before then
      self.ui.Image_H_Arrow:SetActive(true)
      self.ui.Image_V_Arrow:SetActive(true)
      self.ui.Text_Enhance_Level_After:SetActive(true)
      binder:SetText(self.ui.Text_Enhance_Level_After, "Lv." .. levelPreview.after)
    else
      self.ui.Image_H_Arrow:SetActive(false)
      self.ui.Image_V_Arrow:SetActive(false)
      self.ui.Text_Enhance_Level_After:SetActive(false)
    end
  end, function()
    do return self.model.GetEnhanceLevelPreview end
    return self.model.GetEnhanceLevelPreview, self.model
  end)
  binder:BindToRaw(function(_, expPreview)
    local curr = expPreview.curr
    local max = expPreview.max
    binder:SetText(self.ui.Text_Exp_Progress, string.format("%s/%s", curr, max))
  end, function()
    do return self.model.GetEnhanceExpPreview end
    return self.model.GetEnhanceExpPreview, self.model
  end)
  binder:BindToSliderValue(self.ui.Slider_Exp_Progress, function()
    local expPreview = self.model:GetEnhanceExpPreview()
    return expPreview.curr / expPreview.max
  end)
  binder:BindComponent(WeaponAttrComp(self.ui.Weapon_Enhance_Attribute, self.model, true))
  binder:BindToRaw(function(_, numMtrls)
    local numSlots = self.mtrlSlotsModel:GetNumSlots()
    binder:SetText(self.ui.Text_Deplete, LT.Textf("WeaponEnhanceCost", numMtrls, numSlots))
  end, function()
    do return self.mtrlSlotsModel.GetNumMtrls end
    return self.mtrlSlotsModel.GetNumMtrls, self.mtrlSlotsModel
  end)
  binder:BindToRaw(function(_, mtrlType)
    if mtrlType == CommonDefine.WeaponEnhance.AutoMtrlType_1 then
      binder:SetText(self.ui.Text_Mtrl_Type, LT.Text("WeaponEnhanceMtrlType_1"))
    elseif mtrlType == CommonDefine.WeaponEnhance.AutoMtrlType_2 then
      binder:SetText(self.ui.Text_Mtrl_Type, LT.Text("WeaponEnhanceMtrlType_2"))
    end
  end, function()
    do return self.mtrlSlotsModel.GetAutoSelectMtrlType end
    return self.mtrlSlotsModel.GetAutoSelectMtrlType, self.mtrlSlotsModel
  end)
  self.ui.Root_Mtrl_Types:SetActive(false)
  binder:BindButtonClick(self.ui.Btn_Select_Mtrl_Type, function()
    local value = self.ui.Root_Mtrl_Types.activeSelf
    self.ui.Root_Mtrl_Types:SetActive(not value)
  end)
  binder:SetText(self.ui.Text_Mtrl_Type_1, LT.Text("WeaponEnhanceMtrlType_1"))
  binder:BindButtonClick(self.ui.Btn_Mtrl_Type_1, function()
    self.mtrlSlotsModel:SetAutoSelectMtrlType(CommonDefine.WeaponEnhance.AutoMtrlType_1)
    self.ui.Root_Mtrl_Types:SetActive(false)
  end)
  binder:SetText(self.ui.Text_Mtrl_Type_2, LT.Text("WeaponEnhanceMtrlType_2"))
  binder:BindButtonClick(self.ui.Btn_Mtrl_Type_2, function()
    self.mtrlSlotsModel:SetAutoSelectMtrlType(CommonDefine.WeaponEnhance.AutoMtrlType_2)
    self.ui.Root_Mtrl_Types:SetActive(false)
  end)
  local mtrlModel = binder:createModel(AwakerWeaponEnhanceMtrlModel, self.mtrlSlotsModel, self.model)
  binder:BindButtonClick(self.ui.Btn_Auto_Select, function()
    mtrlModel:FillSlotsWithMaterials()
  end)
  binder:BindToCircularListView(self.ui.ScrollView_Materials, function()
    do return self.mtrlSlotsModel.GetSlots end
    return self.mtrlSlotsModel.GetSlots, self.mtrlSlotsModel
  end, function(itemBinder, obj, index)
    local slots = self.mtrlSlotsModel:GetSlots()
    itemBinder:BindComponent(WeaponEnhanceMtrlSlot(obj, slots[index], mtrlModel, self.model))
  end)
  binder:BindToRaw(function(_, goldCost)
    local gold = ItemDataUtils.GetItemByTid(CommonDefine.CurrencyType.JuniorMoney)
    local goldCount = gold and gold.num or 0
    goldCost = math.ceil(goldCost)
    self.goldEnoughForEnhance = goldCount >= goldCost
    if self.goldEnoughForEnhance then
      binder:SetText(self.ui.Text_Coin_Count_Enhance, goldCost)
    else
      goldCost = string.format("<Color4:%d>", goldCost)
      binder:SetText(self.ui.Text_Coin_Count_Enhance, goldCost)
    end
  end, function()
    local currExp = self.model:GetTotalEnhanceExp()
    local expToLevelLimit = self.model:GetTotalExpToEnhanceLevelLimit()
    local ratio = DT.GetConstant("RatioOfGoldToBasicExperienceWhenUpgradingWeapon")
    local goldCost_1 = self.mtrlSlotsModel:GetGoldCost()
    local goldCost_2 = (expToLevelLimit - currExp) * ratio
    do return math.min, goldCost_1 end
    return math.min, goldCost_1, goldCost_2
  end)
  binder:BindButtonClick(self.ui.Btn_Enhance, function()
    local mtrlList = {}
    local slots = self.mtrlSlotsModel:GetSlots()
    for _, slot in ipairs(slots) do
      if slot.uid then
        table.insert(mtrlList, {
          tid = slot.tid,
          uid = slot.uid,
          count = slot.count
        })
      end
    end
    if #mtrlList > 0 then
      if not self.goldEnoughForEnhance then
        Alert.Show(10462)
        return
      end
      local hasEnhancedWeapon, hasRefinedWeapon, hasSROrSSRWeapon
      local confirmInfo = {}
      for _, mtrl in ipairs(mtrlList) do
        local itemCfg = ItemDataUtils.GetItemConfig(mtrl.tid)
        if itemCfg.Type == CommonDefine.ItemType.Weapon then
          local item = ItemDataUtils.GetItemByUid(mtrl.uid)
          if not hasEnhancedWeapon and (item.enhanceLevel and item.enhanceLevel > 1 or item.exp and item.exp > 0) then
            hasEnhancedWeapon = true
            table.insert(confirmInfo, LT.Text("WeaponEnhanced"))
          end
          if not hasRefinedWeapon and item.level and item.level > 1 then
            hasRefinedWeapon = true
            table.insert(confirmInfo, LT.Text("WeaponRefined"))
          end
          if not hasSROrSSRWeapon and (itemCfg.Quality == "Orange" or itemCfg.Quality == "Purple") then
            hasSROrSSRWeapon = true
            table.insert(confirmInfo, LT.Text("WeaponHigherQuality"))
          end
        end
      end
      if #confirmInfo > 0 then
        local strConfirmInfo = table.concat(confirmInfo, "，")
        local desc = LT.Textf(DT.TipsType[20083].Desc, strConfirmInfo)
        Alert.Show(20083, nil, function()
          self:_DoEnhance(mtrlList)
        end, nil, desc, nil)
      else
        self:_DoEnhance(mtrlList)
      end
    else
      Alert.Show(10583)
    end
  end)
  binder:BindButtonClick(self.ui.Btn_BreakthroughPreview, function()
    local model = binder:createModel(WeaponBreakthroughCostPreviewModel, self.model)
    UIManager.Instance:Reopen(Urls.AwakerWeaponBreakthroughCostPreviewPanel, model)
  end)
end

function WeaponEnhanceComp:_DoEnhance(mtrlList)
  self.model:ReqEnhanceWeapon(mtrlList, function(backItems)
    UIManager.Instance:Reopen(Urls.AwakerWeaponLevelUpSuccessPanel, self.model, function()
      self.mtrlSlotsModel:ClearSlots()
      if backItems then
        local items = {}
        for _, item in ipairs(backItems) do
          table.insert(items, {
            tid = item.tid,
            changedNum = item.num
          })
        end
        ItemDataUtils.ShowRewardPanel(LT.Text("WeaponOverflowReturn"), "", items)
      end
    end)
  end)
end

function WeaponEnhanceComp:_OnBindBreakthroughUI(binder)
  binder:BindToRaw(function(_, numStars)
    for idx = 1, self.breakthroughStars:NumStars() do
      if idx <= numStars then
        self.breakthroughStars:TurnOn(idx)
      elseif idx == numStars + 1 then
        self.breakthroughStars:PreTurnOn(idx)
      else
        self.breakthroughStars:TurnOff(idx)
      end
    end
  end, function()
    do return self.model.GetBreakthroughStar end
    return self.model.GetBreakthroughStar, self.model
  end)
  binder:BindToRaw(function(_, reachLevelLimit)
    if reachLevelLimit then
      self.model:CalcBreakthroughPreview()
      local model = binder:createModel(WeaponBreakthroughCostPreviewModel, self.model)
      local preview = model:GetPreview()
      self:_OnBindBreakthroughCostPreview(binder, preview)
    end
  end, function()
    do return self.model.IsReachEnhanceLevelLimit end
    return self.model.IsReachEnhanceLevelLimit, self.model
  end)
  binder:BindToRaw(function(_, preview)
    if not preview then
      return
    end
    local before = string.format("<color=white>Lv.%s</color>/%s", preview.level, preview.currLevelLimit)
    binder:SetText(self.ui.Text_Breakthrough_Level_Before, before)
    binder:SetText(self.ui.Text_Breakthrough_Level_Max, before)
    if preview.nextLevelLimit > preview.currLevelLimit then
      self.ui.Image_Breakthrough_H_Arrow:SetActive(true)
      self.ui.Image_Breakthrough_V_Arrow:SetActive(true)
      self.ui.Text_Breakthrough_Level_After:SetActive(true)
      local after = string.format("<color=white>Lv.%s</color>/%s", preview.level, preview.nextLevelLimit)
      binder:SetText(self.ui.Text_Breakthrough_Level_After, after)
    else
      self.ui.Image_Breakthrough_H_Arrow:SetActive(false)
      self.ui.Image_Breakthrough_V_Arrow:SetActive(false)
      self.ui.Text_Breakthrough_Level_After:SetActive(false)
    end
  end, function()
    do return self.model.GetEnhanceLevelBreakthroughPreview end
    return self.model.GetEnhanceLevelBreakthroughPreview, self.model
  end)
  binder:BindComponent(WeaponAttrComp(self.ui.Weapon_Breakthrough_Attribute, self.model, false))
  binder:BindButtonClick(self.ui.Btn_Breakthrough, function()
    if not self.goldEnoughForBreakthrough then
      Alert.Show(10462)
      return
    end
    self.model:ReqBreakthroughWeapon(function()
      UIManager.Instance:Reopen(Urls.AwakerWeaponBreakthroughSuccessPanel, self.model, function()
        self.model:UpdateEnhancePreview(0)
      end)
    end)
  end)
end

function WeaponEnhanceComp:_OnBindBreakthroughCostPreview(binder, preview)
  local mtrlRootTrans = self.ui.MaterialRoot.transform
  for idx = 0, mtrlRootTrans.childCount - 1 do
    local mtrlGO = mtrlRootTrans:GetChild(idx).gameObject
    local mtrlCost = preview.mtrl[idx + 1]
    if mtrlCost and mtrlCost.id and mtrlCost.count > 0 then
      mtrlGO:SetActive(true)
      local item = ItemDataUtils.GetItemByTid(mtrlCost.id)
      local itemInfo = {
        id = mtrlCost.id,
        currCount = item and item.num or 0,
        requiredCount = mtrlCost.count
      }
      binder:BindComponent(AwakerBreakthroughMaterial(mtrlGO, itemInfo, false))
    else
      mtrlGO:SetActive(false)
    end
  end
  local gold = ItemDataUtils.GetItemByTid(CommonDefine.CurrencyType.JuniorMoney)
  local goldCount = gold and gold.num or 0
  self:_UpdateGoldCost(binder, goldCount, preview.gold)
  binder:BindToRaw(function(_, nVal)
    self:_UpdateGoldCost(binder, nVal, preview.gold)
  end, function()
    local goldId = CommonDefine.CurrencyType.JuniorMoney
    do return ItemDataUtils.GetItemNum end
    return ItemDataUtils.GetItemNum, goldId
  end)
end

function WeaponEnhanceComp:_UpdateGoldCost(binder, goldCount, goldCost)
  self.goldEnoughForBreakthrough = goldCost <= goldCount
  if self.goldEnoughForBreakthrough then
    binder:SetText(self.ui.Text_Coin_Count, goldCost)
  else
    goldCost = string.format("<Color4:%d>", goldCost)
    binder:SetText(self.ui.Text_Coin_Count, goldCost)
  end
end

function WeaponEnhanceComp:_OnBindRefineUI(binder)
  self.refineComp = binder:BindComponent(WeaponRefineComp(self.ui.RootRefine, self.refineModel))
  self.refineComp:SetBackTrackCallBack(function()
    self.refineModel.awakerWeaponModel.awakerModel:SetAwakerPage(CommonDefine.AwakerPage.WeaponChange)
  end)
end

function WeaponEnhanceComp:OnUnbind()
  Super.OnUnbind(self)
end

function WeaponEnhanceComp:ClearMtrlSlots()
  if self.mtrlSlotsModel then
    self.mtrlSlotsModel:ClearSlots()
  end
end

return WeaponEnhanceComp
