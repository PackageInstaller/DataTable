local bs_101702 = class("bs_101702", LuaSkillBase)
local base = LuaSkillBase
bs_101702.config = {
  actionId = 1008,
  actionId_loop = 1007,
  actionId_end = 1009,
  action_speed = 2,
  skill_time = 13,
  start_time = 12,
  end_time = 15,
  audioId1 = 101701,
  audioId2 = 101702,
  effectId_start = 101705,
  effectId_player = 101703,
  effectId_entiy = 101704
}

function bs_101702:ctor()
end

function bs_101702:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.caster.recordTable.Open = false
  self.caster.recordTable.Skill_target = nil
  local bind = self:GetSelfBindingObj()
  if bind ~= nil and self.caster.recordTable.books == nil then
    local bookArray = {}
    for i = 1, 3 do
      table.insert(bookArray, bind.specialObj[i])
    end
    self.caster.recordTable.books = bookArray
  end
end

function bs_101702:PlaySkill(data)
  local targetList = LuaSkillCtrl:CallTargetSelect(self, 58, 10)
  if targetList.Count == 0 then
    return
  end
  local target_skill = targetList[0].targetRole
  if target_skill ~= nil then
    self:CallCasterWait(self.config.skill_time + self.config.end_time)
    local attackTrigger = BindCallback(self, self.OnAttackTrigger, target_skill)
    self.caster:LookAtTarget(target_skill)
    LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.actionId, self.config.action_speed, self.config.start_time, attackTrigger)
    LuaSkillCtrl:PlayAuSource(self.caster, self.config.audioId1)
    LuaSkillCtrl:StartTimer(self, 5, function()
      self:SetBookDisActive(1)
      self:SetBookActive(2)
    end)
  end
end

function bs_101702:SetBookActive(index)
  local bookArray = self.caster.recordTable.books
  if bookArray == nil then
    return
  end
  if bookArray[index] ~= nil then
    bookArray[index]:SetActive(true)
  end
end

function bs_101702:SetBookDisActive(index)
  local bookArray = self.caster.recordTable.books
  if bookArray == nil then
    return
  end
  if bookArray[index] ~= nil then
    bookArray[index]:SetActive(false)
  end
end

function bs_101702:OnAttackTrigger(target)
  LuaSkillCtrl:PlayAuSource(self.caster, self.config.audioId2)
  LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_start, self)
  local targetList = LuaSkillCtrl:CallTargetSelect(self, 2, 10)
  if targetList.Count > 0 then
    for i = 0, targetList.Count - 1 do
      local role = targetList[i].targetRole
      if role ~= nil and 0 < role.hp then
        LuaSkillCtrl:CallEffect(role, self.config.effectId_player, self)
        LuaSkillCtrl:CallResetCDNumForRole(role, self.arglist[1])
      end
    end
  end
  local down = -self.arglist[2]
  LuaSkillCtrl:CallResetMainSkillCDNumForTeam(target.belongNum, down)
  local targetList = LuaSkillCtrl:CallTargetSelect(self, 9, 10)
  if targetList.Count > 0 then
    for i = 0, targetList.Count - 1 do
      local role = targetList[i].targetRole
      if role ~= nil and 0 < role.hp and role.intensity ~= 0 then
        LuaSkillCtrl:CallEffect(role, self.config.effectId_entiy, self)
      end
    end
  end
  self:End(target)
end

function bs_101702:End(target)
  LuaSkillCtrl:CallRoleAction(self.caster, self.config.actionId_end)
  LuaSkillCtrl:StartTimer(self, 5, function()
    self:CancleCasterWait()
  end)
  LuaSkillCtrl:StartTimer(self, 3, function()
    self:SetBookDisActive(2)
    self:SetBookActive(1)
  end)
end

function bs_101702:OnSkillRemove()
  base.OnSkillRemove(self)
end

function bs_101702:OnCasterDie()
  base.OnCasterDie(self)
end

function bs_101702:LuaDispose()
  base.LuaDispose(self)
end

return bs_101702
