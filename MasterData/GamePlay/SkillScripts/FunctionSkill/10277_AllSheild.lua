local bs_10277 = class("bs_10277", LuaSkillBase)
local base = LuaSkillBase
bs_10277.config = {shieldFormula = 10087}

function bs_10277:ctor()
end

function bs_10277:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_10277_2", 10, self.OnAfterBattleStart)
end

function bs_10277:OnAfterBattleStart()
  local targetlist = LuaSkillCtrl:CallTargetSelect(self, 6, 10)
  if targetlist.Count < 1 then
    return
  end
  for i = 0, targetlist.Count - 1 do
    local shieldValue = LuaSkillCtrl:CallFormulaNumberWithSkill(self.config.shieldFormula, self.caster, nil, self)
    local targetRole = targetlist[i].targetRole
    LuaSkillCtrl:AddRoleShield(targetRole, eShieldType.Normal, shieldValue)
  end
end

function bs_10277:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10277
