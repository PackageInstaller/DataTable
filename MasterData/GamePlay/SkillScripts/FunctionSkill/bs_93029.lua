local bs_93029 = class("bs_93029", LuaSkillBase)
local base = LuaSkillBase
bs_93029.config = {
  hurt_config = {
    hit_formula = 0,
    crit_formula = 9992,
    basehurt_formula = 10031
  },
  effectId = 10977,
  buffId = 26,
  checkBuffId = 2055
}

function bs_93029:ctor()
end

function bs_93029:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_93029_1", 1, self.OnAfterBattleStart)
end

function bs_93029:OnAfterBattleStart()
  local arriveCallBack = BindCallback(self, self.OnArriveAction)
  self.timer = LuaSkillCtrl:StartTimer(nil, self.arglist[1], arriveCallBack, nil, -1, self.arglist[1])
end

function bs_93029:OnArriveAction()
  if self.timer ~= nil and self.timer:IsOver() then
    self.timer = nil
  end
  local targetlist = LuaSkillCtrl:CallTargetSelect(self, 9, 10)
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
      LuaSkillCtrl:CallEffect(target, self.config.effectId, self)
      LuaSkillCtrl:RemoveLife(buffTier * self.arglist[2] * skill_intensity // 1000, self, target, true, nil, true, false, eHurtType.RealDmg)
      LuaSkillCtrl:CallBuff(self, target, self.config.buffId, 1, buffTier * self.arglist[3])
      skillResult:EndResult()
    end
  end
end

function bs_93029:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_93029
