local bs_20120 = class("bs_20120", LuaSkillBase)
local base = LuaSkillBase
bs_20120.config = {
  monsterId = 29,
  totalTime = 150,
  maxHp = 20000,
  pow = 800,
  intensity = 1600,
  speed = 150
}

function bs_20120:ctor()
end

function bs_20120:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_20120_1", 1, self.OnAfterBattleStart)
end

function bs_20120:OnAfterBattleStart()
  local arriveCallBack = BindCallback(self, self.Chuxian)
  LuaSkillCtrl:StartTimer(nil, self.config.totalTime, arriveCallBack)
end

function bs_20120:Chuxian()
  local grid = LuaSkillCtrl:FindEmptyGrid(nil)
  if grid ~= nil then
    local summoner = LuaSkillCtrl:CreateSummoner(self, self.config.monsterId, grid.x, grid.y)
    summoner:SetAttr(eHeroAttr.maxHp, self.config.maxHp)
    summoner:SetAttr(eHeroAttr.pow, self.config.pow)
    summoner:SetAttr(eHeroAttr.skill_intensity, self.config.intensity)
    summoner:SetAttr(eHeroAttr.speed, self.config.speed)
    summoner:SetAsRealEntity(1)
    local summonerEntity = LuaSkillCtrl:AddSummonerRole(summoner)
    LuaSkillCtrl:CallEffect(summonerEntity, 10264, self)
  end
end

function bs_20120:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_20120
