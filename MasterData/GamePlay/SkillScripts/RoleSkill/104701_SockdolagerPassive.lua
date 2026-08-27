local bs_104701 = class("bs_104701", LuaSkillBase)
local base = LuaSkillBase
bs_104701.config = {
  HurtConfig = {
    hit_formula = 0,
    basehurt_formula = 3000,
    crit_formula = 0
  },
  actionId = 1002,
  action_speed = 1,
  aoe_config = {
    effect_shape = eSkillResultShapeType.Target,
    aoe_select_code = 4,
    aoe_range = 1
  }
}

function bs_104701:ctor()
end

function bs_104701:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.AttackCount = 0
  self:AddSetHurtTrigger("bs_104701_1", 1, self.OnSetHurt, self.caster, nil, nil, nil, nil, nil, eSkillTag.commonAttack)
  self.caster.recordTable.arglist1 = self.arglist[1]
end

function bs_104701:OnSetHurt(context)
  if not context.skill.isCommonAttack then
    return
  end
  if context.sender == self.caster and context.skill.isCommonAttack then
    self.AttackCount = self.AttackCount + 1
  end
  if self.AttackCount > self.arglist[1] - 1 and self.AttackCount <= self.arglist[1] then
    self.caster.recordTable.passiveisok = 1
  end
  if self.AttackCount > self.arglist[1] then
    self:AimAttack()
  end
end

function bs_104701:AimAttack()
  local last_target = self.caster.recordTable.lastAttackRole
  local targetRole
  if last_target ~= nil and last_target.hp > 0 and last_target.belongNum ~= eBattleRoleBelong.neutral and LuaSkillCtrl:IsAbleAttackTarget(self.caster, last_target, 10) then
    targetRole = last_target
  else
    local tempTarget = self:GetMoveSelectTarget()
    if tempTarget == nil then
      return
    end
    targetRole = tempTarget.targetRole
  end
  if targetRole ~= nil then
    self:OnAttackTrigger(targetRole)
  end
end

function bs_104701:OnAttackTrigger(targetRole)
  local distance = LuaSkillCtrl:GetRoleGridsDistance(self.caster, targetRole)
  local hurtNum = distance * self.arglist[2]
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, targetRole, self.config.aoe_config)
  LuaSkillCtrl:HurtResult(self, skillResult, self.config.HurtConfig, {hurtNum})
  skillResult:EndResult()
  self.AttackCount = 0
end

function bs_104701:OnCasterDie()
  base.OnCasterDie(self)
end

function bs_104701:LuaDispose()
  base.LuaDispose(self)
end

return bs_104701
