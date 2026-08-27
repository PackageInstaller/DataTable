local bs_202901 = class("bs_202901", LuaSkillBase)
local base = LuaSkillBase
bs_202901.config = {
  buffId_110 = 3010,
  buffId_66 = 66,
  effectId = 10570,
  hurt_delay = 10,
  effectHitId = 10571,
  HurtConfig = {
    hit_formula = 0,
    crit_formula = 0,
    correct_formula = 9989,
    basehurt_formula = 10077
  },
  select_id = 9,
  select_range = 0,
  start_time = 16,
  end_time = 5,
  startAnimId = 1008,
  loopAnimId = 1007,
  endAnimId1 = 1009,
  endAnimId2 = 100,
  endAnimDelay = 5,
  audio_loop = 321
}

function bs_202901:ctor()
end

function bs_202901:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterAddBuffTrigger("bs_202901_7", 1, self.OnAfterAddBuff, nil, nil, nil, nil, self.config.buffId_110)
end

function bs_202901:OnAfterAddBuff(buff, target)
  if buff.dataId == self.config.buffId_110 then
    local restTier = target:GetBuffTier(self.config.buffId_110)
    if restTier >= self.arglist[4] then
      LuaSkillCtrl:CallBuff(self, target, self.config.buffId_66, 1, 30)
      LuaSkillCtrl:DispelBuff(target, self.config.buffId_110, 0, true)
      restTier = 0
    end
  end
end

function bs_202901:PlaySkill(data)
  local targetList = LuaSkillCtrl:CallTargetSelect(self, self.config.select_id, self.config.select_range)
  if targetList ~= nil and targetList.Count > 0 and targetList[0] ~= nil then
    local attackTrigger = BindCallback(self, self.OnAttackTrigger, data)
    self:CallCasterWait(self.config.start_time + self.arglist[6] + self.config.end_time)
    LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.startAnimId, 1, self.config.start_time, attackTrigger)
    self.loopeffect = LuaSkillCtrl:CallEffect(self.caster, self.config.effectId, self, nil, nil, nil, true)
  end
end

function bs_202901:OnAttackTrigger(data)
  LuaSkillCtrl:CallRoleAction(self.caster, self.config.loopAnimId)
  self.time = LuaSkillCtrl:StartTimer(self, self.arglist[1], function()
    if self.time ~= nil and self.time:IsOver() then
      self.time = nil
    end
    local targetList = LuaSkillCtrl:CallTargetSelect(self, self.config.select_id, self.config.select_range)
    if targetList.Count > 0 then
      for i = 0, targetList.Count - 1 do
        local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, targetList[i].targetRole)
        skillResult:BuffResult(self.config.buffId_110, 1)
        LuaSkillCtrl:PlayAuHit(self, targetList[i].targetRole)
        LuaSkillCtrl:HurtResult(self, skillResult, self.config.HurtConfig)
        skillResult:EndResult()
        LuaSkillCtrl:CallEffect(targetList[i].targetRole, self.config.effectHitId, self, nil, nil, nil, true)
      end
    end
  end, self, -1, self.config.hurt_delay)
  LuaSkillCtrl:StartTimer(self, self.arglist[6], function()
    if self.loopeffect ~= nil then
      self.loopeffect:Die()
      self.loopeffect = nil
    end
    if self.time ~= nil then
      self.time:Stop()
      self.time = nil
    end
    LuaSkillCtrl:CallRoleAction(self.caster, self.config.endAnimId1)
    LuaSkillCtrl:StartTimer(nil, self.config.endAnimDelay, function()
      LuaSkillCtrl:CallRoleAction(self.caster, self.config.endAnimId2)
    end)
  end)
end

function bs_202901:OnCasterDie()
  base.OnCasterDie(self)
end

function bs_202901:LuaDispose()
  base.LuaDispose(self)
  self.loopeffect = nil
end

return bs_202901
