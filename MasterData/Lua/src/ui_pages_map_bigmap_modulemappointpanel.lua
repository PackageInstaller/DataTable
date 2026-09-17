local this = class("moduleMapPointPanel", G_UIModuleBase)
local _mapNodeTpl = L_GameTpl:getMapNodeTpl()
local _worldAreaTpl = L_GameTpl:getWorldAreaTpl()

function this:ctor(...)
  this.super.ctor(self, ...)
end

function this.bind()
  return {
    note = L_WordsTpl:getValue("ui_signPiont"),
    count = "",
    input = "",
    sureBtn = true,
    group = false,
    bTraceBtnActive = false,
    bUnTraceBtnActive = false,
    txtLittleWindowTitle = "",
    cellMarkItem = {
      moduleName = "pages/Map/BigMap/cellMarkItem"
    }
  }
end

function this.methods()
  return {
    onClick_input = function(self, value)
      local systemId = L_SystemConst.enum.renameMapMark
      local notes = self._info and self._info.notes or L_WordsTpl:getValue("ui_signPiont")
      if value ~= notes and L_SystemBreakManager:checkBanSystemAndTip(systemId) then
        self.bind.input = notes
        return
      end
      self.notes = value
    end,
    onClick_closePanel = function(self)
      self:closeMarkPanel()
    end,
    onclick_bgEmpty = function(self)
      self:closeMarkPanel()
    end,
    onClick_sure = function(self)
      if not self.markId or self.markId <= 0 then
        return
      end
      L_MapManager:setEnableMark(false)
      self:refreshPoint(self.curGuid or 0, self.markId, self.markPos, function()
        self.parent:activeDetailPanel(false)
      end)
      L_AudioUtil.playSound("Play_SFX_System_UI_Map_Mark_Drop")
    end,
    onClick_createAndTrace = function(self)
      if not self.markId or self.markId <= 0 then
        return
      end
      L_MapManager:setEnableMark(false)
      self:refreshPoint(self.curGuid or 0, self.markId, self.markPos, function(rspData)
        self:judgeTraceLogic(rspData)
        self.parent:activeDetailPanel(false)
      end)
      L_AudioUtil.playSound("Play_SFX_System_UI_Map_Mark_Drop")
    end,
    onclick_delete = function(self)
      L_MapStore:req_worldMapMarkDel(self.curGuid, self.mapId, function()
        self.curGuid = nil
        self.parent:activeDetailPanel(false)
        L_AudioUtil.playSound("Play_SFX_System_UI_Map_Mark_Delete")
      end)
    end,
    onclick_trace = function(self)
      self:judgeTraceLogic()
    end,
    onclick_untrace = function(self)
      L_MapStore:req_worldMapMarkTraceDel(self.curGuid)
    end,
    onClick_batchDelete = function(self)
      self.parent:openBatchDelete(self.gameObject.transform.parent)
    end,
    onValueChanged_input = function(self, value)
      value = CS.Lens.Framework.UI.LTextMeshProUtilty.UnicodeWhiteFilter(value)
      self.bind.input = value
    end,
    cellMarkItem = {
      onClick_choose = function(self, id)
        for i = 1, #self.bind.cellMarkItem do
          self:refreshChooseMark(id)
        end
        self.parent:refreshMarkIconClient(id)
      end
    }
  }
end

function this:initModule(areaId, module)
  self.mapId = areaId
  self.curModule = module
  L_MapStore:listenCallFunc(L_MapStore.event.refreshTracing, self.refreshTracing, self)
end

function this:close()
  self:closeCheckPoint()
  L_MapStore:unListenCallFunc(L_MapStore.event.refreshTracing, self.refreshTracing)
end

function this:refreshModule(module)
  self.curModule = module
end

function this:setMark(pos, worldPos)
  self.worldPos = worldPos
  self.markPos = pos
  self.notes = L_WordsTpl:getValue("ui_signPiont")
end

function this:setMarkPanelPos(bNew, guid, markId, bDiffMap)
  self.curGuid = guid or 0
  self.markId = markId or nil
  self.initMarkId = markId or nil
  self:initMarkPanel(bNew, guid)
  self.bDiffMap = bDiffMap
end

function this:initMarkPanel(bNew, guid)
  self.bind.markPanel = true
  self.bind.sureBtn = bNew
  self.bind.group = not bNew
  self.bind.txtLittleWindowTitle = bNew and L_WordsTpl:getValue("ui_moduleMapPointPanel_02") or L_WordsTpl:getValue("ui_moduleMapPointPanel_03")
  self.bNew = bNew
  if not bNew and guid then
    local info = L_MapStore:getMarkBymapInfo(self.mapId, guid)
    self._info = info
    self.bind.input = info and info.notes or ""
    self.bind.note = info and info.notes or L_WordsTpl:getValue("ui_signPiont")
    self.markPos = info.pos
    self.worldPos = {
      x = info.pos_x,
      y = info.pos_y,
      z = info.pos_z
    }
    self.markId = info.markId
    self:refreshTracing()
  else
    local systemId = L_SystemConst.enum.renameMapMark
    if C_IntegrateMgr.SystemUnlockModule:getSystemIsBan(systemId) then
      self.bind.input = L_WordsTpl:getValue("ui_signPiont")
    else
      self.bind.input = ""
    end
    self.bind.note = L_WordsTpl:getValue("ui_signPiont")
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
      local icon = _mapNodeTpl:getIconBig(v)
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
  if math.isEmpty(self.markId) then
    self.markId = temp[1].id
    self:refreshChooseMark(temp[1].id)
  end
end

function this:refreshChooseMark(id)
  for i = 1, #self.bind.cellMarkItem do
    if self.bind.cellMarkItem:getValue(i, "id") == id then
      self.markId = id
      self.parent:refreshMarkIconClient(id)
      self.bind.cellMarkItem:change(i, {mask = true})
    else
      self.bind.cellMarkItem:change(i, {mask = false})
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
  if not self.notes or self.notes == "" then
    self.notes = L_WordsTpl:getValue("ui_signPiont")
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
    pos_z = self.worldPos.z,
    is_set_pos_y = not self.bDiffMap
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

function this:closeMarkPanel()
  if self.bNew then
    self.parent:closePointPanel()
    self.parent:activeDetailPanel(false)
  else
    if not self.curGuid then
      return
    end
    local markId
    if not self.markId or self.markId <= 0 then
      markId = nil
    else
      markId = self.markId
    end
    self:refreshPoint(self.curGuid, self.markId, self.markPos, function()
      self.parent:activeDetailPanel(false)
    end)
  end
end

function this:revertChange()
  if not self.bNew and not math.isEmpty(self.markId) and self.markId ~= self.initMarkId then
    self.markId = self.initMarkId
    self:refreshChooseMark(self.initMarkId)
  end
end

function this:closeCheckPoint()
  if math.isEmpty(self.curGuid) or self.bNew then
    return
  end
  if not math.isEmpty(self.markId) and self.markId ~= self.initMarkId then
    self:refreshPoint(self.curGuid, self.markId, self.markPos)
  end
end

function this:judgeTraceLogic(rspData)
  local sceneId = _worldAreaTpl:getSceneId(_worldAreaTpl:getTplById(self.mapId))
  local transferNodeList = L_MapManager:getAllTransferNode(sceneId)
  local nearestNode
  if table.isEmpty(transferNodeList) then
    local nodeList = L_MapManager:getAllNpcNode(sceneId)
    for i, v in pairs(nodeList) do
      if v.type == L_MapConst.mapSievingType.transfer then
        table.insert(transferNodeList, v)
      end
    end
  end
  if not table.isEmpty(rspData) then
    self.mapId = rspData.map_id
    self.curGuid = rspData.guid
  end
  local node = L_MapStore:getMarkBymapInfo(self.mapId, self.curGuid)
  local nodePos = L_Vector3.new(node.pos_x, node.pos_y, node.pos_z)
  for i, v in pairs(transferNodeList) do
    if nearestNode == nil then
      nearestNode = v
    else
      local distance1 = L_Vector3.distance(v.configPos, nodePos)
      local distance2 = L_Vector3.distance(nearestNode.configPos, nodePos)
      if distance1 < distance2 then
        nearestNode = v
      end
    end
  end
  local hasNearestNode = not table.isEmpty(nearestNode) and true or false
  local sceneId = _worldAreaTpl:getSceneId(_worldAreaTpl:getTplById(self.mapId))
  if sceneId ~= AzurWorldInstance.CurWorldId and hasNearestNode then
    local content = L_WordsTpl:getValue("notice_moduleMapPointPanel_01")
    local data = {
      txtContent = content,
      confirmCallback = function()
        L_SceneStore:transferToPoint(sceneId, nearestNode.id, C_LoginManager.lineId)
        self.parent:close()
      end
    }
    L_GameUtil.showCommonTip(data)
  end
  L_MapStore:req_worldMapMarkTracePointSet(self.curGuid)
end

return this
