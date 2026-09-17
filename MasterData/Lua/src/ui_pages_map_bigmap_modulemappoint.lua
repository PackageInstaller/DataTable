local this = class("moduleMapPoint", G_UIModuleBase)
local _mapNodeTpl = L_GameTpl:getMapNodeTpl()
local _worldAreaTpl = L_GameTpl:getWorldAreaTpl()
local _worldFilter = L_GameTpl:getWorldFilterTpl()

function this:ctor(...)
  this.super.ctor(self, ...)
end

function this.bind()
  return {
    objPanel = true,
    markPanel = false,
    markPanelRectLocalPos = C_Vector3(0, 0, 0),
    markPanelScale = C_Vector3(1, 1, 1),
    count = "",
    input = "",
    sureBtn = true,
    group = false,
    bTraceBtnActive = false,
    bUnTraceBtnActive = false,
    txtLittleWindowTitle = "",
    cellPointItem = {
      moduleName = "pages/Map/BigMap/cellPointItem"
    },
    cellMarkItem = {
      moduleName = "pages/Map/BigMap/cellMarkItem"
    }
  }
end

function this.methods()
  return {
    onClick_input = function(self, value)
      self.notes = value
    end,
    onClick_closePanel = function(self)
    end,
    onclick_bgEmpty = function(self)
    end,
    onClick_sure = function(self)
      if not self.markId or self.markId <= 0 then
        return
      end
      self:refreshPoint(self.curGuid or 0, self.markId, self.markPos, function()
        self.bind.markPanel = false
      end)
    end,
    onclick_delete = function(self)
      L_MapStore:req_worldMapMarkDel(self.curGuid, self.mapId, function()
        L_AudioUtil.playSound("Play_SFX_System_UI_Map_Mark_Delete")
      end)
    end,
    onclick_trace = function(self)
      self:judgeTraceLogic()
    end,
    onclick_untrace = function(self)
      L_MapStore:req_worldMapMarkTraceDel(self.curGuid)
    end,
    cellPointItem = {
      onClick_sure = function(self, bind)
        local info = L_MapStore:getNavPointInfo(self.mapId)
        self:refreshPoint(info.guid, info.markId, self.markPos)
      end,
      onClick_cancel = function(self, bind)
        self:initMarkPoint(false)
      end,
      onClick_deleted = function(self, bind)
        L_MapStore:req_worldMapMarkDel(bind.guid, self.mapId, function()
          L_AudioUtil.playSound("Play_SFX_System_UI_Map_Mark_Delete")
        end)
      end,
      onClick_point = function(self, guid, id, pos)
        self:refreshChoosePoint(guid, id)
        L_AudioUtil.playSound("Play_SFX_System_UI_Map_Mark_Click")
      end,
      onClick_trace = function(self, bind)
        L_MapStore:req_worldMapMarkTracePointSet(bind.guid)
        self:initMarkPoint(false)
      end
    }
  }
end

function this:initModule(areaId, windowLd, windowRu, scale, mapData)
  self.mapId = areaId
  self.rectSafeLd = windowLd
  self.rectSafeRu = windowRu
  self.curModule = L_Const.bigMapModule.freedom
  L_MapStore:listenCallFunc(L_MapStore.event.setMapMark, self.initMarkPoint, self)
  L_MapStore:listenCallFunc(L_MapStore.event.refreshTracing, self.refreshTracing, self)
  if self.markTimer then
    Timer.remove(self.markTimer)
  end
  self.objPanelShow = true
  self.markTimer = Timer.once(0.4, self.initMarkPoint, self)
  self.parentScale = scale
  self.mapData = mapData
end

function this:getCurGuid()
  return self.curGuid
end

function this:close()
  L_MapStore:unListenCallFunc(L_MapStore.event.setMapMark, self.initMarkPoint)
  L_MapStore:unListenCallFunc(L_MapStore.event.refreshTracing, self.refreshTracing)
  self.objPanelShow = false
  self.bind.cellPointItem:clear()
  if self.markTimer then
    Timer.remove(self.markTimer)
  end
end

function this:refreshModule(module)
  self.curModule = module
end

function this:initMarkPoint(isNew, guid, isAllSync)
  local temp = {}
  local tempData = L_MapStore:getMarkBymapId(self.mapId)
  local listCellPointItem = self.bind.cellPointItem
  if not table.isEmpty(tempData) then
    local idx = 1
    for i, v in pairs(tempData) do
      local mapNodeTpl = _mapNodeTpl:getTplById(v.markId)
      local icon = _mapNodeTpl:getIcon(mapNodeTpl)
      local objActive = not self.mapData:getFilter()[13 + v.markId / 10]
      local pt = {
        obj = objActive,
        bg = false,
        ringBg = true,
        icon = icon,
        id = v.markId,
        guid = v.guid,
        pos = v.pos,
        notes = v.notes or "",
        sureGroup = false,
        deletedGroup = false,
        rectSafeLd = self.rectSafeLd,
        rectSafeRu = self.rectSafeRu,
        scale = C_Vector3(self.parentScale, self.parentScale, self.parentScale) or C_Vector3.one,
        bAnim = false,
        raycast = self.objPanelShow,
        bNew = isNew and guid == v.guid and true or false
      }
      if isAllSync then
        local item = listCellPointItem:getItemCls(idx)
        if item.bind.bg then
          pt.bg = true
        end
      end
      idx = idx + 1
      table.insert(temp, pt)
    end
  end
  listCellPointItem:clear()
  listCellPointItem:insert_array(temp)
end

function this:initMarkPointWithoutNavPoint()
  self.bind.markPanel = false
  local temp = {}
  if self.markId ~= L_Const.mapNavPointId and not math.isEmpty(self.markId) then
    local mapNodeTpl = _mapNodeTpl:getTplById(self.markId)
    local icon = _mapNodeTpl:getIcon(mapNodeTpl)
    local objActive = not self.mapData:getFilter()[13 + self.markId / 10]
    table.insert(temp, {
      obj = objActive,
      bg = true,
      ringBg = false,
      icon = icon,
      id = self.markId,
      guid = self.curGuid or 0,
      pos = C_Vector3(self.markPos.x, self.markPos.y, 0),
      sureGroup = false,
      notes = "",
      deletedGroup = false,
      rectSafeLd = self.rectSafeLd,
      rectSafeRu = self.rectSafeRu,
      raycast = self.objPanelShow,
      scale = C_Vector3(self.parentScale, self.parentScale, self.parentScale) or C_Vector3.one,
      bAnim = true
    })
  end
  self.bind.cellPointItem:insert_array(temp)
end

function this:setMark(pos, worldPos, bDiffMap)
  self:refreshChoosePoint()
  self.worldPos = worldPos
  if self.curModule == L_Const.bigMapModule.navigation then
    local navPointInfo = L_MapStore:getNavPointInfo(self.mapId)
    if navPointInfo then
      local mapNodeTpl = _mapNodeTpl:getTplById(L_Const.mapNavPointId)
      local icon = _mapNodeTpl:getIcon(mapNodeTpl)
      local temp = {
        obj = true,
        bg = false,
        icon = icon,
        id = L_Const.mapNavPointId,
        guid = -1,
        pos = C_Vector3(pos.x, pos.y, 0),
        sureGroup = true,
        deletedGroup = false,
        rectSafeLd = self.rectSafeLd,
        rectSafeRu = self.rectSafeRu,
        raycast = self.objPanelShow,
        scale = C_Vector3(self.parentScale, self.parentScale, self.parentScale) or C_Vector3.one,
        bAnim = true
      }
      self.bind.cellPointItem:insert(temp)
      self.markPos = pos
    else
      self:refreshPoint(0, L_Const.mapNavPointId, pos)
    end
  else
    self.markPos = pos
    self.notes = L_WordsTpl:getValue("ui_signPiont")
    self.curGuid = 0
    local posInfo = {markPos = pos, worldPos = worldPos}
    self.parent:setMarkPanelPos(true, 0, 0, posInfo)
    self:initMarkPointWithoutNavPoint()
  end
end

function this:setMarkPanelPos(pos, bNew, guid)
end

function this:initMarkPanel(bNew, guid)
  self.bind.markPanel = true
  self.bind.sureBtn = bNew
  self.bind.group = not bNew
  self.bind.txtLittleWindowTitle = bNew and L_WordsTpl:getValue("ui_moduleMapPointPanel_02") or L_WordsTpl:getValue("ui_moduleMapPointPanel_03")
  self.bNew = bNew
  if not bNew and guid then
    local info = L_MapStore:getMarkBymapInfo(self.mapId, guid)
    self.bind.input = info and info.notes or ""
    self.markPos = info.pos
    self.worldPos = {
      x = info.pos_x,
      y = info.pos_y,
      z = info.pos_z
    }
    self.markId = info.markId
    self:refreshTracing()
  else
    self.bind.input = ""
  end
  if not table.isEmpty(L_MapStore:getMarkBymapId(self.mapId)) then
    self.bind.count = string.format("(%s/%s)", table.count(L_MapStore:getMarkBymapId(self.mapId)), L_GameTpl:getGameConstTpl():getData("MAP_MARK_LIMIT", L_Const.GameTplType.int))
  else
    self.bind.count = string.format("(%s/%s)", 0, L_GameTpl:getGameConstTpl():getData("MAP_MARK_LIMIT", L_Const.GameTplType.int))
  end
  local worldMapIcon = _mapNodeTpl:getArray()
  self.bind.cellMarkItem:clear()
  local temp = {}
  for i, v in ipairs(worldMapIcon) do
    local id = _mapNodeTpl:getId(v)
    if id ~= L_Const.mapNavPointId then
      local mask = self.markId == i
      local icon = _mapNodeTpl:getIcon(v)
      table.insert(temp, {
        icon = icon,
        mask = mask,
        id = i
      })
    end
  end
  table.sort(temp, function(a, b)
    return a.id < b.id
  end)
  self.bind.cellMarkItem:insert_array(temp)
end

function this:refreshChoosePoint(guid, markId)
  self.curGuid = guid
  local listCellPointItem = self.bind.cellPointItem
  for i = 1, #listCellPointItem do
    if listCellPointItem:getValue(i, "guid") == guid then
      if listCellPointItem:getValue(i, "id") == L_Const.mapNavPointId then
        listCellPointItem:change(i, {
          bg = true,
          deletedGroup = true,
          bShowTrace = not L_MapStore:getTracing(guid),
          bAnim = false
        })
      elseif markId then
        listCellPointItem:change(i, {
          bg = true,
          deletedGroup = false,
          bAnim = false
        })
        self.markId = markId
        local curPos = listCellPointItem:getItemCls(i):getNodeScreenPos(self.parent:GetMapShowRect())
        local surroundingNodes, curSelfNode = self:checkSurroundingNodes(i, curPos, self.parent:GetMapShowRect())
        self.parent:checkSelfPointSurroundingNodes(curPos, surroundingNodes, curSelfNode)
      else
        listCellPointItem:change(i, {
          bg = true,
          deletedGroup = false,
          bAnim = false
        })
        self.markId = listCellPointItem:getValue(i, "id")
      end
    else
      local bg = listCellPointItem:getValue(i, "bg")
      local bgActive = self.noClearSelection and bg or false
      listCellPointItem:change(i, {bg = bgActive, bAnim = false})
    end
  end
end

function this:setChoosePoint(guid, isSelect)
  local listCellPointItem = self.bind.cellPointItem
  for i = 1, #listCellPointItem do
    if listCellPointItem:getValue(i, "guid") ~= guid or listCellPointItem:getValue(i, "id") == L_Const.mapNavPointId then
    else
      listCellPointItem:change(i, {
        bg = isSelect,
        deletedGroup = false,
        bAnim = false
      })
    end
  end
end

function this:getAreaPoints(sceneId, areaId)
  local isWholeMap = areaId == 0
  local result = {}
  local listCellPointItem = self.bind.cellPointItem
  for i = 1, #listCellPointItem do
    local cell = listCellPointItem:getValue(i)
    local guid = cell.guid
    if cell.id ~= L_Const.mapNavPointId then
      local info = L_MapStore:getMarkBymapInfo(self.mapId, guid)
      local passFilter = false
      if not info then
      elseif isWholeMap then
        passFilter = true
      else
        local areas = AzurWorld.areaManager:QueryAreaId(sceneId, info.pos_x, info.pos_y, info.pos_z)
        local markAreaId = areas
        while true do
          local tpl = markAreaId and _worldAreaTpl:getTplById(markAreaId)
          if tpl and not math.isEmpty(tpl.mainArea) then
            markAreaId = tpl.mainArea
          else
            break
          end
        end
        passFilter = markAreaId == areaId
      end
      if passFilter then
        local t = result[info.markId] or {}
        table.insert(t, info)
        result[info.markId] = t
      end
    end
  end
  return result
end

function this:setNoClearSelection(noClearSelection)
  self.noClearSelection = noClearSelection
end

function this:checkSurroundingNodes(index, pos, parent)
  if math.isEmpty(self.curGuid) then
    return {}, nil
  end
  local curScreenPos = pos
  local surroundingNodes = {}
  local listCellPointItem = self.bind.cellPointItem
  for i = 1, #listCellPointItem do
    if i ~= index then
      local surrNode = listCellPointItem:getItemCls(i)
      local surroundingPos = surrNode:getNodeScreenPos(parent)
      local x = curScreenPos.x - surroundingPos.x
      local y = curScreenPos.y - surroundingPos.y
      local distance = x * x + y * y
      if distance <= 4225 then
        table.insert(surroundingNodes, {
          markId = listCellPointItem:getValue(i, "id"),
          guid = listCellPointItem:getValue(i, "guid"),
          icon = listCellPointItem:getValue(i, "icon"),
          notes = listCellPointItem:getValue(i, "notes"),
          type = L_MapConst.mapSievingType.selfNode
        })
      end
    end
  end
  local curNode = {
    markId = listCellPointItem:getValue(index, "id"),
    guid = listCellPointItem:getValue(index, "guid"),
    icon = listCellPointItem:getValue(index, "icon"),
    notes = listCellPointItem:getValue(index, "notes"),
    type = L_MapConst.mapSievingType.selfNode
  }
  return surroundingNodes, curNode
end

function this:checkStaticNodeRange(pos, parent)
  local curScreenPos = pos
  local surroundingNodes = {}
  local listCellPointItem = self.bind.cellPointItem
  if self.objPanelShow == false then
    return {}
  end
  for i = 1, #listCellPointItem do
    local surroundingPos = listCellPointItem:getItemCls(i):getNodeScreenPos(parent)
    local x = curScreenPos.x - surroundingPos.x
    local y = curScreenPos.y - surroundingPos.y
    local distance = x * x + y * y
    if distance <= 4225 then
      table.insert(surroundingNodes, {
        markId = listCellPointItem:getValue(i, "id"),
        guid = listCellPointItem:getValue(i, "guid"),
        icon = listCellPointItem:getValue(i, "icon"),
        notes = listCellPointItem:getValue(i, "notes"),
        type = L_MapConst.mapSievingType.selfNode
      })
    end
  end
  return surroundingNodes
end

function this:refreshAllPoints()
  local listCellPointItem = self.bind.cellPointItem
  for i = 1, #listCellPointItem do
    listCellPointItem:change(i, {bg = false, bAnim = false})
  end
end

function this:refreshMarkIconClient(id)
  self.markId = id
  local listCellPointItem = self.bind.cellPointItem
  for i = 1, #listCellPointItem do
    if listCellPointItem:getValue(i, "guid") == self.curGuid then
      local mapNodeTpl = _mapNodeTpl:getTplById(id)
      local icon = _mapNodeTpl:getIcon(mapNodeTpl)
      listCellPointItem:change(i, {icon = icon})
      self.modules.cellPointItem[i]:playChangeAnim()
    end
  end
end

function this:refreshPoint(guid, markId, pos, callback)
  local nowCount = table.count(L_MapStore:getMarkBymapId(self.mapId))
  local limit = L_GameTpl:getGameConstTpl():getData("MAP_MARK_LIMIT", L_Const.GameTplType.int)
  if nowCount >= limit then
    local info = L_MapStore:getMarkBymapInfo(self.mapId, guid)
    if not info then
      L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notce_map_mark"))
      return
    end
  end
  if string.widthSingle(self.notes or "") > 20 then
    L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notce_map_1"))
    return
  end
  local strPos = pos and string.format("%s,%s,%s", pos.x, pos.y, 0)
  local data = {
    map_id = self.mapId,
    mark_id = markId,
    pos = strPos,
    notes = self.notes,
    guid = guid,
    pos_x = self.worldPos.x,
    pos_y = self.worldPos.y,
    pos_z = self.worldPos.z
  }
  L_MapStore:req_worldMapMarkAdd(data, callback)
end

function this:refreshTracing()
  if not self.bNew then
    local bTracing = L_MapStore:getTracing(self.curGuid)
    self.bind.bTraceBtnActive = not bTracing
    self.bind.bUnTraceBtnActive = bTracing
  end
end

function this:onMapDrag()
  local listCellPointItem = self.bind.cellPointItem
  for i = 1, #listCellPointItem do
    if listCellPointItem:getValue(i, "id") == L_Const.mapNavPointId then
      local info = L_MapStore:getNavPointInfo(self.mapId)
      listCellPointItem:change(i, {
        pos = info.pos,
        sureGroup = false
      })
    end
  end
end

function this:setScale(mapData)
  local f = 1 / mapData.imgScale
  local tpl = _worldFilter:getTplById(L_MapConst.mapSievingType.selfNode)
  local isShow = true
  if tpl then
    local resizeRange = _worldFilter:getResizingShow(tpl)
    local min = resizeRange[1] / 100
    local max = resizeRange[2] / 100
    local percent = (mapData.imgScale - mapData.minScale) / (mapData.maxScale - mapData.minScale)
    if min <= percent and max >= percent then
      isShow = true
    else
      isShow = false
    end
  end
  self.parentScale = f
  if self.objPanelShow ~= isShow then
    self.bindComponents.anim:Stop()
    if isShow then
      self.bindComponents.anim:Play("anim_tipnode_show")
    else
      self.bindComponents.anim:Play("anim_tipnode_hide")
    end
    self.objPanelShow = isShow
  end
  local listCellPointItem = self.bind.cellPointItem
  for i = 1, #listCellPointItem do
    listCellPointItem:change(i, {
      scale = C_Vector3(f, f, f)
    })
    listCellPointItem:change(i, {raycast = isShow})
  end
end

function this:clearSelfNode()
  local listCellPointItem = self.bind.cellPointItem
  for i = 1, #listCellPointItem do
    local cell = listCellPointItem:getItemCls(i)
    cell:Destroy()
  end
  self.bind.cellPointItem:clear()
end

function this:refreshSelfMarkState(filters, isReverse)
  local listCellPointItem = self.bind.cellPointItem
  for i = 1, #listCellPointItem do
    local markId = listCellPointItem:getValue(i, "id")
    local filterKey = 130 + markId
    local objActive = filters[filterKey]
    if isReverse then
      objActive = not objActive
    end
    listCellPointItem:change(i, {obj = objActive})
  end
end

return this
