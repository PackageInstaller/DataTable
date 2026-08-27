local JiangyuAttackChange = {}
JiangyuAttackChange.config = {selectId = 6}

function JiangyuAttackChange:OnAttackTrigger(target, data, atkSpeedRatio, atkActionId, atkTriggerFrame)
  if data.audioId3 ~= nil then
    LuaSkillCtrl:PlayAuSource(self.caster, data.audioId3)
  end
  if LuaSkillCtrl:IsAbleAttackTarget(self.caster, target, self.caster.attackRange, true) then
    local targetList = LuaSkillCtrl:CallTargetSelectWithRange(self, self.config.selectId, 2, target)
    if targetList.Count > 0 then
      for i = 0, targetList.Count - 1 do
        local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, targetList[i].targetRole)
        LuaSkillCtrl:HurtResult(self, skillResult)
        skillResult:EndResult()
      end
    end
    if data.Imp == true then
      LuaSkillCtrl:PlayAuHit(self, target)
    end
    if self.caster.recordTable.completeFirstComatk == nil then
      self.caster.recordTable.completeFirstComatk = true
    end
  else
    self:BreakSkill()
  end
end

return JiangyuAttackChange
