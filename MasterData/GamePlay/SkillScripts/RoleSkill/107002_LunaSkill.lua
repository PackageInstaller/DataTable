local bs_107002 = class("bs_107002", LuaSkillBase)
local base = LuaSkillBase
bs_107002.config = {
  skill_time = 25,
  start_time = 10,
  actionId = 1002,
  action_speed = 1,
  buffId_lockCd = 170,
  buff_rune_red = 107002,
  buff_rune_red_count = 107003,
  effect_light = 107007,
  effect_light_dress = 107020,
  hurt_configid = 3,
  hurt_configid_crit = 13,
  select_Id = 42,
  select_Id_Hplowest = 7,
  select_Id_Hplow = 29,
  weaponLv = 0
}

function bs_107002:ctor()
end

function bs_107002:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.hurteffect = nil
  self.caster.recordTable.maxnum_rune_red = self.arglist[5]
  self.caster.recordTable.time_rune_red = self.arglist[4]
  self.caster.recordTable.curtime_max_rune_red = self.arglist[6]
  self.times_shot = 0
end

function bs_107002:PlaySkill(data)
  local target
  if self.config.weaponLv >= 2 then
    local targetlist_enemy = LuaSkillCtrl:CallTargetSelect(self, self.config.select_Id_Hplowest, 10)
    local target_weaponLv = targetlist_enemy[0].targetRole
    if target_weaponLv ~= nil and 0 < target_weaponLv.hp then
      target = target_weaponLv
    end
  else
    local moveTarget = self:GetMoveSelectTarget()
    if moveTarget == nil then
      return
    end
    target = moveTarget.targetRole
  end
  local sender = self.caster
  local times = 0
  local attackTrigger = BindCallback(self, self.OnAttackTrigger, target, sender, times)
  self.caster:LookAtTarget(target)
  self:CallCasterWait(self.config.start_time)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.actionId, self.config.action_speed, self.config.start_time, attackTrigger)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_lockCd, 1, self.config.skill_time, true)
end

function bs_107002:OnAttackTrigger(target, sender, times)
  if self.times_shot < self.arglist[1] - 1 then
    if 0 < times then
      self.times_shot = times
    end
    if LuaSkillCtrl:GetCasterSkinId(self.caster) == 307003 then
      LuaSkillCtrl:CallEffectWithArgOverride(target, self.config.effect_light_dress, self, sender, false, false, self.SkillEventFunc, target, sender, self.times_shot)
    else
      LuaSkillCtrl:CallEffectWithArgOverride(target, self.config.effect_light, self, sender, false, false, self.SkillEventFunc, target, sender, self.times_shot)
    end
  else
    self.times_shot = 0
    self:OnSkillDamageEnd()
  end
end

function bs_107002:SkillEventFunc(target, sender, times, effect, eventId)
  if eventId == eBattleEffectEvent.Trigger then
    if target ~= self.caster and target ~= nil then
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
      local hurt_id = self.config.hurt_configid
      if self.caster.recordTable.crit_trigger and target:GetBuffTier(self.config.buff_rune_red_count) > 0 then
        hurt_id = self.config.hurt_configid_crit
      end
      LuaSkillCtrl:CallBuff(self, target, self.config.buff_rune_red_count, 1, self.caster.recordTable.time_rune_red, false)
      LuaSkillCtrl:HurtResultWithConfig(self, skillResult, hurt_id, {
        self.arglist[2]
      }, false)
      skillResult:EndResult()
    end
    local EnemyList = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.enemy)
    local target_next
    if EnemyList.Count == 1 and target ~= self.caster then
      target_next = self.caster
      if 2 <= self.config.weaponLv then
        self:OnAttackTrigger(target_next, target, times)
      else
        self:OnAttackTrigger(target_next, target, times + 1)
      end
    else
      local targetList
      if 2 <= self.config.weaponLv then
        targetList = LuaSkillCtrl:CallTargetSelect(self, self.config.select_Id_Hplow, 10)
      else
        targetList = LuaSkillCtrl:CallTargetSelect(self, self.config.select_Id, 10)
      end
      if 0 < targetList.Count then
        for i = 0, targetList.Count - 1 do
          if targetList[i].targetRole ~= nil and targetList[i].targetRole ~= target then
            target_next = targetList[i].targetRole
            self:OnAttackTrigger(target_next, target, times + 1)
            break
          end
        end
      end
    end
  end
end

function bs_107002:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_107002
