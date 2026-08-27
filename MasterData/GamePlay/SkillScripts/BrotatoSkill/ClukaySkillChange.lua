local ClukaySkillChange = {}
ClukaySkillChange.config = {effectId_skillBz = 60628}

function ClukaySkillChange:PlaySkill(data)
  local realgrid = LuaSkillCtrl:CallFindGridMostRolesArounded(2)
  if realgrid ~= nil then
    local target = LuaSkillCtrl:FindRolesAroundGrid(realgrid, 2)
    if target ~= nil then
      local attackTrigger = BindCallback(self, self.OnActionCallBack1, target[0])
      self.caster:LookAtTarget(target[0])
      self:CallCasterWait(self.config.skill_time)
      LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.actionId, 1, self.config.start_time, attackTrigger)
    end
  end
  if LuaSkillCtrl:GetCasterSkinId(self.caster) == 305804 then
    LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_skillQk, self)
  end
end

function ClukaySkillChange:OnActionCallBack1(target)
  if LuaSkillCtrl:GetCasterSkinId(self.caster) == 305804 then
    LuaSkillCtrl:CallEffectWithArg(target, self.config.effectId_skill_04, self, false, false, self.OnEffectTrigger1)
  else
    LuaSkillCtrl:CallEffectWithArg(target, self.config.effectId_skill, self, false, false, self.OnEffectTrigger1)
    LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_skillQk, self)
  end
end

function ClukaySkillChange:OnEffectTrigger1(effect, eventId, target)
  if (effect.dataId == self.config.effectId_skill or effect.dataId == self.config.effectId_skill_04) and eventId == eBattleEffectEvent.Trigger then
    local roles = LuaSkillCtrl:FindAllRolesWithinRange(target.targetRole, 2, true)
    LuaSkillCtrl:CallEffect(target, self.config.effectId_skillBz, self)
    if roles ~= nil and roles.Count > 0 then
      for i = 0, roles.Count - 1 do
        if roles[i] ~= nil and 0 < roles[i].hp and roles[i].belongNum ~= self.caster.belongNum then
          local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, roles[i])
          LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.hurtConfig, {
            self.arglist[1]
          })
          skillResult:EndResult()
          LuaSkillCtrl:CallBuff(self, roles[i], self.config.buffIdys, 1, self.arglist[2])
          LuaSkillCtrl:CallBuffRepeated(self, roles[i], self.config.buffIdcx, 1, self.arglist[2] + 1, false, false, self.OnBuffExecute)
        end
      end
    end
    self:OnSkillDamageEnd()
  end
end

return ClukaySkillChange
