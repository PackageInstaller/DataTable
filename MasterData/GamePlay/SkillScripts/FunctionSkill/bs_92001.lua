local bs_92001 = class("bs_92001", LuaSkillBase)
local base = LuaSkillBase
bs_92001.config = {
  hurt_config = {
    hit_formula = 0,
    basehurt_formula = 10127,
    crit_formula = 0
  },
  effectId = 10968
}

function bs_92001:ctor()
end

function bs_92001:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_92001_1", 1, self.OnAfterBattleStart)
end

function bs_92001:OnAfterBattleStart()
  local arriveCallBack = BindCallback(self, self.OnArriveAction)
  self.timer = LuaSkillCtrl:StartTimer(nil, self.arglist[2], arriveCallBack, nil, -1, self.arglist[2])
end

function bs_92001:OnArriveAction()
  if self.timer ~= nil and self.timer:IsOver() then
    self.timer = nil
  end
  local targetlist = LuaSkillCtrl:CallTargetSelect(self, 9, 10)
  if targetlist.Count < 1 then
    return
  end
  local highAttRole = LuaSkillCtrl:CallTargetSelect(self, 46, 20)
  if highAttRole ~= nil and highAttRole.Count > 0 and highAttRole[0] ~= nil then
    for i = 0, targetlist.Count - 1 do
      local target = targetlist[i].targetRole
      if target ~= nil then
        local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
        LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurt_config, {
          highAttRole[0].targetRole.skill_intensity
        }, true)
        skillResult:EndResult()
      end
    end
  end
  local target1 = LuaSkillCtrl:GetTargetWithGrid(3, 2)
  LuaSkillCtrl:CallEffect(target1, self.config.effectId, self)
end

function bs_92001:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_92001
