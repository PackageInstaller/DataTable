_class("UIBookController", UIController)
UIBookController = UIBookController

function UIBookController:OnShow(uiParams)
  self._topBarLoader = self:GetUIComponent("UISelectObjectPath", "TopBarLoader")
  self.topButtonWidget = self._topBarLoader:SpawnObject("UICommonTopButton")
  self.topButtonWidget:SetData(function()
    self:OnBack()
  end, nil, function()
    self:OnHome()
  end)
  self._bookScrollView = self:GetUIComponent("UIDynamicScrollView", "BookList")
  self._chapterScrollView = self:GetUIComponent("UIDynamicScrollView", "ChapterList")
  self._chapterPanel = self:GetGameObject("ChapterPanel")
  self._bookNameLabel = self:GetUIComponent("UILocalizationText", "BookName")
  self._bookDesLabel = self:GetUIComponent("UILocalizationText", "BookDes")
  self:_InitData()
  self:_InitUI()
end

function UIBookController:SelectBook(bookData)
  if self._currentSelectBook then
    self._currentSelectBook:SetSelectedStatus(false)
  end
  self._currentSelectBook = bookData
  self._currentSelectBook:SetSelectedStatus(true)
  self._bookScrollView:RefreshAllShownItem()
  self._bookNameLabel.text = self._currentSelectBook:GetName()
  self._bookDesLabel.text = self._currentSelectBook:GetDes()
  self._chapterPanel:SetActive(true)
  self._chapterCount = self._currentSelectBook:GetChapterCount()
  self._chapterScrollView:SetListItemCount(self._chapterCount, true)
  self._chapterScrollView:RefreshAllShownItem()
end

function UIBookController:_InitData()
  self._currentSelectBook = nil
  local bookCfg = Cfg.cfg_book({})
  self.bookCount = table.count(bookCfg)
  self._bookDatas = {}
  self._chapterCount = 0
  for k, v in pairs(bookCfg) do
    self._bookDatas[#self._bookDatas + 1] = BookData:New(v)
  end
  table.sort(self._bookDatas, function(a, b)
    return a:GetIndex() < b:GetIndex()
  end)
end

function UIBookController:_InitUI()
  self._bookScrollView:InitListView(self.bookCount, function(scrollview, index)
    return self:_OnGetBookItem(scrollview, index)
  end)
  self._chapterPanel:SetActive(false)
  self._chapterScrollView:InitListView(self._chapterCount, function(scrollview, index)
    return self:_OnGetChapterItem(scrollview, index)
  end)
  if #self._bookDatas > 0 then
    self:SelectBook(self._bookDatas[1])
  end
end

function UIBookController:_OnGetBookItem(scrollView, index)
  local item = scrollView:NewListViewItem("RowItem")
  local rowPool = self:GetUIComponentDynamic("UISelectObjectPath", item.gameObject)
  if item.IsInitHandlerCalled == false then
    item.IsInitHandlerCalled = true
    rowPool:SpawnObjects("UIBookItem", 1)
  end
  local rowList = rowPool:GetAllSpawnList()
  local itemWidget = rowList[1]
  if itemWidget then
    local itemIndex = index + 1
    if itemIndex > self.bookCount then
      itemWidget:GetGameObject():SetActive(false)
    else
      self:_RefreshBookItemInfo(itemWidget, itemIndex)
      itemWidget:GetGameObject():SetActive(true)
    end
  end
  UIHelper.RefreshLayout(item:GetComponent("RectTransform"))
  return item
end

function UIBookController:_RefreshBookItemInfo(itemWidget, index)
  itemWidget:Refresh(self, self._bookDatas[index])
end

function UIBookController:_OnGetChapterItem(scrollView, index)
  if index < 0 then
    return nil
  end
  local item = scrollView:NewListViewItem("RowItem")
  local rowPool = self:GetUIComponentDynamic("UISelectObjectPath", item.gameObject)
  if item.IsInitHandlerCalled == false then
    item.IsInitHandlerCalled = true
    rowPool:SpawnObjects("UIBookChapterItem", 1)
  end
  local rowList = rowPool:GetAllSpawnList()
  local itemWidget = rowList[1]
  if itemWidget then
    local itemIndex = index + 1
    if itemIndex > self._chapterCount then
      itemWidget:GetGameObject():SetActive(false)
    else
      self:_RefreshChapterItemInfo(itemWidget, itemIndex)
      itemWidget:GetGameObject():SetActive(true)
    end
  end
  UIHelper.RefreshLayout(item:GetComponent("RectTransform"))
  return item
end

function UIBookController:_RefreshChapterItemInfo(itemWidget, index)
  if not self._currentSelectBook then
    return
  end
  local chapters = self._currentSelectBook:GetChapters()
  itemWidget:Refresh(self._currentSelectBook, chapters[index], index)
end

function UIBookController:OnBack()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.UpdateBookRedPointStatus)
  self:CloseDialog()
end

function UIBookController:OnHome()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.AircraftLeaveAircraft)
  GameGlobal.LoadingManager():StartLoading(LoadingHandlerName.Aircraft_Exit, "UI")
end
