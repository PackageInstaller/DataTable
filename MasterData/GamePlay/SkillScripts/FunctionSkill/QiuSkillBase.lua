local QiuSkillBase = class("QiuSkillBase", LuaSkillBase)
local base = LuaSkillBase
QiuSkillBase.config = {
  effectId_CAIball = 12124,
  effectId_SHANball = 12134,
  effectId_up = 10263,
  effectId_down = 10264,
  effectId_ATKball = 12126,
  buffATKBall = 1284,
  buffATKBallDuration = 90,
  effectId_DEFball = 12128,
  buffDEFBall = 1285,
  buffDEFBallDuration = 90,
  shield_percent = 200,
  effectId_BOOMball = 12130,
  hurt_config = 14,
  pow_percent = 5000,
  buffId = 115,
  buffTier = 1,
  buffDuration = 30,
  effectId_WUDUball = 12132,
  buffId1 = 107101,
  buffId2 = 195,
  buffId3 = 1178,
  buffId4 = 1059,
  buffId5 = 1227,
  buffTier2 = 3,
  buffDuration2 = 75,
  is_reducable = true
}

function QiuSkillBase:ctor()
end

function QiuSkillBase:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.effect = nil
  self.effectBind = nil
  self.collisionEnter = nil
  if self.config.is_reducable then
    self:AddLuaTrigger(eSkillLuaTrigger.OnRoleSplash, self.OnRoleSplash)
    self:AddLuaTrigger(eSkillLuaTrigger.OnRolePhaseMoveStart, self.OnRolePhaseMoveStart)
  end
  self.ToCastBallSkill = nil
  self.recordSkill = nil
  self.QiuList = nil
  if self.caster.recordTable.QiuBaseSkill == nil then
    self.caster.recordTable.QiuBaseSkill = self
    self.recordSkill = self
    self.QiuList = {}
  else
    self.recordSkill = self.caster.recordTable.QiuBaseSkill
  end
  self.recordSkill.QiuList[#self.recordSkill.QiuList + 1] = self
end

function QiuSkillBase:OnQiuCollected()
  LuaSkillCtrl:BroadcastLuaTrigger(eSkillLuaTrigger.OnQiuCollected)
end

function QiuSkillBase:MakeRoleCollectQiu(role)
  local tempList = {}
  for _, skill in ipairs(self.recordSkill.QiuList) do
    if skill.effect ~= nil then
      tempList[#tempList + 1] = skill
    end
  end
  local range = LuaSkillCtrl:CallRange(1, #tempList)
  local skill = tempList[range]
  if skill == nil then
    return
  end
  if skill.effect ~= nil then
    skill.effect:Die()
    skill.effect = nil
  end
  local cb = BindCallback(skill.collisionEnter, nil, nil, role)
  cb()
end

function QiuSkillBase:OnRoleSplash(role, grid)
  if role.belongNum == self.caster.belongNum and self:IsReadyToTake() then
    self:OnSkillTake()
    self:BallReduceTime()
  end
end

function QiuSkillBase:OnRolePhaseMoveStart(role, luaskill)
  if role.belongNum == self.caster.belongNum and self:IsReadyToTake() then
    self:OnSkillTake()
    self:BallReduceTime()
  end
end

function QiuSkillBase:BallReduceTime()
  if self.timer == nil then
    return
  end
  self.timer.left = self.timer.left - self.arglist[2]
end

function QiuSkillBase:RealCastSkillCAIBall()
  if self.timer ~= nil and self.timer:IsOver() then
    self.timer = nil
  end
  local resultGrid = LuaSkillCtrl:FindEmptyGrid()
  if resultGrid == nil then
    return
  end
  local target_role = LuaSkillCtrl:GetTargetWithGrid(resultGrid.x, resultGrid.y)
  if self.effect ~= nil then
    self.effect:Die()
    self.effect = nil
    self.timer.left = self.timer.left - self.timer.left * 200 // 1000
  end
  self.effect = LuaSkillCtrl:CallEffect(target_role, self.config.effectId_CAIball, self)
  self.collisionEnter = BindCallback(self, self.OnCollisionEnterCAI, resultGrid, self.effect)
  LuaSkillCtrl:CallAddCircleColliderForEffect(self.effect, 100, eColliderInfluenceType.Player, nil, self.collisionEnter, nil)
end

function QiuSkillBase:OnCollisionEnterCAI(grid, effect, collider, index, entity)
  if entity ~= nil and entity.hp > 0 and entity.belongNum == self.caster.belongNum and entity.belongNum ~= eBattleRoleBelong.neutral and entity.roleType == eBattleRoleType.character and entity.recordTable.WillowPic ~= true then
    self._delayManageCollisionEnter = BindCallback(self, self.DelayManageCollisionEnterCAI, entity)
    LuaSkillCtrl:StartTimer(nil, 15, self._delayManageCollisionEnter)
  end
end

function QiuSkillBase:DelayManageCollisionEnterCAI(entity)
  if self.effect ~= nil then
    self.effect:Die()
    self.effect = nil
  end
  self:CAIBallRealCast(entity)
  self:OnQiuCollected()
end

function QiuSkillBase:CAIBallRealCast(entity)
  self:ATKBallRealCast(entity)
  self:DEFBallRealCast(entity)
  self:BOOMBallRealCast(entity)
  self:WUDUBallRealCast(entity)
  self:SHANBallRealCast(entity)
end

function QiuSkillBase:RealCastSkillSHANBall(x, y)
  if self.timer ~= nil and self.timer:IsOver() then
    self.timer = nil
  end
  local resultGrid
  if x ~= nil and y ~= nil then
    resultGrid = LuaSkillCtrl:GetGridWithPos(x, y)
  else
    resultGrid = LuaSkillCtrl:FindEmptyGrid()
  end
  if resultGrid == nil then
    return
  end
  local target_role = LuaSkillCtrl:GetTargetWithGrid(resultGrid.x, resultGrid.y)
  if self.effect ~= nil then
    self.effect:Die()
    self.effect = nil
    self.timer.left = self.timer.left - self.timer.left * 200 // 1000
  end
  self.effect = LuaSkillCtrl:CallEffect(target_role, self.config.effectId_SHANball, self)
  self.collisionEnter = BindCallback(self, self.OnCollisionEnterSHAN, resultGrid, self.effect)
  LuaSkillCtrl:CallAddCircleColliderForEffect(self.effect, 100, eColliderInfluenceType.Player, nil, self.collisionEnter, nil)
end

function QiuSkillBase:OnCollisionEnterSHAN(grid, effect, collider, index, entity)
  if entity ~= nil and entity.hp > 0 and entity.belongNum == self.caster.belongNum and entity.belongNum ~= eBattleRoleBelong.neutral and entity.roleType == eBattleRoleType.character and entity.recordTable.WillowPic ~= true then
    self._delayManageCollisionEnter = BindCallback(self, self.DelayManageCollisionEnterSHAN, entity)
    LuaSkillCtrl:StartTimer(nil, 15, self._delayManageCollisionEnter)
  end
end

function QiuSkillBase:DelayManageCollisionEnterSHAN(entity)
  if self.effect ~= nil then
    self.effect:Die()
    self.effect = nil
  end
  self:SHANBallRealCast(entity)
  self:OnQiuCollected()
end

function QiuSkillBase:SHANBallRealCast(entity)
  local grid = LuaSkillCtrl:GetGridWithRole(entity)
  if grid ~= nil then
    LuaSkillCtrl:CallEffect(entity, self.config.effectId_up, self)
    LuaSkillCtrl:SetRolePos(grid, entity)
    LuaSkillCtrl:CallEffect(entity, self.config.effectId_down, self)
  end
  if LuaSkillCtrl:CallRange(1, 1000) <= 250 then
    self:RealCastSkillWUDUBall()
  elseif LuaSkillCtrl:CallRange(1, 1000) <= 500 then
    self:RealCastSkillBOOMBall()
  elseif LuaSkillCtrl:CallRange(1, 1000) <= 750 then
    self:RealCastSkillDEFBall()
  else
    self:RealCastSkillATKBall()
  end
end

function QiuSkillBase:RealCastSkillWUDUBall(x, y)
  if self.timer ~= nil and self.timer:IsOver() then
    self.timer = nil
  end
  if self.timer ~= nil then
    self.timer.left = self.arglist[1]
  end
  local resultGrid
  if x ~= nil and y ~= nil then
    resultGrid = LuaSkillCtrl:GetGridWithPos(x, y)
  else
    resultGrid = LuaSkillCtrl:FindEmptyGrid()
  end
  if resultGrid == nil then
    return
  end
  local target_role = LuaSkillCtrl:GetTargetWithGrid(resultGrid.x, resultGrid.y)
  if self.effect ~= nil then
    self.effect:Die()
    self.effect = nil
    self.timer.left = self.timer.left - self.timer.left * 200 // 1000
  end
  self.effect = LuaSkillCtrl:CallEffect(target_role, self.config.effectId_WUDUball, self)
  self.collisionEnter = BindCallback(self, self.OnCollisionEnterWUDU, resultGrid, self.effect)
  LuaSkillCtrl:CallAddCircleColliderForEffect(self.effect, 100, eColliderInfluenceType.Player, nil, self.collisionEnter, nil)
end

function QiuSkillBase:OnCollisionEnterWUDU(grid, effect, collider, index, entity)
  if entity ~= nil and entity.hp > 0 and entity.belongNum == self.caster.belongNum and entity.belongNum ~= eBattleRoleBelong.neutral and entity.roleType == eBattleRoleType.character and entity.recordTable.WillowPic ~= true then
    self._delayManageCollisionEnter = BindCallback(self, self.DelayManageCollisionEnterWUDU, entity)
    LuaSkillCtrl:StartTimer(nil, 15, self._delayManageCollisionEnter)
  end
end

function QiuSkillBase:DelayManageCollisionEnterWUDU(entity)
  if self.effect ~= nil then
    self.effect:Die()
    self.effect = nil
  end
  self:WUDUBallRealCast(entity)
  self:OnQiuCollected()
end

function QiuSkillBase:WUDUBallRealCast(entity)
  local targetListEnemy = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.enemy)
  if targetListEnemy ~= nil and targetListEnemy.Count > 0 then
    for i = targetListEnemy.Count - 1, 0, -1 do
      LuaSkillCtrl:CallBuff(self, targetListEnemy[i], self.config.buffId1, self.config.buffTier2, self.config.buffDuration2, true, entity)
      LuaSkillCtrl:CallBuff(self, targetListEnemy[i], self.config.buffId2, self.config.buffTier2, self.config.buffDuration2, true, entity)
      LuaSkillCtrl:CallBuff(self, targetListEnemy[i], self.config.buffId3, self.config.buffTier2, self.config.buffDuration2, true, entity)
      LuaSkillCtrl:CallBuff(self, targetListEnemy[i], self.config.buffId4, self.config.buffTier2, self.config.buffDuration2, true, entity)
      LuaSkillCtrl:CallBuff(self, targetListEnemy[i], self.config.buffId5, self.config.buffTier2, self.config.buffDuration2, true, entity)
    end
  end
end

function QiuSkillBase:RealCastSkillBOOMBall(x, y)
  if self.timer ~= nil and self.timer:IsOver() then
    self.timer = nil
  end
  if self.timer ~= nil then
    self.timer.left = self.arglist[1]
  end
  local resultGrid
  if x ~= nil and y ~= nil then
    resultGrid = LuaSkillCtrl:GetGridWithPos(x, y)
  else
    resultGrid = LuaSkillCtrl:FindEmptyGrid()
  end
  if resultGrid == nil then
    return
  end
  local target_role = LuaSkillCtrl:GetTargetWithGrid(resultGrid.x, resultGrid.y)
  if self.effect ~= nil then
    self.effect:Die()
    self.effect = nil
    self.timer.left = self.timer.left - self.timer.left * 200 // 1000
  end
  self.effect = LuaSkillCtrl:CallEffect(target_role, self.config.effectId_BOOMball, self)
  self.collisionEnter = BindCallback(self, self.OnCollisionEnterBOOM, resultGrid, self.effect)
  LuaSkillCtrl:CallAddCircleColliderForEffect(self.effect, 100, eColliderInfluenceType.Player, nil, self.collisionEnter, nil)
end

function QiuSkillBase:OnCollisionEnterBOOM(grid, effect, collider, index, entity)
  if entity ~= nil and entity.hp > 0 and entity.belongNum == self.caster.belongNum and entity.belongNum ~= eBattleRoleBelong.neutral and entity.roleType == eBattleRoleType.character and entity.recordTable.WillowPic ~= true then
    self._delayManageCollisionEnter = BindCallback(self, self.DelayManageCollisionEnterBOOM, entity)
    LuaSkillCtrl:StartTimer(nil, 15, self._delayManageCollisionEnter)
  end
end

function QiuSkillBase:DelayManageCollisionEnterBOOM(entity)
  if self.effect ~= nil then
    self.effect:Die()
    self.effect = nil
  end
  self:BOOMBallRealCast(entity)
  self:OnQiuCollected()
end

function QiuSkillBase:BOOMBallRealCast(entity)
  local targetlist = LuaSkillCtrl:CallTargetSelect(self, 83, 10)
  if targetlist == nil or targetlist.Count < 1 then
    return
  end
  local targetRole = targetlist[0].targetRole
  local damage = targetRole.pow * self.config.pow_percent // 1000
  local targetListEnemy = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.enemy)
  if targetListEnemy ~= nil and targetListEnemy.Count > 0 then
    for i = targetListEnemy.Count - 1, 0, -1 do
      LuaSkillCtrl:CallBuff(self, targetListEnemy[i], self.config.buffId, self.config.buffTier, self.config.buffDuration, true)
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, targetListEnemy[i])
      LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.hurt_config, {damage}, true, true, nil)
      skillResult:EndResult()
    end
  end
end

function QiuSkillBase:RealCastSkillDEFBall(x, y)
  if self.timer ~= nil and self.timer:IsOver() then
    self.timer = nil
  end
  if self.timer ~= nil then
    self.timer.left = self.arglist[1]
  end
  local resultGrid
  if x ~= nil and y ~= nil then
    resultGrid = LuaSkillCtrl:GetGridWithPos(x, y)
  else
    resultGrid = LuaSkillCtrl:FindEmptyGrid()
  end
  if resultGrid == nil then
    return
  end
  local target_role = LuaSkillCtrl:GetTargetWithGrid(resultGrid.x, resultGrid.y)
  if self.effect ~= nil then
    self.effect:Die()
    self.effect = nil
    self.timer.left = self.timer.left - self.timer.left * 200 // 1000
  end
  self.effect = LuaSkillCtrl:CallEffect(target_role, self.config.effectId_DEFball, self)
  self.collisionEnter = BindCallback(self, self.OnCollisionEnterDEF, resultGrid, self.effect)
  LuaSkillCtrl:CallAddCircleColliderForEffect(self.effect, 100, eColliderInfluenceType.Player, nil, self.collisionEnter, nil)
end

function QiuSkillBase:OnCollisionEnterDEF(grid, effect, collider, index, entity)
  if entity ~= nil and entity.hp > 0 and entity.belongNum == self.caster.belongNum and entity.belongNum ~= eBattleRoleBelong.neutral and entity.roleType == eBattleRoleType.character and entity.recordTable.WillowPic ~= true then
    self._delayManageCollisionEnter = BindCallback(self, self.DelayManageCollisionEnterDEF, entity)
    LuaSkillCtrl:StartTimer(nil, 15, self._delayManageCollisionEnter)
  end
end

function QiuSkillBase:DelayManageCollisionEnterDEF(entity)
  if self.effect ~= nil then
    self.effect:Die()
    self.effect = nil
  end
  self:DEFBallRealCast(entity)
  self:OnQiuCollected()
end

function QiuSkillBase:DEFBallRealCast(entity)
  local playerList = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
  if playerList == nil or playerList.Count < 1 then
    return
  end
  for i = 0, playerList.Count - 1 do
    if playerList[i].roleType == eBattleRoleType.character then
      LuaSkillCtrl:CallBuff(self, playerList[i], self.config.buffDEFBall, 1, self.config.buffDEFBallDuration, true)
      local shieldValue = playerList[i].maxHp * self.config.shield_percent // 1000
      LuaSkillCtrl:AddRoleShield(playerList[i], eShieldType.Normal, shieldValue)
    end
  end
end

function QiuSkillBase:RealCastSkillATKBall(x, y)
  if self.timer ~= nil and self.timer:IsOver() then
    self.timer = nil
  end
  if self.timer ~= nil then
    self.timer.left = self.arglist[1]
  end
  local resultGrid
  if x ~= nil and y ~= nil then
    resultGrid = LuaSkillCtrl:GetGridWithPos(x, y)
  else
    resultGrid = LuaSkillCtrl:FindEmptyGrid()
  end
  if resultGrid == nil then
    return
  end
  local target_role = LuaSkillCtrl:GetTargetWithGrid(resultGrid.x, resultGrid.y)
  if self.effect ~= nil then
    self.effect:Die()
    self.effect = nil
    self.timer.left = self.timer.left - self.timer.left * 200 // 1000
  end
  self.effect = LuaSkillCtrl:CallEffect(target_role, self.config.effectId_ATKball, self)
  self.collisionEnter = BindCallback(self, self.OnCollisionEnterATK, resultGrid, self.effect)
  LuaSkillCtrl:CallAddCircleColliderForEffect(self.effect, 100, eColliderInfluenceType.Player, nil, self.collisionEnter, nil)
end

function QiuSkillBase:OnCollisionEnterATK(grid, effect, collider, index, entity)
  if entity ~= nil and entity.hp > 0 and entity.belongNum == self.caster.belongNum and entity.belongNum ~= eBattleRoleBelong.neutral and entity.roleType == eBattleRoleType.character and entity.recordTable.WillowPic ~= true then
    self._delayManageCollisionEnter = BindCallback(self, self.DelayManageCollisionEnterATK, entity)
    LuaSkillCtrl:StartTimer(nil, 15, self._delayManageCollisionEnter)
  end
end

function QiuSkillBase:DelayManageCollisionEnterATK(entity)
  if self.effect ~= nil then
    self.effect:Die()
    self.effect = nil
  end
  self:ATKBallRealCast(entity)
  self:OnQiuCollected()
end

function QiuSkillBase:ATKBallRealCast(entity)
  local playerList = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
  if playerList == nil or playerList.Count < 1 then
    return
  end
  for i = 0, playerList.Count - 1 do
    LuaSkillCtrl:CallBuff(self, playerList[i], self.config.buffATKBall, 1, self.config.buffATKBallDuration, true)
  end
end

function QiuSkillBase:OnCasterDie()
  base.OnCasterDie(self)
  if self.timer ~= nil then
    self.timer:Stop()
    self.timer = nil
  end
  if self.effect ~= nil then
    self.effect:Die()
    self.effect = nil
  end
  self.QiuList = nil
end

function QiuSkillBase:LuaDispose()
  base.LuaDispose(self)
  if self.timer ~= nil then
    self.timer:Stop()
    self.timer = nil
  end
  if self.effect ~= nil then
    self.effect:Die()
    self.effect = nil
  end
  self.QiuList = nil
end

return QiuSkillBase
