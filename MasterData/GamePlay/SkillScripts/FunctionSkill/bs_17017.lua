local bs_17017 = class("bs_17017", LuaSkillBase)
local base = LuaSkillBase
bs_17017.config = {
  freezeBuff = 2098,
  HurtConfig = {
    hit_formula = 0,
    basehurt_formula = 10127,
    crit_formula = 9992
  },
  effectId = 10875,
  effectId2 = 10936
}

function bs_17017:InitSkill(isMidwaySkill)
  self:AddAfterAddBuffHitMaxTierTrigger("bs_17017_1", 1, self.OnBuffHitMaxTier, nil, nil, nil, nil, self.config.freezeBuff)
end

function bs_17017:OnBuffHitMaxTier(buff, role, isOverlay, maxTier)
  LuaSkillCtrl:DispelBuff(role, self.config.freezeBuff, 0, true)
  local neighborRoles = LuaSkillCtrl:FindRolesAroundRole(role)
  if neighborRoles ~= nil and 0 < neighborRoles.Count then
    for i = 0, neighborRoles.Count - 1 do
      local enemy = neighborRoles[i]
      if enemy ~= nil and 0 < enemy.hp and enemy.belongNum ~= self.caster.belongNum then
        local skill_intensity = self.arglist[1]
        local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, enemy)
        LuaSkillCtrl:HurtResultWithConfig(self, skillResult, 3, {skill_intensity}, true, true)
        skillResult:EndResult()
      end
    end
  end
  if role ~= nil and 0 < role.hp then
    local skill_intensity = self.arglist[1]
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, role)
    LuaSkillCtrl:HurtResultWithConfig(self, skillResult, 3, {skill_intensity}, true, true)
    skillResult:EndResult()
  end
end

function bs_17017:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_17017
