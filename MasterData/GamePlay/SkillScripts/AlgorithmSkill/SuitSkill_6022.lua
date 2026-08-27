local bs_6022 = class("bs_6022", LuaSkillBase)
local base = LuaSkillBase
bs_6022.config = {buffId_1 = 602201, buffId_2 = 602202}

function bs_6022:ctor()
end

function bs_6022:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_6022_4", 1, self.OnAfterBattleStart)
  self:AddAfterPlaySkillTrigger("bs_6022_1", 1, self.OnAfterPlaySkill, self.caster, nil, nil, nil, nil, nil, nil, eSkillTag.normalSkill)
end

function bs_6022:OnAfterBattleStart()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_1, 1, nil, true)
end

function bs_6022:OnAfterPlaySkill(skill, role)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_2, 1, self.arglist[2], true)
end

function bs_6022:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_6022
