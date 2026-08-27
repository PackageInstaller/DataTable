local UINDormRoomState = class("UINDormRoomState", UIBaseNode)
local base = UIBaseNode
local UINDormRoomStateItem = require("Game.Dorm.DUI.RoomState.UINDormRoomStateItem")
local DormUtil = require("Game.Dorm.DormUtil")

function UINDormRoomState:ctor(dormMain)
  self.dormMain = dormMain
end

function UINDormRoomState:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.ui.stateIItem:SetActive(false)
  self.stateItemPool = UIItemPool.New(UINDormRoomStateItem, self.ui.stateIItem)
end

function UINDormRoomState:InitDormRoomState()
  local dormCtrl = ControllerManager:GetController(ControllerTypeId.Dorm, false)
  local lockStrDic = dormCtrl.houseCtrl:GetLockRoomDic()
  self.stateItemPool:HideAll()
  for _, data in pairs(lockStrDic) do
    local posx, posy = UIManager:World2UIPositionOut(data.roomEntity.transform)
    local anchorPos = Vector2.New(posx, posy)
    local stateItem = self.stateItemPool:GetOne()
    stateItem:InitDmRoomStateItem(anchorPos)
  end
end

function UINDormRoomState:OnDelete()
  self.stateItemPool:DeleteAll()
  base.OnDelete(self)
end

return UINDormRoomState
