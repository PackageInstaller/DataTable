local bs_15164 = class("bs_15164", LuaSkillBase)
local base = LuaSkillBase
bs_15164.config = {effectId_1 = 12095, effectId_2 = 12096}

function bs_15164:ctor()
end

function bs_15164:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_15164_1", 1, self.AfterBattleStart)
end

function bs_15164:AfterBattleStart()
  local gridCheck = BindCallback(self, self.checkLocation)
  self.timer = LuaSkillCtrl:StartTimer(nil, self.arglist[1], gridCheck, nil, -1)
end

function bs_15164:checkLocation()
  local grid_old = self.grid
  local grid_new = LuaSkillCtrl:GetGridWithRole(self.caster)
  if grid_old ~= grid_new then
    self.grid = grid_new
    return
  end
  LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_1, self)
  local shieldValue = self.arglist[2] * self.caster.maxHp // 1000
  LuaSkillCtrl:AddRoleShield(self.caster, eShieldType.Normal, shieldValue)
  self.grid = grid_new
end

function bs_15164:OnCasterDie()
  base.OnCasterDie(self)
end

function bs_15164:LuaDispose()
  base.LuaDispose(self)
  self.grid = nil
end

return bs_15164
