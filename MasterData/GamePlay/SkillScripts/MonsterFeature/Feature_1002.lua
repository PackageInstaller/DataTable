local bs_1002 = class("bs_1002", LuaSkillBase)
local base = LuaSkillBase
bs_1002.config = {buffId_atk = 501}

function bs_1002:ctor()
end

function bs_1002:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_1002", 9, self.OnAfterHurt, nil, self.caster, nil, nil, nil, nil, nil, nil, false)
end

function bs_1002:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if isTriggerSet ~= true and 0 < hurt and LuaSkillCtrl:CallRange(1, 1000) <= self.arglist[1] then
    LuaSkillCtrl:CallBuff(self, sender, self.config.buffId_atk, 1, self.arglist[2])
  end
end

function bs_1002:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_1002
