local bs_70031 = class("bs_70031", LuaSkillBase)
local base = LuaSkillBase
bs_70031.config = {
  monsterId = {
    39,
    40,
    41
  },
  effectId = 10264,
  annaMaxHpPer = 200,
  annaPowPer = 600,
  annaIntPer = 600,
  anaSpeed = 1500,
  betyMaxHpPer = 250,
  betyPowPer = 2000,
  betyIntPer = 500,
  betySpeed = 1000,
  boneMaxHpPer = 400,
  bonePowPer = 500,
  boneIntPer = 2000,
  boneSpeed = 1000
}

function bs_70031:ctor()
end

function bs_70031:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.index = 1
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_70031_1", 999, self.OnAfterBattleStart)
  LuaSkillCtrl:RegisterRoleHpCostEvent(self, self.caster, {
    900,
    800,
    700,
    600,
    500,
    400,
    300,
    200,
    100
  }, self.OnHpSubCost, false)
end

function bs_70031:OnHpSubCost(curHp, TargetValue)
  if curHp < self.caster.maxHp * 200 // 1000 then
    self:OnSummon()
    self:OnSummon()
    self:OnSummon()
  elseif curHp < self.caster.maxHp * 500 // 1000 then
    self:OnSummon()
    self:OnSummon()
  else
    self:OnSummon()
  end
end

function bs_70031:OnAfterBattleStart()
  self:OnSummon()
end

function bs_70031:OnSummon()
  local gridData = LuaSkillCtrl:CallFindEmptyGridNearest(self.caster)
  if gridData == nil then
    return
  end
  local target = LuaSkillCtrl:GetTargetWithGrid(gridData.x, gridData.y)
  LuaSkillCtrl:CallEffect(target, self.config.effectId, self)
  if self.index > 3 then
    self.index = 1
  end
  local cskill = self.caster.recordTable.CasterSkill or self.cskill
  local summoner = LuaSkillCtrl:CreateSummonerWithCSkill(cskill, self.config.monsterId[self.index], gridData.x, gridData.y)
  if self.index == 1 then
    summoner:SetAttr(eHeroAttr.maxHp, self.caster.maxHp * self.config.annaMaxHpPer // 1000)
    summoner:SetAttr(eHeroAttr.pow, self.caster.pow * self.config.annaPowPer // 1000)
    summoner:SetAttr(eHeroAttr.skill_intensity, self.caster.skill_intensity * self.config.annaIntPer // 1000)
    summoner:SetAttr(eHeroAttr.speed, self.caster.speed * self.config.anaSpeed // 1000)
  elseif self.index == 2 then
    summoner:SetAttr(eHeroAttr.maxHp, self.caster.maxHp * self.config.betyMaxHpPer // 1000)
    summoner:SetAttr(eHeroAttr.pow, self.caster.pow * self.config.betyPowPer // 1000)
    summoner:SetAttr(eHeroAttr.skill_intensity, self.caster.skill_intensity * self.config.betyIntPer // 1000)
    summoner:SetAttr(eHeroAttr.speed, self.caster.speed * self.config.betySpeed // 1000)
  elseif self.index == 3 then
    summoner:SetAttr(eHeroAttr.maxHp, self.caster.maxHp * self.config.boneMaxHpPer // 1000)
    summoner:SetAttr(eHeroAttr.pow, self.caster.pow * self.config.bonePowPer // 1000)
    summoner:SetAttr(eHeroAttr.skill_intensity, self.caster.skill_intensity * self.config.boneIntPer // 1000)
    summoner:SetAttr(eHeroAttr.speed, self.caster.speed * self.config.boneSpeed // 1000)
  else
    summoner:SetAttr(eHeroAttr.maxHp, self.caster.maxHp * self.config.annaMaxHpPer // 1000)
    summoner:SetAttr(eHeroAttr.pow, self.caster.pow * self.config.annaPowPer // 1000)
    summoner:SetAttr(eHeroAttr.skill_intensity, self.caster.skill_intensity * self.config.annaIntPer // 1000)
    summoner:SetAttr(eHeroAttr.speed, self.caster.speed * self.config.anaSpeed // 1000)
  end
  summoner:SetAsRealEntity(1)
  local table = {CasterSkill = cskill}
  summoner:SetRecordTable(table)
  local summonerEntity = LuaSkillCtrl:AddSummonerRole(summoner)
  self.index = self.index + 1
end

function bs_70031:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_70031
