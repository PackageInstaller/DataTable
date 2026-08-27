local bs_92045 = class("bs_92045", LuaSkillBase)
local base = LuaSkillBase
bs_92045.config = {buffId = 2042, buffTier = 1}

function bs_92045:ctor()
end

function bs_92045:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddOnRoleDieTrigger("bs_92044_10", 1, self.OnRoleDie, nil, nil, nil, eBattleRoleBelong.player)
end

function bs_92045:OnRoleDie(killer, role)
  if role.belongNum == eBattleRoleBelong.player then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, self.config.buffTier, nil, true)
    self:PlayChipEffect()
  end
end

function bs_92045:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_92045
