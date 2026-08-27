local bs_8202 = class("bs_8202", LuaSkillBase)
local base = LuaSkillBase
bs_8202.config = {
  effectIdAttack = 603,
  buffId = 66,
  HurtConfig = {hit_formula = 0, basehurt_formula = 10127},
  audioId_start = 129,
  audioId_hit = 130,
  buff_chiyan = 107101
}

function bs_8202:ctor()
end

function bs_8202:InitSkill(isMidwaySkill)
end

function bs_8202:PlaySkill(data, selectTargetCoord, selectRoles)
  return self:GetSelectTargetAndExecute(selectRoles, BindCallback(self, self.CallSelectExecute))
end

function bs_8202:CallSelectExecute(role)
  if role ~= nil and role ~= nil and role.belongNum ~= self.caster.belongNum and not role.unableSelect then
    LuaSkillCtrl:CallEffect(role, self.config.effectIdAttack, self, self.SkillEventFunc)
    LuaSkillCtrl:PlayAuSource(role, self.config.audioId_start)
  end
end

function bs_8202:SkillEventFunc(effect, eventId, target)
  if eventId == eBattleEffectEvent.Trigger then
    LuaSkillCtrl:CallBattleCamShake(2)
    local highAttRole = LuaSkillCtrl:CallTargetSelect(self, 46, 20)
    if highAttRole ~= nil and highAttRole.Count > 0 and highAttRole[0] ~= nil then
      local buff_reload = highAttRole[0].targetRole
      local skill_intensity = buff_reload.skill_intensity
      LuaSkillCtrl:StartTimer(self, 6, function()
        local role = target:GetRole()
        if role == nil then
          return
        end
        if buff_reload ~= nil then
          LuaSkillCtrl:CallBuff(self, role, self.config.buff_chiyan, self.arglist[2], 120, false, buff_reload)
        end
        local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
        LuaSkillCtrl:HurtResult(self, skillResult, self.config.HurtConfig, {skill_intensity}, true)
        skillResult:BuffResult(self.config.buffId, 1, self.arglist[3])
        skillResult:EndResult()
        LuaSkillCtrl:PlayAuSource(role, self.config.audioId_hit)
      end)
    end
  end
end

function bs_8202:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_8202
