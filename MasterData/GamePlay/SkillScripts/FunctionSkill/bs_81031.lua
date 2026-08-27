local bs_81031 = class("bs_81031", LuaSkillBase)
local base = LuaSkillBase
bs_81031.config = {
  SummonerId = 1017,
  SUmmonerId_gaoda = 1000,
  buffId = 2167,
  buffId_Taunt = 3002,
  effectId = 12024,
  effectId_start = 5002205,
  effectIdDie = 12116,
  effectId_down = 10936,
  effectId_cd = 12075,
  maxHpPer = 1000,
  powPer = 300,
  skill_intensityPer = 300,
  critPer = 0,
  critDamagePer = 0,
  defPer = 1000,
  sunderPer = 1000,
  magic_resPer = 1000,
  magic_penPer = 1000,
  equipmentSummonerId = 1000
}

function bs_81031:ctor()
end

function bs_81031:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddOnRoleDieTrigger("bs_81031", 2, self.OnRoleDie, nil, nil, nil, eBattleRoleBelong.player, nil, eBattleRoleType.realSummoner)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_81031", 1, self.OnAfterBattleStart)
  self.maxCount = 1
  self.Count = 0
  self.table = {}
end

function bs_81031:OnAfterBattleStart()
  self:doSummon()
  self.timer = LuaSkillCtrl:StartTimer(nil, self.arglist[1], BindCallback(self, self.doSummon), nil, -1, 0)
end

function bs_81031:doSummon()
  if self.Count < self.maxCount then
    self:Summoner()
  end
end

function bs_81031:Summoner()
  local grid = LuaSkillCtrl:CallFindEmptyGridMostRolesArounded(eBattleRoleBelong.enemy)
  local GridX, GridY
  if grid == nil then
    grid = LuaSkillCtrl:FindEmptyGrid()
  end
  if grid == nil then
    return
  end
  GridX, GridY = grid.x, grid.y
  local target = LuaSkillCtrl:GetTargetWithGrid(GridX, GridY)
  LuaSkillCtrl:CallEffect(target, self.config.effectId_down, self)
  local role = LuaSkillCtrl:GetRoleWithPos(GridX, GridY)
  local x, y
  if role == nil then
    x, y = GridX, GridY
  else
    local emptyGrid = LuaSkillCtrl:CallFindEmptyGridNearest(role)
    if emptyGrid ~= nil then
      x, y = emptyGrid.x, emptyGrid.y
    end
  end
  if x == nil or y == nil then
    return
  end
  local master = self:findMaxRole()
  if master == nil then
    return
  end
  local summoner = LuaSkillCtrl:CreateSummoner(self, self.config.SummonerId, x, y, eBattleRoleBelong.player)
  summoner:SetAttr(eHeroAttr.maxHp, master.maxHp * self.config.maxHpPer // 1000)
  summoner:SetAttr(eHeroAttr.pow, master.pow * self.config.powPer // 1000)
  summoner:SetAttr(eHeroAttr.skill_intensity, master.skill_intensity * self.config.skill_intensityPer // 1000)
  summoner:SetAttr(eHeroAttr.speed, master.speed)
  summoner:SetAttr(eHeroAttr.def, master.def * self.config.defPer // 1000)
  summoner:SetAttr(eHeroAttr.crit, master.crit * self.config.critPer // 1000)
  summoner:SetAttr(eHeroAttr.critDamage, master.critDamage * self.config.critDamagePer // 1000)
  summoner:SetAttr(eHeroAttr.sunder, master.sunder * self.config.sunderPer // 1000)
  summoner:SetAttr(eHeroAttr.magic_res, master.magic_res * self.config.magic_resPer // 1000)
  summoner:SetAttr(eHeroAttr.magic_pen, master.magic_pen * self.config.magic_penPer // 1000)
  summoner:SetAsRealEntity(1)
  local summonerEntity = LuaSkillCtrl:AddSummonerRole(summoner)
  LuaSkillCtrl:CallEffect(summonerEntity, self.config.effectId_start, self)
  self.Count = self.Count + 1
  self.table[self.Count] = summonerEntity
  local enemylist = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.enemy)
  for i = 0, enemylist.Count - 1 do
    local enemyRole = enemylist[i]
    if LuaSkillCtrl:GetGridsDistance(summonerEntity.x, summonerEntity.y, enemyRole.x, enemyRole.y) <= 2 then
      LuaSkillCtrl:CallBuff(self, enemyRole, self.config.buffId_Taunt, 1, self.arglist[3], false, summonerEntity)
    end
  end
end

function bs_81031:OnRoleDie(killer, role)
  if role.roleDataId ~= self.config.SummonerId then
    return
  end
  self.Count = self.Count - 1
  local playerList = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
  local target = LuaSkillCtrl:GetTargetWithGrid(3, 2)
  LuaSkillCtrl:CallEffect(target, self.config.effectIdDie, self)
  for i = 0, playerList.Count - 1 do
    if playerList[i].roleType == eBattleRoleType.character then
      LuaSkillCtrl:CallBuff(self, playerList[i], self.config.buffId, 1, self.arglist[4], true)
    end
  end
end

function bs_81031:findMaxRole()
  local role
  local roleList = LuaSkillCtrl:CallTargetSelect(self, 69, 10)
  if roleList.Count > 0 then
    role = roleList[0].targetRole
  end
  return role
end

function bs_81031:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_81031
