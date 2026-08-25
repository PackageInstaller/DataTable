local AddClipToPlay = AnimatorUtils.AddClipToPlay
local UIAnimationController = CS.Z1Client.UIAnimationController
local MainShopResetPanel, Super = System.NewClass("MainShopResetPanel", UIBasePanel)
MainShopResetPanel.uiResCls = UI_Shop_Popup_Buy_ResetResource

function MainShopResetPanel:ctor(itemId, cost, shopType)
  Super.ctor(self)
  self.itemId = itemId
  self.cost = cost
  self.shopType = shopType
end

function MainShopResetPanel:OnBind(binder)
  self.binder = binder
  self:BindText()
  self:BindButton()
  self:ReOpenTextComp()
  self.uiAnimController = self.ui.uiNode:GetComponent(typeof(UIAnimationController))
  local clipsToPlay = ""
  self.uiAnimController:PlayMultiState(AddClipToPlay(clipsToPlay, "UI_Shop_Popup_Buy_Reset_Open"), nil)
end

function MainShopResetPanel:BindText()
  local binder = self.binder
  binder:BindToText(self.ui.Text_coin2, function()
    local color = self.cost > ItemDataUtils.GetItemNum(self.itemId) and "E25312" or "FDFDFD"
    do return LT.Textf, "DailyChallengeStarAward", ItemDataUtils.GetItemNum(self.itemId), string.format("<color=#%s>%s</color>", color, self.cost) end
    return LT.Textf, "DailyChallengeStarAward", ItemDataUtils.GetItemNum(self.itemId), string.format("<color=#%s>%s</color>", color, self.cost)
  end)
  binder:BindToImage(self.ui.Image_Icon_1, function()
    do return ItemDataUtils.GetItemIcon end
    return ItemDataUtils.GetItemIcon, self.itemId
  end)
  binder:BindToImage(self.ui.Image_Icon_2, function()
    do return ItemDataUtils.GetItemIcon end
    return ItemDataUtils.GetItemIcon, self.itemId
  end)
  binder:SetText(self.ui.Text_coin1, MainShopDataUtils.GetRichStr(self.shopType) .. self.cost)
end

function MainShopResetPanel:BindButton()
  local binder = self.binder
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
    cancelBtnTipsData = cancelBtnTipsData
  }
  binder:BindComponent(CommonPopupConfirmTips(self.ui.UI_Common_Popup_Tips_Confirm_S, commonPopupConfirmTipsData))
  binder:BindToRaw(function(_, btnType)
    self.textBtnState.value = btnType
  end, function()
    if self.cost > ItemDataUtils.GetItemNum(self.itemId) then
      return CommonDefine.BtnType.Unclickable
    else
      return CommonDefine.BtnType.High
    end
  end)
end

function MainShopResetPanel:BtnConfirmClick()
  if self.cost > ItemDataUtils.GetItemNum(self.itemId) then
    local desc = string.format(LT.Text("Shop_Buy_Lack_Money"), ItemDataUtils.GetItemName(self.itemId))
    Alert.Show(10434, nil, nil, nil, desc)
    return
  end
  MainShopDataUtils.ReqShopRefresh(self.shopType, function()
    self:Close()
    Alert.Show(10497)
  end)
end

function MainShopResetPanel:BtnCancelClick()
  self:Close()
end

function MainShopResetPanel:ReOpenTextComp()
  self.ui.Group_Buy_Confirm:SetActive(true)
end

return MainShopResetPanel
