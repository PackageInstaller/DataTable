local bs_30062 = class("bs_30062", LuaSkillBase)
local base = LuaSkillBase
bs_30062.config = {
  freezeBuff = 1178,
  HurtConfig = {
    hit_formula = 0,
    basehurt_formula = 10199,
    crit_formula = 0
  },
  formula = 10106,
  effectId = 60630,
  effectId2 = 10883
}

function bs_30062:InitSkill(isMidwaySkill)
  self:AddAfterPlaySkillTrigger("bs_106902_2", 1, self.OnAfterPlaySkill, nil, nil, self.caster.belongNum, nil, nil, nil, nil, eSkillTag.ultSkill)
end

function bs_30062:OnAfterPlaySkill(skill, role)
  if skill.skillTag ~= eSkillTag.ultSkill or skill.maker ~= self.caster then
    return
  end
  if skill.skillType ~= eBattleSkillLogicType.Original then
    return
  end
  local target = LuaSkillCtrl:GetTargetWithGrid(3, 2)
  LuaSkillCtrl:CallEffect(target, self.config.effectId, self)
  local roleslist = LuaSkillCtrl:CallTargetSelect(self, 9, 10)
  for i = 0, roleslist.Count - 1 do
    local targetRole = roleslist[i].targetRole
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, targetRole)
    LuaSkillCtrl:HurtResultWithConfig(self, skillResult, 3, {
      self.arglist[1]
    }, true, true)
    skillResult:EndResult()
    LuaSkillCtrl:CallEffect(targetRole, self.config.effectId2, self)
  end
  local roleslist2 = LuaSkillCtrl:CallTargetSelect(self, 85, 20)
  for i = 0, roleslist2.Count - 1 do
    local targetRole2 = roleslist2[i].targetRole
    local neighborRoles = LuaSkillCtrl:FindRolesAroundRole(targetRole2)
    if neighborRoles ~= nil and 0 < neighborRoles.Count then
      for i = 0, neighborRoles.Count - 1 do
        local enemy = neighborRoles[i]
        if enemy ~= nil and 0 < enemy.hp and enemy.belongNum ~= self.caster.belongNum then
          local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, enemy)
          local buffTier = enemy:GetBuffTier(self.config.buffId)
          local hurtnum = 300 + 20 * buffTier
          LuaSkillCtrl:HurtResultWithConfig(self, skillResult, 3, {hurtnum}, true)
          skillResult:EndResult()
          LuaSkillCtrl:CallEffect(enemy, self.config.effectId2, self)
        end
      end
    end
    if targetRole2 ~= nil and 0 < targetRole2.hp then
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, targetRole2)
      local buffTier2 = role:GetBuffTier(self.config.buffId)
      local hurtnum2 = 300 + 20 * buffTier2
      LuaSkillCtrl:HurtResultWithConfig(self, skillResult, 3, {hurtnum2}, true)
      skillResult:EndResult()
      LuaSkillCtrl:CallEffect(targetRole2, self.config.effectId2, self)
    end
  end
end

function bs_30062:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_30062
