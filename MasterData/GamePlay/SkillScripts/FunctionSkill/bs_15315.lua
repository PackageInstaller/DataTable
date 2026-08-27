local bs_15315 = class("bs_15315", LuaSkillBase)
local base = LuaSkillBase
bs_15315.config = {
  SummonerId = 1031,
  buffId = 2151,
  effectId_down = 501102,
  maxHpPer = 1000,
  powPer = 500,
  skill_intensityPer = 500,
  critPer = 1000,
  critDamagePer = 1000,
  defPer = 1000,
  sunderPer = 1000,
  magic_resPer = 1000,
  magic_penPer = 1000
}

function bs_15315:ctor()
end

function bs_15315:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddOnRoleDieTrigger("bs_15315_1", 1, self.OnRoleDie, nil, nil, nil, eBattleRoleBelong.player, nil, eBattleRoleType.realSummoner)
  self:AddLuaTrigger(eSkillLuaTrigger.OnSacrifice, self.OnSacrifice)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_15315_2", 1, self.OnAfterBattleStart)
  self.Count = 0
  self.Summoner = nil
  self.flag = false
end

function bs_15315:OnAfterBattleStart()
  local isNotEmpty = LuaSkillCtrl:GetRoleWithPos(3, 2)
  local grid = {3, 2}
  if isNotEmpty ~= nil then
    local targetGrid = LuaSkillCtrl:FindEmptyGrid()
    if targetGrid == nil then
      return
    end
    grid[1] = targetGrid.x
    grid[2] = targetGrid.y
  end
  LuaSkillCtrl:StartTimer(self, 1, BindCallback(self, self.CallSummoner, grid[0], grid[1]))
end

function bs_15315:OnSacrifice(killer, role)
  self:eventFunc(killer, role, true)
end

function bs_15315:OnRoleDie(killer, role)
  self:eventFunc(killer, role, false)
end

function bs_15315:eventFunc(killer, role, isSacrifice)
  self.flag = false
  if role.roleType ~= eBattleRoleType.realSummoner or role.roleDataId ~= self.config.SummonerId then
    return
  end
  local grid = LuaSkillCtrl:GetGridWithRole(role)
  if isSacrifice then
    LuaSkillCtrl:StartTimer(nil, 7, BindCallback(self, self.CallSummoner, grid.x, grid.y, isSacrifice))
  else
    LuaSkillCtrl:StartTimer(nil, self.arglist[1], BindCallback(self, self.CallSummoner, grid.x, grid.y, isSacrifice))
  end
end

function bs_15315:CallSummoner(GridX, GridY, isSacrifice)
  if self.flag == true then
    return
  end
  local role = LuaSkillCtrl:GetRoleWithPos(GridX, GridY)
  local x, y
  if role == nil then
    x, y = GridX, GridY
  else
    local emeptyGrid = LuaSkillCtrl:FindEmptyGrid()
    x, y = emeptyGrid.x, emeptyGrid.y
    if emeptyGrid == nil then
      return
    end
  end
  local summonerId = self.config.SummonerId
  if x == nil or y == nil then
    return
  end
  local master = self:findMaxRole()
  if master == nil then
    return
  end
  local summoner = LuaSkillCtrl:CreateSummoner(self, summonerId, x, y, eBattleRoleBelong.player)
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
  local target = LuaSkillCtrl:GetTargetWithGrid(x, y)
  LuaSkillCtrl:CallEffect(target, self.config.effectId_down, self)
  self.flag = true
end

function bs_15315:findMaxRole()
  local role, max = LuaSkillCtrl:CallFindMaxPowOrSkillIntensityRole()
  return role
end

function bs_15315:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_15315
