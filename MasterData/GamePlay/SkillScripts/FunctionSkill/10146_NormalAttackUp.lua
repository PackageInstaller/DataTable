local bs_10146 = class("bs_10146", LuaSkillBase)
local base = LuaSkillBase
bs_10146.config = {
  buffId = 1028,
  buffTier = 1,
  atkBuffId = 1030
}

function bs_10146:ctor()
end

function bs_10146:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.AfterPlaySkill, "bs_10146_1", 2, self.OnAfterPlaySkill)
  self:AddSetHurtTrigger("bs_10146_3", 3, self.OnSetHurt, self.caster)
  self.caster.recordTable["10146_NormalAttakTime"] = 0
end

function bs_10146:OnAfterPlaySkill(skill, role)
  if skill.maker == self.caster and skill.isCommonAttack then
    self.caster.recordTable["10146_NormalAttakTime"] = self.caster.recordTable["10146_NormalAttakTime"] + 1
  end
end

function bs_10146:OnSetHurt(context)
  if context.sender == self.caster and context.skill.isCommonAttack then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.atkBuffId, self.arglist[1], nil, true)
  end
end

function bs_10146:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10146
