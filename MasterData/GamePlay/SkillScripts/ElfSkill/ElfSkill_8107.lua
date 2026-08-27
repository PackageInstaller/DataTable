local bs_8107 = class("bs_8107", LuaSkillBase)
local base = LuaSkillBase
bs_8107.config = {buffId = 617}

function bs_8107:ctor()
end

function bs_8107:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_8107_1", 1, self.OnAfterBattleStart)
end

function bs_8107:OnAfterBattleStart()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, 1, nil, true)
end

function bs_8107:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_8107
