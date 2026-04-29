_class("EZTL_SMaze_PlayerToast", EZTL_Base)
EZTL_SMaze_PlayerToast = EZTL_SMaze_PlayerToast

function EZTL_SMaze_PlayerToast:Constructor(unit, time)
  self._unit = unit
  self._timer = 0
  self._duration = time
end

function EZTL_SMaze_PlayerToast:Start()
  self._running = true
  self._unit:Start()
end

function EZTL_SMaze_PlayerToast:Stop()
  if self._running then
  else
  end
  self._unit:Stop()
  self._running = false
  self._anim = nil
end

function EZTL_SMaze_PlayerToast:Update(dt)
  if self._running then
    self._timer = self._timer + dt
    if self._unit then
      self._unit:Update(dt)
    end
    if self._timer > self._duration then
      self._running = false
      self:Stop()
    end
  end
end
