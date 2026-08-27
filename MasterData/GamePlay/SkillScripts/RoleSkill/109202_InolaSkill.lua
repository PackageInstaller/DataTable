local bs_109202 = class("bs_109202", LuaSkillBase)
local base = LuaSkillBase
bs_109202.config = {
  selectId_skill = 10001,
  buffid_huyou = 109201,
  actionId = 1002,
  skill_time = 25,
  start_time = 10,
  skill_speed = 1,
  effectId_cast = 109205,
  effectId_hit = 109206,
  HurtConfigID = 17
}

function bs_109202:ctor()
end

function bs_109202:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_109202:PlaySkill(data)
  local targetList = LuaSkillCtrl:CallTargetSelect(self, self.config.selectId_skill, 10)
  if targetList.Count <= 0 then
    return
  end
  local attackTrigger = BindCallback(self, self.OnAttackTrigger)
  self:CallCasterWait(self.config.skill_time)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.actionId, self.config.action_speed, self.config.start_time, attackTrigger)
  LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_cast, self)
end

function bs_109202:OnAttackTrigger(target, data)
  local last_target = self.caster.recordTable.lastAttackRole
  local target
  if last_target ~= nil and last_target.hp > 0 and last_target.belongNum ~= eBattleRoleBelong.neutral and LuaSkillCtrl:IsAbleAttackTarget(self.caster, last_target, 10) then
    target = last_target
  else
    local tempTarget = self:GetMoveSelectTarget()
    if tempTarget == nil then
      return
    end
    target = tempTarget.targetRole
  end
  self.caster:LookAtTarget(target)
  LuaSkillCtrl:CallEffect(target, self.config.effectId_hit, self)
  local target_grid = LuaSkillCtrl:GetTargetWithGrid(target.x, target.y)
  local targetList = LuaSkillCtrl:FindAllRolesWithinRange(target_grid, 2, true)
  if 0 < targetList.Count then
    for i = 0, targetList.Count - 1 do
      local role = targetList[i]
      if role ~= nil and role.hp > 0 and role.belongNum ~= self.caster.belongNum then
        local self_pow = self.caster.skill_intensity
        local tar_pow = role.skill_intensity
        local value = (self_pow / tar_pow - 1) * 1000
        if value > self.arglist[2] * 1000 then
          value = self.arglist[2] * 1000
        elseif value < 0 then
          value = 0
        end
        local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, role)
        LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.HurtConfigID, {
          self.arglist[1] + self.arglist[1] * value // 1000
        })
        skillResult:EndResult()
        LuaSkillCtrl:CallBuff(self, role, self.config.buffid_huyou, self.arglist[3])
      end
    end
  end
end

function bs_109202:LuaDispose()
  base.LuaDispose(self)
end

function bs_109202:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_109202
