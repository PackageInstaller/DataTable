local bs_25403 = class("bs_25403", LuaSkillBase)
local base = LuaSkillBase
bs_25403.config = {buffId = 2157}

function bs_25403:ctor()
end

function bs_25403:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddLuaTrigger(eSkillLuaTrigger.OnRealSummonerCaster, self.OnRealSummonerCaster)
end

function bs_25403:OnRealSummonerCaster(role)
  if role.summoner.summonerMaker.belongNum == eBattleRoleBelong.player then
    LuaSkillCtrl:CallBuff(self, role, self.config.buffId, 1, nil, true)
  end
end

function bs_25403:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_25403
