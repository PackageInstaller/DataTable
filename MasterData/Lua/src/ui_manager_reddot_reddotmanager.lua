local reddotManager = class("reddotManager")
reddotManager:importPartialClass(require("ui.manager.reddot.reddotManagerGetFuncs"))
reddotManager:importPartialClass(require("ui.manager.reddot.reddotManagerDotConfs"))
reddotManager.DotConf = L_Const.emptyTable
reddotManager.EventConf = L_Const.emptyTable
local C_ReddotCtrl = CS.Lens.Gameplay.UI.LReddotCtrl
local tag = reddotManager:getName()
local reddotNode = {value = 0, parent = nil}

function reddotManager:checkStartReddotListener()
  if self._started then
    return
  end
  self._started = true
  reddotManager:initReddotConfs()
  self._reddotMap = {}
  self._dirtyList = {}
  self._go2Key = {}
  self._key2Gos = {}
  self._needsClear = false
  self._listNodeDatas = {}
  self:_initDotMap()
  self:_listenEvents()
  self._UpdateHandler = handler(self, self.update)
  C_UpdateSource.AddUpdateEventHandler(self._UpdateHandler, "reddotManager.update")
end

function reddotManager:dispose()
  self._started = false
  self._reddotMap = {}
  self._dirtyList = {}
  self._go2Key = {}
  self._key2Gos = {}
  self._needsClear = false
  self._listNodeDatas = {}
  self:_unlistenEvents()
  if self._UpdateHandler ~= nil then
    C_UpdateSource.RemoveUpdateEventHandler(self._UpdateHandler)
    self._UpdateHandler = nil
  end
end

function reddotManager:_initDotMap()
  for key, conf in pairs(reddotManager.DotConf) do
    self._reddotMap[key] = self._reddotMap[key] or {value = 0}
    if conf.subNodes then
      for _, subKey in ipairs(conf.subNodes) do
        self._reddotMap[subKey] = self._reddotMap[subKey] or {value = 0}
        self._reddotMap[subKey].parent = self._reddotMap[subKey].parent or {}
        table.insert(self._reddotMap[subKey].parent, key)
      end
    end
    if conf.bindNodeName ~= nil then
      AzurWorld.RedDotMgr:BindLuaNode(conf.bindNodeName, key)
    end
  end
end

function reddotManager:on_sceneChange()
  self._dirtyList[self.DotDef.kiBoDuelAreaLevel] = true
  self._dirtyList[self.DotDef.Adventure_KiboDuelAreaLevel] = true
end

function reddotManager:_listenEvents()
  self.storeListenFuncs = {}
  for _, conf in ipairs(reddotManager.EventConf) do
    local store = conf.store
    
    local function func()
      self._dirtyList[conf.key] = true
    end
    
    self.storeListenFuncs[conf] = func
    store.listenCallFunc(store, conf.event, func)
  end
  self._SceneChangeHandler = handler(self, self.on_sceneChange)
  AzurWorld.areaManager:RegisterEvent(C_WorldAreaEventDefine.SceneChanged, self._SceneChangeHandler)
  
  function self._onAchieveRefresh()
    self._dirtyList[self.DotDef.Achieve] = true
  end
  
  C_AchievementEvent.instance:Listen(C_EAchievementEvent.RefreshAchievementList, self._onAchieveRefresh)
  C_AchievementEvent.instance:Listen(C_EAchievementEvent.GetAchievementPointReward, self._onAchieveRefresh)
  self.systemUnlockHandleIds = {}
  for key, conf in pairs(reddotManager.DotConf) do
    if conf.unlock then
      local module = AzurWorld.IntegrateMgr.SystemUnlockModule
      local cModule = C_IntegrateMgr.SystemUnlockModule
      local isSame = module == cModule
      self.systemUnlockHandleIds[key] = C_IntegrateMgr.SystemUnlockModule:listenCallFunc(C_IntegrateMgr.SystemUnlockModule.onDataChange, function()
        self._dirtyList[key] = true
      end)
    end
  end
  self._OnCSharpNotifyHandle = handler(self, self.onCsharpNotify)
  AzurWorld.RedDotMgr:RegistOnStateChanged(self._OnCSharpNotifyHandle)
end

function reddotManager:_unlistenEvents()
  if self.storeListenFuncs ~= nil then
    for _, conf in ipairs(reddotManager.EventConf) do
      local store = conf.store
      local registerFunc = self.storeListenFuncs[conf]
      if registerFunc ~= nil then
        store.unListenCallFunc(store, conf.event, registerFunc)
      end
    end
    self.storeListenFuncs = nil
  end
  if self._SceneChangeHandler ~= nil then
    AzurWorld.areaManager:UnregisterEvent(C_WorldAreaEventDefine.SceneChanged, self._SceneChangeHandler)
    self._SceneChangeHandler = nil
  end
  if self._onAchieveRefresh ~= nil then
    C_AchievementEvent.instance:Cancel(C_EAchievementEvent.RefreshAchievementList, self._onAchieveRefresh)
    C_AchievementEvent.instance:Cancel(C_EAchievementEvent.GetAchievementPointReward, self._onAchieveRefresh)
    self._onAchieveRefresh = nil
  end
  if self.systemUnlockHandleIds ~= nil then
    for key, handleId in pairs(self.systemUnlockHandleIds) do
      C_IntegrateMgr.SystemUnlockModule:unListenCallFunc(handleId)
    end
    self.systemUnlockHandleIds = nil
  end
  if self._OnCSharpNotifyHandle ~= nil then
    AzurWorld.RedDotMgr:UnRegistOnStateChanged()
    self._OnCSharpNotifyHandle = nil
  end
end

function reddotManager:setAllLeavesDirty()
  for key, conf in pairs(self.DotConf) do
    if conf.listFunc or conf.getFunc then
      self._dirtyList[key] = true
    end
  end
end

function reddotManager:update()
  L_ProfilerUtil.BeginSample("updateNode")
  local MAX_DIRTY_PER_FRAME = 1
  local processed = 0
  for key, _ in pairs(self._dirtyList) do
    self:updateNode(key)
    self._dirtyList[key] = nil
    processed = processed + 1
    if MAX_DIRTY_PER_FRAME <= processed then
      break
    end
  end
  L_ProfilerUtil.EndSample()
  L_ProfilerUtil.BeginSample("table count clear")
  local remainDirty = table.count(self._dirtyList)
  if 0 < remainDirty then
    printf("更新红点 分帧处理中, 剩余数量: %s", remainDirty)
  elseif 0 < processed then
    printf("更新红点 完成一帧刷新, 数量: %s", processed)
  end
  L_ProfilerUtil.EndSample()
  L_ProfilerUtil.BeginSample("invokeNodeUpdate")
  if self._needsClear then
    for go, key in pairs(self._go2Key) do
      if not L_CommonUtil.isValid(go) then
        self:invokeNodeUpdate(key)
        return
      end
    end
    self._needsClear = false
  end
  L_ProfilerUtil.EndSample()
end

function reddotManager:updateNode(key)
  if not self._reddotMap[key] then
    return
  end
  L_ProfilerUtil.BeginSample(key)
  local preValue = self._reddotMap[key].value
  local conf = reddotManager.DotConf[key]
  local addedState = 0
  if conf == nil then
    return
  end
  if conf.bindNodeName ~= nil then
    local has = AzurWorld.RedDotMgr:GetRedDotState(conf.bindNodeName)
    addedState = has and 1 or 0
  end
  if conf.subNodes or conf.bindNodeName then
    local value = addedState
    for _, subKey in ipairs(conf.subNodes or {}) do
      value = value + (self._reddotMap[subKey] and self._reddotMap[subKey].value or 0)
    end
    self._reddotMap[key].value = math.min(value, 1)
    if conf.bindNodeName ~= nil then
      printf("[C#RedDot]更新：" .. conf.bindNodeName .. " 红点值：" .. tostring(self._reddotMap[key].value))
    end
  elseif conf.getFunc then
    if not self[conf.getFunc] or conf.unlock and not C_IntegrateMgr.SystemUnlockModule:getSystemIsOpen(conf.unlock) then
      self._reddotMap[key].value = 0
    else
      local function getValue()
        return self[conf.getFunc](self)
      end
      
      local res, v = xpcall(getValue, self.errorFunction)
      if res then
        self._reddotMap[key].value = v
      end
    end
  elseif conf.listFunc then
    if not self[conf.listFunc] then
      self._reddotMap[key].value = 0
    else
      self._listNodeDatas[key] = self._listNodeDatas[key] or {}
      local lastValueMap = self._listNodeDatas[key]
      
      local function getValueMap()
        return not (not conf.unlock or C_IntegrateMgr.SystemUnlockModule:getSystemIsOpen(conf.unlock)) and {} or self[conf.listFunc](self)
      end
      
      local res, valueMap = xpcall(getValueMap, self.errorFunction)
      if res then
        for id, value in pairs(lastValueMap) do
          if not valueMap[id] then
            local subKey = string.format(key, id)
            self._reddotMap[subKey] = nil
            self:invokeNodeUpdate(subKey)
          end
        end
        local totalValue = 0
        for id, value in pairs(valueMap) do
          if lastValueMap[id] ~= value then
            local key = string.format(key, id)
            self._reddotMap[key] = self._reddotMap[key] or {}
            self._reddotMap[key].value = value
            self:invokeNodeUpdate(key)
          end
          totalValue = totalValue + value
        end
        self._listNodeDatas[key] = valueMap
        self._reddotMap[key].value = math.min(totalValue, 1)
      end
    end
  else
    errorf("error dotConf  " .. key)
  end
  if preValue ~= self._reddotMap[key].value then
    self:invokeNodeUpdate(key)
    if self._reddotMap[key].parent ~= nil then
      for i, v in pairs(self._reddotMap[key].parent) do
        self:updateNode(v)
      end
    end
  end
  L_ProfilerUtil.EndSample()
end

function reddotManager:getRedDotState(key, id)
  if self._reddotMap == nil then
    return
  end
  local subKey = string.format(key, id)
  if id == nil then
    subKey = key
  end
  local reddot = self._reddotMap[subKey]
  if reddot == nil then
    return
  end
  return reddot.value >= 1
end

function reddotManager:invokeNodeUpdate(key)
  if nil == self._key2Gos[key] then
    return
  end
  L_ProfilerUtil.BeginSample(key)
  local state = self._reddotMap[key] and self._reddotMap[key].value > 0 or false
  for go, _ in pairs(self._key2Gos[key]) do
    if L_CommonUtil.isValid(go) then
      local ctrl = go:GetComponent(typeof(C_ReddotCtrl))
      if ctrl then
        self:checkChangeState(go, state)
      else
        self:checkDynamicReddotChangeState(go, state)
      end
    else
      self._key2Gos[key][go] = nil
      self._go2Key[go] = nil
    end
  end
  if next(self._key2Gos[key]) == nil then
    self._key2Gos[key] = nil
  end
  L_ProfilerUtil.EndSample()
end

function reddotManager:registerDynamicReddot(uiRoot, key)
  if not L_CommonUtil.isValid(uiRoot) then
    return
  end
  local go = uiRoot.gameObject
  local oldKey = self._go2Key[go]
  if oldKey and oldKey ~= key then
    if self._key2Gos[oldKey] then
      self._key2Gos[oldKey][go] = nil
    end
    local oldReddotNode = go.transform:Find("reddotNormal(Clone)")
    if oldReddotNode then
      if L_ResPool and L_ResPool.DestroyGameObject then
        L_ResPool:DestroyGameObject(oldReddotNode.gameObject)
      else
        C_BoundGameObject.DestroyImmediate(oldReddotNode.gameObject)
      end
    end
  end
  self._go2Key[go] = key
  self._key2Gos[key] = self._key2Gos[key] or {}
  self._key2Gos[key][go] = true
  self:checkDynamicReddotChangeState(go, self._reddotMap[key] and self._reddotMap[key].value > 0 or false)
  self._needsClear = true
end

function reddotManager:registerReddot(obj, key)
  if not L_CommonUtil.isValid(obj) then
    return
  end
  local go = obj.gameObject
  go:SetActive(true)
  if not go:GetComponent(typeof(C_ReddotCtrl)) then
    go:AddComponent(typeof(C_ReddotCtrl))
  end
  local oldKey = self._go2Key[go]
  if oldKey then
    self._key2Gos[oldKey][go] = nil
  end
  self._go2Key[go] = key
  self._key2Gos[key] = self._key2Gos[key] or {}
  self._key2Gos[key][go] = true
  self:checkChangeState(go, self._reddotMap[key] and self._reddotMap[key].value > 0 or false)
  self._needsClear = true
end

function reddotManager:unregisterDynamicReddot(obj, key)
  if not L_CommonUtil.isValid(obj) then
    return
  end
  local go = obj.gameObject
  local currentKey = self._go2Key[go]
  if not currentKey or key ~= currentKey then
    return
  end
  if self._key2Gos[currentKey] then
    self._key2Gos[currentKey][go] = nil
  end
  self._go2Key[go] = nil
  local reddotNode = go.transform:Find("reddotNormal(Clone)")
  if reddotNode then
    if L_ResPool and L_ResPool.DestroyGameObject then
      L_ResPool:DestroyGameObject(reddotNode.gameObject)
    else
      C_BoundGameObject.DestroyImmediate(reddotNode.gameObject)
    end
  end
  if next(self._key2Gos[currentKey]) == nil then
    self._key2Gos[currentKey] = nil
  end
end

function reddotManager:unregisterReddot(obj, key)
  if not L_CommonUtil.isValid(obj) then
    return
  end
  local go = obj.gameObject
  local currentKey = self._go2Key[go]
  if not currentKey or key ~= currentKey then
    return
  end
  if self._key2Gos[currentKey] then
    self._key2Gos[currentKey][go] = nil
  end
  self._go2Key[go] = nil
  local ctrl = go:GetComponent(typeof(C_ReddotCtrl))
  if ctrl then
    C_BoundGameObject.DestroyImmediate(ctrl)
  end
  if next(self._key2Gos[currentKey]) == nil then
    self._key2Gos[currentKey] = nil
  end
end

function reddotManager:unregisterReddotByKey(key)
  if not self._key2Gos[key] then
    return
  end
  for go, _ in pairs(self._key2Gos[key]) do
    if L_CommonUtil.isValid(go) then
      local ctrl = go:GetComponent(typeof(C_ReddotCtrl))
      if ctrl then
        self:unregisterReddot(go, key)
      else
        self:unregisterDynamicReddot(go, key)
      end
    end
  end
end

function reddotManager:checkChangeState(go, state)
  local ctrl = go:GetComponent(typeof(C_ReddotCtrl))
  if L_CommonUtil.isValid(ctrl) then
    ctrl:SetState(state)
  end
end

function reddotManager:checkDynamicReddotChangeState(uiRoot, state)
  if not L_CommonUtil.isValid(uiRoot) then
    return
  end
  local reddotNode = uiRoot.transform:Find("reddotNormal(Clone)")
  if state == true then
    if reddotNode == nil then
      reddotNode = L_ResPool:syncGameObject("UI/CommonPrefabs/reddotNormal.prefab")
      if not L_CommonUtil.isValid(reddotNode) then
        return
      end
      reddotNode.transform:SetParent(uiRoot.transform, false)
      local rectTransform = uiRoot:GetComponent(typeof(CS.UnityEngine.RectTransform))
      if rectTransform then
        local rect = rectTransform.rect
        reddotNode.transform.localPosition = CS.UnityEngine.Vector3(rect.width * 0.5 - 20, rect.height * 0.5 - 20, 0)
      else
        reddotNode.transform.localPosition = CS.UnityEngine.Vector3(20, 20, 0)
      end
      if not reddotNode:GetComponent(typeof(C_ReddotCtrl)) then
        reddotNode:AddComponent(typeof(C_ReddotCtrl))
      end
    end
    local ctrl = reddotNode:GetComponent(typeof(C_ReddotCtrl))
    if L_CommonUtil.isValid(ctrl) then
      ctrl:SetState(state)
    end
    if L_CommonUtil.isValid(reddotNode) then
      reddotNode.gameObject:SetActive(true)
    end
  elseif reddotNode then
    local ctrl = reddotNode:GetComponent(typeof(C_ReddotCtrl))
    if L_CommonUtil.isValid(ctrl) then
      ctrl:SetState(state)
    end
    if L_CommonUtil.isValid(reddotNode) then
      reddotNode.gameObject:SetActive(false)
    end
  end
end

local dailyRedootClicked

local function initDailyReddot()
  local id = L_PlayerStore:getPlayerId()
  local dailyReddotStr = L_CommonUtil.getLocalValue("RedDot_Daily")
  local today = tostring(L_TimeUtil.getServerTimeOfDate(L_TimeUtil.getServerTime() - 3600 * tonumber(L_GameConstTpl:getData("DAILY_REFRESH_TIME", L_Const.GameTplType.int))))
  dailyRedootClicked = dailyRedootClicked or {}
  if dailyReddotStr then
    local dailyReddotTb = string.split(dailyReddotStr, ",")
    if today == dailyReddotTb[1] then
      dailyRedootClicked[id] = dailyReddotTb
      return
    else
      L_CommonUtil.clearLocalValue("RedDot_Daily")
    end
  end
  dailyRedootClicked[id] = {today}
end

local function haveDailyReddot(key)
  if not dailyRedootClicked then
    initDailyReddot()
  end
  local id = L_PlayerStore:getPlayerId()
  local today = tostring(L_TimeUtil.getServerTimeOfDate(L_TimeUtil.getServerTime() - 3600 * tonumber(L_GameConstTpl:getData("DAILY_REFRESH_TIME", L_Const.GameTplType.int))))
  if not dailyRedootClicked[id] or dailyRedootClicked[id][1] ~= today then
    dailyRedootClicked[id] = {today}
    return false
  else
    return table.containsValue(dailyRedootClicked[id], key)
  end
end

local function saveDailyReddot(key)
  if haveDailyReddot(key) then
    return
  end
  local id = L_PlayerStore:getPlayerId()
  table.insert(dailyRedootClicked[id], key)
  local dailyReddotStr = table.concat(dailyRedootClicked[id], ",")
  L_CommonUtil.setLocalValue("RedDot_Daily", dailyReddotStr)
end

local TempNewDatas = {}
local TempNews = setmetatable({}, {
  __index = function(t, k)
    local id = L_PlayerStore:getPlayerId()
    if not id then
      return nil
    end
    return TempNewDatas[id] and TempNewDatas[id][k]
  end,
  __newindex = function(t, k, v)
    local id = L_PlayerStore:getPlayerId()
    if not id then
      return
    end
    if TempNewDatas == nil then
      TempNewDatas = {}
    end
    TempNewDatas[id] = TempNewDatas[id] or {}
    TempNewDatas[id][k] = v
  end
})

function reddotManager:markNew(key, id, ignore)
  local totalKey = string.format(key, id)
  local dotKey = string.format("RedDot_New_%s", totalKey)
  if not TempNews[dotKey] then
    TempNews[dotKey] = true
    L_CommonUtil.setLocalValue(dotKey, 1)
    if not ignore then
      self._dirtyList[key] = true
    end
  end
end

function reddotManager:clearNew(key, id, ignore)
  local totalKey = string.format(key, id)
  local dotKey = string.format("RedDot_New_%s", totalKey)
  if TempNews[dotKey] then
    TempNews[dotKey] = false
    L_CommonUtil.clearLocalValue(dotKey)
    if not ignore then
      self._dirtyList[key] = true
    end
  end
end

function reddotManager:haveNew(key, id)
  if not L_PlayerStore:getPlayerId() then
    return false
  end
  local totalKey = string.format(key, id)
  local dotKey = string.format("RedDot_New_%s", totalKey)
  if TempNews[dotKey] == nil then
    TempNews[dotKey] = tonumber(L_CommonUtil.getLocalValue(dotKey)) == 1
  end
  return TempNews[dotKey]
end

function reddotManager:setDirty(key, isDirty)
  self._dirtyList[key] = isDirty
end

function reddotManager:haveDailyNew(key, id, ignore)
  local totalKey = string.format(key, id)
  if haveDailyReddot(totalKey) then
    return false
  end
  return true
end

function reddotManager:clearDailyNew(key, id, ignore)
  local totalKey = string.format(key, id)
  saveDailyReddot(totalKey)
end

function reddotManager:onCsharpNotify(key)
  print("[C#RedDot]LuaUpdateFromC# : key:" .. (key or "nil"))
  self._dirtyList[key] = true
end

function reddotManager:errorFunction(err)
  print(err)
end

return reddotManager
