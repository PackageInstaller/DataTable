local Input = CS.UnityEngine.Input
local T_DragGesture = typeof(CS.Z1Client.General.DragGesture)
local T_UIExport = typeof(CS.FrameWork.UIExport)
local GameObject = CS.UnityEngine.GameObject
local Vector2 = CS.UnityEngine.Vector2
local Quaternion = CS.UnityEngine.Quaternion
local T_RepeatButton = typeof(CS.RepeatButton)
local RedDotGmView, Super = NewClass("RedDotGmView", BaseView)
RedDotGmView.uiResCls = GmRedDotViewResource
local TransformUtil = CS.Framework.TransformUtil

function RedDotGmView:ctor(redDotId, redDotParams)
  Super.ctor(self)
  self.redDotId = redDotId
  self.redDotParams = redDotParams
  self.contentTf = nil
  self.contentPosX, self.contentPosY = nil, nil
  self.oriContentPosX, self.oriContentPosY = nil, nil
  self.moveX, self.moveY = 0, 0
  self.minScale = 0.4
  self.maxScale = 1.6
  self._curScale = 1
  self.scaleRange = self.maxScale - self.minScale
  self.mouseDragging = false
  self.isTouchingUI = false
  self._redDotNodeGameObjs = {}
  self._redDotLineGameObjs = {}
  self._redDotNodeMap = {}
  self._collapsedNodeSet = {}
  self._redDotLineMap = {}
  self._hasInitCollapseByStatus = false
  self._nodeListCache = nil
end

function RedDotGmView:OnBuildView()
  self:_InitContentParams()
  CS.UnityEngine.Input.multiTouchEnabled = true
end

function RedDotGmView:RegisterNotifications()
end

function RedDotGmView:RegisterEvents()
  self:AddViewComponent(self.ui.UI_Common_Btn_Back3, UICompBtnCloseItem, System.fn(self, self.Close))
  self:AddButtonClickListener(self.ui.Btn_Reset, System.fn(self, self._ResetContentPos))
  self:_RegisterDragGesture()
  self:_RegisterBlockDrag()
  self:AddSliderListener(self.ui.Slider_Telescopic, function(sliderValue)
    local scale = self.minScale + self.scaleRange * sliderValue
    self._curScale = scale
    TransformUtil.SetLocalScale(self.contentTf, self._curScale, self._curScale, self._curScale)
  end)
  self:SetSliderValue(self.ui.Slider_Telescopic, 0.5)
end

function RedDotGmView:OnEnterView()
  Super.OnEnterView(self)
  LateUpdateBeat.Instance:Add(self.Update, self)
  self:_RefreshRedDotTree()
end

function RedDotGmView:_RefreshRedDotTree()
  self:_ClearRedDotNodes()
  local nodeList = self._nodeListCache
  if not nodeList then
    local redDotController = RedDotController.Instance
    if not redDotController then
      Logger.Error("[RedDotGmView] RedDotController.Instance is nil")
      return
    end
    local redDotTree = redDotController:GetRedDotTree(self.redDotId, self.redDotParams)
    if not redDotTree then
      Logger.Error("[RedDotGmView] Failed to get RedDotTree for redDotId: %s", tostring(self.redDotId))
      return
    end
    nodeList = {}
    self:_CollectNodes(redDotTree, nodeList, 0, 0)
    if not self._hasInitCollapseByStatus then
      for _, nodeInfo in ipairs(nodeList) do
        if nodeInfo.redDotStatus == false then
          self._collapsedNodeSet[nodeInfo.node] = true
        end
      end
      self._hasInitCollapseByStatus = true
    end
    self._nodeListCache = nodeList
  end
  self:_CreateNodeUIs(nodeList)
end

function RedDotGmView:_IsNodeVisible(node)
  if not node then
    return false
  end
  local parent = node.parent
  while parent do
    if self._collapsedNodeSet[parent] then
      return false
    end
    parent = parent.parent
  end
  return true
end

function RedDotGmView:_CollectNodes(node, nodeList, level, index)
  if not node then
    return
  end
  local nodeName = "Unknown"
  local nodeType = getmetatable(node)
  if nodeType and nodeType.__name then
    nodeName = nodeType.__name
  end
  local paramDesc = self:_GetNodeParamDesc(node)
  table.insert(nodeList, {
    node = node,
    redDotId = node.redDotId,
    redDotDesc = node.redDotDesc,
    name = nodeName,
    level = level,
    index = index,
    redDotStatus = node:Execute(),
    paramDesc = paramDesc
  })
  local children = node:GetChildren()
  if children then
    for i, child in ipairs(children) do
      self:_CollectNodes(child, nodeList, level + 1, i)
    end
  end
end

function RedDotGmView:_GetNodeParamDesc(node)
  if not node then
    return nil
  end
  local ignoreKeys = {
    _children = true,
    parent = true,
    redDotId = true,
    redDotDesc = true
  }
  local parts = {}
  for k, v in pairs(node) do
    if type(k) == "string" and not ignoreKeys[k] and string.sub(k, 1, 1) ~= "_" then
      local valueStr = self:_FormatParamValue(v)
      table.insert(parts, string.format("%s = %s", k, valueStr))
    end
  end
  if 0 == #parts then
    return nil
  end
  table.sort(parts)
  do return table.concat, parts end
  return table.concat, parts, "\n", pairs(node)
end

function RedDotGmView:_FormatParamValue(v)
  local t = type(v)
  if "number" == t or "string" == t or "boolean" == t then
    do return tostring end
    return tostring, v, nil, nil, nil, nil, nil, nil
  elseif "table" == t then
    if table and table.tostring then
      do return table.tostring end
      return table.tostring, v, nil, nil, nil, nil, nil, nil
    end
    local count = 0
    for _ in pairs(v) do
      count = count + 1
      if count > 5 then
        break
      end
    end
    do return string.format, "<table, count=%d>" end
    return string.format, "<table, count=%d>", count, pairs(v)
  else
    do return string.format, "<%s>" end
    return string.format, "<%s>", t, count, pairs(v)
  end
end

function RedDotGmView:_CreateNodeUIs(nodeList)
  if not (self.ui and self.ui.Red_Dot_Info_Comp) or not self.ui.Content_Scale then
    Logger.Error("[RedDotGmView] UI components not found")
    return
  end
  local contentParent = self.ui.Content_Scale.transform
  local itemWidth = 300
  local itemHeight = 400
  local spacingX = 40
  local spacingY = 60
  local startX = 140
  local startY = 400
  self._redDotNodeMap = {}
  self._redDotLineMap = {}
  local levelGroups = {}
  local maxLevel = 0
  for _, nodeInfo in ipairs(nodeList) do
    local node = nodeInfo.node
    if self:_IsNodeVisible(node) then
      local level = nodeInfo.level
      if not levelGroups[level] then
        levelGroups[level] = {}
      end
      table.insert(levelGroups[level], nodeInfo)
      if maxLevel < level then
        maxLevel = level
      end
    end
  end
  for level = 0, maxLevel do
    local nodes = levelGroups[level]
    if not nodes then
    else
      local levelY = startY - level * (itemHeight + spacingY)
      local totalWidth = #nodes * itemWidth + (#nodes - 1) * spacingX
      local levelStartX = startX - totalWidth / 2 + itemWidth / 2
      for i, nodeInfo in ipairs(nodes) do
        local nodeX = levelStartX + (i - 1) * (itemWidth + spacingX)
        local nodeGo = GameObject.Instantiate(self.ui.Red_Dot_Info_Comp)
        nodeGo.transform:SetParent(contentParent, false)
        nodeGo:SetActive(true)
        TransformUtil.SetAnchoredPos(nodeGo.transform, nodeX, levelY)
        local uiExport = nodeGo:GetComponent(T_UIExport)
        if uiExport and uiExport.uiNodeList then
          for j = 0, uiExport.uiNodeList.Count - 1 do
            local uiNode = uiExport.uiNodeList[j]
            if uiNode.name == "Txt_Red_Dot_Id" then
              self:SetText(uiNode.obj, string.format("红点Id\n%s", nodeInfo.redDotId))
            elseif uiNode.name == "Txt_Red_Dot_Cls" then
              self:SetText(uiNode.obj, string.format("红点脚本\n%s", nodeInfo.name))
            elseif uiNode.name == "Txt_Red_Dot_Desc" then
              self:SetText(uiNode.obj, string.format("红点描述\n%s", nodeInfo.redDotDesc or ""))
            elseif uiNode.name == "Txt_Red_Dot_Status" then
              local collapsedSuffix = self._collapsedNodeSet[nodeInfo.node] and "（已折叠）" or "（未折叠）"
              self:SetText(uiNode.obj, string.format("红点状态\n%s%s", tostring(nodeInfo.redDotStatus), collapsedSuffix))
            elseif "Red_Dot_Info_Comp" == uiNode.name then
              if not nodeInfo.redDotStatus then
                self:SetImageColorByHtml(uiNode.obj, "#000000")
              elseif nodeInfo.redDotStatus == RedDotDefine.RedDotType.None then
                self:SetImageColorByHtml(uiNode.obj, "#3A3A3A")
              else
                self:SetImageColorByHtml(uiNode.obj, "#CB3C3C")
              end
            end
          end
        end
        table.insert(self._redDotNodeGameObjs, nodeGo)
        self._redDotNodeMap[nodeInfo.node] = nodeGo.transform
        local node = nodeInfo.node
        local repeatBtn = nodeGo:GetComponent(T_RepeatButton)
        if not repeatBtn then
          if AddComponentOnce then
            repeatBtn = AddComponentOnce(nodeGo, T_RepeatButton)
          else
            repeatBtn = nodeGo:AddComponent(T_RepeatButton)
          end
        end
        if repeatBtn then
          self:SetLongPressButtonIntervalTime(nodeGo, tonumber(DT.GetConstant("ItemAddPressTime")))
          self:AddShortPressButtonListener(nodeGo, function()
            self:_OnClickNode(node)
          end)
          self:AddLongPressButtonListener(nodeGo, function()
            self:_OnLongPressNode(nodeInfo)
          end)
        else
          self:AddButtonClickListener(nodeGo, function()
            self:_OnClickNode(node)
          end)
          Logger.Warn("[RedDotGmView] nodeGo has no RepeatButton, long/short press disabled for this node.")
        end
      end
    end
  end
  self:_CreateLines(nodeList)
end

function RedDotGmView:_CreateLines(nodeList)
  if not (self.ui and self.ui.Red_Tree_Line) or not self.ui.Content_Scale then
    return
  end
  local contentParent = self.ui.Content_Scale.transform
  for _, nodeInfo in ipairs(nodeList) do
    local node = nodeInfo.node
    if node and node.parent then
      local parentNode = node.parent
      local parentTf = self._redDotNodeMap[parentNode]
      local childTf = self._redDotNodeMap[node]
      if parentTf and childTf then
        local px, py = TransformUtil.GetAnchoredPos(parentTf)
        local cx, cy = TransformUtil.GetAnchoredPos(childTf)
        local dx = cx - px
        local dy = cy - py
        local length = math.sqrt(dx * dx + dy * dy)
        if length > 0.01 then
          local centerX = (px + cx) / 2
          local centerY = (py + cy) / 2
          local lineGo = GameObject.Instantiate(self.ui.Red_Tree_Line)
          local lineTf = lineGo.transform
          lineTf:SetParent(contentParent, false)
          lineGo:SetActive(true)
          TransformUtil.SetAnchoredPos(lineTf, centerX, centerY)
          local rectTrans = lineGo:GetComponent(typeof(CS.UnityEngine.RectTransform))
          if rectTrans then
            rectTrans.sizeDelta = Vector2(length, rectTrans.sizeDelta.y)
          end
          local angle = math.deg(math.atan2(dy, dx))
          lineTf.localRotation = Quaternion.Euler(0, 0, angle)
          lineGo.transform:SetAsFirstSibling()
          table.insert(self._redDotLineGameObjs, lineGo)
          self._redDotLineMap[node] = lineGo
        end
      end
    end
  end
end

function RedDotGmView:_ClearRedDotNodes()
  if self._redDotNodeGameObjs then
    for _, go in ipairs(self._redDotNodeGameObjs) do
      if not IsNil(go) then
        GameObject.Destroy(go)
      end
    end
    self._redDotNodeGameObjs = {}
  end
  if self._redDotLineGameObjs then
    for _, go in ipairs(self._redDotLineGameObjs) do
      if not IsNil(go) then
        GameObject.Destroy(go)
      end
    end
    self._redDotLineGameObjs = {}
  end
  self._redDotNodeMap = {}
  self._redDotLineMap = {}
end

function RedDotGmView:_OnClickNode(node)
  if not node then
    return
  end
  if self._collapsedNodeSet[node] then
    self._collapsedNodeSet[node] = nil
  else
    self._collapsedNodeSet[node] = true
  end
  self:_RefreshRedDotTree()
end

function RedDotGmView:_OnLongPressNode(nodeInfo)
  if not nodeInfo then
    return
  end
  local lines = {}
  table.insert(lines, string.format("红点Id: %s", tostring(nodeInfo.redDotId)))
  table.insert(lines, string.format("脚本: %s", tostring(nodeInfo.name or "")))
  table.insert(lines, string.format("描述: %s", tostring(nodeInfo.redDotDesc or "")))
  table.insert(lines, string.format("状态: %s", tostring(nodeInfo.redDotStatus)))
  if nodeInfo.paramDesc and "" ~= nodeInfo.paramDesc then
    table.insert(lines, "")
    table.insert(lines, "参数:")
    table.insert(lines, nodeInfo.paramDesc)
  end
  local msg = table.concat(lines, "\n")
  if UIManager and UIManager.Instance and Urls and Urls.PopMsgPanel then
    local tipsData = {
      title = LT.Text("红点详细信息"),
      desc = msg
    }
    Alert.ShowToolTipsByData(tipsData, self.ui.MaxMad_Tips_Node)
  else
    Logger.Info([[
[RedDotGmView] Node Info:
%s]], msg)
  end
end

function RedDotGmView:_RegisterBlockDrag()
  self.blockDragUIList = {
    self.ui.Slider_Telescopic
  }
  for _, go in ipairs(self.blockDragUIList) do
    local gesture = go:GetComponent(T_DragGesture)
    gesture:onPointerDown("+", System.fn(self, self._OnPointerDownUI))
    gesture:onPointerUp("+", System.fn(self, self._OnPointerUpUI))
  end
end

function RedDotGmView:_UnRegisterBlockDrag()
  self.blockDragUIList = {
    self.ui.Slider_Telescopic
  }
  for _, go in ipairs(self.blockDragUIList) do
    local gesture = go:GetComponent(T_DragGesture)
    gesture:onPointerDown("-", System.fn(self, self._OnPointerDownUI))
    gesture:onPointerUp("-", System.fn(self, self._OnPointerUpUI))
  end
end

function RedDotGmView:_RegisterDragGesture()
  local awakerDragGesture = self.ui.Content_Scale:GetComponent(T_DragGesture)
  awakerDragGesture:onBeginDrag("+", System.fn(self, self._OnBeginDrag))
  awakerDragGesture:onDrag("+", System.fn(self, self._OnDrag))
  awakerDragGesture:onEndDrag("+", System.fn(self, self._OnEndDrag))
end

function RedDotGmView:_UnRegisterAwakerDragGesture()
  local awakerDragGesture = self.ui.Content_Scale:GetComponent(T_DragGesture)
  awakerDragGesture:onBeginDrag("-", System.fn(self, self._OnBeginDrag))
  awakerDragGesture:onDrag("-", System.fn(self, self._OnDrag))
  awakerDragGesture:onEndDrag("-", System.fn(self, self._OnEndDrag))
end

function RedDotGmView:_OnUpdateScale(scale)
  local sliderValue = (scale - self.minScale) / self.scaleRange
  self:SetSliderValue(self.ui.Slider_Telescopic, sliderValue)
end

function RedDotGmView:_ResetContentPos()
  self.contentPosX = self.oriContentPosX
  self.contentPosY = self.oriContentPosY
  TransformUtil.SetAnchoredPos(self.contentTf, self.oriContentPosX, self.oriContentPosY)
  self._curScale = 1
  TransformUtil.SetLocalScale(self.contentTf, self._curScale, self._curScale, self._curScale)
  self:_OnUpdateScale(self._curScale)
end

function RedDotGmView:_OnBeginDrag(pointerData)
  local position = pointerData.position
  self.oldTouchPosX = position.x
  self.oldTouchPosY = position.y
end

function RedDotGmView:_OnDrag(pointerData)
  if self.isTouchingUI then
    return
  end
  if not self.oldTouchPosX or not self.oldTouchPosY then
    return
  end
  if 0 ~= self.moveX or 0 ~= self.moveY then
    self.contentPosX = self.contentPosX + self.moveX
    self.contentPosY = self.contentPosY + self.moveY
    TransformUtil.SetAnchoredPos(self.contentTf, self.contentPosX, self.contentPosY)
    self.moveX = 0
    self.moveY = 0
  end
  local curPos = pointerData.position
  local curX, curY = curPos.x, curPos.y
  self.moveX = curX - self.oldTouchPosX
  self.moveY = curY - self.oldTouchPosY
  self.oldTouchPosX = curX
  self.oldTouchPosY = curY
end

function RedDotGmView:_OnEndDrag()
  self.oldTouchPosX = nil
  self.oldTouchPosY = nil
end

function RedDotGmView:_OnPointerDownUI()
  self.isTouchingUI = true
  self.mouseDragging = false
  self.oldTouchPosX = nil
  self.oldTouchPosY = nil
  self.moveX = 0
  self.moveY = 0
  Logger.Debug("[touch] _OnPointerDownUI self.isTouchingUI=%s", self.isTouchingUI)
end

function RedDotGmView:_OnPointerUpUI()
  self.isTouchingUI = false
  Logger.Debug("[touch] _OnPointerDownUI self.isTouchingUI=%s", self.isTouchingUI)
end

function RedDotGmView:_InitContentParams()
  self.contentTf = self.ui.Content_Scale.transform
  self.contentPosX, self.contentPosY = TransformUtil.GetAnchoredPos(self.contentTf)
  self.oriContentPosX, self.oriContentPosY = self.contentPosX, self.contentPosY
end

function RedDotGmView:Update()
  if Input.touchCount >= 2 then
    self.moveX = 0
    self.moveY = 0
    self.oldTouchPosX = nil
    self.oldTouchPosY = nil
  end
end

function RedDotGmView:Close()
  CS.UnityEngine.Input.multiTouchEnabled = false
  LateUpdateBeat.Instance:Remove(self.Update, self)
  self:_ResetContentPos()
  self:_UnRegisterAwakerDragGesture()
  self:_UnRegisterBlockDrag()
  self:_ClearRedDotNodes()
  Super.Close(self)
end

return RedDotGmView
