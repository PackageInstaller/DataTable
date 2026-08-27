local bs_8112 = class("bs_8112", LuaSkillBase)
local base = LuaSkillBase
bs_8112.config = {buffId = 622}

function bs_8112:ctor()
end

function bs_8112:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_8114_1", 1, self.OnAfterBattleStart)
end

function bs_8112:OnAfterBattleStart()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, 1, nil, true)
end

function bs_8112:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_8112
