_class("BuffViewNumLockHP", BuffViewBase)
BuffViewNumLockHP = BuffViewNumLockHP

function BuffViewNumLockHP:PlayView(TT)
  local buffResult = self._buffResult
  local numLockHP = buffResult:GetNumLockHP()
  local buffView = self._entity:BuffView()
  buffView:SetBuffValue("NumLockHP", numLockHP)
end

function BuffViewNumLockHP:IsNotifyMatch(notify)
  local buffResult = self._buffResult
  return true
end
