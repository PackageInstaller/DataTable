local bs_17103 = class("bs_17103", LuaSkillBase)
local base = LuaSkillBase
bs_17103.config = {buffId = 2143}

function bs_17103:ctor()
end

function bs_17103:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddLuaTrigger(eSkillLuaTrigger.OnRealSummonerCaster, self.OnRealSummonerCaster)
end

function bs_17103:OnRealSummonerCaster(summonerEntity)
  LuaSkillCtrl:CallBuff(self, summonerEntity, self.config.buffId, 1, nil, true)
end

function bs_17103:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_17103
