local bs_10339 = class("bs_10339", LuaSkillBase)
local base = LuaSkillBase
bs_10339.config = {buffId = 1289}

function bs_10339:ctor()
end

function bs_10339:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_10339_1", 1, self.OnAfterHurt, self.caster, nil, nil, nil, nil, nil, nil, nil, false)
end

function bs_10339:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if self.caster == sender and not isMiss and not isTriggerSet then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, 1, nil, true)
  end
end

function bs_10339:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10339
