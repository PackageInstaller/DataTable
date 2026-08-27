local bs_208201 = class("bs_208201", LuaSkillBase)
local base = LuaSkillBase
bs_208201.config = {
  skill_time = 37,
  start_time = 26,
  actionId = 1002,
  act_speed = 1,
  buffID_gongSu = 208201,
  buffID_yinShen = 208204,
  buffID_jianFang = 208203,
  effectId1 = 208206,
  effectId2 = 208205,
  audioId1 = 208201,
  buffId_170 = 170
}

function bs_208201:ctor()
end

function bs_208201:InitSkill(isMidwaySkill)
  self:AddAfterBuffRemoveTrigger("bs_208201_4", 1, self.AfterBuffRemove, self.caster, nil, self.config.buffID_yinShen, nil)
end

function bs_208201:AfterBuffRemove(buffId, target, removeType)
  LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId_170, 0)
  LuaSkillCtrl:StopShowSkillDurationTime(self)
end

function bs_208201:PlaySkill(data)
  LuaSkillCtrl:CallBreakAllSkill(self.caster)
  self:CallCasterWait(self.config.skill_time)
  LuaSkillCtrl:CallEffect(self.caster, self.config.effectId1, self)
  local skillTrigger = BindCallback(self, self.OnSkillTrigger)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.actionId, self.config.act_speed, self.config.start_time, skillTrigger)
  LuaSkillCtrl:PlayAuSource(self.caster, self.config.audioId1)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_170, 1, nil, true)
end

function bs_208201:OnSkillTrigger()
  local targetList = LuaSkillCtrl:GetAllFriendRolesRelative(self.caster.belongNum)
  if targetList ~= nil then
    local friNum = 0
    for i = 0, targetList.Count - 1 do
      local role = targetList[i]
      if role ~= nil and 0 < role.hp then
        friNum = friNum + 1
      end
    end
    local realtime = (friNum - 1) * self.arglist[3] + self.arglist[2]
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffID_gongSu, 1, realtime)
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffID_jianFang, 1, realtime)
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffID_yinShen, 1, realtime)
    LuaSkillCtrl:StartShowSkillDurationTime(self, realtime)
    self.caster.recordTable.curStartShowDurationSkill = self
  end
end

function bs_208201:OnBreakSkill(role)
  if role ~= self.caster then
    return
  end
  self:RemoveAllTimers()
  self:RemoveAllBreakKillEffects()
  if self.isSkillUncompleted then
    self.caster:RemoveSkillWaitBuff()
    self.cskill:ReturnCDTimeFromBreak()
    self.isSkillUncompleted = false
  end
  if self.cskill.isNormalSkill and self.dataID == self.caster.recordTable.lastSkill then
    self:OnSkillDamageEnd()
  end
end

function bs_208201:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_208201
