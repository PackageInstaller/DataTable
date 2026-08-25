local BattleEffextPlayQueueCom = System.NewClass("BattleEffextPlayQueueCom")

function BattleEffextPlayQueueCom:ctor()
  self:Clear()
end

function BattleEffextPlayQueueCom:Clear()
  self.effectSfxList = {}
  self.CMDEffect_VFXRef = {}
  self.passTime = 0
  self.lastPlayAwakerEffectTime = 0
end

function BattleEffextPlayQueueCom:Tick(deltaTime)
  self.passTime = self.passTime + deltaTime
  self:TickSingleEffect()
end

function BattleEffextPlayQueueCom:TickSingleEffect()
  if #self.effectSfxList <= 0 then
    return
  end
  if self.passTime - (self.lastPlayAwakerEffectTime or 0) >= bc.DamageFloatInterval then
    local sfxConfigInfo = table.remove(self.effectSfxList, 1)
    local roleUid = sfxConfigInfo.roleUid
    local awakerUid = sfxConfigInfo.awakerUid
    local sfxConfigId = sfxConfigInfo.sfxConfigId
    local checkKey = sfxConfigInfo.checkKey
    local castRoleUid = sfxConfigInfo.castRoleUid
    self:ExcuteAction_SingleAwakerEffect(roleUid, awakerUid, sfxConfigId, checkKey, castRoleUid)
  end
end

function BattleEffextPlayQueueCom:IsHaveUnplayedEffectSfx(roleUid)
  for _, info in ipairs(self.effectSfxList) do
    if info.roleUid == roleUid then
      return true
    end
  end
end

function BattleEffextPlayQueueCom:ExcuteAction_SingleAwakerEffect(roleUid, awakerUid, sfxConfigId, checkKey, castRoleUid)
  self.lastPlayAwakerEffectTime = self.passTime
  local role = bg.battleScene:GetRoleByUid(roleUid)
  if role then
    role:PlayAwakerEffectSfx(roleUid, sfxConfigId, checkKey, castRoleUid)
  end
end

function BattleEffextPlayQueueCom:OnPlay_SingleTarget_EffectSfx(cmdId, targetUid, tSfxConfigIds, castRoleUid)
  if not cmdId then
    return
  end
  local index = self:GetVFXRef(cmdId)
  local sfxConfigId = tSfxConfigIds[index] or tSfxConfigIds[1]
  local maxValue = #tSfxConfigIds
  self:IncreaseVFXRef(cmdId, maxValue)
  table.insert(self.effectSfxList, {
    roleUid = targetUid,
    sfxConfigId = sfxConfigId,
    checkKey = cmdId,
    castRoleUid = castRoleUid
  })
end

function BattleEffextPlayQueueCom:OnPlay_MultiTarget_EffectSfx(cmdId, targetUids, tSfxConfigIds, castRoleUid)
  if not cmdId then
    return
  end
  local maxValue = #tSfxConfigIds
  local index = self:GetVFXRef(cmdId)
  local sfxConfigId = tSfxConfigIds[index] or tSfxConfigIds[1]
  self:IncreaseVFXRef(cmdId, maxValue)
  for _, targetUid in ipairs(targetUids) do
    local role = bg.battleScene:GetRoleByUid(targetUid)
    role:PlayAwakerEffectSfx(targetUid, sfxConfigId, cmdId, castRoleUid)
  end
end

function BattleEffextPlayQueueCom:OnPlay_Role_EffectSfx(cmdId, targetUids, tSfxConfigIds, castRoleUid)
  if not cmdId then
    return
  end
  local maxValue = #tSfxConfigIds
  local index = self:GetVFXRef(cmdId)
  local sfxConfigId = tSfxConfigIds[index] or tSfxConfigIds[1]
  self:IncreaseVFXRef(cmdId, maxValue)
  for _, targetUid in ipairs(targetUids) do
    local roleUid = targetUid.roleUid
    local role = bg.battleScene:GetRoleByUid(roleUid)
    role:PlayEffectSfx(sfxConfigId, castRoleUid)
  end
end

function BattleEffextPlayQueueCom:GetVFXRef(cmdId)
  local ref = self.CMDEffect_VFXRef[cmdId] or nil
  if nil == ref then
    ref = 1
    self.CMDEffect_VFXRef[cmdId] = ref
  end
  return ref
end

function BattleEffextPlayQueueCom:IncreaseVFXRef(cmdId, maxValue)
  local ref = self.CMDEffect_VFXRef[cmdId]
  ref = ref + 1
  ref = maxValue < ref and 1 or ref
  self.CMDEffect_VFXRef[cmdId] = ref
end

return BattleEffextPlayQueueCom
