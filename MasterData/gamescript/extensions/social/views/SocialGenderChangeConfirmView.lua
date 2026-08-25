local SocialGenderChangeConfirmView, Super = NewClass("SocialGenderChangeConfirmView", BaseView)
SocialGenderChangeConfirmView.uiResCls = UI_Social_Popup_SwitchGenderResource

function SocialGenderChangeConfirmView:ctor(callback)
  Super.ctor(self)
  self.callback = callback
end

function SocialGenderChangeConfirmView:RegisterEvents()
end

function SocialGenderChangeConfirmView:_OnClickConfirm()
  local targetGenderId = PlayerDataUtils.GetOtherGender()
  local costItemTid, costNum = self:_GetCostInfo()
  if self:_CheckIsFreeChange() then
    GenderReqUtils.ReqChangeGender(targetGenderId, System.fn(self, self._OnChangeSuccessful))
    return
  end
  if self:_CheckCurrencyEnough() then
    GenderReqUtils.ReqChangeGender(targetGenderId, System.fn(self, self._OnChangeSuccessful))
  else
    local ownNum = ItemDataUtils.GetItemNum(costItemTid)
    DiamondShopDataUtils.RechargeTips(costNum - ownNum)
  end
end

function SocialGenderChangeConfirmView:_OnChangeSuccessful()
  if self.callback then
    self.callback()
  end
  local targetGenderId = PlayerDataUtils.GetGender()
  local targetGenderStr = PlayerDataUtils.GetGenderName(targetGenderId)
  Alert.ShowStr(LT.Textf("GenderChangeSuccessfulTips", targetGenderStr))
  self:Close()
end

function SocialGenderChangeConfirmView:OnEnterView()
  Super.OnEnterView(self)
  self:_RefreshView()
end

function SocialGenderChangeConfirmView:_RefreshView()
  self:_RefreshConfirmTipsInfo()
  self:_RefreshConfirmContent()
  self:_RefreshCostInfo()
  self:_RefreshCurrencyInfo()
end

function SocialGenderChangeConfirmView:_RefreshCurrencyInfo()
  local costItemTid, _ = self:_GetCostInfo()
  local currencyList = {costItemTid}
  self:AddViewComponentOnce(self.ui.UI_Common_Item_Coin_Group, UICompCommonCurrencyGroupItem, currencyList)
end

function SocialGenderChangeConfirmView:_RefreshCostInfo()
  if self:_CheckIsFreeChange() then
    self:SetActive(self.ui.Text_Cost, false)
    return
  end
  self:SetActive(self.ui.Text_Cost, true)
  local costItemTid, costNum = self:_GetCostInfo()
  self:SetText(self.ui.Text_Cost, costNum)
  local colorType = self:_CheckCurrencyEnough() and CommonDefine.ColorType.Dark or CommonDefine.ColorType.Light
  self:SetTextColorType(self.ui.Text_Cost, colorType)
  self:SetImage(self.ui.Image_Cost, ItemDataUtils.GetIcon(costItemTid))
end

function SocialGenderChangeConfirmView:_RefreshConfirmContent()
  local targetGenderId = PlayerDataUtils.GetOtherGender()
  local targetGenderStr = PlayerDataUtils.GetGenderName(targetGenderId)
  local showContent = LT.Textf("GenderChangeConfirmContent", targetGenderStr)
  if self:_CheckIsFreeChange() then
    local costItemTid, costNum = self:_GetCostInfo()
    local freeChangeTips = LT.Textf("GenderChangeConfirmFreeTips", ItemDataUtils.GetItemName(costItemTid), costNum)
    showContent = string.format([[
%s 
 %s]], showContent, freeChangeTips)
  end
  self:SetText(self.ui.Text_Tips, showContent)
end

function SocialGenderChangeConfirmView:_RefreshConfirmTipsInfo()
  local confirmBtnTipsData = {
    clickFunc = System.fn(self, self._OnClickConfirm),
    stateFunc = function()
      return CommonDefine.BtnType.High
    end
  }
  local cancelBtnTipsData = {
    clickFunc = System.fn(self, self.Close),
    stateFunc = function()
      return CommonDefine.BtnType.High
    end
  }
  local viewData = {
    sizeType = CommonDefine.ConfirmTipsType.S,
    textTitleCN = LT.Text("GenderChangeConfirmTitle"),
    confirmBtnTipsData = confirmBtnTipsData,
    cancelBtnTipsData = cancelBtnTipsData
  }
  self:AddViewComponentOnce(self.ui.UI_Common_Popup_Tips_Confirm_S, CompPublicPopupConfirmTips, viewData)
end

function SocialGenderChangeConfirmView:_CheckIsFreeChange()
  return PlayerDataUtils.GetGenderChangeTimes() <= 0
end

function SocialGenderChangeConfirmView:_GetCostInfo()
  do return table.unpack, DT.GetOriginalConstant("ChangeGenderConsume") end
  return table.unpack, DT.GetOriginalConstant("ChangeGenderConsume")
end

function SocialGenderChangeConfirmView:_CheckCurrencyEnough()
  local costItemTid, costNum = self:_GetCostInfo()
  return costNum <= ItemDataUtils.GetItemNum(costItemTid)
end

return SocialGenderChangeConfirmView
