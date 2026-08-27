local bs_15114 = class("bs_15114", LuaSkillBase)
local base = LuaSkillBase
bs_15114.config = {
  buffId = 3004,
  buffTier = 1,
  buffFeature = 22,
  buffId_live = 3009,
  nanaka_buffId = 102603
}

function bs_15114:ctor()
end

function bs_15114:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_15114_1", 300, self.OnAfterBattleStart)
  self:AddSetDeadHurtTrigger("bs_15114_1", 900, self.OnSetDeadHurt, nil, self.caster)
  self:AddAfterHurtTrigger("bs_15114_2", 1, self.OnAfterHurt, self.caster, nil, nil, eBattleRoleBelong.enemy, nil, nil, nil, nil, false)
end

function bs_15114:OnAfterBattleStart()
  self.RealCastSkillYin = BindCallback(self, self.RealCastSkillYin)
  self.timer = LuaSkillCtrl:StartTimer(nil, self.arglist[1], self.RealCastSkillYin, nil, -1)
end

function bs_15114:RealCastSkillYin()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, self.config.buffTier, self.arglist[2])
end

function bs_15114:OnSetDeadHurt(context)
  local NoDeath = LuaSkillCtrl:RoleContainsBuffFeature(context.target, eBuffFeatureType.NoDeath)
  if context.target == self.caster and context.target.roleType == 1 and context.target ~= context.sender and context.target:GetBuffTier(self.config.nanaka_buffId) <= 0 and NoDeath == false then
    LuaSkillCtrl:CallBuff(self, context.target, self.config.buffId_live, 1, 1, true)
    self:RealCastSkillYin()
    self:RemoveSkillTrigger(eSkillTriggerType.SetDeadHurt)
  end
end

function bs_15114:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if isTriggerSet or isMiss or sender ~= self.caster then
    return
  end
  local hasFeature = LuaSkillCtrl:RoleContainsBuffFeature(self.caster, self.config.buffFeature)
  if not hasFeature then
    return
  end
  local shieldValue = (self.caster.pow + self.caster.skill_intensity) * self.arglist[3] // 1000
  LuaSkillCtrl:AddRoleShield(self.caster, eShieldType.Normal, shieldValue)
end

function bs_15114:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_15114
