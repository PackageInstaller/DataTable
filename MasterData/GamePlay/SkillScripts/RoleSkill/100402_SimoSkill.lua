local bs_100402 = class("bs_100402", LuaSkillBase)
local base = LuaSkillBase
bs_100402.config = {
  effectId_trail = 100403,
  effectId_trail_skin = 100407,
  hurt_config = {hit_formula = 0, basehurt_formula = 3000},
  skill_time = 27,
  actionId = 1002,
  selectId = 9,
  selectrange = 10
}

function bs_100402:ctor()
end

function bs_100402:InitSkill(isMidwaySkill)
end

function bs_100402:PlaySkill(data)
  LuaSkillCtrl:CallBreakAllSkill(self.caster)
  local targetList = LuaSkillCtrl:CallTargetSelect(self, self.config.selectId, self.config.selectrange)
  if targetList.Count == 0 then
    LuaSkillCtrl:SetResetCdByReturnConfigOnce(self)
    return
  end
  self:CallCasterWait(self.config.skill_time)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.actionId, 1, 1, BindCallback(self, self.OnActionTrigger, targetList))
end

function bs_100402:OnActionTrigger(targetList)
  local step = self.arglist[2]
  self.num = 0
  for j = 1, step do
    for i = 0, targetList.Count - 1 do
      local targetRole = targetList[i].targetRole
      if targetRole ~= nil and targetRole.intensity ~= 0 then
        LuaSkillCtrl:StartTimer(self, (self.arglist[2] - step) * (10 - self.arglist[2]), BindCallback(self, self.RealPlaySkill, targetRole), nil, 0)
        step = step - 1
      end
      if step <= 0 then
        return
      end
    end
  end
end

function bs_100402:RealPlaySkill(targetRole)
  self.caster:LookAtTarget(targetRole)
  LuaSkillCtrl:StartTimer(self, 3, function()
    local skinId = LuaSkillCtrl:GetCasterSkinId(self.caster)
    if skinId == 300400 or skinId == 300401 or skinId == 300402 or skinId == 0 then
      LuaSkillCtrl:CallEffect(targetRole, self.config.effectId_trail, self, self.SkillEventFunc)
    else
      LuaSkillCtrl:CallEffect(targetRole, self.config.effectId_trail_skin, self, self.SkillEventFunc)
    end
  end)
end

function bs_100402:SkillEventFunc(effect, eventId, target)
  if eventId == eBattleEffectEvent.Trigger then
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, target)
    LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurt_config, {
      self.arglist[1]
    }, false)
    skillResult:EndResult()
    self.num = self.num + 1
    if self.num == self.arglist[2] then
      self:OnSkillDamageEnd()
    end
  end
end

function bs_100402:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_100402
