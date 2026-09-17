local cls = class("loadingView", G_UIModuleBase)
local tag = cls:getName()

function cls.bind()
  return {
    iconActive = false,
    rotation = C_Quaternion.Euler(C_Vector3(0, 0, 0))
  }
end

function cls.methods()
  return {}
end

function cls:clearTimer()
  if self._timer then
    self._timer:destroy()
    self._timer = nil
  end
end

function cls:doShow()
  self:clearTimer()
  self._rotateZ = 0
  self.bind.iconActive = true
  self.bind.rotation = C_Quaternion.Euler(C_Vector3(0, 0, 0))
  self._timer = Timer.new(function()
    self._rotateZ = self._rotateZ - 30
    self.bind.rotation = C_Quaternion.Euler(C_Vector3(0, 0, self._rotateZ))
  end, 0.1, -1)
  self._timer:start()
end

function cls:doHide()
  self:clearTimer()
  self._rotateZ = 0
  self.bind.iconActive = false
  self.bind.rotation = C_Quaternion.Euler(C_Vector3(0, 0, 0))
end

function cls:open()
  self._rotateZ = 0
  self:clearTimer()
end

function cls:close()
  self._rotateZ = 0
  self:clearTimer()
end

return cls
