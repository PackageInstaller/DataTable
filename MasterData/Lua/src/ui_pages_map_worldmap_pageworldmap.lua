local this = class("pageWorldMap", G_UIPageBase)
local areaTpl = L_GameTpl:getAreaTpl()
local domainTpl = L_GameTpl:getDomainTpl()
local worldAreaTpl = L_GameTpl:getWorldAreaTpl()

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
    go_topBar = true,
    go_btnAreaList = true,
    list_domain = {
      moduleName = "pages/map/worldMap/cellWorldDomainItem"
    },
    scrollList_area = {
      moduleName = "pages/map/worldMap/cellWorldAreaItem"
    },
    moduleCommonTop = {
      moduleName = "modulePages/moduleCommonTop"
    },
    txt_level = ""
  }
end

function this.methods()
  return {
    onClick_openAreaList = function(self)
      self:toggleAreaList(true)
    end,
    onClick_closeAreaList = function(self)
      self:toggleAreaList(false)
    end,
    list_domain = {
      onClick_selectDomain = function(self, config)
        L_UI:open("pageAreaMap", {
          areaId = config.areaId,
          exitName = self.data.exitName,
          mode = "replaceSwiftly"
        })
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
    },
    onClick_world = function()
      L_UI:open("pageWorldLevel")
    end
  }
end

function this:preOpen(options)
  this.super.preOpen(self, options)
  L_ReddotStore:listenCallFunc(L_ReddotStore.event.reddotUpdate, self.refreshReddotNew, self)
  self.data.exitName = options and options.exitName or self.pageName
  self:initPage()
  self:generateUnlockNodeData()
  self:refreshReddotNew()
end

function this:close(options)
  this.super.close(self, options)
  L_ReddotStore:unListenCallFunc(L_ReddotStore.event.reddotUpdate, self.refreshReddotNew)
  self:configTouch("-")
end

function this:toggleAreaList(b)
  if b then
    self.bind.go_areaList = true
    self.bindComponents.aniAreaList:Play("anim_AreaMap_listin")
  else
    self.bindComponents.aniAreaList:Play("anim_AreaMap_listout")
    if self.data.areaListCloseTimer then
      self.data.areaListCloseTimer:stop()
      Timer.remove(self.data.areaListCloseTimer)
      self.data.areaListCloseTimer = nil
    end
    self.data.areaListCloseTimer = Timer.once(0.4, function()
      self.bind.go_areaList = false
      self.data.areaListCloseTimer = nil
    end)
  end
  self.bind.go_topBar = not b
  self.bind.go_btnAreaList = not b
end

function this:initPage()
  local data = {
    name = L_WordsTpl:getValue("notice_pageBigMap_02"),
    helpBtnBool = false,
    mainBtnBool = true,
    closeCurPage = function()
      C_MapManager:SandwichClose(self.pageName, self.data.exitName)
    end,
    mainBtn = function()
      L_UI:backToRoot()
    end
  }
  self.modules.moduleCommonTop:initModule(data)
  self:configTouch("+")
  self:initAreaScrollList()
  self:initDomainList()
  self:setMiddlePoint()
  self:refreshWorldLevel()
end

function this:refreshWorldLevel()
  self.bind.txt_level = tostring(L_WorldLevelStore:getNowLevel())
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

function this:initDomainList()
  self.bind.list_domain:clear()
  local tempData = {}
  local data = areaTpl:getConfig()
  for k, v in pairs(data) do
    local icon = areaTpl:getIcon(v)
    local name = areaTpl:getAreaName(v)
    table.insert(tempData, {
      config = v,
      txt_name = name,
      img_icon = icon,
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

function this:clampImgPos()
  if not self.mapClampData then
    local minY = 0
    local minX = 0
    local maxY = 0
    local maxX = 0
    for i, v in ipairs(self.bind.scrollList_area) do
      local config = self.bind.scrollList_area:getValue(i, "config")
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
  local timer
  timer = Timer.new(function()
    self.bindComponents.rectMap.anchoredPosition = C_Vector2.Lerp(startPos, endPos, counter / loop)
    counter = counter + 1
    local bXModified, bYModified = self:clampImgPos()
    if bXModified and bYModified then
      self.bMovingAnim = false
      timer:destroy()
    else
      self.bMovingAnim = counter <= loop
    end
    if not self.bMovingAnim and callBack then
      callBack()
    end
  end, interval, loop)
  timer.autoDestroy = true
  timer:start()
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
  for _, v in pairs(self.modules.list_domain) do
    if self.unlockIdMap[v.bind.config.areaId] or lockIdMap[v.bind.config.areaId] then
      v.bindComponents.trans.gameObject:ActiveTrans(false)
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

return this
