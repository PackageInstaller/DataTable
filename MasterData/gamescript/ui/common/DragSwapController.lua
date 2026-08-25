local T_DragGesture = typeof(CS.Z1Client.General.DragGesture)
local T_RectTransform = typeof(CS.UnityEngine.RectTransform)
local RectTransformUtility = CS.UnityEngine.RectTransformUtility
local UnityObject = CS.UnityEngine.Object
local Vector2 = CS.UnityEngine.Vector2
local DragSwapController = System.NewClass("DragSwapController")

function DragSwapController:ctor(rootNode)
  self.rootNode = rootNode
  self.groups = {}
  self.gestureList = {}
  self.dragSource = nil
  self.dragVisual = nil
end

function DragSwapController:AddGroup(comps, config)
  table.insert(self.groups, {
    comps = comps,
    getTid = config.getTid,
    onSwap = config.onSwap
  })
end

function DragSwapController:Init()
  for groupIndex, group in ipairs(self.groups) do
    for idx, go in ipairs(group.comps) do
      local gesture = go:GetComponent(T_DragGesture)
      gesture = gesture or go:AddComponent(T_DragGesture)
      
      local function onBegin(pointerData)
        self:_OnBeginDrag(groupIndex, idx, go, pointerData)
      end
      
      local function onDrag(pointerData)
        self:_OnDrag(pointerData)
      end
      
      local function onEnd(pointerData)
        self:_OnEndDrag(pointerData)
      end
      
      gesture:onBeginDrag("+", onBegin)
      gesture:onDrag("+", onDrag)
      gesture:onEndDrag("+", onEnd)
      table.insert(self.gestureList, {
        gesture = gesture,
        onBegin = onBegin,
        onDrag = onDrag,
        onEnd = onEnd
      })
    end
  end
end

function DragSwapController:UnInit()
  self:_RestoreDragVisual()
  self.dragSource = nil
  for _, item in ipairs(self.gestureList) do
    if not IsNil(item.gesture) then
      item.gesture:onBeginDrag("-", item.onBegin)
      item.gesture:onDrag("-", item.onDrag)
      item.gesture:onEndDrag("-", item.onEnd)
    end
  end
  self.gestureList = {}
end

function DragSwapController:_OnBeginDrag(groupIndex, idx, go, pointerData)
  local group = self.groups[groupIndex]
  if not group or 0 == group.getTid(idx) then
    self.dragSource = nil
    return
  end
  self.dragSource = {groupIndex = groupIndex, idx = idx}
  self:_PickUpDragVisual(go, pointerData)
end

function DragSwapController:_OnDrag(pointerData)
  if not self.dragSource then
    return
  end
  self:_UpdateDragVisual(pointerData)
end

function DragSwapController:_OnEndDrag(pointerData)
  local source = self.dragSource
  self:_RestoreDragVisual()
  self.dragSource = nil
  if not source then
    return
  end
  local group = self.groups[source.groupIndex]
  if not group then
    return
  end
  local targetIdx = self:_FindDropSlot(group, source.idx, pointerData)
  if not targetIdx or targetIdx == source.idx then
    return
  end
  group.onSwap(source.idx, targetIdx)
end

function DragSwapController:_FindDropSlot(group, sourceIdx, pointerData)
  local screenPos = Vector2(pointerData.position.x, pointerData.position.y)
  local uiCamera = UIRootMgr.GetUICamera()
  for idx, go in ipairs(group.comps) do
    if idx ~= sourceIdx and not IsNil(go) then
      local rectTf = go:GetComponent(T_RectTransform)
      if rectTf and RectTransformUtility.RectangleContainsScreenPoint(rectTf, screenPos, uiCamera) then
        return idx
      end
    end
  end
  return nil
end

function DragSwapController:_PickUpDragVisual(go, pointerData)
  local clone = Instantiate(go, self.rootNode.transform)
  local rectTf = clone:GetComponent(T_RectTransform)
  rectTf:SetAsLastSibling()
  self.dragVisual = {go = clone, rectTf = rectTf}
  self:_UpdateDragVisual(pointerData)
end

function DragSwapController:_UpdateDragVisual(pointerData)
  local dragVisual = self.dragVisual
  if not dragVisual or IsNil(dragVisual.rectTf) then
    return
  end
  local rootRect = self.rootNode:GetComponent(T_RectTransform)
  local screenPos = Vector2(pointerData.position.x, pointerData.position.y)
  local ok, localPoint = RectTransformUtility.ScreenPointToLocalPointInRectangle(rootRect, screenPos, UIRootMgr.GetUICamera())
  if ok then
    dragVisual.rectTf.anchoredPosition = localPoint
  end
end

function DragSwapController:_RestoreDragVisual()
  if not self.dragVisual then
    return
  end
  if not IsNil(self.dragVisual.go) then
    UnityObject.Destroy(self.dragVisual.go)
  end
  self.dragVisual = nil
end

return DragSwapController
