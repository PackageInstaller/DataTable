local bs_20257 = class("bs_20257", LuaSkillBase)
local base = LuaSkillBase
bs_20257.config = {}

function bs_20257:ctor()
end

function bs_20257:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_20257_1", 1, self.OnBattleStart)
  self:AddSetDeadHurtTrigger("bs_20257_2", 20, self.CallStory2, nil, self.caster)
end

function bs_20257:OnBattleStart()
  LuaSkillCtrl:CallStartLocalScale(self.caster, Vector3.New(1.4, 1.4, 1.4), 0.3)
  self:CallStory1()
end

function bs_20257:CallStory1()
  LuaSkillCtrl:StartAvgWithPauseGame("23carnival_s06_2")
end

function bs_20257:CallStory2()
  LuaSkillCtrl:StartAvgWithPauseGame("23carnival_s06_3")
end

function bs_20257:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_20257
