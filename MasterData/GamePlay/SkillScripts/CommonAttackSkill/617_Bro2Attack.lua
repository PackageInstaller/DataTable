local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_617 = class("bs_617", bs_1)
local base = bs_1
bs_617.config = {
  effectId_skill = 61702,
  effectId_w = 60402,
  action1 = 1001,
  action2 = 1001,
  Hurt_config = {
    hit_formula = 0,
    basehurt_formula = 502,
    crit_formula = 0,
    returndamage_formula = 0
  },
  buffIdBro = 60401,
  Time = 15,
  radius = 10,
  spd = 2
}
bs_617.config = setmetatable(bs_617.config, {
  __index = base.config
})

function bs_617:ctor()
end

function bs_617:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_617:RealPlaySkill(target, data)
  LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_w, self)
  LuaSkillCtrl:CallBuff(self, self.caster, 170, 1, self.config.Time)
  LuaSkillCtrl:StartTimer(nil, self.config.Time, function()
    base.RealPlaySkill(self, target, data)
  end)
end

function bs_617:OnAttackTrigger(target, data, atkSpeedRatio, atkActionId)
  self.caster:LookAtTarget(target)
  self:CallBack(target)
end

function bs_617:CallBack(targetRole)
  local cusEffect = LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_skill, self)
  local collisionTrigger = BindCallback(self, self.OnCollision)
  local collisionArrive = BindCallback(self, self.OnArrive, cusEffect)
  LuaSkillCtrl:CallCircledEmissionStraightly(self, self.caster, targetRole, self.config.radius, self.config.spd, eColliderInfluenceType.Enemy, collisionTrigger, nil, nil, cusEffect, true, true, collisionArrive)
end

function bs_617:OnCollision(collider, index, entity)
  if entity.intensity == 0 and entity.career == 1 then
    return
  end
  local hurt = self.caster.recordTable.hurt
  hurt = self.caster.pow * hurt // 1000
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, entity)
  LuaSkillCtrl:HurtResult(self, skillResult, self.config.Hurt_config, {hurt})
  skillResult:EndResult()
end

function bs_617:OnArrive(cueEffect)
  if cueEffect ~= nil then
    cueEffect:Die()
    cueEffect = nil
  end
end

function bs_617:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_617
