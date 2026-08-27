local card_20034 = class("card_20034", LuaSkillBase)
local base = LuaSkillBase
card_20034.config = {buffId = 1252, effectId = 10942}

function card_20034:ctor()
end

function card_20034:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSetHurtTrigger("card_20034_2", 99, self.OnSetHurt, nil, self.caster)
  self.flag1 = 1
  self.flag2 = 1
  self.flag3 = 1
end

function card_20034:OnSetHurt(context)
  local ShieldNormal = LuaSkillCtrl:GetShield(self.caster, eShieldType.Normal)
  local num1 = math.max(self.caster.hp + ShieldNormal - self.caster.maxHp * 750 // 1000, 1)
  if context.target == self.caster and num1 <= context.hurt and self.flag1 == 1 and LuaSkillCtrl:GetRoleBuffById(self.caster, self.config.buffId) == nil then
    context.hurt = num1
    LuaSkillCtrl:RemoveLife(num1, self, self.caster, true, nil, false, true, eHurtType.RealDmg, true)
    LuaSkillCtrl:CallEffect(self.caster, self.config.effectId, self)
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, 1, 45)
    self.flag1 = 0
  end
  local num2 = math.max(self.caster.hp + ShieldNormal - self.caster.maxHp * 500 // 1000, 1)
  if context.target == self.caster and num2 <= context.hurt and self.flag2 == 1 and LuaSkillCtrl:GetRoleBuffById(self.caster, self.config.buffId) == nil then
    context.hurt = num2
    LuaSkillCtrl:RemoveLife(num2, self, self.caster, true, nil, false, true, eHurtType.RealDmg, true)
    LuaSkillCtrl:CallEffect(self.caster, self.config.effectId, self)
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, 1, 45)
    self.flag2 = 0
  end
  local num3 = math.max(self.caster.hp + ShieldNormal - self.caster.maxHp * 250 // 1000, 1)
  if context.target == self.caster and num3 <= context.hurt and self.flag3 == 1 and LuaSkillCtrl:GetRoleBuffById(self.caster, self.config.buffId) == nil then
    context.hurt = num3
    LuaSkillCtrl:RemoveLife(num3, self, self.caster, true, nil, false, true, eHurtType.RealDmg, true)
    LuaSkillCtrl:CallEffect(self.caster, self.config.effectId, self)
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, 1, 45)
    self.flag3 = 0
  end
end

function card_20034:LuaDispose()
  base.LuaDispose(self)
end

return card_20034
