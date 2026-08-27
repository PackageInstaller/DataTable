local bs_1006 = class("bs_1006", LuaSkillBase)
local base = LuaSkillBase
bs_1006.config = {buffId_atk = 503}

function bs_1006:ctor()
end

function bs_1006:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_1006", 9, self.OnAfterHurt, nil, self.caster, nil, nil, nil, nil, nil, nil, false)
end

function bs_1006:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if isTriggerSet ~= true and 0 < hurt and LuaSkillCtrl:CallRange(1, 1000) <= self.arglist[1] then
    LuaSkillCtrl:CallBuff(self, sender, self.config.buffId_atk, 1, self.arglist[2], true)
  end
end

function bs_1006:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_1006
