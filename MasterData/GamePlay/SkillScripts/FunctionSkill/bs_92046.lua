local bs_92046 = class("bs_92046", LuaSkillBase)
local base = LuaSkillBase
bs_92046.config = {
  fireSuppressNeedCount = 1,
  buffId_enemy = 2055,
  configId = 3,
  effectId = 10974
}

function bs_92046:ctor()
end

function bs_92046:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterPlaySkillTrigger("bs_92046_01", 1, self.OnAfterPlaySkill, nil, nil, nil, nil, nil, nil, nil, eSkillTag.commonAttack)
  self:AddOnRoleDieTrigger("bs_92046_02", 1, self.OnRoleDie)
  self:AddAfterAddBuffTrigger("bs_92046_03", 1, self.OnAfterAddBuff, nil, nil, nil, nil, self.config.buffId_enemy)
  self.targetTable = {}
  self.maxCount = 0
  self.targetRole = nil
  self.countBuffEffect = {}
end

function bs_92046:OnAfterPlaySkill(skill, role)
  if skill.isCommonAttack then
    local target = role.recordTable.lastAttackRole
    if target ~= nil and target.belongNum ~= self.caster.belongNum and skill.maker.belongNum == self.caster.belongNum then
      self:OnTargetChange(skill.maker, target)
    end
  end
end

function bs_92046:OnRoleDie(killer, role)
  if role.belongNum == self.caster.belongNum then
    self:OnTargetChange(role, nil)
  end
  if role.belongNum ~= self.caster.belongNum then
    local newBuffTier = role:GetBuffTier(self.config.buffId_enemy)
    if self.countBuffEffect[role.uid] ~= nil then
      self.countBuffEffect[role.uid]:Die()
      self.countBuffEffect[role.uid] = nil
    end
  end
end

function bs_92046:OnTargetChange(role, targetRole)
  local lastTargetRole = self.targetTable[role]
  local lastTargetUid
  if lastTargetRole ~= nil then
    lastTargetUid = lastTargetRole.uid
  end
  local nextTargetUid
  if targetRole ~= nil then
    nextTargetUid = targetRole.uid
  end
  if lastTargetUid == nextTargetUid then
    return
  end
  self.targetTable[role] = targetRole
  if targetRole == nil then
    return
  end
  local maxCount = 0
  for k, v in pairs(self.targetTable) do
    if v == targetRole then
      maxCount = maxCount + 1
    end
  end
  if maxCount >= self.config.fireSuppressNeedCount then
    local buffTier = targetRole:GetBuffTier(self.config.buffId_enemy)
    if maxCount > buffTier then
      LuaSkillCtrl:DispelBuff(targetRole, 2055, 0)
      LuaSkillCtrl:CallBuff(self, targetRole, 2055, maxCount)
    end
  end
end

function bs_92046:OnAfterAddBuff(buff, target)
  if buff.dataId == self.config.buffId_enemy and target ~= nil and target.hp > 0 then
    local buffTier1 = target:GetBuffTier(self.config.buffId_enemy)
    local isHaveEffect = self.countBuffEffect[target.uid] ~= nil
    if not isHaveEffect or buffTier1 == 0 then
      self.countBuffEffect[target.uid] = LuaSkillCtrl:CallEffect(target, self.config.effectId, self)
      LuaSkillCtrl:EffectSetCountValue(self.countBuffEffect[target.uid], buffTier1 - 1)
    else
      LuaSkillCtrl:EffectSetCountValue(self.countBuffEffect[target.uid], buffTier1 - 1)
    end
  end
end

function bs_92046:OnCasterDie()
  base.OnCasterDie(self)
end

function bs_92046:LuaDispose()
  self.countBuffEffect = nil
  self.targetTable = nil
  base.LuaDispose(self)
end

return bs_92046
