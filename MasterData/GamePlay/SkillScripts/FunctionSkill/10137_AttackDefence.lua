local bs_10137 = class("bs_10137", LuaSkillBase)
local base = LuaSkillBase
bs_10137.config = {
  effectId = 10245,
  buffBloodId = 1044,
  buffDefenceId = 1045
}

function bs_10137:ctor()
end

function bs_10137:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_10137_1", 1, self.OnAfterBattleStart)
end

function bs_10137:OnAfterBattleStart()
  local cusEffect = LuaSkillCtrl:CallEffect(self.caster, self.config.effectId, self)
  local collisionEnter = BindCallback(self, self.OnCollisionEnter)
  local collisionExit = BindCallback(self, self.OnCollisionExit)
  LuaSkillCtrl:CallCircledEmissionStraightly(self, self.caster, self.caster, 200, 0, eColliderInfluenceType.Enemy, collisionEnter, nil, collisionExit, nil, false, false, nil, self.caster)
end

function bs_10137:OnCollisionEnter(collider, index, entity)
  if entity.intensity == 0 then
    return
  end
  LuaSkillCtrl:CallBuff(self, entity, self.config.buffBloodId, 1, nil, true)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffDefenceId, 1, nil, true)
end

function bs_10137:OnCollisionExit(collider, entity)
  if entity.intensity == 0 then
    return
  end
  LuaSkillCtrl:DispelBuff(entity, self.config.buffBloodId, 1, nil, true)
  LuaSkillCtrl:DispelBuff(self.caster, self.config.buffDefenceId, 1, nil, true)
end

function bs_10137:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10137
