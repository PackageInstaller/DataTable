local bs_92056 = class("bs_92056", LuaSkillBase)
local base = LuaSkillBase
bs_92056.config = {}

function bs_92056:ctor()
end

function bs_92056:InitSkill(isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_92056_1", 1, self.OnAfterBattleStart)
end

function bs_92056:OnAfterBattleStart()
  self.damTimer = LuaSkillCtrl:StartTimer(self, self.arglist[2], self.CallBack, self, -1, self.arglist[2])
end

function bs_92056:CallBack()
  if self.damTimer ~= nil and self.damTimer:IsOver() then
    self.damTimer = nil
  end
  local targetList = LuaSkillCtrl:CallTargetSelect(self, 6, 10)
  if targetList.Count > 0 then
    for i = 0, targetList.Count - 1 do
      local Value = self.arglist[1] * targetList[i].targetRole.maxHp // 1000
      LuaSkillCtrl:AddRoleShield(targetList[i].targetRole, eShieldType.Normal, Value)
    end
    self:PlayChipEffect()
  end
end

function bs_92056:OnCasterDie()
  base.OnCasterDie(self)
  if self.damTimer then
    self.damTimer:Stop()
    self.damTimer = nil
  end
end

return bs_92056
