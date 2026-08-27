local bs_94103 = class("bs_94103", LuaSkillBase)
local base = LuaSkillBase
bs_94103.config = {buffId = 196}

function bs_94103:ctor()
end

function bs_94103:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_94103_1", 1, self.OnAfterBattleStart)
end

function bs_94103:OnAfterBattleStart()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, 1)
end

function bs_94103:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_94103
