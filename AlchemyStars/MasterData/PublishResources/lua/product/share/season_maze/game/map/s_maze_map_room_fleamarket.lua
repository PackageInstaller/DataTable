require("s_maze_map_room_base")
_class("SMazeMapRoom_FleaMarket", SMazeMapRoomBase)
SMazeMapRoom_FleaMarket = SMazeMapRoom_FleaMarket

function SMazeMapRoom_FleaMarket:Constructor()
end

function SMazeMapRoom_FleaMarket:OnTrigger()
  self:BindEvent(GameEventType.OnSeasonMazeRoomOperationFinish, self.OnTriggerComplete)
  self:ShowDialog("UISeasonMazeRoomFlea", self:NodeID())
end

function SMazeMapRoom_FleaMarket:OnTriggerComplete()
  self:UnBindEvent(GameEventType.OnSeasonMazeRoomOperationFinish)
  self:Finish()
end
