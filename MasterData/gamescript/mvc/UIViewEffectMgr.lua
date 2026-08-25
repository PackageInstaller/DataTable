local UIViewEffectMgr = NewClass("UIViewEffectMgr")

function UIViewEffectMgr:ctor()
end

function UIViewEffectMgr:PlayEffect(effPath, uiNode, offsetX, offsetY, loop)
  local eff = UIEffectMgr.Instance:PlayEffect(effPath, uiNode, offsetX, offsetY, loop)
  self._effInstance = self._effInstance or {}
  self._effInstance[eff] = true
  return eff
end

function UIViewEffectMgr:StopEffect(eff)
  if self._effInstance and self._effInstance[eff] then
    self._effInstance[eff] = nil
    UIEffectMgr.Instance:StopEffect(eff)
  end
end

function UIViewEffectMgr:ClearAll()
  if self._effInstance then
    for k, _ in pairs(self._effInstance) do
      UIEffectMgr.Instance:StopEffect(k)
    end
    self._effInstance = nil
  end
end

return UIViewEffectMgr
