local sixtower_ult = class("sixtower_ult", LuaSkillBase)
local base = LuaSkillBase
sixtower_ult.config = {effect = 12207}

function sixtower_ult:ctor()
end

function sixtower_ult:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "sixtower_ult", 1, self.OnAfterBattleStart)
end

function sixtower_ult:OnAfterBattleStart()
  self.timer = LuaSkillCtrl:StartTimer(nil, self.arglist[1], self.TimerCallBack, self, -1, self.arglist[1])
end

function sixtower_ult:TimerCallBack()
  local shieldValue = self.caster.maxHp * self.arglist[2] // 1000
  LuaSkillCtrl:AddRoleShield(self.caster, eShieldType.normal, shieldValue)
end

function sixtower_ult:OnCasterDie()
  base.OnCasterDie(self)
  if self.timer ~= nil then
    self.timer:Stop()
    self.timer = nil
  end
end

return sixtower_ult
