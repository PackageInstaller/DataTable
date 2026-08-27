local bs_1004 = class("bs_1004", LuaSkillBase)
local base = LuaSkillBase
bs_1004.config = {buffId_def = 502}

function bs_1004:ctor()
end

function bs_1004:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_1000_1", 1, self.OnAfterBattleStart)
end

function bs_1004:OnAfterBattleStart()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_def, 1, nil, true)
end

function bs_1004:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_1004
