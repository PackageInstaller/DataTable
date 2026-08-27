local bs_82031 = class("bs_82031", LuaSkillBase)
local base = LuaSkillBase
bs_82031.config = {buff_ExSkill = 704}

function bs_82031:ctor()
end

function bs_82031:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_82031_1", 1, self.OnAfterBattleStart)
  self.skillCasterEntity = LuaSkillCtrl:GetPlayerRoleEntity()
end

function bs_82031:OnAfterBattleStart()
  self.skillCasterEntity.recordTable.elfSkill_Level = self.cskill.level
  local targetList = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
  if targetList.Count > 0 then
    for i = 0, targetList.Count - 1 do
      if targetList[i].roleType == eBattleRoleType.character then
        LuaSkillCtrl:CallBuff(self, targetList[i], self.config.buff_ExSkill, 1, nil, true)
      end
    end
  end
end

function bs_82031:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_82031
