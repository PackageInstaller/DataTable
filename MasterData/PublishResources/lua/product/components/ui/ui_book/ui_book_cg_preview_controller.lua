_class("UIBookCGPreviewController", UIController)
UIBookCGPreviewController = UIBookCGPreviewController

function UIBookCGPreviewController:Constructor()
  self._itemCountPerRow = 1
  self._listShowItemCount = 0
  self._bookCGType = BookCGType.Main
  self.showBtns = true
  self._moveTime = 0.5
  self._topBtnTab = {
    [1] = BookCGType.Main,
    [2] = BookCGType.Ext,
    [3] = BookCGType.Pet
  }
  self._btnCount = table.count(self._topBtnTab)
  self._type2tips = {
    [BookCGType.Main] = "str_book_main_cg_active",
    [BookCGType.Ext] = "str_book_ext_cg_active",
    [BookCGType.Season] = "str_book_season_cg_active",
    [BookCGType.Pet] = "str_book_pet_skin_cg_active"
  }
  self._itemWidth = 380
  self._padding = 5
end

function UIBookCGPreviewController:GetComponents()
  self._spine1 = self:GetUIComponent("SpineLoader", "spine1")
  self._spine1Go = self:GetGameObject("spine1")
  self._spine2 = self:GetUIComponent("SpineLoader", "spine2")
  self._spine2Go = self:GetGameObject("spine2")
  self._staticPic = self:GetUIComponent("RawImageLoader", "pic")
  self._staticPicRect = self:GetUIComponent("RectTransform", "pic")
  self._staticPicGO = self:GetGameObject("pic")
  self.topLeftAnchor = self:GetGameObject("TopLeftAnchor")
  self.centerAnchor = self:GetGameObject("CenterAnchor")
  self.topRightAnchor = self:GetGameObject("TopRightAnchor")
  self.descTxt = self:GetUIComponent("UILocalizationText", "desc")
  self.nameTxt = self:GetUIComponent("UILocalizationText", "name")
  local backBtns = self:GetUIComponent("UISelectObjectPath", "backBtns")
  self._backBtns = backBtns:SpawnObject("UICommonTopButton")
  self._backBtns:SetData(function()
    self:CloseDialog()
  end, nil)
  self._sortBtns = self:GetUIComponent("UISelectObjectPath", "sortBtns")
  self._scrollView = self:GetUIComponent("UIDynamicScrollView", "ScrollView")
  self._scrollRt = self:GetUIComponent("RectTransform", "ScrollView")
  self._contentRect = self:GetUIComponent("RectTransform", "Content")
  self._scrollRect = self:GetUIComponent("ScrollRect", "ScrollView")
  self._emptyDataTip = self:GetGameObject("EmptyTip")
  self._emptyDataTip:SetActive(false)
  self._animation = self:GetGameObject():GetComponent(typeof(UnityEngine.Animation))
  self:StartAnim("uieff_BookCG_In", 500)
  self._topBlackSide = self:GetGameObject("Top")
  self._bottomBlackSide = self:GetGameObject("Bottom")
  self._leftBlackSide = self:GetGameObject("Left")
  self._rightBlackSide = self:GetGameObject("Right")
  self._uiCanvasRect = self:GetUIComponent("RectTransform", "UICanvas")
end

function UIBookCGPreviewController:OnValue()
  self:InitTopBtns()
  self:CalcPetScrollViewCount()
  self:_InitSrollView()
  local cgs = self:SetDataList(self._bookCGType)
  local active = false
  local id
  for index, value in ipairs(cgs) do
    if value.active then
      active = true
      id = value.id
      self.selectIndex = index
      break
    end
  end
  if id then
    self:OnClickCell(id)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.OnCgBookListItemClick, id)
  end
end

function UIBookCGPreviewController:OnShow(uiParams)
  self:GetComponents()
  self._bookModule = self:GetModule(BookModule)
  self._cgs = self:SetDataList(self._bookCGType)
  self:AttacEvents()
  self:OnValue()
end

function UIBookCGPreviewController:SetDataList(type)
  local storyData = self._bookModule:GetCGStoryData()
  local _cgs = {}
  for cgId, active in HelperProxy:GetInstance():pairsByKeys(storyData.TypeList[type]) do
    local data = {}
    data.id = cgId
    data.active = active
    table.insert(_cgs, data)
  end
  return _cgs
end

function UIBookCGPreviewController:InitTopBtns()
  self._sortBtns:SpawnObjects("UIBookCGSortBtn", self._btnCount)
  self._sortBtnsPool = self._sortBtns:GetAllSpawnList()
  for i = 1, self._btnCount do
    self._sortBtnsPool[i]:SetData(self._topBtnTab[i], self._bookCGType, function(cgType)
      self:ChangeSortParams(cgType)
    end)
  end
end

function UIBookCGPreviewController:ChangeSortParams(cgType)
  if cgType == self._bookCGType then
    return
  end
  local cgs = self:SetDataList(cgType)
  local active = false
  local id
  for index, value in ipairs(cgs) do
    if value.active then
      active = true
      id = value.id
      self.selectIndex = index
      break
    end
  end
  if not active then
    local tipsStr = StringTable.Get(self._type2tips[cgType])
    ToastManager.ShowToast(tipsStr)
    return
  end
  self._bookCGType = cgType
  self._cgs = cgs
  self:RefrenshCGList()
  self:FlushTopBtnState()
  if id then
    self:OnClickCell(id)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.OnCgBookListItemClick, id)
  end
end

function UIBookCGPreviewController:FlushTopBtnState()
  for i = 1, self._btnCount do
    self._sortBtnsPool[i]:Flush(self._bookCGType)
  end
end

function UIBookCGPreviewController:AttacEvents()
end

function UIBookCGPreviewController:DetachEvents()
end

function UIBookCGPreviewController:OnHide()
  if self._tweener then
    self._tweener:Kill()
    self._tweener = nil
  end
  self:DetachEvents()
  self:DestroyAllSpine()
  GameGlobal.UIStateManager():SetBlackSideVisible(true)
end

function UIBookCGPreviewController:DestroyAllSpine()
  if self._spine1 then
    self._spine1:DestroyCurrentSpine()
  end
  if self._spine2 then
    self._spine2:DestroyCurrentSpine()
  end
end

function UIBookCGPreviewController:_InitSrollView()
  self._scrollView:InitListView(self._listShowItemCount, function(scrollView, index)
    return self:InitSpritListInfo(scrollView, index)
  end)
  self._inited = true
end

function UIBookCGPreviewController:InitSpritListInfo(scrollView, index)
  if index < 0 then
    return nil
  end
  local item = scrollView:NewListViewItem("RowItem")
  local rowPool = self:GetUIComponentDynamic("UISelectObjectPath", item.gameObject)
  if item.IsInitHandlerCalled == false then
    item.IsInitHandlerCalled = true
    rowPool:SpawnObjects("UIBookCGPreviewCell", self._itemCountPerRow)
  end
  local rowList = rowPool:GetAllSpawnList()
  for i = 1, self._itemCountPerRow do
    local cgItem = rowList[i]
    local itemIndex = index * self._itemCountPerRow + i
    if itemIndex > self._petCount then
      cgItem:GetGameObject():SetActive(false)
    else
      self:ShowCGItem(cgItem, itemIndex)
    end
  end
  return item
end

function UIBookCGPreviewController:ShowCGItem(cgItem, index)
  local config = self._cgs[index]
  cgItem:GetGameObject():SetActive(true)
  if config ~= nil then
    cgItem:SetData(config, index, function(id, cell)
      if cell.index == self.selectIndex then
        return
      end
      self.curCell = cell
      self.selectIndex = cell.index
      self:OnClickCell(id)
      GameGlobal.EventDispatcher():Dispatch(GameEventType.OnCgBookListItemClick, id)
    end, self.selectIndex == index)
  end
end

function UIBookCGPreviewController:MovePanelToItemIndex()
  local cellx = 380
  local paddingx = 5
  local contentWidth = #self._cgs * cellx + paddingx * (#self._cgs - 1)
  local scrollWidth = self._scrollRt.rect.width
  if contentWidth < scrollWidth then
    return
  end
  local mIdx
  local showTab = self._scrollView:GetVisibleItemIDsInScrollView()
  if self.selectIndex == 1 or self.selectIndex == 2 then
    local pos = 0
    self:MovePanelToPos(pos)
    return
  end
  if self.selectIndex == #self._cgs or self.selectIndex == #self._cgs - 1 then
    local pos = -1 * (contentWidth - scrollWidth)
    self:MovePanelToPos(pos)
    return
  end
  local clickIdx = self.selectIndex
  local contentX = self._contentRect.anchoredPosition.x
  local left = false
  local leftPos = (clickIdx - 2) * self._itemWidth + (clickIdx - 2) * self._padding
  if leftPos < -1 * contentX then
    left = true
  end
  if left then
    local pos = -1 * leftPos
    self:MovePanelToPos(pos)
    return
  end
  local right = false
  local rightPos = (clickIdx + 1) * self._itemWidth + clickIdx * self._padding
  if rightPos > -1 * contentX + scrollWidth then
    right = true
  end
  if right then
    local pos = -1 * (rightPos - scrollWidth)
    self:MovePanelToPos(pos)
    return
  end
end

function UIBookCGPreviewController:MovePanelToPos(x)
  self._scrollRect:StopMovement()
  if self._tweener then
    self._tweener:Kill()
  end
  self._tweener = self._contentRect:DOAnchorPosX(x, self._moveTime)
end

function UIBookCGPreviewController:OnClickCell(id, idx)
  self:StartAnim("uieff_BookCG_SwitchCG", 500)
  self:DestroyAllSpine()
  if self._inited then
    self:MovePanelToItemIndex()
  end
  local cfg = Cfg.cfg_cg_book[id]
  if cfg.Spine then
    GameGlobal.UIStateManager():SetBlackSideVisible(true)
    self._staticPicGO:SetActive(false)
    self._spine1Go:SetActive(true)
    self._spine1Go.transform.localScale = Vector3(cfg.SpineScale, cfg.SpineScale, cfg.SpineScale)
    local spineName1 = cfg.Spine[1]
    self._spine1:LoadSpine(spineName1)
    local spineName2 = cfg.Spine[2]
    if spineName2 then
      self._spine2Go:SetActive(true)
      self._spine2:LoadSpine(spineName2)
      self._spine2Go.transform.localScale = Vector3(cfg.SpineScale, cfg.SpineScale, cfg.SpineScale)
    end
  else
    GameGlobal.UIStateManager():SetBlackSideVisible(true)
    self._spine1Go:SetActive(false)
    self._spine2Go:SetActive(false)
    self._staticPicGO:SetActive(true)
    self._staticPic:LoadImage(cfg.StaticPic)
    self:_SetPicFullScreen(self._staticPicRect)
  end
  local word = cfg.info
  local name = cfg.name
  self.descTxt:SetText(StringTable.Get(word))
  self.nameTxt:SetText(StringTable.Get(name))
end

function UIBookCGPreviewController:_SetPicFullScreen(rectTrans)
  local fullPicWidth = 2048
  local fullPicHeight = 946
  local screenWidth, screenHeight = self:GetCanvasSize()
  local picAspect = fullPicWidth / fullPicHeight
  local screenAspect = screenWidth / screenHeight
  local blackSideHeight = 0
  local blackSideWidth = 0
  if picAspect > screenAspect then
    local picHeight = fullPicHeight * screenWidth / fullPicWidth
    rectTrans.sizeDelta = Vector2(screenWidth, picHeight)
    blackSideHeight = math.abs(screenHeight - picHeight) / 2
  elseif picAspect < screenAspect then
    local picWidth = fullPicWidth * screenHeight / fullPicHeight
    rectTrans.sizeDelta = Vector2(picWidth, screenHeight)
    blackSideWidth = math.abs(screenWidth - picWidth) / 2
  else
    rectTrans.sizeDelta = Vector2(screenWidth, screenHeight)
  end
  self:SetBlackSideSize(blackSideWidth, blackSideHeight)
end

function UIBookCGPreviewController:SetBlackSideSize(width, height)
  self._topBlackSide:GetComponent("RectTransform").sizeDelta = Vector2(0, height)
  self._bottomBlackSide:GetComponent("RectTransform").sizeDelta = Vector2(0, height)
  self._topBlackSide:SetActive(0 < height)
  self._bottomBlackSide:SetActive(0 < height)
  self._leftBlackSide:GetComponent("RectTransform").sizeDelta = Vector2(width, 0)
  self._rightBlackSide:GetComponent("RectTransform").sizeDelta = Vector2(width, 0)
  self._leftBlackSide:SetActive(0 < width)
  self._rightBlackSide:SetActive(0 < width)
end

function UIBookCGPreviewController:GetCanvasSize()
  return self._uiCanvasRect.sizeDelta.x, self._uiCanvasRect.sizeDelta.y
end

function UIBookCGPreviewController:CalcPetScrollViewCount()
  self.selectIndex = -1
  for index, value in ipairs(self._cgs) do
    if value.active == true then
      self.selectIndex = index
      break
    end
  end
  self._petCount = table.count(self._cgs)
  self._listShowItemCount = math.ceil(self._petCount / self._itemCountPerRow)
  self:CheckEmptyTip()
end

function UIBookCGPreviewController:CheckEmptyTip()
  if self._petCount <= 0 then
    self._emptyDataTip:SetActive(true)
  end
  self._emptyDataTip:SetActive(false)
end

function UIBookCGPreviewController:RefrenshCGList()
  self:CalcPetScrollViewCount()
  self._scrollView:SetListItemCount(self._listShowItemCount)
  self._scrollView:MovePanelToItemIndex(0, 0)
end

function UIBookCGPreviewController:bgbtnOnClick()
  self.showBtns = not self.showBtns
  if self.showBtns then
    self.topLeftAnchor:SetActive(true)
    self.centerAnchor:SetActive(true)
    self.topRightAnchor:SetActive(true)
    self:StartAnim("uieff_BookCG_Back", 500)
  else
    self:StartAnim("uieff_BookCG_Full", 500)
  end
end

function UIBookCGPreviewController:StartAnim(aniName, lastTime)
  self:StartTask(function(TT)
    self:Lock("UIBookCGPreviewController:StartAnim")
    self._animation:Play(aniName)
    YIELD(TT, lastTime)
    self:UnLock("UIBookCGPreviewController:StartAnim")
  end, self)
end
