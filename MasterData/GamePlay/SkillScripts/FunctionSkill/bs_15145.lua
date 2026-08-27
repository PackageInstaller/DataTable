local bs_15145 = class("bs_15145", LuaSkillBase)
local base = LuaSkillBase
bs_15145.config = {
  formula = 10106,
  effectId = 12066,
  buffId = 1059
}

function bs_15145:ctor()
end

function bs_15145:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_15144_3", 1, self.OnAfterHurt, nil, nil, self.caster.belongNum, nil, eBattleRoleType.character, nil, nil, eSkillTag.commonAttack, false)
  self.damageNum = 0
end

function bs_15145:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if not isTriggerSet and skill.isCommonAttack and isCrit then
    self:findMax()
    local skillResult1 = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
    LuaSkillCtrl:HurtResultWithConfig(self, skillResult1, 14, {
      self.damageNum
    }, true, true)
    LuaSkillCtrl:CallEffect(target, self.config.effectId, self)
    LuaSkillCtrl:CallBuff(self, target, self.config.buffId, 1, 75)
  end
end

function bs_15145:findMax()
  local role, baseDamage = LuaSkillCtrl:CallFindMaxPowOrSkillIntensityRole()
  if role ~= nil then
    self.damageNum = baseDamage * self.arglist[1] // 1000
  end
end

function bs_15145:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_15145
