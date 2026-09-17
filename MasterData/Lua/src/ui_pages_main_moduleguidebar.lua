local module = class("moduleGuideBar", G_UIModuleBase)

local function getMapStore()
  return C_MapManager:GetMapStore()
end

function module.bind()
  return {
    guidePoint = true,
    guidePointList = {
      moduleName = "pages/Main/guideBarPointItem"
    },
    guidePointList_mapMarks = {
      moduleName = "pages/Main/guideBarPointItem"
    }
  }
end

function module.methods()
  return {}
end

function module:created(...)
  module.super.created(self, ...)
  self.bindComponents.img_guide.uvRect = C_Rect(0, 0, 1, 1)
  self.target = C_CameraManager.mainCamera.transform
  self.currentPointNum = 0
  self.taskEntityIds = {}
end

function module:open()
  self.onEvent_taskUpdateHandleFunc = self.onEvent_taskUpdateHandleFunc or handler(self, self.onEvent_taskUpdateHandle)
  AzurWorld.TaskMgr:RegisterEvent(C_ETaskEvent.RefreshUITask, self.onEvent_taskUpdateHandleFunc)
  self.onEvent_setCurrentTracedTaskFunc = self.onEvent_setCurrentTracedTaskFunc or handler(self, self.onEvent_setCurrentTracedTask)
  AzurWorld.TaskMgr:RegisterEvent(C_ETaskEvent.SetCurrentTracedTask, self.onEvent_setCurrentTracedTaskFunc)
  local mapStore = getMapStore()
  if mapStore then
    self.mapMarkTraceHandle = mapStore:listenCallFunc("refreshTracing", self.onEvent_mapMarkTraceUpdate, self)
  end
end

function module:show()
  self.currentPointNum = 0
end

function module:close()
  if self.onEvent_taskUpdateHandleFunc then
    AzurWorld.TaskMgr:UnregisterEvent(C_ETaskEvent.RefreshUITask, self.onEvent_taskUpdateHandleFunc)
  end
  if self.onEvent_setCurrentTracedTaskFunc then
    AzurWorld.TaskMgr:UnregisterEvent(C_ETaskEvent.SetCurrentTracedTask, self.onEvent_setCurrentTracedTaskFunc)
  end
  local mapStore = getMapStore()
  if mapStore and self.mapMarkTraceHandle then
    mapStore:unListenCallFunc(self.mapMarkTraceHandle)
    self.mapMarkTraceHandle = nil
  end
end

function module:onEvent_taskUpdateHandle(type, list)
  self.currentPointNum = -1
end

function module:onEvent_setCurrentTracedTask(_, args)
end

function module:onEvent_mapMarkTraceUpdate()
  local areaId = AzurWorld.areaManager:GetMapAreaId()
  if not areaId then
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
    if mapStore:getTracing(v.guid) then
      table.insert(tempData, {
        guidePoint = true,
        guid = v.guid,
        guideType = L_Const.guidePointType.mapMark
      })
    end
  end
  self.bind.guidePointList_mapMarks:insert_array(tempData)
end

function module:initGuidePoints(taskEntityIds, player)
end

function module:fresh()
  if self.isBind and self.target then
    self.bindComponents.img_guide.uvRect = C_Rect(self.target.rotation.eulerAngles.y / 360 - 0.5, 0, 1, 1)
    self:setTaskTracedTarget()
    self:setMapMarkTracedPoint()
  end
end

function module:setMapMarkTracedPoint()
  for i = 1, #self.bind.guidePointList_mapMarks do
    local cell = self.bind.guidePointList_mapMarks:getItemCls(i)
    if cell then
      cell:fresh()
    end
  end
end

function module:setTaskTracedTarget()
end

function module:hideAllGuidePoint()
  for i = 1, #self.bind.guidePointList do
    if self.bind.guidePointList:getItemCls(i) then
      self.bind.guidePointList:getItemCls(i):hideGuidePoint()
    end
  end
end

return module
