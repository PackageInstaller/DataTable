local bs_1004022 = class("bs_1004022", LuaSkillBase)
local base = LuaSkillBase
bs_1004022.config = {
  effectId_trail = 100403,
  hurt_config = {hit_formula = 0, basehurt_formula = 3000},
  skill_time = 27,
  actionId = 1002,
  selectId = 9,
  selectrange = 10
}

function bs_1004022:ctor()
end

function bs_1004022:InitSkill(isMidwaySkill)
end

function bs_1004022:PlaySkill(data)
  LuaSkillCtrl:CallBreakAllSkill(self.caster)
  local targetList = LuaSkillCtrl:CallTargetSelect(self, self.config.selectId, self.config.selectrange)
  if targetList.Count == 0 then
    LuaSkillCtrl:SetResetCdByReturnConfigOnce(self)
    return
  end
  self:CallCasterWait(self.config.skill_time)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.actionId, 1, 1, BindCallback(self, self.OnActionTrigger, targetList))
end

function bs_1004022:OnActionTrigger(targetList)
  local step = self.arglist[2]
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

function bs_1004022:RealPlaySkill(targetRole)
  self.caster:LookAtTarget(targetRole)
  LuaSkillCtrl:StartTimer(self, 3, function()
    LuaSkillCtrl:CallEffect(targetRole, self.config.effectId_trail, self, self.SkillEventFunc)
  end)
end

function bs_1004022:SkillEventFunc(effect, eventId, target)
  if eventId == eBattleEffectEvent.Trigger then
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, target)
    LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurt_config, {
      self.arglist[1]
    }, false)
    skillResult:EndResult()
  end
end

function bs_1004022:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_1004022
