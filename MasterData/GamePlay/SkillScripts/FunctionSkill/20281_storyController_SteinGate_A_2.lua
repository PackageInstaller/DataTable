local bs_20281 = class("bs_20281", LuaSkillBase)
local base = LuaSkillBase
bs_20281.config = {
  duration = 75,
  summonerId = 37,
  grids = {
    {1, 1},
    {4, 1},
    {4, 3},
    {7, 5}
  },
  maxHpPer = 150,
  powPer = 700,
  skill_intensityPer = 700,
  critPer = 1000,
  critDamagePer = 1000,
  defPer = 1000,
  sunderPer = 1000,
  magic_resPer = 1000,
  magic_penPer = 1000,
  enemy_words = {
    3,
    4,
    5,
    6,
    7
  },
  player_words = {11},
  event_words = {
    12,
    13,
    14,
    0,
    0,
    0
  },
  break_words = {
    15,
    16,
    17
  },
  effectId_up = 501101,
  effectId_down = 501102,
  callSummonerTimes = 6,
  buff_xuanyun = 66,
  event_intensity = {
    0,
    0,
    0,
    5,
    10,
    15
  },
  c_intensity = {
    20,
    100,
    10000
  },
  barNum = {
    200,
    300,
    400,
    330,
    220,
    150,
    600,
    550,
    400
  },
  endBarNum1 = {
    0,
    0,
    0,
    600,
    650,
    700
  },
  endBarNum2 = {
    800,
    900,
    1000
  }
}

function bs_20281:ctor()
end

function bs_20281:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddLuaTrigger(eSkillLuaTrigger.StoryEvent, self.OnStoryEvent)
  LuaSkillCtrl:ShowCameraEffectFunction(6, 0)
  self.CallSummonerCount = 0
  self.battleroom = LuaSkillCtrl:GetBattleRoomId()
  self.barProgress = 0
  LuaSkillCtrl:SetGameScoreAcitve(4, true)
  self.barProgress = self:GetInitBar()
  LuaSkillCtrl:SetGameScoreValue(4, self.barProgress)
  self.timer = LuaSkillCtrl:StartTimer(nil, 30, BindCallback(self, self.BarPerform), nil, -1)
end

function bs_20281:GetInitBar()
  return 0
end

function bs_20281:BarPerform()
  local t = self.config.barNum
  local rand = LuaSkillCtrl:CallRange(1, #t)
  local num = t[rand]
  LuaSkillCtrl:SetGameScoreValue(4, num)
end

function bs_20281:OnStoryEvent(flag)
  if flag == nil then
    return
  end
  if flag == "StoryEnd" then
    self:EndEvent()
  end
  if flag == "EndEvent1" then
    self:EndEvent1()
  end
  if flag == "EndEvent2" then
    LuaSkillCtrl:StartTimer(nil, 15, function()
      self:endGame()
    end)
  end
end

function bs_20281:EndEvent()
  LuaSkillCtrl:CallBattleCamShakeByParam(0, 2, 1, 50)
  self:muteAll()
  LuaSkillCtrl:StartTimer(nil, 15, function()
    self.CallSummonerCount = self.CallSummonerCount + 1
    local wordId = self.config.event_words[self.CallSummonerCount]
    if wordId ~= 0 then
      LuaSkillCtrl:CallPlayEpTipDialogInBattle(wordId)
    else
      LuaSkillCtrl:CallBattleCamShakeByParam(0, 2, 1, 50)
      for _, grid in ipairs(self.config.grids) do
        self:ItemBorn(self.config.summonerId, grid[1], grid[2])
      end
      if self.CallSummonerCount >= self.config.callSummonerTimes then
        LuaSkillCtrl:BroadcastLuaTrigger(eSkillLuaTrigger.StoryEvent, "EndEvent1")
      end
      local c_intensity = self.config.event_intensity[self.CallSummonerCount]
      LuaSkillCtrl:ShowCameraEffectFunction(6, c_intensity)
      LuaSkillCtrl:SetGameScoreValue(4, self.config.endBarNum1[self.CallSummonerCount])
    end
  end, nil, self.config.callSummonerTimes - 1, 15)
end

function bs_20281:EndEvent1()
  self.EndEventCount = 0
  LuaSkillCtrl:StartTimer(nil, 30, function()
    self.EndEventCount = self.EndEventCount + 1
    local wordId = self.config.break_words[self.EndEventCount]
    LuaSkillCtrl:CallPlayEpTipDialogInBattle(wordId)
    local c_intensity = self.config.c_intensity[self.EndEventCount]
    LuaSkillCtrl:ShowCameraEffectFunction(6, c_intensity)
    LuaSkillCtrl:SetGameScoreValue(4, self.config.endBarNum2[self.EndEventCount])
    if self.EndEventCount >= 3 then
      LuaSkillCtrl:BroadcastLuaTrigger(eSkillLuaTrigger.StoryEvent, "EndEvent2")
    end
  end, nil, 2)
end

function bs_20281:endGame()
  LuaSkillCtrl:ForceEndBattle(true)
end

function bs_20281:ItemBorn(ItemId, grid_x, grid_y)
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
  summoner:SetAttr(eHeroAttr.maxHp, 1)
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
end

function bs_20281:muteAll()
  if self.timer ~= nil then
    self.timer:Stop()
    self.timer = nil
  end
  if not LuaSkillCtrl.IsInVerify then
    self.uiBattle = UIManager:GetWindow(UIWindowTypeID.Battle)
    if self.uiBattle ~= nil then
      self.uiBattle:OnSpeedUpChange(1)
    end
  end
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
  local pList = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
  if pList == nil or 1 > pList.Count then
    return
  end
  for i = 0, pList.Count - 1 do
    LuaSkillCtrl:CallBuff(self, pList[i], self.config.buff_xuanyun, 1, nil, false, nil, false)
  end
end

function bs_20281:LuaDispose()
  base.LuaDispose(self)
  if self.timer ~= nil then
    self.timer:Stop()
    self.timer = nil
  end
  LuaSkillCtrl:ShowCameraEffectFunction(6, 0)
end

function bs_20281:OnCasterDie()
  base.OnCasterDie(self)
  LuaSkillCtrl:CloseCameraEffectFunction(6, true)
end

return bs_20281
