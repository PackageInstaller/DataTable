local T_Upgrade = CommonDefine.TrinketStrengthenTap.Upgrade
local T_Conversion = CommonDefine.TrinketStrengthenTap.Conversion
local TrinketStrengthenPanel, Super = System.NewClass("TrinketStrengthenPanel", UIBasePanel)
TrinketStrengthenPanel.uiResCls = UI_Awaker_Item_Trinket_RefinementResource

function TrinketStrengthenPanel:ctor(strengthenType, trinketUid, trinketModel)
  Super.ctor(self)
  self.strengthenType = strengthenType or CommonDefine.TrinketStrengthenTap.Upgrade
  self.trinketUid = trinketUid
  self.trinketModel = trinketModel
end

function TrinketStrengthenPanel:OnBind(binder)
  self:CreateTrinketModels(binder)
  self:BindTrinketStrengthenType(binder)
  self:BindAwakerInfo(binder)
  self:InitLabels(binder)
  self:BindCurrency(binder)
  binder:BindComponent(BtnCloseItem(self.ui.UI_Common_Btn_Back3, function()
    if self:_IsConversionAutoTranscribing() then
      return
    end
    self:Close()
  end))
end

function TrinketStrengthenPanel:_IsConversionAutoTranscribing()
  if self.conversionComp and self.conversionComp:IsAutoTranscribing() then
    Alert.Show("TrinketAutoRefineExitTips")
    return true
  end
  return false
end

function TrinketStrengthenPanel:PushBackCommand()
  local cmd
  cmd = {
    uiPanel = self,
    Execute = function()
      if self:_IsConversionAutoTranscribing() then
        UIBackCommandStack.Push(cmd)
        return
      end
      self:Close()
    end
  }
  UIBackCommandStack.Push(cmd)
end

function TrinketStrengthenPanel:InitLabels(binder)
  binder:SetText(self.ui.Text_C_Refinement, LT.Text("TrinketStrengthTitle"))
  binder:SetText(self.ui.Text_C_Name_1, LT.Text("TrinketUpgrade"))
  binder:SetText(self.ui.Text_C_Name_2, LT.Text("TrinketConversion"))
end

function TrinketStrengthenPanel:CreateTrinketModels(binder)
  if not self.trinketModel then
    local awakerModel = binder:createModel(AwakerModel)
    self.trinketModel = binder:createModel(AwakerTrinketModel, awakerModel)
  end
  self.strengthenModel = binder:createModel(TrinketStrengthenModel, self.strengthenType, self.trinketUid)
end

function TrinketStrengthenPanel:BindAwakerInfo(binder)
  binder:BindToVisible(self.ui.Image_Small_Avatar, function()
    local ownAwaker = self.strengthenModel:GetOwner()
    return ownAwaker and ownAwaker > 0
  end)
  binder:BindToImage(self.ui.Image_Avatar, function()
    do return self.strengthenModel.GetOwnerSmallIcon end
    return self.strengthenModel.GetOwnerSmallIcon, self.strengthenModel
  end)
end

function TrinketStrengthenPanel:BindTrinketStrengthenType(binder)
  binder:BindToVisible(self.ui.UI_Awaker_Popup_Trinket_Upgrade, function()
    return self.strengthenModel:GetStrengthedType() == T_Upgrade
  end)
  binder:BindToVisible(self.ui.UI_Awaker_Popup_Trinket_Conversion, function()
    return self.strengthenModel:GetStrengthedType() == T_Conversion
  end)
  binder:BindToZ1Toggle(self.ui.Toggle_Upgrade, nil, function(isOn)
    if isOn then
      if self:_IsConversionAutoTranscribing() then
        binder:SetZ1Toggle(self.ui.Toggle_Upgrade, false, true)
        binder:SetZ1Toggle(self.ui.Toggle_Conversion, true, true)
        return
      end
      self.strengthenModel:SetStrengthedType(T_Upgrade)
    elseif self.strengthenModel:GetStrengthedType() == T_Upgrade then
      binder:SetZ1Toggle(self.ui.Toggle_Upgrade, true, true)
    end
  end, function()
    return self.strengthenModel:GetStrengthedType() == T_Upgrade
  end)
  binder:BindToZ1Toggle(self.ui.Toggle_Conversion, nil, function(isOn)
    if isOn then
      local _, unlocked = PlayerDataUtils.IsFeatureUnlock(CommonDefine.FeatureId.TrinketConversion, 0)
      if not unlocked then
        PlayerDataUtils.AlertLockedTips(CommonDefine.FeatureId.TrinketConversion, 0)
        binder:SetZ1Toggle(self.ui.Toggle_Conversion, false, true)
        return
      end
      self.strengthenModel:SetStrengthedType(T_Conversion)
    elseif self.strengthenModel:GetStrengthedType() == T_Conversion then
      binder:SetZ1Toggle(self.ui.Toggle_Conversion, true, true)
    end
  end, function()
    return self.strengthenModel:GetStrengthedType() == T_Conversion
  end)
  binder:BindComponent(TrinketUpgradeComp(self.ui.UI_Awaker_Popup_Trinket_Upgrade, self.strengthenModel, self.trinketModel))
  self.conversionComp = TrinketConversionComp(self.ui.UI_Awaker_Popup_Trinket_Conversion, self.strengthenModel, self.trinketModel)
  binder:BindComponent(self.conversionComp)
  binder:BindToVisible(self.ui.Group_Coin, function()
    return not self.conversionComp:IsAutoTranscribing()
  end)
end

function TrinketStrengthenPanel:BindCurrency(binder)
  binder:BindToRaw(function(childbinder, n, _)
    local itemList
    if n == T_Upgrade then
      itemList = {}
      table.insert(itemList, self.strengthenModel:GetUpgradeCurrencyType())
    else
      itemList = table.deepclone(DT.GetOriginalConstant("TrinketRefineCurrencies"))
      local trinketChipTid = AwakerTrinketDataUtils.GetTrinketChipTid(self.strengthenModel.trinketTid)
      if trinketChipTid then
        table.insert(itemList, 1, trinketChipTid)
      end
    end
    childbinder:BindComponent(CommonCurrencyGroupItem(self.ui.Group_Coin, itemList, nil, nil, function()
      do return self._IsConversionAutoTranscribing end
      return self._IsConversionAutoTranscribing, self
    end))
  end, function()
    return self.strengthenModel.strengthedType
  end)
end

return TrinketStrengthenPanel
