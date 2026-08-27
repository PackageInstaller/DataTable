local base = require("GamePlay.SkillScripts.RoleFSkill.FakeCommonPassive")
local bs_1042012 = class("bs_1042012", base)
bs_1042012.config = {
  selectId = 10002,
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
  buffId_fit = 13001,
  buffId_god = 300901,
  buffId_yinshen = 301601,
  buffId_CD = 170,
  buffId_attackCD = 10420501,
  buffId_tag = 10420401,
  nanaka_buffId = 10260301,
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
  audioId_loop = 104204
}

function bs_1042012:ctor()
end

function bs_1042012:InitSkill(isMidwaySkill)
  self.passive = false
  self.passive_effect = false
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_1042012_1", 1, self.OnAfterBattleStart)
  self:AddTrigger(eSkillTriggerType.SetDeadHurt, "bs_1042012_3", 900, self.OnSetDeadHurt)
  self:AddTrigger(eSkillTriggerType.RoleDie, "bs_1042012_11", 1, self.OnRoleDie)
  self:AddTrigger(eSkillTriggerType.BeforeBattleEnd, "bs_1042012_4", 1, self.BeforeEndBattle)
end

function bs_1042012:OnAfterBattleStart()
  if LuaSkillCtrl:RoleContainsBuffFeature(self.caster, eBuffFeatureType.Stun) ~= true then
    self:RealMove()
  end
end

function bs_1042012:OnSetDeadHurt(context)
  local NoDeath = LuaSkillCtrl:RoleContainsBuffFeature(context.target, eBuffFeatureType.NoDeath)
  if context.target == self.caster and self.passive == false and context.target:GetBuffTier(self.config.nanaka_buffId) <= 0 and NoDeath == false then
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

function bs_1042012:OnRoleDie(killer, role, killSkill)
  if role:GetBuffTier(self.config.buffId_tag) > 0 then
    LuaSkillCtrl:DispelBuff(role, self.config.buffId_tag, 1)
    if LuaSkillCtrl:RoleContainsBuffFeature(self.caster, eBuffFeatureType.Stun) ~= true then
      LuaSkillCtrl:CallEffect(role, self.config.effectId_buffDie, self)
      self:RealMove()
    end
  end
end

function bs_1042012:RealMove()
  local targetList_old = LuaSkillCtrl:CallTargetSelect(self, self.config.selectId, 10)
  local target_one
  if targetList_old.Count > 0 then
    target_one = targetList_old[0].targetRole
  end
  self:CallCasterWait(self.config.start_time + 1)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_CD, 1, self.config.start_time + 3, true)
  local attackTrigger = BindCallback(self, self.OnAttackTrigger, target_one)
  LuaSkillCtrl:CallRoleAction(self.caster, self.config.actionId, self.config.action_speed)
  LuaSkillCtrl:StartTimer(self, self.config.start_time, attackTrigger)
  local startEfcTarget = LuaSkillCtrl:GetTargetWithGrid(self.caster.x, self.caster.y)
  if self.passive_effect == true then
    LuaSkillCtrl:CallEffect(startEfcTarget, self.config.effectId_start_passive, self)
    self.passive_effect = false
  else
    LuaSkillCtrl:CallEffect(startEfcTarget, self.config.effectId_start, self)
  end
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_yinshen, 1, 15)
end

function bs_1042012:OnAttackTrigger(target_one)
  if target_one ~= nil and target_one.hp > 0 then
    local grid = LuaSkillCtrl:FindEmptyGridWithinRange(target_one, 1)
    if grid ~= nil then
      local MoveTime = LuaSkillCtrl:GetGridsDistance(grid.x, grid.y, self.caster.x, self.caster.y)
      LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_CD, 1, self.config.end_time + MoveTime, true)
      LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_attackCD, 1, self.config.end_time, true)
      self:CallCasterWait(self.config.end_time + MoveTime)
      LuaSkillCtrl:CallPhaseMove(self, self.caster, grid.x, grid.y, MoveTime, self.config.MoveBuffId)
      local move_effect = LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_move, self)
      self.move_audio = LuaSkillCtrl:PlayAuSource(self.caster, self.config.audioId_loop)
      LuaSkillCtrl:StartTimer(nil, MoveTime * 3, function()
        if move_effect ~= nil then
          move_effect:Die()
          move_effect = nil
        end
      end)
      LuaSkillCtrl:StartTimer(self, MoveTime, function()
        self:GoUp()
        if self.move_audio ~= nil then
          LuaSkillCtrl:StopAudioByBack(self.move_audio)
          self.move_audio = nil
        end
      end)
      return
    end
  end
  local targetList = LuaSkillCtrl:CallTargetSelect(self, self.config.selectId, 10)
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
          self:CallCasterWait(self.config.end_time)
          self:GoUp()
        end
      end
    end
    if grid == nil then
      LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_CD, 1, self.config.end_time, true)
      LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_attackCD, 1, self.config.end_time, true)
      self:CallCasterWait(self.config.end_time)
      self:GoUp()
    end
    if grid ~= nil then
      local MoveTime = LuaSkillCtrl:GetGridsDistance(grid.x, grid.y, self.caster.x, self.caster.y)
      LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_CD, 1, self.config.end_time + MoveTime, true)
      LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_attackCD, 1, self.config.end_time, true)
      self:CallCasterWait(self.config.end_time + MoveTime)
      LuaSkillCtrl:CallPhaseMove(self, self.caster, grid.x, grid.y, MoveTime, self.config.MoveBuffId)
      local move_effect = LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_move, self)
      self.move_audio = LuaSkillCtrl:PlayAuSource(self.caster, self.config.audioId_loop)
      LuaSkillCtrl:StartTimer(nil, MoveTime * 3, function()
        if move_effect ~= nil then
          move_effect:Die()
          move_effect = nil
        end
      end)
      LuaSkillCtrl:StartTimer(self, MoveTime, function()
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
    self:CallCasterWait(self.config.end_time)
    self:GoUp()
  end
end

function bs_1042012:GoUp()
  LuaSkillCtrl:CallRoleAction(self.caster, self.config.actionId_end, 1)
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
end

function bs_1042012:OnCasterDie()
  base.OnCasterDie(self)
  if self.move_audio ~= nil then
    LuaSkillCtrl:StopAudioByBack(self.move_audio)
    self.move_audio = nil
  end
end

function bs_1042012:BeforeEndBattle()
  if self.move_audio ~= nil then
    LuaSkillCtrl:StopAudioByBack(self.move_audio)
    self.move_audio = nil
  end
end

function bs_1042012:LuaDispose()
  base.LuaDispose(self)
  self.move_audio = nil
end

return bs_1042012
