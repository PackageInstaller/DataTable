_class("UIBookChapterItem", UICustomWidget)
UIBookChapterItem = UIBookChapterItem

function UIBookChapterItem:OnShow(uiParam)
  self._nameLabel = self:GetUIComponent("UILocalizationText", "Name")
  self._unOpenLabel = self:GetUIComponent("UILocalizationText", "UnOpen")
  self._lockGo = self:GetGameObject("Lock")
  self._nameGo = self:GetGameObject("Name")
  self._unOpenGo = self:GetGameObject("UnOpen")
  self._frameGo = self:GetGameObject("Frame")
  self._newGo = self:GetGameObject("New")
end

function UIBookChapterItem:Refresh(bookData, chapterData, index)
  self._chapterData = chapterData
  self._bookData = bookData
  self._index = index
  self._nameLabel.text = StringTable.Get("str_dispatch_book_chapter" .. self._index) .. self._chapterData:GetName()
  self._unOpenLabel.text = StringTable.Get("str_dispatch_book_chapter" .. self._index) .. StringTable.Get("str_dispatch_book_uncollect")
  self._lockGo:SetActive(not self._chapterData:IsOpen())
  self._nameGo:SetActive(self._chapterData:IsOpen())
  self._unOpenGo:SetActive(not self._chapterData:IsOpen())
  self._frameGo:SetActive(self._chapterData:IsOpen())
  self._newGo:SetActive(self._chapterData:IsNew())
end

function UIBookChapterItem:MaskOnClick(go)
  if not self._chapterData:IsOpen() then
    return
  end
  self:Lock("UIBookChapterItem:MaskOnClick")
  GameGlobal.TaskManager():StartTask(self.SetNewStatusCoro, self)
end

function UIBookChapterItem:SetNewStatusCoro(TT)
  self._chapterData:SetNewStatus(TT, false)
  self._newGo:SetActive(self._chapterData:IsNew())
  GameGlobal.EventDispatcher():Dispatch(GameEventType.UpdateBookRedPointStatus)
  self:ShowDialog("UIBookInfoController", self._bookData, self._index)
  self:UnLock("UIBookChapterItem:MaskOnClick")
end

function UIBookChapterItem:LockOnClick(go)
  self:ShowDialog("UIBookInfoController", self._bookData, self._index)
end
