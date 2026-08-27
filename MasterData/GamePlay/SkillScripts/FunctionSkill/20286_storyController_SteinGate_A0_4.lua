local bs_20286 = class("bs_20286", LuaSkillBase)
local base = LuaSkillBase
bs_20286.config = {
  GridList = {
    {2, 0},
    {2, 1},
    {3, 2},
    {2, 3},
    {2, 4},
    {3, 0},
    {3, 1},
    {4, 2},
    {3, 3},
    {3, 4}
  },
  ThisGridList = {
    {
      {5, 0},
      {4, 1},
      {4, 2},
      {4, 3},
      {5, 4}
    },
    {
      {4, 0},
      {3, 1},
      {3, 2},
      {3, 3},
      {4, 4}
    },
    {
      {3, 0},
      {2, 1},
      {2, 2},
      {2, 3},
      {3, 4}
    }
  },
  UnBreakList = {
    {0, 0},
    {0, 1},
    {1, 2},
    {0, 3},
    {0, 4}
  },
  wallId = 68,
  effectId_up = 501101,
  effectId_down = 501102,
  AOE_effect = 10853,
  Attack_effect = 10295,
  buffId = 2175,
  BossId = 20002,
  pfId = 1001080,
  maxHpPer = 150,
  powPer = 700,
  skill_intensityPer = 700,
  critPer = 1000,
  critDamagePer = 1000,
  defPer = 1000,
  sunderPer = 1000,
  magic_resPer = 1000,
  magic_penPer = 1000,
  unCommonATK = 2172,
  unAutoSkill = 2173,
  unULTSKill = 2174,
  unMove = 2175,
  xuan_yun = 2176
}

function bs_20286:ctor()
end

function bs_20286:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.timer = LuaSkillCtrl:StartTimer(nil, 30, BindCallback(self, self.TimerCallBack), nil, -1, 15)
  self.endTimer = LuaSkillCtrl:StartTimer(nil, 225, BindCallback(self, self.EndPerform))
  self.Boss = nil
  self:findBoss()
  self.pf = LuaSkillCtrl:GetRoleWithPos(0, 2)
  LuaSkillCtrl:CallBuff(self, self.pf, 2205, 1, nil, true, nil, false)
  self:ControlRole(self.pf)
  self:FirstCall()
end

function bs_20286:findBoss()
  local eList = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.enemy)
  for i = 0, eList.Count - 1 do
    LuaSkillCtrl:CallBuff(self, eList[i], self.config.buffId, 1, nil, true, eList[i], false)
    if eList[i].roleDataId == self.config.BossId then
      self.Boss = eList[i]
      self:ControlRole(self.Boss)
    end
  end
end

function bs_20286:FirstCall()
  for _, grid in ipairs(self.config.GridList) do
    self:ItemBorn(self.config.wallId, grid[1], grid[2])
  end
end

function bs_20286:TimerCallBack()
  local to_buildArea = {}
  for _, grid in ipairs(self.config.GridList) do
    local notEmpty = LuaSkillCtrl:GetRoleWithPos(grid[1], grid[2])
    if notEmpty == nil then
      to_buildArea[#to_buildArea + 1] = grid
    end
  end
  LuaSkillCtrl:StartTimer(nil, 30, function()
    LuaSkillCtrl:CallEffect(self.pf, 12075, self)
    for _, grid in ipairs(to_buildArea) do
      self:ItemBorn(self.config.wallId, grid[1], grid[2])
    end
  end)
end

function bs_20286:EndPerform()
  LuaSkillCtrl:StartAvgWithPauseGame(nil, 45001190, BindCallback(self, self.EndPerform_1))
end

function bs_20286:EndPerform_1()
  self:timeSet(1)
  if self.timer ~= nil then
    self.timer:Stop()
    self.timer = nil
  end
  local grid = LuaSkillCtrl:GetGridWithPos(3, 2)
  local gridRole = LuaSkillCtrl:GetRoleWithPos(3, 2)
  if gridRole ~= nil then
    LuaSkillCtrl:RemoveLife(9999, self, gridRole, true, nil, true, true)
  end
  LuaSkillCtrl:CallEffect(self.Boss, self.config.effectId_up, self)
  LuaSkillCtrl:StartTimer(nil, 7, function()
    LuaSkillCtrl:CallBattleCamShakeByParam(0, 1, 1, 50)
    local grid = LuaSkillCtrl:GetGridWithPos(3, 2)
    LuaSkillCtrl:SetRolePos(grid, self.Boss, true)
    LuaSkillCtrl:CallEffect(self.Boss, 601, self)
  end)
  LuaSkillCtrl:StartTimer(nil, 17, BindCallback(self, self.killAll))
end

function bs_20286:killAll()
  LuaSkillCtrl:CallBattleCamShakeByParam(0, 1, 1, 50)
  self.Boss:LookAtTarget(self.pf)
  self:timeSet(1)
  for key, grids in ipairs(self.config.ThisGridList) do
    LuaSkillCtrl:StartTimer(nil, 7 * key, function()
      LuaSkillCtrl:CallBattleCamShakeByParam(0, 1, 1, 50)
      for _, grid in ipairs(grids) do
        local target = LuaSkillCtrl:GetTargetWithGrid(grid[1], grid[2])
        LuaSkillCtrl:CallEffect(target, 601, self)
        if not LuaSkillCtrl.IsInVerify then
          AudioManager:PlayAudioById(207705)
        end
        local role = LuaSkillCtrl:GetRoleWithPos(grid[1], grid[2])
        if role ~= nil and role.belongNum ~= eBattleRoleBelong.enemy then
          LuaSkillCtrl:RemoveLife(99999, self, role)
        end
      end
    end, nil, nil, 7)
  end
  LuaSkillCtrl:StartTimer(nil, 30, function()
    LuaSkillCtrl:CallRoleAction(self.Boss, 1004, 1)
  end)
  LuaSkillCtrl:StartTimer(nil, 40, function()
    for _, wall in ipairs(self.config.UnBreakList) do
      local role = LuaSkillCtrl:GetRoleWithPos(wall[1], wall[2])
      LuaSkillCtrl:DispelBuff(role, 175, 1, true, true)
      LuaSkillCtrl:DispelBuff(role, 198, 1, true, true)
      LuaSkillCtrl:DispelBuff(role, 88, 1, true, true)
      LuaSkillCtrl:CallEffect(role, 10866, self, nil, role)
      LuaSkillCtrl:RemoveLife(99999, self, role)
      AudioManager:PlayAudioById(213310)
      LuaSkillCtrl:CallBattleCamShakeByParam(0, 1, 2, 50)
    end
  end)
  LuaSkillCtrl:StartTimer(nil, 45, function()
    LuaSkillCtrl:CallRoleAction(self.pf, 1058, 1)
  end)
  LuaSkillCtrl:StartTimer(nil, 85, function()
    LuaSkillCtrl:StartAvgWithPauseGame(nil, 45001191, BindCallback(self, self.end_game))
  end)
end

function bs_20286:end_game()
  LuaSkillCtrl:ForceEndBattle(true)
end

function bs_20286:timeSet(value)
  if not LuaSkillCtrl.IsInVerify then
    self.uiBattle = UIManager:GetWindow(UIWindowTypeID.Battle)
    if self.uiBattle ~= nil then
      self.uiBattle:OnSpeedUpChange(value)
    end
  end
end

function bs_20286:ItemBorn(ItemId, grid_x, grid_y)
  local summonerId = ItemId
  local x = grid_x
  local y = grid_y
  local notEmpty = LuaSkillCtrl:GetRoleWithPos(x, y)
  if notEmpty ~= nil then
    return
  end
  local summoner = LuaSkillCtrl:CreateSummoner(self, summonerId, x, y, eBattleRoleBelong.neutral)
  summoner:SetAttr(eHeroAttr.maxHp, 200)
  summoner:SetAsRealEntity(1)
  local summonerEntity = LuaSkillCtrl:AddSummonerRole(summoner)
  local target = LuaSkillCtrl:GetTargetWithGrid(x, y)
  LuaSkillCtrl:CallEffect(target, self.config.effectId_down, self)
end

function bs_20286:ControlRole(role)
  LuaSkillCtrl:CallBuff(self, role, self.config.unULTSKill, 1, nil, true)
  LuaSkillCtrl:CallBuff(self, role, self.config.unCommonATK, 1, nil, true)
  LuaSkillCtrl:CallBuff(self, role, self.config.unAutoSkill, 1, nil, true)
  LuaSkillCtrl:CallBuff(self, role, self.config.xuan_yun, 1, nil, true)
end

function bs_20286:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_20286
