_class("SeasonMapExpressBorn", SeasonMapExpressBase)
SeasonMapExpressBorn = SeasonMapExpressBorn

function SeasonMapExpressBorn:Constructor(cfg, eventPoint)
  self._content = self._cfg.Born
  self._seasonManager = GameGlobal.GetUIModule(SeasonModule):SeasonManager()
  self._time = 0
  self._executing = false
end

function SeasonMapExpressBorn:Update(deltaTime)
  if self._state == SeasonExpressState.Playing and self._executing then
    self._time = self._time - deltaTime
    if self._time <= 0 then
      self._executing = false
      self:Next()
    end
  end
end

function SeasonMapExpressBorn:OnPlay()
  if self._content then
    self._executing = true
    local bornType = self._content.type
    if bornType == SeasonBornType.Play then
      self._time = 0
      local animName = self._content.anim
      local eventAnimationState = self._eventPoint:PlayAnimation(animName)
      if eventAnimationState then
        self._time = eventAnimationState.length
      end
      self._time = self._time * 1000
      self._state = SeasonExpressState.Playing
    else
      self:Next()
    end
  end
end
