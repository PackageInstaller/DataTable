local card_10009 = class("card_10009", LuaSkillBase)
local base = LuaSkillBase
card_10009.config = {}

function card_10009:ctor()
end

function card_10009:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.OnGridCreatedInBattle, "card_10009_2", 1, self.OnGridCreatedInBattle)
end

function card_10009:OnGridCreatedInBattle(gridId, totalGridCount)
  if gridId == 1131 or gridId == 1136 then
    local playList = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
    if playList.Count > 0 then
      for i = playList.Count - 1, 0, -1 do
        local targetRole = playList[i]
        LuaSkillCtrl:CallBuff(self, targetRole, 1506, 1, 75, true)
      end
    end
  end
  if gridId == 1133 then
    local playList = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
    if playList.Count > 0 then
      for i = playList.Count - 1, 0, -1 do
        local targetRole = playList[i]
        LuaSkillCtrl:CallBuff(self, targetRole, 1506, 1, 75, true)
      end
    end
  end
end

function card_10009:OnCasterDie()
  base.OnCasterDie(self)
end

return card_10009
