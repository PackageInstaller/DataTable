local BuyConfirmPreviewView, Super = NewClass("BuyConfirmPreviewView", BaseView)
BuyConfirmPreviewView.uiResCls = UI_Passport_Popup_RechargeResource

function BuyConfirmPreviewView:ctor(viewData)
  Super.ctor(self)
  self.viewData = viewData or {}
end

function BuyConfirmPreviewView:OnEnterView()
  self:RefreshView()
end

function BuyConfirmPreviewView:RegisterEvents()
  self:AddButtonClickListener(self.ui.Btn_Confirm, System.fn(self, self._OnBtnConfirm))
  self:AddButtonClickListener(self.ui.Btn_Cancel, System.fn(self, self._OnBtnCancel))
end

function BuyConfirmPreviewView:_OnBtnConfirm()
  if self.viewData.confirmFunc then
    self.viewData.confirmFunc()
  end
  self:Close()
end

function BuyConfirmPreviewView:_OnBtnCancel()
  if self.viewData.cancelFunc then
    self.viewData.cancelFunc()
  end
  self:Close()
end

function BuyConfirmPreviewView:RefreshView()
  self:SetText(self.ui.Text_Title, self.viewData.title or "")
  self:SetText(self.ui.Text_BuyTip, self.viewData.topDesc or "")
  self:SetText(self.ui.Text_CostTip, self.viewData.bottomDesc or "")
  local parentTransform = self.ui.Group_Rewards.transform
  local listLen = #(self.viewData.rewardInfoList or {})
  local cnt = self:ReserveChildren(parentTransform, listLen)
  for i = 1, listLen do
    local go = parentTransform:GetChild(i - 1).gameObject
    go:SetActive(true)
    local reardInfo = self.viewData.rewardInfoList[i]
    local viewData = {
      itemTid = reardInfo.tid,
      itemCount = reardInfo.num
    }
    self:AddViewComponentOnce(go, CompPublicIconItemType2, viewData)
  end
  for i = listLen + 1, cnt do
    local go = parentTransform:GetChild(i - 1).gameObject
    go:SetActive(false)
  end
end

return BuyConfirmPreviewView
