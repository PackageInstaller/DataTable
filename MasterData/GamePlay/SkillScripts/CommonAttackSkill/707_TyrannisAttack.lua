local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_707 = class("bs_707", bs_1)
local base = bs_1
bs_707.config = {
  effectId_end = 208601,
  effectId_hit = 208602,
  effectId_sign = 210201,
  radius = 20,
  spd = 15,
  Hurt_config = {
    hit_formula = 0,
    basehurt_formula = 3000,
    crit_formula = 0,
    returndamage_formula = 0
  },
  effectId_start1 = 208607,
  effectId_start2 = 208608,
  effectId_sj = 208602
}
bs_707.config = setmetatable(bs_707.config, {
  __index = base.config
})

function bs_707:ctor()
end

function bs_707:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_707", 1, self.OnAfterBattleStart)
end

function bs_707:OnAfterBattleStart()
  LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_sign, self)
end

function bs_707:OnAttackTrigger(target, data, atkSpeedRatio, atkActionId)
  if LuaSkillCtrl:IsAbleAttackTarget(self.caster, target, self.caster.attackRange) then
    self.caster:LookAtTarget(target)
    self:CallBack(target)
  end
end

function bs_707:CallBack(targetRole)
  local collisionTrigger = BindCallback(self, self.OnCollision)
  local skillEmission = LuaSkillCtrl:CallCircledEmissionStraightly(self, self.caster, targetRole, self.config.radius, self.config.spd, eColliderInfluenceType.Enemy, collisionTrigger, nil, nil, nil, true, true, nil)
end

function bs_707:OnCollision(collider, index, entity)
  if entity.intensity == 0 and entity.career == 1 then
    return
  end
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, entity)
  LuaSkillCtrl:CallEffect(entity, self.config.effectId_sj, self)
  local num = self.caster.recordTable["208601_hurt"]
  LuaSkillCtrl:HurtResult(self, skillResult, self.config.Hurt_config, {num})
  skillResult:EndResult()
end

function bs_707:CallSelectExecute(targetRole)
  if targetRole == nil or targetRole.hp <= 0 then
    return
  end
  if targetRole.belongNum ~= self.caster.belongNum then
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, targetRole)
    LuaSkillCtrl:HurtResult(self, skillResult, self.config.Hurt_config, {
      self.arglist[1]
    })
    skillResult:EndResult()
    LuaSkillCtrl:CallEffect(targetRole, self.config.effectId_hit, self)
  end
end

function bs_707:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_707
