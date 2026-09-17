local this = class("moduleBattleEliteCell", G_UIModuleBase)
local _screenPosToUI = Unity.RectTransformUtility.ScreenPointToLocalPointInRectangle

function this.bind()
  return {goEliteWeak = false}
end

function this.methods()
  return {}
end

function this:created(...)
  this.super.created(self, ...)
end

function this:open(options)
  self.bind.goEliteWeak = false
  self._canUse = true
end

function this:showEffect(x, y)
  self.bind.goEliteWeak = true
  self._canUse = false
  local _, uiPos = _screenPosToUI(self.parent.bindComponents.BreakEliteEffectRoot, C_Vector2(x, y), C_CameraManager.uiCamera)
  L_Vector3.setAnchored(self.bindComponents.Root, uiPos)
  self:resetEliteWeakTimer()
  self.goEliteWeakTimer = Timer.once(3, function()
    self.bind.goEliteWeak = false
    self.goEliteWeakTimer = nil
    self._canUse = true
  end, self)
end

function this:resetEliteWeakTimer()
  if self.goEliteWeakTimer then
    Timer.remove(self.goEliteWeakTimer)
    self.goEliteWeakTimer = nil
  end
end

function this:canUse()
  return self._canUse
end

function this:close()
  self._canUse = false
  self.bind.goEliteWeak = false
  self:resetEliteWeakTimer()
end

function this:refresh()
end

return this
