local bs_15150 = class("bs_15150", LuaSkillBase)
local base = LuaSkillBase
bs_15150.config = {
  summonId = 1020,
  pfId = 116,
  buffId = 3002,
  buffId_CF = 2072,
  effectId = 12069
}

function bs_15150:ctor()
end

function bs_15150:InitSkill(isMidwaySkill)
  self:AddAfterHurtTrigger("bs_15150_1", 1, self.OnAfterHurt)
  self.lastHpPercent = 100
end

function bs_15150:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if target.roleDataId == self.config.pfId and not isMiss then
    local nowHpPercent = target.hp * 100 // target.maxHp
    local diff = self.lastHpPercent - nowHpPercent
    if diff > self.arglist[1] // 10 then
      local diffBiLi = diff * 10 // self.arglist[1]
      local grid = LuaSkillCtrl:CallFindEmptyGridNearest(sender)
      local summoner = LuaSkillCtrl:CreateSummoner(self, self.config.summonId, grid.x, grid.y, eBattleRoleBelong.player)
      if summoner == nil then
        return
      end
      local maxHp = target.maxHp * self.arglist[2] // 1000
      local skill_intensity = 0
      local pow = 0
      local speedmaxHp = 0
      local moveSpeed = 0
      local def = self.arglist[3]
      local dodge = 0
      summoner:SetAttr(eHeroAttr.maxHp, maxHp)
      summoner:SetAttr(eHeroAttr.skill_intensity, skill_intensity)
      summoner:SetAttr(eHeroAttr.pow, pow)
      summoner:SetAttr(eHeroAttr.speed, 0)
      summoner:SetAttr(eHeroAttr.moveSpeed, 0)
      summoner:SetAttr(eHeroAttr.def, def)
      summoner:SetAttr(eHeroAttr.dodge, dodge)
      summoner:SetAsRealEntity(1)
      local summonerEntity = LuaSkillCtrl:AddSummonerRole(summoner)
      LuaSkillCtrl:CallBuff(self, summonerEntity, self.config.buffId_CF, 1)
      LuaSkillCtrl:CallEffect(summonerEntity, self.config.effectId, self)
      self.lastHpPercent = target.hp * 100 // target.maxHp
    end
  end
end

function bs_15150:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_15150
