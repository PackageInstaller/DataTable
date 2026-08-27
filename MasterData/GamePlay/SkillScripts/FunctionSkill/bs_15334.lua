local bs_15334 = class("bs_15334", LuaSkillBase)
local base = LuaSkillBase
bs_15334.config = {
  buffId = 1178,
  HurtConfig = {
    hit_formula = 0,
    basehurt_formula = 10199,
    crit_formula = 0
  },
  effectId = 10875,
  effectId2 = 10883,
  configId = 3
}

function bs_15334:ctor()
end

function bs_15334:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.AfterPlaySkill, "bs_15334_3", 3, self.OnAfterPlaySkill)
end

function bs_15334:OnAfterPlaySkill(skill, role)
  if skill.maker == self.caster and not skill.isCommonAttack then
    local targetlist = LuaSkillCtrl:CallTargetSelect(self, 45, 10)
    if targetlist.Count < 1 then
      return
    end
    local targetRole = targetlist[0].targetRole
    if 0 < targetRole.hp then
      LuaSkillCtrl:CallBuff(self, targetRole, self.config.buffId, 1, 75)
      LuaSkillCtrl:CallEffect(targetRole, self.config.effectId, self)
      if targetRole ~= nil and 0 < targetRole.hp then
        local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, targetRole)
        local buffTier2 = targetRole:GetBuffTier(self.config.buffId)
        local hurtnum2 = 300 + 20 * buffTier2
        local hurtnum3 = self.arglist[1]
        LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.configId, {hurtnum3}, true)
        if 0 < hurtnum2 then
          LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.configId, {hurtnum2}, true)
          LuaSkillCtrl:CallEffect(targetRole, self.config.effectId2, self)
        end
        skillResult:EndResult()
      end
      local neighborRoles = LuaSkillCtrl:FindRolesAroundRole(targetRole)
      if neighborRoles ~= nil and neighborRoles.Count > 0 then
        for i = 0, neighborRoles.Count - 1 do
          local enemy = neighborRoles[i]
          if enemy ~= nil and 0 < enemy.hp and enemy.belongNum ~= self.caster.belongNum then
            local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, enemy)
            local buffTier = enemy:GetBuffTier(self.config.buffId)
            local hurtnum = 300 + 20 * buffTier
            if 0 < hurtnum then
              LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.configId, {hurtnum}, true)
              LuaSkillCtrl:CallEffect(enemy, self.config.effectId2, self)
            end
          end
        end
      end
    end
  end
end

function bs_15334:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_15334
