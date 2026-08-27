local bs_1014 = class("bs_1014", LuaSkillBase)
local base = LuaSkillBase
bs_1014.config = {buffId_def = 505}

function bs_1014:ctor()
end

function bs_1014:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_1014", 1, self.OnAfterBattleStart)
end

function bs_1014:OnAfterBattleStart()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_def, 1, nil, true)
end

function bs_1014:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_1014
