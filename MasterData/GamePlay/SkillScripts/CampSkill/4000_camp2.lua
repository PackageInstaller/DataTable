local bs_4000 = class("bs_4000", LuaSkillBase)
local base = LuaSkillBase
bs_4000.config = {
  buffId = 66,
  buffTier = 1,
  buffDuration = 30,
  probMax = 5,
  probHit = 1
}

function bs_4000:ctor()
end

function bs_4000:InitSkill(isMidwaySkill)
  self:AddAfterHurtTrigger("bs_4000_3", 1, self.OnAfterHurt, self.caster)
end

function bs_4000:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if sender == self.caster and skill.isCommonAttack and LuaSkillCtrl:CallRange(1, self.config.probMax) == self.config.probHit then
    local targetList = LuaSkillCtrl:CallTargetSelect(self, 1001, 0)
    self:CallCasterLookAt(targetList)
    LuaSkillCtrl:CallBuff(self, target, self.config.buffId, self.config.buffTier, self.config.buffDuration, true)
  end
end

function bs_4000:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_4000
