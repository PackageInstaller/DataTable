local bs_20282 = class("bs_20282", LuaSkillBase)
local base = LuaSkillBase
bs_20282.config = {
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
  sheep_dialog = {
    18,
    19,
    20
  },
  sheep_first_show = {
    22,
    23,
    24
  },
  sheep_defeat = {
    25,
    26,
    27,
    28
  },
  sheep_counter = {
    {32, 33},
    {34, 35},
    {36, 37},
    {22, 23}
  },
  end_dialog = {
    24,
    25,
    26,
    27,
    28,
    29,
    30,
    31
  },
  end_count = 3,
  c_intensity = {
    20,
    30,
    60,
    60,
    20
  },
  endBarNum = {
    200,
    300,
    600
  },
  buff_xuanyun = 66,
  effectId_up = 501101,
  effectId_down = 501102,
  effectId_throw = 10936,
  effectId_baozhao = 10866,
  aoe_config = {
    effect_shape = 3,
    aoe_select_code = 4,
    aoe_range = 1
  },
  audioList = {
    7020,
    7021,
    7022
  }
}

function bs_20282:ctor()
end

function bs_20282:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddLuaTrigger(eSkillLuaTrigger.StoryEvent, self.OnStoryEvent)
  LuaSkillCtrl:ShowCameraEffectFunction(6, 0)
  self.battleroom = LuaSkillCtrl:GetBattleRoomId()
  self.barProgress = 0
  LuaSkillCtrl:SetGameScoreAcitve(4, true)
  self.barProgress = self:GetInitBar()
  LuaSkillCtrl:SetGameScoreValue(4, self.barProgress)
  self.timer = LuaSkillCtrl:StartTimer(nil, 30, BindCallback(self, self.BarPerform), nil, -1)
  self.sheep_count = 0
  self.isFirstSheep = false
  if self.battleroom == 1180033 or self.battleroom == 1181033 then
    self.isFirstSheep = true
  end
  self.EndEventCount = 0
  self.EndFlag = false
  self.FightDialogPointer = nil
end

function bs_20282:GetInitBar()
  return 0
end

function bs_20282:BarPerform()
  local t = self.config.barNum
  local rand = LuaSkillCtrl:CallRange(1, #t)
  local num = t[rand]
  LuaSkillCtrl:SetGameScoreValue(4, num)
end

function bs_20282:OnStoryEvent(flag)
  if flag == "StoryEnd" then
    self:EndPerform()
  end
  if flag == "SteinGate_PowerSheepBorn" then
    if self.EndFlag == true then
      return
    end
    self:OnBigSheepCaste()
  end
  if flag == "SteinGate_PowerSheepDie" then
    if self.EndFlag == true then
      return
    end
    self:OnBigSheepDie()
  end
end

function bs_20282:OnBigSheepCaste()
  LuaSkillCtrl:SetGameScoreValue(4, 80)
  LuaSkillCtrl:CallBattleCamShakeByParam(0, 2, 1, 50)
  self:changeCamera(40, 20)
  AudioManager:PlayAudioById(7024)
  if self.FightDialogPointer then
    return
  end
  local rand = LuaSkillCtrl:CallRange(1, #self.config.sheep_counter)
  self.FightDialogPointer = rand
  local word = self.config.sheep_counter[rand][1]
  LuaSkillCtrl:CallPlayEpTipDialogInBattle(word)
end

function bs_20282:OnBigSheepDie()
  LuaSkillCtrl:ShowCameraEffectFunction(6, 0)
  if self.FightDialogPointer then
    local word = self.config.sheep_counter[self.FightDialogPointer][2]
    LuaSkillCtrl:CallPlayEpTipDialogInBattle(word)
    self.FightDialogPointer = nil
  end
end

function bs_20282:changeCamera(time, strength)
  LuaSkillCtrl:ShowCameraEffectFunction(6, strength)
  LuaSkillCtrl:StartTimer(nil, time, function()
    LuaSkillCtrl:ShowCameraEffectFunction(6, strength)
  end)
end

function bs_20282:EndPerform()
  self.EndFlag = true
  self:muteAll()
  LuaSkillCtrl:StartTimer(nil, 30, function()
    self.EndEventCount = self.EndEventCount + 1
    local wordId = self.config.end_dialog[self.EndEventCount]
    LuaSkillCtrl:CallPlayEpTipDialogInBattle(wordId)
    for _, grid in ipairs(self.config.grids) do
      self:ItemBorn(self.config.summonerId, grid[1], grid[2])
    end
    local c_intensity = self.config.c_intensity[self.EndEventCount]
    LuaSkillCtrl:ShowCameraEffectFunction(6, c_intensity)
    LuaSkillCtrl:SetGameScoreValue(4, self.config.endBarNum[self.EndEventCount])
    if self.EndEventCount >= 4 then
      self:OTAKUreverse()
    end
  end, nil, 3)
end

function bs_20282:OTAKUreverse()
  LuaSkillCtrl:StartTimer(nil, 30, function()
    self.EndEventCount = self.EndEventCount + 1
    local wordId = self.config.end_dialog[self.EndEventCount]
    LuaSkillCtrl:CallPlayEpTipDialogInBattle(wordId)
    local c_intensity = self.config.c_intensity[self.EndEventCount]
    LuaSkillCtrl:ShowCameraEffectFunction(6, c_intensity)
    LuaSkillCtrl:SetGameScoreValue(4, self.config.endBarNum[self.EndEventCount])
    if self.EndEventCount == 6 then
    end
    if self.EndEventCount >= 6 then
      self:ReadyToThrow()
    end
  end, nil, 1)
end

function bs_20282:ReadyToThrow()
  LuaSkillCtrl:CallBattleCamShakeByParam(0, 2, 1, 50)
  local eList = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.enemy)
  for i = 0, eList.Count - 1 do
    LuaSkillCtrl:CallBuff(self, eList[i], self.config.buff_xuanyun, 1, 120, false, nil, false)
  end
  local pf = LuaSkillCtrl:GetGuardProfession()
  LuaSkillCtrl:DispelBuff(pf, 60501, 0, true, false)
  LuaSkillCtrl:DispelBuff(pf, 198, 0, true, false)
  local target = LuaSkillCtrl:GetTargetWithGrid(4, 1)
  if target then
    LuaSkillCtrl:DispelBuff(pf, 60501, 0, true, false)
    LuaSkillCtrl:DispelBuff(pf, 198, 0, true, false)
    LuaSkillCtrl:DispelBuff(pf, 88, 0, true, false)
  end
  LuaSkillCtrl:CallEffect(pf, self.config.effectId_up, self)
  LuaSkillCtrl:CallStartLocalScale(pf, Vector3.New(0.0, 0.0, 0.0), 0.1)
  LuaSkillCtrl:StartTimer(nil, 10, function()
    self.EndEventCount = self.EndEventCount + 1
    local wordId = self.config.end_dialog[self.EndEventCount]
    LuaSkillCtrl:CallPlayEpTipDialogInBattle(wordId)
    if self.EndEventCount >= 8 then
      self:ThrowMyself()
    end
  end, nil, 1)
end

function bs_20282:ThrowMyself()
  local pf = LuaSkillCtrl:GetGuardProfession()
  local grid = LuaSkillCtrl:GetGridWithPos(4, 1)
  local target = LuaSkillCtrl:GetRoleWithPos(4, 1)
  if target ~= nil then
    LuaSkillCtrl:RemoveLife(99999, self, target, true, nil, false, true, eHurtType.RealDmg, true)
  end
  local effect = LuaSkillCtrl:CallEffect(target, self.config.effectId_throw, self, nil, target)
  LuaSkillCtrl:CallEffectDoScale(effect, 2.0, 1)
  LuaSkillCtrl:StartTimer(self, 10, function()
    LuaSkillCtrl:SetRolePos(grid, pf)
    LuaSkillCtrl:CallStartLocalScale(pf, Vector3.New(1.8, 1.8, 1.8), 0.1)
  end)
  self.tempPointer = 0
  LuaSkillCtrl:StartTimer(nil, 20, function()
    self.tempPointer = self.tempPointer + 1
    LuaSkillCtrl:StartTimer(nil, 5, BindCallback(self, self.BreakAll_perform), nil, 2)
    LuaSkillCtrl:CallBattleCamShakeByParam(0, 1, 1, 50)
    if self.tempPointer >= 4 then
      local pList = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
      for i = 0, pList.Count - 1 do
        LuaSkillCtrl:DispelBuff(pList[i], self.config.buff_xuanyun, 0)
      end
    end
  end, nil, 3)
end

function bs_20282:BreakAll_perform()
  local break_grid = {
    {1, 1},
    {7, 1},
    {7, 5},
    {2, 4},
    {5, 3},
    {3, 6}
  }
  local point = LuaSkillCtrl:CallRange(1, #break_grid)
  local coord = break_grid[point]
  local target = LuaSkillCtrl:GetTargetWithGrid(coord[1], coord[2])
  LuaSkillCtrl:CallEffect(target, self.config.effectId_baozhao, self)
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target, self.config.aoe_config)
  if skillResult.roleList.Count > 0 then
    for i = 0, skillResult.roleList.Count - 1 do
      AudioManager:PlayAudioById(213310)
      local damage = skillResult.roleList[i].maxHp
      LuaSkillCtrl:RemoveLife(damage, self, skillResult.roleList[i], true, nil, true, true)
    end
  end
end

function bs_20282:muteAll()
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
  for i = 0, pList.Count - 1 do
    LuaSkillCtrl:CallBuff(self, pList[i], self.config.buff_xuanyun, 1, nil, false, nil, false)
  end
end

function bs_20282:ItemBorn(ItemId, grid_x, grid_y)
  local summonerId = ItemId
  local x = grid_x
  local y = grid_y
  local notEmpty = LuaSkillCtrl:GetRoleWithPos(x, y)
  if notEmpty ~= nil then
    local grid = LuaSkillCtrl:FindEmptyGridWithinRange(notEmpty, 5)
    if grid == nil then
      return
    end
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

function bs_20282:LuaDispose()
  base.LuaDispose(self)
  if self.timer ~= nil then
    self.timer:Stop()
    self.timer = nil
  end
  LuaSkillCtrl:ShowCameraEffectFunction(6, 0)
end

function bs_20282:OnCasterDie()
  base.OnCasterDie(self)
  if self.timer ~= nil then
    self.timer:Stop()
    self.timer = nil
  end
  LuaSkillCtrl:CloseCameraEffectFunction(6, true)
end

return bs_20282
