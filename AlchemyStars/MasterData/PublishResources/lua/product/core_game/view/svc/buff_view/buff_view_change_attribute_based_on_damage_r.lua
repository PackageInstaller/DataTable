_class("BuffViewChangeAttributeBasedOnDamage", BuffViewBase)
BuffViewChangeAttributeBasedOnDamage = BuffViewChangeAttributeBasedOnDamage

function BuffViewChangeAttributeBasedOnDamage:PlayView(TT)
  local result = self._buffResult
  local damageInfo = result:GetDamageInfo()
  local entityID = result:GetEntityID()
  local ret = result:GetMaxHPResult()
  if damageInfo == nil then
    return
  end
  for k, v in pairs(ret) do
    local e = self._world:GetEntityByID(k)
    e:ReplaceMaxHP(v)
  end
  local entityWork = self._world:GetEntityByID(entityID)
  local playDamageSvc = self._world:GetService("PlayDamage")
  playDamageSvc:UpdateTargetHPBar(TT, entityWork, damageInfo)
  playDamageSvc:DisplayDamage(TT, entityWork, damageInfo)
end
