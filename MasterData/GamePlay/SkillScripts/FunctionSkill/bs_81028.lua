local bs_81028 = class("bs_81028", LuaSkillBase)
local base = LuaSkillBase
bs_81028.config = {
  SummonerId = 1017,
  SUmmonerId_gaoda = 1000,
  buffId = 2153,
  buffId_Taunt = 3002,
  effectId = 12024,
  effectId_start = 5002205,
  effectIdDie = 12116,
  effectId_down = 10936,
  effectId_cd = 12075,
  maxHpPer = 400,
  powPer = 500,
  skill_intensityPer = 500,
  critPer = 0,
  critDamagePer = 0,
  defPer = 2000,
  sunderPer = 1000,
  magic_resPer = 2000,
  magic_penPer = 1000,
  equipmentSummonerId = 1000
}

function bs_81028:ctor()
end

function bs_81028:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddOnRoleDieTrigger("bs_81028", 1, self.OnRoleDie, nil, nil, nil, eBattleRoleBelong.player, nil, eBattleRoleType.realSummoner)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_81028", 1, self.OnAfterBattleStart)
  self.Summoner = nil
  self.timer = LuaSkillCtrl:StartTimer(nil, self.arglist[2], function()
    if self.Summoner ~= nil then
      LuaSkillCtrl:RemoveLife(999999, self, self.Summoner, true, nil, true, true, eHurtType.RealDmg, true)
    end
  end)
end

function bs_81028:OnAfterBattleStart()
  local grid = LuaSkillCtrl:CallFindEmptyGridMostRolesArounded(eBattleRoleBelong.enemy)
  local hasRole = LuaSkillCtrl:GetTargetWithGrid(grid.x, grid.y)
  local x, y
  if grid == nil then
    grid = LuaSkillCtrl:FindEmptyGrid()
  end
  if grid == nil then
    return
  end
  x, y = grid.x, grid.y
  local target = LuaSkillCtrl:GetTargetWithGrid(x, y)
  LuaSkillCtrl:CallEffect(target, self.config.effectId_down, self)
  LuaSkillCtrl:StartTimer(self, 1, BindCallback(self, self.CallSummoner, x, y))
end

function bs_81028:CallSummoner(GridX, GridY)
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
  local enemylist = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.enemy)
  for i = 0, enemylist.Count - 1 do
    local enemyRole = enemylist[i]
    if LuaSkillCtrl:GetGridsDistance(summonerEntity.x, summonerEntity.y, enemyRole.x, enemyRole.y) <= 2 then
      LuaSkillCtrl:CallBuff(self, enemyRole, self.config.buffId_Taunt, 1, self.arglist[4], false, summonerEntity)
    end
  end
  self.timer = LuaSkillCtrl:StartTimer(nil, self.arglist[2], function()
    if summonerEntity ~= nil then
      LuaSkillCtrl:RemoveLife(999999, self, summonerEntity, true, nil, true, true, eHurtType.RealDmg, true)
    end
  end)
end

function bs_81028:OnRoleDie(killer, role)
  if role.roleDataId ~= self.config.SummonerId then
    return
  end
  local playerList = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
  local target = LuaSkillCtrl:GetTargetWithGrid(3, 2)
  LuaSkillCtrl:CallEffect(target, self.config.effectIdDie, self)
  for i = 0, playerList.Count - 1 do
    if playerList[i].roleType == eBattleRoleType.character then
      LuaSkillCtrl:CallBuff(self, playerList[i], self.config.buffId, 1, nil, true)
    end
  end
end

function bs_81028:AddMp(role)
  LuaSkillCtrl:CallEffect(role, self.config.effectId_cd, self)
  local skills = role:GetBattleSkillList()
  if skills ~= nil then
    local skillCount = skills.Count
    if 0 < skillCount then
      for j = 0, skillCount - 1 do
        local curTotalCd = skills[j].totalCDTime * self.arglist[3] // 1000
        if not skills[j].isCommonAttack then
          LuaSkillCtrl:CallResetCDForSingleSkill(skills[j], curTotalCd)
        end
      end
    end
  end
end

function bs_81028:findMaxRole()
  local role
  local roleList = LuaSkillCtrl:CallTargetSelect(self, 69, 10)
  if roleList.Count > 0 then
    role = roleList[0].targetRole
  end
  return role
end

function bs_81028:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_81028
