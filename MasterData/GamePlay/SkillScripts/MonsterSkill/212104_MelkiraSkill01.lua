local bs_212104 = class("bs_212104", LuaSkillBase)
local base = LuaSkillBase
bs_212104.config = {
  HurtConfigID = 3,
  actionId = 1002,
  action_speed = 1,
  actionId_start_time = 10,
  skilltime = 34,
  grid_id = 1127,
  buffId_lockCd = 170,
  buffId_live = 3009,
  nanaka_buffId = 102603,
  buffId_1 = 212105,
  buff_grid = 1275,
  effect = 212101,
  effect_cast = 212116,
  effect_hit = 212102,
  buffFeature_ignoreDie = 6
}

function bs_212104:ctor()
end

function bs_212104:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSetDeadHurtTrigger("bs_212104_1", 99999, self.OnSetDeadHurt, nil, nil, nil, nil, nil, 1)
  self.setDeadRole = {}
  self.onCastSkill = false
end

function bs_212104:PlaySkill(data)
  local target
  local targets = LuaSkillCtrl:CallTargetSelect(self, 42, 10)
  for i = targets.Count - 1, 0, -1 do
    local role = targets[i].targetRole
    if LuaSkillCtrl:IsObstacle(role) then
      targets:RemoveAt(i)
    end
  end
  if targets.Count > 0 then
    target = targets[0].targetRole
  end
  if target ~= nil then
    self.caster:LookAtTarget(target)
    self.onCastSkill = true
    LuaSkillCtrl:CallEffect(self.caster, self.config.effect_cast, self, nil)
    local attackTrigger = BindCallback(self, self.OnAttackTrigger, target)
    local time = self.config.skilltime
    self:CallCasterWait(time)
    LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.actionId, self.config.action_speed, self.config.actionId_start_time, attackTrigger)
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_lockCd, 1, time, true)
    local callnextskill = BindCallback(self, self.EndSkillAndCallNext)
    LuaSkillCtrl:StartTimer(self, time, callnextskill)
  end
end

function bs_212104:OnAttackTrigger(target)
  LuaSkillCtrl:CallEffect(target, self.config.effect, self, nil)
  local targetList = LuaSkillCtrl:FindAllRolesWithinRange(target, 1, false)
  if targetList.Count > 0 then
    for i = targetList.Count - 1, 0, -1 do
      if targetList[i].belongNum ~= target.belongNum then
        targetList:RemoveAt(i)
      end
    end
  end
  if self.caster.recordTable.P3 == true then
    local grid = LuaSkillCtrl:GetGridWithRole(target)
    if grid ~= nil and grid.dateId ~= self.config.grid_id then
      LuaSkillCtrl:CallCreateEfcGrid(grid.coord.x, grid.coord.y, self.config.grid_id)
    end
  end
  if targetList.Count == 0 then
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
    LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.HurtConfigID, {
      self.arglist[2]
    })
    skillResult:EndResult()
    LuaSkillCtrl:CallEffect(target, self.config.effect_hit, self, nil)
  else
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
    LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.HurtConfigID, {
      self.arglist[1]
    })
    skillResult:EndResult()
    LuaSkillCtrl:CallEffect(target, self.config.effect_hit, self, nil)
  end
end

function bs_212104:OnSetDeadHurt(context)
  local NoDeath = LuaSkillCtrl:RoleContainsBuffFeature(context.target, eBuffFeatureType.NoDeath)
  local target = context.target
  if target.belongNum ~= self.caster.belongNum and target.roleType == 1 and target:GetBuffTier(self.config.nanaka_buffId) <= 0 and self.setDeadRole[target] ~= true and NoDeath == false then
    if 0 < target:GetBuffTier(self.config.buff_grid) then
      if target == nil or 0 >= target.hp or self.caster == nil then
        return
      end
      LuaSkillCtrl:CallBuff(self, target, self.config.buffId_1, 1, nil, true)
    end
    self:check_ifwin(target)
  end
end

function bs_212104:check_ifwin(target)
  local count_Char = 0
  local count_Poison = 0
  local targetList = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
  for i = targetList.Count - 1, 0, -1 do
    local tar = targetList[i]
    if tar == target or tar ~= nil and 0 < tar:GetBuffTier(self.config.buffId_1) then
      count_Poison = count_Poison + 1
    end
    if tar.roleType == eBattleRoleType.character then
      count_Char = count_Char + 1
    end
  end
  if count_Char == count_Poison then
    for i = targetList.Count - 1, 0, -1 do
      local tar = targetList[i]
      if 0 < tar:GetBuffTier(self.config.buffId_1) then
        LuaSkillCtrl:DispelBuff(tar, self.config.buffId_1, 1, true)
      end
      local IfRoleCotainsIgnoreDieBuff = LuaSkillCtrl:RoleContainsBuffFeature(tar, self.config.buffFeature_ignoreDie)
      if IfRoleCotainsIgnoreDieBuff == true then
        local buff_ignoreDie = LuaSkillCtrl:GetRoleAllBuffsByFeature(tar, self.config.buffFeature_ignoreDie)
        if 0 < buff_ignoreDie.Count then
          for i = 0, buff_ignoreDie.Count - 1 do
            LuaSkillCtrl:DispelBuff(tar, buff_ignoreDie[i].dataId, 0, true)
            IfRoleCotainsIgnoreDieBuff = false
          end
        end
      end
      if 0 < tar.hp and IfRoleCotainsIgnoreDieBuff == false then
        self.setDeadRole[tar] = true
        LuaSkillCtrl:RemoveLife(tar.hp, self, tar, true, nil, false, true, eHurtType.RealDmg, true)
      end
    end
  end
end

function bs_212104:OnBreakSkill(role)
  base.OnBreakSkill(self, role)
  if self.onCastSkill == true then
    self:EndSkillAndCallNext()
  end
end

function bs_212104:EndSkillAndCallNext()
  self.onCastSkill = false
  LuaSkillCtrl:DispelBuff(self.caster, 170, 0)
  if self.caster == nil then
    return
  end
  self:CancleCasterWait()
  local skillMgr = self.caster:GetSkillComponent()
  if skillMgr == nil then
    return
  end
  skillMgr.lastSkill = self.cskill
  self.caster:CallUnFreezeNextSkill()
  LuaSkillCtrl:StopShowSkillDurationTime(self)
end

function bs_212104:OnCasterDie()
  local targetList = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
  for i = targetList.Count - 1, 0, -1 do
    local tar = targetList[i]
    if 0 < tar:GetBuffTier(self.config.buffId_1) then
      LuaSkillCtrl:DispelBuff(tar, self.config.buffId_1, 1, true)
      local IfRoleCotainsIgnoreDieBuff = LuaSkillCtrl:RoleContainsBuffFeature(tar, self.config.buffFeature_ignoreDie)
      if IfRoleCotainsIgnoreDieBuff == true then
        local buff_ignoreDie = LuaSkillCtrl:GetRoleAllBuffsByFeature(tar, self.config.buffFeature_ignoreDie)
        if buff_ignoreDie.Count > 0 then
          for i = 0, buff_ignoreDie.Count - 1 do
            LuaSkillCtrl:DispelBuff(tar, buff_ignoreDie[i].dataId, 0, true)
            IfRoleCotainsIgnoreDieBuff = false
          end
        end
      end
      if 0 < tar.hp and IfRoleCotainsIgnoreDieBuff == false then
        self.setDeadRole[tar] = true
        LuaSkillCtrl:RemoveLife(tar.hp, self, tar, true, nil, false, true, eHurtType.RealDmg, true)
      end
    end
  end
  base.OnCasterDie(self)
end

function bs_212104:LuaDispose()
  base.LuaDispose(self)
  self.setDeadRole = nil
end

return bs_212104
