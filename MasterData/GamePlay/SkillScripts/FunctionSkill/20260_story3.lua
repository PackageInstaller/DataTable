local bs_20260 = class("bs_20260", LuaSkillBase)
local base = LuaSkillBase
bs_20260.config = {effect_Id = 12048}

function bs_20260:ctor()
end

function bs_20260:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_20260_1", 1, self.OnBattleStart)
end

function bs_20260:OnBattleStart()
  LuaSkillCtrl:CallStartLocalScale(self.caster, Vector3.New(1.4, 1.4, 1.4), 0.3)
  LuaSkillCtrl:CallEffect(self.caster, self.config.effect_Id, self)
end

function bs_20260:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_20260
