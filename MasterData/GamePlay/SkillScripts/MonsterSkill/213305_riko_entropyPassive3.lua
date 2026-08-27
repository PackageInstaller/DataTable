local bs_213305 = class("bs_213305", LuaSkillBase)
local base = LuaSkillBase
bs_213305.config = {effect_turn = 203306, monsterId = 81}

function bs_213305:ctor()
end

function bs_213305:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_213305_1", 1, self.OnAfterHurt, nil, self.caster, nil, nil, nil, nil, nil)
end

function bs_213305:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, isRealDmg, isTriggerSet)
  if self.caster.hp <= self.caster.maxHp * self.arglist[1] // 1000 then
    LuaSkillCtrl:StartAvgWithPauseGame(nil, 45001112, nil)
    self:RedayforSummon()
  end
end

function bs_213305:RedayforSummon()
  LuaSkillCtrl:CallBreakAllSkill(self.caster)
  LuaSkillCtrl:SetGameObjectActive(self.caster.lsObject, false)
  LuaSkillCtrl:RemoveLife(self.caster.hp, self, self.caster, true, nil, false, true, eHurtType.RealDmg, true)
end

function bs_213305:Summon()
  local Grid = LuaSkillCtrl:GetGridWithRole(self.caster)
  if Grid ~= nil then
    local target = LuaSkillCtrl:GetTargetWithGrid(Grid.x, Grid.y)
    LuaSkillCtrl:CallEffect(target, self.config.effect_turn, self)
    local summoner
    Grid.role = nil
    summoner = LuaSkillCtrl:CreateSummoner(self, self.config.monsterId, Grid.x, Grid.y)
    summoner:SetAttr(eHeroAttr.maxHp, self.caster.maxHp)
    summoner:SetAttr(eHeroAttr.pow, self.caster.pow)
    summoner:SetAttr(eHeroAttr.skill_intensity, self.caster.skill_intensity)
    summoner:SetAttr(eHeroAttr.speed, self.caster.speed)
    summoner:SetAttr(eHeroAttr.moveSpeed, self.caster.moveSpeed)
    summoner:SetAttr(eHeroAttr.def, self.caster.def)
    summoner:SetAttr(eHeroAttr.magic_res, self.caster.magic_res)
    summoner:SetAttr(eHeroAttr.lucky, self.caster.lucky)
    summoner:SetAttr(eHeroAttr.sunder, self.caster.sunder)
    summoner:SetAttr(eHeroAttr.magic_pen, self.caster.magic_pen)
    summoner:SetAttr(eHeroAttr.dodge, self.caster.dodge)
    summoner:SetAttr(eHeroAttr.crit, self.caster.crit)
    summoner:SetAttr(eHeroAttr.critDamage, self.caster.critDamage)
    summoner:SetAttr(eHeroAttr.damage_increase, self.caster.damage_increase)
    summoner:SetAttr(eHeroAttr.injury_reduce, self.caster.injury_reduce)
    summoner:SetAttr(eHeroAttr.resistance, self.caster.resistance)
    summoner:SetAttr(eHeroAttr.cd_reduce, self.caster.cd_reduce)
    summoner:SetAsRealEntity(1)
    LuaSkillCtrl:AddSummonerRole(summoner)
  end
end

function bs_213305:OnCasterDie()
  LuaSkillCtrl:SetRoleVisible(self.caster, false)
  self:Summon()
  base.OnCasterDie(self)
end

return bs_213305
