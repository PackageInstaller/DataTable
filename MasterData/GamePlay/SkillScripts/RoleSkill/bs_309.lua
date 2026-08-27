local bs_309 = class("bs_309", LuaSkillBase)
local base = LuaSkillBase
bs_309.config = {
  heal_config = {
    baseheal_formula = 1047,
    heal_number = 0,
    correct_formula = 9990
  },
  effectId2 = 10141,
  buffId = 66
}

function bs_309:ctor()
end

function bs_309:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSetHealTrigger("bs_309_1", 1, self.OnSetHeal, nil, nil, nil, nil, nil, nil, 309)
end

function bs_309:OnSetHeal(context)
  if context.skill.dataId == 309 then
    local targetList = LuaSkillCtrl:CallTargetSelect(self, 33, 1, context.target)
    if targetList.Count == 0 then
      return
    end
    for i = 0, targetList.Count - 1 do
      local distance = LuaSkillCtrl:GetRoleGridsDistance(targetList[i].targetRole, context.target)
      if distance < 2 then
        LuaSkillCtrl:RemoveLife(context.heal * 300 // 1000, self, targetList[i].targetRole)
        if 0 <= self.arglist[3] then
          LuaSkillCtrl:CallBuff(self, targetList[i].targetRole, self.config.buffId, 1, 15, true)
        end
      end
    end
  end
end

function bs_309:PlaySkill(data)
  local targetList = LuaSkillCtrl:CallTargetSelect(self, 30, 10)
  if targetList.Count == 0 then
    return
  end
  self.caster:LookAtTarget(targetList[0].targetRole)
  self:CallCasterWait(30)
  local attackTrigger = BindCallback(self, self.OnAttackTrigger, targetList[0].targetRole, data)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, 1002, 1, 20, attackTrigger)
end

function bs_309:OnAttackTrigger(target, data)
  LuaSkillCtrl:CallEffect(target, self.config.effectId1, self, self.SkillEventFunc)
end

function bs_309:SkillEventFunc(effect, eventId, target)
  if effect.dataId == self.config.effectId1 and eventId == eBattleEffectEvent.Trigger then
    LuaSkillCtrl:CallEffect(target, self.config.effectId2, self)
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
    LuaSkillCtrl:HealResult(skillResult, self.config.heal_config)
    skillResult:EndResult()
  end
end

function bs_309:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_309
