_class("StateDrawCardPoolTurnNext", State)
StateDrawCardPoolTurnNext = StateDrawCardPoolTurnNext

function StateDrawCardPoolTurnNext:Init()
  self._fsm = self:GetFsm()
  self._ui = self._fsm:GetData()
  self._anim, self._animName = self._ui:GetAnimNameSwitch()
  self.lockKey = "StateDrawCardPoolTurnNext"
end

function StateDrawCardPoolTurnNext:OnEnter(TT, ...)
  self:Init()
  if self._ui then
    self._ui:Lock(self.lockKey)
    self._anim:Play(self._animName)
  end
  YIELD(TT, 300)
  self:DOPlayTurnNext()
  YIELD(TT, 800)
  if self._fsm then
    self._fsm:ChangeState(StateDrawCardPool.Init)
  end
end

function StateDrawCardPoolTurnNext:OnExit(TT)
  if self._ui then
    if self._anim:IsPlaying(self._animName) then
      Log.fatal("### StateDrawCardPoolTurnNext OnExit anim IsPlaying. ", self._animName)
    end
    for i = 1, self._ui:GetLenLogos() do
      local anim, animName = self._ui:GetAnimNameSwitchPool(i)
      if anim and anim:IsPlaying(animName) then
        Log.fatal("### StateDrawCardPoolTurnNext OnExit anim IsPlaying.", animName)
      end
    end
    self._ui:UnLock(self.lockKey)
  end
end

function StateDrawCardPoolTurnNext:Destroy()
  if self._ui then
    self._ui:UnLock(self.lockKey)
  end
end

function StateDrawCardPoolTurnNext:DOPlayTurnNext()
  if not self._ui then
    return
  end
  local duration = 0.3
  local isFlip = self._ui:IsFlip()
  local layer2Rect = self._ui.layer2Rect
  local layer2Group = self._ui.layer2Group
  local tipsRT = self._ui.tipsRT
  local btnsRT = self._ui.btnsRT
  local onePetGoRT = self._ui.onePetGoRT
  local morePetGoRT = self._ui.morePetGoRT
  local tipsCanvasGroup = self._ui.tipsCanvasGroup
  local btnsCanvasGroup = self._ui.btnsCanvasGroup
  local onePetGoCanvasGroup = self._ui.onePetGoCanvasGroup
  local morePetGoCanvasGroup = self._ui.morePetGoCanvasGroup
  local leftDownGoCanvasGroup = self._ui.leftDownGoCanvasGroup
  local leftDownRt = self._ui.leftDownRt
  local leftDownRtPos = leftDownRt.anchoredPosition
  layer2Rect.anchoredPosition = Vector2(100 * (isFlip and -1 or 1), 0)
  local v2Layer = layer2Rect.anchoredPosition
  tipsRT.anchoredPosition = v2Layer
  btnsRT.anchoredPosition = v2Layer
  onePetGoRT.anchoredPosition = v2Layer
  morePetGoRT.anchoredPosition = v2Layer
  leftDownRtPos.x = v2Layer.x
  layer2Rect:DOAnchorPosX(0, duration):OnUpdate(function()
    local v2Layer = layer2Rect.anchoredPosition
    tipsRT.anchoredPosition = v2Layer
    btnsRT.anchoredPosition = v2Layer
    onePetGoRT.anchoredPosition = v2Layer
    morePetGoRT.anchoredPosition = v2Layer
    leftDownRtPos.x = v2Layer.x
    leftDownRt.anchoredPosition = leftDownRtPos
  end)
  layer2Group:DOFade(1, duration):OnUpdate(function()
    local alpha = layer2Group.alpha
    tipsCanvasGroup.alpha = alpha
    btnsCanvasGroup.alpha = alpha
    onePetGoCanvasGroup.alpha = alpha
    morePetGoCanvasGroup.alpha = alpha
    leftDownGoCanvasGroup.alpha = alpha
  end)
end
