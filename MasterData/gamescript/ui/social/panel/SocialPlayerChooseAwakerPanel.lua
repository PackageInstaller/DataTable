local AwakerSchool = CommonDefine.AwakerSchool
local SocialPlayerChooseAwakerPanel, Super = System.NewClass("SocialPlayerChooseAwakerPanel", UIBasePanel)
SocialPlayerChooseAwakerPanel.uiResCls = UI_Team_Popup_Awaker_ListResource

function SocialPlayerChooseAwakerPanel:ctor(initData)
  Super.ctor(self)
  self.initData = initData
  self.confirmCb = initData and initData.confirmCb
end

function SocialPlayerChooseAwakerPanel:OnBind(binder)
  self.binder = binder
  self.model = binder:createModel(SocialPlayerChooseAwakerModel, self.initData)
  binder:SetActive(self.ui.Image_Detail, false)
  binder:SetActive(self.ui.UI_Common_Glass, true)
  binder:SetActive(self.ui.Image_Bg, true)
  self:_BindToggles(binder)
  self:_BindEmptyShow(binder)
  self:_BindSortComp(binder)
  self:_BindScrollView(binder)
  self:_BindButtons(binder)
end

function SocialPlayerChooseAwakerPanel:_BindToggles(binder)
  local toggleCfgs = {
    {
      ui = self.ui.Toggle_All,
      school = self.model:GetSchoolAll()
    },
    {
      ui = self.ui.Toggle_Hundun,
      school = AwakerSchool.Aequor
    },
    {
      ui = self.ui.Toggle_Shenhai,
      school = AwakerSchool.NewAequor
    },
    {
      ui = self.ui.Toggle_Xuerou,
      school = AwakerSchool.Caro
    },
    {
      ui = self.ui.Toggle_Chaowei,
      school = AwakerSchool.Dimension
    }
  }
  for i = 1, #toggleCfgs do
    local toggleCfg = toggleCfgs[i]
    if not toggleCfg then
    else
      local ui = toggleCfg.ui
      local school = toggleCfg.school
      binder:BindToZ1Toggle(ui, nil, function(isOn)
        if isOn then
          self.model:SetCurrSchool(school)
        end
      end, function()
        return school == self.model.curSchool
      end)
    end
  end
  binder:SetZ1Toggle(self.ui.Toggle_All, true)
end

function SocialPlayerChooseAwakerPanel:_BindEmptyShow(binder)
  binder:SetText(self.ui.Text_Tips, LT.Text("Formation_SelectRole_Nothing_Tips"))
  binder:BindToVisible(self.ui.Group_No_Awaker, function()
    return not self.model.showAwakers or #self.model.showAwakers <= 0
  end)
end

function SocialPlayerChooseAwakerPanel:_BindSortComp(binder)
  local commonFilterListData = {
    sortTypeList = self.model.sortTypeList,
    selectedFunc = function(sortType)
      return self.model.sortType == sortType
    end,
    callback = function(tid)
      if not tid then
        return
      end
      self.model:SetSortType(tid)
      self.model:SetShowSortType(false)
    end
  }
  binder:BindComponent(CommonFilterList(self.ui.ScrollView_Sort_List, commonFilterListData))
  binder:BindButtonClick(self.ui.Btn_Sort_Group_Mask, System.bind(self._OnClickSortTypeBtn, self, false))
  binder:BindToVisible(self.ui.Btn_Sort_Group_Mask, function()
    return self.model.showSortType
  end)
  binder:BindToAnimator(self.ui.ScrollView_Sort_List, function(_, animator, show)
    AnimatorUtils.SetStateEndInBehavior(animator, "Close", function()
      if not self.ui then
        return
      end
      binder:SetActive(self.ui.ScrollView_Sort_List, false)
    end)
    local name = show and "Open" or "Close"
    if "Open" == name then
      return
    end
    local state = string.format("Base Layer.%s", name)
    AnimatorUtils.PlayState(animator, state)
  end, nil, function()
    return self.model.showSortType
  end)
  binder:BindToRaw(function(_, nVal, oVal)
    if nVal then
      if nVal == oVal then
        return
      end
      self.model:SortShowAwakers()
    end
  end, function()
    return self.model.sortType
  end)
  binder:BindToRaw(function(_, nVal)
    if not nVal then
      return
    end
    self.model:SortShowAwakers()
  end, function()
    return self.model.sortOrder
  end)
  binder:BindToText(self.ui.Text_Battle, function()
    do return AwakerDataUtils.GetSortTypeTitle end
    return AwakerDataUtils.GetSortTypeTitle, self.model.sortType
  end)
  binder:BindToText(self.ui.Text_Sort, function()
    if self.model.sortOrder == CommonDefine.SortOrder.Descend then
      do return LT.Text end
      return LT.Text, "ActorString_Sort_Descend"
    end
    do return LT.Text end
    return LT.Text, "ActorString_Sort_Ascend"
  end)
  binder:BindButtonClick(self.ui.Btn_Battle, System.fn(self, self._OnClickSortTypeBtn))
  binder:BindButtonClick(self.ui.Btn_Sort, System.fn(self, self._OnClickSortOrderBtn))
  binder:BindButtonClick(self.ui.Btn_Mask, System.fn(self, self.Close))
end

function SocialPlayerChooseAwakerPanel:_BindScrollView(binder)
  binder:BindToCircularListView(self.ui.ScrollView_Awaker_List, System.fn(self, self._GetShowAwakers), System.fn(self, self._UpdateAwakerItem))
end

function SocialPlayerChooseAwakerPanel:_GetShowAwakers()
  return self.model.showAwakers
end

function SocialPlayerChooseAwakerPanel:_UpdateAwakerItem(binder, obj, index)
  local awakerTid = self.model.showAwakers[index]
  local awakerData = self.model:GetAwakerData(awakerTid)
  local ui = UI_Awaker_Item_ListResource(obj)
  binder:UpdateLocalizedTextAndResouce(obj)
  self:_BindAwakerItem(binder, ui, awakerData)
end

function SocialPlayerChooseAwakerPanel:_BindAwakerItem(binder, ui, data)
  binder:BindToImage(ui.Image_Career_Icon, function()
    local awakerTid = data.tid
    local awakerConfig = AwakerDataUtils.GetAwakerConfig(awakerTid)
    local iconPath = AwakerDataUtils.GetSchoolIcon(awakerConfig.School)
    return iconPath
  end)
  binder:BindToImage(ui.Image_Awaker, function()
    do return AwakerDataUtils.GetAwakerBust, data.tid end
    return AwakerDataUtils.GetAwakerBust, data.tid, data.curSkin
  end)
  binder:BindToImage(ui.Image_D_Quality_Color, function()
    do return AwakerDataUtils.GetAwakerQualityColor end
    return AwakerDataUtils.GetAwakerQualityColor, data.tid
  end)
  binder:BindToText(ui.Text_Level, function()
    do return AwakerDataUtils.GetSortTypeTagContent, self.model.sortType, data end
    return AwakerDataUtils.GetSortTypeTagContent, self.model.sortType, data, data.level
  end)
  binder:BindToVisible(ui.Image_Select, function()
    if not self.model.singleChoose then
      return false
    end
    do return table.contains, self.model.chooseAwakers end
    return table.contains, self.model.chooseAwakers, data.tid
  end)
  binder:BindToVisible(ui.Image_Select_Bg, function()
    if self.model.singleChoose then
      return false
    end
    do return table.contains, self.model.chooseAwakers end
    return table.contains, self.model.chooseAwakers, data.tid
  end)
  binder:BindToVisible(ui.Image_Collect, function()
    do return AwakerDataUtils.GetAwakerCollectStateByTid end
    return AwakerDataUtils.GetAwakerCollectStateByTid, data.tid
  end)
  local isNotOwnedAwaker = data.state ~= CommonDefine.AwakerState.Owned
  if data.state == nil then
    isNotOwnedAwaker = not AwakerDataUtils.HasOwnedAwaker(data.tid)
  end
  binder:BindButtonClick(ui.Btn_Click, function()
    local isRemove = not self.model.singleChoose and table.contains(self.model.chooseAwakers, data.tid)
    if isRemove then
      self.model:RemoveChosenAwaker(data.tid)
      return
    end
    if not self.model.singleChoose and self.model:IsReachMax() then
      Alert.Show(10751)
      return
    end
    if not self.model.singleChoose and not self.model:CheckChosenAwakerForm(data.tid) then
      Alert.Show(10762)
      return
    end
    for _, tid in ipairs(self.model.chooseAwakers) do
      if tid then
        local awakerFormTid = AwakerDataUtils.GetChangerForm(tid)
        if awakerFormTid and awakerFormTid == data.tid then
          break
        end
      end
    end
    self.model:AddChosenAwaker(data.tid)
  end)
  if not self.model.singleChoose then
    if ui.Text_Wrong then
      binder:BindToText(ui.Text_Wrong, function()
        local wrongTips = ""
        if not self.model:CheckChosenAwakerForm(data.tid) then
          wrongTips = LT.Text("AwakerFormConflict")
        end
        return wrongTips
      end)
    end
    if ui.Image_wrong then
      binder:BindToVisible(ui.Image_wrong, function()
        local valid = self.model:CheckChosenAwakerForm(data.tid)
        return not valid
      end)
    end
  end
  if ui.Group_None then
    binder:BindToVisible(ui.Group_None, function()
      return isNotOwnedAwaker
    end)
  end
  if ui.Image_OwnedAwaker then
    binder:BindToVisible(ui.Image_OwnedAwaker, function()
      return false
    end)
  end
  if ui.Text_OwnedAwaker then
    binder:BindToVisible(ui.Text_OwnedAwaker, function()
      return false
    end)
  end
  self:_BindPotencyShow(binder, ui, data)
  self:_BindAwakerFavor(binder, ui, data)
end

function SocialPlayerChooseAwakerPanel:_BindAwakerFavor(binder, ui, data)
  if not ui.Image_AwakerFavor then
    return
  end
  binder:BindToVisible(ui.Image_AwakerFavor, function()
    do return FavorabilityVisualUtils.IsPremiumCardFaceUnlocked, data.tid end
    return FavorabilityVisualUtils.IsPremiumCardFaceUnlocked, data.tid, data
  end)
end

function SocialPlayerChooseAwakerPanel:_BindPotencyShow(binder, ui, awakerData)
  binder:BindToRaw(function(childBinder, data)
    if not data then
      return
    end
    local awakerTid = data[1]
    local potency = data[2]
    childBinder:BindComponent(CommonAwakerPotencyItem(ui.UI_Common_Item_Potency, {awakerTid = awakerTid, potency = potency}))
  end, function()
    return {
      awakerData.tid,
      awakerData.potencyLevel
    }
  end)
  binder:BindToVisible(ui.UI_Common_Item_Potency, function()
    local awakerTid = awakerData.tid
    do return AwakerDataUtils.HasOwnedAwaker end
    return AwakerDataUtils.HasOwnedAwaker, awakerTid
  end)
end

function SocialPlayerChooseAwakerPanel:_BindButtons(binder)
  binder:BindZ1Button(self.ui.Btn_Select, System.fn(self, self._OnClickConfirm), function()
    if not self.model.allowEmpty and #self.model.chooseAwakers <= 0 then
      return CommonDefine.BtnType.Unclickable
    end
    if self.model.singleChoose and self.model.chooseAwakers[1] == self.initData.chosenAwakers[1] then
      if self.initData.sameChosenAsEmpty == true then
        return CommonDefine.BtnType.High
      end
      return CommonDefine.BtnType.Unclickable
    end
    return CommonDefine.BtnType.High
  end, function()
    if self.model.singleChoose and self.initData.sameChosenAsEmpty == true and self.model.chooseAwakers[1] == self.initData.chosenAwakers[1] then
      return self.initData.sameChosenConfirmText or "下场"
    end
    do return LT.Text end
    return LT.Text, "Formation_Fast_Sure_Btn"
  end)
end

function SocialPlayerChooseAwakerPanel:_OnClickSortTypeBtn(show)
  if nil == show then
    show = not self.model.showSortType
  end
  self.model:SetShowSortType(show)
  if show then
    self.binder:SetActive(self.ui.ScrollView_Sort_List, true)
  end
end

function SocialPlayerChooseAwakerPanel:_OnClickSortOrderBtn()
  local order = CommonDefine.SortOrder.Descend
  if self.model.sortOrder == order then
    order = CommonDefine.SortOrder.Ascend
  end
  self.model:SetSortOrder(order)
end

function SocialPlayerChooseAwakerPanel:SortList()
end

function SocialPlayerChooseAwakerPanel:_OnClickConfirm()
  if not self.model.allowEmpty and #self.model.chooseAwakers <= 0 then
    Alert.Show(10749)
    return
  end
  if self.model.singleChoose and self.model.chooseAwakers[1] == self.initData.chosenAwakers[1] then
    if self.initData.sameChosenAsEmpty == true then
      if self.confirmCb then
        self.confirmCb({})
      end
      self:Close()
      return
    end
    local awakerName = AwakerDataUtils.GetAwakerName(self.model.chooseAwakers[1])
    local tips = LT.Textf(DT.TipsType[10748].Desc, awakerName)
    Alert.Show(10748, nil, nil, nil, tips)
    return
  end
  if self.confirmCb then
    self.confirmCb(table.clone(self.model.chooseAwakers))
  end
  self:Close()
end

function SocialPlayerChooseAwakerPanel:Close()
  local binder = self.binder
  binder:SetActive(self.ui.UI_Common_Glass, false)
  binder:SetActive(self.ui.Image_Bg, false)
  Super.Close(self)
end

return SocialPlayerChooseAwakerPanel
