local bs_102802 = class("bs_102802", LuaSkillBase)
local base = LuaSkillBase
bs_102802.config = {
  effectId_skill = 10707,
  buffId_228 = 102802,
  buffId_zw1 = 102805,
  buffId_zw2 = 102806,
  HurtConfig = {
    hit_formula = 0,
    basehurt_formula = 3010,
    crit_formula = 0
  },
  actionId = 1002,
  action_speed = 1,
  skill_time = 31,
  start_time = 11,
  audioId1 = 269,
  weaponLv = 0
}

function bs_102802:ctor()
end

function bs_102802:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_102802:PlaySkill(data)
  local last_target = self.caster.recordTable.lastAttackRole
  local target
  if last_target ~= nil and last_target.hp > 0 and last_target.belongNum ~= eBattleRoleBelong.neutral then
    target = last_target
  else
    local targetList = LuaSkillCtrl:CallTargetSelect(self, 33, 10)
    if 0 < targetList.Count then
      target = targetList[0].targetRole
      self:SetLastSelectTarget(targetList[0])
    end
  end
  if target ~= nil then
    local attackTrigger = BindCallback(self, self.OnAttackTrigger, target)
    self.caster:LookAtTarget(target)
    self:CallCasterWait(self.config.skill_time)
    LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.actionId, self.config.action_speed, self.config.start_time, attackTrigger)
    LuaSkillCtrl:PlayAuSource(self.caster, self.config.audioId1)
  end
end

function bs_102802:OnAttackTrigger(target)
  LuaSkillCtrl:CallEffect(target, self.config.effectId_skill, self, self.SkillEventFunc)
  self:SetLastSelectTarget(nil)
end

function bs_102802:OnBreakSkill(role)
  base.OnBreakSkill(self, role)
  if role == self.caster then
    self:SetLastSelectTarget(nil)
  end
end

function bs_102802:SkillEventFunc(effect, eventId, target)
  if eventId == eBattleEffectEvent.Trigger then
    if self.config.weaponLv >= 1 then
      local targetRole = target.targetRole
      if self.config.weaponLv >= 3 and targetRole:GetBuffTier(self.config.buffId_zw1) >= self.arglist[4] then
        local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
        LuaSkillCtrl:HurtResult(self, skillResult, self.config.HurtConfig, {
          self.arglist[7]
        })
        skillResult:EndResult()
        local targetList = LuaSkillCtrl:CallTargetSelectWithRange(self, 9, 10)
        if targetList.Count > 0 then
          for i = 0, targetList.Count - 1 do
            local temptargetRole = targetList[i].targetRole
            if temptargetRole.intensity ~= 0 and temptargetRole ~= targetRole then
              LuaSkillCtrl:CallBuffRepeated(self, temptargetRole, self.config.buffId_zw1, 1, self.arglist[9] + 1, false, false, self.OnBuffExecute)
              LuaSkillCtrl:CallBuff(self, temptargetRole, self.config.buffId_zw2, 1, self.arglist[9] + 1, true)
            end
          end
        end
      end
      LuaSkillCtrl:CallBuffRepeated(self, targetRole, self.config.buffId_zw1, 1, self.arglist[1] + self.arglist[5] + 1, false, false, self.OnBuffExecute)
      LuaSkillCtrl:CallBuff(self, targetRole, self.config.buffId_zw2, 1, self.arglist[1] + self.arglist[5] + 1, true)
      LuaSkillCtrl:StartTimer(nil, self.arglist[1] + self.arglist[5] + 2, function()
        self:OnSkillDamageEnd()
      end)
    else
      LuaSkillCtrl:CallBuffRepeated(self, target.targetRole, self.config.buffId_228, 1, self.arglist[1] + 1, false, false, self.OnBuffExecute)
      LuaSkillCtrl:StartTimer(nil, self.arglist[1] + 2, function()
        self:OnSkillDamageEnd()
      end)
    end
  end
end

function bs_102802:OnBuffExecute(buff, targetRole)
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, targetRole)
  local num = targetRole:GetBuffTier(self.config.buffId_zw1)
  if 2 <= num then
    LuaSkillCtrl:HurtResult(self, skillResult, self.config.HurtConfig, {
      self.arglist[3] + self.arglist[6]
    })
  else
    LuaSkillCtrl:HurtResult(self, skillResult, self.config.HurtConfig, {
      self.arglist[3]
    })
  end
  skillResult:EndResult()
end

function bs_102802:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_102802
