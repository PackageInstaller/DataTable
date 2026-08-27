local bs_4010402 = class("bs_4010402", LuaSkillBase)
local base = LuaSkillBase
bs_4010402.config = {heal_config = 4}

function bs_4010402:ctor()
end

function bs_4010402:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddLuaTrigger(eSkillLuaTrigger.OnRealSummonerCaster, self.CallSummonerHeal)
end

function bs_4010402:CallSummonerHeal(role)
  if role.summoner.summonerMaker.belongNum == eBattleRoleBelong.player then
    local targetlist = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
    if targetlist.Count < 1 then
      return
    end
    for i = 0, targetlist.Count - 1 do
      local targetRole = targetlist[i]
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, targetRole)
      LuaSkillCtrl:HealResultWithConfig(self, skillResult, self.config.heal_config, {
        self.arglist[1]
      }, true, true)
      skillResult:EndResult()
    end
  end
end

function bs_4010402:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_4010402
