local bs_104802 = class("bs_104802", LuaSkillBase)
local base = LuaSkillBase
bs_104802.config = {
  buffId_debuff1 = 104806,
  buffId_debuff2 = 104805,
  buffId_debuff3 = 104807,
  buffId_stunEnemy = 104809,
  effectId_debuff1 = 104809,
  effectId_debuff2 = 104810,
  effectId_debuff3 = 104811,
  effectId_stunStart = 104820,
  buffId_170 = 170,
  buffId_stun = 66,
  selectId = 104801,
  selectrange = 10,
  start_time = 12,
  actionId = 1008,
  action_speed = 1,
  audioId_start = 104810,
  audioId_stop = 104814,
  effectId_Trail = 104808,
  effectId_skillStart = 104807,
  HurtConfig = {
    hit_formula = 0,
    basehurt_formula = 3000,
    crit_formula = 0,
    hurt_type = -1
  },
  weaponLv = 0
}

function bs_104802:ctor()
end

function bs_104802:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.caster.recordTable.EnemyBuffTime = self.arglist[2]
  self.caster.recordTable.BaseMissChance = self.arglist[3] // 10
  self.NoEnemy = false
end

function bs_104802:PlaySkill(data)
  self.ShotTimes = 0
  self.MissChance = 0
  self:CallCasterWait(999)
  local attackTrigger = BindCallback(self, self.OnAttackTrigger)
  LuaSkillCtrl:PlayAuSource(self.caster, self.config.audioId_start)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.actionId, self.config.action_speed, self.config.start_time, attackTrigger)
  self.skillLoop = LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_skillStart, self, nil, nil, nil, true)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_170, 1, nil, true)
end

function bs_104802:OnAttackTrigger()
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

function bs_104802:AttackEnemy(target)
  self:CheckMiss(target)
  local IfStun = LuaSkillCtrl:GetRoleAllBuffsByFeature(self.caster, 7)
  if IfStun ~= nil then
    return
  end
  if target.hp <= 0 or target == nil or target.unableSelect then
    return
  end
  LuaSkillCtrl:CallEffect(target, self.config.effectId_Trail, self, self.SkillEventFunc)
end

function bs_104802:SkillEventFunc(effect, eventId, target)
  local buffTarget = target.targetRole
  if effect.dataId == self.config.effectId_Trail and eventId == eBattleEffectEvent.Trigger then
    self:AddBuffAndHurt(buffTarget)
  end
end

function bs_104802:AddBuffAndHurt(buffTarget)
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
  if self.config.weaponLv > 0 then
    local buffs = LuaSkillCtrl:GetRoleBuffs(buffTarget)
    local times = 0
    if buffs ~= nil and 0 < buffs.Count then
      for i = 0, buffs.Count - 1 do
        if buffs[i].buffType == 2 and times < 5 then
          times = times + 1
        end
      end
    end
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, buffTarget)
    LuaSkillCtrl:HurtResult(self, skillResult, self.config.HurtConfig, {
      self.arglist[1] + times * self.arglist[7]
    })
    skillResult:EndResult()
  else
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, buffTarget)
    LuaSkillCtrl:HurtResult(self, skillResult, self.config.HurtConfig, {
      self.arglist[1]
    })
    skillResult:EndResult()
  end
end

function bs_104802:CheckMiss(target)
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

function bs_104802:OnBreakSkill(role)
  base.OnBreakSkill(self, role)
  if role == self.caster then
    self:CancleCasterWait()
    LuaSkillCtrl:DispelBuffByMaker(self.caster, self.caster, self.config.buffId_170, 1, true)
    if self.skillLoop ~= nil then
      self.skillLoop:Die()
      self.skillLoop = nil
    end
  end
  self:OnSkillDamageEnd()
end

function bs_104802:OnCasterDie()
  if self.skillLoop ~= nil then
    self.skillLoop:Die()
    self.skillLoop = nil
  end
  base.OnCasterDie(self)
end

function bs_104802:OnDispose()
  base.OnDispose(self)
  if self.skillLoop ~= nil then
    self.skillLoop:Die()
    self.skillLoop = nil
  end
end

return bs_104802
