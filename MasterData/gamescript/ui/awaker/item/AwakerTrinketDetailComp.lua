local AwakerPage = CommonDefine.AwakerPage
local AwakerTrinketDetailComp, Super = System.NewComponent("AwakerTrinketDetailComp")

function AwakerTrinketDetailComp:ctor(uiNode, model, trinketModel, strengthenModel)
  Super.ctor(self)
  self.ui = UI_Awaker_Popup_Trinket_ChangeResource(uiNode)
  self.model = model
  self.trinketModel = trinketModel
  self.strengthenModel = strengthenModel
end

function AwakerTrinketDetailComp:OnBind(binder)
  self:BindConstrast(binder)
  self:BindTrinketDetailsInfo(binder)
  self:BindIntensity(binder)
  self:BindEquipTrinket(binder)
  binder:BindToVisible(self.ui.Group_Equipped, function()
    if 0 == self.trinketModel.equippedTrinketUid then
      return false
    end
    local isSelectEquipping = self.trinketModel.equippedTrinketUid == self.trinketModel.selectTrinketUid
    return isSelectEquipping and not self.trinketModel.compareMode
  end)
end

function AwakerTrinketDetailComp:BindConstrast(binder)
  binder:BindToVisible(self.ui.Btn_Contrast, function()
    local isSelectEquipping = self.trinketModel.equippedTrinketUid == self.trinketModel.selectTrinketUid
    return self.trinketModel.equippedTrinketUid > 0 and (self.trinketModel.compareMode or not isSelectEquipping)
  end)
  binder:BindButtonClick(self.ui.Btn_Contrast, function()
    if self.trinketModel.maskCompareButton then
      return
    end
    local targetState = not self.trinketModel.compareMode
    self.trinketModel:SetCompareMode(targetState)
  end)
  binder:BindToVisible(self.ui.Group_Contrast, function()
    return self.trinketModel.compareMode
  end)
  binder:BindToText(self.ui.Text_Contrast, function()
    local showKey = "TrinketContrast"
    if self.trinketModel.compareMode then
      showKey = "TrinketStow"
    end
    do return LT.Text end
    return LT.Text, showKey
  end)
  binder:BindToRaw(function(childBinder, _, _)
    childBinder:BindTimer(0.1, 0, nil, function()
      self.trinketModel:SetMaskCompareButton(false)
    end)
  end, function()
    return self.trinketModel.compareMode
  end)
end

function AwakerTrinketDetailComp:BindTrinketDetailsInfo(binder)
  local selectedItemData = {
    model = self.trinketModel,
    showType = CommonDefine.AwakerTrinketDetailShowType.Selected,
    selectAwakerTid = self.model.selectAwakerId
  }
  binder:BindComponent(AwakerTrinketDetailItem(self.ui.Group_Trinket_Detail_Now, selectedItemData))
  local equippedItemData = {
    model = self.trinketModel,
    showType = CommonDefine.AwakerTrinketDetailShowType.Equipped,
    selectAwakerTid = self.model.selectAwakerId
  }
  binder:BindComponent(AwakerTrinketDetailItem(self.ui.Group_Trinket_Detail_Contrast, equippedItemData))
  binder:BindToVisible(self.ui.Group_Trinket_Detail_Now, function()
    local selectTrinketUid = self.trinketModel.selectTrinketUid
    return selectTrinketUid > 0
  end)
  binder:BindUICustomInput(self.ui.Group_Trinket_Detail_Contrast, function(hover)
    if not hover then
      self.trinketModel:SetCompareMode(false)
      self.trinketModel:SetMaskCompareButton(true)
    end
  end)
end

function AwakerTrinketDetailComp:BindIntensity(binder)
  binder:BindZ1Button(self.ui.Btn_Intensify, function()
    if self.model.page ~= AwakerPage.TrinketChange then
      return
    end
    local _, unlocked = PlayerDataUtils.IsFeatureUnlock(CommonDefine.FeatureId.TrinketLevelUp, 0)
    if not unlocked then
      PlayerDataUtils.AlertLockedTips(CommonDefine.FeatureId.TrinketLevelUp, 0)
      return
    end
    local selectTrinketUid = self.trinketModel.selectTrinketUid
    UIManager.Instance:Reopen(Urls.TrinketStrengthenPanel, nil, selectTrinketUid)
  end, function()
    local _, unlocked = PlayerDataUtils.IsFeatureUnlock(CommonDefine.FeatureId.TrinketLevelUp, 0)
    if not unlocked then
      return CommonDefine.BtnType.Unclickable
    end
    return CommonDefine.BtnType.High
  end, function()
    do return LT.Text end
    return LT.Text, "RoleDetailsEquipDetails_Btn_LevelUp"
  end)
  binder:BindToVisible(self.ui.Btn_Intensify, function()
    local list = self.trinketModel.trinketShowList
    return #list > 0
  end)
end

function AwakerTrinketDetailComp:BindEquipTrinket(binder)
  binder:BindZ1Button(self.ui.Btn_Change, function()
    local awakerTid = self.model.selectAwakerId
    local selectTrinketUid = self.trinketModel.selectTrinketUid
    local equippedTrinketUid = self.trinketModel.equippedTrinketUid
    Logger.Info("awakerTid=%s, selectTrinketUid=%s, equippedTrinketUid=%s", awakerTid, selectTrinketUid, equippedTrinketUid)
    if selectTrinketUid == equippedTrinketUid then
      self.trinketModel:ReqPutOffTrinket(selectTrinketUid)
      return
    end
    self.trinketModel:ReqPutOnTrinket(awakerTid, selectTrinketUid, function()
      self.trinketModel:SetCompareMode(false)
      self.trinketModel:SetSelectTrinketUid(selectTrinketUid)
    end)
  end, function()
    return self.trinketModel.putOnBtnData.state
  end, function()
    return self.trinketModel.putOnBtnData.text
  end, nil, nil, nil)
  binder:BindToVisible(self.ui.Btn_Change, function()
    local list = self.trinketModel.trinketShowList
    return #list > 0
  end)
end

function AwakerTrinketDetailComp:OnUnbind()
  Super.OnUnbind(self)
end

return AwakerTrinketDetailComp
