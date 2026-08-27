local bs_105401 = class("bs_105401", LuaSkillBase)
local base = LuaSkillBase
bs_105401.config = {
  buffId_healUp = 105402,
  buffId_attackHeal = 105403,
  buffId_tasterMark = 105406,
  buffId_attackUp = 105401,
  buffId_shield = 105411,
  buffId_attackUp2 = 105408,
  buffId_attackUpG = 105413,
  buffId_attackUpG2 = 105414,
  effectId_food_loop = 105406,
  effectId_dandao = 105419,
  effectId_kaisi = 105420,
  superBuffId = 271,
  aoe_config = {
    effect_shape = 3,
    aoe_select_code = 5,
    aoe_range = 1
  },
  HurtConfig = {
    hit_formula = 0,
    basehurt_formula = 3000,
    crit_formula = 0,
    crithur_ratio = 0
  },
  audioId1 = 105405,
  audioId2 = 108,
  audioId3 = 109,
  selectCode = 57,
  weaponLv = 0
}

function bs_105401:ctor()
end

function bs_105401:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_105401_1", 1, self.OnAfterBattleStart)
  self:AddTrigger(eSkillTriggerType.OnBreakShield, "bs_105401_1", 1, self.OnBreakShield)
  self._delayManageCollisionEnter = BindCallback(self, self.DelayManageCollisionEnter)
  self.food_list = {}
  self.food_targetTable = {}
end

function bs_105401:OnBreakShield(shieldType, sender, target)
  if shieldType == 0 and 0 < target:GetBuffTier(self.config.buffId_shield) then
    LuaSkillCtrl:DispelBuff(target, self.config.buffId_shield, 0)
  end
end

function bs_105401:OnAfterBattleStart()
  LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_kaisi, self)
  local start_time = self.arglist[2] - self.arglist[1]
  self.passive = LuaSkillCtrl:StartTimer(nil, self.arglist[2], self.Callback, self, -1, start_time)
  local targetlist = LuaSkillCtrl:CallTargetSelectWithRange(self, 6, 1)
  if targetlist.Count > 0 then
    for i = 0, targetlist.Count - 1 do
      if targetlist[i].targetRole ~= nil then
        LuaSkillCtrl:CallBuff(self, targetlist[i].targetRole, self.config.buffId_tasterMark, 1)
        LuaSkillCtrl:CallBuff(self, targetlist[i].targetRole, self.config.buffId_attackHeal, 1)
      end
    end
  end
end

function bs_105401:Callback()
  if self.passive ~= nil and self.passive:IsOver() then
    self.passive = nil
  end
  local tempTable = {}
  local targetlist = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.enemy)
  if targetlist.Count > 0 then
    for i = 0, targetlist.Count - 1 do
      if targetlist[i] ~= nil then
        local role = targetlist[i]
        local grids = LuaSkillCtrl:FindEmptyGridsWithinRange(role.x, role.y, 3)
        if grids == nil or grids.Count <= 0 then
          break
        end
        for i = 0, grids.Count - 1 do
          local grid = grids[i]
          local pos = BattleUtil.XYCoord2Pos(grid.x, grid.y)
          if tempTable[pos] == nil and self.food_list[grid] == nil then
            tempTable[pos] = LuaSkillCtrl:GetGridsDistance(grid.x, grid.y, role.x, role.y)
          end
        end
      end
    end
  end
  local grid_dict = LuaSkillCtrl:FindEmptyGridsWithinRange(self.caster.x, self.caster.y, 1)
  if grid_dict ~= nil then
    for i = 0, grid_dict.Count - 1 do
      local grid = grid_dict[i]
      local pos = BattleUtil.XYCoord2Pos(grid.x, grid.y)
      tempTable[pos] = nil
    end
  end
  local resultGridPos
  local minDis = 99
  for k, v in pairs(tempTable) do
    if v ~= nil then
      if v == 1 then
        resultGridPos = k
        minDis = v
        break
      elseif resultGridPos == nil or v < minDis then
        resultGridPos = k
        minDis = v
      end
    end
  end
  if resultGridPos ~= nil then
    local coordX, coordY = BattleUtil.Pos2XYCoord(resultGridPos)
    local resultGrid = LuaSkillCtrl:GetGridWithPos(coordX, coordY)
    local target_role = LuaSkillCtrl:GetTargetWithGrid(coordX, coordY)
    local effect = LuaSkillCtrl:CallEffect(target_role, self.config.effectId_food_loop, self)
    local collisionEnter = BindCallback(self, self.OnCollisionEnter, resultGrid, effect)
    LuaSkillCtrl:CallAddCircleColliderForEffect(effect, 100, eColliderInfluenceType.Player, nil, collisionEnter, nil)
    local Callback = BindCallback(self, self.AutoGive, effect, resultGrid)
    LuaSkillCtrl:StartTimer(nil, self.arglist[7], Callback, self)
    self.food_list[resultGrid] = effect
    LuaSkillCtrl:PlayAuSource(self.caster, self.config.audioId1)
  end
end

function bs_105401:AddDropEffectAuto(entity)
  local buff1 = LuaSkillCtrl:GetRoleBuffById(entity, self.config.buffId_tasterMark)
  if buff1 ~= nil then
    LuaSkillCtrl:CallBuff(self, entity, self.config.buffId_attackUpG2, 2, self.arglist[6])
    local value1 = self.caster.def * self.arglist[8] // 1000 * 2
    if 0 < value1 then
      LuaSkillCtrl:AddRoleShield(entity, eShieldType.Normal, value1)
      local SelfShieldValue = LuaSkillCtrl:GetShield(entity, 0)
      if SelfShieldValue ~= 0 then
        LuaSkillCtrl:CallBuff(self, entity, self.config.buffId_shield, 1)
      end
    end
  else
    LuaSkillCtrl:CallBuff(self, entity, self.config.buffId_attackUpG, 1, self.arglist[6])
    local value2 = self.caster.def * self.arglist[8] // 1000
    if 0 < value2 then
      LuaSkillCtrl:AddRoleShield(entity, eShieldType.Normal, value2)
      local SelfShieldValue = LuaSkillCtrl:GetShield(entity, 0)
      if SelfShieldValue ~= 0 then
        LuaSkillCtrl:CallBuff(self, entity, self.config.buffId_shield, 1)
      end
    end
  end
end

function bs_105401:AddDropEffectPick(entity)
  local buff1 = LuaSkillCtrl:GetRoleBuffById(entity, self.config.buffId_tasterMark)
  if buff1 ~= nil then
    LuaSkillCtrl:CallBuff(self, entity, self.config.buffId_attackUp2, 2, self.arglist[6])
    local value1 = self.caster.def * self.arglist[4] // 1000 * 2
    if 0 < value1 then
      LuaSkillCtrl:AddRoleShield(entity, eShieldType.Normal, value1)
      local SelfShieldValue = LuaSkillCtrl:GetShield(entity, 0)
      if SelfShieldValue ~= 0 then
        LuaSkillCtrl:CallBuff(self, entity, self.config.buffId_shield, 1)
      end
    end
  else
    LuaSkillCtrl:CallBuff(self, entity, self.config.buffId_attackUp, 1, self.arglist[6])
    local value2 = self.caster.def * self.arglist[4] // 1000
    if 0 < value2 then
      LuaSkillCtrl:AddRoleShield(entity, eShieldType.Normal, value2)
      local SelfShieldValue = LuaSkillCtrl:GetShield(entity, 0)
      if SelfShieldValue ~= 0 then
        LuaSkillCtrl:CallBuff(self, entity, self.config.buffId_shield, 1)
      end
    end
  end
end

function bs_105401:AutoGive(effect, grid)
  if effect == nil or effect:IsDie() then
    return
  end
  local tempEffect = self.food_list[grid]
  if tempEffect == nil or tempEffect ~= effect then
    return
  end
  local target = LuaSkillCtrl:GetTargetWithGrid(grid.x, grid.y)
  if target == nil then
    return
  end
  local targetList = LuaSkillCtrl:CallTargetSelect(self, 501101, 20)
  local attack_int = 0
  local pass_target1
  if targetList ~= nil and 0 < targetList.Count then
    for i = 0, targetList.Count - 1 do
      local role = targetList[i].targetRole
      if role.belongNum == self.caster.belongNum and (attack_int < role.pow or attack_int < role.skill_intensity) then
        pass_target1 = role
        if role.pow >= role.skill_intensity then
          attack_int = role.pow
        else
          attack_int = role.skill_intensity
        end
      end
    end
  end
  LuaSkillCtrl:CallEffectWithArgOverride(target, self.config.effectId_dandao, self, pass_target1, false, false, self.SkillEventFunc2, pass_target1)
  if effect ~= nil then
    effect:Die()
    effect = nil
  end
end

function bs_105401:SkillEventFunc2(entity, effect, eventId, target)
  if effect.dataId == self.config.effectId_dandao and eventId == eBattleEffectEvent.Trigger then
    self:AddDropEffectAuto(entity)
  end
end

function bs_105401:OnCollisionEnter(grid, effect, collider, index, entity)
  if entity ~= nil and entity.hp > 0 and entity.belongNum == self.caster.belongNum and entity.belongNum ~= eBattleRoleBelong.neutral and entity.roleType == eBattleRoleType.character and entity.recordTable.WillowPic ~= true then
    if self.food_targetTable[effect] == nil then
      self.food_targetTable[effect] = {}
      local tempTable = {}
      tempTable.effect = effect
      tempTable.grid = grid
      LuaSkillCtrl:StartTimer(self, 1, self._delayManageCollisionEnter, tempTable)
      self.food_list[grid] = nil
    end
    self.food_targetTable[effect][index] = entity
  end
end

function bs_105401:DelayManageCollisionEnter(tempTable)
  local addTarget
  local effect = tempTable.effect
  local grid = tempTable.grid
  local target = LuaSkillCtrl:GetTargetWithGrid(grid.x, grid.y)
  local maxAttack = 0
  for k, v in pairs(self.food_targetTable) do
    if k == effect then
      for k2, v2 in pairs(v) do
        if maxAttack < v2.pow then
          maxAttack = v2.pow
          addTarget = v2
        end
      end
    end
  end
  if addTarget ~= nil then
    LuaSkillCtrl:CallEffectWithArgOverride(target, self.config.effectId_dandao, self, addTarget, false, false, self.SkillEventFunc, addTarget)
    self.food_targetTable[effect] = nil
    if effect ~= nil then
      effect:Die()
      effect = nil
    end
  end
end

function bs_105401:SkillEventFunc(entity, effect, eventId, target)
  if eventId == eBattleEffectEvent.Die then
    self:AddDropEffectPick(entity)
  end
end

function bs_105401:OnCasterDie()
  if self.passive ~= nil then
    self.passive:Stop()
    self.passive = nil
  end
  self:KillEquipmentSummoner()
  self:RemoveAllTimers()
  self:RemoveAllBreakKillEffects()
  self:RemoveAllLuaTrigger()
  self:RemoveAllHaleEmission()
end

function bs_105401:LuaDispose()
  if self.passive ~= nil then
    self.passive:Stop()
    self.passive = nil
  end
  self.food_list = nil
  self.food_targetTable = nil
  base.LuaDispose(self)
end

return bs_105401
