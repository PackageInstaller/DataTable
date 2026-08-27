local bs_92061 = class("bs_92061", LuaSkillBase)
local base = LuaSkillBase
bs_92061.config = {
  hurt_config = {
    hit_formula = 0,
    basehurt_formula = 10127,
    crit_formula = 0
  },
  effectId = 10967
}

function bs_92061:ctor()
end

function bs_92061:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_92061_1", 1, self.OnAfterBattleStart)
end

function bs_92061:OnAfterBattleStart()
  local arriveCallBack = BindCallback(self, self.OnArriveAction)
  self.timer = LuaSkillCtrl:StartTimer(nil, self.arglist[2], arriveCallBack, nil, -1, self.arglist[2])
end

function bs_92061:OnArriveAction()
  if self.timer ~= nil and self.timer:IsOver() then
    self.timer = nil
  end
  local targetlist = LuaSkillCtrl:CallTargetSelect(self, 7, 10)
  if targetlist.Count == 0 then
    return
  end
  local target = targetlist[0].targetRole
  if target == nil then
    return
  end
  local targetlist1 = LuaSkillCtrl:CallTargetSelect(self, 6, 10)
  if targetlist1.Count < 1 then
    return
  end
  local pow = 0
  for i = 0, targetlist1.Count - 1 do
    local targetRole = targetlist1[i].targetRole
    pow = pow + targetRole.pow
  end
  if pow ~= 0 and targetlist.Count > 0 and targetlist[0] ~= nil then
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
    LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurt_config, {pow}, true)
    skillResult:EndResult()
  end
  LuaSkillCtrl:CallEffect(target, self.config.effectId, self)
end

function bs_92061:OnCasterDie()
  base.OnCasterDie(self)
  if self.timer ~= nil then
    self.timer:Stop()
    self.timer = nil
  end
end

return bs_92061
