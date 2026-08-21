_class("BuffViewCoffinMusumeSetCandleLight", BuffViewBase)
BuffViewCoffinMusumeSetCandleLight = BuffViewCoffinMusumeSetCandleLight

function BuffViewCoffinMusumeSetCandleLight:PlayView(TT, notify)
  local effectID = self:ViewParams().ExecEffectID
  local e = self:Entity()
  local buffResult = self._buffResult
  local fxsvc = self._world:GetService("Effect")
  if buffResult:IsLightAfter() == 1 then
    fxsvc:CreateEffect(effectID, e)
  elseif buffResult:IsLightAfter() == 0 then
    fxsvc:DestroyEntityEffectByID(e, {effectID})
  end
  self._world:GetService("PlayBuff"):PlayBuffView(TT, NTCoffinMusumeLightChanged:New())
end
