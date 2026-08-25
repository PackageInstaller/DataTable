local ResonanceResetConfirmPanel, Super = System.NewClass("ResonanceResetConfirmPanel", UIBasePanel)
ResonanceResetConfirmPanel.uiResCls = UI_Chapter_Popup_ChapterResource

function ResonanceResetConfirmPanel:ctor(resonanceGroupId)
  Super.ctor(self)
  self.resonanceGroupId = resonanceGroupId
end

function ResonanceResetConfirmPanel:OnBind(binder)
  self.binder = binder
  self:BindPopupConfirmContent()
  self:BindCommonPopupConfirmTips()
end

function ResonanceResetConfirmPanel:BindPopupConfirmContent()
  self.binder:BindTimer(0.01, 0, nil, function()
    local itemId, itemNum = ResonanceDataUtils.GetResonanceResetCost(self.resonanceGroupId)
    self.binder:SetText(self.ui.Text_Description, string.format(LT.Text("ResonanceResetCostConfirm"), DT.ColorConfig.TalentNumGreen.Light, itemNum, ItemDataUtils.GetName(itemId)))
    self.binder:SetImage(self.ui.Image_Coin_Icon, ItemDataUtils.GetIcon(itemId))
    local ownedNum = ItemDataUtils.GetItemNum(itemId)
    local numStr = itemNum > ownedNum and string.format("<color=%s>%d</color>/%d", DT.ColorConfig.Red.Light, ownedNum, itemNum) or ownedNum .. "/" .. itemNum
    self.binder:SetText(self.ui.Text_Coin_Count, numStr)
  end)
end

function ResonanceResetConfirmPanel:BindCommonPopupConfirmTips()
  self.textBtnState = Vue.ref(CommonDefine.BtnType.High)
  local confirmBtnTipsData = {
    clickFunc = System.fn(self, self.BtnConfirmClick),
    text = LT.Text("Shop_Confirm_Buy_Btn_Sure"),
    stateFunc = function()
      return self.textBtnState.value
    end
  }
  local cancelBtnTipsData = {
    clickFunc = System.fn(self, self.BtnCancelClick),
    text = LT.Text("Shop_Confirm_Buy_Btn_Back"),
    stateFunc = function()
      return CommonDefine.BtnType.High
    end
  }
  local commonPopupConfirmTipsData = {
    sizeType = CommonDefine.ConfirmTipsType.S,
    confirmBtnTipsData = confirmBtnTipsData,
    cancelBtnTipsData = cancelBtnTipsData,
    textTitleCN = LT.Text("ResonanceReset")
  }
  self.binder:BindComponent(CommonPopupConfirmTips(self.ui.UI_Common_Popup_Tips_Confirm_S, commonPopupConfirmTipsData))
end

function ResonanceResetConfirmPanel:BtnConfirmClick()
  local itemId, itemNum = ResonanceDataUtils.GetResonanceResetCost(self.resonanceGroupId)
  local ownedItemNum = ItemDataUtils.GetItemNum(itemId)
  if itemNum > ownedItemNum then
    Alert.Show(10561)
    return
  end
  ResonanceDataUtils.ReqResetResonance(self.resonanceGroupId, function()
    self:Close()
    Alert.Show(10563)
  end)
end

function ResonanceResetConfirmPanel:BtnCancelClick()
  self:Close()
end

return ResonanceResetConfirmPanel
