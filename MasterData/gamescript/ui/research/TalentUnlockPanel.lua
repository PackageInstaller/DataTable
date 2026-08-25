local TalentUnlockPanel, Super = System.NewClass("TalentUnlockPanel", UIBasePanel)
TalentUnlockPanel.uiResCls = UI_Common_Popup_Tip_3Resource

function TalentUnlockPanel:ctor(talentConfigId, awakerConfigId)
  Super.ctor(self)
  self.talentConfigId = talentConfigId
  self.awakerConfigId = awakerConfigId
end

function TalentUnlockPanel:OnBind(binder)
  self.binder = binder
  self:BindVisible()
  self:BindCost()
  self:BindBtnAndContent()
  binder:BindButtonClick(self.ui.Btn_Mask, function()
    self:Close()
  end)
end

function TalentUnlockPanel:BindVisible()
  self.ui.Text_Bottom:SetActive(false)
  self.ui.Toggle_Screening:SetActive(false)
  self.ui.Group_Need:SetActive(true)
end

function TalentUnlockPanel:BindCost()
  local binder = self.binder
  local cfgList = DT.GetOriginalConstant("SpecialSkill_Unlock_ConsumeGoldCoins")
  local itemId = cfgList[1]
  local need = cfgList[2]
  local ownNum = ItemDataUtils.GetItemNum(itemId)
  binder:BindToImage(self.ui.Image_icon_2, function()
    do return ItemDataUtils.GetItemIcon end
    return ItemDataUtils.GetItemIcon, itemId
  end)
  local numText = ItemDataUtils.GetItemNumText(need, ownNum)
  binder:SetText(self.ui.Text_coin, numText)
end

function TalentUnlockPanel:BindBtnAndContent()
  local binder = self.binder
  local tipsConfig = DT.TipsType[10595]
  local confirmBtnTipsData = {
    clickFunc = System.fn(self, self.OnConfirmClick)
  }
  local cancelBtnTipsData = {
    clickFunc = System.fn(self, self.Close)
  }
  local commonPopupConfirmTipsData = {
    sizeType = CommonDefine.ConfirmTipsType.M,
    confirmBtnTipsData = confirmBtnTipsData,
    cancelBtnTipsData = cancelBtnTipsData,
    textTitleCN = LT.Text(tipsConfig.Title)
  }
  binder:BindComponent(CommonPopupConfirmTips(self.ui.UI_Common_Popup_Tips_Confirm_S, commonPopupConfirmTipsData))
end

function TalentUnlockPanel:Close()
  Super.Close(self)
end

function TalentUnlockPanel:OnConfirmClick()
  local function successFunc(_)
    TalentDataUtils.UpdateSingleTalentData(self.talentConfigId, self.awakerConfigId)
  end
  
  local failFunc
  ProtoManager.Instance:ReqServer("GameRequest", "UnlockAwakerTalent", successFunc, failFunc, self.talentConfigId, self.awakerConfigId)
  self:Close()
end

return TalentUnlockPanel
