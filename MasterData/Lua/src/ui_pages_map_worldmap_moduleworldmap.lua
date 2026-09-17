local this = class("moduleWorldMap", G_UIModuleBase)
local areaTpl = L_GameTpl:getAreaTpl()
local domainTpl = L_GameTpl:getDomainTpl()
local worldAreaTpl = L_GameTpl:getWorldAreaTpl()
local _taskTpl = L_GameTpl:getTaskTpl()

local function refreshStackTopState()
  local stack = C_UIMgr.GetGroup(CS.Azur.Gameplay.EUIGroup.Stack)
  if stack then
    stack:OnTopUIChange()
  end
end

function this:ctor(...)
  this.super.ctor(self, ...)
  self.data = {
    curSelectAreaId = nil,
    lastSelectAreaItem = nil,
    offsetBorder = 195
  }
end

function this.bind()
  return {
    go_areaList = false,
    go_btnAreaList = true,
    list_domain = {
      moduleName = "pages/map/worldMap/cellWorldDomainItem"
    },
    scrollList_area = {
      moduleName = "pages/map/worldMap/cellWorldAreaItem"
    }
  }
end

function this.methods()
  return {
    list_domain = {
      onClick_selectDomain = function(self, config)
        self.bindComponents.aniPage:Play("anim_AreaMap_ToBig")
        L_TimerManager:newOrResetTimer(self, "toBigAni", function()
          C_UIMgr.ForbidCutinOnce()
          L_UI:open("pageBigMap", {
            areaId = config.worldAreaId,
            ani = "anim_bigmap_in",
            mode = "replaceSwiftly",
            openCallback = refreshStackTopState
          })
        end, 0.3)
        local areaId = areaTpl:getAreaId(config)
        local bRed = L_ReddotStore:hasDot(L_ReddotStore.serverDotDef.AreaNew, areaId) == 0
        if bRed then
          L_ReddotStore:req_CSRedPointSetReq(L_ReddotStore.serverDotDef.AreaNew, areaId, true)
        end
      end
    },
    scrollList_area = {
      onClick_selectItem = function(self, bind)
        for k, v in pairs(self.modules.list_domain) do
          if v.bind.config.areaId == bind.config.areaId then
            self:selectNode(v.bindComponents.trans)
            v:setSelect(true)
          else
            v:setSelect(false)
          end
        end
        for k, v in pairs(self.modules.scrollList_area) do
          if v.bind.config.areaId == bind.config.areaId then
            v.bind.go_normal = false
            v.bind.go_active = true
          else
            v.bind.go_normal = true
            v.bind.go_active = false
          end
        end
        local areaId = areaTpl:getAreaId(bind.config)
        local bRed = L_ReddotStore:hasDot(L_ReddotStore.serverDotDef.AreaNew, areaId) == 0
        if bRed then
          L_ReddotStore:req_CSRedPointSetReq(L_ReddotStore.serverDotDef.AreaNew, areaId, true)
        end
      end
    }
  }
end

function this:open(options)
  this.super.open(self, options)
  L_ReddotStore:listenCallFunc(L_ReddotStore.event.reddotUpdate, self.refreshReddotNew, self)
  L_GuideManager:addListener(G_GuideClasses.GuideEvent.RefreshWorldArea, self.onRefreshWorldArea, self)
  self:initPage()
  self:generateUnlockNodeData()
  self:refreshReddotNew()
  self.bindComponents.aniPage:Play("anim_AreaMap_FromBig")
  self:initGamepad()
end

function this:close(options)
  this.super.close(self, options)
  self:destroyTimer()
  L_ReddotStore:unListenCallFunc(L_ReddotStore.event.reddotUpdate, self.refreshReddotNew)
  L_GuideManager:removeListener(G_GuideClasses.GuideEvent.RefreshWorldArea, self.onRefreshWorldArea, self)
  self:clearGamepad()
end

function this:show()
  self:configTouch("+")
end

function this:hide()
  self:configTouch("-")
  self:destroyTimer()
end

function this:destroyTimer()
  if self.timer ~= nil then
    Timer.remove(self.timer)
    self.timer = nil
  end
end

function this:initPage()
  self:initAreaScrollList()
  self:initDomainList()
  self:setMiddlePoint()
end

function this:initAreaScrollList()
  local tempData = {}
  local data = areaTpl:getConfig()
  for k, v in pairs(data) do
    local bShow = false
    local conds = areaTpl:getUnlockCondition(v)
    if conds then
      local complete = L_ConditionManager:isComplete(conds)
      bShow = complete
    else
      bShow = true
    end
    if bShow then
      local icon = areaTpl:getIcon(v)
      local name = areaTpl:getAreaName(v)
      table.insert(tempData, {
        config = v,
        go_active = false,
        go_normal = true,
        go_lock = false,
        txt_name_active = name,
        txt_name_normal = name,
        txt_name_lock = name
      })
    end
  end
  self.bind.scrollList_area:clear()
  self.bind.scrollList_area:insert_array(tempData)
end

function this:refreshWorldList(bind)
  for k, v in pairs(self.modules.list_domain) do
    if v.bind.config.areaId == bind.config.areaId then
      self:selectNode(v.bindComponents.trans)
      v:setSelect(true)
    else
      v:setSelect(false)
    end
  end
  local areaId = areaTpl:getAreaId(bind.config)
  local bRed = L_ReddotStore:hasDot(L_ReddotStore.serverDotDef.AreaNew, areaId) == 0
  if bRed then
    L_ReddotStore:req_CSRedPointSetReq(L_ReddotStore.serverDotDef.AreaNew, areaId, true)
  end
end

function this:initDomainList()
  self.bind.list_domain:clear()
  local tempData = {}
  local curSceneId = AzurWorldInstance.CurWorldId
  local data = areaTpl:getConfig()
  for k, v in pairs(data) do
    local icon = areaTpl:getIcon(v)
    local name = areaTpl:getAreaName(v)
    local sceneId = areaTpl:getSceneId(v)
    local canShowPlayer = false
    if not math.isEmpty(curSceneId) and sceneId == curSceneId then
      canShowPlayer = true
    end
    local taskLocationList = {}
    local allInfors = AzurWorld.TaskMgr:GetTaskTraceInfosBySceneId(sceneId, true)
    if allInfors.Count > 0 then
      local taskId = allInfors[0].TaskId
      for i = 0, allInfors.Count - 1 do
        local tpl = _taskTpl:getTplById(allInfors[i].TaskId)
        if tpl and _taskTpl:getType(tpl) == L_Const.taskType.main then
          taskId = allInfors[i].TaskId
          break
        end
      end
      table.insert(taskLocationList, {id = taskId})
    end
    table.insert(tempData, {
      config = v,
      txt_name = name,
      img_icon = icon,
      taskLocation = taskLocationList,
      playerPos = canShowPlayer,
      localPosition_position = Unity.Vector3(areaTpl:getCoordinate(v)[1], areaTpl:getCoordinate(v)[2], 0)
    })
  end
  self.bind.list_domain:insert_array(tempData)
end

function this:configTouch(operator)
  self.onUIDragStartHandle = self.onUIDragStartHandle or L_CommonUtil.handle(self.onUI_dragStartHandle, self)
  self.onUIDragHandle = self.onUIDragHandle or L_CommonUtil.handle(self.onUI_dragHandle, self)
  C_ScreenTouch.OnUI_DragStart(operator, self.onUIDragStartHandle)
  C_ScreenTouch.OnUI_Drag(operator, self.onUIDragHandle)
end

function this:onUI_dragHandle(gesture)
  if gesture:GetCurrentFirstPickedUIElement() ~= self.bindComponents.rectMap.gameObject then
    return
  end
  if not self.isDragInMapPos then
    return
  end
  local deltaPos = gesture.deltaPosition
  self:setMapPosition(deltaPos)
end

function this:onUI_dragStartHandle(gesture)
  if gesture:GetCurrentFirstPickedUIElement() ~= self.bindComponents.rectMap.gameObject then
    self.isDragInMapPos = false
    return
  end
  self.isDragInMapPos = true
end

function this:setMapPosition(deltaPos)
  if self.bMovingAnim then
    return
  end
  self.bindComponents.rectMap.anchoredPosition = self.bindComponents.rectMap.anchoredPosition + deltaPos
  self:clampImgPos()
end

function this:onRefreshWorldArea(data)
  if not data then
    return
  end
  for _, v in pairs(self.modules.list_domain) do
    if v.bind.config.areaId == data.areaId then
      self:selectNode(v.bindComponents.trans, data.callback)
    end
  end
end

function this:clampImgPos()
  if not self.mapClampData then
    local minY = 0
    local minX = 0
    local maxY = 0
    local maxX = 0
    for i, v in ipairs(self.bind.list_domain) do
      local config = self.bind.list_domain:getValue(i, "config")
      local posX = areaTpl:getCoordinate(config)[1]
      local posY = areaTpl:getCoordinate(config)[2]
      if minX >= posX then
        minX = posX
      end
      if maxX <= posX then
        maxX = posX
      end
      if minY >= posY then
        minY = posY
      end
      if maxY <= posY then
        maxY = posY
      end
    end
    self.mapClampData = {
      min_x = 0,
      min_y = 0,
      max_x = 0,
      max_y = 0
    }
    local lengthY = maxY - minY
    local lengthX = maxX - minX
    local point_1 = L_Vector3.new(minX, minY)
    local point_2 = L_Vector3.new(maxX, maxY)
    local middlePoint = L_Vector3.new((point_1.x + point_2.x) / 2, (point_1.y + point_2.y) / 2)
    local absLengthX = lengthX / 2 + self.data.offsetBorder
    local absLengthY = lengthY / 2 + self.data.offsetBorder
    local rectFrameX = self.bindComponents.rectFrame.sizeDelta.x / 2
    local rectFrameY = self.bindComponents.rectFrame.sizeDelta.y / 2
    local rectMapX = self.bindComponents.rectMap.sizeDelta.x / 2
    local rectMapY = self.bindComponents.rectMap.sizeDelta.y / 2
    local egdeX = (self.bindComponents.rectMap.sizeDelta.x - self.bindComponents.rectFrame.sizeDelta.x) / 2
    local egdeY = (self.bindComponents.rectMap.sizeDelta.y - self.bindComponents.rectFrame.sizeDelta.y) / 2
    if absLengthX <= rectFrameX and absLengthY <= rectFrameY and rectMapX >= absLengthX + math.abs(middlePoint.x) and rectMapY >= absLengthY + math.abs(middlePoint.y) then
      local x = egdeX <= math.abs(middlePoint.x) and egdeX or middlePoint.x
      local y = egdeY <= math.abs(middlePoint.y) and egdeY or middlePoint.y
      self.mapClampData = {
        min_x = -x,
        min_y = -y,
        max_x = -x,
        max_y = -y
      }
    elseif absLengthX > rectFrameX or absLengthY > rectFrameY then
      self.bindComponents.rectMap.anchoredPosition = L_Vector3.new(-middlePoint.x, -middlePoint.y)
      local x = 0
      local y = 0
      if absLengthX > rectFrameX and absLengthX <= rectMapX then
        x = absLengthX - rectFrameX
        self.mapClampData.max_x = egdeX <= math.abs(x + middlePoint.x) and egdeX or x + middlePoint.x
        self.mapClampData.min_x = egdeX <= math.abs(-x + middlePoint.x) and -egdeX or -x + middlePoint.x
      else
        x = egdeX <= math.abs(middlePoint.x) and egdeX or middlePoint.x
        self.mapClampData.max_x = -x
        self.mapClampData.min_x = -x
      end
      if absLengthY > rectFrameY and absLengthY <= rectMapY then
        y = absLengthY - rectFrameY
        self.mapClampData.max_y = egdeY <= math.abs(y + middlePoint.y) and egdeY or y + middlePoint.y
        self.mapClampData.min_y = egdeY <= math.abs(-y + middlePoint.y) and -egdeY or -y + middlePoint.y
      else
        y = egdeY <= math.abs(middlePoint.y) and egdeY or middlePoint.y
        self.mapClampData.max_y = -y
        self.mapClampData.min_y = -y
      end
    else
      local clamp = {x = egdeX, y = egdeY}
      self.mapClampData = {
        min_x = -clamp.x,
        min_y = -clamp.y,
        max_x = clamp.x,
        max_y = clamp.y
      }
    end
  end
  local prevPos = self.bindComponents.rectMap.anchoredPosition
  if self.mapClampData.max_x - self.mapClampData.min_x < 1.0E-4 then
    self.reachLeft = true
    self.reachRight = true
  else
    self.reachLeft = 0 < prevPos.x - self.mapClampData.max_x
    self.reachRight = 0 > prevPos.x - self.mapClampData.min_x
  end
  if self.mapClampData.max_y - self.mapClampData.min_y < 1.0E-4 then
    self.reachUp = true
    self.reachDown = true
  else
    self.reachUp = 0 > prevPos.y - self.mapClampData.min_y
    self.reachDown = 0 < prevPos.y - self.mapClampData.max_y
  end
  self.bindComponents.rectMap.anchoredPosition = C_Vector2(math.clamp(prevPos.x, self.mapClampData.min_x, self.mapClampData.max_x), math.clamp(prevPos.y, self.mapClampData.min_y, self.mapClampData.max_y))
  return prevPos.x ~= self.bindComponents.rectMap.anchoredPosition.x, prevPos.y ~= self.bindComponents.rectMap.anchoredPosition.y
end

function this:selectNode(trans, callBack)
  local duration = 0.5
  local interval = 0.01
  local loop = duration / interval
  local counter = 1
  local nodeScreen = C_CameraManager.uiCamera:WorldToScreenPoint(trans.position)
  local startPos = self.bindComponents.rectMap.anchoredPosition
  local endPos = self.bindComponents.rectMap.anchoredPosition + C_Vector2(Unity.Screen.width / 2 - nodeScreen.x, Unity.Screen.height / 2 - nodeScreen.y)
  self.timer = Timer.new(function()
    self.bindComponents.rectMap.anchoredPosition = C_Vector2.Lerp(startPos, endPos, counter / loop)
    counter = counter + 1
    local bXModified, bYModified = self:clampImgPos()
    if bXModified and bYModified then
      self.bMovingAnim = false
      self.timer:destroy()
    else
      self.bMovingAnim = counter <= loop
    end
    if not self.bMovingAnim and callBack then
      callBack()
    end
  end, interval, loop)
  self.timer:start()
end

function this:setMiddlePoint()
  self:clampImgPos()
end

function this:generateUnlockNodeData()
  local lockIdMap = {}
  self.unlockIdMap = {}
  local data = areaTpl:getConfig()
  for i, v in pairs(data) do
    local conds = areaTpl:getUnlockCondition(v)
    if conds and not (#conds <= 0) then
      local areaId = areaTpl:getAreaId(v)
      local complete = L_ConditionManager:isComplete(conds)
      if not complete then
        lockIdMap[areaId] = true
      else
        local bRed = L_ReddotStore:hasDot(L_ReddotStore.serverDotDef.AreaAnim, areaId) == 0
        if bRed then
          L_ReddotStore:req_CSRedPointSetReq(L_ReddotStore.serverDotDef.AreaAnim, areaId, true)
          self.unlockIdMap[areaId] = true
        end
      end
    end
  end
  if C_MapManager:GetMapStore():getUnlockAreaStatus() == false then
    for _, v in pairs(self.modules.list_domain) do
      if self.unlockIdMap[v.bind.config.areaId] or lockIdMap[v.bind.config.areaId] then
        v.bindComponents.trans.gameObject:ActiveTrans(false)
      end
    end
  end
  self:unlockNode()
end

function this:unlockNode()
  if self.unlockIdMap then
    local k, v = next(self.unlockIdMap)
    if k ~= nil then
      for kk, vv in pairs(self.modules.list_domain) do
        if self.unlockIdMap[vv.bind.config.areaId] and k == vv.bind.config.areaId then
          self.unlockIdMap[k] = nil
          self:selectNode(vv.bindComponents.trans, function()
            vv.bindComponents.trans.gameObject:ActiveTrans(true)
            self:unlockNode()
          end)
        end
      end
    end
  end
end

function this:refreshReddotNew()
  for k, v in pairs(self.modules.list_domain) do
    local conds = domainTpl:getUnlockCondition(v.bind.config)
    if conds and 0 < #conds then
      local bRed = L_ReddotStore:hasDot(L_ReddotStore.serverDotDef.AreaNew, v.bind.config.areaId) == 0
      self.bind.list_domain:change(k, {goNew = bRed})
    end
  end
  for k, v in pairs(self.modules.scrollList_area) do
    local conds = domainTpl:getUnlockCondition(v.bind.config)
    if conds and 0 < #conds then
      local bRed = L_ReddotStore:hasDot(L_ReddotStore.serverDotDef.AreaNew, v.bind.config.areaId) == 0
      self.bind.scrollList_area:change(k, {goNew = bRed})
    end
  end
end

function this:playAni(aniName)
  self.bindComponents.aniPage:Play(aniName)
end

function this:initGamepad()
  self.bindComponents.gamepadCursor.gameObject:SetActive(C_InputManager.IsEnableGamePad)
  self.reachLeft = false
  self.reachRight = false
  self.reachUp = false
  self.reachDown = false
  self.screenSize = C_Vector2(C_Screen.width, C_Screen.height)
  self.cursorSize = self.bindComponents.gamepadCursor.rect.size * 0.5
  self:moveCursorToScreenPos(C_Vector2(self.screenSize.x * 0.5, self.screenSize.y * 0.5))
  self.moveHandle = self.moveHandle or L_CommonUtil.handle(self.lStickMove, self)
  C_InputManager.AddAxisListener(L_Const.axisType.eCommonLStickMove, self.moveHandle)
  self.controlSchemeChangeHandle = self.controlSchemeChangeHandle or handler(self, self.onControlSchemeChange)
  C_ExternalManager.AddEvent(C_EExternalEventType.ControlSchemeChange, self.controlSchemeChangeHandle)
  L_ShortCutManager:registerShortCut(self.parent.pageName, C_InputManager_KeyType.ESubmit, function()
    local scrPos = C_CameraManager.uiCamera:WorldToScreenPoint(self.bindComponents.gamepadCursor.position)
    local pos = C_Vector2(scrPos.x, scrPos.y)
    C_ScreenTouch.SimulateTouch(pos)
    L_TimerManager:newOrResetTimer(self, "SimulateClick", function()
      C_GamepadUtility.SimulateClick(pos)
    end, 0)
  end)
end

function this:clearGamepad()
  C_InputManager.RemoveAxisListener(L_Const.axisType.eCommonLStickMove, self.moveHandle)
  C_ExternalManager.RemoveEvent(C_EExternalEventType.ControlSchemeChange, self.controlSchemeChangeHandle)
  L_ShortCutManager:removeShortCut(self.parent.pageName)
end

function this:lStickMove(v2)
  self._gamepadMove = v2
end

function this:moveCursorToScreenPos(v2)
  local _, anchorPos = C_RectTransformUtility.ScreenPointToLocalPointInRectangle(self.bindComponents.gamepadCursor.parent, C_Vector2(v2.x, v2.y), C_CameraManager.uiCamera)
  self.bindComponents.gamepadCursor.anchoredPosition = anchorPos
end

function this:isAnyDirectionReached()
  return self.reachUp or self.reachDown or self.reachLeft or self.reachRight
end

function this:onControlSchemeChange()
  self.bindComponents.gamepadCursor.gameObject:SetActive(C_InputManager.IsEnableGamePad)
end

function this:update()
  if self._gamepadMove == nil then
    return
  end
  local v2 = self._gamepadMove
  local sqrMag = v2.x * v2.x + v2.y * v2.y
  if sqrMag < 1.0E-4 then
    return
  end
  if self.bMovingAnim then
    return
  end
  local deltaTime = C_Time.deltaTime
  local moveRatio = 1000
  local scrPos = C_CameraManager.uiCamera:WorldToScreenPoint(self.bindComponents.gamepadCursor.position)
  if self:isAnyDirectionReached() then
    local cursorMove = v2 * (deltaTime * moveRatio)
    local cursorPos = self.bindComponents.gamepadCursor.anchoredPosition
    cursorPos = cursorPos + cursorMove
    self.bindComponents.gamepadCursor.anchoredPosition = cursorPos
    scrPos = C_CameraManager.uiCamera:WorldToScreenPoint(self.bindComponents.gamepadCursor.position)
    if self.reachLeft and self.reachRight then
      scrPos.x = math.clamp(scrPos.x, self.cursorSize.x, self.screenSize.x - self.cursorSize.x)
    elseif self.reachRight then
      scrPos.x = math.clamp(scrPos.x, self.screenSize.x * 0.5, self.screenSize.x - self.cursorSize.x)
    elseif self.reachLeft then
      scrPos.x = math.clamp(scrPos.x, self.cursorSize.x, self.screenSize.x * 0.5)
    else
      scrPos.x = self.screenSize.x * 0.5
    end
    if self.reachUp and self.reachDown then
      scrPos.y = math.clamp(scrPos.y, self.cursorSize.y, self.screenSize.y - self.cursorSize.y)
    elseif self.reachUp then
      scrPos.y = math.clamp(scrPos.y, self.screenSize.y * 0.5, self.screenSize.y - self.cursorSize.y)
    elseif self.reachDown then
      scrPos.y = math.clamp(scrPos.y, self.cursorSize.y, self.screenSize.y * 0.5)
    else
      scrPos.y = self.screenSize.y * 0.5
    end
    self:moveCursorToScreenPos(C_Vector2(scrPos.x, scrPos.y))
  else
    self.bindComponents.gamepadCursor.anchoredPosition = C_Vector2.zero
  end
  self:updateBottomInfo(C_Vector2(scrPos.x, scrPos.y))
  if 1.0E-4 > math.abs(scrPos.x - self.screenSize.x * 0.5) or 1.0E-4 > math.abs(scrPos.y - self.screenSize.y * 0.5) then
    local mapMove = -v2 * (deltaTime * moveRatio)
    self:setMapPosition(mapMove)
  end
end

function this:updateBottomInfo(scrPos)
  local curObj = C_GamepadUtility.GetUIGameObjectAtPoint(scrPos, self.parent.gameObject)
  if curObj ~= nil and self._curObj ~= curObj then
    local grpName = "GroupNormal"
    if curObj:TryGetComponent(typeof(C_LButton)) then
      grpName = "GroupSelect"
    end
    local args = CS.Lens.Gameplay.UI.BottomGamepadCutsEventArgs()
    args.isLuaEvent = true
    args.luaTable = {
      moduleOrPageName = "moduleWorldMap",
      changeGroupName = grpName
    }
    C_ExternalManager.DispatchEvent(C_EExternalEventType.BottomGamepadCutsGroupChange, args)
  end
  self._curObj = curObj
end

return this
