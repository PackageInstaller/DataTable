local bs_605 = class("bs_605", LuaSkillBase)
local base = LuaSkillBase
bs_605.config = {monsterId = 1018, buffId = 88}

function bs_605:ctor()
end

function bs_605:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_605:OnCasterDie()
  local summoner = LuaSkillCtrl:CreateSummoner(self, self.config.monsterId, self.caster.x + 1, self.caster.y)
  summoner:SetAttr(eHeroAttr.maxHp, self.caster.maxHp)
  summoner:SetAsRealEntity(1)
  base.OnCasterDie(self)
  LuaSkillCtrl:StartTimer(nil, 30, function(summoner)
    local summonerEntity = LuaSkillCtrl:AddSummonerRole(summoner)
    LuaSkillCtrl:CallBuff(self, summonerEntity, self.config.buffId, 1, nil, true)
  end, summoner)
end

return bs_605
