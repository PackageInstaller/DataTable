require("s_maze_map_room_base")
_class("SMazeMapRoom_RoundBonus", SMazeMapRoomBase)
SMazeMapRoom_RoundBonus = SMazeMapRoom_RoundBonus

function SMazeMapRoom_RoundBonus:Constructor()
end

function SMazeMapRoom_RoundBonus:OnTrigger()
  self:BindEvent(GameEventType.OnSeasonMazeRoomOperationFinish, self.OnTriggerComplete)
  self:ShowDialog("UISeasonMazeRoomRound", self:NodeID())
end

function SMazeMapRoom_RoundBonus:OnTriggerComplete(count)
  self:UnBindEvent(GameEventType.OnSeasonMazeRoomOperationFinish)
  self:Finish()
end
