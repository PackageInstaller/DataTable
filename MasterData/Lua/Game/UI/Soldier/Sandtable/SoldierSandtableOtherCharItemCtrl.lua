local SoldierSandtableOtherCharItemCtrl = class("SoldierSandtableOtherCharItemCtrl", BaseCtrl)
SoldierSandtableOtherCharItemCtrl._mapNodeConfig = {
  btn_char = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Char"
  },
  drag = {
    sNodeName = "char",
    sComponentName = "UIDrag",
    callback = "OnUIDrag_Drag"
  },
  trSortItem = {
    sNodeName = "char",
    sComponentName = "RectTransform"
  },
  raySortItem = {
    sNodeName = "char",
    sComponentName = "Empty4Raycast"
  },
  rayDragEvent = {
    sComponentName = "Empty4Raycast"
  },
  charCtrl = {
    sNodeName = "tc_char_small",
    sCtrlName = "Game.UI.Soldier.Template.Character.SoldierCharItemCtrl"
  }
}
SoldierSandtableOtherCharItemCtrl._mapEventConfig = {
  SoldierSandtableOtherCharItemDragStart = "OnSoldierSandtableOtherCharItemDragStart",
  SoldierSandtableOtherCharItemDragEnd = "OnSoldierSandtableOtherCharItemDragEnd"
}
SoldierSandtableOtherCharItemCtrl._mapRedDotConfig = {}

function SoldierSandtableOtherCharItemCtrl:Awake()
  self.otherChessData = nil
  self.itemCtrl = nil
end

function SoldierSandtableOtherCharItemCtrl:OnDisable()
  if self.itemCtrl ~= nil then
    self:UnbindCtrlByNode(self.itemCtrl)
    self.itemCtrl = nil
  end
end

function SoldierSandtableOtherCharItemCtrl:SetData(otherChessData, nIndex)
  if otherChessData == nil or otherChessData.nId == 0 then
    self.gameObject:SetActive(false)
    return
  end
  self.gameObject:SetActive(true)
  self.levelData = PlayerData.SoldierData:GetCurLevelData()
  self.otherChessData = otherChessData
  self.nIndex = nIndex
  self._mapNode.trSortItem.localPosition = Vector3(0, 0, 0)
  self._mapNode.charCtrl:SetItemData(self.otherChessData.nId)
  self._mapNode.charCtrl:SetCharLevel(self.otherChessData.nStar or 1)
  if self.itemCanvas == nil then
    self.itemCanvas = self.gameObject:GetComponent("Canvas")
  end
  NovaAPI.SetCanvasOverrideSorting(self.itemCanvas, false)
  self._mapNode.rayDragEvent.gameObject:SetActive(false)
end

function SoldierSandtableOtherCharItemCtrl:GetItemBtnInstanceId()
  return self._mapNode.rayDragEvent.gameObject:GetInstanceID()
end

function SoldierSandtableOtherCharItemCtrl:SetAnimator()
end

function SoldierSandtableOtherCharItemCtrl:SetItemPos(dragPos)
  local localPos = GameUIUtils.ScreenPointToLocalPoint(dragPos, self.gameObject.transform)
  self._mapNode.trSortItem.localPosition = Vector3(localPos.x, localPos.y, 0)
end

function SoldierSandtableOtherCharItemCtrl:InitSortingOrder(nSortOrder)
  self.nInitSortingOrder = nSortOrder
  if self.itemCanvas == nil then
    self.itemCanvas = self.gameObject:GetComponent("Canvas")
  end
  NovaAPI.SetCanvasSortingOrder(self.itemCanvas, self.nInitSortingOrder)
  NovaAPI.SetCanvasOverrideSorting(self.itemCanvas, false)
end

function SoldierSandtableOtherCharItemCtrl:CheckLimitAction()
  return self.levelData:CheckSandTableDisable()
end

function SoldierSandtableOtherCharItemCtrl:OnUIDrag_Drag(mDrag)
  if self:CheckLimitAction() then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Soldier_Sandtable_TemporaryReturn_Tips"))
    return
  end
  if self.otherChessData.nId <= 0 then
    return
  end
  if mDrag.DragEventType == AllEnum.UIDragType.DragStart then
    self.nLastPointerInsId = nil
    self:SetItemPos(mDrag.EventData.position)
    self._mapNode.raySortItem.enabled = false
    self._mapNode.rayDragEvent.enabled = false
    self._mapNode.btn_char.gameObject:SetActive(false)
    EventManager.Hit("SoldierSandtableOtherCharItemDragStart", self:GetItemBtnInstanceId(), self.otherChessData, self.nIndex)
  elseif mDrag.DragEventType == AllEnum.UIDragType.Drag then
    self:SetItemPos(mDrag.EventData.position)
  elseif mDrag.DragEventType == AllEnum.UIDragType.DragEnd then
    local pointerObj = mDrag.EventData.pointerCurrentRaycast
    if nil ~= pointerObj and nil ~= pointerObj.gameObject then
      local nPointerInsId = pointerObj.gameObject:GetInstanceID()
      if nPointerInsId ~= self.nLastPointerInsId then
        self.nLastPointerInsId = nPointerInsId
        EventManager.Hit("SoldierSandtableOtherCharItemDragEnd", self.otherChessData, nPointerInsId)
      else
        EventManager.Hit("SoldierSandtableOtherCharItemDragEnd", self.otherChessData, nPointerInsId)
      end
    else
      EventManager.Hit("SoldierSandtableOtherCharItemDragEnd", self.otherChessData, 0)
    end
    NovaAPI.SetCanvasOverrideSorting(self.itemCanvas, false)
    NovaAPI.SetCanvasSortingOrder(self.itemCanvas, self.nInitSortingOrder)
    self._mapNode.raySortItem.enabled = true
    self._mapNode.rayDragEvent.enabled = true
    self._mapNode.btn_char.gameObject:SetActive(true)
  end
end

function SoldierSandtableOtherCharItemCtrl:OnSoldierSandtableOtherCharItemDragStart(objInsId)
  self._mapNode.rayDragEvent.gameObject:SetActive(true)
  NovaAPI.SetCanvasOverrideSorting(self.itemCanvas, true)
  NovaAPI.SetCanvasSortingName(self.itemCanvas, AllEnum.SortingLayerName.UI)
  if self:GetItemBtnInstanceId() ~= objInsId then
    NovaAPI.SetCanvasSortingOrder(self.itemCanvas, self.nInitSortingOrder + 1)
  else
    NovaAPI.SetCanvasSortingOrder(self.itemCanvas, self.nInitSortingOrder + 2)
  end
end

function SoldierSandtableOtherCharItemCtrl:OnSoldierSandtableOtherCharItemDragEnd()
  NovaAPI.SetCanvasSortingOrder(self.itemCanvas, self.nInitSortingOrder + 1)
  self._mapNode.rayDragEvent.gameObject:SetActive(false)
end

function SoldierSandtableOtherCharItemCtrl:OnBtnClick_Char()
  if self.otherChessData.nId <= 0 then
    return
  end
  local chessData = {
    nId = self.otherChessData.nId,
    nStar = self.otherChessData.nStar,
    nPositionType = AllEnum.SoldierPositionType.Other
  }
  EventManager.Hit(EventId.OpenPanel, PanelId.SoldierCharCardTips, self.gameObject.transform, chessData)
end

return SoldierSandtableOtherCharItemCtrl
