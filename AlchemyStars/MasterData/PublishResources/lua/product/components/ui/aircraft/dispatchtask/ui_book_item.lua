_class("UIBookItem", UICustomWidget)
UIBookItem = UIBookItem

function UIBookItem:OnShow(uiParam)
  self._iconImg = self:GetUIComponent("RawImageLoader", "Icon")
  self._nameLabel = self:GetUIComponent("UILocalizationText", "Name")
  self._chapterLabel = self:GetUIComponent("UILocalizationText", "Chapter")
  self._selectedGo = self:GetGameObject("Selected")
  self._newGo = self:GetGameObject("New")
  self:AttachEvent(GameEventType.UpdateBookRedPointStatus, self.UpdateRedPointStatus)
end

function UIBookItem:OnHide()
  self:DetachEvent(GameEventType.UpdateBookRedPointStatus, self.UpdateRedPointStatus)
end

function UIBookItem:Refresh(bookController, bookData)
  self._bookController = bookController
  self._bookData = bookData
  self._nameLabel.text = self._bookData:GetName()
  self._selectedGo:SetActive(self._bookData:IsSelected())
  self._iconImg:LoadImage(self._bookData:GetIcon())
  local str = "<color=#FFB34C>" .. self._bookData:GetOpenChapterCount() .. "</color>/" .. self._bookData:GetChapterCount()
  self._chapterLabel.text = StringTable.Get("str_dispatch_book_ce", str)
  self._newGo:SetActive(self._bookData:IsNew())
end

function UIBookItem:MaskOnClick(go)
  if self._bookData:IsSelected() then
    return
  end
  self._bookController:SelectBook(self._bookData)
end

function UIBookItem:UpdateRedPointStatus()
  self._newGo:SetActive(self._bookData:IsNew())
end
