local bs_15073 = class("bs_15073", LuaSkillBase)
local base = LuaSkillBase
bs_15073.config = {buffId = 1258, configId1 = 26}

function bs_15073:ctor()
end

function bs_15073:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_15073_3", 1, self.OnAfterHurt, self.caster, nil, nil, nil, nil, nil, nil, eSkillTag.commonAttack)
end

function bs_15073:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if skill.isCommonAttack and not isTriggerSet then
    local damageNum = self.caster.maxHp - self.caster.hp
    if 0 < damageNum then
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
      LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.configId1, {damageNum}, true)
      skillResult:EndResult()
    end
  end
end

function bs_15073:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_15073
