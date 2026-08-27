local bs_17327 = class("bs_17327", LuaSkillBase)
local base = LuaSkillBase
bs_17327.config = {summonerId = 92}

function bs_17327:ctor()
end

function bs_17327:InitSkill(isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_17327", 50, self.OnAfterBattleStart)
end

function bs_17327:OnAfterBattleStart()
  local grid = LuaSkillCtrl:FindEmptyGrid()
  local summoner = LuaSkillCtrl:CreateSummoner(self, self.config.summonerId, grid.x, grid.y)
  summoner:SetAttr(eHeroAttr.maxHp, self.caster.maxHp * self.config.maxHp_per // 1000)
  summoner:SetAttr(eHeroAttr.def, self.caster.def * self.config.def_per // 1000)
  summoner:SetAttr(eHeroAttr.magic_res, self.caster.magic_res * self.config.magic_res_per // 1000)
  summoner:SetAsRealEntity(1)
  local summonerEntity = LuaSkillCtrl:AddSummonerRole(summoner)
end

function bs_17327:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_17327
