local bs_202002 = class("bs_202002", LuaSkillBase)
local base = LuaSkillBase
bs_202002.config = {buffId = 1153}

function bs_202002:ctor()
end

function bs_202002:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_202002_1", 1, self.OnAfterBattleStart)
end

function bs_202002:OnAfterBattleStart()
  LuaSkillCtrl:RegisterRoleHpCostEvent(self, self.caster, {
    800,
    600,
    400,
    200
  }, self.OnHpSubCost, false)
end

function bs_202002:OnHpSubCost(curHp, TargetValue)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, 1, self.arglist[2], true)
end

function bs_202002:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_202002
