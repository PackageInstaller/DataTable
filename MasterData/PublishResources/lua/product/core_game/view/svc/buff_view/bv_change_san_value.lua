_class("BuffViewChangeSanValue", BuffViewBase)
BuffViewChangeSanValue = BuffViewChangeSanValue

function BuffViewChangeSanValue:PlayView(TT)
  local result = self._buffResult
  local featureSvcRender = self._world:GetService("FeatureRender")
  if featureSvcRender then
    featureSvcRender:NotifySanValueChange(result:GetCurSan(), result:GetOldSan(), result:GetRealModifyValue(), result:GetForceRefresh())
    local svcPlayBuff = self._world:GetService("PlayBuff")
    svcPlayBuff:PlayBuffView(TT, NTSanValueChange:New(result:GetCurSan(), result:GetOldSan(), result:GetDebtVal(), result:GetModifyTimes()))
  end
end
