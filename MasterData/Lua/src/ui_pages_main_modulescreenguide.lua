local module = class("moduleScreenGuide", G_UIModuleBase)
local _taskTpl = L_GameTpl:getTaskTpl()
local _worldMapTpl = L_GameTpl:getWorldMapTpl()
local _worldCityTpl = L_GameTpl:getWorldCityTpl()
local _worldEntityTipsTpl = L_GameTpl:getWorldEntityTipsTpl()
local CHALLENGEPOINTPATH = "UI/Pages/Main/challengePointItem.prefab"
local C_EPlayerFightStateEnum = CS.Lens.Gameplay.Modules.BigWorld.EPlayerFightState

local function getMapStore()
  return C_MapManager:GetMapStore()
end

local function hasNodeTarget(nodeInfo)
  return nodeInfo ~= nil and nodeInfo.sceneId ~= 0
end

function module.bind()
  return {
    guidePoint = false,
    guidePointList = {
      moduleName = "pages/main/guidePointItem"
    },
    guidePointList_journey = {
      moduleName = "pages/main/guidePointItem"
    },
    guidePointList_mapMarks = {
      moduleName = "pages/main/guidePointItem"
    },
    guidePointList_nodeTarget = {
      moduleName = "pages/main/mapGuideNodeItem"
    },
    guidePointList_dungeonTarget = {
      moduleName = "pages/main/dungeonPointItem"
    },
    guidePointList_nodeExploreTarget = {
      moduleName = "pages/main/dungeonPointItem"
    },
    dungeonTargetActive = true
  }
end

function module.methods()
  return {}
end

function module:created(...)
  self.super.created(self, ...)
end

function module:open()
  self.updateHandle = handler(self, self.update)
  self.asyncSpawnPool = L_PoolManager:getAsyncSpawnPool(self.bindComponents.worldChallengeActive.transform)
  C_UpdateSource.AddLateUpdateEventHandler(self.updateHandle, "moduleScreenGuide.update")
  local mapStore = getMapStore()
  if mapStore then
    self.mapMarkTraceHandle = mapStore:listenCallFunc("refreshTracing", self.onEvent_mapMarkTraceUpdate, self)
    self.mapNodeTraceHandle = mapStore:listenCallFunc("refreshNodeTrace", self.onEvent_mapNodeTargetTrace, self)
  end
  self._onCutWorldComplete = handler(self, self.onEvent_mapNodeTrace)
  C_GameFlow.flowEvent:Listen(C_EGameFlowEvent.CutWorldComplete, self._onCutWorldComplete)
  L_BattleDataManager:addListener(L_BattleDataManager.event.playerFightStateChange, self.setChallengeNodeAcitve, self)
  L_WorldChallengeManager:addListener(L_WorldChallengeManager.event.generateChallengePoint, self.onEvent_generateChallengePoint, self)
  L_WorldChallengeManager:addListener(L_WorldChallengeManager.event.disposeChallengePoint, self.onEvent_disposeChallengePoint, self)
  self._syncChallengeDataHandler = handler(self, self.onEvent_syncChallengeData)
  AzurWorld.ChallengeMgr:RegisterEvent(C_EChallengeEvent.SyncChallengeData, self._syncChallengeDataHandler)
  self.limitCanvas = self.bindComponents.limitCanvas
end

function module:show()
  self.currentPointNum = 0
  self:initGuidePoints()
  self:initDungeonChallengePoints()
  self:initMapMarkPoints()
  self:initMapNodeTarget()
  self:initWorldChallengePoints()
end

function module:hide()
  self.bind.guidePointList:clear()
  self.bind.guidePointList_mapMarks:clear()
  self.bind.guidePointList_nodeTarget:clear()
  self.bind.guidePointList_dungeonTarget:clear()
  self:disposeWorldChallengePoints()
end

function module:close()
  C_UpdateSource.RemoveLateUpdateEventHandler(self.updateHandle)
  self.currentPointNum = 0
  self.asyncSpawnPool:dispose()
  local mapStore = getMapStore()
  if mapStore then
    if self.mapMarkTraceHandle then
      mapStore:unListenCallFunc(self.mapMarkTraceHandle)
      self.mapMarkTraceHandle = nil
    end
    if self.mapNodeTraceHandle then
      mapStore:unListenCallFunc(self.mapNodeTraceHandle)
      self.mapNodeTraceHandle = nil
    end
  end
  C_GameFlow.flowEvent:Cancel(C_EGameFlowEvent.CutWorldComplete, self._onCutWorldComplete)
  L_BattleDataManager:removeListener(L_BattleDataManager.event.playerFightStateChange, self.setChallengeNodeAcitve, self)
  L_WorldChallengeManager:removeListener(L_WorldChallengeManager.event.generateChallengePoint, self.onEvent_generateChallengePoint)
  L_WorldChallengeManager:removeListener(L_WorldChallengeManager.event.disposeChallengePoint, self.onEvent_disposeChallengePoint)
  AzurWorld.ChallengeMgr:UnregisterEvent(C_EChallengeEvent.SyncChallengeData, self._syncChallengeDataHandler)
end

function module:update()
  self:setTaskTracedPoint()
  self:setMapMarkTracedPoint()
  self:setMapNodeTarget()
  self:setDungeonChallengeNodeTarget()
end

function module:onEvent_disposeChallengePoint(tipData)
  if not self.resKetDic then
    return
  end
  if self.resKetDic[tipData.entity.data.entityId] then
    self.asyncSpawnPool:despawnRes(self.resKetDic[tipData.entity.data.entityId], true)
    self.resKetDic[tipData.entity.data.entityId] = nil
  end
end

function module:onEvent_generateChallengePoint(tipData)
  self:asyncSpawnTipsTarget(tipData)
end

function module:initWorldChallengePoints()
  self.resKetDic = {}
  self.bindComponents.worldChallengeActive.gameObject:ActiveTrans(true)
  local dataList = L_WorldChallengeManager:getChallengePointList()
  for i, v in pairs(dataList) do
    self:asyncSpawnTipsTarget(v)
  end
end

function module:asyncSpawnTipsTarget(tipData)
  local resKey = self.asyncSpawnPool:asyncGameObject(CHALLENGEPOINTPATH, function(go)
    local mainCityGuidePoint = go:GetComponent(typeof(C_MainCityGuidePoint))
    go.transform:Reset(self.bindComponents.worldChallengeActive.transform)
    L_Vector3.setScale(go.transform, L_Vector3.getTemp(1, 1, 1))
    mainCityGuidePoint:Init(self.bindComponents.guidePointViewPort, tipData, true)
    local icon = go.transform:GetComponent(typeof(C_LImage))
    local group = go.transform:GetComponent(typeof(C_CanvasGroup))
    group.alpha = 0
    local tpl = _worldEntityTipsTpl:getTplById(tipData.cfgId)
    if tpl then
      icon:LoadSprite(_worldEntityTipsTpl:getResourcePath(tpl))
    end
  end, true, true)
  self.resKetDic[tipData.entity.data.entityId] = resKey
end

function module:disposeWorldChallengePoints()
  self.asyncSpawnPool.spawnPool:dispose()
  self.resKetDic = nil
  self.resKetDic = {}
  self.bindComponents.worldChallengeActive.gameObject:ActiveTrans(false)
end

function module:onEvent_taskUpdateHandle()
  self:initGuidePoints()
end

function module:onEvent_syncChallengeData()
  self:initDungeonChallengePoints()
end

function module:onEvent_mapMarkTraceUpdate()
  self:initMapMarkPoints()
end

function module:onEvent_mapNodeTrace()
  self:initMapMarkPoints()
  self:initMapNodeTarget()
  self:initGuidePoints()
end

function module:onEvent_mapNodeTargetTrace(nodeInfo)
  self:initMapNodeTarget(nodeInfo)
end

function module:initGuidePoints()
  local pointDatas = {}
  local traceTasks = AzurWorld.TaskMgr:GetTaskTraceInfosBySceneId(AzurWorldInstance.CurWorldId)
  local count = traceTasks.Count - 1
  for i = 0, count do
    local taskId = traceTasks[i].TaskId
    local triggerData = traceTasks[i].TriggerData
    local tplTask = _taskTpl:getTplById(taskId)
    local modelControl
    local Obj = AzurWorld.TaskMgr:GetTaskOrWorldEntity(taskId, triggerData.targetId, triggerData.sceneId, triggerData.isClientCreate)
    if L_CommonUtil.isValid(Obj) and L_CommonUtil.isValid(Obj.target) then
      modelControl = Obj.target.transform.gameObject:GetComponent(typeof(C_ModelControl))
    end
    table.insert(pointDatas, {
      imgIcon = _taskTpl:getMapTaskIcon(tplTask),
      guidePoint = true,
      targetDirection = true,
      taskEntityId = triggerData.targetId,
      isNeedShowRange = triggerData.isNeedShowRange,
      showRange = triggerData.showRange,
      triggerRange = triggerData.isNeedShowRange and triggerData.triggerRange or -1,
      inRangeShowGuide = triggerData.inRangeShowGuide,
      getTargetPosFunc = function()
        return traceTasks[i]:GetPosition(true)
      end,
      modelControl = modelControl
    })
  end
  self.bind.guidePointList:clear()
  self.bind.guidePointList:insert_array(pointDatas)
  self.currentPointNum = #pointDatas
  self.bind.guidePoint = 0 < self.currentPointNum
  for i = 1, #self.bind.guidePointList do
    local cell = self.bind.guidePointList:getItemCls(i)
    if cell then
      cell:refreshTargetPoint(self.limitCanvas, self.bindComponents.guidePointViewPort)
    end
  end
end

function module:initDungeonChallengePoints()
  local showData = AzurWorld.ChallengeMgr:GetShowChallengeData()
  local dataList = showData.allDataList
  local groupData = showData.groupData
  if groupData.state == C_EChallengeState.None or groupData.state == C_EChallengeState.End then
    self.bind.guidePointList_dungeonTarget:clear()
    return
  end
  local dataCount = dataList.Count
  local tempData = {}
  for i = 0, dataCount - 1 do
    local data = dataList[i]
    if not math.isEmpty(data.param1) then
      local curScene = AzurWorldInstance.CurWorldId
      local tpl = _worldMapTpl:getTplById(curScene, data.param1)
      if tpl then
        local pos = _worldMapTpl:getPosition(tpl)
        pos.y = pos.y + 2
        table.insert(tempData, {
          guidePoint = true,
          targetDirection = true,
          targetPos = pos
        })
      end
    end
    if not math.isEmpty(data.param2) then
      local entity = C_EntityManager.GetEntity(data.param2)
      if entity then
        local pos = entity.transform.position
        pos.y = pos.y + 2
        table.insert(tempData, {
          guidePoint = true,
          targetDirection = true,
          targetPos = pos
        })
      end
    end
  end
  self.bind.guidePointList_dungeonTarget:clear()
  self.bind.guidePointList_dungeonTarget:insert_array(tempData)
end

function module:initMapMarkPoints()
  local areaId = AzurWorld.areaManager:GetMapAreaId()
  if not areaId or areaId < 0 then
    return
  end
  local mapStore = getMapStore()
  local marks = mapStore and mapStore:getMarkListBymapId(areaId)
  self.bind.guidePointList_mapMarks:clear()
  if not marks then
    return
  end
  local tempData = {}
  for i = 0, marks.Count - 1 do
    local v = marks[i]
    if mapStore:getTracing(v.guid) and v.isSetPosY then
      table.insert(tempData, {
        guidePoint = true,
        targetDirection = true,
        guid = v.guid
      })
    end
  end
  self.bind.guidePointList_mapMarks:insert_array(tempData)
end

function module:initMapNodeTarget(nodeInfo)
  local mapStore = getMapStore()
  nodeInfo = nodeInfo or mapStore and mapStore:getCurNodeTargetTracing() or nil
  if not hasNodeTarget(nodeInfo) then
    self.bind.guidePointList_nodeTarget:clear()
    return
  end
  self.bind.guidePointList_nodeTarget:clear()
  local isSameScene = AzurWorldInstance.CurWorldId == nodeInfo.sceneId
  if not isSameScene then
    return
  end
  local tempData = {}
  table.insert(tempData, {
    guidePoint = true,
    targetDirection = true,
    nodeInfo = nodeInfo
  })
  self.bind.guidePointList_nodeTarget:insert_array(tempData)
end

function module:setTaskTracedPoint()
  if not self.bind.guidePoint then
    return
  end
  for i = 1, #self.bind.guidePointList do
    local cell = self.bind.guidePointList:getItemCls(i)
    if cell then
      cell:refreshTargetPoint(self.limitCanvas, self.bindComponents.guidePointViewPort)
    end
  end
end

function module:setMapMarkTracedPoint()
  for i = 1, #self.bind.guidePointList_mapMarks do
    local cell = self.bind.guidePointList_mapMarks:getItemCls(i)
    if cell then
      cell:refreshTargetPoint_mapMark(self.limitCanvas, self.bindComponents.guidePointViewPort)
    end
  end
end

function module:setMapNodeTarget()
  for i = 1, #self.bind.guidePointList_nodeTarget do
    local cell = self.bind.guidePointList_nodeTarget:getItemCls(i)
    if cell then
      cell:refreshTargetPoint_nodeTarget(self.limitCanvas, self.bindComponents.guidePointViewPort)
    end
  end
end

function module:setDungeonChallengeNodeTarget()
  if not self.bind.dungeonTargetActive then
    return
  end
  for i = 1, #self.bind.guidePointList_dungeonTarget do
    local cell = self.bind.guidePointList_dungeonTarget:getItemCls(i)
    if cell then
      cell:refreshChallengeTarget(self.limitCanvas, self.bindComponents.guidePointViewPort)
    end
  end
end

function module:setChallengeNodeAcitve(state)
  if state == C_EPlayerFightStateEnum.Idle then
    self.bind.dungeonTargetActive = true
    self:initDungeonChallengePoints()
  elseif state == C_EPlayerFightStateEnum.Fighting then
    self.bind.dungeonTargetActive = false
  end
end

function module:activate()
  self:open()
  self:openModules()
  self:show()
  self:showModules()
end

function module:deActivate()
  self:hide()
  self:hideModules()
  self:close()
  self:closeModules()
end

return module
