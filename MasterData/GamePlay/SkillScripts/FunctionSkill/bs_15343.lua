local bs_15343 = class("bs_15343", LuaSkillBase)
local base = LuaSkillBase
bs_15343.config = {
  buffId_miniFire = 110150,
  effectId = 12092,
  newBuffId_miniFire = 110152
}

function bs_15343:ctor()
end

function bs_15343:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddOnRoleDieTrigger("bs_15343", 1, self.OnRoleDie, self.caster, nil, nil, eBattleRoleBelong.enemy, nil, nil, nil)
  self:AddSetDeadHurtTrigger("bs_15343_2", 949, self.OnSetDeadHurt, self.caster, nil, nil, eBattleRoleBelong.enemy)
end

function bs_15343:OnRoleDie(killer, role)
  if role.recordTable.bs_15343_tier ~= nil and role.recordTable.bs_15343_tier > 0 then
    local buffTier = role.recordTable.bs_15343_tier
    local damage = buffTier * self.arglist[1]
    local roles = LuaSkillCtrl:FindRolesAroundRole(role)
    LuaSkillCtrl:CallEffect(role, self.config.effectId, self)
    if roles ~= nil and 0 < roles.Count then
      for i = 0, roles.Count - 1 do
        local targetRole = roles[i]
        if targetRole.belongNum == eBattleRoleBelong.enemy and 0 < targetRole.hp then
          if self.caster.recordTable.miniFireBuff == nil then
            LuaSkillCtrl:CallBuff(self, targetRole, self.config.buffId_miniFire, buffTier, 150)
          else
            LuaSkillCtrl:CallBuff(self, targetRole, self.caster.recordTable.miniFireBuff, buffTier, 150)
          end
          local skillResult1 = LuaSkillCtrl:CallSkillResultNoEffect(self, targetRole)
          LuaSkillCtrl:HurtResultWithConfig(self, skillResult1, 38, {damage}, true)
          skillResult1:EndResult()
        end
      end
    end
  end
end

function bs_15343:OnSetDeadHurt(context)
  local role = context.target
  if role:GetBuffTier(self.config.buffId_miniFire) > 0 or 0 < role:GetBuffTier(self.config.newBuffId_miniFire) then
    local tier = role:GetBuffTier(self.config.buffId_miniFire)
    local tier2 = role:GetBuffTier(self.config.newBuffId_miniFire)
    if 0 < tier then
      role.recordTable.bs_15343_tier = tier
    else
      role.recordTable.bs_15343_tier = tier2
    end
  end
end

function bs_15343:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_15343
