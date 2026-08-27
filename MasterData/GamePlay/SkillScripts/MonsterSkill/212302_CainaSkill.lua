local bs_212302 = class("bs_212302", LuaSkillBase)
local base = LuaSkillBase
bs_212302.config = {
  effectId = 212306,
  buffID_rage = 212302,
  MoveBuffId = 69,
  buffId_170 = 170,
  actionId = 1002,
  skill_time = 35,
  action_speed = 1,
  start_time = 17,
  jump_audioId1 = 212305,
  jump_audioId2 = 212304,
  effectId_jump_on = 212307,
  effectId_jump_off = 212308
}

function bs_212302:ctor()
end

function bs_212302:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.caster.recordTable.AtkSpd = self.arglist[1]
end

function bs_212302:PlaySkill(data)
  local Jump = BindCallback(self, self.OnJump)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.actionId, self.config.action_speed, self.config.start_time, Jump)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_170, 1, self.arglist[4], true)
  LuaSkillCtrl:PlayAuSource(self.caster, self.config.jump_audioId1)
  local callnextskill = BindCallback(self, self.EndSkillAndCallNext)
  LuaSkillCtrl:StartTimer(self, self.config.skill_time, callnextskill)
end

function bs_212302:OnJump()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffID_rage, 1, self.arglist[4], true)
  local grid = LuaSkillCtrl:CallFindEmptyGridMostRolesArounded(1)
  if grid == nil then
    return
  end
  local targetList = LuaSkillCtrl:FindRolesAroundGrid(grid, 1)
  if targetList == nil then
    return
  else
    local gird_now = LuaSkillCtrl:GetGridWithRole(self.caster)
    local targetList_now = LuaSkillCtrl:FindRolesAroundGrid(gird_now, 1)
    if targetList_now == nil or targetList.Count > targetList_now.Count then
      local Targetgrid = LuaSkillCtrl:GetTargetWithGrid(grid.x, grid.y)
      local MoveTime = LuaSkillCtrl:GetGridsDistance(grid.x, grid.y, self.caster.x, self.caster.y)
      self.caster:LookAtTarget(Targetgrid)
      local move_effect_jumpon = LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_jump_on, self)
      self.move_audio = LuaSkillCtrl:PlayAuSource(self.caster, self.config.jump_audioId2)
      LuaSkillCtrl:StartTimer(nil, MoveTime, function()
        if move_effect_jumpon ~= nil then
          move_effect_jumpon:Die()
          move_effect_jumpon = nil
        end
      end)
      LuaSkillCtrl:StartTimer(nil, MoveTime // 5, function()
        self.move_effect_jumpoff = LuaSkillCtrl:CallEffect(Targetgrid, self.config.effectId_jump_off, self)
        LuaSkillCtrl:SetRolePos(grid, self.caster)
      end)
      LuaSkillCtrl:StartTimer(nil, MoveTime * 2, function()
        if self.move_effect_jumpoff ~= nil then
          self.move_effect_jumpoff:Die()
          self.move_effect_jumpoff = nil
        end
        if self.move_audio ~= nil then
          LuaSkillCtrl:StopAudioByBack(self.move_audio)
          self.move_audio = nil
        end
      end)
    end
  end
end

function bs_212302:EndSkillAndCallNext()
  if self.caster == nil then
    return
  end
  self:CancleCasterWait()
  local skillMgr = self.caster:GetSkillComponent()
  if skillMgr == nil then
    return
  end
  skillMgr.lastSkill = self.cskill
  self:CancleCasterWait()
  self:CallNextBossSkill()
  LuaSkillCtrl:StopShowSkillDurationTime(self)
end

function bs_212302:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_212302
