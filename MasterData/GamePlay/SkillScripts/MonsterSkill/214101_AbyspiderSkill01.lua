local bs_214101 = class("bs_214101", LuaSkillBase)
local base = LuaSkillBase
bs_214101.config = {
  HurtConfigID = 2,
  actionId = 1020,
  action_speed = 1,
  actionId_start_time = 7,
  skilltime = 25,
  buffId_lockCd = 170,
  buffId_weava = 214101,
  buff_id_locked = 214102,
  effect_trail_1 = 214103,
  effectId_locked = 214112
}

function bs_214101:ctor()
end

function bs_214101:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddBuffDieTrigger("bs_214101", 1, self.OnBuffDie, nil, eBattleRoleBelong.player, self.config.buffId_weava)
  self:AddLuaTrigger(eSkillLuaTrigger.OnRolePhaseMoveStart, self.OnRolePhaseMoveStart)
  self:AddLuaTrigger(eSkillLuaTrigger.OnRoleSplash, self.OnRoleSplash)
  self.onCastSkill = false
  self.caster.recordTable.SpitTargetNum = 2
  self.callnextskill = BindCallback(self, self.EndSkillAndCallNext)
end

function bs_214101:PlaySkill(data)
  local targetList = LuaSkillCtrl:CallTargetSelect(self, 88, 10)
  local target
  if targetList.Count > 0 then
    target = targetList[0]
  end
  if target ~= nil then
    self.caster:LookAtTarget(target)
    self.onCastSkill = true
    local FinalTargetlist = {}
    local TargetNum = 0
    if targetList.Count > self.caster.recordTable.SpitTargetNum then
      TargetNum = self.caster.recordTable.SpitTargetNum
    else
      TargetNum = targetList.Count
    end
    for i = 0, TargetNum - 1 do
      if targetList[i] ~= nil then
        FinalTargetlist[i] = targetList[i]
      end
    end
    local attackTrigger = BindCallback(self, self.OnAttackTrigger, FinalTargetlist)
    local time = self.config.skilltime
    self:CallCasterWait(time)
    LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.actionId, self.config.action_speed, self.config.actionId_start_time, attackTrigger)
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_lockCd, 1, time, true)
    LuaSkillCtrl:StartTimer(self, time, self.callnextskill)
  end
end

function bs_214101:OnAttackTrigger(targetlist)
  if targetlist == nil or 0 >= targetlist[0].targetRole.hp then
    LuaSkillCtrl:CallBreakAllSkill(self.caster)
    return
  end
  for i = #targetlist, 0, -1 do
    local target = targetlist[i]
    LuaSkillCtrl:CallEffectWithArgOverride(target, self.config.effect_trail_1, self, self.caster, nil, nil, self.SkillEventFunc)
  end
end

function bs_214101:SkillEventFunc(effect, eventId, target)
  if effect.dataId == self.config.effect_trail_1 and eventId == eBattleEffectEvent.Trigger then
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
    LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.HurtConfigID, {
      self.arglist[1]
    })
    skillResult:EndResult()
    LuaSkillCtrl:CallBuff(self, target.targetRole, self.config.buffId_weava, 1, self.arglist[3], false)
  end
end

function bs_214101:OnBuffDie(buff, target, removeType)
  if removeType == eBuffRemoveType.Timeout then
    LuaSkillCtrl:CallBuffRepeated(self, target, self.config.buff_id_locked, 1, self.arglist[5], false, false, self.OnBuffExecute)
  end
end

function bs_214101:OnBuffExecute(buff, targetRole)
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, targetRole)
  local hurtnum = self.arglist[4]
  LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.HurtConfigID, {hurtnum}, true)
  skillResult:EndResult()
end

function bs_214101:OnRoleSplash(role, grid)
  if role.belongNum == eBattleRoleBelong.player and role.hp > 0 then
    LuaSkillCtrl:DispelBuff(role, self.config.buffId_weava, 0)
  end
end

function bs_214101:OnRolePhaseMoveStart(role, luaskill)
  if role.belongNum == eBattleRoleBelong.player and role.hp > 0 then
    LuaSkillCtrl:DispelBuff(role, self.config.buffId_weava, 0)
  end
end

function bs_214101:OnBreakSkill(role)
  base.OnBreakSkill(self, role)
  if self.onCastSkill == true then
    self:EndSkillAndCallNext()
  end
end

function bs_214101:EndSkillAndCallNext()
  self.onCastSkill = false
  LuaSkillCtrl:DispelBuff(self.caster, 170, 0)
  if self.caster == nil then
    return
  end
  self:CancleCasterWait()
  local skillMgr = self.caster:GetSkillComponent()
  if skillMgr == nil then
    return
  end
  skillMgr.lastSkill = self.cskill
  self.caster:CallUnFreezeNextSkill()
  LuaSkillCtrl:StopShowSkillDurationTime(self)
end

function bs_214101:OnCasterDie()
  base.OnCasterDie(self)
end

function bs_214101:LuaDispose()
  base.LuaDispose(self)
  self.callnextskill = nil
end

return bs_214101
