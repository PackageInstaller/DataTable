require("ui_season_maze_room_base")
_class("UISeasonMazeRoomResources", UISeasonMazeRoomBase)
UISeasonMazeRoomResources = UISeasonMazeRoomResources

function UISeasonMazeRoomResources:LoadDataOnEnter(TT, res)
  res:SetSucc(true)
end

function UISeasonMazeRoomResources:OnShowUI(uiParams)
  self:AttachEvent(GameEventType.OnSeasonMazeShowRewardsFinish, self.OnSeasonMazeShowRewardsFinish)
  self:ReqFinishRoom()
end

function UISeasonMazeRoomResources:ReqFinishRoom()
  GameGlobal.TaskManager():StartTask(self.OnReqFinishRoom, self)
end

function UISeasonMazeRoomResources:OnReqFinishRoom(TT)
  local res = AsyncRequestRes:New()
  self:Lock("UISeasonMazeRoomResources:ReqFinishRoom")
  self._response = self._component:HandleSeasonMazeResource(TT, res)
  self:UnLock("UISeasonMazeRoomResources:ReqFinishRoom")
  if res and res:GetSucc() then
    if self._response then
      local rewards = self._response.reward
      local reward = SeasonMazeEffect:New()
      reward.type = rewards[1].type
      reward.id = rewards[1].id
      reward.value_min = 0
      reward.value_max = 0
      for _, eft in ipairs(rewards) do
        if eft.type ~= reward.type then
          Log.exception("宝箱房奖励类型错误 无法显示:", echo(rewards))
        end
        reward.value_min = reward.value_min + eft.value_min
      end
      local asset = SeasonMazeTool:GetInstance():Effect2Asset(reward, reward.value_min)
      self._asset = asset
      if reward.type == SeasonMazeEffectType.SMET_Bead then
        local showRewards = rewards
        
        function self._waitGetRewardsFinishCb()
          self:CloseBtnOnClick()
        end
        
        SeasonMazeTool:GetInstance():ShowUIGetRewards(showRewards)
      else
        self._roomInfo = self._component:GetComponentInfo().rooms[self._nodeID]
        self:ShowDialog("UISeasonMazeRoomPopBox", SeasonMazeRoomType.SMRT_Resource, function()
          self:CloseBtnOnClick()
        end, reward)
      end
    end
  else
    local result = res:GetResult()
    Log.error("###[UISeasonMazeRoomResources] HandleSeasonMazeResource fail ! result : ", result)
    if GameGlobal.GetModule(SeasonMazeModule):CheckSeasonMazeClose(res) then
      return
    end
  end
end

function UISeasonMazeRoomResources:CloseBtnOnClick(go)
  local params
  if self._response then
    params = self._response.reward
  end
  self:OnHideUI(self._asset)
end

function UISeasonMazeRoomResources:OnSeasonMazeShowRewardsFinish(flag)
  if self._waitGetRewardsFinishCb then
    self._waitGetRewardsFinishCb()
    self._waitGetRewardsFinishCb = nil
  end
end
