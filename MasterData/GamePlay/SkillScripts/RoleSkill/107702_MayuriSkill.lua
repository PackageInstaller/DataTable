local bs_107702 = class("bs_107702", LuaSkillBase)
local base = LuaSkillBase
bs_107702.config = {
  selectId_skill = 45,
  buffid_fade = 107701,
  actionId = 1002,
  skill_time = 25,
  start_time = 10,
  skill_speed = 1,
  buffid_wupa = 107702,
  hurt_config = {lifesteal_formula = 1113, spell_lifesteal_formula = 1114},
  effectId_cast = 107705,
  effectId_skill = 107711,
  HurtConfigID = 2
}

function bs_107702:ctor()
end

function bs_107702:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddHurtResultStartTriggerForTable("bs_107702", 40, self.OnHurtResultStart, {
    senderBelongNum = eBattleRoleBelong.player,
    extraArg2 = false
  })
end

function bs_107702:PlaySkill(data)
  local targetList = LuaSkillCtrl:CallTargetSelect(self, self.config.selectId_skill, 10)
  if targetList.Count <= 0 then
    return
  end
  local attackTrigger = BindCallback(self, self.OnAttackTrigger)
  self:CallCasterWait(self.config.skill_time)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.actionId, self.config.action_speed, self.config.start_time, attackTrigger)
end

function bs_107702:OnAttackTrigger()
  LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_cast, self)
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
  self.caster:LookAtTarget(target)
  local target_grid = LuaSkillCtrl:GetTargetWithGrid(target.x, target.y)
  LuaSkillCtrl:CallEffectWithArg(target, self.config.effectId_skill, self, false, false, self.OnEffectTrigger, target_grid)
end

function bs_107702:OnEffectTrigger(realgrid, effect, eventId, target)
  if effect.dataId == self.config.effectId_skill and eventId == eBattleEffectEvent.Trigger then
    local num = self.caster:GetBuffTier(self.config.buffid_fade)
    local targetList = LuaSkillCtrl:FindAllRolesWithinRange(realgrid, 2, true)
    if targetList.Count > 0 then
      for i = 0, targetList.Count - 1 do
        local role = targetList[i]
        if role ~= nil and 0 < role.hp and role.belongNum ~= self.caster.belongNum then
          local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, role)
          LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.HurtConfigID, {
            self.arglist[1] - num * self.arglist[2]
          })
          skillResult:EndResult()
          LuaSkillCtrl:CallBuff(self, role, self.config.buffid_wupa, 1, self.arglist[5])
        end
      end
    end
  end
end

function bs_107702:OnHurtResultStart(skill, context)
  if skill.skillType == eBattleSkillLogicType.Original and context.target:GetBuffTier(self.config.buffid_wupa) > 0 and context.sender.belongNum == self.caster.belongNum and LuaSkillCtrl:CallRange(1, 1000) <= self.arglist[4] and not context.isTriggerSet and context.extraArg ~= ConfigData.buildinConfig.HurtIgnoreKey and context.hurt_type ~= 2 then
    LuaSkillCtrl:CallRecoverHeal(context.sender, self, 0, 0, 0)
  end
end

function bs_107702:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_107702
