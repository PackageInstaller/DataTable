_class("UIN13BuildMapNode", UICustomWidget)
UIN13BuildMapNode = UIN13BuildMapNode

function UIN13BuildMapNode:SetData(nodeData, nodeId, callback)
  self._nodeData = nodeData
  self._nodeId = nodeId
  self._callback = callback
  self:_SetPos(nodeId)
  self:_SetType(nodeId)
end

function UIN13BuildMapNode:_SetPos(nodeId)
  local pos = self._nodeData:GetNodePos(nodeId)
  local rect = self:GetGameObject():GetComponent("RectTransform")
  rect.anchorMax = Vector2(0, 0.5)
  rect.anchorMin = Vector2(0, 0.5)
  rect.sizeDelta = Vector2.zero
  rect.anchoredPosition = pos
end

function UIN13BuildMapNode:_SetType(nodeId)
  local type = self._nodeData:GetNode(nodeId).Type
  local widgetName = {
    {"type2"},
    {"type3"}
  }
  local name = widgetName[type][1]
  self:_SetWidgetActive(name, true)
end

function UIN13BuildMapNode:SetHighlight(high)
  local nodeId = self._nodeId
  local type = self._nodeData:GetNode(nodeId).Type
  if type == 2 then
    local widgetName = {"type3", "type3b"}
    local show = high and 2 or 1
    local hide = high and 1 or 2
    self:_SetWidgetActive(widgetName[show], true)
    self:_SetWidgetActive(widgetName[hide], false)
  end
end

function UIN13BuildMapNode:_SetWidgetActive(name, show)
  local trans = self:GetGameObject("state_open").transform
  local obj = trans:Find(name)
  obj.gameObject:SetActive(show)
end

function UIN13BuildMapNode:SetDebugText(txt)
  self:GetGameObject("_debug"):SetActive(UIActivityHelper.CheckDebugOpen())
  local obj = self:GetUIComponent("UILocalizationText", "_debug")
  obj:SetText(txt)
end

function UIN13BuildMapNode:BtnOnClick()
  Log.info("UIN13BuildMapNode:BtnOnClick")
  if self._callback then
    self._callback(self._nodeId)
  end
end
