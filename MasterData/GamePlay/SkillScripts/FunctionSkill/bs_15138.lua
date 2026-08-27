local bs_15138 = class("bs_15138", LuaSkillBase)
local base = LuaSkillBase
bs_15138.config = {}

function bs_15138:ctor()
end

function bs_15138:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_15138_1", 1, self.OnAfterBattleStart)
end

function bs_15138:OnAfterBattleStart()
  if self.damTimer ~= nil then
    self.damTimer:Stop()
    self.damTimer = nil
  end
  self.damTimer = LuaSkillCtrl:StartTimer(nil, self.arglist[1], self.CallBack, self, -1, self.arglist[1])
end

function bs_15138:CallBack()
  local targetList = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
  if targetList.Count > 0 then
    for i = 0, targetList.Count - 1 do
      if targetList[i].roleDataId ~= 116 then
        local ShieldNum = targetList[i].maxHp * self.arglist[2] // 1000
        LuaSkillCtrl:AddRoleShield(targetList[i], eShieldType.Normal, ShieldNum)
      end
    end
  end
end

function bs_15138:OnCasterDie()
  base.OnCasterDie(self)
  if self.damTimer then
    self.damTimer:Stop()
    self.damTimer = nil
  end
end

return bs_15138
