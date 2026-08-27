local bs_15215 = class("bs_15215", LuaSkillBase)
local base = LuaSkillBase
bs_15215.config = {buffId = 110113}

function bs_15215:ctor()
end

function bs_15215:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_15215_1", 1, self.OnAfterBattleStart)
  self:AddSelfTrigger(eSkillTriggerType.AfterPlaySkill, "bs_15215_2", 1, self.OnAfterPlaySkill)
end

function bs_15215:OnAfterBattleStart()
end

function bs_15215:OnAfterPlaySkill(skill, role)
  if role == self.caster and not skill.isCommonAttack then
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId, 0)
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, 1, self.arglist[2], true)
  end
end

function bs_15215:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_15215
