_class("BuffViewShowChainDamage", BuffViewBase)
BuffViewShowChainDamage = BuffViewShowChainDamage

function BuffViewShowChainDamage:PlayView(TT, notify)
  local result = self._buffResult
  local attackerID = result:GetAttackerID()
  local defenderID = result:GetDefenderID()
  local lineEffectID = result:GetLineEffectID()
  local isShow = result:GetIsShow()
  local attacker = self._world:GetEntityByID(attackerID)
  local defender = self._world:GetEntityByID(defenderID)
  if not attacker then
    return
  end
  local viewParams = self._viewInstance:BuffConfigData():GetViewParams() or {}
  local effectHolderCmpt = attacker:EffectHolder()
  if attacker:HasTeam() then
    local leader = attacker:GetTeamLeaderPetEntity()
    effectHolderCmpt = leader:EffectHolder()
    if not effectHolderCmpt then
      leader:AddEffectHolder()
      effectHolderCmpt = leader:EffectHolder()
    end
  end
  local attackerEffectEntityIdList = effectHolderCmpt:GetEffectIDEntityDic()[lineEffectID]
  local lineEffect
  if attackerEffectEntityIdList then
    lineEffect = self._world:GetEntityByID(attackerEffectEntityIdList[1])
  end
  if lineEffect then
    lineEffect:SetViewVisible(isShow)
  end
  local targetPermanentEffectID = viewParams.targetPermanentEffectID
  if targetPermanentEffectID then
    if defender:HasTeam() then
      defender = defender:GetTeamLeaderPetEntity()
    end
    local defenderEffectHolderCmpt = defender:EffectHolder()
    if not defenderEffectHolderCmpt then
      defender:AddEffectHolder()
      defenderEffectHolderCmpt = defender:EffectHolder()
    end
    local effect
    local defenderEffectEntityIdList = defenderEffectHolderCmpt:GetEffectIDEntityDic()[targetPermanentEffectID]
    if defenderEffectEntityIdList then
      effect = self._world:GetEntityByID(defenderEffectEntityIdList[1])
    end
    if effect then
      effect:SetViewVisible(isShow)
    end
  end
end

function BuffViewShowChainDamage:IsNotifyMatch(notify)
  return true
end
