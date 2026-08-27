local bs_92055 = class("bs_92055", LuaSkillBase)
local base = LuaSkillBase
bs_92055.config = {}

function bs_92055:ctor()
end

function bs_92055:InitSkill(isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_92055_1", 1, self.OnAfterBattleStart)
end

function bs_92055:OnAfterBattleStart()
  self.damTimer = LuaSkillCtrl:StartTimer(self, self.arglist[2], self.CallBack, self, -1, self.arglist[2])
end

function bs_92055:CallBack()
  if self.damTimer ~= nil and self.damTimer:IsOver() then
    self.damTimer = nil
  end
  local targetListAll = LuaSkillCtrl:CallTargetSelect(self, 6, 10)
  if targetListAll.Count > 0 then
    for i = 0, targetListAll.Count - 1 do
      LuaSkillCtrl:CallHeal(targetListAll[i].targetRole.maxHp * self.arglist[1] // 1000, self, targetListAll[i], true)
    end
    self:PlayChipEffect()
  end
end

function bs_92055:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_92055
