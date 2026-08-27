local bs_4010408 = class("bs_4010408", LuaSkillBase)
local base = LuaSkillBase
bs_4010408.config = {buffId = 110070}

function bs_4010408:ctor()
end

function bs_4010408:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddLuaTrigger(eSkillLuaTrigger.OnRealSummonerCaster, self.CallSummonerBuff)
end

function bs_4010408:CallSummonerBuff(role)
  if role.summoner.summonerMaker.belongNum == eBattleRoleBelong.player then
    LuaSkillCtrl:CallBuff(self, role, self.config.buffId, 1, nil)
  end
end

function bs_4010408:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_4010408
