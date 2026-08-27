local bs_4010409 = class("bs_4010409", LuaSkillBase)
local base = LuaSkillBase
bs_4010409.config = {
  heal_config = {baseheal_formula = 9990}
}

function bs_4010409:ctor()
end

function bs_4010409:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_4010409_3", 1, self.OnAfterHurt, nil, nil, eBattleRoleBelong.player)
end

function bs_4010409:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if sender.belongNum == eBattleRoleBelong.player and isCrit and not isTriggerSet then
    local value = sender.maxHp * self.arglist[1] // 1000
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, sender)
    LuaSkillCtrl:HealResult(skillResult, self.config.heal_config, {value}, true, true)
    skillResult:EndResult()
  end
end

function bs_4010409:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_4010409
