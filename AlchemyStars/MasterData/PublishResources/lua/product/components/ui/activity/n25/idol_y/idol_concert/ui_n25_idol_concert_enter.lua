_class("UIN25IdolConcertEnter", UIController)
UIN25IdolConcertEnter = UIN25IdolConcertEnter

function UIN25IdolConcertEnter:Constructor()
end

function UIN25IdolConcertEnter:OnShow(uiParams)
  self.currentTurn = uiParams[1]
  local cfgs = Cfg.cfg_n25_concert({
    Turn = self.currentTurn
  })
  Log.debug("###[UIN25IdolConcert] OnShow ! id --> ", self.currentTurn)
  self.cfg = cfgs[1]
  self:GetComponents()
  self:OnValue()
end

function UIN25IdolConcertEnter:GetComponents()
  self.anim = self:GetUIComponent("Animation", "SafeArea")
end

function UIN25IdolConcertEnter:OnHide()
  if self.event then
    GameGlobal.Timer():CancelEvent(self.event)
    self.event = nil
  end
  if self.animEvent then
    GameGlobal.Timer():CancelEvent(self.animEvent)
    self.animEvent = nil
  end
end

function UIN25IdolConcertEnter:OnValue()
  local inAnim = "uieff_UIN25IdolConcertEnter_in"
  local inAnimTime = 500
  local loopAnim = "uieff_UIN25IdolConcertEnter_loading"
  local loopAnimTime = 4000
  self._yieldTime = inAnimTime + loopAnimTime
  self.anim:Play(inAnim)
  self.animEvent = GameGlobal.Timer():AddEvent(inAnimTime, function()
    self.anim:Play(loopAnim)
  end)
  if self.event then
    GameGlobal.Timer():CancelEvent(self.event)
    self.event = nil
  end
  self.event = GameGlobal.Timer():AddEvent(self._yieldTime, function()
    self:PlayEnd()
  end)
end

function UIN25IdolConcertEnter:PlayEnd()
  local before = self.cfg.BeforeStory
  if before then
    self:ShowDialog("UIN25IdolStoryController", before, function()
      self:CloseEnd()
    end)
  else
    self:CloseEnd()
  end
end

function UIN25IdolConcertEnter:CloseEnd()
  self:CloseDialog()
end
