local bs_213402 = class("bs_213402", LuaSkillBase)
local base = LuaSkillBase
bs_213402.config = {
  actionId = 1020,
  actionId_time = 20,
  action_speed = 1,
  buffId_Mark = 213403,
  effectId_Mark = 213404
}

function bs_213402:ctor()
end

function bs_213402:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_213402_1", 10, self.OnAfterBattleStart)
  self.target = nil
  self.num = 0
  self.pow_pool = 0
  self.skill_intensity_pool = 0
  self.pow_max_pool = 0
  self.skill_intensity_max_pool = 0
  self:AddLuaTrigger(eSkillLuaTrigger.OnRecoverHeal, self.OnRecoverHeal)
  self:AddOnRoleDieTrigger("bs_213402_2", 1, self.OnRoleDie, nil, nil, nil, nil)
end

function bs_213402:OnAfterBattleStart()
  local time = self.config.actionId_time
  self:CallCasterWait(time)
  LuaSkillCtrl:CallRoleAction(self.caster, self.config.actionId, self.config.action_speed)
  local target_pow, target_skill_intensity, target
  local targets_pow = LuaSkillCtrl:CallTargetSelect(self, 84, 10)
  if targets_pow.Count > 0 then
    for i = 0, targets_pow.Count - 1 do
      target_pow = targets_pow[i].targetRole
      if target_pow ~= nil then
        break
      end
    end
  end
  if target_pow == nil then
    target_pow = targets_pow[0].targetRole
  end
  local targets_skill_intensity = LuaSkillCtrl:CallTargetSelect(self, 54, 10)
  if targets_skill_intensity.Count > 0 then
    for i = 0, targets_skill_intensity.Count - 1 do
      target_skill_intensity = targets_skill_intensity[i].targetRole
      if target_skill_intensity ~= nil then
        break
      end
    end
    if target_skill_intensity == nil then
      target_skill_intensity = targets_skill_intensity[0].targetRole
    end
  end
  if target_pow.pow >= target_skill_intensity.skill_intensity then
    target = target_pow
  else
    target = target_skill_intensity
  end
  self.target = target
  self.caster:LookAtTarget(self.target)
  self.loop_effect1 = LuaSkillCtrl:CallEffect(self.target, self.config.effectId_Mark, self)
  self.loop_effect2 = LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_Mark, self, nil, self.target)
  self.looper = LuaSkillCtrl:StartTimer(nil, 15, BindCallback(self, self.UpdataAttr, self.target, 1), nil, -1, 15)
end

function bs_213402:UpdataAttr(target, num)
  if self.target == nil then
    return
  end
  if self.num <= 0 then
    self.num = 0
  end
  if self.num > self.arglist[1] then
    self.num = self.arglist[1]
  elseif num == 1 then
    LuaSkillCtrl:CallBuff(self, self.target, self.config.buffId_Mark, 1, nil, true)
  elseif num == -1 then
    LuaSkillCtrl:DispelBuff(self.target, self.config.buffId_Mark, 1, true)
  end
  self.num = self.target:GetBuffTier(self.config.buffId_Mark)
  if self.pow_pool == 0 then
    self.pow_max_pool = target.pow
    self.skill_intensity_max_pool = target.skill_intensity
    self.pow_pool = self.pow_max_pool * self.num // 100
    self.skill_intensity_pool = self.skill_intensity_max_pool * self.num // 100
    self.target:AddRoleProperty(eHeroAttr.pow, -self.pow_pool, eHeroAttrType.Extra)
    self.target:AddRoleProperty(eHeroAttr.skill_intensity, -self.skill_intensity_pool, eHeroAttrType.Extra)
    self.caster:AddRoleProperty(eHeroAttr.pow, self.pow_pool, eHeroAttrType.Extra)
    self.caster:AddRoleProperty(eHeroAttr.skill_intensity, self.skill_intensity_pool, eHeroAttrType.Extra)
  else
    self.target:AddRoleProperty(eHeroAttr.pow, self.pow_pool, eHeroAttrType.Extra)
    self.target:AddRoleProperty(eHeroAttr.skill_intensity, self.skill_intensity_pool, eHeroAttrType.Extra)
    self.caster:AddRoleProperty(eHeroAttr.pow, -self.pow_pool, eHeroAttrType.Extra)
    self.caster:AddRoleProperty(eHeroAttr.skill_intensity, -self.skill_intensity_pool, eHeroAttrType.Extra)
    self.pow_max_pool = target.pow
    self.skill_intensity_max_pool = target.skill_intensity
    self.pow_pool = self.pow_max_pool * self.num // 100
    self.skill_intensity_pool = self.skill_intensity_max_pool * self.num // 100
    self.target:AddRoleProperty(eHeroAttr.pow, -self.pow_pool, eHeroAttrType.Extra)
    self.target:AddRoleProperty(eHeroAttr.skill_intensity, -self.skill_intensity_pool, eHeroAttrType.Extra)
    self.caster:AddRoleProperty(eHeroAttr.pow, self.pow_pool, eHeroAttrType.Extra)
    self.caster:AddRoleProperty(eHeroAttr.skill_intensity, self.skill_intensity_pool, eHeroAttrType.Extra)
  end
end

function bs_213402:OnRecoverHeal(role)
  if role == self.target and self.num > 0 then
    self:UpdataAttr(self.target, -1)
  end
end

function bs_213402:OnRoleDie(killer, role)
  if role == self.target then
    if self.loop_effect1 ~= nil then
      self.loop_effect1:Die()
      self.loop_effect1 = nil
    end
    if self.loop_effect2 ~= nil then
      self.loop_effect2:Die()
      self.loop_effect2 = nil
    end
    if self.looper ~= nil then
      self.looper:Stop()
      self.looper = nil
    end
    self.target = nil
  end
end

function bs_213402:OnCasterDie()
  base.OnCasterDie(self)
  if self.looper ~= nil then
    self.looper:Stop()
    self.looper = nil
  end
  if self.loop_effect1 ~= nil then
    self.loop_effect1:Die()
    self.loop_effect1 = nil
  end
  if self.loop_effect2 ~= nil then
    self.loop_effect2:Die()
    self.loop_effect2 = nil
  end
end

return bs_213402
