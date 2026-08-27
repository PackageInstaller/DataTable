local bs_30029 = class("bs_30029", LuaSkillBase)
local base = LuaSkillBase
bs_30029.config = {
  heal_config = {
    baseheal_formula = 501,
    heal_number = 0,
    correct_formula = 9990
  }
}

function bs_30029:ctor()
end

function bs_30029:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_30029_1", 1, self.OnAfterBattleStart)
  self.maxShieldVal = 0
end

function bs_30029:OnAfterBattleStart()
  LuaSkillCtrl:StartTimer(nil, self.arglist[1], self.CallBack, self, -1)
end

function bs_30029:CallBack()
  local targetlist = LuaSkillCtrl:CallTargetSelect(self, 6, 10)
  if targetlist.Count < 1 then
    return
  end
  for i = 0, targetlist.Count - 1 do
    local targetRole = targetlist[i].targetRole
    local shieldVal = LuaSkillCtrl:GetShield(targetRole, eShieldType.Normal)
    if shieldVal > self.maxShieldVal then
      self.maxShieldVal = shieldVal
    end
  end
  targetlist = LuaSkillCtrl:CallTargetSelect(self, 52, 10)
  if targetlist.Count < 1 then
    return
  end
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, targetlist[0].targetRole)
  LuaSkillCtrl:HealResult(skillResult, self.config.heal_config, {
    self.maxShieldVal
  }, true, true)
  skillResult:EndResult()
  self.maxShieldVal = 0
end

function bs_30029:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_30029
