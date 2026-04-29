_class("BuffViewDecreaseMaxHP", BuffViewBase)
BuffViewDecreaseMaxHP = BuffViewDecreaseMaxHP

function BuffViewDecreaseMaxHP:PlayView(TT)
  local playDamageSvc = self._world:GetService("PlayDamage")
  local result = self._buffResult
  local damageInfo = result:GetDamageInfo()
  local entityID = result:GetEntityID()
  local ret = result:GetMaxHPResult()
  for k, v in pairs(ret) do
    local e = self._world:GetEntityByID(k)
    e:ReplaceMaxHP(v)
  end
  local entityWork = self._world:GetEntityByID(entityID)
  playDamageSvc:UpdateTargetHPBar(TT, entityWork, damageInfo)
end
