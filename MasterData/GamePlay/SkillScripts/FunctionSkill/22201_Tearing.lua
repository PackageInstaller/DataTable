local bs_22201 = class("bs_22201", LuaSkillBase)
local base = LuaSkillBase
bs_22201.config = {effectId = 12045}

function bs_22201:ctor()
end

function bs_22201:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.RoleDie, "bs_22201_11", 1, self.OnRoleDie)
  self.Timer = nil
end

function bs_22201:OnRoleDie(killer, role, killSkill)
  if role.belongNum == eBattleRoleBelong.enemy and role.roleType == eBattleRoleType.character and role.roleDataId ~= 1021058 and role.roleDataId ~= 1021059 and role.roleDataId ~= 30003 then
    local grid = LuaSkillCtrl:GetGridWithRole(role)
    if grid == nil then
      local grid = LuaSkillCtrl:CallFindEmptyGridNearest(role)
      if grid == nil then
        grid = LuaSkillCtrl:FindRoleRightEmptyGrid(role, 10)
      end
    end
    if grid ~= nil then
      LuaSkillCtrl:CallEffect(role, self.config.effectId, self)
      local maxHp = role.maxHp * self.arglist[1] // 1000
      local skill_intensity = role.skill_intensity * self.arglist[1] // 1000
      local pow = role.pow * self.arglist[1] // 1000
      local speed = role.speed
      local moveSpeed = role.moveSpeed
      local def = role.def * self.arglist[1] // 1000
      local magic_res = role.magic_res * self.arglist[1] // 1000
      local summoner = LuaSkillCtrl:CreateSummoner(self, role.roleDataId, grid.x, grid.y, eBattleRoleBelong.enemy)
      if summoner == nil then
        return
      end
      summoner:SetAttr(eHeroAttr.maxHp, maxHp)
      summoner:SetAttr(eHeroAttr.skill_intensity, skill_intensity)
      summoner:SetAttr(eHeroAttr.pow, pow)
      summoner:SetAttr(eHeroAttr.speed, speed)
      summoner:SetAttr(eHeroAttr.moveSpeed, moveSpeed)
      summoner:SetAttr(eHeroAttr.def, def)
      summoner:SetAttr(eHeroAttr.magic_res, magic_res)
      summoner:SetAsRealEntity(1)
      local summonerEntity = LuaSkillCtrl:AddSummonerRole(summoner)
    end
  end
end

function bs_22201:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_22201
