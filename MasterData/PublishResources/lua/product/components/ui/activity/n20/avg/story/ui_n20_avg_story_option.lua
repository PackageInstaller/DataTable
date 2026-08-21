_class("UIN20AVGStoryOption", UICustomWidget)
UIN20AVGStoryOption = UIN20AVGStoryOption

function UIN20AVGStoryOption:Constructor()
  self.mCampaign = GameGlobal.GetModule(CampaignModule)
  self.data = self.mCampaign:GetN20AVGData()
  self.animNames = {
    "uieff_UIN20AVGStoryOption_normal_in",
    "uieff_UIN20AVGStoryOption_normal_loop1",
    "uieff_UIN20AVGStoryOption_normal_loop2",
    "uieff_UIN20AVGStoryOption_normal_loop3",
    "uieff_UIN20AVGStoryOption_normal_out",
    "uieff_UIN20AVGStoryOption_lock_in",
    "uieff_UIN20AVGStoryOption_lock_loop1",
    "uieff_UIN20AVGStoryOption_lock_loop2",
    "uieff_UIN20AVGStoryOption_lock_loop3",
    "uieff_UIN20AVGStoryOption_lock_out"
  }
  self.taskIdChangePos = 0
  self.taskId = 0
end

function UIN20AVGStoryOption:OnShow()
  self.anim = self:GetUIComponent("Animation", "root")
  self.rt = self:GetGameObject():GetComponent(typeof(UnityEngine.RectTransform))
  UICommonHelper:GetInstance():RectTransformAnchor2Center(self.rt)
  self.rt.gameObject:SetActive(false)
  self.normal = self:GetGameObject("normal")
  self.lock = self:GetGameObject("lock")
  self.rtNormal = self:GetUIComponent("RectTransform", "normal")
  self.rtLock = self:GetUIComponent("RectTransform", "lock")
  self.imgSelected = self:GetGameObject("imgSelected")
  self.imgNotSelected = self:GetGameObject("imgNotSelected")
  self.txtOption = self:GetUIComponent("UILocalizationText", "txtOption")
  self.txtUnlockCondition = self:GetUIComponent("UILocalizationText", "txtUnlockCondition")
  self:AttachEvent(GameEventType.AVGShowHideOptionInfluence, self.AVGShowHideOptionInfluence)
end

function UIN20AVGStoryOption:OnHide()
  self.anim = nil
  self.option = nil
  self.taskIdChangePos = 0
  self.taskId = 0
  self:DetachEvent(GameEventType.AVGShowHideOptionInfluence, self.AVGShowHideOptionInfluence)
end

function UIN20AVGStoryOption:Flush(option, callback, uis)
  self.option = option
  self.callback = callback
  self._uis = uis
  if option:IsSatisfyUnlock() then
    if option:IsSelected() then
      self.imgSelected:SetActive(true)
      self.imgNotSelected:SetActive(false)
    else
      self.imgSelected:SetActive(false)
      self.imgNotSelected:SetActive(true)
    end
    self.txtOption:SetText(option:Content())
  else
    self.txtUnlockCondition:SetText(option.unlockConditionDesc)
  end
  self:PlayAnimChangePos()
end

function UIN20AVGStoryOption:btnOnClick(go)
  if not self.option:IsSatisfyUnlock() then
    return
  end
  for i, ui in ipairs(self._uis) do
    if i == self.option.index then
      self:PlayAnimClick(self.callback)
    else
      ui:PlayAnimOut()
    end
  end
end

function UIN20AVGStoryOption:GetPos()
  local posTarget = self.data.optionPos[self.option.index] or Vector2.zero
  return posTarget
end

function UIN20AVGStoryOption:ResetRectTransform()
  self.rtNormal.anchoredPosition = Vector2.zero
  self.rtLock.anchoredPosition = Vector2.zero
end

function UIN20AVGStoryOption:AVGShowHideOptionInfluence(isShowInfluence)
  if isShowInfluence then
    self:PlayAnimOut()
  else
    self:PlayAnimIn()
  end
end

function UIN20AVGStoryOption:GetState()
  if not self.option then
    return
  end
  local state = 0
  if self.option:IsSatisfyUnlock() then
    state = 1
  else
    state = 6
  end
  self.normal:SetActive(state == 1)
  self.lock:SetActive(state == 6)
  return state
end

function UIN20AVGStoryOption:PlayAnimChangePos()
  if self.taskIdChangePos > 0 then
    GameGlobal.TaskManager():KillTask(self.taskIdChangePos)
  end
  self.taskIdChangePos = self:StartTask(function(TT)
    local key = "PlayAnimChangePos" .. self.option.index
    self:Lock(key)
    local posTarget = self:GetPos()
    local duration = 0.222
    local delay = self.option.index * 0.1
    self.rt.gameObject:SetActive(false)
    self.rt:DOAnchorPos(posTarget, duration):SetDelay(delay):OnStart(function()
      self.rt.gameObject:SetActive(true)
      self:AVGShowHideOptionInfluence(false)
    end)
    YIELD(TT, (duration + delay) * 1000)
    self.taskIdChangePos = 0
    self:UnLock(key)
  end, self)
end

function UIN20AVGStoryOption:PlayAnimIn()
  if not self.anim then
    return
  end
  self:ResetRectTransform()
  if self.taskId > 0 then
    GameGlobal.TaskManager():KillTask(self.taskId)
  end
  self.taskId = self:StartTask(function(TT)
    self:StopAnim()
    local state = self:GetState()
    local animName = self.animNames[state]
    self.anim:Play(animName)
    YIELD(TT, 833)
    self.taskId = 0
    self:PlayAnimLoop()
  end, self)
end

function UIN20AVGStoryOption:PlayAnimLoop()
  if not self.anim then
    return
  end
  local offset = math.random(1, 3)
  local state = self:GetState() + offset
  self.anim:Play(self.animNames[state])
end

function UIN20AVGStoryOption:PlayAnimOut()
  if not self.anim then
    return
  end
  local state = self:GetState() + 4
  self:StopAnim()
  self.anim:Play(self.animNames[state])
end

function UIN20AVGStoryOption:StopAnim()
  if not self.anim then
    return
  end
  for index, animName in ipairs(self.animNames) do
    local state = self.anim:get_Item(animName)
    state.normalizedTime = 0
  end
  self.anim:Stop()
end

function UIN20AVGStoryOption:PlayAnimClick(callback)
  UIWidgetHelper.PlayAnimation(self, "root", "uieff_UIN20AVGStoryOption_normal_click", 1000, callback)
end
