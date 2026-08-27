local bs_80014 = class("bs_80014", LuaSkillBase)
local base = LuaSkillBase
bs_80014.config = {}

function bs_80014:ctor()
end

function bs_80014:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_80014_1", 1, self.OnAfterBattleStart)
end

function bs_80014:OnAfterBattleStart()
  local life = self.caster.hp * (1000 - self.arglist[1]) // 1000
  self.caster:SubHp(life)
  LuaSkillCtrl:AddRoleShield(self.caster, eShieldType.Normal, life)
  LuaSkillCtrl:RemoveLife(1, self, self.caster, true, nil, false, true, eHurtType.RealDmg)
end

function bs_80014:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_80014
