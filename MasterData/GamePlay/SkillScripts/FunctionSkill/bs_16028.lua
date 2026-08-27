local bs_16028 = class("bs_16028", LuaSkillBase)
local base = LuaSkillBase
bs_16028.config = {}

function bs_16028:ctor()
end

function bs_16028:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_16028_1", 1, self.OnAfterBattleStart)
  self:AddOnRoleDieTrigger("bs_16028_2", 1, self.OnRoleDie, nil, nil, nil, eBattleRoleBelong.player)
end

function bs_16028:OnAfterBattleStart()
  if self.caster.belongNum == 2 then
    local eventFunc = BindCallback(self, self.eventFunction)
    self.timer = LuaSkillCtrl:StartTimer(nil, self.arglist[1], eventFunc, nil, -1, self.arglist[1])
  end
end

function bs_16028:OnRoleDie(killer, role, killSkill)
  if role.belongNum == eBattleRoleBelong.player then
    local shieldValue_expect = self.caster.maxHp * self.arglist[2] // 1000
    local hurt = shieldValue_expect * self.arglist[3] // 1000
    LuaSkillCtrl:ReduceRoleShield(self.caster, eShieldType.Normal, hurt)
  end
end

function bs_16028:eventFunction()
  local shieldValue_expect = self.caster.maxHp * self.arglist[2] // 1000
  local shieldValue_current = LuaSkillCtrl:GetShield(self.caster, eShieldType.Normal)
  if shieldValue_current == nil or shieldValue_current <= 0 then
    LuaSkillCtrl:AddRoleShield(self.caster, eShieldType.Normal, shieldValue_expect)
  elseif shieldValue_expect > shieldValue_current then
    LuaSkillCtrl:AddRoleShield(self.caster, eShieldType.Normal, shieldValue_expect - shieldValue_current)
  end
end

function bs_16028:LuaDispose()
  base.LuaDispose(self)
  if self.timer ~= nil then
    self.timer:Stop()
    self.timer = nil
  end
end

function bs_16028:OnCasterDie()
  base.OnCasterDie(self)
  if self.timer ~= nil then
    self.timer:Stop()
    self.timer = nil
  end
end

return bs_16028
