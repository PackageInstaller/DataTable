local TowerDefenseSelectedCharCtrl = class("TowerDefenseSelectedCharCtrl", BaseCtrl)
TowerDefenseSelectedCharCtrl._mapNodeConfig = {
  drag = {
    sNodeName = "go_char",
    sComponentName = "UIDrag",
    callback = "OnUIDrag_Drag"
  },
  trSortItem = {
    sNodeName = "go_char",
    sComponentName = "RectTransform"
  },
  raySortItem = {
    sNodeName = "go_char",
    sComponentName = "Empty4Raycast"
  },
  rayDragEvent = {
    sNodeName = "rayDragEvent",
    sComponentName = "Empty4Raycast"
  },
  btn_add = {
    sNodeName = "img_add",
    sComponentName = "UIButton",
    callback = "OnBtnClick_EditorTeam"
  },
  img_icon = {},
  icon_char = {sComponentName = "Image"},
  txt_name = {sComponentName = "TMP_Text"},
  img_add = {},
  img_none = {}
}
TowerDefenseSelectedCharCtrl._mapEventConfig = {
  TowerDefenseItemDragStart = "OnTowerDefenseItemDragStart",
  TowerDefenseItemDragEnd = "OnTowerDefenseItemDragEnd"
}
TowerDefenseSelectedCharCtrl._mapRedDotConfig = {}
local item_Width = 198
local item_spacing = 8.6

function TowerDefenseSelectedCharCtrl:Awake()
  self.tweener = nil
  self.nGuideId = 0
  self.bCanChange = true
  self.nItemHeight = self.gameObject:GetComponent("RectTransform").rect.height
  self.nItemWidth = self.gameObject:GetComponent("RectTransform").rect.width
end

function TowerDefenseSelectedCharCtrl:OnEnable()
end

function TowerDefenseSelectedCharCtrl:OnDisable()
end

function TowerDefenseSelectedCharCtrl:OnDestroy()
end

function TowerDefenseSelectedCharCtrl:SetData(guideId, bCanChange, nIndex)
  self.nGuideId = guideId
  self.bCanChange = bCanChange
  self.nIndex = nIndex
  self._mapNode.btn_add.interactable = bCanChange
  self._mapNode.drag:SetDragEnable(bCanChange and self.nGuideId > 0)
  self._mapNode.img_none.gameObject:SetActive(self.nGuideId == -1)
  self._mapNode.img_add.gameObject:SetActive(self.nGuideId == 0)
  self._mapNode.img_icon.gameObject:SetActive(self.nGuideId > 0)
  if self.nGuideId > 0 then
    local guideConfig = ConfigTable.GetData("TowerDefenseGuide", self.nGuideId)
    local characterConfig = ConfigTable.GetData("TowerDefenseCharacter", guideConfig.ObjectId)
    if characterConfig ~= nil then
      self:SetPngSprite(self._mapNode.icon_char, characterConfig.Icon .. AllEnum.CharHeadIconSurfix.QM)
      NovaAPI.SetTMPText(self._mapNode.txt_name, characterConfig.Name)
    end
  end
  if nil ~= self.tweener then
    self.tweener:Kill()
    self.tweener = nil
  end
  self._mapNode.trSortItem.localPosition = Vector3(0, 0, 0)
  self.itemCanvas = self.gameObject:GetComponent("Canvas")
  NovaAPI.SetCanvasOverrideSorting(self.itemCanvas, false)
  self._mapNode.rayDragEvent.gameObject:SetActive(false)
end

local function clamp(x, min, max)
  return math.max(math.min(x, max), min)
end

function TowerDefenseSelectedCharCtrl:InitSortingOrder(nSortOrder, goDragMin, goDragMax)
  self.nInitSortingOrder = nSortOrder
  self.goDragMin = goDragMin
  self.goDragMax = goDragMax
end

function TowerDefenseSelectedCharCtrl:GetItemBtnInstanceId()
  return self._mapNode.rayDragEvent.gameObject:GetInstanceID()
end

function TowerDefenseSelectedCharCtrl:PlayItemMoveAnim(nIndex)
  local nEndPosX = (self.nItemWidth + item_spacing) * (nIndex - self.nIndex)
  local endPos = Vector2(nEndPosX, 0)
  self.tweener = self._mapNode.trSortItem:DOAnchorPos(endPos, 0.1):SetUpdate(true)
end

function TowerDefenseSelectedCharCtrl:SetItemPos(dragPos)
  local localPos = GameUIUtils.ScreenPointToLocalPoint(dragPos, self.gameObject.transform)
  localPos.x = clamp(localPos.x, self.nDragMinPosX, self.nDragMaxPosX)
  self._mapNode.trSortItem.localPosition = Vector3(localPos.x, self.nItemHeight * 0.25, 0)
end

function TowerDefenseSelectedCharCtrl:CalDragRange()
  if nil == self.nDragMinPosX or nil == self.nDragMaxPosX then
    local transform = self.gameObject:GetComponent("Transform")
    self.nDragMinPosX = transform:InverseTransformPoint(self.goDragMin.position).x + item_Width / 2
    self.nDragMaxPosX = transform:InverseTransformPoint(self.goDragMax.position).x - item_Width / 2
  end
end

function TowerDefenseSelectedCharCtrl:OnUIDrag_Drag(mDrag)
  if self.nGuideId <= 0 then
    return
  end
  if mDrag.DragEventType == AllEnum.UIDragType.DragStart then
    self.nLastPointerInsId = nil
    self:CalDragRange()
    self:SetItemPos(mDrag.EventData.position)
    self._mapNode.raySortItem.enabled = false
    self._mapNode.rayDragEvent.enabled = false
    EventManager.Hit("TowerDefenseItemDragStart", self.gameObject:GetInstanceID())
  elseif mDrag.DragEventType == AllEnum.UIDragType.Drag then
    self:SetItemPos(mDrag.EventData.position)
    local pointerObj = mDrag.EventData.pointerCurrentRaycast
    if nil ~= pointerObj and nil ~= pointerObj.gameObject then
      local nPointerInsId = pointerObj.gameObject:GetInstanceID()
      if nPointerInsId ~= self.nLastPointerInsId then
        self.nLastPointerInsId = nPointerInsId
        EventManager.Hit("TowerDefenseItemDragging", self:GetItemBtnInstanceId(), nPointerInsId)
      end
    end
  elseif mDrag.DragEventType == AllEnum.UIDragType.DragEnd then
    EventManager.Hit("TowerDefenseItemDragEnd")
    NovaAPI.SetCanvasOverrideSorting(self.itemCanvas, false)
    NovaAPI.SetCanvasSortingOrder(self.itemCanvas, self.nInitSortingOrder)
    self._mapNode.raySortItem.enabled = true
    self._mapNode.rayDragEvent.enabled = true
  end
end

function TowerDefenseSelectedCharCtrl:OnBtnClick_EditorTeam()
  EventManager.Hit("TowerDefense_EditorTeam")
end

function TowerDefenseSelectedCharCtrl:OnTowerDefenseItemDragStart(objInsId)
  self._mapNode.rayDragEvent.gameObject:SetActive(true)
  NovaAPI.SetCanvasOverrideSorting(self.itemCanvas, true)
  NovaAPI.SetCanvasSortingName(self.itemCanvas, AllEnum.SortingLayerName.UI)
  if self.gameObject:GetInstanceID() ~= objInsId then
    NovaAPI.SetCanvasSortingOrder(self.itemCanvas, self.nInitSortingOrder + 1)
  else
    NovaAPI.SetCanvasSortingOrder(self.itemCanvas, self.nInitSortingOrder + 2)
  end
end

function TowerDefenseSelectedCharCtrl:OnTowerDefenseItemDragEnd()
  NovaAPI.SetCanvasSortingOrder(self.itemCanvas, self.nInitSortingOrder + 1)
  self._mapNode.rayDragEvent.gameObject:SetActive(false)
end

return TowerDefenseSelectedCharCtrl
