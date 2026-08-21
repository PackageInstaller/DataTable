require("s_maze_map_room_base")
_class("SMazeMapRoom_DirectionalRecruit", SMazeMapRoomBase)
SMazeMapRoom_DirectionalRecruit = SMazeMapRoom_DirectionalRecruit

function SMazeMapRoom_DirectionalRecruit:OnTrigger()
  self:BindEvent(GameEventType.OnSeasonMazeRoomOperationFinish, self.OnTriggerComplete)
  self:ShowDialog("UISeasonMazeRoom_DirectionalRecruit", self:NodeID())
end

function SMazeMapRoom_DirectionalRecruit:OnTriggerComplete(petID)
  if not petID or 0 < petID then
  end
  self:UnBindEvent(GameEventType.OnSeasonMazeRoomOperationFinish)
  self:Finish()
end
