local base = require("GamePlay.SkillScripts.RoleFSkill.FakeCommonPassive")
local bs_1024012 = class("bs_1024012", base)
bs_1024012.config = {
  buffId_plane = 236,
  buffId_attackspeedup = 235,
  effectId = 10738
}

function bs_1024012:ctor()
end

function bs_1024012:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_1024012_3", 1, self.OnAfterHurt, self.caster)
end

function bs_1024012:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if sender == self.caster and isCrit and sender:GetBuffTier(self.config.buffId_plane) == 0 and skill.isCommonAttack then
    LuaSkillCtrl:CallResetCDNumForRole(self.caster, self.arglist[1])
  end
  if sender == self.caster and isCrit and skill.isCommonAttack then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_attackspeedup, 1, self.arglist[4], true)
  end
end

function bs_1024012:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_1024012
