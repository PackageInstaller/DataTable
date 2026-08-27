local bs_15210 = class("bs_15210", LuaSkillBase)
local base = LuaSkillBase
bs_15210.config = {hurtConfig = 2, effectId = 12077}

function bs_15210:ctor()
end

function bs_15210:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_15210_3", 1, self.OnAfterHurt, self.caster, nil, nil, nil, nil, nil, nil, eSkillTag.commonAttack, false)
end

function bs_15210:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if sender == self.caster and not isMiss and not isTriggerSet and skill.isCommonAttack and target.belongNum == eBattleRoleBelong.enemy and target.hp * 1000 // target.maxHp < self.arglist[1] then
    LuaSkillCtrl:CallEffect(target, self.config.effectId, self)
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
    LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.hurtConfig, {
      self.arglist[2]
    }, true)
    skillResult:EndResult()
  end
end

function bs_15210:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_15210
