local bs_5027 = class("bs_5027", LuaSkillBase)
local base = LuaSkillBase
bs_5027.config = {}

function bs_5027:ctor()
end

function bs_5027:InitSkill(isMidwaySkill)
  self:AddSetHurtTrigger("bs_5027_3", 1, self.OnSetHurt, self.caster)
end

function bs_5027:OnSetHurt(context)
  local buffId = LuaSkillCtrl:GetSkillBindBuffId(self)
  if context.sender == self.caster and context.skill.isCommonAttack and self.caster:GetBuffTier(buffId) > 0 and not context.isMiss and 0 < context.hurt then
    context.hurt = context.hurt * (1000 - self.arglist[1]) // 1000
    LuaSkillCtrl:DispelBuff(self.caster, buffId, 1)
  end
end

function bs_5027:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_5027
