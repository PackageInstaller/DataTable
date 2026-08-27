local bs_5143 = class("bs_5143", LuaSkillBase)
local base = LuaSkillBase
bs_5143.config = {
  effectIdAttack = 514301,
  buffId = 251,
  buffTier = 1,
  effectId_bnfffire = 514302,
  buffIdstun = 66,
  buffTierstun = 1,
  HurtConfig = {hit_formula = 0, basehurt_formula = 10127},
  HurtConfig_ex = {
    hit_formula = 0,
    basehurt_formula = 10133,
    crit_formula = 0,
    lifesteal_formula = 0,
    spell_lifesteal_formula = 0,
    returndamage_formula = 0
  },
  audioId_start = 133,
  audioId_hit = 134
}

function bs_5143:ctor()
end

function bs_5143:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_5143:PlaySkill(data, selectTargetCoord, selectRoles)
  return self:GetSelectTargetAndExecute(selectRoles, BindCallback(self, self.CallSelectExecute))
end

function bs_5143:CallSelectExecute(role)
  if role ~= nil and role ~= nil and role.belongNum ~= self.caster.belongNum and not role.unableSelect then
    LuaSkillCtrl:CallEffect(role, self.config.effectIdAttack, self, self.SkillEventFunc)
    LuaSkillCtrl:PlayAuSource(role, self.config.audioId_start)
  end
end

function bs_5143:SkillEventFunc(effect, eventId, target)
  if eventId == eBattleEffectEvent.Trigger then
    LuaSkillCtrl:CallBattleCamShake(2)
    local highAttRole = LuaSkillCtrl:CallTargetSelect(self, 46, 20)
    if highAttRole ~= nil and highAttRole.Count > 0 and highAttRole[0] ~= nil then
      local skill_intensity = highAttRole[0].targetRole.skill_intensity
      LuaSkillCtrl:StartTimer(self, 6, function()
        local role = target:GetRole()
        if role == nil then
          return
        end
        local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
        LuaSkillCtrl:HurtResult(self, skillResult, self.config.HurtConfig, {skill_intensity}, true)
        skillResult:BuffResult(self.config.buffIdstun, self.config.buffTierstun, self.arglist[2])
        skillResult:EndResult()
        LuaSkillCtrl:CallBuffRepeated(self, role, self.config.buffId, self.config.buffTier, self.arglist[4], nil, false, self.OnBuffExecute, skill_intensity)
        LuaSkillCtrl:PlayAuSource(role, self.config.audioId_hit)
      end)
    end
  end
end

function bs_5143:OnBuffExecute(skill_intensity, buff, targetRole)
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, targetRole)
  LuaSkillCtrl:HurtResult(self, skillResult, self.config.HurtConfig_ex, {skill_intensity}, true)
  skillResult:EndResult()
  LuaSkillCtrl:CallEffect(targetRole, self.config.effectId_bnfffire, self)
end

function bs_5143:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_5143
