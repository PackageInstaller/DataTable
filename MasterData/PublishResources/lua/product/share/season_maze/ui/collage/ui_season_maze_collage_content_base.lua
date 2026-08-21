_class("UISeasonMazeCollageContentBase", UICustomWidget)
UISeasonMazeCollageContentBase = UISeasonMazeCollageContentBase

function UISeasonMazeCollageContentBase:Constructor()
  self._bVisible = false
  self._collageDagaMgr = GameGlobal.GetModule(SeasonMazeModule):GetSeasonMazeCollageDataMgr()
  self._itemCountPerRow = 4
  self._listShowItemCount = 0
end

function UISeasonMazeCollageContentBase:InitCommonWidget()
  self._rootGo = self:GetGameObject("Root")
  self.contentScrollView = self:GetUIComponent("UIDynamicScrollView", "ScrollView")
end

function UISeasonMazeCollageContentBase:SetVisible(bVisible)
  self._rootGo:SetActive(bVisible)
  self._bVisible = bVisible
end

function UISeasonMazeCollageContentBase:OnInit(itemClickCb)
  self:SetVisible(false)
  self._itemClickCb = itemClickCb
end

function UISeasonMazeCollageContentBase:OnItemClick(itemID, pos)
  if self.contentScrollView.IsDraging then
    return
  end
  if self._itemClickCb then
    self._itemClickCb(itemID, pos, self:GetCollageType())
  end
end

function UISeasonMazeCollageContentBase:OnEnter()
  if self._bVisible then
    return
  end
  self:SetVisible(true)
  self._dataList = self._collageDagaMgr:GetData(self:GetCollageType())
  self._listShowItemCount = math.ceil(#self._dataList / self._itemCountPerRow)
  self:RefreshScrollView()
  self.contentScrollView:MovePanelToItemIndex(0, 0)
end

function UISeasonMazeCollageContentBase:OnExit()
  if not self._bVisible then
    return
  end
  self:SetVisible(false)
  self:ClearNew()
end

function UISeasonMazeCollageContentBase:ClearNew()
  if self._dataList then
    for k, subData in pairs(self._dataList) do
      if subData:GetNew() then
        subData:SetNewAsRead()
      end
    end
  end
end

function UISeasonMazeCollageContentBase:RefreshScrollView()
  if not self.isDynamicSvInited then
    self.isDynamicSvInited = true
    self.contentScrollView:InitListView(self._listShowItemCount, function(scrollView, index)
      return self:SpawnListItem(scrollView, index)
    end)
  else
    self:_RefreshItemScroll(self._listShowItemCount, self.contentScrollView)
  end
end

function UISeasonMazeCollageContentBase:_RefreshItemScroll(count, list)
  local contentPos = list.ScrollRect.content.localPosition
  list:SetListItemCount(count)
  list:MovePanelToItemIndex(0, 0)
  list.ScrollRect.content.localPosition = contentPos
end

function UISeasonMazeCollageContentBase:SpawnListItem(scrollView, rowIndex)
  Log.exception("UISeasonMazeCollageContentBase:SpawnListItem 需要子类实现该方法")
end
