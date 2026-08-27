local bs_103903 = class("bs_103903", LuaSkillBase)
local base = LuaSkillBase
bs_103903.config = {
  hurt_config = {
    hit_formula = 0,
    basehurt_formula = 3000,
    def_formula = 9996,
    minhurt_formula = 9994,
    crit_formula = 0,
    crithur_ratio = 9995,
    correct_formula = 9989,
    lifesteal_formula = 1001,
    spell_lifesteal_formula = 1002,
    returndamage_formula = 1000,
    hurt_type = -1
  },
  buffId = 66,
  buffTier = 1,
  effectId_UltID = 103901,
  effectId_Hurt = 103902,
  effectId_Sj = 103903,
  effect_speed = 10,
  effect_radius = 50,
  audioIdStart = 103902,
  audioIdMovie = 103903
}

function bs_103903:ctor()
end

function bs_103903:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.effectStart = nil
end

function bs_103903:PlaySkill(data, selectTargetCoord, selectRoles)
  LuaSkillCtrl:CallBreakAllSkill(self.caster)
  local inputTarget = LuaSkillCtrl:GetTargetWithGrid(selectTargetCoord.x, selectTargetCoord.y)
  self.caster:LookAtTarget(inputTarget)
  self:CallCasterWait(self.arglist[2] * 2)
  LuaSkillCtrl:CallRoleAction(self.caster, 1010)
  self.effectStart = LuaSkillCtrl:CallEffect(inputTarget, self.config.effectId_UltID, self, nil, nil, nil, true)
  local totalEmitTime = self.arglist[2] - 1
  LuaSkillCtrl:StartTimer(self, 2, BindCallback(self, self.CallEffectAndEmissions, inputTarget), nil, totalEmitTime, 2)
  LuaSkillCtrl:StartTimer(self, self.arglist[2] * 2, function()
    LuaSkillCtrl:CallRoleAction(self.caster, 100)
  end)
end

function bs_103903:CallEffectAndEmissions(inputTarget)
  local cusEffect = LuaSkillCtrl:CallEffect(inputTarget, self.config.effectId_Hurt, self, nil, nil, 0.17)
  local collisionTrigger = BindCallback(self, self.OnCollision, cusEffect)
  LuaSkillCtrl:CallCircledEmissionStraightly(self, self.caster, inputTarget, 30, 10, eColliderInfluenceType.Enemy, collisionTrigger, nil, nil, nil, true, true, BindCallback(self, self.OnArive, cusEffect))
end

function bs_103903:OnArive(cusEffect)
  if cusEffect ~= nil and not cusEffect:IsDie() then
    cusEffect:Die()
  end
end

function bs_103903:OnCollision(cusEffect, collider, index, entity)
  if self.caster == nil or self.caster.hp <= 0 or entity == nil or entity.hp <= 0 then
    return
  end
  if LuaSkillCtrl:IsFixedObstacle(entity) then
    return
  end
  if cusEffect ~= nil and not cusEffect:IsDie() then
    cusEffect:Die()
  end
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, entity)
  LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurt_config, {
    self.arglist[1]
  }, false)
  LuaSkillCtrl:CallEffect(entity, self.config.effectId_Sj, self)
  skillResult:EndResult()
  LuaSkillCtrl:ClearColliderOrEmission(collider)
end

function bs_103903:PlayUltEffect()
  base.PlayUltEffect(self)
  LuaSkillCtrl:CallBuff(self, self.caster, 196, 1, 15, true)
  LuaSkillCtrl:CallFocusTimeLine(self.caster)
end

function bs_103903:OnUltRoleAction()
  base.OnUltRoleAction(self)
  LuaSkillCtrl:StartTimerInUlt(self, 7, self.PlayUltMovie)
  LuaSkillCtrl:CallRoleAction(self.caster, 1005, 1)
end

function bs_103903:OnSkipUltView()
  base.OnSkipUltView(self)
end

function bs_103903:OnMovieFadeOut()
  self:RemoveSkillTrigger(eSkillTriggerType.OnSelfUltMovieFadeOut)
  LuaSkillCtrl:CallBackViewTimeLine(self.caster, true)
  base.OnMovieFadeOut(self)
end

function bs_103903:OnBreakSkill(role)
  if role == self.caster then
    self:CancleCasterWait()
  end
  base.OnBreakSkill(self, role)
end

function bs_103903:OnCasterDie()
  base.OnCasterDie(self)
  if self.effectStart ~= nil then
    self.effectStart:Die()
    self.effectStart = nil
  end
end

function bs_103903:LuaDispose()
  base.LuaDispose(self)
  if self.effectStart ~= nil then
    self.effectStart:Die()
    self.effectStart = nil
  end
end

return bs_103903
