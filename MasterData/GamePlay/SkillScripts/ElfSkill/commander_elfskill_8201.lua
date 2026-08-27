local bs_8201 = class("bs_8201", LuaSkillBase)
local base = LuaSkillBase
bs_8201.config = {
  effectIdAttack = 601,
  HurtConfigID1 = 41,
  HurtConfigID2 = 42,
  audioId_start = 124,
  audioId_hit = 125,
  skill_intensity = 1,
  pow = 2,
  buff_id = 604
}

function bs_8201:InitSkill(isMidwaySkill)
end

function bs_8201:PlaySkill(data)
  local targetList = LuaSkillCtrl:CallTargetSelect(self, 7, 20)
  if targetList.Count >= 1 and targetList[0] ~= nil then
    LuaSkillCtrl:CallEffect(targetList[0].targetRole, self.config.effectIdAttack, self, self.SkillEventFunc)
    LuaSkillCtrl:PlayAuSource(targetList[0].targetRole, self.config.audioId_start)
    return true
  else
    return false
  end
end

function bs_8201:SkillEventFunc(effect, eventId, target)
  if eventId == eBattleEffectEvent.Trigger then
    LuaSkillCtrl:CallBattleCamShake(1)
    local highAttRole, MaxNum, attacktype
    local highAttRole, MaxNum = LuaSkillCtrl:CallFindMaxPowOrSkillIntensityRole()
    if highAttRole.skill_intensity > highAttRole.pow then
      attacktype = self.config.skill_intensity
    else
      attacktype = self.config.pow
    end
    if highAttRole ~= nil and attacktype ~= nil and target ~= nil then
      LuaSkillCtrl:CallBuff(self, target.targetRole, self.config.buff_id, 1, self.arglist[3], true)
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
      if attacktype == self.config.skill_intensity then
        LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.HurtConfigID1, {MaxNum}, true)
      elseif attacktype == self.config.pow then
        LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.HurtConfigID2, {MaxNum}, true)
      end
      skillResult:EndResult()
      LuaSkillCtrl:PlayAuSource(target.targetRole, self.config.audioId_hit)
    end
  end
end

function bs_8201:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_8201
