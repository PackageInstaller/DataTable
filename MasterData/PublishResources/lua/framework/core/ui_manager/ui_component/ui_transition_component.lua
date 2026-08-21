_class("UITransitionComponent", UIComponent)

function UITransitionComponent:Constructor()
  self.enterAnims = nil
  self.leaveAnims = nil
end

function UITransitionComponent:AfterShow(TT)
  self:PlayEnterAnim(TT)
end

function UITransitionComponent:BeforeHide(TT)
  if not self.uiController.SkipTransitionAmin then
    self:PlayLeaveAnim(TT)
  end
end

function UITransitionComponent:PlayEnterAnim(TT)
  if not self.enterAnims then
    self.enterAnims = SortedArray:New(Algorithm.COMPARE_CUSTOM, function(anim1, anim2)
      if anim1.EnterTime > anim2.EnterTime then
        return -1
      elseif anim1.EnterTime == anim2.EnterTime then
        return 0
      else
        return 1
      end
    end)
    local resCmps = UIHelper.GetAllTransitionComponents(self.uiController:GetGameObject())
    if resCmps then
      for i = 1, resCmps.Length do
        self.enterAnims:Insert(resCmps[i - 1])
      end
    end
  end
  for i = 1, self.enterAnims:Size() do
    self.enterAnims:GetAt(i):PlayEnterAnimation(true)
  end
  local enterTime = 0
  if self.enterAnims:Size() > 0 then
    enterTime = self.enterAnims:GetAt(1).EnterTime
  end
  YIELD(TT, enterTime)
end

function UITransitionComponent:PlayLeaveAnim(TT)
  if not self.leaveAnims then
    self.leaveAnims = SortedArray:New(Algorithm.COMPARE_CUSTOM, function(anim1, anim2)
      if anim1.RestTime > anim2.RestTime then
        return -1
      elseif anim1.RestTime == anim2.RestTime then
        return 0
      else
        return 1
      end
    end)
    local resCmps = UIHelper.GetAllTransitionComponents(self.uiController:GetGameObject())
    if resCmps then
      for i = 1, resCmps.Length do
        self.leaveAnims:Insert(resCmps[i - 1])
      end
    end
  end
  for i = 1, self.leaveAnims:Size() do
    self.leaveAnims:GetAt(i):PlayLeaveAnimation(true)
  end
  local restTime = 0
  if self.leaveAnims:Size() > 0 then
    restTime = self.leaveAnims:GetAt(1).RestTime
  end
  for i = 1, self.leaveAnims:Size() do
    local anim = self.leaveAnims:GetAt(i).gameObject:GetComponent("Animation")
    anim.enabled = true
    anim:get_Item(anim.clip.name).time = self.leaveAnims:GetAt(i).EnterTime / 1000
  end
  YIELD(TT, restTime)
  if 0 < restTime then
    YIELD(TT)
  end
end
