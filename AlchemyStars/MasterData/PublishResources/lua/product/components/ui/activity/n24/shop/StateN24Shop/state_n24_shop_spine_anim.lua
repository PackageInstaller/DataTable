_class("StateN24ShopSpineAnim", StateN24ShopBase)
StateN24ShopSpineAnim = StateN24ShopSpineAnim

function StateN24ShopSpineAnim:OnEnter(TT, ...)
  self:Init()
  self:ShowHideSpineSkip(true)
  self:SetSpineSkipClickCallback(function()
    self:ChangeState(StateN24Shop.SpineAnim2)
  end)
  local lotteryType = table.unpack({
    ...
  })
  self:PlaySpineAnim(TT, lotteryType)
end

function StateN24ShopSpineAnim:OnExit(TT)
  self:ShowHideSpineSkip(false)
  if self.taskId then
    GameGlobal.TaskManager():KillTask(self.taskId)
  end
  if self._playAudioTask then
    GameGlobal.TaskManager():KillTask(self._playAudioTask)
    self._playAudioTask = nil
  end
end

function StateN24ShopSpineAnim:PlaySpineAnim(TT, lotteryType)
  local curPageIndex = self:CurPageIndex()
  local spineAnim
  if lotteryType == ECampaignLotteryType.E_CLT_SINGLE then
    spineAnim = curPageIndex .. "_1"
  else
    spineAnim = curPageIndex .. "_3"
  end
  self._playAudioTask = GameGlobal.TaskManager():StartTask(function(TT)
    YIELD(TT, 1000)
    AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.N24Lottery)
  end, self)
  local yieldTime = self:PlaySpineAnimation(spineAnim, false)
  if yieldTime and 0 < yieldTime then
    self.taskId = GameGlobal.TaskManager():StartTask(function(TT)
      YIELD(TT, yieldTime)
      self.taskId = nil
      self:ChangeState(StateN24Shop.SpineAnim2, lotteryType)
    end, self)
  else
    self:ChangeState(StateN24Shop.GetAward)
  end
end
