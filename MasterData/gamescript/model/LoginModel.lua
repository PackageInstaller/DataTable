local function createLoginModelState(_)
  local state = {}
  
  state.platformToken = nil
  state.gameToken = nil
  state.ipAddr = nil
  state.port = nil
  state.serverId = nil
  
  function state.serverName()
    if not state.serverId or state.serverId == "" then
      return
    end
    local serverData = state:GetCurrServerData()
    do return LT.Text end
    return LT.Text, serverData.name
  end
  
  state.serverList = {}
  state.serverMap = {}
  
  function state.isPlatformLogin()
    return state.platformToken and state.platformToken ~= ""
  end
  
  state.isLogin = false
  state.isActorLogin = false
  state.account = nil
  return state
end

local function createLoginModelViews(data)
  local views = {}
  
  function views:GetServerList()
    return data.serverList
  end
  
  function views:GetServerInfoById(serverId)
    if not serverId then
      Logger.Warn("[LoginMgr.GetServerInfoById] serverId is nil")
      return
    end
    return data.serverMap[serverId]
  end
  
  function views:GetServerInfoByIndex(index)
    if not index or type(index) ~= "number" or index > #data.serverList then
      return
    end
    return data.serverList[index]
  end
  
  function views:GetCurrServerData()
    do return self.GetServerInfoById, self end
    return self.GetServerInfoById, self, data.serverId
  end
  
  function views:GetServerName()
    if data.serverName == nil then
      return
    end
    do return LT.Text end
    return LT.Text, data.serverName
  end
  
  function views:GetServerNode()
    if data.serverNode == nil then
      return
    end
    do return LT.Text end
    return LT.Text, data.serverNode
  end
  
  function views:GetLocalCacheAccount()
    do return MobileFileDataManager.Instance.GetCommFileValue, MobileFileDataManager.Instance end
    return MobileFileDataManager.Instance.GetCommFileValue, MobileFileDataManager.Instance, CommonDefine.LocalSaveKeyCommon.Account
  end
  
  return views
end

local function createLoginModelActions(data)
  local actions = {}
  
  function actions:ResetLoginTokens()
    data:ResetPlatformToken()
    data:ResetGameToken()
  end
  
  function actions:ResetIsLogin()
    data.isLogin = false
    data.isActorLogin = false
  end
  
  function actions:SetIsLogin(isLogin)
    data.isLogin = isLogin
  end
  
  function actions:SetIsActorLogin(isLogin)
    data.isActorLogin = isLogin
  end
  
  function actions:ResetPlatformToken()
    data.platformToken = nil
  end
  
  function actions:SetPlatformToken(token)
    data.platformToken = token
  end
  
  function actions:ResetGameToken()
    data.gameToken = nil
  end
  
  function actions:SetGameToken(gameToken)
    data.gameToken = gameToken
  end
  
  function actions:ResetServerData()
    data.ipAddr = nil
    data.port = nil
    data.serverId = nil
  end
  
  function actions:SetServerDataById(serverId)
    local serverData = data:GetServerInfoById(serverId)
    if not serverData then
      Logger.Warn("[Server] Set server data error: can't find serverData by id:", serverId)
      return
    end
    data.ipAddr = serverData.ipAddr
    data.port = serverData.port
    data.serverId = serverData.id
  end
  
  function actions:ReSetGameServerNode()
    data.serverNode = data.gameServerNode
  end
  
  function actions:SetGameServerNode(serverNode)
    data.gameServerNode = serverNode
    data.serverNode = serverNode
  end
  
  function actions:SetBattleServerNode(serverNode)
    data.battleServerNode = serverNode
    data.serverNode = serverNode
  end
  
  function actions:SetIpAddr(ipAddr)
    data.ipAddr = ipAddr
  end
  
  function actions:SetPort(port)
    data.port = port
  end
  
  function actions:SetServerId(serverId)
    data.serverId = serverId
  end
  
  function actions:CreateServerInfoBy(platformServerData)
    if not platformServerData then
      return
    end
    local serverInfo = {
      name = platformServerData.name,
      id = platformServerData.server_id,
      tags = platformServerData.tags,
      sort = platformServerData.data and platformServerData.data.desc or 0
    }
    local addrData = platformServerData.data and platformServerData.data.addrs and platformServerData.data.addrs[1]
    if addrData then
      serverInfo.ipAddr = addrData.ip
      serverInfo.port = addrData.port
    end
    return serverInfo
  end
  
  function actions:SetServerDataByResponse(serverList)
    if not serverList then
      return
    end
    local tableInsert = table.insert
    local tableSort = table.sort
    local list = {}
    local map = {}
    for _, serverInfo in ipairs(serverList) do
      local clientServerInfo = self:CreateServerInfoBy(serverInfo)
      if clientServerInfo then
        tableInsert(list, clientServerInfo)
        map[clientServerInfo.id] = clientServerInfo
      end
    end
    tableSort(list, function(a, b)
      if a.sort == b.sort then
        return a.id < b.id
      end
      return a.sort < b.sort
    end)
    data.serverList = list
    data.serverMap = map
  end
  
  function actions:SetAccount(account)
    if SdkMgr.Instance:IsSdkLogin() then
      return
    end
    data.account = account
  end
  
  return actions
end

local function onSetup(_, _)
end

local LoginModel = Vue.model("LoginModel", createLoginModelState):views(createLoginModelViews):actions(createLoginModelActions):setup(onSetup)
return LoginModel
