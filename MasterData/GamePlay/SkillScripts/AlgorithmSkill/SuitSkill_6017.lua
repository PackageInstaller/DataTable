local bs_6017 = class("bs_6017", LuaSkillBase)
local base = LuaSkillBase
bs_6017.config = {}

function bs_6017:ctor()
end

function bs_6017:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.RoleDie, "bs_6017_1", 10, self.OnRoleDie)
  self:AddTrigger(eSkillTriggerType.SetDeadHurt, "bs_6017_4", 1, self.OnSetDeadHurt)
  self.caster.recordTable.pre_pow = 0
  self.caster.recordTable.pre_skill = 0
  self.times = {}
end

function bs_6017:OnSetDeadHurt(context)
  if context.sender == self.caster then
    local buffs = LuaSkillCtrl:GetRoleBuffs(context.target)
    if buffs ~= nil and buffs.Count > 0 then
      self.times[context.target] = 0
      for i = 0, buffs.Count - 1 do
        if buffs[i].buffType == 2 and self.times[context.target] * self.arglist[1] < self.arglist[2] then
          self.times[context.target] = self.times[context.target] + 1
        end
      end
    end
  end
end

function bs_6017:OnRoleDie(killer, role)
  if killer == self.caster and self.times[role] ~= nil and self.times[role] > 0 then
    local times = self.times[role]
    local Num = times * self.arglist[1]
    local add_pow = Num * self.caster.pow // 100
    local add_skill_intensity = Num * self.caster.skill_intensity // 100
    local pre_pow = self.caster.recordTable.pre_pow
    local pre_skill = self.caster.recordTable.pre_skill
    if add_pow > pre_pow then
      self.caster:AddRoleProperty(eHeroAttr.pow, add_pow - pre_pow, eHeroAttrType.Extra)
      self.caster.recordTable.pre_pow = add_pow
    end
    if add_skill_intensity > pre_skill then
      self.caster:AddRoleProperty(eHeroAttr.skill_intensity, add_skill_intensity - pre_skill, eHeroAttrType.Extra)
      self.caster.recordTable.pre_skill = add_skill_intensity
    end
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, self.caster)
    skillResult:EndResult()
  end
end

function bs_6017:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_6017
