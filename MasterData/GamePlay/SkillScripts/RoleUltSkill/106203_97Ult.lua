local bs_106203 = class("bs_106203", LuaSkillBase)
local base = LuaSkillBase
bs_106203.config = {
  start_time = 5,
  end_time = 35,
  effectId_loop = 106212,
  effectId_end = 106213,
  effectId_hit = 106204,
  configId_trail = 3,
  buffId1 = 106201,
  buffId2 = 106202,
  buffId3 = 106203,
  hurtConfig = 25,
  summerId = 62,
  audioIdStart = 106209,
  audioIdMovie = 106210,
  audioIdEnd = 106211
}

function bs_106203:ctor()
end

function bs_106203:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_106203:PlaySkill(data, selectTargetCoord, selectRoles)
  local skill_time = 80
  self:TryResetMoveState(self.caster)
  local tempRole = self.caster
  if self.caster == LuaSkillCtrl:GetPlayerRoleEntity() then
  end
  local grid = LuaSkillCtrl:GetGridWithRole(tempRole)
  self.caster.lsObject:SetPositionForce(grid.fixLogicPosition)
  self:CallCasterWait(skill_time)
  LuaSkillCtrl:CallBuff(self, self.caster, 196, 1, skill_time, true)
  self.caster.recordTable.IsInSkill1 = true
  LuaSkillCtrl:StartTimer(nil, 1, function()
    LuaSkillCtrl:CallRoleAction(self.caster, 1010)
    local targetlist = LuaSkillCtrl:CallTargetSelectWithRange(self, 9, 1)
    if targetlist.Count > 0 and targetlist[0].targetRole ~= nil then
      self.caster:LookAtTarget(targetlist[0].targetRole)
    end
  end)
  local targetGrid = LuaSkillCtrl:GetGridWithPos(selectTargetCoord.x, selectTargetCoord.y)
  if targetGrid ~= nil then
    LuaSkillCtrl:CallBreakAllSkill(self.caster)
    self:TryResetMoveState(self.caster)
    LuaSkillCtrl:SetRolePos(targetGrid, self.caster)
  end
  local starttime = self.arglist[1] - 1
  local targetlist = LuaSkillCtrl:CallTargetSelectWithRange(self, 6, 10)
  if targetlist.Count > 0 then
    for i = 0, targetlist.Count - 1 do
      if targetlist[i].targetRole ~= nil and targetlist[i].targetRole.roleDataId == self.config.summerId then
        LuaSkillCtrl:CallBuff(self, targetlist[i].targetRole, self.config.buffId2, 1)
      end
    end
  end
  self.skillLoop = LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_loop, self, nil, nil, nil, true)
  LuaSkillCtrl:StartTimer(self, 25, function()
    LuaSkillCtrl:CallRoleAction(self.caster, 1006)
  end)
  self.beginTimer = LuaSkillCtrl:StartTimer(self, self.arglist[1] + 1, function()
    self:beginAttack()
  end, self, -1, starttime)
  self.time = LuaSkillCtrl:StartTimer(self, self.arglist[3], function()
    if self.beginTimer ~= nil then
      self.beginTimer:Stop()
      self.beginTimer = nil
    end
    self:endAttack()
  end)
end

function bs_106203:beginAttack()
  local targetlist = LuaSkillCtrl:CallTargetSelectWithRange(self, 9, 1)
  if targetlist.Count > 0 then
    for i = 0, targetlist.Count - 1 do
      if targetlist[i].targetRole ~= nil then
        LuaSkillCtrl:CallBuff(self, targetlist[i].targetRole, self.config.buffId3, 1)
        local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, targetlist[i].targetRole)
        LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.hurtConfig, {
          self.arglist[2]
        })
        skillResult:EndResult()
        LuaSkillCtrl:CallEffect(targetlist[i].targetRole, self.config.effectId_hit, self)
      end
    end
  end
end

function bs_106203:endAttack()
  if self.beginTimer ~= nil then
    self.beginTimer:Stop()
    self.beginTimer = nil
  end
  if self.time ~= nil then
    self.time:Stop()
    self.time = nil
  end
  self.caster.recordTable.IsInSkill1 = false
  LuaSkillCtrl:StartTimer(self, 20, function()
    self:CancleCasterWait()
  end)
end

function bs_106203:OnUltRoleAction()
  base.OnUltRoleAction(self)
  LuaSkillCtrl:StartTimerInUlt(self, 7, self.PlayUltMovie)
  LuaSkillCtrl:CallRoleAction(self.caster, 1005, 1.5)
end

function bs_106203:PlayUltEffect(data, selectTargetCoord, selectRoles)
  base.PlayUltEffect(self)
  LuaSkillCtrl:CallBuff(self, self.caster, 196, 1, 15, true)
  LuaSkillCtrl:CallFocusTimeLine(self.caster)
end

function bs_106203:OnSkipUltView()
  base.OnSkipUltView(self)
end

function bs_106203:OnMovieFadeOut()
  base.OnMovieFadeOut(self)
end

function bs_106203:OnCasterDie()
  base.OnCasterDie(self)
  if self.skillLoop ~= nil then
    self.skillLoop:Die()
    self.skillLoop = nil
  end
  if self.beginTimer ~= nil then
    self.beginTimer:Stop()
    self.beginTimer = nil
  end
  if self.time ~= nil then
    self.time:Stop()
    self.time = nil
  end
  if self.skillend ~= nil then
    self.skillend:Die()
    self.skillend = nil
  end
end

function bs_106203:LuaDispose()
  base.LuaDispose(self)
  if self.skillLoop ~= nil then
    self.skillLoop:Die()
    self.skillLoop = nil
  end
  if self.beginTimer ~= nil then
    self.beginTimer:Stop()
    self.beginTimer = nil
  end
  if self.time ~= nil then
    self.time:Stop()
    self.time = nil
  end
  if self.skillend ~= nil then
    self.skillend:Die()
    self.skillend = nil
  end
end

return bs_106203
