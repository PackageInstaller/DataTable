local bs_17011 = class("bs_17011", LuaSkillBase)
local base = LuaSkillBase
bs_17011.config = {
  hurt_config = {
    hit_formula = 0,
    basehurt_formula = 3010,
    crit_formula = 0
  },
  buffId = 2097,
  buffTier = 1
}

function bs_17011:ctor()
end

function bs_17011:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_17011_3", 1, self.OnAfterHurt, self.caster, nil, nil, nil, nil, nil, nil, eSkillTag.commonAttack, false)
  self:AddSelfTrigger(eSkillTriggerType.AfterPlaySkill, "bs_17011_12", 1, self.OnAfterPlaySkill)
  self.flag = false
end

function bs_17011:OnAfterPlaySkill(skill, role)
  if role == self.caster and not skill.isCommonAttack and not self.flag then
    self.flag = true
  end
end

function bs_17011:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if sender == self.caster and not isMiss and not isTriggerSet and skill.isCommonAttack and self.flag then
    self.flag = false
    local piece = 0
    while piece < self.arglist[1] do
      piece = piece + 1
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
      LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurt_config, {
        self.arglist[2]
      }, true)
      LuaSkillCtrl:CallBuff(self, target, 2097, 1)
      skillResult:EndResult()
    end
    piece = 0
  end
end

function bs_17011:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_17011
