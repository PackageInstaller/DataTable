local bs_104201 = class("bs_104201", LuaSkillBase)
local base = LuaSkillBase
bs_104201.config = {
  selectId = 10002,
  selectId2 = 9,
  selectId3 = 45,
  MoveBuffId = 104201,
  start_time = 10,
  end_time = 18,
  actionId_speed = 1.5,
  actionId = 1008,
  actionId_end = 1009,
  effectId_start = 104203,
  effectId_move = 104204,
  effectId_end = 104205,
  effectId_hit1 = 104207,
  effectId_buffDie = 104215,
  effectId_start_passive = 104218,
  effectZw = 104220,
  buffId_fit = 130,
  buffId_god = 3009,
  buffId_yinshen = 3016,
  buffId_CD = 170,
  buffId_attackCD = 104205,
  buffId_tag = 104204,
  nanaka_buffId = 102603,
  buffPj = 104206,
  buff_CD2 = 104207,
  Aoe = {
    effect_shape = 3,
    aoe_select_code = 4,
    aoe_range = 1
  },
  HurtConfig_aoe = {
    hit_formula = 0,
    basehurt_formula = 3000,
    crit_formula = 0,
    returndamage_formula = 0
  },
  heal_config = {baseheal_formula = 3022},
  audioId_hit = 104206,
  audioId_loop = 104204,
  weaponLv = 0
}

function bs_104201:ctor()
end

function bs_104201:InitSkill(isMidwaySkill)
  self.passive = false
  self.passive_effect = false
  base.InitSkill(self, isMidwaySkill)
  self.Mark = 0
  self.caster.recordTable.case = 1
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_104201_1", 1, self.OnAfterBattleStart)
  self:AddTrigger(eSkillTriggerType.SetDeadHurt, "bs_104201_3", 1, self.OnSetDeadHurt)
  self:AddTrigger(eSkillTriggerType.RoleDie, "bs_104201_11", 1, self.OnRoleDie)
  self:AddTrigger(eSkillTriggerType.BeforeBattleEnd, "bs_104201_4", 1, self.BeforeEndBattle)
end

function bs_104201:OnAfterBattleStart()
  if LuaSkillCtrl:RoleContainsBuffFeature(self.caster, eBuffFeatureType.Stun) ~= true then
    self:RealMove()
  end
  if self.config.weaponLv >= 2 then
    self.caster.recordTable.arg1 = self.arglist[8]
  end
end

function bs_104201:OnSetDeadHurt(context)
  if context.target == self.caster and self.passive == false and context.target:GetBuffTier(self.config.nanaka_buffId) <= 0 then
    self.passive = true
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_god, 1, 2)
    LuaSkillCtrl:StartTimer(nil, 1, function()
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, self.caster)
      LuaSkillCtrl:HealResult(skillResult, self.config.heal_config, {
        self.arglist[3]
      })
      skillResult:EndResult()
    end)
    if LuaSkillCtrl:RoleContainsBuffFeature(self.caster, eBuffFeatureType.Stun) ~= true then
      self.passive_effect = true
      self:RealMove()
    end
  end
end

function bs_104201:OnRoleDie(killer, role, killSkill)
  if role:GetBuffTier(self.config.buffId_tag) > 0 then
    LuaSkillCtrl:DispelBuff(role, self.config.buffId_tag, 1)
    if LuaSkillCtrl:RoleContainsBuffFeature(self.caster, eBuffFeatureType.Stun) ~= true then
      LuaSkillCtrl:CallEffect(role, self.config.effectId_buffDie, self)
      self:RealMove()
    end
  end
end

function bs_104201:RealMove()
  local targetList_old
  if self.Mark == 0 then
    targetList_old = LuaSkillCtrl:CallTargetSelect(self, self.config.selectId, 10)
  else
    targetList_old = LuaSkillCtrl:CallTargetSelect(self, self.config.selectId3, 10)
  end
  local target_one
  if 0 < targetList_old.Count then
    target_one = targetList_old[0].targetRole
  end
  self:CallCasterWait(self.config.start_time + 150)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_CD, 1, self.config.start_time + 3, true)
  local attackTrigger = BindCallback(self, self.OnAttackTrigger, target_one)
  LuaSkillCtrl:CallRoleAction(self.caster, self.config.actionId, self.config.action_speed)
  LuaSkillCtrl:StartTimer(nil, self.config.start_time, attackTrigger)
  local startEfcTarget = LuaSkillCtrl:GetTargetWithGrid(self.caster.x, self.caster.y)
  if self.passive_effect == true then
    LuaSkillCtrl:CallEffect(startEfcTarget, self.config.effectId_start_passive, self)
    self.passive_effect = false
  else
    LuaSkillCtrl:CallEffect(startEfcTarget, self.config.effectId_start, self)
  end
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_yinshen, 1, 15)
end

function bs_104201:OnAttackTrigger(target_one)
  if LuaSkillCtrl:RoleContainsBuffFeature(self.caster, eBuffFeatureType.Stun) then
    self:CancleCasterWait()
    LuaSkillCtrl:CallRoleAction(self.caster, self.config.actionId_end, 1)
    return
  end
  if target_one ~= nil and target_one.hp > 0 then
    local grid = LuaSkillCtrl:FindEmptyGridWithinRange(target_one, 1)
    if grid ~= nil then
      local MoveTime = LuaSkillCtrl:GetGridsDistance(grid.x, grid.y, self.caster.x, self.caster.y)
      LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_CD, 1, self.config.end_time + MoveTime, true)
      LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_attackCD, 1, self.config.end_time, true)
      LuaSkillCtrl:CallPhaseMove(self, self.caster, grid.x, grid.y, MoveTime, self.config.MoveBuffId)
      local move_effect = LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_move, self)
      self.move_audio = LuaSkillCtrl:PlayAuSource(self.caster, self.config.audioId_loop)
      LuaSkillCtrl:StartTimer(nil, MoveTime * 3, function()
        if move_effect ~= nil then
          move_effect:Die()
          move_effect = nil
        end
      end)
      LuaSkillCtrl:StartTimer(nil, MoveTime, function()
        self:GoUp()
        if self.move_audio ~= nil then
          LuaSkillCtrl:StopAudioByBack(self.move_audio)
          self.move_audio = nil
        end
      end)
      return
    end
  end
  local targetList
  if 1 <= self.config.weaponLv and self.Mark == 1 then
    targetList = LuaSkillCtrl:CallTargetSelect(self, self.config.selectId3, 10)
  else
    targetList = LuaSkillCtrl:CallTargetSelect(self, self.config.selectId, 10)
  end
  if 0 < targetList.Count then
    local target_move = targetList[0].targetRole
    local grid = LuaSkillCtrl:FindEmptyGridWithinRange(target_move, 1)
    if grid == nil then
      if 1 < targetList.Count then
        for i = 0, targetList.Count - 1 do
          local role = targetList[i].targetRole
          grid = LuaSkillCtrl:FindEmptyGridWithinRange(role, 1)
          if grid ~= nil then
            target_move = targetList[i].targetRole
            break
          end
        end
      end
      if targetList.Count == 1 then
        if LuaSkillCtrl:IsRoleAdjacent(self.caster, target_move) ~= true then
          local grid_list = LuaSkillCtrl:FindEmptyGridsWithinRange(target_move.x, target_move.y, 5)
          if grid_list ~= nil and 0 < grid_list.Count then
            grid = grid_list[0]
          end
        else
          LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_CD, 1, self.config.end_time, true)
          LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_attackCD, 1, self.config.end_time, true)
          self:GoUp()
        end
      end
    end
    if grid == nil then
      LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_CD, 1, self.config.end_time, true)
      LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_attackCD, 1, self.config.end_time, true)
      self:GoUp()
    end
    if grid ~= nil then
      local MoveTime = LuaSkillCtrl:GetGridsDistance(grid.x, grid.y, self.caster.x, self.caster.y)
      LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_CD, 1, self.config.end_time + MoveTime, true)
      LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_attackCD, 1, self.config.end_time, true)
      LuaSkillCtrl:CallPhaseMove(self, self.caster, grid.x, grid.y, MoveTime, self.config.MoveBuffId)
      local move_effect = LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_move, self)
      self.move_audio = LuaSkillCtrl:PlayAuSource(self.caster, self.config.audioId_loop)
      LuaSkillCtrl:StartTimer(nil, MoveTime * 3, function()
        if move_effect ~= nil then
          move_effect:Die()
          move_effect = nil
        end
      end)
      LuaSkillCtrl:StartTimer(nil, MoveTime, function()
        self:GoUp()
        if self.move_audio ~= nil then
          LuaSkillCtrl:StopAudioByBack(self.move_audio)
          self.move_audio = nil
        end
      end)
    end
  else
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_CD, 1, self.config.end_time, true)
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_attackCD, 1, self.config.end_time, true)
    self:GoUp()
  end
end

function bs_104201:GoUp()
  LuaSkillCtrl:StartTimer(nil, self.config.end_time + 2, function()
    self:CancleCasterWait()
  end)
  LuaSkillCtrl:CallRoleAction(self.caster, self.config.actionId_end, 1)
  if 1 <= self.config.weaponLv then
    self.Mark = 1
    LuaSkillCtrl:StartTimer(self, 10, function()
      LuaSkillCtrl:CallEffect(self.caster, self.config.effectZw, self)
      local targetList = LuaSkillCtrl:CallTargetSelectWithRange(self, self.config.selectId2, 2)
      if targetList.Count > 0 then
        for i = 0, targetList.Count - 1 do
          local role = targetList[i].targetRole
          if role.belongNum == eBattleRoleBelong.enemy then
            LuaSkillCtrl:CallBuff(self, role, self.config.buffPj, 1, self.arglist[6])
          end
          local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, role)
          LuaSkillCtrl:HurtResult(self, skillResult, self.config.HurtConfig_aoe, {
            self.arglist[5]
          })
          skillResult:EndResult()
        end
      end
    end, nil)
  end
  LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_end, self)
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, self.caster, self.config.Aoe)
  for i = 0, skillResult.roleList.Count - 1 do
    local role = skillResult.roleList[i]
    LuaSkillCtrl:CallBuff(self, role, self.config.buffId_fit, 1, self.arglist[1])
    LuaSkillCtrl:CallEffect(role, self.config.effectId_hit1, self)
  end
  LuaSkillCtrl:HurtResult(self, skillResult, self.config.HurtConfig_aoe, {
    self.arglist[2]
  })
  skillResult:EndResult()
  LuaSkillCtrl:PlayAuSource(self.caster, self.config.audioId_hit)
  if self.config.weaponLv >= 2 then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buff_CD2, 1, self.arglist[8], true)
    LuaSkillCtrl:CallResetCDNumForRole(self.caster, self.arglist[9])
    self:ShowDiveCounting()
    self.caster.recordTable.case = 1
  end
end

function bs_104201:OnCasterDie()
  self.caster.recordTable.case = 1
  base.OnCasterDie(self)
  if self.move_audio ~= nil then
    LuaSkillCtrl:StopAudioByBack(self.move_audio)
    self.move_audio = nil
  end
end

function bs_104201:BeforeEndBattle()
  if self.move_audio ~= nil then
    LuaSkillCtrl:StopAudioByBack(self.move_audio)
    self.move_audio = nil
  end
  self.Mark = 0
end

function bs_104201:OnBreakSkill(role)
  if role == self.caster then
    self:CancleCasterWait()
  end
  base.OnBreakSkill(self, role)
end

function bs_104201:LuaDispose()
  self.caster.recordTable.case = 1
  base.LuaDispose(self)
  self.move_audio = nil
  self.Mark = 0
end

return bs_104201
