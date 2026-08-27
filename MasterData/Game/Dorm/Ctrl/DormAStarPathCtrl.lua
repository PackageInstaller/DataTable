local DormCtrlBase = require("Game.Dorm.Ctrl.DormCtrlBase")
local DormAStarPathCtrl = class("DormAStarPathCtrl", DormCtrlBase)
local BoundSpaceSize = 0.4

function DormAStarPathCtrl:ctor(dormCtrl)
end

function DormAStarPathCtrl:OnEnterDormRoomEnd(roomEntity)
  local roomData = roomEntity.roomData
  local gridLength = roomData:GetRoomGridLengthCount()
  local gridHeight = roomData:GetRoomGridHeightCount()
  local sizeLen = gridLength * ConfigData.game_config.HouseGridWidth - BoundSpaceSize
  local sizeHeight = gridHeight * ConfigData.game_config.HouseGridWidth - BoundSpaceSize
  local pos = roomEntity.transform.position
  pos.y = pos.y + sizeHeight / 2
  local graph = CS.AstarPath.active.data.recastGraph
  graph.forcedBoundsCenter = pos
  graph.forcedBoundsSize = Vector3.New(sizeLen, sizeHeight, sizeLen)
  graph:Scan()
end

function DormAStarPathCtrl:OnExitDormRoomStart(roomEntity)
end

function DormAStarPathCtrl:OnEnterDormRoomEditMode(roomEntity)
end

function DormAStarPathCtrl:OnExitDormRoomEditMode(roomEntity, success)
  if not success then
    return
  end
  CS.AstarPath.active:Scan()
end

return DormAStarPathCtrl
