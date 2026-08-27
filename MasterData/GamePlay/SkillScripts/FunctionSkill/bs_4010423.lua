local bs_4010423 = class("bs_4010423", LuaSkillBase)
local base = LuaSkillBase
bs_4010423.config = {buffId = 2086}

function bs_4010423:ctor()
end

function bs_4010423:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_4010423", 1, self.OnAfterHurt, nil, self.caster)
  self.count = 0
end

function bs_4010423:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if self.count == 0 and target == self.caster then
    local hp = self.caster.hp
    local MaxHP = self.caster.maxHp
    local percent = hp / MaxHP * 1000
    if percent <= self.arglist[1] then
      LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, 1, nil, true)
      self.count = 1
      self:RemoveSkillTrigger(eSkillTriggerType.AfterHurt)
    end
  end
end

function bs_4010423:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_4010423
