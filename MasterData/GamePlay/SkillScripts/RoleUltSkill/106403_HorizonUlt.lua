local bs_106403 = class("bs_106403", LuaSkillBase)
local base = LuaSkillBase
bs_106403.config = {
  start_time = 5,
  end_time = 35,
  configId_trail = 3,
  hurtConfig = 2,
  audioIdStart = 106410,
  audioIdMovie = 106411,
  effectId_HIT = 106411,
  buffId_jc = 106403,
  buffId_Back = 151,
  effectId_bh = 106405,
  effectId_sjj = 106407,
  effectId_sjy = 106408,
  effectId3 = 106412,
  effectId4 = 106416,
  effectId_pass = 106404,
  effectId_pass2 = 106413,
  effectId_pass3 = 106414,
  buffId_back = 151,
  buffId_Taunt = 3002,
  buffId_shield = 106404,
  aoe_config = {
    effect_shape = 2,
    aoe_select_code = 4,
    aoe_range = 1
  }
}

function bs_106403:ctor()
end

function bs_106403:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.shieldlist = {}
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_106403_2", 1, self.OnAfterBattleStart)
  self.caster.recordTable["106403_ultTime"] = self.arglist[3]
  self.wallInfo1 = {}
  self.wallInfo2 = {}
  self.cando = 1
end

function bs_106403:OnAfterBattleStart()
  self.collisionEnter = BindCallback(self, self.OnCollisionEnter)
  self.collisionExit = BindCallback(self, self.OnCollisionExit)
  self.collisionEnter2 = BindCallback(self, self.OnCollisionEnter2)
  self.collisionEnter3 = BindCallback(self, self.OnCollisionEnter3)
  self.collisionExit3 = BindCallback(self, self.OnCollisionExit3)
  self.collisionEnter4 = BindCallback(self, self.OnCollisionEnter4)
  self.collisionExit4 = BindCallback(self, self.OnCollisionExit4)
end

function bs_106403:PlaySkill(data, selectTargetCoord, selectRoles, selectRolesType)
  local skill_time = 41
  LuaSkillCtrl:CallRoleAction(self.caster, 1006, 1)
  self:CallCasterWait(skill_time)
  self.shieldlist = {}
  self:GetSelectTargetAndExecute(selectRoles, BindCallback(self, self.CallSelectExecute))
end

function bs_106403:CallSelectExecute(role)
  local grid_THIS = LuaSkillCtrl:GetGridWithRole(role)
  local targetGrid = LuaSkillCtrl:GetTargetWithGrid(grid_THIS.x, grid_THIS.y)
  if targetGrid ~= nil then
    self.caster:LookAtTarget(targetGrid)
    LuaSkillCtrl:CallEffect(role, self.config.effectId4, self)
    local target = role
    if target ~= nil and target.hp > 0 and target.belongNum == self.caster.belongNum and target.roleType == 1 then
      local shieldValue = self.caster.pow * self.caster.recordTable["106402_Shield"] // 1000
      if 0 < shieldValue then
        LuaSkillCtrl:AddRoleShield(target, eShieldType.Normal, shieldValue)
        local SelfShieldValue = LuaSkillCtrl:GetShield(target, 0)
        if SelfShieldValue ~= 0 then
          LuaSkillCtrl:CallBuff(self, target, self.config.buffId_shield, 1)
        end
      end
      local tauntBuffTime = self.caster.recordTable["106402_ztime"]
      local range = 2 - target.attackRange
      local targetlist_enemy = LuaSkillCtrl:CallTargetSelect(self, 9, range, target)
      if targetlist_enemy ~= nil and 0 < targetlist_enemy.Count then
        for i = 0, targetlist_enemy.Count - 1 do
          if targetlist_enemy[i] ~= nil then
            LuaSkillCtrl:CallBuff(self, targetlist_enemy[i].targetRole, self.config.buffId_Taunt, 1, tauntBuffTime, false, target)
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
    end
  end
  if self.wallInfo1 ~= nil then
    self:ClearWallInfo(self.wallInfo1)
  end
  self:CreatWall(targetGrid, self.wallInfo1)
  if self.caster.recordTable.grid_wall ~= nil then
    if self.wallInfo2 ~= nil then
      self:ClearWallInfo(self.wallInfo2)
    end
    local targetGrid1 = LuaSkillCtrl:GetTargetWithGrid(self.caster.recordTable.grid_wall.x, self.caster.recordTable.grid_wall.y)
    self.wallInfo2 = {}
    self:CreatWall(targetGrid1, self.wallInfo2)
  end
  self:RemoveSkillTrigger(eSkillTriggerType.SetHurt)
  self:AddSetHurtTrigger("bs_106403_3", 1, self.OnSetHurt, nil, nil, nil, self.caster.belongNum)
  if self.loop ~= nil then
    self.loop:Stop()
    self.loop = nil
  end
  self.loop = LuaSkillCtrl:StartTimer(nil, self.arglist[3], function()
    self.shieldlist = {}
    if self.wallInfo1 ~= nil then
      if self.wallInfo1.effectHalo ~= nil then
        self:ExtraDamage(self.wallInfo1.effectHalo.target)
      end
      self:ClearWallInfo(self.wallInfo1)
    end
    if self.wallInfo2 ~= nil then
      if self.wallInfo2.effectHalo ~= nil then
        self:ExtraDamage(self.wallInfo2.effectHalo.target)
      end
      self:ClearWallInfo(self.wallInfo2)
    end
    self:RemoveSkillTrigger(eSkillTriggerType.SetHurt)
  end)
end

function bs_106403:CreatWall(targetGrid, wallInfo)
  wallInfo.effectHalo = LuaSkillCtrl:CallEffect(targetGrid, 106405, self)
  wallInfo.effectHalop = LuaSkillCtrl:CallEffect(targetGrid, self.config.effectId_pass, self)
  wallInfo.jc = LuaSkillCtrl:CallAddCircleColliderForEffect(wallInfo.effectHalo, 25, eColliderInfluenceType.Player, nil, self.collisionEnter, self.collisionExit)
  wallInfo.jt = LuaSkillCtrl:CallAddCircleColliderForEffect(wallInfo.effectHalo, 25, eColliderInfluenceType.Enemy, nil, self.collisionEnter2, nil)
  wallInfo.zd1 = LuaSkillCtrl:CallAddCircleColliderForEffect(wallInfo.effectHalop, 25, eColliderInfluenceType.Player, nil, self.collisionEnter3, self.collisionExit3)
  wallInfo.zd2 = LuaSkillCtrl:CallAddCircleColliderForEffect(wallInfo.effectHalo, 75, eColliderInfluenceType.Enemy, nil, self.collisionEnter4, self.collisionExit4)
end

function bs_106403:ClearWallInfo(wallInfo)
  if wallInfo.effectHalo ~= nil then
    wallInfo.effectHalo:Die()
    wallInfo.effectHalo = nil
  end
  if wallInfo.effectHalop ~= nil then
    wallInfo.effectHalop:Die()
    wallInfo.effectHalop = nil
  end
  if wallInfo.jc ~= nil then
    LuaSkillCtrl:ClearColliderOrEmission(wallInfo.jc)
    wallInfo.jc = nil
  end
  if wallInfo.jt ~= nil then
    LuaSkillCtrl:ClearColliderOrEmission(wallInfo.jt)
    wallInfo.jt = nil
  end
  wallInfo.zd1 = nil
  wallInfo.zd2 = nil
end

function bs_106403:OnSetHurt(context)
  if self.shieldlist[context.target] ~= nil then
    if LuaSkillCtrl:GetRoleGridsDistance(context.target, context.sender) == 1 then
      context.hurt = context.hurt * (1000 - self.arglist[2]) // 1000
      local targetX = context.sender.x
      local targetY = context.sender.y
      local buff = LuaSkillCtrl:CallBuff(self, context.sender, self.config.buffId_Back, 1, 3)
      if buff ~= nil and (context.sender.x ~= targetX or context.sender.y ~= targetY) then
        LuaSkillCtrl:BroadcastLuaTrigger(eSkillLuaTrigger.OnHorizonCauseBacklash, context.sender)
      end
      local grid = LuaSkillCtrl:GetGridWithRole(context.target)
      LuaSkillCtrl:CallEffect(context.target, self.config.effectId_sjj, self)
    end
    if LuaSkillCtrl:GetRoleGridsDistance(context.target, context.sender) >= 2 then
      context.hurt = context.hurt * (1000 - self.arglist[1]) // 1000
      local grid = LuaSkillCtrl:GetGridWithRole(context.target)
      LuaSkillCtrl:CallEffect(context.target, self.config.effectId_sjy, self)
    end
  end
end

function bs_106403:OnCollisionEnter(collider, index, entity)
  local grid = LuaSkillCtrl:GetGridWithRole(entity)
  self.shieldlist[entity] = grid
end

function bs_106403:OnCollisionExit(collider, entity)
  self.shieldlist[entity] = nil
end

function bs_106403:OnCollisionEnter2(collider, index, entity)
  local buff
  local targetX = entity.x
  local targetY = entity.y
  buff = LuaSkillCtrl:CallBuff(self, entity, self.config.buffId_Back, 1, 3)
  if buff ~= nil and (entity.x ~= targetX or entity.y ~= targetY) then
    LuaSkillCtrl:BroadcastLuaTrigger(eSkillLuaTrigger.OnHorizonCauseBacklash, entity)
  end
end

function bs_106403:OnCollisionEnter3(collider, index, entity)
  if entity:GetBuffTier(self.config.buffId_jc) < 1 then
    LuaSkillCtrl:CallBuff(self, entity, self.config.buffId_jc, 1)
  end
end

function bs_106403:OnCollisionExit3(collider, entity)
  if entity:GetBuffTier(self.config.buffId_jc) >= 1 then
    LuaSkillCtrl:DispelBuff(entity, self.config.buffId_jc, 0)
  end
end

function bs_106403:OnCollisionEnter4(collider, index, entity)
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, entity)
  LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.hurtConfig, {
    self.caster.recordTable["106402_hurt"]
  })
  skillResult:EndResult()
  LuaSkillCtrl:CallEffect(entity, self.config.effectId_HIT, self)
end

function bs_106403:OnCollisionExit4(collider, entity)
  if self.cando ~= 0 then
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, entity)
    LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.hurtConfig, {
      self.caster.recordTable["106402_hurt"]
    })
    skillResult:EndResult()
    LuaSkillCtrl:CallEffect(entity, self.config.effectId_HIT, self)
  end
end

function bs_106403:ExtraDamage(target)
  if target ~= nil then
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target, self.config.aoe_config)
    LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.hurtConfig, {
      self.caster.recordTable["106402_hurt2"]
    })
    skillResult:EndResult()
  end
end

function bs_106403:OnUltRoleAction()
  base.OnUltRoleAction(self)
  LuaSkillCtrl:StartTimerInUlt(self, 7, self.PlayUltMovie)
  LuaSkillCtrl:CallRoleAction(self.caster, 1005, 1.5)
end

function bs_106403:PlayUltEffect(data, selectTargetCoord, selectRoles)
  base.PlayUltEffect(self)
  LuaSkillCtrl:CallBuff(self, self.caster, 196, 1, 15, true)
  LuaSkillCtrl:CallFocusTimeLine(self.caster)
end

function bs_106403:OnSkipUltView()
  base.OnSkipUltView(self)
end

function bs_106403:OnMovieFadeOut()
  base.OnMovieFadeOut(self)
end

function bs_106403:OnCasterDie()
  base.OnCasterDie(self)
  if self.wallInfo1 ~= nil then
    self:ClearWallInfo(self.wallInfo1)
    self.wallInfo1 = nil
  end
  if self.wallInfo2 ~= nil then
    self:ClearWallInfo(self.wallInfo2)
    self.wallInfo2 = nil
  end
end

function bs_106403:LuaDispose()
  base.LuaDispose(self)
  self.cando = 0
  if self.wallInfo1 ~= nil then
    self:ClearWallInfo(self.wallInfo1)
    self.wallInfo1 = nil
  end
  if self.wallInfo2 ~= nil then
    self:ClearWallInfo(self.wallInfo2)
    self.wallInfo2 = nil
  end
  self.shieldlist = nil
end

return bs_106403
