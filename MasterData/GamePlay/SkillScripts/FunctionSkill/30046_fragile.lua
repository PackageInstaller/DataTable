local bs_cuiruozuzhou = class("bs_cuiruozuzhou", LuaSkillBase)
local base = LuaSkillBase
bs_cuiruozuzhou.config = {buffId = 1208, effectId = 10084}

function bs_cuiruozuzhou:ctor()
end

function bs_cuiruozuzhou:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.SetDeadHurt, "bs_cuiruozuzhou_3", 1, self.OnSetDeadHurt)
  self:AddTrigger(eSkillTriggerType.AfterHurt, "bs_cuiruozuzhou_4", 1, self.OnAfterHurt)
end

function bs_cuiruozuzhou:OnSetDeadHurt(context)
  if context.target == self.caster then
    LuaSkillCtrl:CallBuff(self, context.sender, self.config.buffId, 1, 1000)
    LuaSkillCtrl:CallEffect(self.caster, self.config.effectId, self)
  end
end

function bs_cuiruozuzhou:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, isRealDmg, isTriggerSet)
end

function bs_cuiruozuzhou:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_cuiruozuzhou
