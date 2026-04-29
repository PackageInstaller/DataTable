_class("UIDataBaseMapController", UIController)
UIDataBaseMapController = UIDataBaseMapController

function UIDataBaseMapController:OnShow(uiParams)
  self._waitAnimNodeList = {}
  self._waitAnimLineList = {}
  self._nodeOffset = {
    [1] = Vector2(-60, 50),
    [2] = Vector2(60, 50),
    [3] = Vector2(160, 0),
    [4] = Vector2(60, -50),
    [5] = Vector2(-60, -50),
    [6] = Vector2(-160, 0)
  }
  self._dir2angle = {
    [1] = -90,
    [2] = 0,
    [3] = 90,
    [4] = 180
  }
  self._module = GameGlobal.GetModule(AircraftModule)
  self._loginModule = GameGlobal.GetModule(LoginModule)
  self:GetComponents()
  self:OnValue()
  self:AddListeners()
end

function UIDataBaseMapController:BackBtn()
  self:CloseDialog()
end

function UIDataBaseMapController:HelpBtn()
  self:ShowDialog("UIHelpController", "UIDataBase")
end

function UIDataBaseMapController:GetComponents()
  self._ltBtn = self:GetUIComponent("UISelectObjectPath", "backBtns")
  self._backBtns = self._ltBtn:SpawnObject("UICommonTopButton")
  self._backBtns:SetData(function()
    self:BackBtn()
  end, nil, nil, true)
  local sop = self:GetUIComponent("UISelectObjectPath", "menu")
  self.currencyMenu = sop:SpawnObject("UICurrencyMenu")
  self._contentRect = self:GetUIComponent("RectTransform", "Content")
  self._scrollRect = self:GetUIComponent("ScrollRect", "scrollView")
  self._scrollTransform = self:GetUIComponent("RectTransform", "scrollView")
end

function UIDataBaseMapController:RefreshItemInfo()
  local cfg_value = Cfg.cfg_aircraft_values[37].StringValue
  local s1 = string.split(cfg_value, "|")
  local topTips = {}
  for i = 1, #s1 do
    local id = tonumber(s1[i])
    table.insert(topTips, id)
  end
  self.currencyMenu:SetData(topTips, true)
end

function UIDataBaseMapController:OnValue()
  self:InitNodeList()
  self:RefreshItemInfo()
end

function UIDataBaseMapController:AddListeners()
  self:AttachEvent(GameEventType.OnDataBaseInfoUnLock, self.__RefreshNodeInfo)
  self:AttachEvent(GameEventType.OnDataBaseInfoGetAward, self.__RefreshNodeInfo)
end

function UIDataBaseMapController:OnHide()
  self:__DisposePool()
end

function UIDataBaseMapController:InitNodeList()
  self:__CreateData()
  self:__GetCfgNode()
  self:__FilterNode()
  self:__FarNode()
  self:__CreatePool()
  self:__CreateLinePool()
  self:__CreateNodeAndLinePrefab()
  self:__InitScrollRect()
end

function UIDataBaseMapController:__CreateData()
end

function UIDataBaseMapController:__GetCfgNode()
  self._cfg_data_base_nodes = Cfg.cfg_tactical_db_theme({})
end

function UIDataBaseMapController:__FilterNode()
  local svrTimeModule = GameGlobal.GetModule(SvrTimeModule)
  local svrTime = svrTimeModule:GetServerTime() * 0.001
  local loginModule = GameGlobal.GetModule(LoginModule)
  self._filterList = {}
  self._openList = {}
  for key, value in pairs(self._cfg_data_base_nodes) do
    local inner = false
    if not value.OpenTime then
      inner = true
    else
      local openTime = loginModule:GetTimeStampByTimeStr(value.OpenTime, Enum_DateTimeZoneType.E_ZoneType_GMT)
      local closeTime = loginModule:GetTimeStampByTimeStr(value.CloseTime, Enum_DateTimeZoneType.E_ZoneType_GMT)
      if svrTime >= openTime and svrTime <= closeTime then
        inner = true
      end
    end
    if inner then
      table.insert(self._filterList, value)
    end
  end
end

function UIDataBaseMapController:__FarNode()
  local farX = 0
  for key, value in pairs(self._filterList) do
    local posX = value.Pos[1]
    if farX < posX then
      farX = posX
    end
  end
  self._nodeWidthHalf = 184
  self._paddingRight = 184
  self._leftRightGap = 28
  local realWidth = ResolutionManager.RealWidth()
  self._screenWidth = realWidth
  local width = farX + self._nodeWidthHalf + self._paddingRight
  self._contentRect.sizeDelta = Vector2(width, self._contentRect.sizeDelta.y)
end

function UIDataBaseMapController:__CreatePool()
  local poolCount = 15
  self._reqList = {}
  local nodeName = "UIDataBaseNode.prefab"
  self._nodePools = UIDataBasePool:New("NODE")
  for i = 1, poolCount do
    local req = ResourceManager:GetInstance():SyncLoadAsset(nodeName, LoadType.GameObject)
    local go = req.Obj
    local tr = go.transform
    tr:SetParent(self._contentRect)
    tr.localScale = Vector3(1, 1, 1)
    tr.localPosition = Vector3(0, 0, 0)
    tr.localRotation = Quaternion.identity
    table.insert(self._reqList, req)
    local nodeLua = UIDataBaseNodeItem:New()
    local view = go:GetComponent("UIView")
    nodeLua:Load(view, self)
    self._nodePools:Add(nodeLua)
  end
end

function UIDataBaseMapController:__DisposePool()
  if self._nodePools then
    self._nodePools:Dispose()
    self._nodePools = nil
  end
  if self._linePools then
    self._linePools:Dispose()
    self._linePools = nil
  end
  if self._reqList then
    for i = 1, #self._reqList do
      local req = self._reqList[i]
      req:Dispose()
    end
  end
end

function UIDataBaseMapController:__MoveContentPos()
end

function UIDataBaseMapController:__CreateNodeAndLinePrefab()
  self:__MoveContentPos()
  self:__CheckHideNode()
  self:__CheckShowNode()
  self:__CheckLines()
end

function UIDataBaseMapController:__CreateLinePool()
  self._openLines = {}
  local lineParent = self:GetUIComponent("Transform", "lineParent")
  self._linePools = UIDataBasePool:New("LINE")
  for i = 1, lineParent.childCount do
    local lineTr = lineParent:GetChild(i - 1)
    local line = UIDataBaseLineItem:New()
    local go = lineTr.gameObject
    line:SetData(i, go, lineTr, function(id)
      self:__SaveAnimLines(id)
    end)
    self._linePools:Add(line)
  end
end

function UIDataBaseMapController:__SaveAnimLines(id)
  if not table.icontains(self._waitAnimLineList, id) then
    table.insert(self._waitAnimLineList, id)
  end
end

function UIDataBaseMapController:__CheckPosInScreen(v2)
  local contentPosX = self._contentRect.anchoredPosition.x
  local posX = v2[1] + contentPosX
  if posX + self._nodeWidthHalf >= 0 - self._leftRightGap and posX - self._nodeWidthHalf + self._leftRightGap <= self._screenWidth - self._leftRightGap then
    return true
  end
  return false
end

function UIDataBaseMapController:__InitScrollRect()
  self._scrollRect.onValueChanged:AddListener(function(value)
    self:__CheckHideNode()
    self:__CheckShowNode()
    self:__CheckLines()
  end)
end

function UIDataBaseMapController:__CheckHideNode()
  if self._openList and table.count(self._openList) > 0 then
    for key, value in pairs(self._openList) do
      if not self:__CheckPosInScreen(value:Pos()) then
        self._openList[key] = nil
        value:EndDrag()
        self._nodePools:ReturnItem(value)
      end
    end
  end
end

function UIDataBaseMapController:__CheckShowNode()
  if self._filterList and table.count(self._filterList) > 0 then
    for key, value in pairs(self._filterList) do
      if not self._openList[value.ID] and self:__CheckPosInScreen(value.Pos) then
        local node = self._nodePools:GetItem()
        local nodeInfo = self:__GetNodeInfo(value.ID)
        node:SetData(value, nodeInfo, function(id)
          self:__OnNodeClick(id)
        end, function(id)
          return self:__CheckNodeRed(id)
        end, function(id)
          self:__SaveAnimNode(id)
        end)
        self._openList[value.ID] = node
      end
    end
  end
end

function UIDataBaseMapController:__SaveAnimNode(id)
  if not table.icontains(self._waitAnimNodeList, id) then
    table.insert(self._waitAnimNodeList, id)
  end
end

function UIDataBaseMapController:__RefreshNodeInfo()
  if self._openList and table.count(self._openList) > 0 then
    for key, value in pairs(self._openList) do
      local info = self:__GetNodeInfo(key)
      value:RefreshInfo(info)
    end
  end
  self:__RefreshLines()
end

function UIDataBaseMapController:__CheckNodeRed(id)
  return self._module:UI_DB_one_node_red(id)
end

function UIDataBaseMapController:__OnNodeClick(id)
  Log.debug("###[UIDataBaseMapController] __OnNodeClick id --> ", id)
  self:ShowDialog("UIDataBaseController", id, function()
    self:__PlayWaitNodeAnim()
  end)
  self:MoveContentTween(id)
end

function UIDataBaseMapController:MoveContentTween(id)
  local node = self._openList[id]
  if node then
    local pos = node:Pos()
    if pos then
      local posX = pos[1]
      local scrollRectWidth = self._scrollTransform.rect.width
      local realPosX = self._contentRect.anchoredPosition.x + posX
      local _moveX = 0
      if 0 > realPosX - self._nodeWidthHalf then
        _moveX = self._nodeWidthHalf - realPosX
      elseif scrollRectWidth < realPosX + self._nodeWidthHalf then
        _moveX = scrollRectWidth - (realPosX + self._nodeWidthHalf)
      end
      local moveX = self._contentRect.anchoredPosition.x + _moveX
      self._contentRect.anchoredPosition = Vector2(moveX, self._contentRect.anchoredPosition.y)
    end
  end
end

function UIDataBaseMapController:__PlayWaitNodeAnim()
  if not self._waitAnimNodeList or not self._waitAnimLineList then
    return
  end
  if table.count(self._waitAnimNodeList) > 0 then
    for key, value in pairs(self._openList) do
      local id = key
      local node = value
      if table.icontains(self._waitAnimNodeList, id) then
        node:PlayAnim()
      end
    end
    table.clear(self._waitAnimNodeList)
  end
  if table.count(self._waitAnimLineList) > 0 then
    for key, value in pairs(self._openLines) do
      local line = value
      local id = line:GetID()
      if table.icontains(self._waitAnimLineList, id) then
        line:PlayAnim()
      end
    end
    table.clear(self._waitAnimLineList)
  end
end

function UIDataBaseMapController:__GetNodeInfo(nodeID)
  local info = {}
  local lock = not self._module:CheckOneNodeOpen(nodeID)
  info.lock = lock
  return info
end

function UIDataBaseMapController:__CheckLines()
  self:__CheckHideLine()
  self:__CheckShowLine()
end

function UIDataBaseMapController:__CheckHideLine()
  if self._openLines and table.count(self._openLines) > 0 then
    for key, value in pairs(self._openLines) do
      local leftNode = value:GetLeftNode()
      local rightNode = value:GetRightNode()
      local leftPos = self._cfg_data_base_nodes[leftNode].Pos
      local rightPos = self._cfg_data_base_nodes[rightNode].Pos
      if not self:__CheckPosInScreen(leftPos) and not self:__CheckPosInScreen(rightPos) then
        self._openLines[key] = nil
        value:Reset()
        self._linePools:ReturnItem(value)
        Log.debug("==== line return ", key)
      end
    end
  end
end

function UIDataBaseMapController:__CheckShowLine()
  for i = 1, #self._filterList do
    local nodeCfg = self._filterList[i]
    if nodeCfg.PreThemeID then
      local lastNodes = nodeCfg.PreThemeID
      for j = 1, #lastNodes do
        local lastNodeID = lastNodes[j]
        local lineid = nodeCfg.ID * 1000 + lastNodeID
        if not self._openLines[lineid] then
          local nodePos = nodeCfg.Pos
          local lastNodeCfg = self._cfg_data_base_nodes[lastNodeID]
          local lastNodePos = lastNodeCfg.Pos
          if self:__CheckPosInScreen(lastNodePos) or self:__CheckPosInScreen(nodePos) then
            local node_1_type = self:__GetPosTypeWithPosY(lastNodePos[2])
            local node_2_type = self:__GetPosTypeWithPosY(nodePos[2])
            local isRight = true
            local dir
            if node_1_type == 1 then
              if node_2_type == 1 then
                isRight = false
              elseif node_2_type == 2 then
                dir = 1
              elseif node_2_type == 3 then
                isRight = false
              end
            elseif node_1_type == 2 then
              if node_2_type == 1 then
                dir = 2
              elseif node_2_type == 2 then
                dir = 0
              elseif node_2_type == 3 then
                dir = 3
              end
            elseif node_1_type == 3 then
              if node_2_type == 1 then
                isRight = false
              elseif node_2_type == 2 then
                dir = 4
              elseif node_2_type == 3 then
                isRight = false
              end
            end
            if not isRight then
              Log.fatal("###[UIDataBaseMapController] 配置错误,id --> ", nodeCfg.ID, "[", node_1_type, "]|", lastNodeCfg.ID, "[", node_2_type, "]")
              return
            end
            local line = self._linePools:GetItem()
            line:OnValue(lastNodeCfg.ID, nodeCfg.ID)
            Log.debug("==== line get !")
            line:HideAllLines()
            local open = self._module:CheckOneNodeOpen(nodeCfg.ID)
            if dir == 0 then
              local pos1 = nodeCfg.Pos
              local pos2 = lastNodeCfg.Pos
              line:ShowLine(true, open)
              self:__SetLineStData(line, dir, pos1, pos2)
            else
              local pos1 = lastNodeCfg.Pos
              local pos2 = nodeCfg.Pos
              line:ShowLine(false, open)
              self:__SetLineCurveData(line, dir, pos1, pos2)
            end
            self._openLines[lineid] = line
          end
        end
      end
    end
  end
end

function UIDataBaseMapController:__RefreshLines()
  for key, value in pairs(self._openLines) do
    local line = value
    local rightNodeID = line:GetRightNode()
    local open = self._module:CheckOneNodeOpen(rightNodeID)
    line:RefreshOpenState(open)
  end
end

function UIDataBaseMapController:__SetLineStData(line, dir, pos1, pos2)
  if dir ~= 0 then
    Log.fatal("###[UIDataBaseMapController] __SetLineStData dir ~= 0 ! dir --> ", dir)
    return
  end
  local rt = line:GetRt()
  local middlePos = Vector2((pos1[1] + pos2[1]) * 0.5, (pos1[2] + pos2[2]) * 0.5)
  rt.anchoredPosition = middlePos
  local width = Mathf.Sqrt((pos1[1] - pos2[1]) ^ 2 + (pos1[2] - pos2[2]) ^ 2)
  rt.sizeDelta = Vector2(width, rt.sizeDelta.y)
  rt.localRotation = Quaternion.FromToRotation(Vector3.right, Vector3(pos1[1] - pos2[1], pos1[2] - pos2[2], 0))
end

function UIDataBaseMapController:__SetLineCurveData(line, dir, pos1, pos2)
  local rotation = self:__GetRotationWithDir(dir)
  line:SetCurveRotation(rotation)
  local pos, width, height = self:__GetNodePosOffset(dir, pos1, pos2)
  line:SetCurvePos(pos)
  line:SetCurveLineWidth(width, height)
end

function UIDataBaseMapController:__GetPosTypeWithPosY(y)
  local node_1_y = y
  local node_1_type
  if node_1_y == 0 then
    node_1_type = 2
  elseif 0 < node_1_y then
    node_1_type = 1
  elseif node_1_y < 0 then
    node_1_type = 3
  end
  return node_1_type
end

function UIDataBaseMapController:__GetRotationWithDir(dir)
  if dir == 0 then
    Log.fatal("###[UIDataBaseMapController] __GetRotationWithDir dir == 0 !")
  end
  return self._dir2angle[dir]
end

function UIDataBaseMapController:__GetNodePosOffset(dir, pos1, pos2)
  local _pos, _lastPosOffset, _nextPosOffset, _width, _height, offsetPos1
  if dir == 0 then
    Log.fatal("###[UIDataBaseMapController] __GetNodePosOffset dir == 0 !")
  elseif dir == 1 then
    local nextPos = Vector2(pos2[1], pos2[2])
    _nextPosOffset = nextPos + self._nodeOffset[1]
    local lastPos = Vector2(pos1[1], pos1[2])
    _lastPosOffset = lastPos + self._nodeOffset[3]
    _pos = Vector2(_nextPosOffset.x, _lastPosOffset.y)
    _width = math.abs(_lastPosOffset.y - _nextPosOffset.y)
    _height = math.abs(_lastPosOffset.x - _nextPosOffset.x)
  elseif dir == 2 then
    local nextPos = Vector2(pos2[1], pos2[2])
    _nextPosOffset = nextPos + self._nodeOffset[6]
    local lastPos = Vector2(pos1[1], pos1[2])
    _lastPosOffset = lastPos + self._nodeOffset[2]
    _pos = Vector2(_lastPosOffset.x, _nextPosOffset.y)
    _width = math.abs(_lastPosOffset.x - _nextPosOffset.x)
    _height = math.abs(_lastPosOffset.y - _nextPosOffset.y)
  elseif dir == 3 then
    local nextPos = Vector2(pos2[1], pos2[2])
    _nextPosOffset = nextPos + self._nodeOffset[6]
    local lastPos = Vector2(pos1[1], pos1[2])
    _lastPosOffset = lastPos + self._nodeOffset[4]
    _pos = Vector2(_lastPosOffset.x, _nextPosOffset.y)
    _width = math.abs(_lastPosOffset.y - _nextPosOffset.y)
    _height = math.abs(_lastPosOffset.x - _nextPosOffset.x)
  elseif dir == 4 then
    local nextPos = Vector2(pos2[1], pos2[2])
    _nextPosOffset = nextPos + self._nodeOffset[5]
    local lastPos = Vector2(pos1[1], pos1[2])
    _lastPosOffset = lastPos + self._nodeOffset[3]
    _pos = Vector2(_nextPosOffset.x, _lastPosOffset.y)
    _width = math.abs(_lastPosOffset.x - _nextPosOffset.x)
    _height = math.abs(_lastPosOffset.y - _nextPosOffset.y)
  end
  return _pos, _width, _height
end

_class("UIDataBasePool", Object)
UIDataBasePool = UIDataBasePool

function UIDataBasePool:Constructor(name)
  self._name = name
  self._poolList = {}
end

function UIDataBasePool:Add(unit)
  unit:SetEnable(false)
  table.insert(self._poolList, unit)
end

function UIDataBasePool:Dispose()
  self._poolList = nil
end

function UIDataBasePool:GetItem()
  for key, value in pairs(self._poolList) do
    self._poolList[key] = nil
    value:SetEnable(true)
    return value
  end
end

function UIDataBasePool:ReturnItem(unit)
  unit:SetEnable(false)
  table.insert(self._poolList, unit)
end

_class("UIDataBaseNodeItem", UICustomWidget)
UIDataBaseNodeItem = UIDataBaseNodeItem

function UIDataBaseNodeItem:Constructor()
  self._inited = false
  self._id = nil
  self._beginCb = nil
  self._endCb = nil
  self._dragCb = nil
  self._clickCb = nil
end

function UIDataBaseNodeItem:OnShow()
  self:GetComponents()
end

function UIDataBaseNodeItem:GetComponents()
  self._iconImg = self:GetUIComponent("RawImageLoader", "icon")
  self._iconRect = self:GetUIComponent("RectTransform", "icon")
  self._nameTex = self:GetUIComponent("UILocalizationText", "name")
  self._lockGo = self:GetGameObject("lock")
  self._redGo = self:GetGameObject("red")
  self._go = self:GetGameObject("go")
  self._rect = self:GetUIComponent("RectTransform", "go")
  self._numberGo = self:GetGameObject("numberGo")
  self._gotGo = self:GetGameObject("gotGo")
  self._getGo = self:GetGameObject("getGo")
  self._anim = self:GetUIComponent("Animation", "go")
  self._eventTriggerListener = self:GetUIComponent("UIEventTriggerListener", "bg")
end

function UIDataBaseNodeItem:SetData(nodeCfg, nodeInfo, callback, getred, saveNode)
  self._cfg = nodeCfg
  local itemid = nodeCfg.Award[1]
  local cfg_item = Cfg.cfg_item[itemid]
  if not cfg_item then
    Log.error("###[UIDataBaseNodeItem] cfg_item is nil ! id --> ", itemid)
  end
  local hwAspect = 1
  if 3751000 <= itemid and itemid <= 3751999 then
    hwAspect = 0.8421052631578947
  elseif 3752000 <= itemid and itemid <= 3752999 then
    hwAspect = 0.6388888888888888
  elseif 3753000 <= itemid and itemid <= 3753999 then
    hwAspect = 0.6388888888888888
  end
  self._iconRect.sizeDelta = Vector2(150, 150 * hwAspect)
  self._icon = cfg_item.Icon
  self._name = nodeCfg.Name
  self._lock = nodeInfo.lock
  self._callback = callback
  self._getred = getred
  self._saveNode = saveNode
  self:OnValue()
end

function UIDataBaseNodeItem:RefreshInfo(info)
  local lock = info.lock
  if self._lock and not info.lock then
    self._saveNode(self._cfg.ID)
  end
  self._lock = lock
  self._lockGo:SetActive(lock)
  self:Red()
  self:CheckInfoData()
end

function UIDataBaseNodeItem:PlayAnim()
  Log.debug("###[UIDataBaseNodeItem] 我播动画了 ! id --> ", self._cfg.ID)
  self._anim:Play("uieff_UIDataBaseNode_in")
end

function UIDataBaseNodeItem:OnValue()
  self._iconImg:LoadImage(self._icon)
  self._lockGo:SetActive(self._lock)
  self._rect.anchoredPosition = Vector2(self._cfg.Pos[1], self._cfg.Pos[2])
  self:Red()
  self:CheckInfoData()
end

function UIDataBaseNodeItem:CheckInfoData()
  local airModule = GameGlobal.GetModule(AircraftModule)
  local passCount = 0
  local infos = self._cfg.InfoIDList
  local allCount = table.count(infos)
  local nodePassList = airModule:GetThemeList()
  if nodePassList[self._cfg.ID] then
    local preNodeData = nodePassList[self._cfg.ID]
    local pre_unlock_infos = preNodeData.unlock_info_list
    for i = 1, #infos do
      local infoid = infos[i]
      if table.icontains(pre_unlock_infos, infoid) then
        passCount = passCount + 1
      end
    end
  end
  local state
  if self._lock then
    state = 1
  elseif self._red then
    if passCount == allCount then
      state = 2
    else
      state = 3
    end
  elseif passCount == allCount then
    state = 4
  else
    state = 5
  end
  self._numberGo:SetActive(state == 3 or state == 5)
  self._gotGo:SetActive(state == 4)
  self._getGo:SetActive(state == 2)
  if state == 3 or state == 5 then
    self._nameTex:SetText(passCount .. "/" .. allCount)
  end
end

function UIDataBaseNodeItem:GetID()
  return self._cfg.ID
end

function UIDataBaseNodeItem:Red()
  self._red = false
  if self._getred then
    self._red = self._getred(self._cfg.ID)
  end
  self:SetRed(self._red)
end

function UIDataBaseNodeItem:Pos()
  return self._cfg.Pos
end

function UIDataBaseNodeItem:SetEnable(nodeEnable)
  self._nodeEnable = nodeEnable
  self._go:SetActive(nodeEnable)
end

function UIDataBaseNodeItem:SetRed(red)
  self._redGo:SetActive(red)
end

function UIDataBaseNodeItem:GetEnable()
  return self._nodeEnable
end

function UIDataBaseNodeItem:EndDrag()
  if self._eventTriggerListener then
    self._eventTriggerListener.IsDragging = false
  end
end

function UIDataBaseNodeItem:bgOnClick(go)
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.N8DefaultClick)
  if self._callback then
    self._callback(self._cfg.ID)
  end
end

_class("UIDataBaseLineItem", Object)
UIDataBaseLineItem = UIDataBaseLineItem

function UIDataBaseLineItem:Constructor()
  self._leftNode = nil
  self._rightNode = nil
end

function UIDataBaseLineItem:SetData(id, go, lineRoot, saveCb)
  self._id = id
  self._go = go
  self._lineRoot = lineRoot
  self._saveCb = saveCb
  self:GetComponent()
end

function UIDataBaseLineItem:GetComponent()
  self._st_go = self._lineRoot:Find("straight").gameObject
  self._st_tr = self._st_go:GetComponent("RectTransform")
  self._st_black_go = self._lineRoot:Find("straight/black").gameObject
  self._st_yellow_go = self._lineRoot:Find("straight/yellow").gameObject
  self._cur_go = self._lineRoot:Find("curve").gameObject
  self._cur_tr = self._cur_go:GetComponent("RectTransform")
  self._cur_black_go = self._lineRoot:Find("curve/black").gameObject
  self._cur_yellow_go = self._lineRoot:Find("curve/yellow").gameObject
  self._anim = self._go:GetComponent("Animation")
end

function UIDataBaseLineItem:PlayAnim()
  Log.debug("###[UIDataBaseLineItem] 我是线，我播了动画 ！ id --> ", self._id)
  self._anim:Play("uieff_UIDataBaseMapController_line")
end

function UIDataBaseLineItem:OnValue(leftNode, rightNode)
  self._leftNode = leftNode
  self._rightNode = rightNode
end

function UIDataBaseLineItem:GetID()
  return self._id
end

function UIDataBaseLineItem:GetLeftNode()
  return self._leftNode
end

function UIDataBaseLineItem:GetRightNode()
  return self._rightNode
end

function UIDataBaseLineItem:GetRt()
  return self._st_tr
end

function UIDataBaseLineItem:RefreshOpenState(open)
  if not self._open and open and self._saveCb then
    self._saveCb(self._id)
  end
  self._open = open
  self:HideAllLines()
  self._st_go:SetActive(self._isStraight)
  self._cur_go:SetActive(not self._isStraight)
  if self._isStraight then
    if self._open then
      self._st_yellow_go:SetActive(true)
    else
      self._st_black_go:SetActive(true)
    end
  elseif self._open then
    self._cur_yellow_go:SetActive(true)
  else
    self._cur_black_go:SetActive(true)
  end
end

function UIDataBaseLineItem:SetEnable(enable)
  self._lineEnable = enable
  self._go:SetActive(enable)
end

function UIDataBaseLineItem:GetEnable()
  return self._lineEnable
end

function UIDataBaseLineItem:SetCurveRotation(rotation)
  self._cur_tr.localRotation = Quaternion.Euler(0, 0, rotation)
end

function UIDataBaseLineItem:SetCurvePos(pos)
  self._cur_tr.anchoredPosition = pos
end

function UIDataBaseLineItem:SetCurveLineWidth(width, height)
  self._cur_tr.sizeDelta = Vector2(width, height)
end

function UIDataBaseLineItem:HideAllLines()
  self._st_black_go:SetActive(false)
  self._st_yellow_go:SetActive(false)
  self._cur_black_go:SetActive(false)
  self._cur_yellow_go:SetActive(false)
end

function UIDataBaseLineItem:ShowLine(straight, open)
  self._isStraight = straight
  self._open = open
  self._st_go:SetActive(self._isStraight)
  self._cur_go:SetActive(not self._isStraight)
  if self._isStraight then
    if self._open then
      self._st_yellow_go:SetActive(true)
    else
      self._st_black_go:SetActive(true)
    end
  elseif self._open then
    self._cur_yellow_go:SetActive(true)
  else
    self._cur_black_go:SetActive(true)
  end
end

function UIDataBaseLineItem:Reset()
  self._cur_tr.localRotation = Quaternion.identity
  self._st_tr.localRotation = Quaternion.identity
end
