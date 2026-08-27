local bs_93027 = class("bs_93027", LuaSkillBase)
local base = LuaSkillBase
bs_93027.config = {buffId = 2043}

function bs_93027:ctor()
end

function bs_93027:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddOnRoleDieTrigger("bs_93027_10", 1, self.OnRoleDie, nil, nil, nil, eBattleRoleBelong.player)
end

function bs_93027:OnRoleDie(killer, role)
  if role.belongNum == eBattleRoleBelong.player then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, 1, nil, true)
    self:PlayChipEffect()
  end
end

function bs_93027:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_93027
