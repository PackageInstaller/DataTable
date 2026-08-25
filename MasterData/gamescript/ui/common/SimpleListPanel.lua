local typeof = _ENV.typeof
local InputField = typeof(CS.UnityEngine.UI.InputField)
local Text = CS.UnityEngine.UI.Text
local SimpleListPanel, Super = System.NewClass("SimpleListPanel", UIBasePanel)
SimpleListPanel.uiResCls = Simple_List_PanelResource
SimpleListPanel.cachedSearchWord = {}

function SimpleListPanel:ctor(showList, chooseCallback, enableSearch, panelKey)
  Super.ctor(self)
  self.orgList = showList
  self.showList = Vue.ref(showList)
  self.chooseCallback = chooseCallback
  self.enableSearch = enableSearch
  self.panelKey = panelKey
  if not panelKey and #(showList or {}) > 0 then
    self.panelKey = showList[#showList].id
  end
end

function SimpleListPanel:OnBind(binder)
  self.binder = binder
  self:ResetLastSelect()
  binder:BindToCircularListView(self.ui.ShowList, function()
    return self.showList.value
  end, function(childBinder, item, index)
    local data = self.showList.value[index]
    if data then
      childBinder:BindButtonClick(item, function()
        self:SaveLastSelect(data)
        if self.chooseCallback then
          self.chooseCallback(data, index)
          Super.Close(self)
        end
      end)
      self.binder:SetText(item.transform:GetChild(0), data.text)
    end
  end)
  binder:BindButtonClick(self.ui.Btn_Exit, System.fn(self, self.Close))
  self.ui.SearchText:SetActive(self.enableSearch and true or false)
  if self.enableSearch then
    if self.panelKey and SimpleListPanel.cachedSearchWord[self.panelKey] then
      self.ui.SearchText:GetComponent(InputField).text = SimpleListPanel.cachedSearchWord[self.panelKey]
    end
    self.searchWord = ""
    self:OnSearch()
    binder:BindTimer(0.5, -1, function()
      self:OnSearch()
    end)
  end
end

function SimpleListPanel:ResetLastSelect()
  if not self.panelKey then
    return
  end
  local maxSaveCount = 4
  local lastSelectList = MobileFileDataManager.Instance:GetCommFileValue(self.panelKey, {})
  if type(lastSelectList) ~= "table" then
    lastSelectList = {}
  end
  self.ui.RecentBtns:SetActive(#lastSelectList > 0)
  local dataList = {}
  for _, id in ipairs(lastSelectList) do
    for _, data in ipairs(self.orgList) do
      if data.id == id then
        table.insert(dataList, data)
        break
      end
    end
  end
  for index = 1, maxSaveCount do
    local btnNode = self.ui["Rec_Btn" .. index]
    local data = dataList[index]
    btnNode:SetActive(nil ~= data)
    if data and data then
      self.binder:BindButtonClick(btnNode, function()
        self:SaveLastSelect(data)
        if self.chooseCallback then
          self.chooseCallback(data, index)
          Super.Close(self)
        end
      end)
      local uiText = btnNode.transform:GetChild(0):GetComponent(typeof(Text))
      uiText.text = data.text
    end
  end
end

function SimpleListPanel:SaveLastSelect(data)
  if not self.panelKey then
    return
  end
  if -1 == data.id or data.text == "清除" then
    return
  end
  local lastSelectList = MobileFileDataManager.Instance:GetCommFileValue(self.panelKey, {})
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
  MobileFileDataManager.Instance:SetCommFileValue(self.panelKey, lastSelectList)
  MobileFileDataManager.Instance:OnSaveCommInfo()
end

function SimpleListPanel:OnSearch()
  local curWord = self.ui.SearchText:GetComponent(InputField).text
  if curWord == self.searchWord then
    return
  end
  if self.panelKey then
    SimpleListPanel.cachedSearchWord[self.panelKey] = curWord
  end
  self.searchWord = curWord
  local filterList = {}
  local reg = ""
  for i = 1, #curWord do
    local str = string.sub(curWord, i, i)
    if " " ~= str then
      reg = reg .. string.sub(curWord, i, i) .. ".*"
    end
  end
  for _, data in ipairs(self.orgList) do
    if 0 == #curWord or data.text and string.find(data.text, reg) then
      if string.find(data.text, curWord) then
        table.insert(filterList, 1, data)
      else
        table.insert(filterList, data)
      end
    end
  end
  self.showList.value = filterList
end

function SimpleListPanel:Close()
  if self.closeCallback then
    self.closeCallback()
  end
  Super.Close(self)
end

return SimpleListPanel
