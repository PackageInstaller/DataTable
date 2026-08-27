local bs_104803 = class("bs_104803", LuaSkillBase)
local base = LuaSkillBase
bs_104803.config = {
  buffId_down = 104801,
  buffId_Luk = 104808,
  buffId_debuff1 = 104806,
  buffId_debuff2 = 104805,
  buffId_debuff3 = 104807,
  effectId_stunStart = 104820,
  effectId_debuff1 = 104809,
  effectId_debuff2 = 104810,
  effectId_debuff3 = 104811,
  buffId_stun = 66,
  buffId_stunEnemy = 104809,
  selectId = 104801,
  selectrange = 10,
  start_time = 12,
  actionId = 1008,
  action_speed = 1,
  effectId_Trail = 104808,
  effectId_skillStart = 104814,
  effectId_skillStart02 = 104813,
  HurtConfig = {
    hit_formula = 0,
    basehurt_formula = 3000,
    crit_formula = 0,
    hurt_type = -1
  },
  audioIdStart = 104815,
  audioIdMovie = 104816,
  audioId_skillStart = 104817
}

function bs_104803:ctor()
end

function bs_104803:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.targetStartTimer = {}
  self.UltShotTimes = {}
  self.UltMissChance = {}
  self.TargetCount = nil
end

function bs_104803:PlaySkill(data, selectTargetCoord, selectRoles)
  local buffDown = LuaSkillCtrl:GetRoleBuffById(self.caster, self.config.buffId_down)
  if buffDown ~= nil then
    self:Activation()
  else
    self:Attack()
  end
end

function bs_104803:Activation()
  LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_skillStart02, self)
  LuaSkillCtrl:DispelBuffByMaker(self.caster, self.caster, self.config.buffId_down, 1, true)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_Luk, 1, self.arglist[2], true)
end

function bs_104803:Attack()
  LuaSkillCtrl:CallBreakAllSkill(self.caster)
  self:CallCasterWait(999)
  local attackTrigger = BindCallback(self, self.OnAttackTrigger)
  LuaSkillCtrl:PlayAuSource(self.caster, self.config.audioId_skillStart)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.actionId, self.config.action_speed, self.config.start_time, attackTrigger)
  self.skillLoop = LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_skillStart, self, nil, nil, nil, true)
end

function bs_104803:OnAttackTrigger()
  local targetList = LuaSkillCtrl:CallTargetSelect(self, self.config.selectId, self.config.selectrange)
  if targetList.Count == 0 then
    LuaSkillCtrl:CallBreakAllSkill(self.caster)
    LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_stunStart, self)
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_stun, 1, self.arglist[7], true)
    return
  end
  self.TargetCount = targetList.Count - 1
  for i = 0, targetList.Count - 1 do
    if LuaSkillCtrl:IsObstacle(targetList[i].targetRole) then
      self.TargetCount = self.TargetCount - 1
    else
      self.UltShotTimes[i] = 0
      self.UltMissChance[i] = 0
      self.targetStartTimer[i] = LuaSkillCtrl:StartTimer(self, 5, function()
        local target = targetList[i].targetRole
        self:AttackEnemy(target, i)
      end, self, -1, 5)
    end
  end
end

function bs_104803:AttackEnemy(target, i)
  self:CheckMiss(i)
  local IfStun = LuaSkillCtrl:GetRoleAllBuffsByFeature(self.caster, 7)
  if IfStun ~= nil then
    return
  end
  if target.hp > 0 then
    LuaSkillCtrl:CallEffect(target, self.config.effectId_Trail, self, self.SkillEventFunc)
  end
end

function bs_104803:SkillEventFunc(effect, eventId, target)
  local buffTarget = target.targetRole
  if effect.dataId == self.config.effectId_Trail and eventId == eBattleEffectEvent.Trigger then
    self:AddBuffAndHurt(buffTarget)
  end
end

function bs_104803:AddBuffAndHurt(buffTarget)
  local buff1 = LuaSkillCtrl:GetRoleBuffById(buffTarget, self.config.buffId_debuff1)
  local buff2 = LuaSkillCtrl:GetRoleBuffById(buffTarget, self.config.buffId_debuff2)
  local buff3 = LuaSkillCtrl:GetRoleBuffById(buffTarget, self.config.buffId_debuff3)
  if buff1 ~= nil and buff2 ~= nil and buff3 ~= nil then
    LuaSkillCtrl:CallBuff(self, buffTarget, self.config.buffId_debuff1, 1, self.caster.recordTable.EnemyBuffTime, true)
    LuaSkillCtrl:CallBuff(self, buffTarget, self.config.buffId_debuff2, 1, self.caster.recordTable.EnemyBuffTime, true)
    LuaSkillCtrl:CallBuff(self, buffTarget, self.config.buffId_stunEnemy, 1, self.caster.recordTable.EnemyBuffTime, true)
    LuaSkillCtrl:CallBuff(self, buffTarget, self.config.buffId_debuff3, 1, self.caster.recordTable.EnemyBuffTime)
  end
  if buff1 ~= nil and buff2 ~= nil and buff3 == nil then
    LuaSkillCtrl:CallEffect(buffTarget, self.config.effectId_debuff3, self)
    LuaSkillCtrl:CallBuff(self, buffTarget, self.config.buffId_debuff1, 1, self.caster.recordTable.EnemyBuffTime, true)
    LuaSkillCtrl:CallBuff(self, buffTarget, self.config.buffId_debuff2, 1, self.caster.recordTable.EnemyBuffTime, true)
    LuaSkillCtrl:CallBuff(self, buffTarget, self.config.buffId_stunEnemy, 1, self.caster.recordTable.EnemyBuffTime, true)
    LuaSkillCtrl:CallBuff(self, buffTarget, self.config.buffId_debuff3, 1, self.caster.recordTable.EnemyBuffTime)
  end
  if buff1 ~= nil and buff2 == nil and buff3 == nil then
    LuaSkillCtrl:CallEffect(buffTarget, self.config.effectId_debuff2, self)
    LuaSkillCtrl:CallBuff(self, buffTarget, self.config.buffId_debuff1, 1, self.caster.recordTable.EnemyBuffTime, true)
    LuaSkillCtrl:CallBuff(self, buffTarget, self.config.buffId_stunEnemy, 1, self.caster.recordTable.EnemyBuffTime)
    LuaSkillCtrl:CallBuff(self, buffTarget, self.config.buffId_debuff2, 1, self.caster.recordTable.EnemyBuffTime, true)
  end
  if buff1 == nil and buff2 == nil and buff3 == nil then
    LuaSkillCtrl:CallEffect(buffTarget, self.config.effectId_debuff1, self)
    LuaSkillCtrl:CallBuff(self, buffTarget, self.config.buffId_debuff1, 1, self.caster.recordTable.EnemyBuffTime)
  end
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, buffTarget)
  LuaSkillCtrl:HurtResult(self, skillResult, self.config.HurtConfig, {
    self.arglist[6]
  })
  skillResult:EndResult()
end

function bs_104803:CheckMiss(i)
  self.UltShotTimes[i] = self.UltShotTimes[i] + 1
  local missChanceArg = self.caster.recordTable.BaseMissChance or 15
  if self.UltShotTimes[i] > 8 then
    self.UltMissChance[i] = self.UltMissChance[i] + missChanceArg
    local MissChance = LuaSkillCtrl:CallRange(1, 100)
    if MissChance < self.UltMissChance[i] and self.targetStartTimer[i] ~= nil then
      self.targetStartTimer[i]:Stop()
      self.targetStartTimer[i] = nil
      self.UltShotTimes[i] = 0
      self.UltMissChance[i] = 0
      if i == self.TargetCount then
        LuaSkillCtrl:CallBreakAllSkill(self.caster, true)
        LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_stunStart, self)
        LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_stun, 1, self.arglist[7], true)
      end
    end
  end
end

function bs_104803:PlayUltEffect()
  base.PlayUltEffect(self)
  LuaSkillCtrl:CallFocusTimeLine(self.caster)
  local buffDown = LuaSkillCtrl:GetRoleBuffById(self.caster, self.config.buffId_down)
  if buffDown ~= nil then
    LuaSkillCtrl:CallRoleAction(self.caster, 1042, 1)
    LuaSkillCtrl:CallRoleAction(self.caster, 102, 1)
    LuaSkillCtrl:CallRoleAction(self.caster, 1040, 3)
  else
    LuaSkillCtrl:CallRoleAction(self.caster, 1008, 1)
  end
end

function bs_104803:OnUltRoleAction()
  base.OnUltRoleAction(self)
  local buffDown = LuaSkillCtrl:GetRoleBuffById(self.caster, self.config.buffId_down)
  if buffDown ~= nil then
    LuaSkillCtrl:StartTimerInUlt(self, 20, self.PlayUltMovie)
  else
    LuaSkillCtrl:StartTimerInUlt(self, 7, self.PlayUltMovie)
  end
end

function bs_104803:OnBreakSkill(role)
  base.OnBreakSkill(self, role)
  if role == self.caster then
    self:CancleCasterWait()
    if self.skillLoop ~= nil then
      self.skillLoop:Die()
      self.skillLoop = nil
    end
  end
end

function bs_104803:OnCasterDie()
  base.OnCasterDie(self)
end

function bs_104803:LuaDispose()
  self.skillLoop = nil
  base.LuaDispose(self)
end

return bs_104803
