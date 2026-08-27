local bs_15047 = class("bs_15047", LuaSkillBase)
local base = LuaSkillBase
bs_15047.config = {buffId = 26}

function bs_15047:ctor()
end

function bs_15047:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterHurt, "bs_15047_4", 1, self.OnAfterHurt)
end

function bs_15047:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  LuaSkillCtrl:CallBuff(self, target, self.config.buffId, 1, 15, true)
end

function bs_15047:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_15047
