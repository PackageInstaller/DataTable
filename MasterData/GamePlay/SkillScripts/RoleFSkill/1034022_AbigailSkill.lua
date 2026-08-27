local bs_1034022 = class("bs_1034022", LuaSkillBase)
local base = LuaSkillBase
bs_1034022.config = {
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
  audioId2 = 279
}

function bs_1034022:ctor()
end

function bs_1034022:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_1034022:PlaySkill(data)
  LuaSkillCtrl:CallBreakAllSkill(self.caster)
  self:CallCasterWait(self.config.skill_time)
  LuaSkillCtrl:CallRoleAction(self.caster, self.config.actionId, self.config.speed)
  LuaSkillCtrl:PlayAuSource(self.caster, self.config.audioId1)
  LuaSkillCtrl:CallEffect(self.caster, self.config.effectId, self, self.SkillEventFunc, nil, self.config.speed, nil, false)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_170, 1, self.arglist[1], true)
  LuaSkillCtrl:StartShowSkillDurationTime(self, self.arglist[1])
end

function bs_1034022:SkillEventFunc(effect, eventId, target)
  if eventId == eBattleEffectEvent.Trigger then
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target, self.config.aoe_config)
    if skillResult.roleList.Count > 0 then
      for i = 0, skillResult.roleList.Count - 1 do
        LuaSkillCtrl:CallBuff(self, skillResult.roleList[i], self.config.buffId_Crit, 1, self.arglist[1])
      end
      skillResult:EndResult()
    end
  end
end

function bs_1034022:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_1034022
