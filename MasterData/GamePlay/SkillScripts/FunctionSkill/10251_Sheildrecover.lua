local bs_10251 = class("bs_10251", LuaSkillBase)
local base = LuaSkillBase
bs_10251.config = {
  heal_config = {baseheal_formula = 10139}
}

function bs_10251:ctor()
end

function bs_10251:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_100501_1", 1, self.OnAfterBattleStart)
end

function bs_10251:OnAfterBattleStart()
  self.timer = LuaSkillCtrl:StartTimer(nil, self.arglist[1], self.Callback, self, -1)
end

function bs_10251:Callback()
  self:PlayChipEffect()
  if self.timer ~= nil and self.timer:IsOver() then
    self.timer = nil
  end
  local Value = math.max(1, self.arglist[2] * self.caster.skill_intensity // 1000)
  LuaSkillCtrl:AddRoleShield(self.caster, eShieldType.Normal, Value)
end

function bs_10251:OnCasterDie()
  base.OnCasterDie(self)
  if self.timer ~= nil then
    self.timer:Stop()
    self.timer = nil
  end
end

return bs_10251
