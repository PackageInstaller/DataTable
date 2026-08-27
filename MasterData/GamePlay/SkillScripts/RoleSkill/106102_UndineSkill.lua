local bs_106102 = class("bs_106102", LuaSkillBase)
local base = LuaSkillBase
bs_106102.config = {
  heal_config = {baseheal_formula = 3022},
  skilltime = 24,
  actionId = 1020,
  action_speed = 1.2,
  actionId_start_time = 19,
  effect_cast = 106116,
  effect_trail01 = 106119,
  effect_trail02 = 106118,
  effect_hit = 106117,
  configId = 17,
  weaponLv = 0,
  buffId_1 = 106105
}

function bs_106102:ctor()
end

function bs_106102:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_106102:PlaySkill(data)
  self.caster.recordTable.NeedRestart = true
  LuaSkillCtrl:CallEffect(self.caster, self.config.effect_cast, self, nil)
  local targetList = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
  local num = 0
  if 0 < targetList.Count then
    for i = 0, targetList.Count - 1 do
      if targetList[i] ~= self.caster then
        LuaSkillCtrl:CallEffect(self.caster, self.config.effect_trail01, self, nil, targetList[i])
        num = num + 1
      end
    end
  end
  if 10 < num then
    num = 10
  end
  local attackTrigger = BindCallback(self, self.OnAttackTrigger, num)
  local time = self.config.skilltime * 10 // 12
  self:CallCasterWait(time)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.actionId, self.config.action_speed, self.config.actionId_start_time * 10 // 12, attackTrigger)
end

function bs_106102:OnAttackTrigger(num)
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
  LuaSkillCtrl:CallEffectWithArgOverride(target, self.config.effect_trail02, self, self.caster, nil, nil, self.SkillEventFunc, num)
end

function bs_106102:SkillEventFunc(num, effect, eventId, target)
  if effect.dataId == self.config.effect_trail02 and eventId == eBattleEffectEvent.Trigger then
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
    local damageNum = self.arglist[1] + num * self.arglist[2]
    if 2 <= self.config.weaponLv then
      local buffNum = self.caster:GetBuffTier(self.config.buffId_1)
      damageNum = damageNum * (1000 + buffNum * self.arglist[3]) // 1000
    end
    LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.configId, {damageNum}, nil, nil)
    skillResult:EndResult()
    LuaSkillCtrl:CallEffect(target, self.config.effect_hit, self, nil)
    self:OnSkillDamageEnd()
  end
end

function bs_106102:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_106102
