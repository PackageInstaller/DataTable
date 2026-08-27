local bs_15113 = class("bs_15113", LuaSkillBase)
local base = LuaSkillBase
bs_15113.config = {effectId_up = 10263, effectId_down = 10264}

function bs_15113:ctor()
end

function bs_15113:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_15113_1", 1, self.OnAfterBattleStart)
end

function bs_15113:OnAfterBattleStart()
  local grid = LuaSkillCtrl:GetGridWithRole(self.caster)
  if grid ~= nil then
    LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_up, self)
    LuaSkillCtrl:SetRolePos(grid, self.caster)
    LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_down, self)
  end
  local shieldValue = self.caster.maxHp * self.arglist[1] // 1000
  LuaSkillCtrl:AddRoleShield(self.caster, eShieldType.Normal, shieldValue)
end

function bs_15113:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_15113
