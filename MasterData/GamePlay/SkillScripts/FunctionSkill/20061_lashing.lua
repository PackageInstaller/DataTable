local bs_20061 = class("bs_20061", LuaSkillBase)
local base = LuaSkillBase
bs_20061.config = {formula1 = 10106, formula2 = 10158}

function bs_20061:ctor()
end

function bs_20061:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_20061_1", 99, self.OnAfterBattleStart)
end

function bs_20061:OnAfterBattleStart()
  if self.caster.maxHp <= 0 then
    return
  end
  if self.caster.hp * 1000 // self.caster.maxHp > 150 then
    local hurt1 = LuaSkillCtrl:CallFormulaNumberWithSkill(self.config.formula1, self.caster, self.caster, self)
    LuaSkillCtrl:RemoveLife(hurt1, self, self.caster, true, nil, true, false, eHurtType.RealDmg)
  elseif self.caster.hp * 1000 // self.caster.maxHp > 50 then
    local hurt2 = LuaSkillCtrl:CallFormulaNumberWithSkill(self.config.formula2, self.caster, self.caster, self)
    LuaSkillCtrl:RemoveLife(hurt2, self, self.caster, true, nil, true, false, eHurtType.RealDmg)
  else
    return
  end
end

function bs_20061:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_20061
