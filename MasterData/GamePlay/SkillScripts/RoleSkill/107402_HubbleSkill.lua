local bs_107402 = class("bs_107402", LuaSkillBase)
local base = LuaSkillBase
bs_107402.config = {
  skill_time = 25,
  actionId = 1002,
  action_speed = 1,
  start_time = 11,
  effectId_cast = 107420,
  effect_trail = 107407,
  effectId_trail_1 = 107408,
  effectId_trail_2 = 107409,
  effectId_trail_3 = 107410,
  effectId_trail_hit1 = 107411,
  effectId_trail_hit2 = 107417,
  effectId_trail_hit3 = 107419,
  effectId_buff3 = 107414,
  effectId_buff2 = 107413,
  effectId_buff1 = 107412,
  effectId_1 = 107406,
  HurtConfigID = 17,
  weaponLv = 0,
  buffFeature_ignoreDie = 6,
  buffFeature_Invinciable = 2,
  Exiled = 16,
  buffId_nurse = 101803
}

function bs_107402:ctor()
end

function bs_107402:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.period = 1
  self.caster.recordTable.tar = nil
  self.num = 0
end

function bs_107402:PlaySkill(data)
  self.num = 0
  self.hurt = 0
  local originAttrList = self.caster.originAttrList
  self.skill_intensity_max = originAttrList[eHeroAttr.skill_intensity] * self.arglist[1] // 1000
  self.pow_max = originAttrList[eHeroAttr.pow] * self.arglist[1] // 1000
  local last_target = self.caster.recordTable.lastAttackRole
  local target
  if last_target ~= nil and 0 < last_target.hp and last_target.belongNum ~= eBattleRoleBelong.neutral and LuaSkillCtrl:IsAbleAttackTarget(self.caster, last_target, self.cskill.SkillRange) then
    target = last_target
  else
    local tempTarget = self:GetMoveSelectTarget()
    if tempTarget == nil then
      return
    end
    target = tempTarget.targetRole
  end
  if target == nil then
    return
  end
  if target ~= nil then
    local attackTrigger = BindCallback(self, self.OnAttackTrigger, target)
    self.caster:LookAtTarget(target)
    self:CallCasterWait(self.config.skill_time)
    LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.actionId, self.config.action_speed, self.config.start_time, attackTrigger)
  end
  if self.effect == nil then
    if self.ClearAttr_timer ~= nil then
      self.ClearAttr_timer.left = 0
      self.ClearAttr_timer:Stop()
      self.ClearAttr_timer = nil
    end
    self:ToSacrifice(target)
  end
end

function bs_107402:ToSacrifice(target)
  self.skill_intensity = 0
  self.pow = 0
  local targetList = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
  if 0 < targetList.Count then
    for i = targetList.Count - 1, 0, -1 do
      if i < targetList.Count and 0 <= i then
        local role = targetList[i]
        if role ~= nil and 0 < role.hp and role.roleType == eBattleRoleType.realSummoner and not role.summoner:HasSummonerFeature(8) then
          self.skill_intensity = self.skill_intensity + role.skill_intensity * self.arglist[3] // 1000
          self.pow = self.pow + role.pow * self.arglist[3] // 1000
          LuaSkillCtrl:CallEffect(self.caster, self.config.effect_trail, self, nil, role, nil, true)
          LuaSkillCtrl:CallEffect(role, self.config.effectId_1, self, nil, nil, nil, true)
          local IfRoleCotainsIgnoreDieBuff = LuaSkillCtrl:RoleContainsBuffFeature(role, self.config.buffFeature_ignoreDie)
          if IfRoleCotainsIgnoreDieBuff == true then
            local buff_ignoreDie = LuaSkillCtrl:GetRoleAllBuffsByFeature(role, self.config.buffFeature_ignoreDie)
            if 0 < buff_ignoreDie.Count then
              for i = 0, buff_ignoreDie.Count - 1 do
                LuaSkillCtrl:DispelBuff(role, buff_ignoreDie[i].dataId, 0, true)
                IfRoleCotainsIgnoreDieBuff = false
              end
            end
          end
          local IfRoleCotainsWudiBuff = LuaSkillCtrl:RoleContainsBuffFeature(role, self.config.buffFeature_Invinciable)
          if IfRoleCotainsWudiBuff == true then
            local buff_Wudi = LuaSkillCtrl:GetRoleAllBuffsByFeature(role, self.config.buffFeature_Invinciable)
            if 0 < buff_Wudi.Count then
              for i = 0, buff_Wudi.Count - 1 do
                LuaSkillCtrl:DispelBuff(role, buff_Wudi[i].dataId, 0, true)
              end
            end
          end
          local IfRoleCotainsExiledBuff = LuaSkillCtrl:RoleContainsBuffFeature(role, self.config.Exiled)
          if IfRoleCotainsExiledBuff == true then
            local buff_Exile = LuaSkillCtrl:GetRoleAllBuffsByFeature(role, self.config.Exiled)
            if 0 < buff_Exile.Count then
              for i = 0, buff_Exile.Count - 1 do
                LuaSkillCtrl:DispelBuff(role, buff_Exile[i].dataId, 0, true)
              end
            end
          end
          LuaSkillCtrl:DispelBuff(role, self.config.buffId_nurse, 0, true)
          if 0 < role.hp and IfRoleCotainsIgnoreDieBuff == false then
            LuaSkillCtrl:RemoveLife(role.hp * 100, self, role, true, nil, false, false, eHurtType.RealDmg, true)
          end
          LuaSkillCtrl:BroadcastLuaTrigger(eSkillLuaTrigger.OnSacrifice, self.caster, role)
          self.num = self.num + 1
          if self.pow > self.pow_max then
            self.pow = self.pow_max
          end
          if self.skill_intensity > self.skill_intensity_max then
            self.skill_intensity = self.skill_intensity_max
            break
          end
        end
      end
    end
  end
  LuaSkillCtrl:StartTimer(self, 6, function()
    self.caster:AddRoleProperty(eHeroAttr.skill_intensity, self.skill_intensity, eHeroAttrType.Extra)
    self.caster:AddRoleProperty(eHeroAttr.pow, self.pow, eHeroAttrType.Extra)
    if self.config.weaponLv >= 3 and self.num > 0 then
      local targetList = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
      if 0 < targetList.Count then
        for i = 0, targetList.Count - 1 do
          local role = targetList[i]
          if role ~= nil and 0 < role.hp and role.roleType ~= eBattleRoleType.realSummoner then
            local shieldValue = self.caster.skill_intensity * self.arglist[5] // 1000 * self.num
            if 0 < shieldValue then
              LuaSkillCtrl:AddRoleShield(targetList[i], eShieldType.Normal, shieldValue)
            end
          end
        end
      end
    end
    if self.effect ~= nil then
      self.effect:Die()
      self.effect = nil
    end
    if self.skill_intensity == self.skill_intensity_max then
      self.effect = LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_buff3, self, nil, nil, nil)
      self.period = 3
    elseif self.skill_intensity >= self.skill_intensity_max * 0.4 and self.skill_intensity < self.skill_intensity_max then
      self.effect = LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_buff2, self, nil, nil, nil)
      self.period = 2
    elseif self.skill_intensity > 0 and self.skill_intensity < self.skill_intensity_max * 0.4 then
      self.effect = LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_buff1, self, nil, nil, nil)
      self.period = 1
    end
    self.ClearAttr_timer = LuaSkillCtrl:StartTimer(nil, self.arglist[2], BindCallback(self, self.ClearAttr, self.skill_intensity, self.pow), nil)
  end, nil)
end

function bs_107402:ClearAttr(skill_intensity, pow)
  self.caster:AddRoleProperty(eHeroAttr.skill_intensity, -skill_intensity, eHeroAttrType.Extra)
  self.caster:AddRoleProperty(eHeroAttr.pow, -pow, eHeroAttrType.Extra)
  self.period = 1
  if self.effect ~= nil then
    self.effect:Die()
    self.effect = nil
  end
end

function bs_107402:OnAttackTrigger(target)
  local last_target = self.caster.recordTable.lastAttackRole
  local target
  if last_target ~= nil and last_target.hp > 0 and last_target.belongNum ~= eBattleRoleBelong.neutral and LuaSkillCtrl:IsAbleAttackTarget(self.caster, last_target, self.cskill.SkillRange) then
    target = last_target
  else
    local tempTarget = self:GetMoveSelectTarget()
    if tempTarget == nil then
      return
    end
    target = tempTarget.targetRole
  end
  if target == nil then
    return
  end
  if target ~= nil then
    self.caster.recordTable.tar = target
    self.caster:LookAtTarget(target)
    if self.period == 1 then
      LuaSkillCtrl:CallEffectWithArgOverride(target, self.config.effectId_trail_1, self, self.caster, nil, nil, self.SkillEventFunc)
    elseif self.period == 2 then
      LuaSkillCtrl:CallEffectWithArgOverride(target, self.config.effectId_trail_2, self, self.caster, nil, nil, self.SkillEventFunc)
    elseif self.period == 3 then
      LuaSkillCtrl:CallEffectWithArgOverride(target, self.config.effectId_trail_3, self, self.caster, nil, nil, self.SkillEventFunc)
    end
    LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_cast, self)
  end
end

function bs_107402:SkillEventFunc(effect, eventId, target)
  if eventId == eBattleEffectEvent.Trigger then
    local hpRate = target.targetRole._curHp * 1000 // target.targetRole.maxHp
    if self.config.weaponLv >= 1 and hpRate <= self.arglist[6] then
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
      LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.HurtConfigID, {
        self.arglist[4] + self.arglist[7]
      })
      skillResult:EndResult()
      LuaSkillCtrl:CallEffect(target.targetRole, self.config.effectId_trail_hit1, self, nil, nil, nil, true)
    elseif self.config.weaponLv >= 1 then
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
      LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.HurtConfigID, {
        self.arglist[4]
      })
      skillResult:EndResult()
      LuaSkillCtrl:CallEffect(target.targetRole, self.config.effectId_trail_hit1, self, nil, nil, nil, true)
    else
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
      LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.HurtConfigID, {
        self.arglist[4]
      })
      skillResult:EndResult()
      LuaSkillCtrl:CallEffect(target.targetRole, self.config.effectId_trail_hit1, self, nil, nil, nil, true)
    end
    self:OnSkillDamageEnd()
  end
end

function bs_107402:LuaDispose()
  base.LuaDispose(self)
  if self.effect ~= nil then
    self.effect:Die()
    self.effect = nil
  end
end

function bs_107402:OnCasterDie()
  base.OnCasterDie(self)
  if self.effect ~= nil then
    self.effect:Die()
    self.effect = nil
  end
end

return bs_107402
