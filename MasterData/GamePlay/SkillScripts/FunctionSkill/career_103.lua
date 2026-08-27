local career_103 = class("career_103", LuaSkillBase)
local base = LuaSkillBase
career_103.config = {buffId = 1801}

function career_103:ctor()
end

function career_103:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddLuaTrigger(eSkillLuaTrigger.OnRealSummonerCaster, self.OnRealSummonerCaster)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "career_103_2", 1, self.OnAfterBattleStart)
end

function career_103:OnAfterBattleStart()
  local targetlist = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
  if targetlist ~= nil then
    for i = 0, targetlist.Count - 1 do
      LuaSkillCtrl:CallBuff(self, targetlist[i], self.config.buffId, 1, nil, true)
    end
  end
end

function career_103:OnRealSummonerCaster(summonerEntity)
  if summonerEntity.belongNum == eBattleRoleBelong.player then
    LuaSkillCtrl:CallBuff(self, summonerEntity, self.config.buffId, 1, nil, true)
    self:PlayChipEffect()
  end
end

function career_103:OnCasterDie()
  base.OnCasterDie(self)
end

return career_103
