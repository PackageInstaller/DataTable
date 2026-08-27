local bs_9001 = class("bs_9001", LuaSkillBase)
local base = LuaSkillBase
bs_9001.config = {
  effectIdAttack = 511101,
  HurtConfig = {hit_formula = 0, basehurt_formula = 10127},
  audioId_start = 120,
  audioId_hit = 121,
  skillId = 5111
}

function bs_9001:InitSkill(isMidwaySkill)
  self:AddOnRoleDieTrigger("bs_9001_1", 1, self.OnRoleDie, self.caster, nil, nil, nil, nil, nil, self.config.skillId)
end

function bs_9001:PlaySkill(data)
  local targetList = LuaSkillCtrl:CallTargetSelect(self, 7, 20)
  if targetList.Count >= 1 and targetList[0] ~= nil then
    LuaSkillCtrl:CallEffect(targetList[0].targetRole, self.config.effectIdAttack, self, self.SkillEventFunc)
    LuaSkillCtrl:PlayAuSource(targetList[0].targetRole, self.config.audioId_start)
    return true
  else
    return false
  end
end

function bs_9001:SkillEventFunc(effect, eventId, target)
  if eventId == eBattleEffectEvent.Trigger then
    LuaSkillCtrl:PlayAuSource(target.targetRole, self.config.audioId_hit)
    LuaSkillCtrl:CallBattleCamShake(1)
    if target ~= nil then
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
      LuaSkillCtrl:HurtResultWithConfig(self, skillResult, 14, {
        target.targetRole.maxHp
      })
      skillResult:EndResult()
    end
  end
end

function bs_9001:OnRoleDie(killer, role, killSkill)
  LuaSkillCtrl:CallAddPlayerMp(self.arglist[2])
end

function bs_9001:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_9001
