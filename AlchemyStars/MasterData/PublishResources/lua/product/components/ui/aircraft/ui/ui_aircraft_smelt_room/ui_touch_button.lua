_class("UITouchButton", Object)
UITouchButton = UITouchButton

function UITouchButton:Constructor(button, callBack)
  self._eventListener = UICustomUIEventListener:New()
  self._eventListener:AddUICustomEventListener(button, UIEvent.Press, function()
    self:OnDwon()
  end)
  self._eventListener:AddUICustomEventListener(button, UIEvent.Release, function()
    self:OnUp()
  end)
  self._eventListener:AddUICustomEventListener(button, UIEvent.Drag, function()
    self:Cancel()
  end)
  self._callBack = callBack
  self._timeModule = GameGlobal.GetModule(SvrTimeModule)
  self._touchTime = Cfg.cfg_global.pet_up_level_start_long_time.IntValue
  self._callDeltaTime = Cfg.cfg_global.pet_up_level_add_count_per_second.IntValue
  self._downTime = 0
  self._down = false
  self._callTime = 0
  self._touching = false
  self._active = true
end

function UITouchButton:OnDwon()
  if not self._active then
    return
  end
  self._down = true
  self._downTime = self:Time()
  GameGlobal.TaskManager():StartTask(self._Update, self)
end

function UITouchButton:OnUp()
  if not self._active then
    return
  end
  if self._down and not self._touching then
    AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundDefaultClick)
    self._callBack()
  end
  self:Cancel()
end

function UITouchButton:Cancel()
  if not self._active then
    return
  end
  self._down = false
  self._touching = false
  self._downTime = 0
  self._callTime = 0
end

function UITouchButton:_Update(TT)
  while self._down do
    YIELD(TT)
    if not self._active then
      return
    end
    if self._down then
      local time = self:Time()
      if not self._touching and time - self._downTime > self._touchTime then
        self._touching = true
        self._callTime = time
        self._callBack()
      end
      if self._touching and time - self._callTime > self._callDeltaTime then
        self._callTime = time
        self._callBack()
      end
    end
  end
end

function UITouchButton:Time()
  return self._timeModule:GetServerTime()
end

function UITouchButton:Dispose()
  self._eventListener:Dispose()
  self._active = false
end
