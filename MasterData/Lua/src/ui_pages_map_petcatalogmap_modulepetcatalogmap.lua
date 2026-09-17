local this = class("modulePetHabitatMap", G_UIModuleBase)
local _worldFilter = L_GameTpl:getWorldFilterTpl()
local _worldPointTpl = L_GameTpl:getWorldBorthposTpl()
local _worldAreaTpl = L_GameTpl:getWorldAreaTpl()
local _worldMapTpl = L_GameTpl:getWorldMapTpl()
local _areaTpl = L_GameTpl:getAreaTpl()
local _exploreTpl = L_GameTpl:getExploreTpl()
local _exploreLevelTpl = L_GameTpl:getExploreLevelTpl()
local _worldFilterMarkTpl = L_GameTpl:getWorldFilterMarkTpl()
local _screenPosToUI = Unity.RectTransformUtility.ScreenPointToLocalPointInRectangle
local screenOffset = 100
local screenOffsetMinY = 480
local _tmpPos = C_Vector3.zero
local _tmpVec2 = C_Vector2.zero
local _toInt32 = CS.System.Convert.ToInt32

local function normalizeNodeTypeKey(nodeType)
  if type(nodeType) == "number" then
    return nodeType
  end
  local ok, value = pcall(_toInt32, nodeType)
  if ok then
    return value
  end
  return nodeType
end

local function toLuaList(list)
  if list == nil then
    return {}
  end
  if type(list) == "userdata" and list.Count ~= nil then
    local result = {}
    for i = 0, list.Count - 1 do
      result[#result + 1] = list[i]
    end
    return result
  end
  return list
end

local function toLuaNodeDic(nodeDic)
  if nodeDic == nil then
    return {}
  end
  if type(nodeDic) == "userdata" and nodeDic.Count ~= nil then
    local result = {}
    for nodeType, list in pairs(nodeDic) do
      result[normalizeNodeTypeKey(nodeType)] = toLuaList(list)
    end
    return result
  end
  return nodeDic
end

function this.bind()
  return {
    sliderValue = 0,
    selfAngle = C_Vector3(0, 0, 0),
    arrowAngle = C_Vector3(0, 0, 0)
  }
end

function this.methods()
  return {
    onClick_add = function(self)
      local value = math.clamp(self.mapData.sliderValue + 0.01, 0, 1)
      self.bindComponents.slider_scale.value = value
    end,
    onClick_decrease = function(self)
      local value = math.clamp(self.mapData.sliderValue - 0.01, 0, 1)
      self.bindComponents.slider_scale.value = value
    end,
    onValueChanged_mapScale = function(self, value)
      self.mapScale = value
      self:setMapScale(self.mapScale)
      self:checkSelfPointIsOutScreen()
    end
  }
end

function this:preOpen()
end

function this:open()
  L_SceneStore:listenCallFunc(L_SceneStore.event.refreshPoint, self.onEvent_refreshTransferNode, self)
  self:configTouch("+")
  self.mapScale = 0
  self.pool = L_PoolManager:getResPool()
  self.timers = {}
  self.mapData = nil
  self.mapBuilder = nil
  self.nodeDic = {}
  self.areaBlockDic = {
    areaBlock = {},
    miniAreaBlock = {},
    sceneBorderTransfer = {},
    areaMask = {},
    areaBoundary = {}
  }
  local size = 1
  self.judgeWidth = Unity.Screen.width / size
  self.judgeHeight = Unity.Screen.height / size
  self.middlePoint = L_Vector3.new(Unity.Screen.width / 2, Unity.Screen.height / 2)
  self.vector_up = L_Vector3.new(0, 1)
  self.isPc = L_DeviceTpl:getIsPc()
  self.updateHandle = handler(self, self.update)
  C_UpdateSource.AddUpdateEventHandler(self.updateHandle, "modulePetCatalogMap.modulePetHabitatMap.update")
end

function this:show()
  self.bindComponents.aniPage:Play("anim_bigmap_open")
end

function this:update()
  if not (self.parent and self.parent.parent) or not self.parent.parent.bind.mapInfoActive then
    return
  end
  if self.isPc then
    local scrollInput = Unity.Input.GetAxis("Mouse ScrollWheel")
    if scrollInput ~= 0 then
      self:updateScroll(scrollInput)
    end
  end
  if self.mapData then
    self:checkSelfPointIsOutScreen()
  end
end

function this:updateScroll(dv)
  self.mapScale = self.mapScale + (0 < dv and 0.05 or dv < 0 and -0.05 or 0)
  self.mapScale = math.clamp(self.mapScale, 0, 1)
  self.bindComponents.slider_scale.value = self.mapScale
end

function this:setAreaId(areaId)
  if math.isEmpty(areaId) then
    errorf("地图areaId不能为空")
    return
  end
  if areaId ~= self.curAreaId then
    self:initMap(areaId)
  end
  self.curAreaId = areaId
  self:initCenterPos()
  self:focusPlayerPos()
end

function this:close()
  L_SceneStore:unListenCallFunc(L_SceneStore.event.refreshPoint, self.onEvent_refreshTransferNode)
  C_UpdateSource.RemoveUpdateEventHandler(self.updateHandle)
  self:configTouch("-")
  L_TimerManager:clearTimer(self)
  self:clearAllTimer()
  self:clearAllNode()
  self:clearAllStaticNode()
  self.pool:dispose()
end

function this:onEvent_refreshTransferNode()
  self:refreshAllNodeLockState(L_MapConst.mapSievingType.transfer)
end

function this:checkSelfPointIsOutScreen()
  if self.mapData.areaId ~= AzurWorld.areaManager:GetMapAreaId() then
    self.bindComponents.playerTarget.gameObject:ActiveTrans(false)
    return
  end
  local screenPos = C_CameraManager.uiCamera:WorldToScreenPoint(self.bindComponents.player.position)
  if screenPos.x <= self.judgeWidth and screenPos.x >= 0 and screenPos.y <= self.judgeHeight and screenPos.y >= screenOffsetMinY then
    self.bindComponents.playerTarget.gameObject:ActiveTrans(false)
    return
  end
  local target = (screenPos - self.middlePoint).normalized
  local cos = math.clamp(L_Vector3.dot(target, self.vector_up), -1, 1)
  local deg = math.acos(cos) * (180 / math.pi)
  local cross = self.vector_up.x * target.y - self.vector_up.y * target.x
  if cross < 0 then
    deg = -deg
  end
  _tmpPos.z = deg
  self.bind.arrowAngle = _tmpPos
  self.bindComponents.playerTarget.gameObject:ActiveTrans(true)
  local k = (screenPos.y - self.middlePoint.y) / (screenPos.x - self.middlePoint.x)
  if screenPos.y > self.judgeHeight - screenOffset then
    screenPos.y = self.judgeHeight - screenOffset
    screenPos.x = self.middlePoint.x + (screenPos.y - self.middlePoint.y) / k
  elseif screenPos.y < screenOffsetMinY then
    screenPos.y = screenOffsetMinY
    screenPos.x = self.middlePoint.x + (screenPos.y - self.middlePoint.y) / k
  end
  if screenPos.x > self.judgeWidth - screenOffset then
    screenPos.x = self.judgeWidth - screenOffset
    screenPos.y = self.middlePoint.y + (screenPos.x - self.middlePoint.x) * k
  elseif screenPos.x < screenOffset then
    screenPos.x = screenOffset
    screenPos.y = self.middlePoint.y + (screenPos.x - self.middlePoint.x) * k
  end
  _tmpVec2.x = screenPos.x
  _tmpVec2.y = screenPos.y
  local rect = self.bindComponents.mapShowRect
  local _, uiPos = _screenPosToUI(rect, _tmpVec2, C_CameraManager.uiCamera)
  L_Vector3.setAnchored(self.bindComponents.playerTarget, uiPos)
end

function this:setScreenOffsetMinY(value)
  screenOffsetMinY = value
end

function this:clearAllTimer()
  for _, v in pairs(self.timers) do
    Timer.remove(v)
  end
  self.timers = {}
  if self.doTweenMap then
    self.doTweenMap:Kill()
  end
end

function this:initMap(areaId)
  self:initMapData(areaId)
  self.mapBuilder = C_MapManager:CreateMapBuilder(self.mapData)
  self.mapBuilder:paint(self.bindComponents.imgMap)
  local tpl = _worldAreaTpl:getTplById(self.mapData.areaId)
  local isCut = _worldAreaTpl:getIsCut(tpl)
  if self.mapData.isStream and isCut then
    self.mapBuilder:setTargetTrans(self.bindComponents.mapShowRect)
  end
  self:setMapInit(areaId)
  self:clearAllStaticNode()
  self.areaBlockDic.areaBlock = toLuaList(C_MapManager:GetMapAreaBlockList(self.mapData.sceneId, self.areaBlockDic.areaBlock))
  self.areaBlockDic.miniAreaBlock = toLuaList(C_MapManager:GetMiniAreaBlockList(self.mapData.sceneId, self.areaBlockDic.miniAreaBlock))
  self.areaBlockDic.sceneBorderTransfer = toLuaList(C_MapManager:GetAllSceneBorderTransferNode(self.mapData.sceneId, self.areaBlockDic.sceneBorderTransfer))
  self.areaBlockDic.areaMask = toLuaList(C_MapManager:GetMapAreaMask(self.mapData.sceneId, self.areaBlockDic.areaMask))
  self.areaBlockDic.areaBoundary = toLuaList(C_MapManager:GetMapAreaBoundary(self.mapData.areaId, self.areaBlockDic.areaBoundary))
  if table.isEmpty(self.areaBlockDic.areaMask) then
    self.bindComponents.mapMaskNode.gameObject:ActiveTrans(false)
  else
    self.bindComponents.mapMaskNode.gameObject:ActiveTrans(true)
  end
  for i, list in pairs(self.areaBlockDic) do
    for _, v in ipairs(list) do
      if v.type == L_MapConst.mapSievingType.areaMask or v.type == L_MapConst.mapSievingType.areaBoundary then
        v:Generate(self.bindComponents.mapMaskNode.transform)
      else
        v:Generate(self.bindComponents.entityNode.transform)
      end
    end
  end
  self:refreshAllNodeLockState()
  self:refreshAllNodeState()
  self:refreshAllNodePos()
end

function this:setPetConfigId(petConfigId, isNight)
  self.petConfigId = petConfigId
  self:initAllMapNode(petConfigId, isNight)
end

function this:initMapData(areaId)
  local tpl = _worldAreaTpl:getTplById(areaId)
  local curAreaId = areaId
  if string.isEmpty(_worldAreaTpl:getAreaMap(tpl)) then
    local sceneId = _worldAreaTpl:getSceneId(tpl)
    local list = {}
    for i, v in pairs(_worldAreaTpl:getAllArea(sceneId)) do
      table.insert(list, v)
    end
    table.sort(list, function(a, b)
      return _worldAreaTpl:getId(a) < _worldAreaTpl:getId(b)
    end)
    curAreaId = _worldAreaTpl:getId(list[1])
  end
  if self.mapBuilder ~= nil and self.mapBuilder.data.areaId ~= areaId then
    self.mapBuilder:removePaint()
    self.mapBuilder = nil
  end
  self.mapData = C_MapManager:CreateMapData(curAreaId)
  self.mapData.isStream = true
  self.mapData.isBigMap = true
  self.bind.mapDirection = C_Vector3(0, 0, -self.mapData.mapDirection)
  local rect = self.bindComponents.mapShowRect.rect
  self.mapData:setShowSize(rect.width / 2, rect.height / 2)
  L_Vector3.setSize(self.bindComponents.imgMap, self.mapData.imgScale)
  L_Vector3.setAnchored(self.bindComponents.imgMap, L_Vector3.zero)
end

function this:setMapInit(areaId)
  local tpl = _worldAreaTpl:getTplById(self.mapData.areaId)
  if tpl then
    self.mapScale = L_GameConstTpl:getData("MAP_ENTER_SCALE", L_Const.GameTplType.float) or 0
    self.mapData:checkResolutionRatio()
    self:setMapScale(self.mapScale)
    self.bind.sliderValue = self.mapScale
  end
  local truetpl = _worldAreaTpl:getTplById(areaId)
  if truetpl then
    local sceneId = _worldAreaTpl:getSceneId(truetpl)
    local id = _worldAreaTpl:getId(truetpl)
    local areaData = _areaTpl:getConfig()
    for i, v in ipairs(areaData) do
      if _areaTpl:getWorldAreaId(v) == id and _areaTpl:getSceneId(v) == sceneId then
        self.txtTitle = _areaTpl:getAreaName(v)
        return
      end
    end
    self.txtTitle = _worldAreaTpl:getName(truetpl)
  end
end

function this:setMapPosition(deltaPos)
  if self.bMovingAnim then
    return
  end
  local imgPos = L_Vector3.getAnchored(self.bindComponents.imgMap)
  imgPos.x = imgPos.x + deltaPos.x
  imgPos.y = imgPos.y + deltaPos.y
  imgPos = self.mapData:clampImgPos(imgPos)
  L_Vector3.setAnchored(self.bindComponents.imgMap, imgPos)
  self:refreshAllNodePos()
end

function this:setMapScale(value)
  self.mapData:setSlider(value)
  self.mapBuilder.painter:OnSlider(self.mapData.imgScale)
  self.bind.value_sliderScale = value
  local ratio = self.mapData.maxScale / self.mapData.minScale
  local size = L_Vector3.getSize(self.bindComponents.imgMap)
  local pos = L_GameUtil.spToLpInRectangle(self.bindComponents.imgMap, self.mapData.showSize)
  local offset = pos * (size - self.mapData.imgScale)
  L_Vector3.setSize(self.bindComponents.imgMap.transform, self.mapData.imgScale)
  self:setMapPosition(offset)
  self:refreshMetaBall(self.nodeDic, self.mapData.imgScale, ratio)
end

function this:initAllMapNode(petConfigId, isNight)
  self:initMetaBall()
  self:clearAllNode()
  self.nodeDic = toLuaNodeDic(C_MapManager:getPetCatalogMapNodeDic(self.mapData.sceneId, petConfigId, isNight or false))
  for nodeType, list in pairs(self.nodeDic) do
    for _, v in ipairs(list) do
      v.mapAreaName = self.txtTitle
      if C_MapManager:CheckIsNoMaskNode(nodeType) then
        v:Generate(self.bindComponents.noMaskNode.transform)
      else
        v:Generate(self.bindComponents.entityNode.transform)
      end
      v:AddClick(function()
      end)
    end
  end
  local value = self.mapScale
  local ratio = self.mapData.maxScale / self.mapData.minScale
  self:refreshAllNodeLockState()
  self:refreshAllNodeState()
  self:refreshAllNodePos()
end

function this:getNodeList(nodeType)
  return self.nodeDic[nodeType]
end

function this:clearAllNode()
  if table.isEmpty(self.nodeDic) then
    return
  end
  for nodeType, v in pairs(self.nodeDic) do
    self:clearNode(nodeType)
  end
end

function this:clearAllStaticNode()
  if table.isEmpty(self.areaBlockDic) then
    return
  end
  for _, list in pairs(self.areaBlockDic) do
    for _, v in pairs(list) do
      v:OnDestroy()
    end
  end
  self.areaBlockDic = {
    areaBlock = {},
    miniAreaBlock = {},
    sceneBorderTransfer = {},
    areaMask = {},
    areaBoundary = {}
  }
end

function this:clearNode(nodeType)
  local list = self.nodeDic[nodeType]
  if not table.isEmpty(list) then
    for _, v in ipairs(list) do
      v:OnDestroy()
    end
    self.nodeDic[nodeType] = {}
  end
end

function this:refreshAllNodeLockState(mapType)
  if mapType then
    local transferList = self:getNodeList(mapType)
    for _, v in ipairs(transferList) do
      v:RefreshLockState()
    end
    if mapType == L_MapConst.mapSievingType.transfer then
      for i, node in ipairs(self.areaBlockDic.areaMask) do
        node:RefreshLockState()
      end
    end
  else
    for _, v in pairs(self.nodeDic) do
      for _, node in pairs(v) do
        node:RefreshLockState()
      end
    end
    for i, node in ipairs(self.areaBlockDic.areaMask) do
      node:RefreshLockState()
    end
  end
end

function this:refreshAllNodeState()
  for _, v in pairs(self.nodeDic) do
    for _, node in pairs(v) do
      node:RefreshState(self.mapData)
    end
  end
  for _, list in pairs(self.areaBlockDic) do
    for _, node in pairs(list) do
      node:RefreshState(self.mapData)
    end
  end
end

function this:refreshAllNodePos()
  for _, v in pairs(self.nodeDic) do
    for _, node in pairs(v) do
      node:RefreshPosByMapData(self.mapData)
      node:RefreshState(self.mapData)
    end
  end
  for _, list in pairs(self.areaBlockDic) do
    for _, node in pairs(list) do
      node:RefreshPosByMapData(self.mapData)
      node:RefreshState(self.mapData)
    end
  end
  self:refreshPlayerNodePos()
  self:refreshMetaBall(self.nodeDic, self.mapData.imgScale, self.mapData.maxScale / self.mapData.minScale)
end

function this:refreshPlayerNodePos()
  local mainControl = AzurWorld.playerMgr.myPlayerData:GetPlayerMainControl(false)
  if mainControl == nil then
    self.bindComponents.player.gameObject:ActiveTrans(false)
    return
  end
  if self.mapData.sceneId ~= AzurWorldInstance.CurWorldId then
    self.bindComponents.player.gameObject:ActiveTrans(false)
    return
  end
  self.bindComponents.player.gameObject:ActiveTrans(true)
  local pos = L_PlayerManager:getMainControlEntityPos()
  local rot = L_PlayerManager:getMainControlEntityRot()
  local w2l = self.mapData:worldToLocal(pos)
  L_Vector3.setAnchored(self.bindComponents.player, w2l)
  L_Vector3.setRot(self.bindComponents.playerDir, L_Vector3.getTemp(0, 0, -rot.y + self.mapData.zRot))
  self.bind.selfAngle = L_Vector3.new(0, 0, -rot.y + self.mapData.zRot)
  L_Vector3.setSize(self.bindComponents.playerDir, 1 / self.mapData.imgScale)
  local camTrans = C_CameraManager.mainCamera.transform
  L_Vector3.setRot(self.bindComponents.cameraDir.transform, L_Vector3.getTemp(0, 0, -camTrans.eulerAngles.y + self.mapData.zRot))
end

function this:focusPlayerPos()
  if self.mapData.sceneId ~= AzurWorldInstance.CurWorldId then
    self:initCenterPos()
    return
  end
  L_Vector3.setAnchored(self.bindComponents.imgMap, L_Vector3.zero)
  local w2L = self.mapData:worldToLocal(L_PlayerManager:getMainControlEntityPos())
  local offset = C_Vector3(-w2L.x * self.mapData.imgScale, -w2L.y * self.mapData.imgScale, 0)
  self:setMapPosition(offset)
end

function this:generateMetaBall(vector4Array)
  local lImage = self.bindComponents.img_KiboMetaBall
  local material = lImage.material
  local maxBall = 100
  local _vector4Array = {}
  for _, v in pairs(vector4Array) do
    if maxBall > #_vector4Array then
      table.insert(_vector4Array, v)
    else
      break
    end
  end
  local circleCount = #_vector4Array
  material:SetFloat("_CircleCount", circleCount)
  local finalArray = _vector4Array
  if circleCount == 0 then
    finalArray = {}
    for i = 1, maxBall do
      table.insert(finalArray, C_Vector4(0, 0, 0, 0))
    end
  end
  material:SetVectorArray("_CircleArray", finalArray)
  local currentMat = lImage.material
  lImage.material = nil
  lImage.material = currentMat
end

function this:refreshMetaBall(nodeDic, value, ratio)
  local metaBallArray = {}
  local hasKiboHabitat = false
  local resolutionX = math.floor(C_CameraManager.mainCamera.pixelWidth * C_UniversalRenderPipeline.renderScale + 0.5)
  local resolutionY = math.floor(C_CameraManager.mainCamera.pixelHeight * C_UniversalRenderPipeline.renderScale + 0.5)
  for nodeType, list in pairs(nodeDic) do
    if nodeType == L_MapConst.mapSievingType.kiboHabitat then
      for _, node in pairs(list) do
        local _value = value
        node:RefreshProbabilityVal(_value)
        local size = 200 * ratio
        size = size / 150 * L_GameConstTpl:getData("PET_HABITAT_RANGE", L_Const.GameTplType.int)
        local position = node:GetPosition()
        if position ~= nil then
          hasKiboHabitat = true
          local screenPoint = C_CameraManager.uiCamera:WorldToScreenPoint(position)
          local realResolutionPoint = C_Vector2(math.floor(screenPoint.x * C_UniversalRenderPipeline.renderScale + 0.5), math.floor(screenPoint.y * C_UniversalRenderPipeline.renderScale + 0.5))
          local x = realResolutionPoint.x / resolutionX * 10
          local y = realResolutionPoint.y / resolutionY * 10
          size = size / 2 / (1350 * C_UniversalRenderPipeline.renderScale) * 10
          size = size * _value * _value
          table.insert(metaBallArray, C_Vector4(x, y, size, 0))
        end
      end
    end
  end
  if hasKiboHabitat then
    table.sort(metaBallArray, function(a, b)
      return (a.x - 5) * (a.x - 5) + (a.y - 5) * (a.y - 5) < (b.x - 5) * (b.x - 5) + (b.y - 5) * (b.y - 5)
    end)
    self:generateMetaBall(metaBallArray)
  end
end

function this:initMetaBall()
  self:generateMetaBall({})
end

function this:onEvent_refreshMapNodeGenerated()
end

function this:refreshNodeTraceState()
  for _, v in pairs(self.nodeDic) do
    for _, node in pairs(v) do
      node:RefreshNodeTraceState()
    end
  end
end

function this:initCenterPos()
  self.bindComponents.imgMap.anchoredPosition = C_Vector2(0, 0)
end

function this:configTouch(operator)
  self.onUIDragStartHandle = self.onUIDragStartHandle or L_CommonUtil.handle(self.onUI_dragStartHandle, self)
  self.onUIDragHandle = self.onUIDragHandle or L_CommonUtil.handle(self.onUI_dragHandle, self)
  self.onUIDragEndHandle = self.onUIDragEndHandle or L_CommonUtil.handle(self.onUI_dragEndHandle, self)
  self.onClickHandle = self.onClickHandle or L_CommonUtil.handle(self.on_clickHandle, self)
  C_ScreenTouch.OnUI_DragStart(operator, self.onUIDragStartHandle)
  C_ScreenTouch.OnUI_Drag(operator, self.onUIDragHandle)
  C_ScreenTouch.OnUI_DragEnd(operator, self.onUIDragEndHandle)
  C_ScreenTouch.OnUI_Click(operator, self.onClickHandle)
end

function this:onUI_dragStartHandle(gesture)
  if not L_CommonUtil.isValid(gesture.go) then
    return
  end
  if gesture.go ~= self.bindComponents.imgMap.gameObject and gesture.go:GetComponent(typeof(C_LMaskImage)) == nil then
    self.isDragInMapPos = false
    return
  end
  self.isDragInMapPos = true
end

function this:onUI_dragHandle(gesture)
  if not L_CommonUtil.isValid(gesture.go) then
    return
  end
  if gesture.go ~= self.bindComponents.imgMap.gameObject and gesture.go:GetComponent(typeof(C_LMaskImage)) == nil then
    if self.dragClickPos ~= nil then
      self.dragClickPos = nil
    end
    self.isDragInMapPos = false
    return
  end
  if self.isDragInMapPos ~= true then
    return
  end
  local pos = gesture.deltaPosition
  self:setMapPosition(pos)
  self:checkSelfPointIsOutScreen()
end

function this:onUI_dragEndHandle(gesture)
  if not L_CommonUtil.isValid(gesture.go) then
    return
  end
  if gesture.go ~= self.bindComponents.imgMap.gameObject and gesture.go:GetComponent(typeof(C_LMaskImage)) == nil then
    return
  end
end

function this:on_clickHandle(gesture)
  if gesture.go ~= self.bindComponents.imgMap.gameObject then
    return
  end
end

function this:onUI_pinchIn(gesture)
  self:refreshAllNodePos()
end

function this:onUI_pinchOut(gesture)
  self:refreshAllNodePos()
end

function this:onUI_pinch(gesture)
  self:refreshAllNodePos()
end

return this
