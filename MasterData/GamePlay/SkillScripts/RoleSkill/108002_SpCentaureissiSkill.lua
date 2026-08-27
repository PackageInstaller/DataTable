local bs_108002 = class("bs_108002", LuaSkillBase)
local base = LuaSkillBase
bs_108002.config = {
  selectId = 88,
  selectId2 = 71,
  selectId3 = 19,
  actionId = 1002,
  actionId2 = 1020,
  action_speed = 1,
  start_time = 4,
  buffZZ = 108002,
  buffPowerUp = 108003,
  buff_mark = 108004,
  buff_doddge = 108007,
  hurtConfigId = 25,
  effectTrail = 108005,
  effectTrail2 = 108010,
  effectId_fire = 108019,
  effectSX = 108008,
  buffFeature = 0
}

function bs_108002:ctor()
end

function bs_108002:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.time = 0
  self.hurtArgs = {}
  self.endTime = 0
end

function bs_108002:PlaySkill(data)
  self:CallCasterWait(20)
  local attackTrigger
  local enemys = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.enemy)
  local tempList = {}
  if enemys == nil then
    return
  end
  for i = 0, enemys.Count - 1 do
    local targetRole = enemys[i]
    if not targetRole:IsUnSelect(self.caster) and targetRole.belongNum ~= eBattleRoleBelong.neutral then
      table.insert(tempList, targetRole)
    end
  end
  if #tempList <= 0 then
    return
  end
  self.caster:LookAtTarget(tempList[1])
  if 0 < self.caster:GetBuffTier(self.config.buffPowerUp) then
    attackTrigger = BindCallback(self, self.OnAttackTrigger2, tempList)
    LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.actionId2, self.config.action_speed, self.config.start_time, attackTrigger)
  else
    attackTrigger = BindCallback(self, self.OnAttackTrigger, tempList)
    LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.actionId, self.config.action_speed, self.config.start_time, attackTrigger)
  end
end

function bs_108002:OnAttackTrigger(enemys)
  self.time = 0
  LuaSkillCtrl:StartTimer(self, 3, function()
    local n = self.time % #enemys + 1
    self.time = self.time + 1
    LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_fire, self)
    if enemys[n].isDead == false then
      LuaSkillCtrl:CallEffectWithArg(enemys[n], self.config.effectTrail, self, nil, nil, self.SkillEventFunc)
    else
      local enemysNew = LuaSkillCtrl:CallTargetSelect(self, self.config.selectId3, 10)
      if enemysNew == nil or enemysNew.Count <= 0 then
        self:BreakSkill()
      else
        LuaSkillCtrl:CallEffectWithArg(enemysNew[0], self.config.effectTrail, self, nil, nil, self.SkillEventFunc)
      end
    end
  end, nil, 2)
end

function bs_108002:SkillEventFunc(effect, eventId, target)
  if eventId == eBattleEffectEvent.Trigger then
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
    local args = LuaSkillCtrl:CreatCacheTable(self.arglist[2], self.hurtArgs)
    LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.hurtConfigId, args)
    skillResult:EndResult()
    self.endTime = self.endTime + 1
    if self.endTime == 3 then
      self:OnSkillDamageEnd()
      self.endTime = 0
    end
  end
end

function bs_108002:OnAfterAddBuff(buff, target)
  if self.time == 3 and target:GetBuffTier(self.config.buff_mark) == 3 then
    LuaSkillCtrl:BroadcastLuaTrigger(eSkillLuaTrigger.OncentaureissispHit, self.arglist[3])
  end
end

function bs_108002:OnAttackTrigger2(enemys)
  self.time = 0
  LuaSkillCtrl:StartTimer(self, 3, function()
    local n = self.time % #enemys + 1
    self.time = self.time + 1
    if enemys[n].isDead == false then
      LuaSkillCtrl:CallEffectWithArg(enemys[n], self.config.effectTrail2, self, nil, nil, self.SkillEventFunc2)
    else
      local enemysNew = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.enemy)
      if enemysNew == nil then
        self:BreakSkill()
      else
        LuaSkillCtrl:CallEffectWithArg(enemysNew[0], self.config.effectTrail2, self, nil, nil, self.SkillEventFunc2)
      end
    end
  end, nil, 4)
end

function bs_108002:SkillEventFunc2(effect, eventId, target)
  if eventId == eBattleEffectEvent.Trigger then
    LuaSkillCtrl:CallBattleCamShakeByParam(0, 0.2, 0.3, 50)
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
    local args = LuaSkillCtrl:CreatCacheTable(self.arglist[4], self.hurtArgs)
    LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.hurtConfigId, args)
    skillResult:EndResult()
    self.endTime = self.endTime + 1
    if self.endTime == 5 then
      self:OnSkillDamageEnd()
      self.endTime = 0
    end
  end
end

function bs_108002:OnCasterDie()
  base.OnCasterDie(self)
  self.time = 0
  self.endTime = 0
end

function bs_108002:LuaDispose()
  base.LuaDispose(self)
  self.hurtArgs = nil
  self.endTime = 0
end

return bs_108002
