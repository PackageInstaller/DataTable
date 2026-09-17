local this = class("modulePhotoGroup_lightArrange", require("ui.pages.photo.group.modulePhotoGroup_base"))
local _screenPosToUI = Unity.RectTransformUtility.ScreenPointToLocalPointInRectangle

function this.bind()
  return {
    modulePhotoLightSetting = {
      moduleName = "pages/photo/submodule/modulePhotoLightSetting"
    },
    isActive_lightDrag = false,
    listTab = {
      moduleName = "pages/photo/cell/cellPhotoLightTab"
    },
    tabId = 0,
    listDrag = {
      moduleName = "pages/photo/cell/cellPhotoLightDrag"
    }
  }
end

function this.methods()
  return {
    onDrag_light = function(self, screenPos)
    end,
    onEndDrag_light = function(self, screenPos)
    end,
    onClick_lightTab = function(self, tabId)
      if self.bind.tabId == tabId then
        return
      end
      self.bind.tabId = tabId
      self:onSelectLight(tabId)
    end,
    modulePhotoLightSetting = {
      setLightOn = function(self, id, isOn)
        self:refreshTabStatus(id, isOn)
      end,
      setLightColor = function(self, lightData)
        self:refreshTabColor(lightData.lightId)
      end
    },
    listDrag = {
      onDrag_light = function(self, tabId, screenPos)
        self.isDragging = true
        self:onDrag_light(screenPos, tabId)
      end,
      onEndDrag = function(self)
        self.isDragging = false
      end
    },
    onClickHideGroup = function(self)
      L_PhotoManager:sendEvent(L_PhotoManager.event.isActiveBg)
      self:hideGroup()
    end
  }
end

function this:open()
  if not self.lightData then
    self.lightData = {}
    L_PhotoManager.mediator.lightArrangeData = self.lightData
    self:initLightData()
  end
  self.modules.modulePhotoLightSetting.groupBase = self
  self:initTab()
  self.bind.tabId = 1
end

function this:show()
  self.isDragging = false
  self.timer = Timer.repeated(0, self.update, self)
end

function this:refresh()
end

function this:initLightData()
  for i = 1, 3 do
    local data = require("ui.pages.photo.submodule.photoLightData").new()
    data.lightId = i
    self.lightData[i] = data
    data:reset(true)
  end
end

function this:initTab()
  self.bind.listTab:clear()
  self.bind.listDrag:clear()
  for i = 1, 3 do
    local tab = {
      tabId = i,
      tabGroup = self.bindComponents.tabGroup
    }
    self.bind.listTab:insert(tab)
    local drag = {tabId = i, isOn = false}
    self.bind.listDrag:insert(drag)
  end
end

function this:onSelectLight(id)
  if id <= 0 or 3 < id then
    return
  end
  if self.lightData[id] then
    self.modules.modulePhotoLightSetting:initWithData(self.lightData[id])
    self:syncDragBtnPos(self.lightData[id])
  end
end

function this:refreshTabColor(id)
  local m = self.modules.listTab[id]
  if m then
    self.bind.listTab:change(id, {
      color = self.lightData[id].color
    })
  end
end

function this:refreshTabStatus(id, isOn)
  local m = self.modules.listTab[id]
  if m then
    self.bind.listTab:change(id, {
      color = self.lightData[id].color
    })
  end
  local drag = self.modules.listDrag[id]
  if drag then
    self.bind.listDrag:change(id, {isOn = isOn})
  end
end

function this:syncDragBtnPos(lightData)
  if lightData and lightData.isOn and not self.isDragging then
    local screenPos = C_CameraManager.mainCamera:WorldToScreenPoint(lightData.position)
    local v2 = C_Vector2(screenPos.x, screenPos.y)
    local _, pos = _screenPosToUI(self.bindComponents.btnDrag_light.transform.parent, v2, C_CameraManager.uiCamera)
    local dragBtn = self.modules.listDrag[lightData.lightId]
    if dragBtn and dragBtn.gameObject then
      L_Vector3.setAnchored(dragBtn.gameObject.transform, pos)
    end
  end
end

function this:hide()
  Timer.remove(self.timer)
end

function this:close()
  for i, v in pairs(self.lightData) do
    v:destroyObj()
  end
end

function this:update()
  for i, v in pairs(self.lightData) do
    if v.isOn then
      self:syncDragBtnPos(v)
    end
  end
end

function this:onDrag_light(screenPos, id)
  local cam = C_CameraManager.mainCamera
  local plane = Unity.Plane(cam.transform.forward, self.lightData[id].position)
  local ray = cam:ScreenPointToRay(C_Vector3(screenPos.x, screenPos.y, 0))
  local s, distance = plane:Raycast(ray)
  if s then
    local hitPoint = ray:GetPoint(distance)
    self.lightData[id]:setPosition(hitPoint)
  end
end

return this
