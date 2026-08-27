local bs_15205 = class("bs_15205", LuaSkillBase)
local base = LuaSkillBase
bs_15205.config = {buffId = 110104}

function bs_15205:ctor()
end

function bs_15205:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_15205_1", 1, self.OnAfterBattleStart)
  self:AddAfterPlaySkillTrigger("bs_15205_2", 1, self.OnAfterPlaySkill, self.caster, nil, nil, nil, nil, nil, nil, eSkillTag.normalSkill)
end

function bs_15205:OnAfterBattleStart()
end

function bs_15205:OnAfterPlaySkill(skill, role)
  if skill.isCommonAttack then
    return
  end
  LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId, 0, true)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, 1, self.arglist[2], true)
end

function bs_15205:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_15205
