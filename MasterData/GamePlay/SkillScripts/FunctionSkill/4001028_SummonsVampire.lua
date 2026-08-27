local bs_4001028 = class("bs_4001028", LuaSkillBase)
local base = LuaSkillBase
bs_4001028.config = {buffId = 2022}

function bs_4001028:ctor()
end

function bs_4001028:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddLuaTrigger(eSkillLuaTrigger.OnRealSummonerCaster, self.OnRealSummonerCaster)
end

function bs_4001028:OnRealSummonerCaster(summonerEntity)
  if summonerEntity.recordTable.VampireFlag ~= true then
    LuaSkillCtrl:CallBuff(self, summonerEntity, self.config.buffId, 1, nil, true)
    summonerEntity.recordTable.VampireFlag = true
  end
end

function bs_4001028:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_4001028
