local bs_17109 = class("bs_17109", LuaSkillBase)
local base = LuaSkillBase
bs_17109.config = {buffId = 2086}

function bs_17109:ctor()
end

function bs_17109:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_17109", 1, self.OnAfterHurt, nil, self.caster)
  self.count = 0
end

function bs_17109:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if self.count == 0 and target == self.caster then
    local hp = self.caster.hp
    local MaxHP = self.caster.maxHp
    local percent = hp / MaxHP * 1000
    if percent <= self.arglist[1] then
      LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, 1, self.arglist[3], true)
      self.count = 1
      self:RemoveSkillTrigger(eSkillTriggerType.AfterHurt)
    end
  end
end

function bs_17109:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_17109
