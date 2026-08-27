local bs_203101 = class("bs_203101", LuaSkillBase)
local base = LuaSkillBase
bs_203101.config = {effectId = 10594, buffId = 208}

function bs_203101:ctor()
end

function bs_203101:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterPlaySkill, "bs_203101_11", 1, self.OnAfterPlaySkill)
end

function bs_203101:OnAfterPlaySkill(skill, role)
  if role.camp == self.caster.camp and role.belongNum == self.caster.belongNum and not skill.isCommonAttack then
    if role ~= self.caster then
      LuaSkillCtrl:CallEffect(role, self.config.effectId, self)
    end
    LuaSkillCtrl:CallBuff(self, role, self.config.buffId, 1, self.arglist[1])
  end
end

function bs_203101:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_203101
