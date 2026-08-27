local bs_31007 = class("bs_31007", LuaSkillBase)
local base = LuaSkillBase
bs_31007.config = {
  summonerId = 93,
  buffId = 2227,
  maxHp_per = 1000,
  def_per = 1000
}

function bs_31007:ctor()
end

function bs_31007:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_31007", 50, self.OnAfterBattleStart)
  self.isHasSecond = false
  self.isCanGrow = false
  self.master = nil
  if self.caster.recordTable.bs_31008 ~= nil then
    self.isHasSecond = true
  end
  if self.caster.recordTable.bs_31009 ~= nil then
    self.isCanGrow = true
  end
end

function bs_31007:OnAfterBattleStart()
  local list = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
  self.master = list[0]
  for i = 0, list.Count - 1 do
    if list[i].skill_intensity > self.master.skill_intensity then
      self.master = list[i]
    end
  end
  self.timer = LuaSkillCtrl:StartTimer(nil, 7, function()
    self:CallSummoner()
    if self.isHasSecond then
      self:CallSummoner()
    end
  end)
end

function bs_31007:CallSummoner()
  local target
  local pre_checkList = {
    {0, 2},
    {6, 2},
    {5, 2},
    {1, 2}
  }
  for _, grid in ipairs(pre_checkList) do
    local entity = LuaSkillCtrl:GetRoleWithPos(grid[1], grid[2])
    if entity ~= nil and entity.belongNum == eBattleRoleBelong.neutral and 0 < entity:GetBuffTier(88) and entity.roleType ~= eBattleRoleType.realSummoner then
      target = entity
      break
    end
  end
  if target == nil then
    local list = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.neutral)
    for i = list.Count - 1, 0, -1 do
      if 0 < list[i]:GetBuffTier(88) then
        target = list[i]
        break
      end
    end
  end
  local grid_x, grid_y
  if target ~= nil then
    grid_x = target.x
    grid_y = target.y
    LuaSkillCtrl:DispelBuff(target, 88, 1, true, false)
    LuaSkillCtrl:RemoveLife(target.maxHp + 1, self, target, true, nil, false, true, nil, nil)
  else
    local grid = LuaSkillCtrl:FindEmptyGrid()
    if grid == nil then
      return
    end
    grid_x = grid.x
    grid_y = grid.y
  end
  local summoner = LuaSkillCtrl:CreateSummoner(self, self.config.summonerId, grid_x, grid_y, eBattleRoleBelong.neutral)
  summoner:SetAttr(eHeroAttr.maxHp, self.master.maxHp * self.config.maxHp_per // 1000)
  summoner:SetAttr(eHeroAttr.skill_intensity, self.master.skill_intensity * self.config.def_per // 1000)
  summoner:SetAsRealEntity(1)
  local summonerEntity = LuaSkillCtrl:AddSummonerRole(summoner)
  if self.isCanGrow then
    summonerEntity.recordTable.ShootCount = self.caster.recordTable.bs_31009
  end
  LuaSkillCtrl:CallEffect(summonerEntity, 70001, self)
end

function bs_31007:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_31007
