local bs_106201 = class("bs_106201", LuaSkillBase)
local base = LuaSkillBase
bs_106201.config = {
  buffId_Taunt = 3002,
  buffId_unselected = 206806,
  buffId1 = 106201,
  buffId2 = 106203,
  MoveDuration = 4,
  effectId_show = 106216,
  effectId_cc = 106209,
  effectId_showdd = 106206,
  actionId1_start = 1008,
  actionId1_loop = 1007,
  actionId1_end = 1009,
  actionId1_end2 = 1056,
  actionId_start_time = 13,
  MoveDuration = 5,
  monsterId = 62,
  weaponLv = 0
}

function bs_106201:ctor()
end

function bs_106201:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHealTrigger("bs_106201_5", 2, self.OnAfterHeal, nil, nil, self.caster.belongNum)
  self:AddAfterHurtTrigger("bs_106201_3", 1, self.OnAfterHurt, nil, nil, nil)
  self:AddAfterAddBuffTrigger("bs_106201_7", 1, self.OnAfterAddBuff, nil, nil, self.caster.belongNum, nil, self.config.buffId2)
  self:AddLuaTrigger(eSkillLuaTrigger.OnJiangyuSkill, self.OnJiangyuSkill)
  self:AddOnRoleDieTrigger("bs_106201_2", 1, self.OnRoleDie, nil, nil, nil, self.caster.belongNum)
  self.num = 0
  self.caster.recordTable.c_add = self.arglist[9]
  self.caster.recordTable.c_addH = self.arglist[10]
  self.caster.recordTable.is_pass = flase
  self.maxCount = 2
  self.table = {}
  self.time = 0
  self.time2 = 0
end

function bs_106201:OnJiangyuSkill(target)
  if self.time2 < 1 then
    self.time2 = self.time2 + 1
    local grid = self:FindGrid(target)
    if table.length(self.table) < self.maxCount and grid ~= nil then
      LuaSkillCtrl:StartTimer(nil, 1 + self.config.actionId_start_time, function()
        local targetGrid = LuaSkillCtrl:GetTargetWithGrid(grid.x, grid.y)
        LuaSkillCtrl:CallEffect(targetGrid, self.config.effectId_showdd, self)
      end)
      LuaSkillCtrl:StartTimer(nil, 2 + self.config.actionId_start_time, function()
        self:Summon(grid)
      end)
    end
  end
end

function bs_106201:OnAfterAddBuff(buff, target)
  if target.belongNum ~= self.caster.belongNum then
    LuaSkillCtrl:CallBuff(self, target, self.config.buffId1, 1, self.arglist[7], false)
  end
end

function bs_106201:OnAfterHeal(sender, target, skill, heal, isStealHeal, isCrit, isTriggerSet)
  if sender.belongNum == self.caster.belongNum and isCrit and not isTriggerSet then
    self.num = self.num + 1
    if self.num >= self.arglist[1] and not self.caster.recordTable.IsInSkill1 and not LuaSkillCtrl:RoleContainsBuffFeature(self.caster, eBuffFeatureType.Stun) then
      self:Passive()
    end
  end
end

function bs_106201:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if sender.belongNum == self.caster.belongNum and isCrit and not isTriggerSet then
    self.num = self.num + 1
    if self.num >= self.arglist[1] and not self.caster.recordTable.IsInSkill1 and not LuaSkillCtrl:RoleContainsBuffFeature(self.caster, eBuffFeatureType.Stun) then
      self:Passive()
    end
  end
end

function bs_106201:Passive()
  local target = self.caster.recordTable.lastAttackRole
  self.num = 0
  local grid_now = LuaSkillCtrl:GetGridWithRole(self.caster)
  local last_target = self.caster.recordTable.lastAttackRole
  local target
  if last_target ~= nil and 0 < last_target.hp and last_target.belongNum ~= eBattleRoleBelong.neutral and LuaSkillCtrl:IsAbleAttackTarget(self.caster, last_target, self.cskill.SkillRange) then
    target = last_target
  else
    local tempTarget = self:GetMoveSelectTarget()
    if tempTarget == nil then
      self.num = self.arglist[1]
      return
    end
    target = tempTarget.targetRole
  end
  if target == nil or 0 >= target.hp then
    self.num = self.arglist[1]
    return
  end
  local grid = self:FindGrid(target)
  if grid == nil then
    self.num = self.arglist[1]
    return
  end
  LuaSkillCtrl:CallRoleAction(self.caster, self.config.actionId1_start, 1)
  self:CallCasterWait(self.config.actionId_start_time + self.config.MoveDuration + 3)
  LuaSkillCtrl:PreSetRolePos(grid, self.caster)
  LuaSkillCtrl:StartTimer(self, self.config.actionId_start_time, function()
    LuaSkillCtrl:CallRoleAction(self.caster, self.config.actionId_loop, 1)
    LuaSkillCtrl:CanclePreSetPos(self.caster)
    LuaSkillCtrl:CallPhaseMove(self, self.caster, grid.x, grid.y, self.config.MoveDuration, self.config.buffId_unselected)
    LuaSkillCtrl:StartTimer(nil, 1, function()
    end)
    local effect = LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_cc, self)
    LuaSkillCtrl:StartTimer(nil, self.config.MoveDuration + 3, function()
      if effect ~= nil then
        effect:Die()
        effect = nil
      end
    end)
    LuaSkillCtrl:CallResetCDNumForRole(self.caster, self.arglist[11])
  end)
  if table.length(self.table) < self.maxCount then
    LuaSkillCtrl:StartTimer(nil, 2 + self.config.actionId_start_time, function()
      local targetGrid = LuaSkillCtrl:GetTargetWithGrid(grid_now.x, grid_now.y)
      LuaSkillCtrl:CallEffect(targetGrid, self.config.effectId_showdd, self)
    end)
    LuaSkillCtrl:StartTimer(nil, 3 + self.config.actionId_start_time, function()
      self:Summon(grid_now, target)
    end)
  else
    self.time = self.time + 1
    if self.time % 2 == 0 then
      if table.length(self.table) >= self.maxCount then
        local role = self.table[2]
        if role ~= nil and 0 < role.hp then
          LuaSkillCtrl:DispelBuff(role, 106205)
          LuaSkillCtrl:RemoveLife(role.maxHp * 10, self, role, false, nil, false, true, 1, true)
        end
      end
    elseif table.length(self.table) >= self.maxCount then
      local role = self.table[1]
      if role ~= nil and 0 < role.hp then
        LuaSkillCtrl:DispelBuff(role, 106205)
        LuaSkillCtrl:RemoveLife(role.maxHp * 10, self, role, false, nil, false, true, 1, true)
      end
    end
    LuaSkillCtrl:StartTimer(nil, 1 + self.config.actionId_start_time, function()
      local targetGrid = LuaSkillCtrl:GetTargetWithGrid(grid_now.x, grid_now.y)
      LuaSkillCtrl:CallEffect(targetGrid, self.config.effectId_showdd, self)
    end)
    LuaSkillCtrl:StartTimer(nil, 2 + self.config.actionId_start_time, function()
      self:Summon(grid_now, target)
    end)
  end
  LuaSkillCtrl:StartTimer(self, self.config.actionId_start_time + self.config.MoveDuration, function()
    LuaSkillCtrl:CallRoleAction(self.caster, self.config.actionId1_end, 1)
    if target ~= nil then
      self.caster.recordTable.lastAttackRole = target
    end
  end)
end

function bs_106201:Summon(grid1, target, isCount)
  if grid1 ~= nil then
    local summonerEntity
    local role1 = LuaSkillCtrl:GetRoleWithPos(grid1.x, grid1.y)
    local Grid
    if role1 ~= nil then
      local Grid = self:FindGrid(target)
    else
      local Grid = grid1
      local monsterId = self.config.monsterId
      local summoner = LuaSkillCtrl:CreateSummoner(self, monsterId, Grid.x, Grid.y)
      summoner:SetAttr(eHeroAttr.maxHp, self.caster.maxHp * self.arglist[2] // 1000)
      summoner:SetAttr(eHeroAttr.skill_intensity, 0)
      summoner:SetAttr(eHeroAttr.pow, self.caster.pow * self.arglist[3] // 1000)
      summoner:SetAttr(eHeroAttr.speed, self.caster.speed)
      summoner:SetAttr(eHeroAttr.moveSpeed, 0)
      summoner:SetAttr(eHeroAttr.def, self.caster.def)
      summoner:SetAttr(eHeroAttr.magic_res, self.caster.magic_res)
      summoner:SetAttr(eHeroAttr.lucky, self.caster.lucky)
      summoner:SetAttr(eHeroAttr.crit, self.caster.crit * self.arglist[4] // 1000)
      summoner:SetAttr(eHeroAttr.critDamage, self.caster.critDamage)
      summoner:SetAttr(eHeroAttr.sunder, self.caster.sunder)
      summoner:SetAttr(eHeroAttr.damage_increase, self.caster.damage_increase)
      summoner:SetAttr(eHeroAttr.injury_reduce, self.caster.injury_reduce)
      summoner:SetAttr(eHeroAttr.magic_pen, self.caster.magic_pen)
      summoner:SetAsRealEntity(1)
      local arg1 = self.arglist[6]
      local arg2
      if self.table[1] == nil then
        arg2 = 1
      elseif self.table[2] == nil then
        arg2 = 2
      end
      local arg3 = self.arglist[5]
      local arg4 = self.arglist[2]
      local skinId = LuaSkillCtrl:GetCasterSkinId(self.caster)
      local tab = {
        arg_1 = arg1,
        arg_2 = arg2,
        arg_3 = arg3,
        arg_4 = arg4,
        skinId = skinId
      }
      summoner:SetRecordTable(tab)
      summonerEntity = LuaSkillCtrl:AddSummonerRole(summoner)
      if not isCount then
        if self.table[1] == nil then
          self.table[1] = summonerEntity
        elseif self.table[2] == nil then
          self.table[2] = summonerEntity
        end
      end
    end
  end
end

function bs_106201:OnRoleDie(killer, role)
  if role == self.table[1] then
    self.table[1] = nil
  elseif role == self.table[2] then
    self.table[2] = nil
  end
end

function bs_106201:FindGrid(role)
  if role ~= nil then
    local grid_dict = LuaSkillCtrl:FindEmptyGridsWithinRange(role.x, role.y, 1)
    if grid_dict == nil or grid_dict.Count <= 0 then
      local targetList = LuaSkillCtrl:CallTargetSelect(self, 9, 10)
      local grid2
      for i = 0, targetList.Count - 1 do
        if targetList[i] ~= nil and targetList[i].targetRole ~= nil and targetList[i].targetRole.belongNum ~= eBattleRoleBelong.neutral then
          local role1 = targetList[i].targetRole
          local grid_dict1 = LuaSkillCtrl:FindEmptyGridsWithinRange(role1.x, role1.y, 1)
          if grid_dict1 == nil or grid_dict1.Count == 0 then
            grid2 = nil
          else
            grid2 = grid_dict1[0]
            return grid2
          end
        end
      end
      local grid7 = LuaSkillCtrl:FindEmptyGrid(nil)
      return grid7
    else
      local dismax = 0
      local grid1 = grid_dict[0]
      for i = 0, grid_dict.Count - 1 do
        local dis = LuaSkillCtrl:GetGridsDistance(self.caster.x, self.caster.y, grid_dict[i].x, grid_dict[i].y)
        if dismax < dis then
          dismax = dis
          grid1 = grid_dict[i]
        end
      end
      return grid1
    end
  else
    local targetList = LuaSkillCtrl:CallTargetSelect(self, 9, 10)
    local grid4
    for i = 0, targetList.Count - 1 do
      if targetList[i] ~= nil and targetList[i].targetRole ~= nil and targetList[i].targetRole.belongNum ~= eBattleRoleBelong.neutral then
        local role1 = targetList[i].targetRole
        local grid_dict1 = LuaSkillCtrl:FindEmptyGridsWithinRange(role1.x, role1.y, 1)
        if grid_dict1 == nil or grid_dict1.Count == 0 then
          grid4 = nil
        else
          grid4 = grid_dict1[0]
          return grid4
        end
      end
    end
    local grid7 = LuaSkillCtrl:FindEmptyGrid(nil)
    return grid7
  end
end

function bs_106201:OnCasterDie()
  LuaSkillCtrl:CanclePreSetPos(self.caster)
  base.OnCasterDie(self)
end

function bs_106201:LuaDispose()
  self.table = nil
  base.LuaDispose(self)
end

return bs_106201
