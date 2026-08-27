local bs_10208 = class("bs_10208", LuaSkillBase)
local base = LuaSkillBase
bs_10208.config = {checkBuffId = 195, buffId = 1058}

function bs_10208:ctor()
end

function bs_10208:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSetHurtTrigger("bs_10208_2", 1, self.OnSetHurt, self.caster)
end

function bs_10208:OnSetHurt(context)
  if context.sender == self.caster and context.target.belongNum ~= self.caster.belongNum then
    local buffTier = context.target:GetBuffTier(self.config.checkBuffId)
    context.hurt = context.hurt * (buffTier * self.arglist[1] + 1000) // 1000
  end
end

function bs_10208:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10208
