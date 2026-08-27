local bs_5112 = class("bs_5112", LuaSkillBase)
local base = LuaSkillBase
bs_5112.config = {
  effectIdAttack = 511201,
  HurtConfig_1 = {hit_formula = 0, basehurt_formula = 10128},
  audioId_start = 122,
  audioId_hit = 123,
  skillId = 5112
}

function bs_5112:ctor()
end

function bs_5112:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddOnRoleDieTrigger("bs_5112_1", 1, self.OnRoleDie, self.caster, nil, nil, nil, nil, nil, self.config.skillId)
end

function bs_5112:PlaySkill(data)
  local targetList = LuaSkillCtrl:CallTargetSelect(self, 7, 20)
  if targetList.Count >= 1 and targetList[0] ~= nil then
    LuaSkillCtrl:CallEffect(targetList[0].targetRole, self.config.effectIdAttack, self, self.SkillEventFunc)
    LuaSkillCtrl:PlayAuSource(targetList[0].targetRole, self.config.audioId_start)
    return true
  else
    return false
  end
end

function bs_5112:SkillEventFunc(effect, eventId, target)
  if eventId == eBattleEffectEvent.Trigger then
    LuaSkillCtrl:CallBattleCamShake(1)
    local highAttRole = LuaSkillCtrl:CallTargetSelect(self, 46, 20)
    if highAttRole ~= nil and highAttRole.Count > 0 and highAttRole[0] ~= nil then
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
      LuaSkillCtrl:HurtResult(self, skillResult, self.config.HurtConfig_1, {
        highAttRole[0].targetRole.skill_intensity
      }, true)
      skillResult:EndResult()
      LuaSkillCtrl:PlayAuSource(target.targetRole, self.config.audioId_hit)
    end
  end
end

function bs_5112:OnRoleDie(killer, role, killSkill)
  LuaSkillCtrl:CallAddPlayerMp(self.arglist[4])
end

function bs_5112:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_5112
