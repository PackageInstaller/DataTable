require("s_maze_map_room_base")
_class("SMazeMapRoom_Empty", SMazeMapRoomBase)
SMazeMapRoom_Empty = SMazeMapRoom_Empty

function SMazeMapRoom_Empty:Constructor()
end

function SMazeMapRoom_Empty:OnTrigger()
  self:BindEvent(GameEventType.OnSeasonMazeRoomOperationFinish, self.OnTriggerComplete)
  self:ShowDialog("UISeasonMazeRoomEmpty", self:NodeID())
end

function SMazeMapRoom_Empty:OnTriggerComplete()
  self:UnBindEvent(GameEventType.OnSeasonMazeRoomOperationFinish)
  self:Finish()
end
