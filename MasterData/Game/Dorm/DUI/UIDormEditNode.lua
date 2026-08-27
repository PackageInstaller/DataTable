local UIDormEditNode = class("UIDormEditNode", UIBaseNode)
local base = UIBaseNode
local JumpManager = require("Game.Jump.JumpManager")
local ShopEnum = require("Game.Shop.ShopEnum")

function UIDormEditNode:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Name, self, self.OnRoomRenameClicked)
  UIUtil.AddButtonListener(self.ui.btn_DressUp, self, self.OnDressUpClicked)
  self.ui.selectCanvas:SetActive(false)
  self:__InitEditRoomDragUI()
end

function UIDormEditNode:__InitEditRoomDragUI()
  local cs_EventTrigger = CS.EventTriggerListener
  local eventTrigger = cs_EventTrigger.Get(self.ui.btn_Drop)
  self.__OnRoomDragStart = BindCallback(self, self.OnRoomDragStart)
  self.__OnRoomDragging = BindCallback(self, self.OnRoomDragging)
  self.__OnRoomDragEnd = BindCallback(self, self.OnRoomDragEnd)
  eventTrigger:onBeginDrag("+", self.__OnRoomDragStart)
  eventTrigger:onDrag("+", self.__OnRoomDragging)
  eventTrigger:onEndDrag("+", self.__OnRoomDragEnd)
end

function UIDormEditNode:SelectEditRoom(houseCtrl, roomEntity)
  if roomEntity == nil then
    return
  end
  self.__centerPos = roomEntity:GetDormRoomCenterPos()
  self.ui.roomControl.localPosition = self.__centerPos
  self.ui.tex_Name.text = roomEntity.roomData:GetName()
  self.ui.selectCanvas:SetActive(true)
  self.ui.roomMove:SetActive(false)
  self.ui.img_Drop.gameObject:SetActive(not houseCtrl.curHouse:IsOnlyOneRoom())
  self.__selectRoomEntity = roomEntity
  AudioManager:PlayAudioById(1122)
end

function UIDormEditNode:BindRoomMoveAction(selectStartAction, selectDragAction, selectEndAction)
  self.__selectStartAction = selectStartAction
  self.__selectEndAction = selectEndAction
  self.__selectDragAction = selectDragAction
end

function UIDormEditNode:UnSelectEditRoom()
  self.ui.selectCanvas:SetActive(false)
  self.__selectEndAction = nil
  self.__selectRoomEntity = nil
  self:ResetMoveRoomUI()
end

function UIDormEditNode:ResetMoveRoomUI()
  self.ui.img_Drop.localPosition = Vector3.zero
  self.ui.roomMove:SetActive(false)
  self.ui.changeNode:SetActive(true)
end

function UIDormEditNode:OnHide()
  self:UnSelectEditRoom()
  base.OnHide(self)
end

function UIDormEditNode:OnRoomDragStart(go, eventData)
  self.ui.changeNode:SetActive(false)
  self.ui.roomMove:SetActive(true)
  if self.__selectStartAction ~= nil then
    self.__selectStartAction()
  end
end

function UIDormEditNode:OnRoomDragging(go, eventData)
  local obj = eventData.pointerEnter
  local uiPos = UIManager:Screen2UIPosition(eventData.position)
  self.ui.img_Drop.localPosition = Vector3.New(uiPos.x, uiPos.y, 0) - self.__centerPos
  if self.__selectDragAction ~= nil then
    self.__selectDragAction(obj)
  end
end

function UIDormEditNode:OnRoomDragEnd(go, eventData)
  local obj = eventData.pointerEnter
  if self.__selectEndAction ~= nil then
    self.__selectEndAction(obj)
  end
end

function UIDormEditNode:OnRoomRenameClicked()
  if CloseCustomBename then
    CS.MessageCommon.ShowMessageTips(ConfigData:GetTipContent(393))
    return
  end
  local dormCtrl = ControllerManager:GetController(ControllerTypeId.Dorm)
  dormCtrl.houseCtrl:RequestCurRoomRename(function()
    if self.__selectRoomEntity ~= nil then
      self.ui.tex_Name.text = self.__selectRoomEntity.roomData:GetName()
    end
  end)
end

function UIDormEditNode:OnDressUpClicked()
  local roomEntity = self.__selectRoomEntity
  if roomEntity == nil then
    return
  end
  UIUtil.OnClickBackByWinId(UIWindowTypeID.DormMain)
  local dormCtrl = ControllerManager:GetController(ControllerTypeId.Dorm)
  dormCtrl.houseCtrl:OnHouseClicked(roomEntity, true)
end

function UIDormEditNode:OnDelete()
  base.OnDelete(self)
end

return UIDormEditNode
