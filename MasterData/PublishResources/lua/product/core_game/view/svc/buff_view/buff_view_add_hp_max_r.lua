_class("BuffViewAddHPMax", BuffViewBase)
BuffViewAddHPMax = BuffViewAddHPMax

function BuffViewAddHPMax:PlayView(TT)
  if self:ViewParams() then
    local skipView = self:ViewParams().SkipView
    if skipView == 1 then
      return
    end
  end
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
  if result:GetNotAddHP() == 1 then
    playDamageSvc:_RefreshTeamHP(TT, entityWork, damageInfo)
    return
  end
  playDamageSvc:UpdateTargetHPBar(TT, entityWork, damageInfo)
  if result:GetDisplayDamage() == 1 then
    playDamageSvc:DisplayDamage(TT, entityWork, damageInfo)
  end
end
