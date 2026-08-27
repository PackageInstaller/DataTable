local bs_101809 = class("bs_101809", LuaSkillBase)
local base = LuaSkillBase
bs_101809.config = {buffId_262 = 101803}

function bs_101809:ctor()
end

function bs_101809:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSetHurtTrigger("bs_101809_2", 99, self.OnSetHurt, nil, self.caster)
end

function bs_101809:OnSetHurt(context)
  if context.target == self.caster then
    local tier = self.caster:GetBuffTier(self.config.buffId_262)
    context.hurt = context.hurt * (1000 - self.arglist[1] * tier) // 1000
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId_262, 1)
  end
end

function bs_101809:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_101809
