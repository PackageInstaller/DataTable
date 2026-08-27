local bs_108102 = class("bs_108102", LuaSkillBase)
local base = LuaSkillBase
bs_108102.config = {
  actionId = 1008,
  start_time = 8,
  end_time = 5,
  actionId_end = 1009,
  effect_atk1 = 108106,
  effectId_hit = 108107,
  effect_blink = 108110,
  effectId_show = 108111,
  HurtConfigID = 2
}

function bs_108102:ctor()
end

function bs_108102:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.hurtArgs = {}
end

function bs_108102:PlaySkill(data)
  local last_target = self.caster.recordTable.lastAttackRole
  local target
  if last_target ~= nil and last_target.hp > 0 and last_target.belongNum ~= eBattleRoleBelong.neutral and LuaSkillCtrl:IsAbleAttackTarget(self.caster, last_target, 1) then
    target = last_target
  else
    local tempTarget = self:GetMoveSelectTarget()
    if tempTarget == nil then
      return
    end
    target = tempTarget.targetRole
  end
  if target == nil then
    LuaSkillCtrl:SetResetCdByReturnConfigOnce(self)
    return
  end
  local Grid = LuaSkillCtrl:GetRoleBehindGrid(target)
  if Grid == nil then
    Grid = LuaSkillCtrl:FindEmptyGridAroundRole(target)
    if Grid == nil then
      Grid = LuaSkillCtrl:GetGridWithRole(self.caster)
    end
  end
  LuaSkillCtrl:CallEffect(self.caster, self.config.effect_blink, self)
  LuaSkillCtrl:SetRolePos(Grid, self.caster)
  LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_show, self)
  local random = LuaSkillCtrl:CallRange(1, 1000)
  local num = 1
  if random <= 125 then
    num = 4
  elseif random <= 250 then
    num = 3
  elseif random <= 500 then
    num = 2
  end
  local attackTrigger = BindCallback(self, self.OnAttackTrigger, target, num)
  self.caster:LookAtTarget(target)
  local atktime = 0
  if num == 1 then
    atktime = 9
  elseif num == 2 then
    atktime = 11
  elseif num == 3 then
    atktime = 15
  elseif num == 4 then
    atktime = 23
  end
  local skilltime = atktime + self.config.end_time
  self:CallCasterWait(skilltime)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.actionId, self.config.action_speed, self.config.start_time, attackTrigger)
  self.ender = LuaSkillCtrl:StartTimer(self, atktime, BindCallback(self, self.OnEndAction), nil, 0, 0)
  if self.loopEffect ~= nil then
    self.loopEffect:Die()
    self.loopEffect = nil
  end
  self.loopEffect = LuaSkillCtrl:CallEffect(self.caster, self.config.effect_atk1, self)
end

function bs_108102:OnAttackTrigger(target, num)
  if target ~= nil then
    self:DoDamage(target)
    if 1 < num then
      LuaSkillCtrl:StartTimer(self, 2, function()
        self:DoDamage(target)
      end, nil, 0, 0)
    end
    if 2 < num then
      LuaSkillCtrl:StartTimer(self, 6, function()
        self:DoDamage(target)
      end, nil, 0, 0)
    end
    if 3 < num then
      LuaSkillCtrl:StartTimer(self, 14, function()
        self:DoDamage(target)
      end, nil, 0, 0)
    end
  end
end

function bs_108102:DoDamage(target)
  if target.isDead then
    self.ender.left = 0
    return
  end
  LuaSkillCtrl:CallEffect(target, self.config.effectId_hit, self)
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
  local args = LuaSkillCtrl:CreatCacheTable(self.arglist[1], self.hurtArgs)
  LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.HurtConfigID, args)
  skillResult:EndResult()
end

function bs_108102:OnEndAction()
  if self.loopEffect ~= nil then
    self.loopEffect:Die()
    self.loopEffect = nil
  end
  LuaSkillCtrl:CallRoleAction(self.caster, self.config.actionId_end, 1)
  self:OnSkillDamageEnd()
end

function bs_108102:OnBreakSkill(role)
  base.OnBreakSkill(self, role)
  self:CancleCasterWait()
end

function bs_108102:OnCasterDie()
  base.OnCasterDie(self)
end

function bs_108102:LuaDispose()
  base.LuaDispose(self)
  self.loopEffect = nil
  self.hurtArgs = nil
end

return bs_108102
