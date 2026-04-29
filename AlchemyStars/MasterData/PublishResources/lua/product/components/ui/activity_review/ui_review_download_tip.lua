_class("UIReviewDownloadTip", UIController)
UIReviewDownloadTip = UIReviewDownloadTip

function UIReviewDownloadTip:LoadDataOnEnter(TT, res)
  res:SetSucc(true)
end

function UIReviewDownloadTip:OnShow(uiParams)
  self:InitWidget()
  self._data = uiParams[1]
  self.size:SetText(StringTable.Get("str_review_download_tip_size", string.format("%.2f", self._data:DownloadPackageSize() / 1024 / 1024)))
end

function UIReviewDownloadTip:InitWidget()
  self.size = self:GetUIComponent("UILocalizationText", "size")
  self.title = self:GetUIComponent("UILocalizationText", "title")
end

function UIReviewDownloadTip:CancelOnClick(go)
  self:CloseDialog()
end

function UIReviewDownloadTip:ConfirmOnClick(go)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.UIReviewOnDownloadStart, self._data:ActivityID())
  self:CloseDialog()
end
