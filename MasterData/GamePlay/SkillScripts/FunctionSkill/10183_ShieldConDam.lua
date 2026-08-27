local bs_10183 = class("bs_10183", LuaSkillBase)
local base = LuaSkillBase
bs_10183.config = {sheildBuffId = 174, damageFormula = 10011}

function bs_10183:ctor()
end

function bs_10183:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_10183_1", 1, self.OnAfterBattleStart)
end

function bs_10183:OnAfterBattleStart()
  LuaSkillCtrl:StartTimer(nil, self.arglist[2], self.CallBack, self, -1, 0)
end

function bs_10183:CallBack()
  local targetlist = LuaSkillCtrl:CallTargetSelect(self, 9, 20)
  if targetlist.Count > 0 then
    for i = 0, targetlist.Count - 1 do
      local targetRole = targetlist[i].targetRole
      local value = LuaSkillCtrl:GetShield(targetRole, eShieldType.NoRange)
      local value2 = LuaSkillCtrl:GetShield(targetRole, eShieldType.LongRange)
      if 0 < value or 0 < value2 then
        local damage = math.max(1, LuaSkillCtrl:CallFormulaNumberWithSkill(self.config.damageFormula, self.caster, targetRole, self))
        LuaSkillCtrl:RemoveLife(damage, self, targetRole, true, nil, true, false, eHurtType.RealDmg)
      end
    end
  end
end

function bs_10183:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10183
