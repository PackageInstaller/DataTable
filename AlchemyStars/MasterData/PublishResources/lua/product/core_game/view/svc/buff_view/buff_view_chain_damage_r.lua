_class("BuffViewChainDamage", BuffViewBase)
BuffViewChainDamage = BuffViewChainDamage

function BuffViewChainDamage:PlayView(TT)
  local result = self._buffResult
  local entity = self._entity
  local playDamageText = result:GetPlayDamageText()
  local targetIDList = result:GetDefenderIDs()
  local damageInfoList = result:GetDamageInfos()
  if not targetIDList or not damageInfoList then
    return
  end
  if table.count(targetIDList) ~= table.count(damageInfoList) then
    return
  end
  local viewParams = self._viewInstance:BuffConfigData():GetViewParams()
  local baseAnim
  if viewParams then
    baseAnim = viewParams.baseAnim
  end
  for i = 1, #targetIDList do
    local targetEntity = self._world:GetEntityByID(targetIDList[i])
    local damageInfo = damageInfoList[i]
    local damageType = damageInfo:GetDamageType()
    local targetDamage = damageInfo:GetDamageValue()
    if baseAnim then
      local damageAnim = baseAnim .. viewParams.damageAnim
      local damageFinishAnim = baseAnim .. viewParams.damageFinishAnim
      local recoverAnim = baseAnim .. viewParams.recoverAnim
      local recoverFinishAnim = baseAnim .. viewParams.recoverFinishAnim
      local animTime = viewParams.animTime
      local lineEffectOwner
      local lineEffect = self:_OnGetLineEffect(viewParams, targetEntity, true)
      lineEffect = lineEffect or self:_OnGetLineEffect(viewParams, entity, true)
      if lineEffect then
        do
          local go = lineEffect:View():GetGameObject()
          local anim = go:GetComponentInChildren(typeof(UnityEngine.Animation))
          if anim then
            do
              local animation = ""
              local animationFinish = ""
              if damageType == DamageType.Recover or damageType == DamageType.RecoverTransmit then
                animation = recoverAnim
                animationFinish = recoverFinishAnim
              else
                animation = damageAnim
                animationFinish = damageFinishAnim
              end
              GameGlobal.TaskManager():StartTask(function(TT)
                anim:Play(animation)
                YIELD(TT, animTime)
                if go and go ~= null and anim and anim ~= null then
                  anim:Play(animationFinish)
                end
              end, self)
            end
          end
        end
      end
    end
    damageInfo:SetShowType(DamageShowType.Single)
    local playDamageSvc = self._world:GetService("PlayDamage")
    if playDamageText == 1 then
      playDamageSvc:AsyncUpdateHPAndDisplayDamage(targetEntity, damageInfo)
    else
      do
        local nTaskDamage = GameGlobal.TaskManager():CoreGameStartTask(function(TT)
          playDamageSvc:UpdateTargetHPBar(TT, targetEntity, damageInfo)
          playDamageSvc:_OnHpChangeNotifyBuff(TT, targetEntity, damageInfo:GetChangeHP(), damageInfo)
        end)
      end
    end
  end
end

function BuffViewChainDamage:IsNotifyMatch(notify)
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

function BuffViewChainDamage:_OnGetLineEffect(viewParams, entity, isCaster)
  if entity:HasTeam() then
    entity = entity:GetTeamLeaderPetEntity()
  end
  local effectHolderCmpt = entity:EffectHolder()
  if not effectHolderCmpt then
    return
  end
  local effectLineRenderer = entity:EffectLineRenderer()
  if not effectLineRenderer then
    return
  end
  local defenderID = effectLineRenderer:GetTargetEntityID()
  local casterEntityID = effectLineRenderer:GetCasterEntityID()
  if isCaster == false and casterEntityID == entity:GetID() and defenderID ~= entity:GetID() then
    return
  end
  local lineEffectID = viewParams.lineEffectID
  local lineEffect
  local effectEntityIdList = effectHolderCmpt:GetEffectIDEntityDic()[lineEffectID]
  if effectEntityIdList then
    lineEffect = self._world:GetEntityByID(effectEntityIdList[1])
  end
  return lineEffect
end
