local bs_8203201 = class("bs_8203201", LuaSkillBase)
local base = LuaSkillBase
bs_8203201.config = {
  effectIdAttack = 608,
  HurtConfig = {hit_formula = 0, basehurt_formula = 10127},
  audioId_start = 120,
  audioId_hit = 121,
  buff_ExSkillPow = 712
}

function bs_8203201:ctor()
end

function bs_8203201:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_8203201_01", 1, self.OnAfterHurt, nil, nil, nil, eBattleRoleBelong.player)
  self.count2 = 0
end

function bs_8203201:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if isMiss == true then
    self.count2 = self.count2 + 1
    if self.count2 >= self.arglist[2] then
      self.count2 = 0
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

function bs_8203201:SkillEventFunc(effect, eventId, target)
  if eventId == eBattleEffectEvent.Trigger then
    local Damage = self.caster.pow
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
    LuaSkillCtrl:HurtResult(self, skillResult, self.config.HurtConfig, {Damage}, true)
    skillResult:EndResult()
  end
end

function bs_8203201:OnCasterDie()
  local MaxpowRole
  local targetList = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
  if targetList.Count > 0 then
    for i = 0, targetList.Count - 1 do
      if targetList[i].roleType == eBattleRoleType.character and 0 < targetList[i].hp then
        if MaxpowRole == nil then
          MaxpowRole = targetList[i]
        end
        if targetList[i].pow >= MaxpowRole.pow then
          MaxpowRole = targetList[i]
        end
      end
    end
    LuaSkillCtrl:CallBuff(self, MaxpowRole, self.config.buff_ExSkillPow, 1, nil, true)
  end
  base.OnCasterDie(self)
end

return bs_8203201
