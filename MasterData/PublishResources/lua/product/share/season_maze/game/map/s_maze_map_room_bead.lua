require("s_maze_map_room_base")
_class("SMazeMapRoom_Bead", SMazeMapRoomBase)
SMazeMapRoom_Bead = SMazeMapRoom_Bead

function SMazeMapRoom_Bead:OnTrigger()
  self:BindEvent(GameEventType.OnSeasonMazeRoomOperationFinish, self.OnTriggerComplete)
  self:ShowDialog("UISeasonMazeRoomBead", self:NodeID())
end

function SMazeMapRoom_Bead:OnTriggerComplete(asstes)
  if not asstes or 0 < #asstes then
  end
  self:UnBindEvent(GameEventType.OnSeasonMazeRoomOperationFinish)
  self:Finish()
end
