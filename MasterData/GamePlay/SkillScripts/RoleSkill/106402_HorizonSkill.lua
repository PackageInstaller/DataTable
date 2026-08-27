local bs_106402 = class("bs_106402", LuaSkillBase)
local base = LuaSkillBase
bs_106402.config = {
  skill_time = 55,
  actionId_start_time = 36,
  actionId = 1002,
  action_speed = 1,
  effectId_pass = 106404,
  effectId_HIT = 106411,
  buffId_jc = 106401,
  buffId_back = 151,
  hurtConfig = 2,
  buffId_Taunt = 3002,
  buffId1 = 106403,
  buffId_shield = 106404,
  aoe_config = {
    effect_shape = 2,
    aoe_select_code = 4,
    aoe_range = 1
  }
}

function bs_106402:ctor()
end

function bs_106402:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.targetlist = {}
  self:AddAfterPlaySkillTrigger("bs_106402_2", 1, self.OnAfterPlaySkill, self.caster)
  self:AddAfterAddBuffTrigger("bs_106402_3", 2, self.OnAfterAddBuff, nil, nil, nil, nil, self.config.buffId1)
  self:AddBuffDieTrigger("bs_106402_4", 3, self.OnBuffDie, nil, nil, self.config.buffId1)
  self.caster.recordTable["106402_hurt"] = self.arglist[3]
  self.caster.recordTable["106402_hurt2"] = self.arglist[5]
  self.caster.recordTable["106402_ztime"] = self.arglist[1]
  self.caster.recordTable["106402_Shield"] = self.arglist[8]
  self:AddTrigger(eSkillTriggerType.OnBreakShield, "bs_106402_5", 4, self.OnBreakShield)
end

function bs_106402:OnBreakShield(shieldType, sender, target)
  if shieldType == 0 and 0 < target:GetBuffTier(self.config.buffId_shield) then
    LuaSkillCtrl:DispelBuff(target, self.config.buffId_shield, 0)
  end
end

function bs_106402:PlaySkill(data)
  local attackTrigger = BindCallback(self, self.OnAttackTrigger, data)
  local time = self.config.skill_time
  self:CallCasterWait(time)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.actionId, self.config.action_speed, self.config.actionId_start_time, attackTrigger)
end

function bs_106402:OnAfterPlaySkill(skill, role)
  if skill.maker == self.caster and (skill.dataId == 106403 or skill.dataId == 106402) and self.effectHalo ~= nil then
    if skill.dataId == 106402 then
      LuaSkillCtrl:StartTimer(nil, 35, function()
        if self.effectHalo ~= nil then
          self:ExtraDamage(self.effectHalo.target)
        end
        if self.loop1 ~= nil then
          self.loop1:Stop()
          self.loop1 = nil
        end
        self.targetlist = {}
        if self.effectHalo ~= nil then
          self.effectHalo:Die()
          self.effectHalo = nil
        end
        if self.jc ~= nil then
          LuaSkillCtrl:ClearColliderOrEmission(self.jc)
          self.jc = nil
        end
        self.caster.recordTable.grid_wall = nil
      end)
    else
      LuaSkillCtrl:StartTimer(nil, 6, function()
        if self.loop1 ~= nil then
          self.loop1:Stop()
          self.loop1 = nil
        end
        self.targetlist = {}
        if self.effectHalo ~= nil then
          self.effectHalo:Die()
          self.effectHalo = nil
        end
        if self.jc ~= nil then
          LuaSkillCtrl:ClearColliderOrEmission(self.jc)
          self.jc = nil
        end
        self.caster.recordTable.grid_wall = nil
      end)
    end
  end
end

function bs_106402:OnAfterAddBuff(buff, target)
  if target:GetBuffTier(self.config.buffId_jc) < 1 then
    LuaSkillCtrl:CallBuff(self, target, self.config.buffId_jc, 1)
  end
end

function bs_106402:OnBuffDie(buff, target, removeType)
  if target:GetBuffTier(self.config.buffId_jc) >= 1 then
    LuaSkillCtrl:DispelBuff(target, self.config.buffId_jc, 0)
  end
end

function bs_106402:OnAttackTrigger(data)
  local dis = 0
  local target
  local targetList = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
  for i = 0, targetList.Count - 1 do
    if targetList[i] ~= nil then
      local grid = LuaSkillCtrl:GetGridWithRole(targetList[i])
      local dis_1 = grid.x
      if dis <= dis_1 then
        dis = dis_1
        target = targetList[i]
      end
    end
  end
  local grid_wall = LuaSkillCtrl:GetGridWithRole(target)
  self.caster.recordTable.grid_wall = grid_wall
  local shieldValue = self.caster.pow * self.arglist[8] // 1000
  if 0 < shieldValue then
    LuaSkillCtrl:AddRoleShield(target, eShieldType.Normal, shieldValue)
    local SelfShieldValue = LuaSkillCtrl:GetShield(target, 0)
    if SelfShieldValue ~= 0 then
      LuaSkillCtrl:CallBuff(self, target, self.config.buffId_shield, 1)
    end
  end
  local range = 2 - target.attackRange
  local targetlist_enemy = LuaSkillCtrl:CallTargetSelect(self, 9, range, target)
  if targetlist_enemy ~= nil and 0 < targetlist_enemy.Count then
    for i = 0, targetlist_enemy.Count - 1 do
      if targetlist_enemy[i] ~= nil then
        LuaSkillCtrl:CallBuff(self, targetlist_enemy[i].targetRole, self.config.buffId_Taunt, 1, self.arglist[1], false, target)
      end
    end
  end
  local range2 = 1 - target.attackRange
  local targetlist_enemy2 = LuaSkillCtrl:CallTargetSelect(self, 9, range2, target)
  if targetlist_enemy2 ~= nil and 0 < targetlist_enemy2.Count then
    for i = 0, targetlist_enemy2.Count - 1 do
      if targetlist_enemy2[i] ~= nil then
        local targetEnemyRole = targetlist_enemy2[i].targetRole
        local buff
        local targetX = targetEnemyRole.x
        local targetY = targetEnemyRole.y
        buff = LuaSkillCtrl:CallBuff(self, targetEnemyRole, self.config.buffId_back, 1, 3, false, target)
        if buff ~= nil and (targetEnemyRole.x ~= targetX or targetEnemyRole.y ~= targetY) then
          LuaSkillCtrl:BroadcastLuaTrigger(eSkillLuaTrigger.OnHorizonCauseBacklash, targetEnemyRole)
        end
      end
    end
  end
  if target ~= nil then
    local Grid1 = grid_wall
    local targetGrid1 = LuaSkillCtrl:GetTargetWithGrid(Grid1.x, Grid1.y)
    if targetGrid1 ~= nil then
      if self.effectHalo ~= nil then
        self.effectHalo:Die()
        self.effectHalo = nil
      end
      self.effectHalo = LuaSkillCtrl:CallEffect(targetGrid1, self.config.effectId_pass, self)
      if self.jc ~= nil then
        LuaSkillCtrl:ClearColliderOrEmission(self.jc)
        self.jc = nil
      end
      local collisionEnter = BindCallback(self, self.OnCollisionEnter)
      local collisionExit = BindCallback(self, self.OnCollisionExit)
      self.jc = LuaSkillCtrl:CallAddCircleColliderForEffect(self.effectHalo, 25, eColliderInfluenceType.Player, nil, collisionEnter, collisionExit)
      local collisionEnter2 = BindCallback(self, self.OnCollisionEnter2)
      local collisionExit2 = BindCallback(self, self.OnCollisionExit2)
      self.pz = LuaSkillCtrl:CallAddCircleColliderForEffect(self.effectHalo, 75, eColliderInfluenceType.Enemy, nil, collisionEnter2, collisionExit2)
      self.loop1 = LuaSkillCtrl:StartTimer(nil, self.arglist[7], function()
        if self.effectHalo ~= nil then
          self:ExtraDamage(self.effectHalo.target)
        end
        self.targetlist = {}
        if self.effectHalo ~= nil then
          self.effectHalo:Die()
          self.effectHalo = nil
        end
        if self.jc ~= nil then
          LuaSkillCtrl:ClearColliderOrEmission(self.jc)
          self.jc = nil
        end
        self.caster.recordTable.grid_wall = nil
      end)
    end
  end
end

function bs_106402:OnCollisionEnter(collider, index, entity)
  if entity:GetBuffTier(self.config.buffId_jc) < 1 then
    LuaSkillCtrl:CallBuff(self, entity, self.config.buffId_jc, 1)
  end
end

function bs_106402:OnCollisionExit(collider, entity)
  if entity:GetBuffTier(self.config.buffId_jc) >= 1 then
    LuaSkillCtrl:DispelBuff(entity, self.config.buffId_jc, 0)
  end
end

function bs_106402:OnCollisionEnter2(collider, index, entity)
  if self.targetlist[entity] == nil then
    self.targetlist[entity] = 0
  end
  self.targetlist[entity] = self.targetlist[entity] + 1
  if self.targetlist[entity] <= self.arglist[4] then
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, entity)
    LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.hurtConfig, {
      self.arglist[3]
    })
    skillResult:EndResult()
    LuaSkillCtrl:CallEffect(entity, self.config.effectId_HIT, self)
  end
end

function bs_106402:OnCollisionExit2(collider, entity)
  if self.targetlist[entity] == nil then
    self.targetlist[entity] = 0
  end
  self.targetlist[entity] = self.targetlist[entity] + 1
  if self.targetlist[entity] <= self.arglist[4] then
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, entity)
    LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.hurtConfig, {
      self.arglist[3]
    })
    skillResult:EndResult()
    LuaSkillCtrl:CallEffect(entity, self.config.effectId_HIT, self)
  end
end

function bs_106402:ExtraDamage(target)
  if target ~= nil then
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target, self.config.aoe_config)
    LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.hurtConfig, {
      self.arglist[5]
    })
    skillResult:EndResult()
  end
end

function bs_106402:OnCasterDie()
  base.OnCasterDie(self)
  self.targetlist = {}
  if self.effectHalo ~= nil then
    self.effectHalo:Die()
    self.effectHalo = nil
  end
  self.caster.recordTable.grid_wall = nil
  if self.loop1 ~= nil then
    self.loop1:Stop()
    self.loop1 = nil
  end
  if self.jc ~= nil then
    LuaSkillCtrl:ClearColliderOrEmission(self.jc)
    self.jc = nil
  end
end

function bs_106402:LuaDispose()
  base.LuaDispose(self)
  self.effectHalo = nil
  self.jc = nil
  self.targetlist = nil
end

return bs_106402
