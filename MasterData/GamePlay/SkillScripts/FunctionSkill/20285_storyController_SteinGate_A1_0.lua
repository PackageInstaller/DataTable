local bs_20285 = class("bs_20285", LuaSkillBase)
local base = LuaSkillBase
bs_20285.config = {
  flag_1 = 1,
  summonerId = 85,
  call_duration = 75,
  WuPaId = 1001079,
  ReplaceWuPaId = 2135,
  flag_2 = 2,
  gridId = 10,
  gridId_truth = 34,
  call_duration = 45,
  effcetId = 10,
  special_room = 1180157,
  special_buff = 66,
  CameraEffectDegree = 0.6,
  AvgList = {
    4500117,
    4500117,
    4500117
  },
  JumpGrids = {
    {1, 2},
    {3, 1},
    {4, 1}
  },
  JumpEffect1 = 501101,
  JumpEffect2 = 501102,
  sp_gridList = {},
  sp_summList = {},
  maxHpPer = 100,
  powPer = 1000,
  skill_intensityPer = 1000,
  critPer = 1000,
  critDamagePer = 1000,
  defPer = 1000,
  sunderPer = 1000,
  magic_resPer = 1000,
  magic_penPer = 1000,
  effect_onCallSummoner = 501101,
  effect_corrode = 12118,
  effect_onCall = 12044,
  unCommonATK = 2172,
  unAutoSkill = 2173,
  unULTSKill = 2174,
  unMove = 2175,
  xuan_yun = 2176,
  coordList = {
    {
      {1, 2}
    },
    {
      {0, 2},
      {0, 1},
      {1, 1},
      {2, 2},
      {1, 3},
      {0, 3}
    },
    {
      {0, 0},
      {1, 0},
      {2, 0},
      {0, 4},
      {1, 4},
      {2, 4},
      {2, 1},
      {3, 2},
      {2, 3}
    },
    {
      {3, 0},
      {3, 1},
      {4, 2},
      {3, 3},
      {3, 4}
    },
    {
      {4, 0},
      {4, 1},
      {5, 2},
      {4, 3},
      {4, 4}
    },
    {
      {5, 0},
      {5, 1},
      {6, 2},
      {5, 3},
      {5, 4}
    },
    {
      {6, 0},
      {6, 4}
    }
  },
  effect_connect = 211900,
  grid_list = {
    {2, 0},
    {1, 0},
    {0, 2},
    {1, 3},
    {0, 4},
    {3, 4}
  }
}

function bs_20285:ctor()
end

function bs_20285:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddLuaTrigger(eSkillLuaTrigger.StoryEvent, self.OnStoryEvent)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_20285", 1, self.OnBattleStart)
  self.roomID = LuaSkillCtrl:GetBattleRoomId()
  self.timerList = {}
  self.GridPoint = 1
end

function bs_20285:OnBattleStart()
  self.Mayuri = nil
  local pList = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
  for i = 0, pList.Count - 1 do
    if pList[i].roleDataId == 1077 then
      self.Mayuri = pList[i]
    end
  end
  self.gridList = {}
  if self.roomID == self.config.special_room then
    self:special_perform()
  end
  if self.roomID == 1180152 then
    self:opening_perform()
  end
  if self.roomID >= 1180153 and self.roomID ~= self.config.special_room then
    for i = 1, 3 do
      self:CallSummoner()
    end
    self:add_timer(self.config.call_duration, BindCallback(self, self.CallSummoner))
  end
  if self.roomID >= 1180154 and self.roomID ~= self.config.special_room then
    self:add_timer(self.config.call_duration, BindCallback(self, self.CallGrids))
  end
end

function bs_20285:MuteUlt(self)
  if not LuaSkillCtrl.IsInVerify then
    self.win = UIManager:ShowWindow(UIWindowTypeID.Battle)
    if self.win ~= nil then
      self.win:SetUltAuto(false)
    end
  end
  local costurlnum = 0 - LuaSkillCtrl:GetUltHMp()
  LuaSkillCtrl:CallAddPlayerHmp(costurlnum)
  if self.timer_HMP ~= nil then
    self.timer_HMP:Stop()
    self.timer_HMP = nil
  end
end

function bs_20285:timeSet(value)
  self.uiBattle = UIManager:GetWindow(UIWindowTypeID.Battle)
  if self.uiBattle ~= nil then
    self.uiBattle:OnSpeedUpChange(value)
  end
end

function bs_20285:CameraEffect()
  LuaSkillCtrl:CallBattleCamShakeByParam(0, 1, 0.5, 50)
  LuaSkillCtrl:ShowCameraEffectFunction(3, 0.6)
end

function bs_20285:JumpTo(x, y)
  LuaSkillCtrl:CallEffect(self.Mayuri, self.config.JumpEffect1, self)
  local grid = LuaSkillCtrl:GetGridWithPos(x, y)
  LuaSkillCtrl:SetRolePos(grid, self.Mayuri)
  LuaSkillCtrl:CallEffect(self.Mayuri, self.config.JumpEffect2, self)
end

function bs_20285:add_timer(duration, cb)
  local timer = LuaSkillCtrl:StartTimer(nil, duration, cb, nil, -1)
  local length = #self.timerList
  self.timerList[length + 1] = timer
end

function bs_20285:clear_timer()
  for _, timer in ipairs(self.timerList) do
    if timer ~= nil then
      timer:Stop()
      timer = nil
    end
  end
end

function bs_20285:has(CheckId)
  return true
end

function bs_20285:CallSummoner(overrideSummonerId)
  local MayuriGrid = LuaSkillCtrl:GetGridWithRole(self.Mayuri)
  local gridList = LuaSkillCtrl:FindEmptyGridsWithinRange(MayuriGrid.x, MayuriGrid.y, 3)
  if gridList == nil or gridList.Count < 1 then
    return
  end
  local grid = gridList[0]
  local master = self.Mayuri
  local summonerId = self.config.summonerId
  if overrideSummonerId then
    summonerId = overrideSummonerId
  end
  local summonerEntity = LuaSkillCtrl:CreateSummoner(self, self.config.summonerId, grid.x, grid.y, eBattleRoleBelong.player)
  summonerEntity:SetAttr(eHeroAttr.maxHp, master.maxHp * self.config.maxHpPer // 1000)
  summonerEntity:SetAttr(eHeroAttr.pow, master.pow * self.config.powPer // 1000)
  summonerEntity:SetAttr(eHeroAttr.skill_intensity, master.skill_intensity * self.config.skill_intensityPer // 1000)
  summonerEntity:SetAttr(eHeroAttr.speed, master.speed)
  summonerEntity:SetAttr(eHeroAttr.def, master.def * self.config.defPer // 1000)
  summonerEntity:SetAttr(eHeroAttr.crit, master.crit * self.config.critPer // 1000)
  summonerEntity:SetAttr(eHeroAttr.critDamage, master.critDamage * self.config.critDamagePer // 1000)
  summonerEntity:SetAttr(eHeroAttr.sunder, master.sunder * self.config.sunderPer // 1000)
  summonerEntity:SetAttr(eHeroAttr.magic_res, master.magic_res * self.config.magic_resPer // 1000)
  summonerEntity:SetAttr(eHeroAttr.magic_pen, master.magic_pen * self.config.magic_penPer // 1000)
  summonerEntity:SetAsRealEntity(1)
  local summoner = LuaSkillCtrl:AddSummonerRole(summonerEntity)
  LuaSkillCtrl:CallEffect(summoner, self.config.effect_onCallSummoner, self)
  return summoner
end

function bs_20285:CallEnemy(enemyId, x, y)
  local grid = LuaSkillCtrl:GetGridWithPos(x, y)
  local master = self.Mayuri
  local summonerId = enemyId
  if LuaSkillCtrl:GetRoleWithPos(x, y) ~= nil then
    return
  end
  local summonerEntity = LuaSkillCtrl:CreateSummoner(self, summonerId, grid.x, grid.y, eBattleRoleBelong.enemy)
  summonerEntity:SetAttr(eHeroAttr.maxHp, master.maxHp * self.config.maxHpPer // 1000)
  summonerEntity:SetAttr(eHeroAttr.pow, master.pow * self.config.powPer // 1000)
  summonerEntity:SetAttr(eHeroAttr.skill_intensity, master.skill_intensity * self.config.skill_intensityPer // 1000)
  summonerEntity:SetAttr(eHeroAttr.speed, master.speed)
  summonerEntity:SetAttr(eHeroAttr.def, master.def * self.config.defPer // 1000)
  summonerEntity:SetAttr(eHeroAttr.crit, master.crit * self.config.critPer // 1000)
  summonerEntity:SetAttr(eHeroAttr.critDamage, master.critDamage * self.config.critDamagePer // 1000)
  summonerEntity:SetAttr(eHeroAttr.sunder, master.sunder * self.config.sunderPer // 1000)
  summonerEntity:SetAttr(eHeroAttr.magic_res, master.magic_res * self.config.magic_resPer // 1000)
  summonerEntity:SetAttr(eHeroAttr.magic_pen, master.magic_pen * self.config.magic_penPer // 1000)
  summonerEntity:SetAsRealEntity(1)
  local summoner = LuaSkillCtrl:AddSummonerRole(summonerEntity)
  LuaSkillCtrl:CallEffect(summoner, self.config.effect_onCallSummoner, self)
  return summoner
end

function bs_20285:ItemBorn(enemyId, x, y)
  local grid = LuaSkillCtrl:GetGridWithPos(x, y)
  local master = self.Mayuri
  local summonerId = enemyId
  if LuaSkillCtrl:GetRoleWithPos(x, y) ~= nil then
    return
  end
  local summonerEntity = LuaSkillCtrl:CreateSummoner(self, summonerId, grid.x, grid.y, eBattleRoleBelong.neutral)
  summonerEntity:SetAttr(eHeroAttr.maxHp, master.maxHp * self.config.maxHpPer // 1000)
  summonerEntity:SetAttr(eHeroAttr.pow, master.pow * self.config.powPer // 1000)
  summonerEntity:SetAttr(eHeroAttr.skill_intensity, master.skill_intensity * self.config.skill_intensityPer // 1000)
  summonerEntity:SetAttr(eHeroAttr.speed, master.speed)
  summonerEntity:SetAttr(eHeroAttr.def, master.def * self.config.defPer // 1000)
  summonerEntity:SetAttr(eHeroAttr.crit, master.crit * self.config.critPer // 1000)
  summonerEntity:SetAttr(eHeroAttr.critDamage, master.critDamage * self.config.critDamagePer // 1000)
  summonerEntity:SetAttr(eHeroAttr.sunder, master.sunder * self.config.sunderPer // 1000)
  summonerEntity:SetAttr(eHeroAttr.magic_res, master.magic_res * self.config.magic_resPer // 1000)
  summonerEntity:SetAttr(eHeroAttr.magic_pen, master.magic_pen * self.config.magic_penPer // 1000)
  summonerEntity:SetAsRealEntity(1)
  local summoner = LuaSkillCtrl:AddSummonerRole(summonerEntity)
  LuaSkillCtrl:CallEffect(summoner, self.config.effect_onCallSummoner, self)
  return summoner
end

function bs_20285:CallGrids()
  local grids = self.config.coordList[self.GridPoint]
  if grids == nil then
    return
  end
  for _, grid in ipairs(grids) do
    LuaSkillCtrl:CallCreateEfcGrid(grid[1], grid[2], self.config.gridId)
    self.gridList[#self.gridList + 1] = grid
  end
  self.GridPoint = self.GridPoint + 1
end

function bs_20285:checkGrid(grid)
  local tempList = LuaSkillCtrl:FindGridsWithoutEfcGridAroundGrid(grid.x, grid.y)
  return tempList
end

function bs_20285:ControlRole(role)
  LuaSkillCtrl:CallBuff(self, role, self.config.unULTSKill, 1, nil, true)
  LuaSkillCtrl:CallBuff(self, role, self.config.unCommonATK, 1, nil, true)
  LuaSkillCtrl:CallBuff(self, role, self.config.unAutoSkill, 1, nil, true)
  LuaSkillCtrl:CallBuff(self, role, self.config.xuan_yun, 1, nil, true)
end

function bs_20285:opening_perform()
  self:timeSet(1)
  self:MuteUlt(self)
  LuaSkillCtrl:CallBuff(self, self.Mayuri, 2205, 1, nil)
  LuaSkillCtrl:StartTimer(nil, 75, BindCallback(self, self.call_summoner_thenAVG))
end

function bs_20285:call_summoner_thenAVG()
  LuaSkillCtrl:CallBuff(self, self.Mayuri, self.config.xuan_yun, 1, nil, true)
  LuaSkillCtrl:CallBattleCamShakeByParam(0, 2, 1, 50)
  local MayuriGrid = LuaSkillCtrl:GetGridWithRole(self.Mayuri)
  local grids = LuaSkillCtrl:FindEmptyGridsWithinRange(MayuriGrid.x, MayuriGrid.y, 1)
  self.effects = {}
  for i = 0, grids.Count - 1 do
    local enemy = self:CallEnemy(5, grids[i].x, grids[i].y)
    self.effects[#self.effects + 1] = LuaSkillCtrl:CallEffect(self.Mayuri, self.config.effect_connect, self, nil, enemy)
  end
  LuaSkillCtrl:StartTimer(nil, 30, function()
    LuaSkillCtrl:StartAvgWithPauseGame(nil, 45001153, BindCallback(self, self.Mayuri_aida))
  end, nil)
end

function bs_20285:Mayuri_aida()
  LuaSkillCtrl:StartTimer(nil, 75, function()
    LuaSkillCtrl:StartAvgWithPauseGame(nil, 45001154, BindCallback(self, self.event_call_then_kill), nil)
  end)
end

function bs_20285:event_call_then_kill()
  LuaSkillCtrl:ShowCameraEffectFunction(7, 0.2)
  for _, effect in ipairs(self.effects) do
    if effect ~= nil then
      effect:Die()
      effect = nil
    end
  end
  LuaSkillCtrl:CallBattleCamShakeByParam(0, 2, 1, 50)
  LuaSkillCtrl:DispelBuff(self.Mayuri, self.config.xuan_yun, 1, true, true)
  LuaSkillCtrl:CallEffect(self.Mayuri, 12117, self)
  local target = LuaSkillCtrl:GetTargetWithGrid(3, 2)
  LuaSkillCtrl:CallEffect(target, 12074, self)
  local eList = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.enemy)
  for i = 0, eList.Count - 1 do
    local grids = LuaSkillCtrl:FindEmptyGridsWithinRange(1, 2, 10, true)
    LuaSkillCtrl:CallPhaseMove(self, eList[i], grids[0].x, grids[0].y, 7, nil, nil, true)
  end
  for i = 0, 2 do
    self:CallSummoner(nil)
  end
  local now_timer = LuaSkillCtrl:StartTimer(nil, 35, function()
    self:CallSummoner(nil)
    LuaSkillCtrl:CallBattleCamShakeByParam(0, 2, 1, 20)
  end, nil, -1, 20)
end

function bs_20285:start_perform()
end

function bs_20285:special_perform()
  self:MuteUlt(self)
  self:timeSet(1)
  self:clear_timer()
  self.wupaList = {}
  self.Ganglun = nil
  local entitys = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
  for i = 0, entitys.Count - 1 do
    self:ControlRole(entitys[i])
    if entitys[i].roleDataId == 1001079 then
      self.wupaList[#self.wupaList + 1] = entitys[i]
    end
  end
  local eList = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.enemy)
  for i = 0, eList.Count - 1 do
    self:ControlRole(eList[i])
    if eList[i].roleDataId == 40046 then
      self.Ganglun = eList[i]
    end
  end
  LuaSkillCtrl:CallRoleAction(self.Ganglun, 1058, 99)
  self:flow1()
end

function bs_20285:flow1()
  local grids = {
    {2, 2},
    {1, 2},
    {3, 2},
    -1
  }
  for count, grid in ipairs(grids) do
    LuaSkillCtrl:StartTimer(nil, 17 * count, function()
      if grid == -1 then
        self:activeFlow()
      else
        local target = LuaSkillCtrl:GetGridWithPos(grid[1], grid[2])
        LuaSkillCtrl:MoveRoleToTarget(self, target, self.Mayuri, false)
      end
    end)
  end
end

function bs_20285:activeFlow()
  LuaSkillCtrl:CallRoleAction(self.Mayuri, 1002, 1)
  local target = LuaSkillCtrl:GetRoleWithPos(4, 2)
  LuaSkillCtrl:StartTimer(nil, 15, function()
    LuaSkillCtrl:RemoveLife(99999, self, target)
    LuaSkillCtrl:StartAvgWithPauseGame(nil, 45001157, BindCallback(self, self.flow2))
  end)
end

function bs_20285:flow2()
  self:CameraEffect()
  LuaSkillCtrl:StartTimer(nil, 15, function()
    self:flow2_1()
  end)
  LuaSkillCtrl:StartTimer(nil, 25, function()
    self:flow2_2()
  end)
end

function bs_20285:flow2_1()
  LuaSkillCtrl:CallEffect(self.Mayuri, self.config.effect_corrode, self)
  LuaSkillCtrl:ChangeRoleBody(self.Mayuri, "mayuri_entropy", 0)
  LuaSkillCtrl:CallRoleAction(self.Ganglun, 1058, 99)
  LuaSkillCtrl:CallLoseAllGridEffect()
  for _, grid in ipairs(self.config.grid_list) do
    local target = LuaSkillCtrl:GetTargetWithGrid(grid[1], grid[2])
    LuaSkillCtrl:CallEffect(target, self.config.effect_corrode, self)
    LuaSkillCtrl:CallCreateEfcGrid(grid[1], grid[2], self.config.gridId_truth)
    AudioManager:PlayAudioById(102105)
  end
  LuaSkillCtrl:StartTimer(nil, 15, function()
    for _, summoner in ipairs(self.wupaList) do
      LuaSkillCtrl:CallEffect(summoner, self.config.effect_corrode, self)
      LuaSkillCtrl:ChangeRoleBody(summoner, "twiner", 0)
      AudioManager:PlayAudioById(102105)
    end
  end)
end

function bs_20285:flow2_2()
  local grid = LuaSkillCtrl:GetGridWithPos(4, 2)
  LuaSkillCtrl:MoveRoleToTarget(self, grid, self.Mayuri, false, BindCallback(self, self.EndingPerform))
end

function bs_20285:EndingPerform()
  LuaSkillCtrl:CallEffect(self.Mayuri, 12110, self)
  LuaSkillCtrl:CallBattleCamShakeByParam(0, 2, 1, 20)
  LuaSkillCtrl:StartTimer(nil, 7, function()
    LuaSkillCtrl:CallEffect(self.Mayuri, 12110, self)
    LuaSkillCtrl:CallRoleAction(self.Mayuri, 1058, 99)
  end)
  LuaSkillCtrl:StartTimer(nil, 25, function()
    AudioManager:PlayAudioById(207705)
    LuaSkillCtrl:CallBattleCamShakeByParam(0, 2, 1, 20)
    local grids = {
      {4, 2},
      {4, 1},
      {5, 1},
      {6, 2},
      {5, 3},
      {4, 3},
      {3, 2}
    }
    for _, this_grid in ipairs(grids) do
      self:ItemBorn(86, this_grid[1], this_grid[2])
    end
  end)
  LuaSkillCtrl:StartTimer(nil, 70, function()
    LuaSkillCtrl:ForceEndBattle(true)
  end)
end

function bs_20285:LuaDispose()
  base.LuaDispose(self)
  LuaSkillCtrl:CloseCameraEffectFunction(3, true)
  LuaSkillCtrl:CloseCameraEffectFunction(7, true)
end

function bs_20285:OnCasterDie()
  base.OnCasterDie(self)
  self:clear_timer()
  LuaSkillCtrl:CloseCameraEffectFunction(3, true)
  LuaSkillCtrl:CloseCameraEffectFunction(7, true)
end

return bs_20285
