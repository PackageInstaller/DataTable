require("s_maze_map_room_base")
_class("SMazeMapRoom_Camp", SMazeMapRoomBase)
SMazeMapRoom_Camp = SMazeMapRoom_Camp

function SMazeMapRoom_Camp:OnTrigger()
  self:BindEvent(GameEventType.OnSeasonMazeRoomOperationFinish, self.OnTriggerComplete)
  self:ShowDialog("UISeasonMazeRoom_Campsites", self:NodeID())
end

function SMazeMapRoom_Camp:OnTriggerComplete()
  self:UnBindEvent(GameEventType.OnSeasonMazeRoomOperationFinish)
  self:Finish()
end
