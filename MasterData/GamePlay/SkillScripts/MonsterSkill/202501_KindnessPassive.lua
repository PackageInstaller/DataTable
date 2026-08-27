local bs_202501 = class("bs_202501", LuaSkillBase)
local base = LuaSkillBase
bs_202501.config = {buffId_193 = 193, effectId = 1}

function bs_202501:ctor()
end

function bs_202501:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_202501_3", 1, self.OnAfterHurt, self.caster)
end

function bs_202501:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if sender == self.caster and isCrit then
    LuaSkillCtrl:CallBuff(self, target, self.config.buffId_193, 1, self.arglist[1], true)
  end
end

function bs_202501:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_202501
