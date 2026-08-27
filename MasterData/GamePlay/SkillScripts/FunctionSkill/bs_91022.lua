local bs_91022 = class("bs_91022", LuaSkillBase)
local base = LuaSkillBase
bs_91022.config = {buffId = 2044}

function bs_91022:ctor()
end

function bs_91022:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_91022_3", 1, self.OnAfterHurt, nil, nil, nil, self.caster.belongNum)
end

function bs_91022:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if target == self.caster and not isMiss and not isTriggerSet then
    local buffTier = sender:GetBuffTier(self.config.buffId)
    if buffTier >= self.arglist[3] then
      return
    end
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, 1, nil, true)
    self:PlayChipEffect()
  end
end

function bs_91022:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_91022
