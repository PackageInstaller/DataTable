local bs_4024 = class("bs_4024", LuaSkillBase)
local base = LuaSkillBase
bs_4024.config = {}

function bs_4024:ctor()
end

function bs_4024:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_4024_1", 110, self.OnAfterBattleStart)
end

function bs_4024:OnAfterBattleStart()
  LuaSkillCtrl:StartTimer(nil, self.arglist[1], BindCallback(self, self.OnLoopDamage), nil, -1, self.arglist[1])
end

function bs_4024:OnLoopDamage()
  local shieldValue = self.caster.def * self.arglist[2] // 1000 + self.caster.magic_res * self.arglist[2] // 1000
  if 0 < shieldValue then
    LuaSkillCtrl:AddRoleShield(self.caster, eShieldType.Normal, shieldValue)
  end
end

function bs_4024:LuaDispose()
  base.LuaDispose(self)
end

function bs_4024:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_4024
