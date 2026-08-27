local bs_10217 = class("bs_10217", LuaSkillBase)
local base = LuaSkillBase
bs_10217.config = {buffId = 1114}

function bs_10217:ctor()
end

function bs_10217:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_10217_1", 1, self.OnAfterBattleStart)
end

function bs_10217:OnAfterBattleStart()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, 1, nil, true)
end

function bs_10217:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10217
