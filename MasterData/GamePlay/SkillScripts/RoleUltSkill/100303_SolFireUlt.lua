local bs_100303 = class("bs_100303", LuaSkillBase)
local base = LuaSkillBase
bs_100303.config = {
  hurt_config = {
    hit_formula = 0,
    basehurt_formula = 3023,
    crit_formula = 0,
    returndamage_formula = 0,
    hurt_type = 1
  },
  real_Config = {
    hit_formula = 0,
    basehurt_formula = 502,
    lifesteal_formula = 0,
    spell_lifesteal_formula = 0,
    returndamage_formula = 0,
    hurt_type = 2
  },
  effectId_start = 10310,
  effectId_hit = 10343,
  buffId = 3011,
  audioIdStart = 100309,
  audioIdMovie = 100310,
  audioIdEnd = 100311,
  actionId_start = 1005,
  movieEndRoleActionId = 1006
}

function bs_100303:ctor()
end

function bs_100303:InitSkill(isMidwaySkill)
end

function bs_100303:PlaySkill(data, selectTargetCoord, selectRoles, SelectRolesType)
  LuaSkillCtrl:CallBreakAllSkill(self.caster)
  self:CallCasterWait(23)
  self:GetSelectTargetAndExecute(selectRoles, BindCallback(self, self.CallSelectExecute), SelectRolesType)
  if selectTargetCoord ~= nil then
    local inputTarget = LuaSkillCtrl:GetTargetWithGrid(selectTargetCoord.x, selectTargetCoord.y)
    self.caster:LookAtTarget(inputTarget)
    LuaSkillCtrl:CallEffect(inputTarget, self.config.effectId_start, self)
  end
end

function bs_100303:CallSelectExecute(role)
  if role ~= nil and role.belongNum ~= self.caster.belongNum then
    LuaSkillCtrl:StartTimer(self, 5, BindCallback(self, self.CallSingleHurtEffect, role))
  end
end

function bs_100303:CallSingleHurtEffect(role)
  if self.caster ~= nil and self.caster.hp > 0 then
    LuaSkillCtrl:CallEffect(role, self.config.effectId_hit, self, self.SkillEventFunc1, nil, 1)
  end
end

function bs_100303:SkillEventFunc1(effect, eventId, target)
  if eventId == eBattleEffectEvent.Trigger and self.caster ~= nil and self.caster.hp > 0 then
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, target)
    LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurt_config, {
      self.arglist[1]
    }, false)
    skillResult:EndResult()
    local roleBuffTier = target.targetRole:GetBuffTier(self.config.buffId)
    if 0 < roleBuffTier then
      local hurt = roleBuffTier * self.caster.skill_intensity * self.arglist[2] // 1000
      if hurt <= 0 then
        hurt = 1
      end
      LuaSkillCtrl:CallRealDamage(self, target, nil, self.config.real_Config, {hurt}, true)
    end
  end
end

function bs_100303:PlayUltEffect()
  base.PlayUltEffect(self)
  LuaSkillCtrl:CallBuff(self, self.caster, 196, 1, 15, true)
  LuaSkillCtrl:CallFocusTimeLine(self.caster)
end

function bs_100303:OnUltRoleAction()
  base.OnUltRoleAction(self)
  LuaSkillCtrl:StartTimerInUlt(self, 7, self.PlayUltMovie)
  LuaSkillCtrl:CallRoleAction(self.caster, self.config.actionId_start)
end

function bs_100303:OnSkipUltView()
  base.OnSkipUltView(self)
end

function bs_100303:OnMovieFadeOut()
  base.OnMovieFadeOut(self)
end

function bs_100303:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_100303
