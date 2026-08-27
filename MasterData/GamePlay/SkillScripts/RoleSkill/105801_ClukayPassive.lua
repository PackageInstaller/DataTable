local bs_105801 = class("bs_105801", LuaSkillBase)
local base = LuaSkillBase
bs_105801.config = {
  effectId_xb = 105801,
  hurtConfig = 13,
  buffIdys = 105801,
  aoe_config = {
    effect_shape = 3,
    aoe_select_code = 5,
    aoe_range = 2
  },
  frameMaxEffectNum = 4,
  weaponLv = 0,
  buffId_damage_1 = 105805,
  buffId_damage_2 = 105806,
  effectId_damage = 105834,
  buffId_damage_add = 105807,
  Role_id = 1058
}

function bs_105801:ctor()
end

function bs_105801:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddOnRoleDieTrigger("bs_105803_2", 1, self.OnRoleDie)
  self:AddSelfTrigger(eSkillTriggerType.AfterBattleStart, "bs_105803_3", 1, self.OnAfterBattleStart)
  self.caster.recordTable["105801_Roll"] = self.arglist[1]
  self.caster.recordTable["105801_arg2"] = self.arglist[2]
  self.caster.recordTable["105801_arg3"] = self.arglist[3]
  self.callEffectQueue = {}
  self.passiveCd = 0
  if 2 <= self.config.weaponLv then
    LuaSkillCtrl:AddExtraAddSkill(105807, self.level)
  end
end

function bs_105801:OnAfterBattleStart()
  self.updateTimer = LuaSkillCtrl:StartTimer(nil, 1, function()
    if self.callEffectQueue ~= nil and #self.callEffectQueue > 0 then
      for i = 1, self.config.frameMaxEffectNum do
        if #self.callEffectQueue > 0 then
          local role = self.callEffectQueue[1]
          LuaSkillCtrl:CallEffect(role, self.config.effectId_xb, self)
          table.remove(self.callEffectQueue, 1)
        else
          break
        end
      end
    end
  end, nil, -1)
  if self.config.weaponLv >= 2 then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_damage_1, 1, nil, true)
    LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_damage, self)
    local target_pow, target_skill_intensity, target
    local targets_pow = LuaSkillCtrl:CallTargetSelect(self, 31, 10)
    if targets_pow.Count > 0 and target_pow == nil then
      target_pow = targets_pow[0].targetRole
    end
    local targets_skill_intensity = LuaSkillCtrl:CallTargetSelect(self, 51, 10)
    if targets_skill_intensity.Count > 0 and target_skill_intensity == nil then
      target_skill_intensity = targets_skill_intensity[0].targetRole
    end
    if target_pow.pow > target_skill_intensity.skill_intensity then
      target = target_pow
    else
      target = target_skill_intensity
    end
    if target == self.caster then
      LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_damage_2, 1, nil, true)
    end
  end
end

function bs_105801:OnRoleDie(killer, role)
  if killer == self.caster or role:GetBuffTier(self.config.buffIdys) >= 1 then
    if role.belongNum ~= self.caster.belongNum and role.hp == 0 and role ~= nil and role.belongNum ~= eBattleRoleBelong.neutral then
      table.insert(self.callEffectQueue, role)
      local damage1 = 0
      if 0 < self.config.weaponLv then
        damage1 = self.arglist[4] + self.arglist[5]
      end
      local damage2 = self.arglist[4]
      if role.roleDataId == 89 then
        damage1 = damage1 * (1000 - role.recordTable.arg2) // 1000
        damage2 = damage2 * (1000 - role.recordTable.arg2) // 1000
      end
      LuaSkillCtrl:StartTimer(nil, 12, function()
        if self.config.weaponLv > 0 then
          local targetList = LuaSkillCtrl:FindAllRolesWithinRange(role, 2, false)
          if 0 < targetList.Count then
            for i = targetList.Count - 1, 0, -1 do
              local target = targetList[i]
              if target ~= nil and 0 < target.hp and target.belongNum ~= self.caster.belongNum then
                LuaSkillCtrl:CallBuff(self, target, self.config.buffId_damage_add, 1, self.arglist[7])
                if 1 <= target:GetBuffTier(self.config.buffIdys) then
                  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
                  LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.hurtConfig, {damage1})
                  skillResult:EndResult()
                else
                  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
                  LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.hurtConfig, {damage2})
                  skillResult:EndResult()
                end
              end
            end
          end
        else
          local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, role, self.config.aoe_config)
          LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.hurtConfig, {damage2})
          skillResult:EndResult()
        end
      end)
    end
    LuaSkillCtrl:DispelBuff(role, self.config.buffIdys, 0)
  end
end

function bs_105801:OnCasterDie()
  base.OnCasterDie(self)
  if self.updateTimer ~= nil then
    self.updateTimer:Stop()
    self.updateTimer = nil
  end
  self.callEffectQueue = nil
end

function bs_105801:LuaDispose()
  base.LuaDispose(self)
  if self.updateTimer ~= nil then
    self.updateTimer:Stop()
    self.updateTimer = nil
  end
  self.callEffectQueue = nil
end

return bs_105801
