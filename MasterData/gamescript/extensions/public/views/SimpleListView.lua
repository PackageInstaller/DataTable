local SimpleListView, Super = NewClass("SimpleListView", BaseView)
SimpleListView.uiResCls = Simple_List_PanelResource
SimpleListView._cachedSearchWord = {}

function SimpleListView:ctor(showList, chooseCallback, enableSearch, panelKey)
  Super.ctor(self)
  self._orgList = showList
  self._showList = showList
  self._chooseCallback = chooseCallback
  self._enableSearch = enableSearch
  self._panelKey = panelKey
  if not panelKey and #(showList or {}) > 0 then
    self._panelKey = showList[#showList].id
  end
end

function SimpleListView:OnBuildView()
  self._cellTemplate = UIUtils.ReplaceCircularListWithTable(self.ui.ShowList)
  if IsNil(self._cellTemplate) then
    Logger.Error("SimpleListView ShowList missing CircularScrollView itemGameObject")
  end
end

function SimpleListView:RegisterNotifications()
end

function SimpleListView:RegisterEvents()
  self:AddButtonClickListener(self.ui.Btn_Exit, function()
    self:Close()
  end)
end

function SimpleListView:OnEnterView()
  Super.OnEnterView(self)
  self:_ResetLastSelect()
  self:_CreateShowListTableview()
  self.ui.SearchText:SetActive(self._enableSearch and true or false)
  if self._enableSearch then
    if self._panelKey and SimpleListView._cachedSearchWord[self._panelKey] then
      self:SetInputText(self.ui.SearchText, SimpleListView._cachedSearchWord[self._panelKey])
    end
    self._searchWord = ""
    self:_OnSearch()
    self:BindTimer(0.5, -1, function()
      self:_OnSearch()
    end)
  end
end

function SimpleListView:OnExitView()
  Super.OnExitView(self)
  UIUtils.DestroyRuntimeTableComponent(self.ui.ShowList)
  self._tableview = nil
end

function SimpleListView:_CreateShowListTableview()
  if IsNil(self._cellTemplate) then
    return
  end
  self._tableview = self:CreateTableview(self.ui.ShowList, function()
    return #self._showList
  end, function(view, index)
    do return self._CellAtIndex, self, view end
    return self._CellAtIndex, self, view, index
  end)
  self._tableview:ReloadData()
end

function SimpleListView:_CellAtIndex(view, index)
  local cell = view:DequeueCell()
  cell = cell or view:AddChild(self._cellTemplate)
  local data = self._showList[index]
  if data then
    self:AddButtonClickListener(cell.gameObject, function()
      self:_SaveLastSelect(data)
      if self._chooseCallback then
        self._chooseCallback(data, index)
        Super.Close(self)
      end
    end)
    local textNode = cell.gameObject.transform:GetChild(0).gameObject
    self:SetText(textNode, data.text)
  end
  return cell
end

function SimpleListView:_ResetLastSelect()
  if not self._panelKey then
    return
  end
  local maxSaveCount = 4
  local lastSelectList = MobileFileDataManager.Instance:GetCommFileValue(self._panelKey, {})
  if type(lastSelectList) ~= "table" then
    lastSelectList = {}
  end
  self.ui.RecentBtns:SetActive(#lastSelectList > 0)
  local dataList = {}
  for _, id in ipairs(lastSelectList) do
    for _, data in ipairs(self._orgList) do
      if data.id == id then
        table.insert(dataList, data)
        break
      end
    end
  end
  for idx = 1, maxSaveCount do
    local btnNode = self.ui["Rec_Btn" .. idx]
    local data = dataList[idx]
    btnNode:SetActive(nil ~= data)
    if data then
      self:AddButtonClickListener(btnNode, function()
        self:_SaveLastSelect(data)
        if self._chooseCallback then
          self._chooseCallback(data, idx)
          Super.Close(self)
        end
      end)
      self:SetText(btnNode.transform:GetChild(0).gameObject, data.text)
    end
  end
end

function SimpleListView:_SaveLastSelect(data)
  if not self._panelKey then
    return
  end
  if -1 == data.id or data.text == "清除" then
    return
  end
  local lastSelectList = MobileFileDataManager.Instance:GetCommFileValue(self._panelKey, {})
  if type(lastSelectList) ~= "table" then
    lastSelectList = {}
  end
  local lastIndex = table.findvalue(lastSelectList, data.id)
  if lastIndex then
    table.remove(lastSelectList, lastIndex)
  end
  table.insert(lastSelectList, 1, data.id)
  local maxSaveCount = 4
  if maxSaveCount < #lastSelectList then
    table.remove(lastSelectList, #lastSelectList)
  end
  MobileFileDataManager.Instance:SetCommFileValue(self._panelKey, lastSelectList)
  MobileFileDataManager.Instance:OnSaveCommInfo()
end

function SimpleListView:_OnSearch()
  local curWord = self:GetInputText(self.ui.SearchText) or ""
  if curWord == self._searchWord then
    return
  end
  if self._panelKey then
    SimpleListView._cachedSearchWord[self._panelKey] = curWord
  end
  self._searchWord = curWord
  local filterList = {}
  local reg = ""
  for i = 1, #curWord do
    local str = string.sub(curWord, i, i)
    if " " ~= str then
      reg = reg .. string.sub(curWord, i, i) .. ".*"
    end
  end
  for _, data in ipairs(self._orgList) do
    if 0 == #curWord or data.text and string.find(data.text, reg) then
      if string.find(data.text, curWord) then
        table.insert(filterList, 1, data)
      else
        table.insert(filterList, data)
      end
    end
  end
  self._showList = filterList
  if self._tableview then
    self._tableview:ReloadData()
  end
end

function SimpleListView:Close()
  if self._closeCallback then
    self._closeCallback()
  end
  Super.Close(self)
end

return SimpleListView
