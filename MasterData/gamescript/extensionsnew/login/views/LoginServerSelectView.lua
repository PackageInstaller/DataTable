local typeof = _ENV.typeof
local Text = CS.UnityEngine.UI.Text
local InputField = CS.UnityEngine.UI.InputField
local Vector2 = CS.UnityEngine.Vector2
local Vector3 = CS.UnityEngine.Vector3
local RECENT_SERVER_MAX_COUNT = 5
local RECENT_BTN_STEP_X = 493
local RECENT_BTN_SCALE = 0.7
local LoginServerSelectView, Super = System.NewClass("LoginServerSelectView", BaseView)
LoginServerSelectView.uiResCls = UI_Login_Panel_ServerSelectResource

function LoginServerSelectView:ctor()
  Super.ctor(self)
  self.chosenColor = CS.UnityEngine.Color.white
  self.whiteColor = ColorUtils.ParseHtmlStringToUnityColor("#acbfca")
  self.model = LoginServerSelectModel.Instance
  self.controller = LoginServerSelectController.Instance
end

function LoginServerSelectView:OnBuildView()
  Super.OnBuildView(self)
  self:_BuildServerListView()
end

function LoginServerSelectView:RegisterEvents()
  self:AddButtonClickListener(self.ui.Btn_Exit, System.fn(self, self.ClosePanel))
end

function LoginServerSelectView:OnEnterView()
  Super.OnEnterView(self)
  self.controller:Init()
  self.model:ResetData()
  self.model:LoadRecentServerIdsFromStorage()
  self:_RefreshAll()
  self:BindTimer(0.5, -1, System.fn(self, self._OnSearch))
end

function LoginServerSelectView:OnExitView()
  Super.OnExitView(self)
end

function LoginServerSelectView:_RefreshAll()
  self:_RefreshList()
  self:_RefreshRecentServerButtons()
end

function LoginServerSelectView:_RefreshList()
  if self._tableView then
    self._tableView:ReloadData()
  end
end

function LoginServerSelectView:_RefreshRecentServerButtons()
  local templateBtn = self.ui.Btn_SubType
  if not templateBtn then
    return
  end
  self._recentBtnList = self._recentBtnList or {}
  local parentTf = templateBtn.transform.parent
  local recentDataList = self.model:GetRecentServerDataList()
  local templateRectTf = templateBtn.transform
  local basePos = self._recentBtnBasePos
  if not basePos then
    basePos = templateRectTf and templateRectTf.anchoredPosition or Vector2.zero
    self._recentBtnBasePos = basePos
  end
  for i = 1, RECENT_SERVER_MAX_COUNT do
    local serverData = recentDataList[i]
    local btnGo = self._recentBtnList[i]
    if not btnGo then
      btnGo = self:Instantiate(templateBtn, parentTf)
      self._recentBtnList[i] = btnGo
      self:AddButtonClickListener(btnGo, function()
        local curList = self.model:GetRecentServerDataList()
        local serverId = curList[i] and curList[i].id or nil
        self:_OnServerSelect(nil, serverId)
      end)
    end
    btnGo:SetActive(nil ~= serverData)
    if serverData then
      local btnTransform = btnGo.transform
      if btnTransform then
        btnTransform.anchoredPosition = Vector2(basePos.x + (i - 1) * RECENT_BTN_STEP_X * RECENT_BTN_SCALE, basePos.y)
        btnTransform.localScale = Vector3.one * RECENT_BTN_SCALE
      end
      local childTf = btnTransform.childCount > 0 and btnTransform:GetChild(0)
      local uiText = childTf and childTf:GetComponent(typeof(Text))
      if uiText then
        uiText.text = serverData.name or ""
      end
    end
  end
end

function LoginServerSelectView:_BuildServerListView()
  local cellPrefab = UIUtils.ReplaceCircularListWithTable(self.ui.ServerList)
  if not cellPrefab then
    return
  end
  self._cellPrefab = cellPrefab
  local cellW = cellPrefab.transform.sizeDelta.x
  local cellH = cellPrefab.transform.sizeDelta.y
  self._tableView = self:CreateTableview(self.ui.ServerList, function()
    local list = self.model:GetFilteredServerList()
    return list and #list or 0
  end, function(view, idx)
    do return self._OnServerCellAtIndex, self, view end
    return self._OnServerCellAtIndex, self, view, idx
  end, function()
    return cellW, cellH
  end)
end

function LoginServerSelectView:_OnServerCellAtIndex(view, idx)
  local filteredList = self.model:GetFilteredServerList()
  local data = filteredList[idx]
  if not data then
    return nil
  end
  if self.model:GetSelectIndex() == nil and LoginMgr.Instance.model.serverId == data.id then
    self.model:SetSelectIndex(idx)
  end
  local cell = self:DequeueCell(view, self._cellPrefab)
  self:AddButtonClickListener(cell.gameObject, function()
    self:_OnServerSelect(idx, data.id)
  end)
  local uiText = cell.gameObject.transform:GetChild(0):GetComponent(typeof(Text))
  if uiText then
    uiText.text = data.name
    if idx == self.model:GetSelectIndex() then
      uiText.color = self.chosenColor
    else
      uiText.color = self.whiteColor
    end
  end
  return cell
end

function LoginServerSelectView:_OnSearch()
  local searchInput = self.ui.SearchInputField:GetComponent(typeof(InputField))
  local curWord = searchInput.text
  local prevList = self.model:GetFilteredServerList()
  self.model:OnSearch(curWord)
  if self.model:GetFilteredServerList() ~= prevList then
    self:_RefreshList()
  end
end

function LoginServerSelectView:_OnServerSelect(index, id)
  self.controller:SelectServer(index, id)
  self:ClosePanel()
end

function LoginServerSelectView:ClosePanel()
  self:Close()
end

return LoginServerSelectView
