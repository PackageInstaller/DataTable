_class("BuffViewTransmitDamage", BuffViewBase)
BuffViewTransmitDamage = BuffViewTransmitDamage

function BuffViewTransmitDamage:PlayView(TT)
  local result = self._buffResult
  local targetIDList = result:GetDefenderIDs()
  local damageInfoList = result:GetDamageInfos()
  if not targetIDList or not damageInfoList then
    return
  end
  if table.count(targetIDList) ~= table.count(damageInfoList) then
    return
  end
  local viewParams = self._viewInstance:BuffConfigData():GetViewParams()
  local hitEffectID = 0
  if viewParams then
    hitEffectID = viewParams.HitEffectId
  end
  for i = 1, #targetIDList do
    local targetEntity = self._world:GetEntityByID(targetIDList[i])
    local damageInfo = damageInfoList[i]
    local damageType = damageInfo:GetDamageType()
    local targetDamage = damageInfo:GetDamageValue()
    if 0 < hitEffectID then
      local effectEntity = self._world:GetService("Effect"):CreateBeHitEffect(hitEffectID, targetEntity)
      YIELD(TT)
      local view = self._entity:View()
      if view then
        local tran = view:GetGameObject().transform
        local castPos = tran.position
        local targetPos = targetEntity:Location().Position
        local dir = targetPos - castPos
        if effectEntity:View() then
          effectEntity:View():GetGameObject().transform.forward = dir
        end
      end
    end
    damageInfo:SetShowType(DamageShowType.Single)
    local svc = self._world:GetService("PlayDamage")
    svc:AsyncUpdateHPAndDisplayDamage(targetEntity, damageInfo)
  end
end

function BuffViewTransmitDamage:IsNotifyMatch(notify)
  local result = self._buffResult
  if result:GetOriginalAttackerID() ~= notify:GetDamageSrcEntityID() then
    return false
  end
  if notify.GetAttackPos and result:GetAttackPos() ~= notify:GetAttackPos() then
    return false
  end
  local notifyHp = result:GetNotifyHp()
  if notifyHp and notify.GetChangeHP and notifyHp ~= notify:GetChangeHP() then
    return false
  end
  return true
end
