local bs_92044 = class("bs_92044", LuaSkillBase)
local base = LuaSkillBase
bs_92044.config = {
  buffId = 2041,
  buffTier = 1,
  effectId = 1008
}

function bs_92044:ctor()
end

function bs_92044:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddOnRoleDieTrigger("bs_92044_10", 1, self.OnRoleDie, nil, nil, nil, eBattleRoleBelong.player)
end

function bs_92044:OnRoleDie(killer, role)
  if role.belongNum == eBattleRoleBelong.player then
    LuaSkillCtrl:CallEffect(self.caster, self.config.effectId, self)
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, 1, nil, true)
    self:PlayChipEffect()
  end
end

function bs_92044:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_92044
