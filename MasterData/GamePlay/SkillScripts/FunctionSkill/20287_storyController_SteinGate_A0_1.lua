local bs_20287 = class("bs_20287", LuaSkillBase)
local base = LuaSkillBase
bs_20287.config = {
  talks_begin = {
    47,
    48,
    49,
    -1
  },
  talks_end = {
    50,
    51,
    52,
    -1
  },
  gridId = 34,
  bossId = 1032,
  bossBornEffect = 12117,
  bossBornGrid = {4, 3},
  summonerId = 10,
  buff_xuanyun = 66,
  maxHpPer = 150,
  powPer = 700,
  skill_intensityPer = 700,
  critPer = 1000,
  critDamagePer = 1000,
  defPer = 1000,
  sunderPer = 1000,
  magic_resPer = 1000,
  magic_penPer = 1000,
  effectId_up = 501101,
  effectId_down = 501102,
  effect_highlight = 12123,
  summonerList = {
    27,
    26,
    23
  },
  toCallGrids = {
    {
      {3, 1},
      {4, 1},
      {5, 1},
      {3, 2},
      {6, 2},
      {2, 3},
      {6, 3},
      {3, 4},
      {6, 4},
      {3, 5},
      {4, 5},
      {5, 5}
    },
    {
      {3, 0},
      {4, 0},
      {5, 0},
      {6, 0},
      {2, 1},
      {6, 1},
      {2, 2},
      {7, 2},
      {1, 3},
      {7, 3},
      {2, 4},
      {7, 4},
      {2, 5},
      {6, 5},
      {3, 6},
      {4, 6},
      {5, 6},
      {6, 6}
    },
    {
      {2, 0},
      {7, 0},
      {1, 1},
      {7, 1},
      {1, 2},
      {8, 2},
      {0, 3},
      {8, 3},
      {1, 4},
      {8, 4},
      {1, 5},
      {7, 5},
      {2, 6},
      {7, 6}
    },
    {
      {0, 0},
      {1, 0},
      {8, 0},
      {9, 0},
      {0, 1},
      {8, 1},
      {0, 5},
      {8, 5},
      {0, 6},
      {1, 6},
      {8, 6},
      {9, 6}
    }
  }
}

function bs_20287:ctor()
end

function bs_20287:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddLuaTrigger(eSkillLuaTrigger.StoryEvent, self.OnStoryEvent)
  self.talkCount = 0
  self.call_timer = LuaSkillCtrl:StartTimer(nil, 100, BindCallback(self, self.TimerEvent), nil, -1)
  self.effectList = {}
  if LuaSkillCtrl:GetBattleRoomId() ~= 1180146 or LuaSkillCtrl:GetBattleRoomId() ~= 1181146 then
    return
  end
end

function bs_20287:TimerEvent()
  local grid = LuaSkillCtrl:FindEmptyGrid()
  local target = LuaSkillCtrl:GetTargetWithGrid(grid.x, grid.y)
  local effect = LuaSkillCtrl:CallEffect(target, self.config.effect_highlight, self)
  LuaSkillCtrl:StartTimer(nil, 60, BindCallback(self, self.RandomCall, grid, effect))
end

function bs_20287:RandomCall(grid, effect)
  local role = LuaSkillCtrl:GetRoleWithPos(grid.x, grid.y)
  if role ~= nil then
    return
  end
  local rand = LuaSkillCtrl:CallRange(1, #self.config.summonerList)
  self:ItemBorn(self.config.summonerList[rand], grid.x, grid.y)
  if effect ~= nil then
    effect:Die()
    effect = nil
  end
end

function bs_20287:OnStoryEvent(flag)
  if flag == "StoryEnd" then
    self:EndPerform()
  end
end

function bs_20287:EndPerform()
  self.Counter = 0
  self.ScreenEffectDegree = 0
  LuaSkillCtrl:CallBattleCamShakeByParam(0, 1, 0.5, 50)
  self:muteAll()
  self:timeSet(1)
  if self.call_timer ~= nil then
    self.call_timer:Stop()
    self.call_timer = nil
  end
  local target = LuaSkillCtrl:GetTargetWithGrid(4, 3)
  self.boss_effect = LuaSkillCtrl:CallEffect(target, self.config.effect_highlight, self)
  LuaSkillCtrl:CallEffectDoScale(self.boss_effect, 2.0, 99)
  self.timer = LuaSkillCtrl:StartTimer(nil, 15, function()
    self.Counter = self.Counter + 1
    local to_corrodes = self.config.toCallGrids[self.Counter]
    LuaSkillCtrl:CallBattleCamShakeByParam(0, 1, 1, 50)
    for k, v in ipairs(to_corrodes) do
      LuaSkillCtrl:CallCreateEfcGrid(v[1], v[2], 1132)
    end
    if self.Counter >= 4 then
      self:CallAvg()
    end
  end, nil, 3)
end

function bs_20287:CallAvg()
  LuaSkillCtrl:StartTimer(nil, 7, function()
    LuaSkillCtrl:StartAvgWithPauseGame(nil, 45001142, BindCallback(self, self.BossPerform))
  end)
end

function bs_20287:BossPerform()
  local grid = self.config.bossBornGrid
  local gridRole = LuaSkillCtrl:GetRoleWithPos(grid[1], grid[2])
  if gridRole ~= nil then
    LuaSkillCtrl:DispelBuff(gridRole, 175, 1, true, true)
    LuaSkillCtrl:DispelBuff(gridRole, 198, 1, true, true)
    LuaSkillCtrl:DispelBuff(gridRole, 88, 1, true, true)
    LuaSkillCtrl:RemoveLife(gridRole.maxHp + 1, self, gridRole, nil, nil, false, true)
  end
  local target = LuaSkillCtrl:GetTargetWithGrid(grid[1], grid[2])
  if self.boss_effect ~= nil then
    self.boss_effect:Die()
    self.boss_effect = nil
  end
  self.effect = LuaSkillCtrl:CallEffect(target, self.config.bossBornEffect, self, function()
    local boss = self:ItemBorn(self.config.bossId, grid[1], grid[2])
    LuaSkillCtrl:CallBuff(self, boss, 88, 1, nil, true)
    LuaSkillCtrl:CallBuff(self, boss, 2175, 1, nil, true)
    LuaSkillCtrl:CallStartLocalScale(boss, Vector3.New(1.5, 1.5, 1.5), 0.3)
  end)
  self.Counter = 0
  LuaSkillCtrl:StartTimer(nil, 15, function()
    self.Counter = self.Counter + 1
    for i = 1, 4 do
      local grid = LuaSkillCtrl:FindEmptyGrid()
      self:RandomCall(grid, nil)
    end
    if self.Counter >= 4 then
      LuaSkillCtrl:ForceEndBattle(true)
    end
  end, nil, 3)
end

function bs_20287:ItemBorn(ItemId, grid_x, grid_y)
  local summonerId = ItemId
  local x = grid_x
  local y = grid_y
  local notEmpty = LuaSkillCtrl:GetRoleWithPos(x, y)
  if notEmpty ~= nil then
    local grid = LuaSkillCtrl:FindEmptyGridWithinRange(notEmpty, 5)
    x = grid.x
    y = grid.y
  end
  local summoner = LuaSkillCtrl:CreateSummoner(self, summonerId, x, y, eBattleRoleBelong.enemy)
  summoner:SetAttr(eHeroAttr.maxHp, 1000)
  summoner:SetAttr(eHeroAttr.pow, self.caster.pow * self.config.powPer // 1000)
  summoner:SetAttr(eHeroAttr.skill_intensity, self.caster.skill_intensity * self.config.skill_intensityPer // 1000)
  summoner:SetAttr(eHeroAttr.speed, self.caster.speed)
  summoner:SetAttr(eHeroAttr.def, self.caster.def * self.config.defPer // 1000)
  summoner:SetAttr(eHeroAttr.crit, self.caster.crit * self.config.critPer // 1000)
  summoner:SetAttr(eHeroAttr.critDamage, self.caster.critDamage * self.config.critDamagePer // 1000)
  summoner:SetAttr(eHeroAttr.sunder, self.caster.sunder * self.config.sunderPer // 1000)
  summoner:SetAttr(eHeroAttr.magic_res, self.caster.magic_res * self.config.magic_resPer // 1000)
  summoner:SetAttr(eHeroAttr.magic_pen, self.caster.magic_pen * self.config.magic_penPer // 1000)
  summoner:SetAsRealEntity(1)
  local summonerEntity = LuaSkillCtrl:AddSummonerRole(summoner)
  local target = LuaSkillCtrl:GetTargetWithGrid(x, y)
  LuaSkillCtrl:CallEffect(target, self.config.effectId_down, self)
  return summonerEntity
end

function bs_20287:muteAll()
  if self.timer ~= nil then
    self.timer:Stop()
    self.timer = nil
  end
  self.uiBattle = UIManager:GetWindow(UIWindowTypeID.Battle)
  if self.uiBattle ~= nil then
    self.uiBattle:OnSpeedUpChange(1)
  end
  self.win = UIManager:ShowWindow(UIWindowTypeID.Battle)
  if self.win ~= nil then
    self.win:SetUltAuto(false)
  end
  local costurlnum = 0 - LuaSkillCtrl:GetUltHMp()
  LuaSkillCtrl:CallAddPlayerHmp(costurlnum)
  if self.timer_HMP ~= nil then
    self.timer_HMP:Stop()
    self.timer_HMP = nil
  end
  local pList = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
  for i = 0, pList.Count - 1 do
    LuaSkillCtrl:CallBuff(self, pList[i], self.config.buff_xuanyun, 1, nil, false, nil, false)
  end
end

function bs_20287:timeSet(value)
  self.uiBattle = UIManager:GetWindow(UIWindowTypeID.Battle)
  if self.uiBattle ~= nil then
    self.uiBattle:OnSpeedUpChange(value)
  end
end

function bs_20287:OnCasterDie()
  base.OnCasterDie(self)
  LuaSkillCtrl:CloseCameraEffectFunction(3, true)
end

function bs_20287:LuaDispose()
  base.LuaDispose(self)
  LuaSkillCtrl:CloseCameraEffectFunction(3, true)
end

return bs_20287
