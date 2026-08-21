_class("DamageInfo", Object)
DamageInfo = DamageInfo
local DamageType = {
  Invalid = 0,
  Normal = 1,
  Real = 2,
  Recover = 3,
  Guard = 4,
  Miss = 5,
  Critical = 6,
  Burn = 21,
  Poison = 22,
  Bleed = 23,
  Explode = 24,
  RealReflexive = 25,
  RealDead = 26,
  NoElementNormal = 27,
  RealTransmit = 28,
  RecoverTransmit = 29
}
_enum("DamageType", DamageType)

function DamageInfo:Constructor(damageValue, damageType)
  if damageValue then
    self._damageValue = math.ceil(damageValue)
  else
    self._damageValue = nil
  end
  self._damageType = damageType
  self._changeHP = 0
  self._attackerEntityId = nil
  self._targetEntityId = nil
  self._dropAssetList = nil
  self._isTriggerHPLock = nil
  self._isTriggerSecKill = nil
  self._isHpShieldGuard = nil
  self._hpShield = nil
  self._hpShieldDelta = nil
  self._initHPShield = nil
  self._comboCount = nil
  self._shieldLayer = nil
  self._mazeDamageList = nil
  self._mazeTeamMembersDamageList = nil
  self._singlePet = nil
  self._showPosition = nil
  self._elementType = nil
  self._showType = DamageShowType.Single
  self._beHitRefreshBuff = true
  self._playBuffResult = nil
  self._renderGridPos = nil
  self._hpAndShieldChangeValue = nil
  self._multiHPSwitch = false
  self._newMultiHPStage = -1
  self._multiHPFinalHP = -1
  self._multiHPCurMaxHP = -1
  self._multiHPSwitchCount = -1
  self._syncDamageInfoList = {}
  self._damageStatisticsType = nil
end

function DamageInfo:Clone(other)
  self._damageValue = other._damageValue
  self._damageType = other._damageType
  self._changeHP = other._changeHP
  self._attackerEntityId = other._attackerEntityId
  self._targetEntityId = other._targetEntityId
  self._dropAssetList = nil
  self._isTriggerHPLock = other._isTriggerHPLock
  self._isTriggerSecKill = other._isTriggerSecKill
  self._isHpShieldGuard = other._isHpShieldGuard
  self._hpShield = nil
  self._hpShieldDelta = nil
  self._initHPShield = nil
  self._comboCount = other._comboCount
  self._shieldLayer = nil
  if other._mazeDamageList then
    self._mazeDamageList = table.clone(other._mazeDamageList)
  end
  if other._mazeTeamMembersDamageList then
    self._mazeTeamMembersDamageList = table.clone(other._mazeTeamMembersDamageList)
  end
  self._singlePet = other._singlePet
  self._showPosition = other._showPosition
  self._elementType = other._elementType
  self._showType = other._showType
  self._beHitRefreshBuff = other._beHitRefreshBuff
  self._playBuffResult = other._playBuffResult
  self._renderGridPos = other._renderGridPos
  self._hpAndShieldChangeValue = other._hpAndShieldChangeValue
  self._multiHPFinalHP = other._multiHPFinalHP
  self._multiHPCurMaxHP = other._multiHPCurMaxHP
  self._multiHPSwitchCount = other._multiHPSwitchCount
end

function DamageInfo:GetDamageValue()
  return self._damageValue
end

function DamageInfo:GetMazeDamageList()
  return self._mazeDamageList
end

function DamageInfo:SetMazeDamageList(mazeDamageList)
  self._mazeDamageList = mazeDamageList
end

function DamageInfo:GetMazeDamageValue(entityID)
  if not self._mazeDamageList then
    return 0
  end
  return self._mazeDamageList[entityID]
end

function DamageInfo:AddMazeDamage(entityID, damageValue)
  if not self._mazeDamageList then
    self._mazeDamageList = {}
  end
  self._mazeDamageList[entityID] = damageValue
end

function DamageInfo:MergeDamageInfo(damageInfo)
  if self._damageType ~= damageInfo:GetDamageType() then
    return
  end
  self._damageValue = self._damageValue + damageInfo:GetDamageValue()
  self._changeHP = self._changeHP + damageInfo:GetChangeHP()
  local mazeDamageList = damageInfo:GetMazeDamageList()
  if mazeDamageList then
    if not self._mazeDamageList then
      self._mazeDamageList = {}
    end
    for eid, val in pairs(mazeDamageList) do
      self._mazeDamageList[eid] = (self._mazeDamageList[eid] or 0) + val
    end
  end
  local mazeTeamMemberDamageList = damageInfo:GetMazeTeamMemberDamageList()
  if mazeTeamMemberDamageList then
    if not self._mazeTeamMembersDamageList then
      self._mazeTeamMembersDamageList = {}
    end
    for eid, v in pairs(mazeTeamMemberDamageList) do
      local saveDamageInfo = self._mazeTeamMembersDamageList[eid]
      if not saveDamageInfo then
        self._mazeTeamMembersDamageList[eid] = v
      else
        local saveDamageInfoChangeHp = saveDamageInfo:GetChangeHP()
        local saveDamageInfoDamageValue = saveDamageInfo:GetDamageValue()
        saveDamageInfo:SetChangeHP(saveDamageInfoChangeHp + v:GetChangeHP())
        saveDamageInfo:SetDamageValue(saveDamageInfoDamageValue + v:GetDamageValue())
      end
    end
  end
end

function DamageInfo:GetMazeTeamMemberDamageList()
  return self._mazeTeamMembersDamageList
end

function DamageInfo:SetMazeTeamMemberDamageList(mazeDamageList)
  self._mazeTeamMembersDamageList = mazeDamageList
end

function DamageInfo:GetMazeTeamMemberDamageInfo(entityID)
  if not self._mazeTeamMembersDamageList then
    return DamageInfo:New(0, DamageType.Invalid)
  end
  return self._mazeTeamMembersDamageList[entityID]
end

function DamageInfo:AddMazeTeamMemberDamageInfo(entityID, damageInfo)
  if not self._mazeTeamMembersDamageList then
    self._mazeTeamMembersDamageList = {}
  end
  self._mazeTeamMembersDamageList[entityID] = damageInfo
  if not self._elementType then
    self._elementType = damageInfo:GetElementType()
  end
  local damageType = damageInfo:GetDamageType()
  if damageType ~= DamageType.Guard and damageType ~= DamageType.Miss then
    self._damageType = damageType
  end
  if damageInfo:GetHPShield() then
    if not self._hpShield then
      self._hpShield = 0
    end
    self._hpShield = self._hpShield + damageInfo:GetHPShield()
  end
  if damageInfo:GetHPShieldDelta() then
    if not self._hpShieldDelta then
      self._hpShieldDelta = 0
    end
    self._hpShieldDelta = self._hpShieldDelta + damageInfo:GetHPShieldDelta()
  end
  if damageInfo:GetShieldCostDamage() then
    if not self._shieldCostDamage then
      self._shieldCostDamage = 0
    end
    self._shieldCostDamage = self._shieldCostDamage + damageInfo:GetShieldCostDamage()
    self._isHpShieldGuard = self._shieldCostDamage == self._changeHP
  end
end

function DamageInfo:GetSinglePet()
  return self._singlePet or 0
end

function DamageInfo:SetSinglePet(singlePet)
  self._singlePet = singlePet
end

function DamageInfo:GetDamageType()
  return self._damageType
end

function DamageInfo:GetDropAssetList()
  return self._dropAssetList
end

function DamageInfo:SetDropAssetList(dropAssetList)
  self._dropAssetList = dropAssetList
end

function DamageInfo:SetDamageValue(damage)
  self._damageValue = math.floor(damage)
end

function DamageInfo:SetDamageType(damageType)
  self._damageType = damageType
end

function DamageInfo:SetAttackerEntityID(damageSrcEntityId)
  self._attackerEntityId = damageSrcEntityId
end

function DamageInfo:GetAttackerEntityID()
  return self._attackerEntityId
end

function DamageInfo:SetTargetEntityID(targetEntityId)
  self._targetEntityId = targetEntityId
end

function DamageInfo:GetTargetEntityID()
  return self._targetEntityId
end

function DamageInfo:IsTriggerHPLock()
  return self._isTriggerHPLock
end

function DamageInfo:SetTriggerHPLock(val)
  self._isTriggerHPLock = val
end

function DamageInfo:SetTriggerSecKill(val)
  self._isTriggerSecKill = val
end

function DamageInfo:IsTriggerSecKill()
  return self._isTriggerSecKill
end

function DamageInfo:SetShieldLayer(layer)
  self._shieldLayer = layer
end

function DamageInfo:GetShieldLayer()
  return self._shieldLayer
end

function DamageInfo:SetComboCount(count)
  self._comboCount = count
end

function DamageInfo:GetComboCount()
  return self._comboCount
end

function DamageInfo:SetChangeHP(val)
  self._changeHP = val
end

function DamageInfo:GetChangeHP()
  return self._changeHP
end

function DamageInfo:SetShowPosition(pos)
  self._showPosition = pos
end

function DamageInfo:GetShowPosition()
  return self._showPosition
end

function DamageInfo:SetElementType(element)
  self._elementType = element
end

function DamageInfo:GetElementType()
  return self._elementType
end

function DamageInfo:SetShowType(type)
  self._showType = type
end

function DamageInfo:GetShowType()
  return self._showType
end

function DamageInfo:SetHPShield(val)
  self._hpShield = val
end

function DamageInfo:GetHPShield()
  return self._hpShield
end

function DamageInfo:SetHPShieldDelta(val)
  self._hpShieldDelta = val
end

function DamageInfo:GetHPShieldDelta()
  return self._hpShieldDelta
end

function DamageInfo:SetHPShieldGuard(val)
  self._isHpShieldGuard = val
end

function DamageInfo:IsHPShieldGuard()
  return self._isHpShieldGuard
end

function DamageInfo:SetBeHitRefreshBuff(val)
  self._beHitRefreshBuff = val
end

function DamageInfo:GetBeHitRefreshBuff()
  return self._beHitRefreshBuff
end

function DamageInfo:SetPlayBuffResult(val)
  self._playBuffResult = val
end

function DamageInfo:GetPlayBuffResult()
  return self._playBuffResult
end

function DamageInfo:SetDamageStageIndex(val)
  self._damageStageIndex = val
end

function DamageInfo:GetDamageStageIndex()
  return self._damageStageIndex
end

function DamageInfo:SetRenderGridPos(gridPos)
  self._renderGridPos = gridPos
end

function DamageInfo:GetRenderGridPos()
  return self._renderGridPos
end

function DamageInfo:SetRandHalfDamageIndex(val)
  self._randHalfDamageIndex = val
end

function DamageInfo:GetRandHalfDamageIndex()
  return self._randHalfDamageIndex
end

function DamageInfo:SetAttackPos(attackPos)
  self._attackPos = attackPos
end

function DamageInfo:GetAttackPos()
  return self._attackPos
end

function DamageInfo:SetHpAndShieldChangeValue(val)
  self._hpAndShieldChangeValue = val
end

function DamageInfo:GetHpAndShieldChangeValue()
  return self._hpAndShieldChangeValue
end

function DamageInfo:SetShieldCostDamage(val)
  self._shieldCostDamage = val
end

function DamageInfo:GetShieldCostDamage()
  return self._shieldCostDamage
end

function DamageInfo:SetCurSkillDamageIndex(val)
  self._curSkillDamageIndex = val
end

function DamageInfo:GetCurSkillDamageIndex()
  return self._curSkillDamageIndex
end

function DamageInfo:GetNormalAttackIndex()
  return self._normalAttackIndex
end

function DamageInfo:SetNormalAttackIndex(index)
  self._normalAttackIndex = index
end

function DamageInfo:SetCurseHp(val)
  self._curseHp = val
end

function DamageInfo:GetCurseHp()
  return self._curseHp
end

function DamageInfo:SetCurseHpDelta(val)
  self._curseHpDelta = val
end

function DamageInfo:GetCurseHpDelta()
  return self._curseHpDelta
end

function DamageInfo:SetSkillEffectType(skillEffectType)
  self._skillEffectType = skillEffectType
end

function DamageInfo:GetSkillEffectType()
  return self._skillEffectType
end

function DamageInfo:SetSkillID(skillID)
  self._skillID = skillID
end

function DamageInfo:GetSkillID()
  return self._skillID
end

function DamageInfo:IsMultiHPSwitch()
  return self._multiHPSwitch == true
end

function DamageInfo:SetMultiHPSwitch(state)
  self._multiHPSwitch = state
end

function DamageInfo:GetNewMultiHPStage()
  return self._newMultiHPStage
end

function DamageInfo:SetNewMultiHPStage(stage)
  self._newMultiHPStage = stage
end

function DamageInfo:SetMultiHPFinalHP(hp)
  self._multiHPFinalHP = hp
end

function DamageInfo:GetMultiHPFinalHP()
  return self._multiHPFinalHP
end

function DamageInfo:SetMultiHPCurMaxHP(maxHP)
  self._multiHPCurMaxHP = maxHP
end

function DamageInfo:GetMultiHPCurMaxHP()
  return self._multiHPCurMaxHP
end

function DamageInfo:SetMultiHPSwitchCount(count)
  self._multiHPSwitchCount = count
end

function DamageInfo:GetMultiHPSwitchCount()
  return self._multiHPSwitchCount
end

function DamageInfo:SetInitShield(state)
  self._initHPShield = state
end

function DamageInfo:IsInitShield()
  return self._initHPShield == true
end

function DamageInfo:AddSyncDamageInfo(damageInfo)
  table.insert(self._syncDamageInfoList, damageInfo)
end

function DamageInfo:GetSyncDamageInfo()
  return self._syncDamageInfoList
end

function DamageInfo:GetChainIndex()
  return self._chainIndex
end

function DamageInfo:SetChainIndex(chainIndex)
  self._chainIndex = chainIndex
end

function DamageInfo:GetDamageStatisticsType()
  return self._damageStatisticsType
end

function DamageInfo:SetDamageStatisticsType(damageStatisticsType)
  self._damageStatisticsType = damageStatisticsType
end

function DamageInfo:SetDamageStatisticsAttackerEntityID(damageSrcEntityID)
  self._damageStatisticsAttackerEntityID = damageSrcEntityID
end

function DamageInfo:GetDamageStatisticsAttackerEntityID()
  return self._damageStatisticsAttackerEntityID
end
