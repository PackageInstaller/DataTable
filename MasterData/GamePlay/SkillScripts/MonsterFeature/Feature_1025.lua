local Feature_1025 = class("Feature_1025", LuaSkillBase)
local base = LuaSkillBase
Feature_1025.config = {}

function Feature_1025:ctor()
end

function Feature_1025:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "Feature_1025", 1, self.OnAfterBattleStart)
end

function Feature_1025:OnAfterBattleStart()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_1, 4, nil, true)
  local eventFunc = BindCallback(self, self.eventFunction)
  self.timer = LuaSkillCtrl:StartTimer(nil, self.arglist[1], eventFunc, nil, -1, self.arglist[1])
end

function Feature_1025:eventFunction()
  local shieldValue_expect = self.caster.maxHp * self.arglist[2] // 1000
  local shieldValue_current = LuaSkillCtrl:GetShield(self.caster, eShieldType.Normal)
  if shieldValue_current == nil then
    LuaSkillCtrl:AddRoleShield(self.caster, eShieldType.Normal, shieldValue_expect)
  elseif shieldValue_expect > shieldValue_current then
    LuaSkillCtrl:AddRoleShield(self.caster, eShieldType.Normal, shieldValue_expect - shieldValue_current)
  end
end

function Feature_1025:OnCasterDie()
  base.OnCasterDie(self)
  if self.timer ~= nil then
    self.timer:Stop()
    self.timer = nil
  end
end

return Feature_1025
