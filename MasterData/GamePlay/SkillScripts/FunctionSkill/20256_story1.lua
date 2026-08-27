local bs_20256 = class("bs_20256", LuaSkillBase)
local base = LuaSkillBase
bs_20256.config = {
  pos = {
    {2, 0},
    {2, 1},
    {2, 2},
    {2, 4},
    {2, 5},
    {2, 6}
  },
  SummonnerId = 66,
  maxHpPer = 150,
  powPer = 700,
  skill_intensityPer = 700,
  critPer = 1000,
  critDamagePer = 1000,
  defPer = 1000,
  sunderPer = 1000,
  magic_resPer = 1000,
  magic_penPer = 1000
}

function bs_20256:ctor()
end

function bs_20256:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_20256", 1, self.OnBattleStart)
end

function bs_20256:OnBattleStart()
  local maxCount = 6
  for i = 1, maxCount do
    x = self.config.pos[i][1]
    y = self.config.pos[i][2]
    self:CallSummonerOnPos(x, y)
  end
end

function bs_20256:CallSummonerOnPos(x, y)
  local summoner = LuaSkillCtrl:CreateSummoner(self, self.config.SummonnerId, x, y)
  summoner:SetAttr(eHeroAttr.maxHp, self.caster.maxHp * self.config.maxHpPer // 1000)
  summoner:SetAttr(eHeroAttr.pow, self.caster.pow * self.config.powPer // 1000)
  summoner:SetAttr(eHeroAttr.skill_intensity, self.caster.skill_intensity * self.config.skill_intensityPer // 1000)
  summoner:SetAttr(eHeroAttr.speed, self.caster.speed)
  summoner:SetAttr(eHeroAttr.def, self.caster.def * self.config.defPer // 1000)
  summoner:SetAttr(eHeroAttr.crit, self.caster.crit * self.config.critPer // 1000)
  summoner:SetAttr(eHeroAttr.critDamage, self.caster.critDamage * self.config.critDamagePer // 1000)
  summoner:SetAttr(eHeroAttr.sunder, self.caster.sunder * self.config.sunderPer // 1000)
  summoner:SetAttr(eHeroAttr.magic_res, self.caster.magic_res * self.config.magic_resPer // 1000)
  summoner:SetAttr(eHeroAttr.magic_pen, self.caster.magic_pen * self.config.magic_penPer // 1000)
  summoner:SetAsRealEntity(1)
  local summonerEntity = LuaSkillCtrl:AddSummonerRole(summoner)
end

function bs_20256:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_20256
