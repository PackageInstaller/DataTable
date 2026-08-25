local CollectionUnlockConfirmView, Super = NewClass("CollectionUnlockConfirmView", BaseView)
CollectionUnlockConfirmView.uiResCls = UI_Collection_Panel_UnlockResource

function CollectionUnlockConfirmView:ctor(title, content, costItems, callback)
  Super.ctor(self)
  self.title = title
  self.content = content
  self.costItems = costItems
  self.callback = callback
end

function CollectionUnlockConfirmView:RegisterEvents()
end

function CollectionUnlockConfirmView:_OnClickConfirm()
  local costItemTid, costNum = self:_GetCostInfo()
  if costNum > ItemDataUtils.GetItemNum(costItemTid) then
    Alert.ShowWithParams(10646, {
      ItemDataUtils.GetItemName(costItemTid)
    })
    return
  end
  if self.callback then
    self.callback()
    self:Close()
  end
end

function CollectionUnlockConfirmView:OnBuildView()
end

function CollectionUnlockConfirmView:OnEnterView()
  Super.OnEnterView(self)
  self:_RefreshView()
end

function CollectionUnlockConfirmView:_RefreshView()
  self:_RefreshConfirmTipsInfo()
  self:_RefreshTexts()
  self:_RefreshCostInfo()
  self:_RefreshCurrencyInfo()
end

function CollectionUnlockConfirmView:_RefreshCurrencyInfo()
  local costItemTid, _ = self:_GetCostInfo()
  local currencyList = {costItemTid}
  self:AddViewComponentOnce(self.ui.UI_Common_Item_Coin_Group, UICompCommonCurrencyGroupItem, currencyList)
end

function CollectionUnlockConfirmView:_RefreshCostInfo()
  local costItemTid, costNum = self:_GetCostInfo()
  self:SetText(self.ui.Text_Cost, costNum)
  local colorType = self:_CheckCurrencyEnough() and CommonDefine.ColorType.Dark or CommonDefine.ColorType.Light
  self:SetTextColorType(self.ui.Text_Cost, colorType)
  self:SetImage(self.ui.Image_Cost, ItemDataUtils.GetIcon(costItemTid))
end

function CollectionUnlockConfirmView:_RefreshTexts()
  self:SetText(self.ui.Text_Title, self.title)
  self:SetText(self.ui.Text_Tips, self.content)
end

function CollectionUnlockConfirmView:_RefreshConfirmTipsInfo()
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

function CollectionUnlockConfirmView:_GetCostInfo()
  do return table.unpack end
  return table.unpack, self.costItems or {}
end

function CollectionUnlockConfirmView:_CheckCurrencyEnough()
  local costItemTid, costNum = self:_GetCostInfo()
  return costNum <= ItemDataUtils.GetItemNum(costItemTid)
end

return CollectionUnlockConfirmView
