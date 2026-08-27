local bs_80019 = class("bs_80019", LuaSkillBase)
local base = LuaSkillBase
bs_80019.config = {
  heal_config = {baseheal_formula = 501}
}

function bs_80019:ctor()
end

function bs_80019:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_80019_2", 1, self.OnAfterHurt, self.caster)
end

function bs_80019:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if sender == self.caster and not isMiss and 0 < hurt and not isTriggerSet then
    local value = hurt * self.arglist[1] // 1000
    local targetList = LuaSkillCtrl:CallTargetSelect(self, 47, 10)
    if 0 < targetList.Count then
      for i = 0, targetList.Count - 1 do
        local targetRole = targetList[i].targetRole
        if 1 < targetRole.intensity then
          local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, targetRole)
          LuaSkillCtrl:HealResult(skillResult, self.config.heal_config, {value}, true)
          skillResult:EndResult()
          break
        end
      end
    end
  end
end

function bs_80019:OnAfterBattleStart()
end

function bs_80019:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_80019
