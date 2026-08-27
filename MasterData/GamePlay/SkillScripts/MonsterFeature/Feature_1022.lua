local Feature_1022 = class("Feature_1022", LuaSkillBase)
local base = LuaSkillBase
Feature_1022.config = {buffId_1 = 110134, buffId_2 = 110135}

function Feature_1022:ctor()
end

function Feature_1022:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "Feature_1022_2", 1, self.OnAfterBattleStart)
  self:AddAfterPlaySkillTrigger("Feature_1022", 1, self.OnAfterPlaySkill, nil, nil, nil, nil, nil, nil, nil, eSkillTag.ultSkill)
end

function Feature_1022:OnAfterBattleStart()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_1, 1, nil, true)
end

function Feature_1022:OnAfterPlaySkill(skill, role)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_2, 1, self.arglist[3], true)
end

function Feature_1022:OnCasterDie()
  base.OnCasterDie(self)
end

return Feature_1022
