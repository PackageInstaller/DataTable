local ShaleSkillChange = {}
ShaleSkillChange.config = {selectId = 6}

function ShaleSkillChange:PlaySkill(data)
  LuaSkillCtrl:CallBreakAllSkill(self.caster)
  local target = self.caster.recordTable.lastAttackRole
  if target == nil or target.hp <= 0 or target.belongNum == eBattleRoleBelong.neutral then
    local tempTarget = self:GetMoveSelectTarget()
    if tempTarget ~= nil then
      target = tempTarget.targetRole
      self.caster:LookAtTarget(target)
    end
  end
  local attackTrigger = BindCallback(self, self.OnAttackTrigger, target)
  local skill_time = 60
  self:CallCasterWait(skill_time)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.actionId1_start, self.config.action_speed, self.config.start_time, attackTrigger)
end

function ShaleSkillChange:OnAttackTrigger(target, data)
  self.skillMode = true
  self.caster:AddRoleProperty(eHeroAttr.moveSpeed, 1000, eHeroAttrType.Origin)
  if target ~= nil or target.hp <= 0 then
    LuaSkillCtrl:BroadcastLuaTrigger(eSkillLuaTrigger.OnShaleBuffAdd, target, true)
  end
  self.effect = LuaSkillCtrl:CallEffect(self.caster, self.config.effcet_zuantou, self)
  local DamageTime = self.arglist[1] / self.arglist[2]
  self.timeskill = LuaSkillCtrl:StartTimer(nil, DamageTime, function()
    local A = LuaSkillCtrl:CallTargetSelect(self, 1)
    if A ~= nil and A.Count > 0 then
      local tempTarget = A[0].targetRole
      if tempTarget ~= nil and 0 < tempTarget.hp then
        self.caster:LookAtTarget(tempTarget)
        local targetList = LuaSkillCtrl:CallTargetSelectWithRange(self, self.config.selectId, 3, tempTarget)
        if targetList.Count > 0 then
          for i = 0, targetList.Count - 1 do
            LuaSkillCtrl:CallEffect(targetList[i].targetRole, self.config.effect_zuantousj, self)
            local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, targetList[i].targetRole)
            LuaSkillCtrl:HurtResult(self, skillResult)
            skillResult:EndResult()
          end
        end
      end
    end
    if self.timeskill.over then
      self:ChooseSkillEndAffect()
    end
  end, self, self.arglist[2] - 1, DamageTime)
end

function ShaleSkillChange:ChooseSkillEndAffect(target)
  LuaSkillCtrl:CallEffect(self.caster, self.config.effect_jiesuan, self)
  local BuffCoountMax = self.arglist[6] // self.arglist[5]
  if BuffCoountMax <= self.buffCount then
    self.buffCount = BuffCoountMax
  end
  local Arg = self.arglist[4] + self.buffCount * self.arglist[5]
  local A = LuaSkillCtrl:CallTargetSelect(self, 1)
  if A ~= nil and A.Count > 0 then
    local tempTarget = A[0].targetRole
    if tempTarget ~= nil or 0 < tempTarget.hp then
      local targetList = LuaSkillCtrl:CallTargetSelectWithRange(self, self.config.selectId, 3, tempTarget)
      if targetList.Count > 0 then
        for i = 0, targetList.Count - 1 do
          LuaSkillCtrl:CallEffect(targetList[i].targetRole, self.config.effect_jiesuansj, self)
          local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, targetList[i].targetRole)
          LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurt_config, {Arg})
          skillResult:EndResult()
        end
      end
    end
  end
  LuaSkillCtrl:StartTimer(self, self.config.end_time, function()
    self:CancleCasterWait()
  end)
  self.caster:AddRoleProperty(eHeroAttr.moveSpeed, -1000, eHeroAttrType.Origin)
  LuaSkillCtrl:CallRoleAction(self.caster, self.config.actionId1_end, self.config.action_speed)
  self.skillMode = false
  self.buffCount = 0
  self.skillTarget = nil
  if self.effect ~= nil then
    self.effect:Die()
    self.effect = nil
  end
  if self.timeskill ~= nil then
    self.timeskill:Stop()
    self.timeskill = nil
  end
end

return ShaleSkillChange
