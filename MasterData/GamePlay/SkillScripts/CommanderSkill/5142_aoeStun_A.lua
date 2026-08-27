local bs_5142 = class("bs_5142", LuaSkillBase)
local base = LuaSkillBase
bs_5142.config = {
  effectIdAttack = 514201,
  buffId = 66,
  buffTier = 1,
  buffId_hurt = 252,
  HurtConfig = {hit_formula = 0, basehurt_formula = 10127},
  audioId_start = 131,
  audioId_hit = 132
}

function bs_5142:ctor()
end

function bs_5142:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_5142:PlaySkill(data, selectTargetCoord, selectRoles)
  return self:GetSelectTargetAndExecute(selectRoles, BindCallback(self, self.CallSelectExecute))
end

function bs_5142:CallSelectExecute(role)
  if role ~= nil and role ~= nil and role.belongNum ~= self.caster.belongNum and not role.unableSelect then
    LuaSkillCtrl:CallEffect(role, self.config.effectIdAttack, self, self.SkillEventFunc)
    LuaSkillCtrl:PlayAuSource(role, self.config.audioId_start)
  end
end

function bs_5142:SkillEventFunc(effect, eventId, target)
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
        skillResult:BuffResult(self.config.buffId, self.config.buffTier, self.arglist[2])
        LuaSkillCtrl:HurtResult(self, skillResult, self.config.HurtConfig, {skill_intensity}, true)
        skillResult:EndResult()
        LuaSkillCtrl:CallBuff(self, role, self.config.buffId_hurt, self.arglist[3])
        LuaSkillCtrl:PlayAuSource(role, self.config.audioId_hit)
      end)
    end
  end
end

function bs_5142:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_5142
