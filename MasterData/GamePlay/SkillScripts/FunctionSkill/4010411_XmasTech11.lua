local bs_4010411 = class("bs_4010411", LuaSkillBase)
local base = LuaSkillBase
bs_4010411.config = {buffId = 110072}

function bs_4010411:ctor()
end

function bs_4010411:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddLuaTrigger(eSkillLuaTrigger.OnRealSummonerCaster, self.CallSummonerBuff)
end

function bs_4010411:CallSummonerBuff(role)
  if role.summoner.summonerMaker.belongNum == eBattleRoleBelong.player then
    LuaSkillCtrl:CallBuff(self, role, self.config.buffId, 1, self.arglist[1], true)
  end
end

function bs_4010411:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_4010411
