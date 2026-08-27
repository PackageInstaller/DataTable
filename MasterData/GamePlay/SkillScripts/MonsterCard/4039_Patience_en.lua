local bs_4039 = class("bs_4039", LuaSkillBase)
local base = LuaSkillBase
bs_4039.config = {buffId_1 = 40391, buffId_2 = 40392}

function bs_4039:ctor()
end

function bs_4039:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.AfterPlaySkill, "bs_4039_2", 1, self.OnAfterPlaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_4039_1", 1, self.OnAfterBattleStart)
end

function bs_4039:OnAfterBattleStart()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_1, 1, nil, true)
end

function bs_4039:OnAfterPlaySkill(skill, role)
  if role == self.caster and skill.isUltSkill then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_2, 1, nil, true)
  end
end

function bs_4039:LuaDispose()
  base.LuaDispose(self)
end

function bs_4039:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_4039
