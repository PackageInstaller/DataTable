require("s_maze_map_room_base")
_class("SMazeMapRoom_Battle", SMazeMapRoomBase)
SMazeMapRoom_Battle = SMazeMapRoom_Battle

function SMazeMapRoom_Battle:Constructor()
end

function SMazeMapRoom_Battle:IsDestroyedByBomb()
  return self._type == SeasonMazeRoomType.SMRT_Empty and self._srcType == SeasonMazeRoomType.SMRT_PVE
end

function SMazeMapRoom_Battle:Boom(svrData)
  if self._type == SeasonMazeRoomType.SMRT_PVE and svrData.type == SeasonMazeRoomType.SMRT_PVE and svrData.is_bomb then
    self._type = SeasonMazeRoomType.SMRT_Empty
    self._srcType = SeasonMazeRoomType.SMRT_PVE
    self._destroyed = true
    Log.info("使用炸弹后战斗房改为空白房:", self._id)
    self._req:Dispose()
    self:_LoadModel(SeasonMazeRoomType.SMRT_Empty)
    self:Anim_Init(SMazeNodeState.Reachable)
  end
end

function SMazeMapRoom_Battle:OnTrigger()
  self:BindEvent(GameEventType.OnSeasonMazeRoomOperationFinish, self.OnTriggerComplete)
  if self:IsDestroyedByBomb() then
    self:ShowDialog("UISeasonMazeRoomEmpty", self:NodeID())
  else
    self:ShowDialog("UISeasonMazeRoomStage", self:NodeID())
  end
end

function SMazeMapRoom_Battle:OnTriggerComplete(autoFightReward)
  self:UnBindEvent(GameEventType.OnSeasonMazeRoomOperationFinish)
  local autoFightReward = SeasonMazeTool:GetInstance():Efts2Assets(autoFightReward)
  self:SetAwardAssets(autoFightReward)
  self:Finish()
end
