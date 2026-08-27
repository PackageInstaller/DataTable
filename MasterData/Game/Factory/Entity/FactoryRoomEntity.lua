local FactoryRoomEntity = class("FactoryRoomEntity")
local CS_EventTriggerListener = CS.EventTriggerListener
local CS_GameObject = CS.UnityEngine.GameObject
local FactoryEnum = require("Game.Factory.FactoryEnum")

function FactoryRoomEntity:ctor()
  self.factoryController = ControllerManager:GetController(ControllerTypeId.Factory, false)
  self.type = nil
  self.__onRoomClicked = BindCallback(self, self.OnRoomClicked)
end

function FactoryRoomEntity:InitRoomObject(object, clickAction, type, index, unlcokDes)
  object:SetActive(true)
  self.gameObject = object
  self.transform = object.transform
  self.clickAction = clickAction
  self.type = type
  self.index = index
  self.unlcokDes = unlcokDes
  local eventTrigger = CS_EventTriggerListener.Get(self.gameObject)
  eventTrigger:onClick("+", self.__onRoomClicked)
  self:GenRoomInfo()
end

function FactoryRoomEntity:ChangeRoomModelGo(object, type)
  if type == self.type then
    return
  end
  local oldType = self.type
  self.gameObject:SetActive(false)
  local eventTrigger = CS_EventTriggerListener.Get(self.gameObject)
  eventTrigger:onClick("-", self.__onRoomClicked)
  object:SetActive(true)
  self.gameObject = object
  self.transform = object.transform
  self.type = type
  local eventTrigger = CS_EventTriggerListener.Get(self.gameObject)
  eventTrigger:onClick("+", self.__onRoomClicked)
  self:GenRoomInfo()
end

function FactoryRoomEntity:GenRoomInfo()
  self.uiRoomInfo = self.factoryController.ui3DCanvas:GenRoomInfo(self.index, self.transform, self.type, self.unlcokDes)
  self.factoryController.ui3DCanvas:SetRoomInfoSate(self.index, self.type)
end

function FactoryRoomEntity:SetSelected(bool)
  self.uiRoomInfo:SetRoomSeleced(bool)
end

function FactoryRoomEntity:OnRoomClicked(go, eventData)
  if self.clickAction ~= nil then
    self.clickAction(self)
  end
end

function FactoryRoomEntity:OnDelete()
end

return FactoryRoomEntity
