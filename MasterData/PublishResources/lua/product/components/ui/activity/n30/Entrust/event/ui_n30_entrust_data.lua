_class("N30EntrustData", Object)
N30EntrustData = N30EntrustData

function N30EntrustData:Constructor(component)
  self._component = component
  self._datas = {}
  self._dbViewedNode = {}
  self._dbViewedPlot = false
  self:NewNodeLoadDB()
  self:ViewPlotLoadDB()
end

function N30EntrustData:GetModule(gameModuleProto)
  return GameGlobal.GetModule(gameModuleProto)
end

function N30EntrustData:GetDBNewNodeKey()
  local key = "N30EntrustData::NewNode"
  local roleModule = self:GetModule(RoleModule)
  return roleModule:GetPstId() .. key
end

function N30EntrustData:NewNodeLoadDB()
  local key = self:GetDBNewNodeKey()
  local content = LocalDB.GetString(key, "")
  local fnString = string.format("return {%s}", content)
  local fnTable = load(fnString)
  local dbData = fnTable()
  for k, v in pairs(dbData) do
    self._dbViewedNode[v] = v
  end
end

function N30EntrustData:NewNodeSaveDB()
  local content = ""
  for k, v in pairs(self._dbViewedNode) do
    content = content .. string.format("%d, ", v)
  end
  local key = self:GetDBNewNodeKey()
  LocalDB.SetString(key, content)
end

function N30EntrustData:ViewNode(viewedNodeId)
  self._dbViewedNode[viewedNodeId] = viewedNodeId
  self:NewNodeSaveDB()
  local node = self:GetNodeData(viewedNodeId)
  node._isNew = false
end

function N30EntrustData:GetDBViewPlotKey()
  local key = "N30EntrustData::ViewPlot"
  local roleModule = self:GetModule(RoleModule)
  return roleModule:GetPstId() .. key
end

function N30EntrustData:ViewPlotLoadDB()
  local key = self:GetDBViewPlotKey()
  local content = LocalDB.GetInt(key, 0)
  self._dbViewedPlot = content == 1
end

function N30EntrustData:ViewPlotSaveDB()
  local content = self._dbViewedPlot and 1 or 0
  local key = self:GetDBViewPlotKey()
  LocalDB.SetInt(key, content)
end

function N30EntrustData:ViewPlot(viewedPlot)
  if viewedPlot ~= nil then
    self._dbViewedPlot = viewedPlot
    self:ViewPlotSaveDB()
  end
  return self._dbViewedPlot
end

function N30EntrustData:ClearDB()
  self._dbViewedNode = {}
  self._dbViewedPlot = false
  self:NewNodeSaveDB()
  self:ViewPlotSaveDB()
end

function N30EntrustData:GetAllEntrust()
  local allEntrust = Cfg.cfg_component_entrust({
    ComponentID = self._component:GetComponentCfgId()
  })
  local lookup = {}
  local theNext = {}
  for k, v in pairs(allEntrust) do
    lookup[v.ID] = v
    theNext[v.PreID] = v
  end
  local dataNodes = {}
  local curNode = theNext[0]
  while curNode ~= nil do
    table.insert(dataNodes, curNode)
    curNode = theNext[curNode.ID]
  end
  return dataNodes
end

function N30EntrustData:RefreshClientData()
  local allEntrust = self:GetAllEntrust()
  for _, v in pairs(allEntrust) do
    local key = v.ID
    local node = self._datas[key]
    if node == nil then
      node = N30EntrustNodeData:New(self, v)
      self._datas[key] = node
      self:NodePreEvents(node)
      self:NodeReachable(node)
      self:NodeSequence(node)
    end
    self:NodeNormalData(node)
  end
end

function N30EntrustData:NodePreEvents(node)
  local preLinks = node._preLinks
  local preEvents = node._preEvents
  local lineIds = {}
  if node._cfg.LineID ~= nil then
    lineIds = node._cfg.LineID
  end
  local eventIds = {}
  if node._cfg.EventID ~= nil then
    eventIds = node._cfg.EventID
  end
  local cacheLine = Cfg.cfg_campaign_entrust_line
  for k, v in pairs(lineIds) do
    local cfg = cacheLine[v]
    local preDic = preLinks[cfg.RightEventID]
    if preDic == nil then
      preDic = {}
      preLinks[cfg.RightEventID] = preDic
    end
    preDic[cfg.LeftEventID] = cfg.LeftEventID
  end
  local cacheEvent = Cfg.cfg_campaign_entrust_event
  for k, v in pairs(eventIds) do
    local cfg = cacheEvent[v]
    if cfg.LockedPointID ~= nil then
      local preDic = preEvents[v]
      if preDic == nil then
        preDic = {}
        preEvents[v] = preDic
      end
      preDic[cfg.LockedPointID] = cfg.LockedPointID
    end
  end
end

function N30EntrustData:NodeReachable(node)
  local reachable = node._reachable
  local lineIds = {}
  if node._cfg.LineID ~= nil then
    lineIds = node._cfg.LineID
  end
  local cacheLine = Cfg.cfg_campaign_entrust_line
  for k, v in pairs(lineIds) do
    local cfg = cacheLine[v]
    local dic = reachable[cfg.LeftEventID]
    if dic == nil then
      dic = {}
      reachable[cfg.LeftEventID] = dic
    end
    dic[cfg.RightEventID] = cfg.RightEventID
    local dic = reachable[cfg.RightEventID]
    if dic == nil then
      dic = {}
      reachable[cfg.RightEventID] = dic
    end
    dic[cfg.LeftEventID] = cfg.LeftEventID
  end
end

function N30EntrustData:NodeSequence(node)
  local sequence = node._sequence
  local lineIds = {}
  if node._cfg.LineID ~= nil then
    lineIds = node._cfg.LineID
  end
  local eventIds = {}
  if node._cfg.EventID ~= nil then
    eventIds = node._cfg.EventID
  end
  local cacheLine = Cfg.cfg_campaign_entrust_line
  local cacheEvent = Cfg.cfg_campaign_entrust_event
  local start = {}
  local trans = {}
  for k, v in pairs(eventIds) do
    local cfg = cacheEvent[v]
    if cfg.EventType == EntrustEventType.EntrustEventType_Start then
      table.insert(start, cfg.EventID)
    elseif cfg.EventType == EntrustEventType.EntrustEventType_Transfer then
      trans[cfg.EventID] = cfg.TargetID
      trans[cfg.TargetID] = cfg.EventID
    end
  end
  local lookupE2L = {}
  for k, v in pairs(lineIds) do
    local cfg = cacheLine[v]
    local dic = lookupE2L[cfg.LeftEventID]
    if dic == nil then
      dic = {}
      lookupE2L[cfg.LeftEventID] = dic
    end
    dic[cfg.LineID] = cfg
  end
  local newUnique = {}
  while 0 < #start do
    local newStart = {}
    local list = {}
    for k, v in pairs(start) do
      local dic = lookupE2L[v]
      if dic == nil then
        dic = {}
      end
      for dk, dv in pairs(dic) do
        table.insert(list, dv)
        if newUnique[dv.RightEventID] == nil then
          newUnique[dv.RightEventID] = dv.RightEventID
          table.insert(newStart, dv.RightEventID)
        end
      end
      dic = {}
      if trans[v] ~= nil then
        dic = lookupE2L[trans[v]]
      end
      if dic == nil then
        dic = {}
      end
      for dk, dv in pairs(dic) do
        table.insert(list, dv)
        if newUnique[dv.RightEventID] == nil then
          newUnique[dv.RightEventID] = dv.RightEventID
          table.insert(newStart, dv.RightEventID)
        end
      end
    end
    if 0 < #list then
      table.insert(sequence, list)
    end
    start = newStart
  end
end

function N30EntrustData:NodeNormalData(node)
  local nodeId = node._cfg.ID
  local componentInfo = self._component:GetComponentInfo()
  local cacheEvent = Cfg.cfg_campaign_entrust_event
  node._rewarded_events = {}
  if componentInfo.rewarded_events[nodeId] ~= nil then
    local list = componentInfo.rewarded_events[nodeId]
    for k, v in pairs(list) do
      node._rewarded_events[v] = v
    end
  end
  node._isNew = self._dbViewedNode[nodeId] == nil
  if node._isNew then
    for k, v in pairs(node._rewarded_events) do
      local cfgEvent = cacheEvent[v]
      if cfgEvent.EventType ~= EntrustEventType.EntrustEventType_Start then
        self:ViewNode(nodeId)
        break
      end
    end
  end
  local preID = node._cfg.PreID
  local preNode = self._datas[preID]
  if preNode == nil then
    node._isLocked = false
  else
    node._isLocked = not preNode._isPass
  end
  local eventIds = {}
  if node._cfg.EventID ~= nil then
    eventIds = node._cfg.EventID
  end
  node._isPass = true
  for k, v in pairs(eventIds) do
    local cfgEvent = cacheEvent[v]
    if cfgEvent.EventType == EntrustEventType.EntrustEventType_End and node._rewarded_events[v] == nil then
      node._isPass = false
      break
    end
  end
  node._totalEvents = 0
  node._completeEvents = 0
  for k, v in pairs(eventIds) do
    local cfgEvent = cacheEvent[v]
    if cfgEvent.EventType ~= EntrustEventType.EntrustEventType_Start then
      node._totalEvents = node._totalEvents + 1
    end
  end
  for k, v in pairs(node._rewarded_events) do
    local cfgEvent = cacheEvent[v]
    if cfgEvent.EventType ~= EntrustEventType.EntrustEventType_Start then
      node._completeEvents = node._completeEvents + 1
    end
  end
end

function N30EntrustData:NodeRewardsData(node)
  if node._rewardFinish == nil then
    node._rewardFinish = {}
    node._rewardExplor = {}
    local eventIds = {}
    if node._cfg.EventID ~= nil then
      eventIds = node._cfg.EventID
    end
    local cacheEvent = Cfg.cfg_campaign_entrust_event
    for k, v in pairs(eventIds) do
      local rewardList
      local cfg = cacheEvent[v]
      if cfg.EventType == EntrustEventType.EntrustEventType_End then
        rewardList = node._rewardFinish
      elseif cfg.EventType == EntrustEventType.EntrustEventType_Box then
        rewardList = node._rewardExplor
      end
      if rewardList ~= nil then
        local list = self:EventRewardList(cfg)
        for rk, rv in pairs(list) do
          table.insert(rewardList, rv)
        end
      end
    end
  end
  self:NodeNormalizedRewards(node, node._rewardFinish)
  self:NodeNormalizedRewards(node, node._rewardExplor)
end

function N30EntrustData:NodeDetailsData(node)
  local eventIds = {}
  if node._cfg.EventID ~= nil then
    eventIds = node._cfg.EventID
  end
  local lineIds = {}
  if node._cfg.LineID ~= nil then
    lineIds = node._cfg.LineID
  end
  local cacheEvent = Cfg.cfg_campaign_entrust_event
  local cacheLine = Cfg.cfg_campaign_entrust_line
  node._totalBox = 0
  node._completeBox = 0
  for k, v in pairs(eventIds) do
    local cfgEvent = cacheEvent[v]
    if cfgEvent.EventType == EntrustEventType.EntrustEventType_Box then
      node._totalBox = node._totalBox + 1
    end
  end
  for k, v in pairs(node._rewarded_events) do
    local cfgEvent = cacheEvent[v]
    if cfgEvent.EventType == EntrustEventType.EntrustEventType_Box then
      node._completeBox = node._completeBox + 1
    end
  end
  if node._dicEvents == nil then
    node._dicEvents = {}
    for k, v in pairs(eventIds) do
      local cfgEvent = cacheEvent[v]
      local event = N30EntrustEvent:CreateEvent(node, cfgEvent)
      node._dicEvents[v] = event
    end
  end
  for k, v in pairs(node._dicEvents) do
    v._isVisible = false
    v._isLocked = false
    v._isPass = false
    local eventId = v:ID()
    local preDic = node._preLinks[eventId]
    if node._rewarded_events[k] ~= nil then
      v._isVisible = true
    elseif preDic == nil then
      if v:EventType() == EntrustEventType.EntrustEventType_Start then
        v._isVisible = true
      end
    else
      for vk, vv in pairs(preDic) do
        if node._rewarded_events[vv] ~= nil then
          v._isVisible = true
          break
        end
      end
    end
    local preDic = node._preEvents[eventId]
    if preDic == nil then
      v._isLocked = false
    else
      for vk, vv in pairs(preDic) do
        if node._rewarded_events[vv] == nil then
          v._isLocked = true
          break
        end
      end
    end
    v._isPass = node._rewarded_events[eventId] ~= nil
  end
  if node._dicLines == nil then
    node._dicLines = {}
    for k, v in pairs(lineIds) do
      local cfgLine = cacheLine[v]
      local line = N30EntrustLine:CreateLine(node, cfgLine)
      node._dicLines[v] = line
    end
  end
  for k, v in pairs(node._dicLines) do
    v._isVisible = false
    local cfgLine = v:Cfg()
    v._isVisible = node._rewarded_events[cfgLine.LeftEventID] ~= nil
  end
end

function N30EntrustData:EventRewardList(cfgEvent)
  local rewardList = {}
  if cfgEvent.RewardList ~= nil then
    for rk, rv in pairs(cfgEvent.RewardList) do
      local reward = RoleAsset:New()
      reward.assetid = rv[1]
      reward.count = rv[2]
      reward.eventid = cfgEvent.EventID
      reward.received = false
      table.insert(rewardList, reward)
    end
  end
  return rewardList
end

function N30EntrustData:NodeNormalizedRewards(node, rewards)
  local rewarded_events = node._rewarded_events
  for k, v in pairs(rewards) do
    v.received = rewarded_events[v.eventid] ~= nil
  end
  table.sort(rewards, function(a, b)
    if not a.received and b.received then
      return true
    elseif a.received and not b.received then
      return false
    else
      return a.assetid < b.assetid
    end
    return false
  end)
end

function N30EntrustData:EntrustComponent()
  return self._component
end

function N30EntrustData:EntrustComponentInfo()
  return self._component:GetComponentInfo()
end

function N30EntrustData:GetNodeData(nodeKey)
  return self._datas[nodeKey]
end

function N30EntrustData:HasNew()
  if self._datas == nil then
    return false
  end
  for k, v in pairs(self._datas) do
    if v:IsLocked() then
    elseif v:IsTimeLocked() then
    elseif v:IsNew() then
      return true
    end
  end
  return false
end

_class("N30EntrustNodeData", Object)
N30EntrustNodeData = N30EntrustNodeData

function N30EntrustNodeData:Constructor(parent, cfg)
  self._parent = parent
  self._cfg = cfg
  self._preLinks = {}
  self._preEvents = {}
  self._reachable = {}
  self._sequence = {}
  self._rewarded_events = {}
  self._isNew = false
  self._isPass = false
  self._isLocked = false
  self._totalEvents = 0
  self._completeEvents = 0
  self._rewardFinish = nil
  self._rewardExplor = nil
  self._totalBox = 0
  self._completeBox = 0
  self._dicEvents = nil
  self._dicLines = nil
end

function N30EntrustNodeData:IsLocked()
  return self._isLocked
end

function N30EntrustNodeData:IsTimeLocked()
  local svrTimeModule = GameGlobal.GetModule(SvrTimeModule)
  local curTime = math.floor(svrTimeModule:GetServerTime() * 0.001)
  local openTime = self:GetOpenTime()
  if curTime < openTime then
    return true, openTime - curTime
  end
  return false, nil
end

function N30EntrustNodeData:IsLocked_TestCase()
  return false
end

function N30EntrustNodeData:IsTimeLocked_TestCase()
  return false, nil
end

function N30EntrustNodeData:IsNew()
  if self._isLocked then
    return false
  end
  return self._isNew
end

function N30EntrustNodeData:IsPass()
  return self._isPass
end

function N30EntrustNodeData:GetOpenTime()
  local component = self._parent:EntrustComponent()
  local componentInfo = component:GetComponentInfo()
  return componentInfo.open_time[self._cfg.ID]
end

function N30EntrustNodeData:GetExplor()
  if self._totalEvents == nil or self._totalEvents == 0 then
    return 0
  end
  return self._completeEvents / self._totalEvents
end

function N30EntrustNodeData:ID()
  return self._cfg.ID
end

function N30EntrustNodeData:GetCfg()
  return self._cfg
end

function N30EntrustNodeData:GetRewardedEvents()
  return self._rewarded_events
end

function N30EntrustNodeData:EntrustData()
  return self._parent
end

function N30EntrustNodeData:GetPreLinks()
  return self._preLinks
end

function N30EntrustNodeData:GetPreEvents()
  return self._preEvents
end

function N30EntrustNodeData:GetReachable()
  return self._reachable
end

function N30EntrustNodeData:GetSequence()
  return self._sequence
end

function N30EntrustNodeData:GetRewardFinish()
  return self._rewardFinish
end

function N30EntrustNodeData:GetRewardExplor()
  return self._rewardExplor
end

function N30EntrustNodeData:GetTotalBox()
  return self._totalBox
end

function N30EntrustNodeData:GetCompleteBox()
  return self._completeBox
end

function N30EntrustNodeData:GetAllEvents()
  return self._dicEvents
end

function N30EntrustNodeData:GetAllLines()
  return self._dicLines
end

function N30EntrustNodeData:GetEvent(idEvent)
  return self._dicEvents[idEvent]
end

function N30EntrustNodeData:GetLine(idLine)
  return self._dicLines[idLine]
end
