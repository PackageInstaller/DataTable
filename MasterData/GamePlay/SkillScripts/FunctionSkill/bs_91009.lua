local bs_91009 = class("bs_91009", LuaSkillBase)
local base = LuaSkillBase
bs_91009.config = {}

function bs_91009:ctor()
end

function bs_91009:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.AfterBattleStart, "bs_91009_1", 1, self.OnAfterBattleStart)
end

function bs_91009:OnAfterBattleStart()
  local arriveCallBack = BindCallback(self, self.OnArriveAction)
  self.timer = LuaSkillCtrl:StartTimer(nil, self.arglist[1], arriveCallBack, nil, -1)
end

function bs_91009:OnArriveAction()
  if self.timer ~= nil and self.timer:IsOver() then
    self.timer = nil
  end
  local shieldValue = self.caster.maxHp * self.arglist[2] // 1000
  LuaSkillCtrl:AddRoleShield(self.caster, eShieldType.Normal, shieldValue)
end

function bs_91009:OnCasterDie()
  base.OnCasterDie(self)
  if self.timer ~= nil then
    self.timer:Stop()
    self.timer = nil
  end
end

return bs_91009
