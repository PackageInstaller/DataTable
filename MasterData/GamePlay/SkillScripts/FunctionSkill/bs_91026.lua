local bs_91026 = class("bs_91026", LuaSkillBase)
local base = LuaSkillBase
bs_91026.config = {buffId = 2048, buffTier = 1}

function bs_91026:ctor()
end

function bs_91026:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_91026_1", 1, self.OnAfterBattleStart)
end

function bs_91026:OnAfterBattleStart()
  self.damTimer = LuaSkillCtrl:StartTimer(self, self.arglist[1], self.CallBack, self, -1, self.arglist[1])
end

function bs_91026:CallBack()
  if self.damTimer ~= nil and self.damTimer:IsOver() then
    self.damTimer = nil
  end
  local targetListAll = LuaSkillCtrl:CallTargetSelect(self, 6, 10)
  if targetListAll.Count > 0 then
    for i = 0, targetListAll.Count - 1 do
      LuaSkillCtrl:CallBuff(self, targetListAll[i].targetRole, self.config.buffId, self.config.buffTier, nil)
    end
    self:PlayChipEffect()
  end
end

function bs_91026:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_91026
