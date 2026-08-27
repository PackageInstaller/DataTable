local bs_8104 = class("bs_8104", LuaSkillBase)
local base = LuaSkillBase
bs_8104.config = {buffId = 614}

function bs_8104:ctor()
end

function bs_8104:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_8104_1", 1, self.OnAfterBattleStart)
end

function bs_8104:OnAfterBattleStart()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, 1, nil, true)
end

function bs_8104:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_8104
