local card_20009 = class("card_20009", LuaSkillBase)
local base = LuaSkillBase
card_20009.config = {}

function card_20009:ctor()
end

function card_20009:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.OnGridCreatedInBattle, "card_20009_2", 1, self.OnGridCreatedInBattle)
end

function card_20009:OnGridCreatedInBattle(gridId, totalGridCount)
  if gridId ~= 1131 and gridId ~= 1136 and gridId ~= 1133 then
    local enemyList = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.enemy)
    if enemyList.Count > 0 then
      for i = enemyList.Count - 1, 0, -1 do
        local targetRole = enemyList[i]
        LuaSkillCtrl:CallBuff(self, targetRole, 1506, 1, 75, true)
      end
    end
  end
end

function card_20009:OnCasterDie()
  base.OnCasterDie(self)
end

return card_20009
