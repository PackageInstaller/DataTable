local bs_93030 = class("bs_93030", LuaSkillBase)
local base = LuaSkillBase
bs_93030.config = {
  effectId = 10978,
  buffId = 2062,
  checkBuffId = 2061
}

function bs_93030:ctor()
end

function bs_93030:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_93030_1", 1, self.OnAfterBattleStart)
end

function bs_93030:OnAfterBattleStart()
  local arriveCallBack = BindCallback(self, self.OnArriveAction)
  self.timer = LuaSkillCtrl:StartTimer(nil, self.arglist[1], arriveCallBack, nil, -1, self.arglist[1])
end

function bs_93030:OnArriveAction()
  if self.timer ~= nil and self.timer:IsOver() then
    self.timer = nil
  end
  local targetlist = LuaSkillCtrl:CallTargetSelect(self, 6, 10)
  if targetlist.Count < 1 then
    return
  end
  for i = 0, targetlist.Count - 1 do
    local target = targetlist[i].targetRole
    local buffTier = target:GetBuffTier(self.config.checkBuffId)
    local targetlist1 = LuaSkillCtrl:CallTargetSelect(self, 51, 10)
    if targetlist1.Count < 0 then
      return
    end
    local targetRole = targetlist1[0].targetRole
    local skill_intensity = targetRole.skill_intensity
    if target ~= nil and buffTier ~= 0 then
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
      LuaSkillCtrl:CallEffect(target, self.config.effectId, self, self.SkillEventFunc)
      LuaSkillCtrl:HealResultWithConfig(self, skillResult, 6, {
        buffTier * self.arglist[2] * skill_intensity // 1000
      }, true, true)
      LuaSkillCtrl:CallBuff(self, target, self.config.buffId, 1, buffTier * self.arglist[3])
      skillResult:EndResult()
    end
  end
end

function bs_93030:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_93030
