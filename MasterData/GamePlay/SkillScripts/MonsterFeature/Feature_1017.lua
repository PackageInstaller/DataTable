local bs_1017 = class("bs_1017", LuaSkillBase)
local base = LuaSkillBase
bs_1017.config = {buffId_bati = 196}

function bs_1017:ctor()
end

function bs_1017:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_1017", 1, self.OnAfterBattleStart)
end

function bs_1017:OnAfterBattleStart()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_bati, 1, nil, true)
end

function bs_1017:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_1017
