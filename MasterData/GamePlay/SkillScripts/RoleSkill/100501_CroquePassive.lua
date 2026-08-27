local bs_100501 = class("bs_100501", LuaSkillBase)
local base = LuaSkillBase
bs_100501.config = {
  heal_config = {baseheal_formula = 100501},
  heal_time = 15,
  weaponLv = 0
}

function bs_100501:ctor()
end

function bs_100501:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_100501_1", 1, self.OnAfterBattleStart)
end

function bs_100501:OnAfterBattleStart()
  self.passive = LuaSkillCtrl:StartTimer(nil, self.config.heal_time, self.Callback, self, -1)
end

function bs_100501:Callback()
  if self.passive ~= nil and self.passive:IsOver() then
    self.passive = nil
  end
  local num = 0
  if self.caster.recordTable.peopleNum ~= nil and self.caster.recordTable.peopleNum ~= 0 then
    num = self.caster.recordTable.peopleNum
  end
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, self.caster)
  LuaSkillCtrl:HealResult(skillResult, self.config.heal_config, {num}, true)
  skillResult:EndResult()
end

function bs_100501:OnCasterDie()
  if self.passive ~= nil then
    self.passive:Stop()
    self.passive = nil
  end
  base.OnCasterDie(self)
end

function bs_100501:LuaDispose()
  base.LuaDispose(self)
  if self.passive ~= nil then
    self.passive:Stop()
    self.passive = nil
  end
end

return bs_100501
