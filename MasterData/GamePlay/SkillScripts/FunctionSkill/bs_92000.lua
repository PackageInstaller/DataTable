local bs_92000 = class("bs_92000", LuaSkillBase)
local base = LuaSkillBase
bs_92000.config = {
  hurt_config = {
    hit_formula = 0,
    basehurt_formula = 10127,
    crit_formula = 0
  },
  effectId = 10967
}

function bs_92000:ctor()
end

function bs_92000:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_92000_1", 1, self.OnAfterBattleStart)
end

function bs_92000:OnAfterBattleStart()
  local arriveCallBack = BindCallback(self, self.OnArriveAction)
  self.timer = LuaSkillCtrl:StartTimer(nil, self.arglist[2], arriveCallBack, nil, -1, self.arglist[2])
end

function bs_92000:OnArriveAction()
  if self.timer ~= nil and self.timer:IsOver() then
    self.timer = nil
  end
  local targetlist = LuaSkillCtrl:CallTargetSelect(self, 7, 10)
  if targetlist.Count < 1 then
    return
  end
  local target = targetlist[0].targetRole
  if target == nil then
    return
  end
  local highAttRole = LuaSkillCtrl:CallTargetSelect(self, 59, 20)
  if highAttRole ~= nil and highAttRole.Count > 0 and highAttRole[0] ~= nil then
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
    LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurt_config, {
      highAttRole[0].targetRole.pow
    }, true)
    skillResult:EndResult()
  end
  LuaSkillCtrl:CallEffect(target, self.config.effectId, self)
end

function bs_92000:OnCasterDie()
  base.OnCasterDie(self)
  if self.timer ~= nil then
    self.timer:Stop()
    self.timer = nil
  end
end

return bs_92000
