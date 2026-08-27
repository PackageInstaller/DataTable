local bs_15330 = class("bs_15330", LuaSkillBase)
local base = LuaSkillBase
bs_15330.config = {
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

function bs_15330:ctor()
end

function bs_15330:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_15330_3", 1, self.OnAfterHurt, self.caster, nil, nil, nil, nil, nil, nil, eSkillTag.commonAttack, false)
end

function bs_15330:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if not isMiss and LuaSkillCtrl:CallRange(1, 1000) <= self.arglist[2] and not isTriggerSet and skill.isCommonAttack then
    LuaSkillCtrl:CallBuff(self, target, self.config.buffId, 1, 75)
    LuaSkillCtrl:CallEffect(target, self.config.effectId, self)
    if target ~= nil and target.hp > 0 then
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
      local buffTier2 = target:GetBuffTier(self.config.buffId)
      local hurtnum2 = 300 + 20 * buffTier2
      if 0 < hurtnum2 then
        LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.configId, {hurtnum2}, true)
        LuaSkillCtrl:CallEffect(target, self.config.effectId2, self)
      end
      skillResult:EndResult()
    end
    local neighborRoles = LuaSkillCtrl:FindRolesAroundRole(target)
    if neighborRoles ~= nil and 0 < neighborRoles.Count then
      for i = 0, neighborRoles.Count - 1 do
        local enemy = neighborRoles[i]
        if enemy ~= nil and enemy.hp > 0 and enemy.belongNum ~= self.caster.belongNum then
          local buffTier = enemy:GetBuffTier(self.config.buffId)
          local hurtnum = 300 + 20 * buffTier
          if 0 < hurtnum then
            local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, enemy)
            LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.configId, {hurtnum}, true)
            LuaSkillCtrl:CallEffect(enemy, self.config.effectId2, self)
            skillResult:EndResult()
          end
        end
      end
    end
  end
end

function bs_15330:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_15330
