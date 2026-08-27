local DormCtrlBase = class("ExplorationCtrlBase")

function DormCtrlBase:ctor(dormCtrl)
  self.dormCtrl = dormCtrl
  table.insert(self.dormCtrl.ctrls, self)
end

function DormCtrlBase:OnEnterDormScene()
end

function DormCtrlBase:OnEnterDormHouse()
end

function DormCtrlBase:OnEnterDormHouseEditMode()
end

function DormCtrlBase:OnExitDormHouseEditMode(success)
end

function DormCtrlBase:OnEnterDormRoomEditMode(roomEntity)
end

function DormCtrlBase:OnExitDormRoomEditMode(roomEntity, success)
end

function DormCtrlBase:OnEnterDormRoomStart(roomEntity)
end

function DormCtrlBase:OnEnterDormRoomEnd(roomEntity)
end

function DormCtrlBase:OnExitDormRoomStart(roomEntity)
end

function DormCtrlBase:OnExitDormRoomEnd()
end

function DormCtrlBase:GetDormState()
  return self.dormCtrl.state
end

function DormCtrlBase:OnDelete()
end

return DormCtrlBase
