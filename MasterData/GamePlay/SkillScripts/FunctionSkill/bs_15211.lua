local bs_15211 = class("bs_15211", LuaSkillBase)
local base = LuaSkillBase
bs_15211.config = {buffId = 110109}

function bs_15211:ctor()
end

function bs_15211:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddHurtResultStartTrigger("bs_15211_3", 1, self.OnHurtResultStart, nil, self.caster)
  self:AddAfterHurtTrigger("bs_15209_3", 1, self.OnAfterHurt, nil, self.caster)
end

function bs_15211:OnHurtResultStart(skill, context)
  if context.target == self.caster and context.sender.hp * 1000 // context.sender.maxHp >= self.arglist[1] then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, 1, nil, true)
  end
end

function bs_15211:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if target == self.caster then
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId, 0, true)
  end
end

function bs_15211:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_15211
