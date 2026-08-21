require("s_maze_map_room_base")
_class("SMazeMapRoom_Ore", SMazeMapRoomBase)
SMazeMapRoom_Ore = SMazeMapRoom_Ore

function SMazeMapRoom_Ore:Constructor()
end

function SMazeMapRoom_Ore:OnTrigger()
  self:BindEvent(GameEventType.OnSeasonMazeRoomOperationFinish, self.OnTriggerComplete)
  self:ShowDialog("UISeasonMazeRoomMining", self:NodeID())
end

function SMazeMapRoom_Ore:OnTriggerComplete(efts)
  self:UnBindEvent(GameEventType.OnSeasonMazeRoomOperationFinish)
  local assets = SeasonMazeTool:GetInstance():Efts2Assets(efts)
  local log = {
    "派遣房奖励:"
  }
  for _, asset in ipairs(assets) do
    table.insert(log, asset:Name())
    table.insert(log, "+" .. asset:Count())
    table.insert(log, ",")
  end
  Log.info(table.concat(log))
  self:SetAwardAssets(assets)
  self:Finish()
end
