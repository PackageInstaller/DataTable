local bs_4010433 = class("bs_4010433", LuaSkillBase)
local base = LuaSkillBase
bs_4010433.config = {buffId = 2073}

function bs_4010433:ctor()
end

function bs_4010433:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_4010433", 1, self.OnBattleStart)
end

function bs_4010433:OnBattleStart()
  local targetList1 = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.enemy)
  local targetList2 = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
  for i = 0, targetList1.Count - 1 do
    LuaSkillCtrl:CallBuff(self, targetList1[i], self.config.buffId, 1)
  end
  for i = 0, targetList2.Count - 1 do
    LuaSkillCtrl:CallBuff(self, targetList2[i], self.config.buffId, 1, nil, false)
  end
end

function bs_4010433:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_4010433
