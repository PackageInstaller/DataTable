_class("PetLevelUpAnim", Object)
PetLevelUpAnim = PetLevelUpAnim

function PetLevelUpAnim:Constructor(slider, onLevelChange, onFinish)
  self._slider = slider
  self._onLevelChanged = onLevelChange
  self._onFinish = onFinish
  self._player = EZTL_Player:New()
end

function PetLevelUpAnim:SetData(from, to, endPercent)
  local cur = self._slider.value
  local total = 0
  local deltaLevel = to - from
  if deltaLevel <= 0 then
    total = endPercent - cur
  else
    total = 1 - cur + (deltaLevel - 1) + endPercent
  end
  local speedMin = 2
  local speedMax = 6
  local accelSpeed = 0.8
  local changeSpeedValue = 0.3
  local delta = to - from
  local count = 1
  local step = 0
  if delta <= 0 then
    count = 0
    step = 0
  elseif delta <= 1 then
    count = 1
    step = 1
  elseif delta <= 5 then
    count = delta
    step = 1
  elseif delta <= 10 then
    count = math.ceil(delta / 2)
    step = 2
  else
    count = math.ceil(delta / 5)
    step = 5
  end
  self._timeLength = {}
  local tls = {}
  local tl = EZTL_PetLevelUpAnim:New(self._slider, from, to, step, changeSpeedValue, cur, endPercent, count, speedMax, speedMin, accelSpeed, function(lv)
    self._onLevelChanged(lv)
  end, "升级Slider时间线")
  tls[#tls + 1] = tl
  tls[#tls + 1] = EZTL_Callback:New(function()
    self._onFinish()
  end, "升级动画结束")
  self._tl = EZTL_Sequence:New(tls, "升级总时间线")
end

function PetLevelUpAnim:GetTimeLength()
  return self._timeLength
end

function PetLevelUpAnim:Play()
  self._player:Play(self._tl)
end

_class("EZTL_PetLevelUpAnim", EZTL_Base)
EZTL_PetLevelUpAnim = EZTL_PetLevelUpAnim

function EZTL_PetLevelUpAnim:Constructor(slider, fromLv, toLv, step, changeSpeedValue, from, to, times, speedMax, speedMin, accSpeed, onLevelChangedCallback, desc)
  self._slider = slider
  self._fromLv = fromLv
  self._toLv = toLv
  self._step = step
  self._changeSpeedValue = changeSpeedValue
  self._fromValue = from
  self._toValue = to
  self._times = times
  self._speedMax = speedMax
  self._speedMin = speedMin
  self._speed = self._speedMax
  self._accSpeed = accSpeed
  self._onLevelChangedCallback = onLevelChangedCallback
  self._des = desc
  self._accSpeedOn = false
  self._curValue = 0
  self._oriFromValue = self._fromValue
  self._allValue = 0
  self._levelUp = self._times > 0
  if self._times <= 0 then
    self._allValue = self._toValue - self._fromValue
  else
    self._allValue = 1 - self._fromValue + self._times - 1 + self._toValue
  end
end

function EZTL_PetLevelUpAnim:Start()
  self._timer = 0
  self._running = true
end

function EZTL_PetLevelUpAnim:Update(deltaTimeMS)
  if self._running then
    self._timer = self._timer + deltaTimeMS
    if self._times > 0 then
      if 1 - self._fromValue + (self._times - 1) + self._toValue <= self._changeSpeedValue then
        self._accSpeedOn = true
      end
    elseif self._toValue - self._fromValue <= self._changeSpeedValue then
      self._accSpeedOn = true
    end
    if self._accSpeedOn then
      if self._speed > self._speedMin then
        self._speed = Mathf.Lerp(self._speed, self._speedMin, self._accSpeed)
      else
        self._speed = self._speedMin
      end
    end
    self._fromValue = self._fromValue + self._speed * UnityEngine.Time.deltaTime
    local rate = 0
    if self._levelUp then
      self._curValue = self._curValue + self._speed * UnityEngine.Time.deltaTime
      if self._curValue >= self._allValue then
        self._curValue = self._allValue
        rate = 1
      else
        rate = self._curValue / self._allValue
      end
      GameGlobal.EventDispatcher():Dispatch(GameEventType.OnLevelUpAttValueChanged, rate)
    end
    if self._times <= 0 then
      if self._fromValue >= self._toValue then
        if 1 <= self._toValue then
          self:UpLevel()
        end
        self._fromValue = self._toValue
        self:EndLevel()
        self._running = false
        self:Stop()
      end
    elseif self._fromValue >= 1 then
      self._fromValue = 0
      self._times = self._times - 1
      self._fromLv = self._fromLv + self._step
      if self._fromLv > self._toLv then
        self._fromLv = self._toLv
      end
      self:UpLevel()
    end
    self:SliderValue()
  end
end

function EZTL_PetLevelUpAnim:EndLevel()
  Log.notice("###动画结束")
end

function EZTL_PetLevelUpAnim:UpLevel()
  if self._onLevelChangedCallback then
    self._onLevelChangedCallback(self._fromLv)
  end
  Log.notice("###升级")
end

function EZTL_PetLevelUpAnim:Stop()
  if self._running then
    self._running = false
  end
end

function EZTL_PetLevelUpAnim:SliderValue()
  self._slider.value = self._fromValue
end
