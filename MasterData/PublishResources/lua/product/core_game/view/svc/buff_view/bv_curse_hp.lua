_class("BuffViewEnableCurseHPCharge", BuffViewBase)
BuffViewEnableCurseHPCharge = BuffViewEnableCurseHPCharge

function BuffViewEnableCurseHPCharge:PlayView(TT)
  local entity = self:Entity()
  local curCurseHpVal = 0
  if entity:HasPet() then
    entity = entity:Pet():GetOwnerTeamEntity()
  end
  local hpCmpt = entity:HP()
  hpCmpt:SetShowCurseHp(true)
  hpCmpt:SetCurseHpValue(curCurseHpVal)
  local playDamageSvc = self._world:GetService("PlayDamage")
  local damageInfo = DamageInfo:New(0, DamageType.Recover)
  damageInfo:SetCurseHp(curCurseHpVal)
  damageInfo:SetCurseHpDelta(nil)
  playDamageSvc:UpdateTargetHPBar(TT, entity, damageInfo)
  local viewParams = self:ViewParams()
  if not viewParams then
    return
  end
  local effectID = viewParams.curseEffectID
  if not effectID then
    return
  end
  local sEffect = self._world:GetService("Effect")
  local cEffectHolder = entity:EffectHolder()
  if entity:HasTeam() then
    local eTeamLeader = entity:Team():GetTeamLeaderEntity()
    cEffectHolder = eTeamLeader:EffectHolder()
  end
  local eEffect = sEffect:CreateEffect(effectID, entity)
  local effEntityId = eEffect:GetID()
  if cEffectHolder then
    cEffectHolder:AttachEffect("CurseHpEffect", effEntityId)
  end
  local waitTime = viewParams.startAnimLength
  local loopAnimName = viewParams.loopAnim
  GameGlobal.TaskManager():CoreGameStartTask(function(TT)
    YIELD(TT, waitTime)
    local effEntity = self._world:GetEntityByID(effEntityId)
    if not effEntity then
      return
    end
    local effView = effEntity:View()
    if not effView then
      return
    end
    local viewWrapper = effView.ViewWrapper
    if not viewWrapper then
      return
    end
    local animMonoCmpt = viewWrapper.GameObject:GetComponent("Animation")
    if animMonoCmpt then
      animMonoCmpt:Play(loopAnimName)
    end
  end)
end

_class("BuffViewDisableCurseHPCharge", BuffViewBase)
BuffViewDisableCurseHPCharge = BuffViewDisableCurseHPCharge

function BuffViewDisableCurseHPCharge:PlayView(TT)
  local entity = self:Entity()
  local curCurseHpVal = 0
  if entity:HasPet() then
    entity = entity:Pet():GetOwnerTeamEntity()
  end
  local hpCmpt = entity:HP()
  hpCmpt:SetShowCurseHp(false)
  hpCmpt:SetCurseHpValue(curCurseHpVal)
  local playDamageSvc = self._world:GetService("PlayDamage")
  local damageInfo = DamageInfo:New(0, DamageType.Recover)
  damageInfo:SetCurseHp(curCurseHpVal)
  damageInfo:SetCurseHpDelta(nil)
  playDamageSvc:UpdateTargetHPBar(TT, entity, damageInfo)
  local viewParams = self:ViewParams()
  if not viewParams then
    return
  end
  local waitTime = viewParams.endAnimLength
  local endAnimName = viewParams.endAnim
  if not endAnimName then
    return
  end
  local cEffectHolder = entity:EffectHolder()
  if entity:HasTeam() then
    local eTeamLeader = entity:Team():GetTeamLeaderEntity()
    cEffectHolder = eTeamLeader:EffectHolder()
  end
  if cEffectHolder then
    local effects = cEffectHolder:GetEffectList("CurseHpEffect")
    if effects and 0 < table.count(effects) then
      for _, effId in ipairs(effects) do
        GameGlobal.TaskManager():CoreGameStartTask(function(TT)
          local effEntity = self._world:GetEntityByID(effId)
          if not effEntity then
            return
          end
          local effView = effEntity:View()
          if not effView then
            return
          end
          local viewWrapper = effView.ViewWrapper
          if not viewWrapper then
            return
          end
          local animMonoCmpt = viewWrapper.GameObject:GetComponent("Animation")
          if animMonoCmpt then
            animMonoCmpt:Play(endAnimName)
          end
          YIELD(TT, waitTime)
          local sEffect = self._world:GetService("Effect")
          sEffect:DestroyEffectByID(effId)
        end)
      end
    end
  end
end

_class("BuffViewChargeCurseHP", BuffViewBase)
BuffViewChargeCurseHP = BuffViewChargeCurseHP

function BuffViewChargeCurseHP:IsNotifyMatch(notify)
  return true
end

function BuffViewChargeCurseHP:PlayView(TT)
  local result = self._buffResult
  local eid = result:GetEntityID()
  local entity = self._world:GetEntityByID(eid)
  local curCurseHpVal = result:GetCurseHPVal()
  local curseHpDeltaVal = result:GetChangedVal()
  if entity:HasPet() then
    entity = entity:Pet():GetOwnerTeamEntity()
  end
  local hpCmpt = entity:HP()
  hpCmpt:SetCurseHpValue(curCurseHpVal)
  local playDamageSvc = self._world:GetService("PlayDamage")
  local damageInfo = DamageInfo:New(0, DamageType.Recover)
  damageInfo:SetCurseHp(curCurseHpVal)
  damageInfo:SetCurseHpDelta(nil)
  playDamageSvc:UpdateTargetHPBar(TT, entity, damageInfo)
  local bShowDamage = result:GetShowDamage()
  if bShowDamage then
    local hudDamageInfo
    local showDamageElementType = result:GetShowDamageElementType()
    if showDamageElementType then
      if showDamageElementType == ElementType.ElementType_None then
        hudDamageInfo = DamageInfo:New(curseHpDeltaVal, DamageType.NoElementNormal)
      else
        hudDamageInfo = DamageInfo:New(curseHpDeltaVal, DamageType.Normal)
        hudDamageInfo:SetElementType(showDamageElementType)
      end
    end
    if hudDamageInfo then
      playDamageSvc:DisplayDamage(TT, entity, hudDamageInfo)
    end
  end
end
