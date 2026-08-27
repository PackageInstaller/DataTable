local bs_20170 = class("bs_20170", LuaSkillBase)
local base = LuaSkillBase
bs_20170.config = {}

function bs_20170:ctor()
end

function bs_20170:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.OnBattleEnd, "bs_20170", 1, self.OnBattleEnd)
end

function bs_20170:OnBattleEnd()
  LuaSkillCtrl:RemoveLife(99999, self, self.caster, true, nil, false, true, eHurtType.RealDmg, true)
end

function bs_20170:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_20170
