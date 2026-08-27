local bs_10151 = class("bs_10151", LuaSkillBase)
local base = LuaSkillBase
bs_10151.config = {buffId = 1123, buffTier = 1}

function bs_10151:ctor()
end

function bs_10151:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_10151_3", 1, self.OnAfterHurt, nil, nil, nil, eBattleRoleBelong.player)
end

function bs_10151:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if target.belongNum == self.caster.belongNum and isMiss then
    local layer = self.caster:GetBuffTier(self.config.buffId)
    if layer ~= self.arglist[2] then
      self:PlayChipEffect()
      if layer + self.arglist[1] <= self.arglist[2] then
        LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, self.arglist[1])
      elseif layer + self.arglist[1] > self.arglist[2] then
        LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId, 0)
        LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, self.arglist[2])
      end
    end
  end
end

function bs_10151:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10151
