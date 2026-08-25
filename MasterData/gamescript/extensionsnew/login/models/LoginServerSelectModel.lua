local LoginServerSelectModel = NewClass("LoginServerSelectModel", BaseModel)
local RECENT_SERVER_MAX_COUNT = 5

function LoginServerSelectModel:OnInit()
  self:OnReset()
end

function LoginServerSelectModel:OnReset()
  self.selectIndex = nil
  self.recentServerIds = {}
  self.searchWord = ""
  self.serverList = LoginMgr.Instance.model:GetServerList()
  self.filteredServerList = self.serverList
end

function LoginServerSelectModel:ResetData()
  self:OnReset()
end

function LoginServerSelectModel:GetSelectIndex()
  return self.selectIndex
end

function LoginServerSelectModel:GetServerList()
  return self.serverList
end

function LoginServerSelectModel:GetFilteredServerList()
  return self.filteredServerList
end

function LoginServerSelectModel:GetRecentServerIds()
  return self.recentServerIds
end

function LoginServerSelectModel:GetRecentServerDataList()
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

function LoginServerSelectModel:SetSelectIndex(index)
  self.selectIndex = index
end

function LoginServerSelectModel:OnSearch(searchWord)
  if searchWord == self.searchWord then
    return self.filteredServerList
  end
  self.searchWord = searchWord
  local filterList = {}
  local reg = ""
  for i = 1, #searchWord do
    local str = string.sub(searchWord, i, i)
    if " " ~= str then
      reg = reg .. string.sub(searchWord, i, i) .. ".*"
    end
  end
  for _, data in ipairs(self.serverList) do
    if 0 == #searchWord or data.name and string.find(data.name, reg) then
      table.insert(filterList, data)
    end
  end
  self.filteredServerList = filterList
  return self.filteredServerList
end

function LoginServerSelectModel:LoadRecentServerIdsFromStorage()
  local serverIds = MobileFileDataManager.Instance:GetCommFileValue(CommonDefine.LocalSaveKeyCommon.RecentLoginServerIds, {})
  if type(serverIds) ~= "table" then
    self.recentServerIds = {}
    return
  end
  local result = {}
  for _, serverId in ipairs(serverIds) do
    if nil ~= serverId and #result < RECENT_SERVER_MAX_COUNT then
      table.insert(result, serverId)
    end
  end
  self.recentServerIds = result
end

function LoginServerSelectModel:RecordRecentServerId(serverId)
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

return LoginServerSelectModel
