require("s_maze_map_room_base")
_class("SMazeMapRoom_RandomEvent", SMazeMapRoomBase)
SMazeMapRoom_RandomEvent = SMazeMapRoom_RandomEvent

function SMazeMapRoom_RandomEvent:Constructor()
end

function SMazeMapRoom_RandomEvent:OnTrigger()
  self:BindEvent(GameEventType.OnSeasonMazeRoomOperationFinish, self.OnTriggerComplete)
  self:ShowDialog("UISeasonMazeRoomRandomEvent", self:NodeID())
end

function SMazeMapRoom_RandomEvent:OnTriggerComplete(efts)
  self:UnBindEvent(GameEventType.OnSeasonMazeRoomOperationFinish)
  local assets = SeasonMazeTool:GetInstance():Efts2Assets(efts)
  local log = {
    "随机事件房奖励:"
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
