local card_10023 = class("card_10023", LuaSkillBase)
local base = LuaSkillBase
card_10023.config = {buffId1 = 1600}

function card_10023:ctor()
end

function card_10023:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTriggerForTable("card_10023", 1, self.OnAfterHurt, {
    sender = self.caster,
    extraArg1 = eSkillTag.commonAttack,
    extraArg2 = false,
    extraArg3 = false
  })
  self.add_pow = 0
end

function card_10023:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if target.hp > 0 and sender == self.caster and skill.isCommonAttack and not isMiss and not isTriggerSet then
    if target:GetBuffTier(self.config.buffId1) == 0 then
      self.add_pow = self.arglist[1] * target.pow // 1000
    end
    if target:GetBuffTier(self.config.buffId1) > 14 then
      self:RemoveSkillTrigger(eSkillTriggerType.AfterHurt)
      return
    end
    LuaSkillCtrl:CallBuff(self, target, self.config.buffId1, 1, nil, true)
    sender:AddRoleProperty(eHeroAttr.pow, self.add_pow, eHeroAttrType.Extra)
    target:AddRoleProperty(eHeroAttr.pow, -self.add_pow, eHeroAttrType.Extra)
  end
end

function card_10023:OnCasterDie()
  base.OnCasterDie(self)
end

return card_10023
