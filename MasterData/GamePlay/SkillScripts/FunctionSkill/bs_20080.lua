local bs_20080 = class("bs_20080", LuaSkillBase)
local base = LuaSkillBase
bs_20080.config = {}

function bs_20080:ctor()
end

function bs_20080:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_20080_1", 1, self.OnAfterBattleStart)
end

function bs_20080:OnAfterBattleStart()
  LuaSkillCtrl:CallBuff(self, self.caster, 1193, 1, 999)
end

function bs_20080:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_20080
