local SmashingPenguinsExplosion = class("SmashingPenguinsExplosion", UIBaseNode)
local base = UIBaseNode
local CS_Animator = CS.UnityEngine.Animator

function SmashingPenguinsExplosion:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.animator = self.gameObject:GetComponent(typeof(CS_Animator))
end

function SmashingPenguinsExplosion:InitSmashingPenguinsExplosion()
  self.animator:Play("PenguinExplosion", 0, 0.0)
  if self._timerId ~= nil then
    TimerManager:StopTimer(self._timerId)
    self._timerId = nil
  end
  self._timerId = TimerManager:StartTimer(0.6, function()
    self:DestroySmashingPenguinsExplosionFx()
  end)
end

function SmashingPenguinsExplosion:DestroySmashingPenguinsExplosionFx()
  local mainUI = UIManager:GetWindow(UIWindowTypeID.SmashingPenguins)
  if IsNull(mainUI) then
    self:Delete()
    return
  end
  mainUI.explosionPool:HideOne(self)
end

function SmashingPenguinsExplosion:OnHide()
  if self._timerId ~= nil then
    TimerManager:StopTimer(self._timerId)
    self._timerId = nil
  end
end

function SmashingPenguinsExplosion:OnDelete()
  if self._timerId ~= nil then
    TimerManager:StopTimer(self._timerId)
    self._timerId = nil
  end
end

return SmashingPenguinsExplosion
