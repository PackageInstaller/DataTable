local bs_30025 = class("bs_30025", LuaSkillBase)
local base = LuaSkillBase
bs_30025.config = {
  freezeBuff = 1178,
  silenceBuff = 26,
  HurtConfig = {
    hit_formula = 0,
    basehurt_formula = 10127,
    crit_formula = 9992
  },
  effectId = 10875,
  effectId2 = 10883
}

function bs_30025:InitSkill(isMidwaySkill)
  self:AddAfterAddBuffHitMaxTierTrigger("bs_30025_1", 1, self.OnBuffHitMaxTier, nil, nil, nil, nil, self.config.freezeBuff)
end

function bs_30025:OnBuffHitMaxTier(buff, role, isOverlay, maxTier)
  LuaSkillCtrl:DispelBuff(role, self.config.freezeBuff, 0, true)
  LuaSkillCtrl:CallEffect(role, self.config.effectId, self)
  local highAttRole = LuaSkillCtrl:CallTargetSelect(self, 46, 20)
  if highAttRole ~= nil and 0 < highAttRole.Count and highAttRole[0] ~= nil then
    local neighborRoles = LuaSkillCtrl:FindRolesAroundRole(role)
    if neighborRoles ~= nil and 0 < neighborRoles.Count then
      for i = 0, neighborRoles.Count - 1 do
        local enemy = neighborRoles[i]
        if enemy ~= nil and 0 < enemy.hp and enemy.belongNum ~= self.caster.belongNum then
          local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, enemy)
          LuaSkillCtrl:HurtResult(self, skillResult, self.config.HurtConfig, {
            highAttRole[0].targetRole.skill_intensity
          }, true)
          skillResult:EndResult()
          LuaSkillCtrl:CallBuff(self, enemy, self.config.silenceBuff, 1, self.arglist[2])
          LuaSkillCtrl:CallEffect(enemy, self.config.effectId2, self)
        end
      end
    end
    if role ~= nil and 0 < role.hp then
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, role)
      LuaSkillCtrl:HurtResult(self, skillResult, self.config.HurtConfig, {
        highAttRole[0].targetRole.skill_intensity
      }, true)
      skillResult:EndResult()
      LuaSkillCtrl:CallEffect(role, self.config.effectId2, self)
      LuaSkillCtrl:CallBuff(self, role, self.config.silenceBuff, 1, self.arglist[2])
    end
  end
end

function bs_30025:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_30025
