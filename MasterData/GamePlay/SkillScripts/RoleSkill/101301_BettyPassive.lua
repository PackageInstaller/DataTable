local bs_101301 = class("bs_101301", LuaSkillBase)
local base = LuaSkillBase
bs_101301.config = {
  effectId_hit = 101304,
  HurtConfig = {
    hit_formula = 0,
    basehurt_formula = 3000,
    returndamage_formula = 0
  }
}

function bs_101301:ctor()
end

function bs_101301:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_101301_3", 1, self.OnAfterHurt, self.caster)
end

function bs_101301:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if sender == self.caster and skill ~= nil and skill.isCommonAttack and not isMiss then
    local low = self.arglist[1]
    local high = self.arglist[2]
    local prob = LuaSkillCtrl:CallRange(low, high)
    LuaSkillCtrl:StartTimer(nil, 4, function()
      LuaSkillCtrl:CallEffect(target, self.config.effectId_hit, self)
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
      LuaSkillCtrl:HurtResult(self, skillResult, self.config.HurtConfig, {prob})
      skillResult:EndResult()
    end)
  end
end

function bs_101301:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_101301
