local bs_92060 = class("bs_92060", LuaSkillBase)
local base = LuaSkillBase
bs_92060.config = {buffId = 2053, buffId2 = 2054}

function bs_92060:ctor()
end

function bs_92060:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.AfterHurt, "bs_92060_3", 1, self.OnAfterHurt)
end

function bs_92060:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if target.hp <= 0 and 0 < hurt and sender == self.caster and target.belongNum == 2 then
    local powNum = target.pow * self.arglist[1] // 1000
    local skillNum = target.skill_intensity * self.arglist[1] // 1000
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, powNum, nil, true)
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId2, skillNum, nil, true)
  end
end

function bs_92060:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_92060
