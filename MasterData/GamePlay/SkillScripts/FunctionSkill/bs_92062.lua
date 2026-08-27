local bs_92062 = class("bs_92062", LuaSkillBase)
local base = LuaSkillBase
bs_92062.config = {
  hurt_config = {
    hit_formula = 0,
    basehurt_formula = 10127,
    crit_formula = 0
  },
  effectId = 10968
}

function bs_92062:ctor()
end

function bs_92062:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_92062_1", 1, self.OnAfterBattleStart)
end

function bs_92062:OnAfterBattleStart()
  local arriveCallBack = BindCallback(self, self.OnArriveAction)
  self.timer = LuaSkillCtrl:StartTimer(nil, self.arglist[2], arriveCallBack, nil, -1, self.arglist[2])
end

function bs_92062:OnArriveAction()
  if self.timer ~= nil and self.timer:IsOver() then
    self.timer = nil
  end
  local targetlist = LuaSkillCtrl:CallTargetSelect(self, 9, 10)
  if targetlist.Count < 1 then
    return
  end
  local targetlist1 = LuaSkillCtrl:CallTargetSelect(self, 6, 10)
  if targetlist1.Count < 1 then
    return
  end
  local skill_intensity = 0
  for i = 0, targetlist1.Count - 1 do
    local targetRole = targetlist1[i].targetRole
    skill_intensity = skill_intensity + targetRole.skill_intensity
  end
  if skill_intensity ~= 0 and targetlist.Count > 0 and targetlist[0] ~= nil then
    for i = 0, targetlist.Count - 1 do
      local target = targetlist[i].targetRole
      if target ~= nil then
        local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
        LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurt_config, {skill_intensity}, true)
        skillResult:EndResult()
      end
    end
  end
  local target1 = LuaSkillCtrl:GetTargetWithGrid(3, 2)
  LuaSkillCtrl:CallEffect(target1, self.config.effectId, self)
end

function bs_92062:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_92062
