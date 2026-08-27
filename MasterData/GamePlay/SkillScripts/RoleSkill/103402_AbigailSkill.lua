local bs_103402 = class("bs_103402", LuaSkillBase)
local base = LuaSkillBase
bs_103402.config = {
  effectId = 10455,
  buffId_Crit = 103402,
  aoe_config = {
    effect_shape = 1,
    aoe_select_code = 3,
    aoe_range = 10
  },
  speed = 1,
  skill_time = 15,
  actionId = 1002,
  buffId_170 = 170,
  audioId1 = 278,
  audioId2 = 279,
  weaponLv = 0,
  buffId_Crit_ex = 103403
}

function bs_103402:ctor()
end

function bs_103402:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  if self.config.weaponLv > 1 then
    self:AddAfterHurtTrigger("bs_103402_2", 9, self.OnAfterHurt, nil, nil, self.caster.belongNum)
  end
end

function bs_103402:PlaySkill(data)
  LuaSkillCtrl:CallBreakAllSkill(self.caster)
  self:CallCasterWait(self.config.skill_time)
  LuaSkillCtrl:CallRoleAction(self.caster, self.config.actionId, self.config.speed)
  LuaSkillCtrl:PlayAuSource(self.caster, self.config.audioId1)
  LuaSkillCtrl:CallEffect(self.caster, self.config.effectId, self, self.SkillEventFunc, nil, self.config.speed, nil, false)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_170, 1, self.arglist[1], true)
  LuaSkillCtrl:StartShowSkillDurationTime(self, self.arglist[1])
end

function bs_103402:SkillEventFunc(effect, eventId, target)
  if eventId == eBattleEffectEvent.Trigger then
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target, self.config.aoe_config)
    if skillResult.roleList.Count > 0 then
      for i = 0, skillResult.roleList.Count - 1 do
        local buffId = self.config.buffId_Crit
        if 1 < self.config.weaponLv then
          buffId = self.config.buffId_Crit_ex
          skillResult.roleList[i].recordTable.Crit = self.caster.recordTable.Crit
          skillResult.roleList[i].recordTable.CritHurt = self.caster.recordTable.CritHurt
          skillResult.roleList[i].recordTable.CritMax = self.caster.recordTable.CritMax
        end
        LuaSkillCtrl:CallBuff(self, skillResult.roleList[i], buffId, 1, self.arglist[1])
      end
      skillResult:EndResult()
    end
  end
end

function bs_103402:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if (sender:GetBuffTier(self.config.buffId_Crit) > 0 or 0 < sender:GetBuffTier(self.config.buffId_Crit_ex)) and sender.belongNum == self.caster.belongNum and isTriggerSet ~= true and isCrit == true and 0 < hurt then
    local time = self.caster.recordTable.Time
    if time ~= nil then
      LuaSkillCtrl:CallResetCDNumForRole(self.caster, time)
    end
  end
end

function bs_103402:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_103402
