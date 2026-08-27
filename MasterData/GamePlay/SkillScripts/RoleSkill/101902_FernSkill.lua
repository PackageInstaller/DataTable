local bs_101902 = class("bs_101902", LuaSkillBase)
local base = LuaSkillBase
bs_101902.config = {
  effectId_skill = 10688,
  buffId_fly = 223,
  buffId_stun = 66,
  effectId_fly = 10690,
  HurtConfig = {
    hit_formula = 0,
    basehurt_formula = 3010,
    crit_formula = 0,
    crithur_ratio = 0
  },
  Aoe = {
    effect_shape = 3,
    aoe_select_code = 5,
    aoe_range = 1
  },
  skill_time = 30,
  start_time = 13,
  actionId = 1020,
  action_speed = 1,
  audioId1 = 221,
  audioId2 = 222
}

function bs_101902:ctor()
end

function bs_101902:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_101902:PlaySkill(data)
  local target = self.caster.recordTable.lastAttackRole
  if target == nil or target.hp <= 0 or target.belongNum == eBattleRoleBelong.neutral then
    local tempTarget = self:GetMoveSelectTarget()
    if tempTarget == nil then
      return
    end
    target = tempTarget.targetRole
  end
  if target ~= nil and target.hp > 0 then
    local attackTrigger = BindCallback(self, self.OnAttackTrigger, target)
    self.caster:LookAtTarget(target)
    self:CallCasterWait(self.config.skill_time)
    LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.actionId, self.config.action_speed, self.config.start_time, attackTrigger)
    LuaSkillCtrl:PlayAuSource(self.caster, self.config.audioId1)
  end
end

function bs_101902:OnAttackTrigger(target)
  LuaSkillCtrl:BroadcastLuaTrigger(eSkillLuaTrigger.FernSkill)
  LuaSkillCtrl:CallEffect(target, self.config.effectId_fly, self)
  LuaSkillCtrl:StartTimer(nil, 16, function()
    LuaSkillCtrl:CallBuff(self, target, self.config.buffId_fly, 1, 20, true)
    local target2 = LuaSkillCtrl:CallTargetSelect(self, 21, 10)
    LuaSkillCtrl:StartTimer(nil, 20, function()
      LuaSkillCtrl:CallEffect(target, self.config.effectId_skill, self, self.SkillEventFunc)
    end)
    if target2.Count <= 0 or target2[0].targetRole == target then
      return
    end
    local grid = LuaSkillCtrl:FindEmptyGridWithoutEfcGridOfTypeAroundRole(target2[0].targetRole, eEffectGridType.positive)
    if grid ~= nil and 0 < target.hp and 0 < target:GetBuffTier(self.config.buffId_fly) then
      LuaSkillCtrl:CallPhaseMove(self, target, grid.x, grid.y, 20, 63)
    end
  end)
end

function bs_101902:SkillEventFunc(effect, eventId, target)
  if eventId == eBattleEffectEvent.Create then
    LuaSkillCtrl:PlayAuSource(target, self.config.audioId2)
    LuaSkillCtrl:StartTimer(nil, 3, function()
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target, self.config.Aoe)
      for i = 0, skillResult.roleList.Count - 1 do
        if skillResult.roleList[i].belongNum ~= self.caster.belongNum then
          LuaSkillCtrl:CallBuff(self, skillResult.roleList[i], self.config.buffId_stun, 1, self.arglist[2])
        end
      end
      LuaSkillCtrl:HurtResult(self, skillResult, self.config.HurtConfig, {
        self.arglist[1]
      })
      skillResult:EndResult()
      self:OnSkillDamageEnd()
    end)
  end
end

function bs_101902:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_101902
