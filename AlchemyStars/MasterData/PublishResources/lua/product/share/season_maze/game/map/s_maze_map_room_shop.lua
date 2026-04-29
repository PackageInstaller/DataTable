require("s_maze_map_room_base")
_class("SMazeMapRoom_Shop", SMazeMapRoomBase)
SMazeMapRoom_Shop = SMazeMapRoom_Shop

function SMazeMapRoom_Shop:OnTrigger()
  self:BindEvent(GameEventType.OnSeasonMazeRoomOperationFinish, self.OnTriggerComplete)
  self:ShowDialog("UISeasonMazeRoomShop", self:NodeID())
end

function SMazeMapRoom_Shop:OnTriggerComplete(asstes)
  if not asstes or 0 < #asstes then
  end
  self:UnBindEvent(GameEventType.OnSeasonMazeRoomOperationFinish)
  self:Finish()
end
