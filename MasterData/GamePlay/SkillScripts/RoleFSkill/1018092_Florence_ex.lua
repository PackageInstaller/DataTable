local bs_1018092 = class("bs_1018092", LuaSkillBase)
local base = LuaSkillBase
bs_1018092.config = {buffId_262 = 10180301}

function bs_1018092:ctor()
end

function bs_1018092:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSetHurtTrigger("bs_1018092_2", 99, self.OnSetHurt, nil, self.caster)
end

function bs_1018092:OnSetHurt(context)
  if context.target == self.caster then
    local tier = self.caster:GetBuffTier(self.config.buffId_262)
    context.hurt = context.hurt * (1000 - self.arglist[1] * tier) // 1000
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId_262, 1)
  end
end

function bs_1018092:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_1018092
