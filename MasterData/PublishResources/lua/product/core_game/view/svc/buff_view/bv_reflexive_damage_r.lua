_class("BuffViewReflexiveDamage", BuffViewBase)
BuffViewReflexiveDamage = BuffViewReflexiveDamage

function BuffViewReflexiveDamage:PlayView(TT)
  local result = self._buffResult
  local layer = result:GetLayer()
  if layer and self._entity:PetPstID() then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.SetAccumulateNum, self._entity:PetPstID():GetPstID(), layer)
  end
  local targetId = result:GetDefenderID()
  local damageInfo = result:GetDamageInfo()
  if not damageInfo then
    return
  end
  local viewParams = self._viewInstance:BuffConfigData():GetViewParams()
  local targetEntity = self._world:GetEntityByID(targetId)
  local damageType = damageInfo:GetDamageType()
  local targetDamage = damageInfo:GetDamageValue()
  local hitEffectID = 0
  if viewParams then
    hitEffectID = viewParams.HitEffectId
  end
  if damageType == DamageType.Invalid and targetDamage == 0 then
    return
  end
  if damageType == DamageType.Guard then
  elseif 0 < hitEffectID then
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
  local originalAttackerID = result:GetOriginalAttackerID()
  if targetEntity:HasTeam() and originalAttackerID then
    targetEntity = self._world:GetEntityByID(originalAttackerID)
  end
  svc:AsyncUpdateHPAndDisplayDamage(targetEntity, damageInfo)
end

function BuffViewReflexiveDamage:IsNotifyMatch(notify)
  local result = self._buffResult
  if result:GetSkillHolderID() then
    if result:GetSkillHolderID() == notify:GetAttackerEntity():GetID() then
      return true
    end
  elseif result:GetOriginalAttackerID() == notify:GetAttackerEntity():GetID() then
    if notify:GetSkillType() == SkillType.Normal then
      local damageIndexMatch = true
      if result:GetCurSkillDamageIndex() and notify.GetCurSkillDamageIndex then
        damageIndexMatch = result:GetCurSkillDamageIndex() == notify:GetCurSkillDamageIndex()
      end
      if result:GetAttackPos() == notify:GetAttackPos() and damageIndexMatch then
        return true
      else
        return false
      end
    end
    return true
  end
  return false
end
