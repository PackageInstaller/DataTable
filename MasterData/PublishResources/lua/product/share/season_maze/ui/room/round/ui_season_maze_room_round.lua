_class("UISeasonMazeRoomRound", UISeasonMazeRoomBase)
UISeasonMazeRoomRound = UISeasonMazeRoomRound

function UISeasonMazeRoomRound:LoadDataOnEnter(TT, res)
  res:SetSucc(true)
end

function UISeasonMazeRoomRound:OnShowUI(uiParams)
  self:Lock("UISeasonMazeRoomRound")
  self:StartTask(function(TT)
    local res = AsyncRequestRes:New()
    local result = self._component:HandleSeasonMazeRound(TT, res)
    self:UnLock("UISeasonMazeRoomRound")
    if not res:GetSucc() then
      Log.error("回合奖励房间UI结算失败:", res:GetResult())
      if GameGlobal.GetModule(SeasonMazeModule):CheckSeasonMazeClose(res) then
        return
      end
      return
    end
    self._round = 0
    local reward = result.reward[1]
    self._round = reward.value_min
    self:ShowDialog("UISeasonMazeRoomPopBox", SeasonMazeRoomType.SMRT_Round, function()
      self:OnHideUI(self._round)
    end, reward)
  end, self)
end
