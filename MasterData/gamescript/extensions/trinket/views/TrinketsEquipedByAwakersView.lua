local TrinketsEquipedByAwakersView, Super = NewClass("TrinketsEquipedByAwakersView", BaseView)
TrinketsEquipedByAwakersView.uiResCls = UI_Common_Popup_Tip_8Resource

function TrinketsEquipedByAwakersView:ctor(trinketList, callback)
  Super.ctor(self)
  self.trinketList = trinketList
  self.callback = callback
end

function TrinketsEquipedByAwakersView:OnBuildView()
  Super.OnBuildView(self)
  local tipConfig = DT.TipsType[20201]
  local confirmBtnTipsData = {
    clickFunc = System.fn(self, self.OnConfirmClick),
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
  local commonPopupConfirmTipsData = {
    textTitleCN = tipConfig.Title and LT.Text(tipConfig.Title) or LT.Text("UniversalAlertTitle"),
    sizeType = CommonDefine.ConfirmTipsType.S,
    confirmBtnTipsData = confirmBtnTipsData,
    cancelBtnTipsData = cancelBtnTipsData
  }
  self.binder:BindComponent(CommonPopupConfirmTips(self.ui.UI_Common_Popup_Tips_Confirm_S, commonPopupConfirmTipsData))
  self:SetText(self.ui.Text_Describe, LT.Text(tipConfig.Desc) or LT.Text("TrinketsEquipedByAwakersTips"))
end

function TrinketsEquipedByAwakersView:OnConfirmClick()
  if self.callback then
    self.callback()
  end
  self:Close()
end

function TrinketsEquipedByAwakersView:OnEnterView()
  Super.OnEnterView(self)
  local ct_transform = self.ui.Content.transform
  local cnt = self:ReserveChildren(ct_transform, #self.trinketList)
  for i = 1, #self.trinketList do
    local go = ct_transform:GetChild(i - 1).gameObject
    go:SetActive(true)
    local itemData = self.trinketList[i]
    
    function itemData.getOwnerTid(uid)
      return itemData.awakerTid
    end
    
    itemData.hideIsNew = true
    
    function itemData.onClick(tid, uid)
      ItemDataUtils.ShowItemDetailTips(self.binder, go, uid, tid)
    end
    
    self:SetIcon(MaterialIconType.CommonIcon, go, itemData)
  end
  for i = #self.trinketList + 1, cnt do
    local go = ct_transform:GetChild(i - 1).gameObject
    go:SetActive(false)
  end
end

return TrinketsEquipedByAwakersView
