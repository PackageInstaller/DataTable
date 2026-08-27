local bs_25282 = class("bs_25282", LuaSkillBase)
local base = LuaSkillBase
bs_25282.config = {summonId = 1022}

function bs_25282:ctor()
end

function bs_25282:InitSkill(isMidwaySkill)
  self:AddOnRoleDieTrigger("bs_25282_1", 10, self.OnRoleDie, nil, nil, nil, self.caster.belongNum)
end

function bs_25282:OnRoleDie(killer, role)
  if role.roleDataId == self.config.summonId and role.roleType == eBattleRoleType.realSummoner then
    return
  end
  local x, y = role.x, role.y
  LuaSkillCtrl:StartTimer(nil, 3, function()
    local summoner = LuaSkillCtrl:CreateSummoner(self, self.config.summonId, x, y, eBattleRoleBelong.player)
    if summoner == nil then
      local grid = LuaSkillCtrl:FindEmptyGridsWithinRange(x, y, 2)
      x = grid.x
      y = grid.y
      summoner = LuaSkillCtrl:CreateSummoner(self, self.config.summonId, x, y, eBattleRoleBelong.player)
    end
    summoner:SetAttr(eHeroAttr.maxHp, role.maxHp)
    summoner:SetAttr(eHeroAttr.skill_intensity, role.skill_intensity)
    summoner:SetAttr(eHeroAttr.pow, role.pow)
    summoner:SetAttr(eHeroAttr.speed, role.speed)
    summoner:SetAttr(eHeroAttr.moveSpeed, role.movespeed)
    summoner:SetAttr(eHeroAttr.def, 0)
    summoner:SetAttr(eHeroAttr.dodge, 0)
    summoner:SetAsRealEntity(1)
    local summonerEntity = LuaSkillCtrl:AddSummonerRole(summoner)
  end)
end

function bs_25282:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_25282
