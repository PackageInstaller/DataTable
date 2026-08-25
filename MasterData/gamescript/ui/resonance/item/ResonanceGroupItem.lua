local DragGesture = CS.Z1Client.General.DragGesture
local TypeOfScrollRect = typeof(CS.UnityEngine.UI.ScrollRect)
local ResonanceGroupItem, Super = System.NewClass("ResonanceGroupItem", UIBasePanel)

function ResonanceGroupItem:ctor(uiNode, uiResCls, resonanceModel, selectResonancePos, selectResonanceScrollVPos, view)
  Super.ctor(self)
  ResonanceGroupItem.uiResCls = uiResCls
  self.view = view
  self.ui = uiResCls(uiNode)
  self.resonanceModel = resonanceModel
  self.selectResonancePos = selectResonancePos
  self.selectResonanceScrollVPos = selectResonanceScrollVPos
  self.resonanceItems = {}
end

function ResonanceGroupItem:OnBind(binder)
  self.binder = binder
  self:BindResonanceListView()
  self:BindResonanceSelected()
  self:BindResonanceStateLinkedLines()
  self:BindScrollViewButton()
  self:AutoSelectFirstResonance()
end

function ResonanceGroupItem:BindScrollViewButton()
  self.gesture = self.ui.ScrollView:GetComponent(typeof(DragGesture))
  self.gesture:onDrag("+", System.fn(self, self.OnDragScrollview))
  self.gesture:onPointerDown("+", System.fn(self, self.OnPointerDownUpponScrollview))
  self.gesture:onPointerClick("+", System.fn(self, self.OnPointerClickScrollview))
end

function ResonanceGroupItem:OnPointerDownUpponScrollview()
  self.isDragScrollview = false
end

function ResonanceGroupItem:OnDragScrollview()
  self:StopTweenContent()
  self.isDragScrollview = true
end

function ResonanceGroupItem:OnPointerClickScrollview()
  if self.isDragScrollview then
    return
  end
  self.resonanceModel:SetSelectResonanceID(0)
end

function ResonanceGroupItem:OnUnbind()
  self.gesture:onDrag("-", System.fn(self, self.OnDragScrollview))
  self.gesture:onPointerDown("-", System.fn(self, self.OnPointerDownUpponScrollview))
  self.gesture:onPointerClick("-", System.fn(self, self.OnPointerClickScrollview))
end

function ResonanceGroupItem:BindResonanceStateLinkedLines()
  local tidToLineGoList = {}
  local contentTf = self.ui.Group_Content.transform
  for i = 0, contentTf.childCount - 1 do
    local child = contentTf:GetChild(i)
    local lineGo = child.gameObject
    local curIndex, _ = child.name:match("Image_vessel_(%d+)_(%d+)")
    if curIndex then
      local tid = self:GetResonanceTidByIndex(tonumber(curIndex))
      tidToLineGoList[tid] = tidToLineGoList[tid] or {}
      table.insert(tidToLineGoList[tid], lineGo)
    end
  end
  self.binder:BindToRaw(function(_, _, _)
    for tid, lineGoList in pairs(tidToLineGoList) do
      local isActive = ResonanceDataUtils.IsResonanceActive(tid)
      for i = 1, #lineGoList do
        local lineGo = lineGoList[i]
        local noActiveLine = lineGo.transform:GetChild(0)
        local activeLine = lineGo.transform:GetChild(1)
        noActiveLine.gameObject:SetActive(not isActive)
        activeLine.gameObject:SetActive(isActive)
      end
    end
  end, function()
    do return self.resonanceModel.GetResonanceGroupTotalLevel, self.resonanceModel end
    return self.resonanceModel.GetResonanceGroupTotalLevel, self.resonanceModel, self.resonanceModel.resonanceGroupId
  end)
end

function ResonanceGroupItem:GetResonanceTidByIndex(index)
  for tidCur, v in pairs(self.resonanceItems) do
    if v.index == index then
      return tidCur
    end
  end
end

function ResonanceGroupItem:BindResonanceListView()
  local index = 1
  local resonances = self.resonanceModel:GetResonancesList()
  ResonanceDataUtils.ActiveFirstResonance(resonances[1].ID)
  while true do
    local uiNode = self.ui["UI_Chaper_Item_Level_Vibes" .. index - 1]
    if not uiNode then
      break
    end
    uiNode:SetActive(true)
    local behaviour = self.binder:BindUIBehavior(uiNode, self.resonanceModel, resonances[index], true, self.view)
    self.resonanceItems[resonances[index].ID] = {
      index = index - 1,
      resonanceItem = behaviour
    }
    index = index + 1
  end
  self.ui.Content.transform.localPosition = CS.UnityEngine.Vector3(-940, 0, 0)
end

function ResonanceGroupItem:BindResonanceSelected()
  self.binder:BindToRaw(function(_, new)
    if 0 == new then
      return
    end
    self:StopScrollRectMotion()
    self:StopTweenContent()
    local node = self.resonanceItems[new].resonanceItem.ui.uiNode
    local changePos = self.selectResonancePos.transform.position
    local deltaX = changePos.x - node.transform.position.x
    local lPos = self.ui.Content.transform.position
    self.tweenContent = self.ui.Content.transform:DOMoveX(lPos.x + deltaX, math.min(0.5, math.abs(deltaX) / 60))
  end, function()
    return self.resonanceModel.selectResonanceID
  end)
end

function ResonanceGroupItem:StopTweenContent()
  if self.tweenContent then
    self.tweenContent:Kill()
    self.tweenContent = nil
  end
end

function ResonanceGroupItem:StopScrollRectMotion()
  local scrollRect = self.ui.ScrollView:GetComponent(TypeOfScrollRect)
  scrollRect:StopMovement()
end

function ResonanceGroupItem:AutoSelectFirstResonance()
  local resonances = self.resonanceModel:GetResonancesList()
  for i = #resonances, 1, -1 do
    if ResonanceDataUtils.IsResonanceActive(resonances[i].ID) then
      self.resonanceModel:SetSelectResonanceID(resonances[i].ID)
      return
    end
  end
  self.resonanceModel:SetSelectResonanceID(resonances[1].ID)
end

return ResonanceGroupItem
