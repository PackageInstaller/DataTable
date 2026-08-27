local bs_100801 = class("bs_100801", LuaSkillBase)
local base = LuaSkillBase
bs_100801.config = {
  weaponLv = 0,
  buffId_159 = 100802,
  buffId_atkspeed = 100803
}

function bs_100801:ctor()
end

function bs_100801:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.caster.recordTable.BJ = true
  self.caster.recordTable["arglist[1]"] = self.arglist[1]
  self:AddAfterHealTrigger("bs_100801_1", 1, self.OnAfterHeal, self.caster, nil, nil, nil, nil, nil, 100800)
  self:AddAfterAddBuffTrigger("bs_100801_2", 1, self.OnAfterAddBuff, nil, self.caster, nil, nil, nil, nil, eBuffFeatureType.Taunt)
  self:AddBuffDieTrigger("bs_100801_3", 1, self.OnBuffDie, self.caster, nil, nil, nil, eBuffFeatureType.Taunt)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_100801_4", 1, self.OnAfterBattleStart)
  self:AddOnRoleDieTrigger("bs_100801_5", 1, self.OnRoleDie)
  self.RoleAttackRange = self.caster.attackRange
  if 1 <= self.config.weaponLv then
    self:AddSelfTrigger(eSkillTriggerType.AfterPlaySkill, "bs_100801_5", 1, self.OnAfterPlaySkill)
  end
end

function bs_100801:OnAfterBattleStart()
  local num = 10 - self.caster.attackRange
  self.caster:AddRoleProperty(eHeroAttr.attackRange, num, eHeroAttrType.Origin)
end

function bs_100801:OnAfterHeal(sender, target, skill, heal, isStealHeal)
  if skill.dataId == 100800 and sender == self.caster and not isStealHeal then
    LuaSkillCtrl:CallBuff(self, target, self.config.buffId_159, 1, self.arglist[2])
  end
end

function bs_100801:OnAfterAddBuff(buff, target)
  local num = self.RoleAttackRange - self.caster.attackRange
  self.caster:AddRoleProperty(eHeroAttr.attackRange, num, eHeroAttrType.Origin)
  self.caster.recordTable.BJ = false
  self.tauntTarget = buff.maker
end

function bs_100801:OnBuffDie(buff, target, removeType)
  local num = 10 - self.caster.attackRange
  self.caster:AddRoleProperty(eHeroAttr.attackRange, num, eHeroAttrType.Origin)
  self.caster.recordTable.BJ = true
  self.tauntTarget = nil
end

function bs_100801:OnRoleDie(killer, role, skill)
  if role == self.tauntTarget then
    local num = 10 - self.caster.attackRange
    self.caster:AddRoleProperty(eHeroAttr.attackRange, num, eHeroAttrType.Origin)
    self.caster.recordTable.BJ = true
    self.tauntTarget = nil
  end
end

function bs_100801:OnAfterPlaySkill(skill, role)
  if role == self.caster and skill.isCommonAttack and self.config.weaponLv >= 1 and LuaSkillCtrl:CallRange(1, 1000) <= self.arglist[3] then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_atkspeed, 1, self.arglist[4], true)
  end
end

function bs_100801:OnCasterDie()
  base.OnCasterDie(self)
end

function bs_100801:LuaDispose()
  base.LuaDispose(self)
  self.tauntTarget = nil
end

return bs_100801
