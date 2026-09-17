local dizzy = class("dizzy", G_UIModuleBase)

function dizzy.bind()
  return {dizzyActive = false}
end

function dizzy.methods()
  return {}
end

function dizzy:open()
end

function dizzy:setEffect(params)
  self.bind.dizzyActive = true
  local mat = self.bindComponents.dizzy.material
  mat:SetFloat("_StunRadius", 0)
  
  local function getter()
    return mat:GetFloat("_StunRadius")
  end
  
  local function setter(r)
    mat:SetFloat("_StunRadius", r)
  end
  
  self._tweenCore = C_DOTween.To(getter, setter, 0.025, 0.33)
  self._tweenCore:SetTarget(self.bindComponents.dizzy)
end

function dizzy:stopEffect()
  local mat = self.bindComponents.dizzy.material
  
  local function getter()
    return mat:GetFloat("_StunRadius")
  end
  
  local function setter(r)
    mat:SetFloat("_StunRadius", r)
  end
  
  self._tweenCore = C_DOTween.To(getter, setter, 0, 0.33)
  self._tweenCore:SetTarget(self.bindComponents.dizzy)
  
  function self._tweenCore.onComplete()
    self.bind.dizzyActive = false
  end
end

function dizzy:dispose()
  if self._tweenCore then
    self._tweenCore:Kill(true)
    self._tweenCore = nil
  end
end

return dizzy
