local bs_310703 = class("bs_310703", LuaSkillBase)
local base = LuaSkillBase
bs_310703.config = {
  buffId_debuff1 = 110052,
  buffId_debuff2 = 110051,
  buffId_debuff3 = 110053,
  buffId_stunEnemy = 110055,
  effectId_debuff1 = 10480902,
  effectId_debuff2 = 10481002,
  effectId_debuff3 = 10481102,
  effectId_stunStart = 10482002,
  buffId_170 = 170,
  buffId_stun = 66,
  selectId = 104801,
  selectrange = 10,
  start_time = 18,
  actionId = 1022,
  action_speed = 1,
  audioId_start = 104810,
  audioId_stop = 104814,
  effectId_Trail = 10480802,
  effectId_skillStart = 10480702,
  HurtConfig = {
    hit_formula = 0,
    basehurt_formula = 3000,
    crit_formula = 0,
    hurt_type = -1
  }
}

function bs_310703:ctor()
end

function bs_310703:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.caster.recordTable.EnemyBuffTime = self.arglist[2]
  self.caster.recordTable.BaseMissChance = self.arglist[3] // 10
  self.NoEnemy = false
end

function bs_310703:PlaySkill(data)
  LuaSkillCtrl:CallBreakAllSkill(self.caster)
  self.ShotTimes = 0
  self.MissChance = 0
  self:CallCasterWait(999)
  local attackTrigger = BindCallback(self, self.OnAttackTrigger)
  LuaSkillCtrl:PlayAuSource(self.caster, self.config.audioId_start)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.actionId, self.config.action_speed, self.config.start_time, attackTrigger)
  self.skillLoop = LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_skillStart, self, nil, nil, nil, true)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_170, 1, nil, true)
end

function bs_310703:OnAttackTrigger()
  LuaSkillCtrl:StartTimer(self, 5, function()
    local targetList = LuaSkillCtrl:CallTargetSelect(self, self.config.selectId, self.config.selectrange)
    for i = targetList.Count - 1, 0, -1 do
      local role = targetList[i].targetRole
      if LuaSkillCtrl:IsObstacle(role) then
        targetList:RemoveAt(i)
      end
    end
    local targetListCount = targetList.Count
    if targetListCount == 0 then
      LuaSkillCtrl:CallBreakAllSkill(self.caster)
      LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_stunStart, self)
      LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_stun, 1, self.arglist[4])
      LuaSkillCtrl:DispelBuffByMaker(self.caster, self.caster, self.config.buffId_170, 1, true)
      return
    end
    local index = LuaSkillCtrl:CallRange(0, targetListCount - 1)
    self:AttackEnemy(targetList[index].targetRole)
  end, self, -1, 5)
end

function bs_310703:AttackEnemy(target)
  self:CheckMiss(target)
  local IfStun = LuaSkillCtrl:GetRoleAllBuffsByFeature(self.caster, 7)
  if IfStun ~= nil then
    return
  end
  if target.hp <= 0 or target == nil or target:IsUnSelect(self.caster) then
    return
  end
  LuaSkillCtrl:CallEffect(target, self.config.effectId_Trail, self, self.SkillEventFunc)
end

function bs_310703:SkillEventFunc(effect, eventId, target)
  local buffTarget = target.targetRole
  if effect.dataId == self.config.effectId_Trail and eventId == eBattleEffectEvent.Trigger then
    self:AddBuffAndHurt(buffTarget)
  end
end

function bs_310703:AddBuffAndHurt(buffTarget)
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
    LuaSkillCtrl:CallBuff(self, buffTarget, self.config.buffId_debuff1, 1, self.caster.recordTable.EnemyBuffTime, true)
    LuaSkillCtrl:CallBuff(self, buffTarget, self.config.buffId_debuff2, 1, self.caster.recordTable.EnemyBuffTime, true)
    LuaSkillCtrl:CallBuff(self, buffTarget, self.config.buffId_stunEnemy, 1, self.caster.recordTable.EnemyBuffTime, true)
    LuaSkillCtrl:CallBuff(self, buffTarget, self.config.buffId_debuff3, 1, self.caster.recordTable.EnemyBuffTime)
    LuaSkillCtrl:CallEffect(buffTarget, self.config.effectId_debuff3, self)
  end
  if buff1 ~= nil and buff2 == nil and buff3 == nil then
    LuaSkillCtrl:CallBuff(self, buffTarget, self.config.buffId_debuff1, 1, self.caster.recordTable.EnemyBuffTime, true)
    LuaSkillCtrl:CallBuff(self, buffTarget, self.config.buffId_debuff2, 1, self.caster.recordTable.EnemyBuffTime, true)
    LuaSkillCtrl:CallBuff(self, buffTarget, self.config.buffId_stunEnemy, 1, self.caster.recordTable.EnemyBuffTime)
    LuaSkillCtrl:CallEffect(buffTarget, self.config.effectId_debuff2, self)
  end
  if buff1 == nil and buff2 == nil and buff3 == nil then
    LuaSkillCtrl:CallEffect(buffTarget, self.config.effectId_debuff1, self)
    LuaSkillCtrl:CallBuff(self, buffTarget, self.config.buffId_debuff1, 1, self.caster.recordTable.EnemyBuffTime)
  end
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, buffTarget)
  LuaSkillCtrl:HurtResult(self, skillResult, self.config.HurtConfig, {
    self.arglist[1]
  })
  skillResult:EndResult()
end

function bs_310703:CheckMiss(target)
  self.ShotTimes = self.ShotTimes + 1
  if self.ShotTimes > 8 then
    self.MissChance = self.MissChance + self.caster.recordTable.BaseMissChance
    local MissChance = LuaSkillCtrl:CallRange(1, 100)
    if MissChance < self.MissChance then
      LuaSkillCtrl:PlayAuSource(self.caster, self.config.audioId_stop)
      LuaSkillCtrl:CallBreakAllSkill(self.caster)
      LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_stunStart, self)
      LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_stun, 1, self.arglist[4])
      LuaSkillCtrl:DispelBuffByMaker(self.caster, self.caster, self.config.buffId_170, 1, true)
    end
  end
end

function bs_310703:OnBreakSkill(role)
  base.OnBreakSkill(self, role)
  if role == self.caster then
    self:CancleCasterWait()
    LuaSkillCtrl:DispelBuffByMaker(self.caster, self.caster, self.config.buffId_170, 1, true)
    if self.skillLoop ~= nil then
      self.skillLoop:Die()
      self.skillLoop = nil
    end
  end
end

function bs_310703:OnCasterDie()
  if self.skillLoop ~= nil then
    self.skillLoop:Die()
    self.skillLoop = nil
  end
  base.OnCasterDie(self)
end

function bs_310703:OnDispose()
  base.OnDispose(self)
  if self.skillLoop ~= nil then
    self.skillLoop:Die()
    self.skillLoop = nil
  end
end

return bs_310703
