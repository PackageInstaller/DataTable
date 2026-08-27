local bs_93005 = class("bs_93005", LuaSkillBase)
local base = LuaSkillBase
bs_93005.config = {effectId = 10969}

function bs_93005:ctor()
end

function bs_93005:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.AfterBattleStart, "bs_93005_1", 1, self.OnAfterBattleStart)
end

function bs_93005:OnAfterBattleStart()
  local arriveCallBack = BindCallback(self, self.OnArriveAction)
  self.timer = LuaSkillCtrl:StartTimer(nil, self.arglist[1], arriveCallBack, nil, -1, self.arglist[1])
end

function bs_93005:OnArriveAction()
  if self.timer ~= nil and self.timer:IsOver() then
    self.timer = nil
  end
  local targetlist = LuaSkillCtrl:CallTargetSelect(self, 9, 10)
  if targetlist ~= nil and targetlist.Count > 0 then
    local targetSelect
    for i = 0, targetlist.Count - 1 do
      if targetlist[i].targetRole.intensity < 3 and targetSelect == nil then
        targetSelect = targetlist[i].targetRole
      elseif targetlist[i].targetRole.intensity < 3 and targetlist[i].targetRole.hp > targetSelect.hp then
        targetSelect = targetlist[i].targetRole
      end
    end
    if targetSelect ~= nil then
      local damage = targetSelect.maxHp * self.arglist[2] // 1000
      LuaSkillCtrl:RemoveLife(damage, self, targetSelect, true, nil, true, true)
      LuaSkillCtrl:CallEffect(targetSelect, self.config.effectId, self, self.SkillEventFunc)
    end
  end
end

function bs_93005:OnCasterDie()
  base.OnCasterDie(self)
  if self.timer ~= nil then
    self.timer:Stop()
    self.timer = nil
  end
end

return bs_93005
