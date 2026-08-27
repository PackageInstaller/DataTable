local bs_15153 = class("bs_15153", LuaSkillBase)
local base = LuaSkillBase
bs_15153.config = {
  summonId = 1019,
  buffId = 2072,
  effectId = 12069
}

function bs_15153:ctor()
end

function bs_15153:InitSkill(isMidwaySkill)
  self:AddOnRoleDieTrigger("bs_15153_2", 10, self.OnRoleDie, nil, nil, nil, self.caster.belongNum, nil, eBattleRoleType.character)
end

function bs_15153:OnRoleDie(killer, role)
  if role.roleType ~= eBattleRoleType.character then
    return
  end
  local maxHp = role.maxHp * self.arglist[2] // 1000
  local x, y = role.x, role.y
  LuaSkillCtrl:StartTimer(self, 3, function()
    local summoner = LuaSkillCtrl:CreateSummoner(self, self.config.summonId, x, y, eBattleRoleBelong.player)
    if summoner == nil then
      return
    end
    summoner:SetAttr(eHeroAttr.maxHp, maxHp)
    summoner:SetAttr(eHeroAttr.skill_intensity, 0)
    summoner:SetAttr(eHeroAttr.pow, 0)
    summoner:SetAttr(eHeroAttr.speed, 0)
    summoner:SetAttr(eHeroAttr.moveSpeed, 0)
    summoner:SetAttr(eHeroAttr.def, self.arglist[2])
    summoner:SetAttr(eHeroAttr.dodge, 0)
    summoner:SetAsRealEntity(1)
    local summonerEntity = LuaSkillCtrl:AddSummonerRole(summoner)
    LuaSkillCtrl:CallBuff(self, summonerEntity, self.config.buffId, 1)
    LuaSkillCtrl:CallEffect(summonerEntity, self.config.effectId, self)
  end)
end

function bs_15153:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_15153
