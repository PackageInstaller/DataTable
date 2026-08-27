local sixtower_aoe2 = class("sixtower_aoe2", LuaSkillBase)
local base = LuaSkillBase
sixtower_aoe2.config = {
  effectId = 12045,
  effectId_up = 501101,
  effectId_down = 501102,
  contain_table = {
    20004,
    20046,
    20070,
    20021,
    20048,
    20054,
    20009,
    20041,
    20049,
    20092,
    20091,
    20042,
    1000003,
    20082,
    20084,
    20085,
    20086,
    20089,
    20099,
    25019
  }
}

function sixtower_aoe2:ctor()
end

function sixtower_aoe2:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.RoleDie, "sixtower_aoe2_11", 1, self.OnRoleDie)
  self.Timer = nil
end

function sixtower_aoe2:IsContain(id)
  for _, v in ipairs(self.config.contain_table) do
    if v == id then
      return true
    end
  end
  return false
end

function sixtower_aoe2:OnRoleDie(killer, role, killSkill)
  if role.belongNum == eBattleRoleBelong.enemy and role.roleType == eBattleRoleType.character and self:IsContain(role.roleDataId) then
    LuaSkillCtrl:CallEffect(role, self.config.effectId, self)
    local role_table = {}
    role_table.maxHp = role.maxHp * self.arglist[1] // 1000
    role_table.skill_intensity = role.skill_intensity * self.arglist[1] // 1000
    role_table.pow = role.pow * self.arglist[1] // 1000
    role_table.speed = role.speed
    role_table.moveSpeed = role.moveSpeed
    role_table.def = role.def * self.arglist[1] // 1000
    role_table.magic_res = role.magic_res * self.arglist[1] // 1000
    local role_grid = {}
    role_grid.x = role.x
    role_grid.y = role.y
    for i = 0, self.arglist[3] - 1 do
      LuaSkillCtrl:StartTimer(nil, 7 * i, function()
        self:CastSummoner(role_grid.x, role_grid.y, role.roleDataId, eBattleRoleBelong.enemy, role_table)
      end)
    end
  end
end

function sixtower_aoe2:CastSummoner(x, y, summonerId, belongNum, attr_table)
  local attr
  if attr_table == nil then
    attr = self.config.attr_table
  else
    attr = attr_table
  end
  local isEmpty = LuaSkillCtrl:GetRoleWithPos(x, y)
  local grid_x = x
  local grid_y = y
  if isEmpty ~= nil then
    local grid = self:GetNeartestEmptyGridSafely(x, y)
    if grid == nil then
      return
    end
    grid_x, grid_y = grid.x, grid.y
  end
  local summoner = LuaSkillCtrl:CreateSummoner(self, summonerId, grid_x, grid_y, belongNum)
  for key, value in pairs(attr) do
    summoner:SetAttr(eHeroAttr[key], value)
  end
  summoner:SetAsRealEntity(1)
  local summonerEntity = LuaSkillCtrl:AddSummonerRole(summoner)
  return summonerEntity
end

function sixtower_aoe2:GetNeartestEmptyGridSafely(x, y)
  local grid
  local gridList = LuaSkillCtrl:FindEmptyGridsWithinRange(x, y, 1)
  if gridList == nil or 1 > gridList.Count then
    local gridList = LuaSkillCtrl:FindEmptyGridsWithinRange(x, y, 3)
  end
  if gridList == nil or 1 > gridList.Count then
    local gridList = LuaSkillCtrl:FindEmptyGridsWithinRange(x, y, 3)
  end
  if gridList ~= nil and gridList.Count > 0 then
    return gridList[0]
  else
    return nil
  end
end

function sixtower_aoe2:OnCasterDie()
  base.OnCasterDie(self)
end

return sixtower_aoe2
