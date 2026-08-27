local bs_92058 = class("bs_92058", LuaSkillBase)
local base = LuaSkillBase
bs_92058.config = {
  buffId = 2050,
  buffId2 = 2051,
  effectId_Suck = 104307
}

function bs_92058:ctor()
end

function bs_92058:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTriggerForTable("bs_92058_3", 1, self.OnAfterHurt, {
    sender = self.caster,
    extraArg2 = false,
    extraArg3 = false
  })
end

function bs_92058:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if sender == self.caster and not isTriggerSet and not isMiss then
    local powNum = target.pow * self.arglist[1] // 1000
    local skillNum = target.skill_intensity * self.arglist[1] // 1000
    if skill.isCommonAttack then
      LuaSkillCtrl:DispelBuff(sender, self.config.buffId, 0)
      LuaSkillCtrl:DispelBuff(sender, self.config.buffId2, 0)
      LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, powNum, nil, true)
      LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId2, skillNum, nil, true)
    end
  end
end

function bs_92058:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_92058
