local bs_21261 = class("bs_21261", LuaSkillBase)
local base = LuaSkillBase
bs_21261.config = {check_skillId = 70047, buffId = 2231}

function bs_21261:ctor()
end

function bs_21261:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_21261_1", 1, self.OnAfterBattleStart)
end

function bs_21261:OnAfterBattleStart()
  if self.caster.recordTable.bs_70047 ~= nil then
    local pList = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
    for i = 0, pList.Count - 1 do
      LuaSkillCtrl:CallBuff(self, pList[i], self.config.buffId, 1, nil, true, nil, true)
    end
  end
end

function bs_21261:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_21261
