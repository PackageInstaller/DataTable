local card_10018 = class("card_10018", LuaSkillBase)
local base = LuaSkillBase
card_10018.config = {
  hurt_config = {
    hit_formula = 0,
    basehurt_formula = 10127,
    crit_formula = 0
  },
  effectId = 10968
}

function card_10018:ctor()
end

function card_10018:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "card_10018_1", 1, self.OnAfterBattleStart)
end

function card_10018:OnAfterBattleStart()
  local arriveCallBack = BindCallback(self, self.OnArriveAction)
  self.timer = LuaSkillCtrl:StartTimer(nil, self.arglist[2], arriveCallBack, nil, -1, self.arglist[2])
end

function card_10018:OnArriveAction()
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
  local role, damage = LuaSkillCtrl:CallFindMaxPowOrSkillIntensityRole()
  if damage ~= 0 and targetlist.Count > 0 and targetlist[0] ~= nil then
    for i = 0, targetlist.Count - 1 do
      local target = targetlist[i].targetRole
      if target ~= nil then
        local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
        LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurt_config, {damage}, true)
        skillResult:EndResult()
      end
    end
  end
  local target1 = LuaSkillCtrl:GetTargetWithGrid(3, 2)
  LuaSkillCtrl:CallEffect(target1, self.config.effectId, self)
end

function card_10018:OnCasterDie()
  base.OnCasterDie(self)
end

return card_10018
