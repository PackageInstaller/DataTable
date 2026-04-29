require("s_maze_map_room_base")
_class("SMazeMapRoom_Altar", SMazeMapRoomBase)
SMazeMapRoom_Altar = SMazeMapRoom_Altar

function SMazeMapRoom_Altar:Constructor()
end

function SMazeMapRoom_Altar:OnTrigger()
  self:BindEvent(GameEventType.OnSeasonMazeRoomOperationFinish, self.OnTriggerComplete)
  self:ShowDialog("UISeasonMazeRoom_Altar", self:NodeID())
end

function SMazeMapRoom_Altar:OnTriggerComplete()
  self:UnBindEvent(GameEventType.OnSeasonMazeRoomOperationFinish)
  self:Finish()
end
