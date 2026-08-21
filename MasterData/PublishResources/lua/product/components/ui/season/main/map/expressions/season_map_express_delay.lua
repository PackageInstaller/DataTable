_class("SeasonMapExpressDelay", SeasonMapExpressBase)
SeasonMapExpressDelay = SeasonMapExpressDelay

function SeasonMapExpressDelay:Constructor(cfg, eventPoint)
  self._content = self._cfg.Delay
  self._time = 0
  self._executing = false
end

function SeasonMapExpressDelay:Update(deltaTime)
  if self._state == SeasonExpressState.Playing and self._executing then
    self._time = self._time - deltaTime
    if self._time <= 0 then
      self._executing = true
      self:Next()
    end
  end
end

function SeasonMapExpressDelay:OnPlay()
  if self._content then
    self._executing = true
    self._time = self._content
    if self._time > 0 then
      self._state = SeasonExpressState.Playing
    else
      self:Next()
    end
  end
end
