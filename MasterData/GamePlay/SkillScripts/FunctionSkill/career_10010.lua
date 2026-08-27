local career_10010 = class("career_10010", LuaSkillBase)
local base = LuaSkillBase
career_10010.config = {beatBackBuff = 2065}

function career_10010:ctor()
end

function career_10010:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTriggerForTable("career_10010_3", 1, self.OnAfterHurt, {
    sender = self.caster,
    extraArg3 = false,
    extraArg1 = eSkillTag.commonAttack,
    extraArg2 = false
  })
end

function career_10010:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if target.hp > 0 and sender == self.caster and not isMiss and skill.isCommonAttack and LuaSkillCtrl:CallRange(1, 1000) <= self.arglist[1] and not isTriggerSet then
    self:PlayChipEffect()
    LuaSkillCtrl:CallBuff(self, target, self.config.beatBackBuff, 1, 3, nil, nil, true)
  end
end

function career_10010:OnCasterDie()
  base.OnCasterDie(self)
end

return career_10010
