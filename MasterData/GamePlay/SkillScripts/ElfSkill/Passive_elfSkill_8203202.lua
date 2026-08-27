local bs_8203202 = class("bs_8203202", LuaSkillBase)
local base = LuaSkillBase
bs_8203202.config = {
  effectIdAttack = 608,
  HurtConfig = {hit_formula = 0, basehurt_formula = 10127},
  audioId_start = 120,
  audioId_hit = 121,
  buff_ExSkillSkill = 713
}

function bs_8203202:ctor()
end

function bs_8203202:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_8203202_01", 1, self.OnAfterHurt, nil, nil, nil, eBattleRoleBelong.player)
  self.count1 = 0
end

function bs_8203202:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if isMiss == true then
    self.count1 = self.count1 + 1
    if self.count1 >= self.arglist[2] then
      self.count1 = 0
      local targetList = LuaSkillCtrl:CallTargetSelect(self, 7, 20)
      if 1 <= targetList.Count and targetList[0] ~= nil then
        LuaSkillCtrl:CallEffect(targetList[0].targetRole, self.config.effectIdAttack, self, self.SkillEventFunc)
        return true
      else
        return false
      end
    end
  end
end

function bs_8203202:SkillEventFunc(effect, eventId, target)
  if eventId == eBattleEffectEvent.Trigger then
    local Damage = self.caster.skill_intensity
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
    LuaSkillCtrl:HurtResult(self, skillResult, self.config.HurtConfig, {Damage}, true)
    skillResult:EndResult()
  end
end

function bs_8203202:OnCasterDie()
  local MaxskillRole
  local targetList = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
  if targetList.Count > 0 then
    for i = 0, targetList.Count - 1 do
      if targetList[i].roleType == eBattleRoleType.character then
        if MaxskillRole == nil then
          MaxskillRole = targetList[i]
        end
        if targetList[i].skill_intensity >= MaxskillRole.skill_intensity then
          MaxskillRole = targetList[i]
        end
      end
    end
    LuaSkillCtrl:CallBuff(self, MaxskillRole, self.config.buff_ExSkillSkill, 1, nil, true)
  end
  base.OnCasterDie(self)
end

return bs_8203202
