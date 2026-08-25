local typeof = _ENV.typeof
local Text = CS.UnityEngine.UI.Text
local InputField = CS.UnityEngine.UI.InputField
local Vector2 = CS.UnityEngine.Vector2
local Vector3 = CS.UnityEngine.Vector3
local RECENT_SERVER_MAX_COUNT = 5
local RECENT_BTN_STEP_X = 493
local RECENT_BTN_SCALE = 0.7
local ServerSelectPanel, _ = System.NewClass("ServerSelectPanel", UIBasePanel)
ServerSelectPanel.uiResCls = UI_Login_Panel_ServerSelectResource

function ServerSelectPanel:ctor()
  self.chosenColor = CS.UnityEngine.Color.white
  self.whiteColor = ColorUtils.ParseHtmlStringToUnityColor("#acbfca")
  self.selectIndex = nil
  self.recentServerIds = {}
  LoginMgr.Instance:ReqGetServerList()
end

function ServerSelectPanel:OnBind(binder)
  self.binder = binder
  self.serverList = LoginMgr.Instance.model:GetServerList()
  self.filteredServerList = Vue.ref(self.serverList)
  self.recentServerIds = self:LoadRecentServerIdsFromStorage()
  self:RefreshRecentServerButtons()
  binder:BindToCircularListView(self.ui.ServerList, function()
    return self.filteredServerList.value
  end, function(childBinder, item, index)
    local data = self.filteredServerList.value[index]
    if data and self.selectIndex == nil and LoginMgr.Instance.model.serverId == data.id then
      self.selectIndex = index
    end
    if data then
      childBinder:BindButtonClick(item, function()
        self:OnServerSelect(index, data.id)
      end)
      local uiText = item.transform:GetChild(0):GetComponent(typeof(Text))
      if uiText then
        uiText.text = data.name
        if index == self.selectIndex then
          uiText.color = self.chosenColor
        else
          uiText.color = self.whiteColor
        end
      end
    end
  end)
  self.searchWord = self.ui.SearchInputField:GetComponent(typeof(InputField)).text
  binder:BindTimer(0.5, -1, function()
    self:OnSearch()
  end)
  binder:BindButtonClick(self.ui.Btn_Exit, System.fn(self, self.ClosePanel))
end

function ServerSelectPanel:OnServerSelect(index, id)
  if nil == id then
    return
  end
  self.selectIndex = index
  LoginMgr.Instance.model:SetServerDataById(id)
  self:RecordRecentServerId(id)
  self:ClosePanel()
end

function ServerSelectPanel:OnSearch()
  local curWord = self.ui.SearchInputField:GetComponent(typeof(InputField)).text
  if curWord == self.searchWord then
    return
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
  for _, data in ipairs(self.serverList) do
    if 0 == #curWord or data.name and string.find(data.name, reg) then
      table.insert(filterList, data)
    end
  end
  self.filteredServerList.value = filterList
end

function ServerSelectPanel:LoadRecentServerIdsFromStorage()
  local serverIds = MobileFileDataManager.Instance:GetCommFileValue(CommonDefine.LocalSaveKeyCommon.RecentLoginServerIds, {})
  if type(serverIds) ~= "table" then
    return {}
  end
  local result = {}
  for _, serverId in ipairs(serverIds) do
    if nil ~= serverId and #result < RECENT_SERVER_MAX_COUNT then
      table.insert(result, serverId)
    end
  end
  return result
end

function ServerSelectPanel:GetRecentServerDataList()
  local result = {}
  for _, serverId in ipairs(self.recentServerIds or {}) do
    local serverData = LoginMgr.Instance.model:GetServerInfoById(serverId)
    if serverData then
      table.insert(result, serverData)
    end
    if #result >= RECENT_SERVER_MAX_COUNT then
      break
    end
  end
  return result
end

function ServerSelectPanel:RefreshRecentServerButtons()
  local templateBtn = self.ui.Btn_SubType
  if not templateBtn then
    return
  end
  self.recentBtnList = self.recentBtnList or {}
  local parentTf = templateBtn.transform.parent
  local recentDataList = self:GetRecentServerDataList()
  local templateRectTf = templateBtn.transform
  local basePos = self.recentBtnBasePos
  if not basePos then
    basePos = templateRectTf and templateRectTf.anchoredPosition or Vector2.zero
    self.recentBtnBasePos = basePos
  end
  for i = 1, RECENT_SERVER_MAX_COUNT do
    local serverData = recentDataList[i]
    local btnGo = self.recentBtnList[i]
    if not btnGo then
      btnGo = self.binder:Instantiate(templateBtn, parentTf)
      self.recentBtnList[i] = btnGo
      self.binder:BindButtonClick(btnGo, function()
        local _serverList = self:GetRecentServerDataList()
        local serverId = _serverList[i] and _serverList[i].id or nil
        self:OnServerSelect(nil, serverId)
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

function ServerSelectPanel:RecordRecentServerId(serverId)
  if nil == serverId then
    return
  end
  local list = self.recentServerIds or {}
  for i = #list, 1, -1 do
    if list[i] == serverId then
      table.remove(list, i)
    end
  end
  table.insert(list, 1, serverId)
  while #list > RECENT_SERVER_MAX_COUNT do
    table.remove(list)
  end
  self.recentServerIds = list
  MobileFileDataManager.Instance:SetCommFileValue(CommonDefine.LocalSaveKeyCommon.RecentLoginServerIds, list, true)
end

function ServerSelectPanel:ClosePanel()
  self:Close()
end

return ServerSelectPanel
