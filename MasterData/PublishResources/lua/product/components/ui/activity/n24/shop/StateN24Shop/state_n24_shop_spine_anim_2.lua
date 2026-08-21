_class("StateN24ShopSpineAnim2", StateN24ShopBase)
StateN24ShopSpineAnim2 = StateN24ShopSpineAnim2

function StateN24ShopSpineAnim2:OnEnter(TT, ...)
  self:Init()
  self:ShowHideSpineSkip(true)
  self:SetSpineSkipClickCallback(function()
    self:ChangeState(StateN24Shop.GetAward)
  end)
  local lotteryType = table.unpack({
    ...
  })
  self:PlaySpineAnim2(lotteryType)
end

function StateN24ShopSpineAnim2:OnExit(TT)
  self:ShowHideSpineSkip(false)
  self.ui:ShowSpineAnim3()
  if self.taskId then
    GameGlobal.TaskManager():KillTask(self.taskId)
  end
end

function StateN24ShopSpineAnim2:PlaySpineAnim2(lotteryType)
  local curPageIndex = self:CurPageIndex()
  local spineAnim2
  if lotteryType == ECampaignLotteryType.E_CLT_SINGLE then
    spineAnim2 = curPageIndex .. "_2"
  else
    spineAnim2 = curPageIndex .. "_4"
  end
  local yieldTime = self:PlaySpineAnimation(spineAnim2, false)
  if yieldTime and 0 < yieldTime then
    self.taskId = GameGlobal.TaskManager():StartTask(function(TT)
      YIELD(TT, yieldTime)
      self.taskId = nil
      self:ChangeState(StateN24Shop.GetAward)
    end, self)
  else
    self:ChangeState(StateN24Shop.GetAward)
  end
end
