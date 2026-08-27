local bs_20263 = class("bs_20263", LuaSkillBase)
local base = LuaSkillBase
bs_20263.config = {
  effect_shang_grid = 504,
  effect_shang_corrode = 505,
  ItemGrid = {
    {
      {4, 0},
      {2, 0},
      {3, 0},
      {4, 4},
      {2, 4},
      {3, 4}
    },
    {
      {3, 0},
      {2, 1},
      {2, 0},
      {2, 3},
      {2, 4},
      {3, 4}
    }
  },
  ItemDataId = {
    1026,
    1027,
    1028,
    1029,
    1030
  },
  AvgList = {
    "23summer_s16_2",
    "23summer_s16_3"
  },
  BarNum = {990},
  BarIncrease = {
    50,
    100,
    150,
    200,
    250,
    300,
    342,
    383,
    425,
    467,
    508,
    550,
    592,
    633,
    675,
    717,
    758,
    800,
    832,
    863,
    895,
    927,
    958,
    990,
    990,
    990,
    990,
    990,
    990
  },
  ContainGrid = {5, 2},
  effectId_up = 501101,
  effectId_down = 501102,
  grid_shang = {
    {
      {2, 0},
      {2, 4}
    },
    {
      {2, 1},
      {2, 3}
    },
    {
      {3, 0},
      {3, 4}
    },
    {
      {3, 1},
      {3, 3},
      {2, 2}
    },
    {
      {6, 0},
      {6, 4},
      {3, 2}
    }
  },
  CorrodeEffect = {12109, 12110},
  CorrodeGridId = 1134,
  CorrodeGridEffect = 12112,
  CorrodeGrids = {
    {4, 1},
    {5, 1},
    {4, 2},
    {6, 2},
    {4, 3},
    {5, 3}
  },
  playerGrid = {
    {0, 1},
    {0, 3}
  },
  buffList = {2139, 2140},
  maxHpPer = 150,
  powPer = 700,
  skill_intensityPer = 700,
  critPer = 1000,
  critDamagePer = 1000,
  defPer = 1000,
  sunderPer = 1000,
  magic_resPer = 1000,
  magic_penPer = 1000,
  Item_buff_list = {88},
  EmptyGrid = {5, 2},
  buffId_wudi = 88,
  buffId_unselect = 88
}

function bs_20263:ctor()
end

function bs_20263:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.nextAVG = 1
  self.progress = 0
  self.barProgress = 0
  LuaSkillCtrl:SetGameScoreAcitve(4, true)
  LuaSkillCtrl:SetGameScoreValue(4, self.barProgress)
  self:AddAfterPlaySkillTrigger("bs_20263_1", 1, self.OnAfterPlaySkill, nil, nil, nil, nil, nil, nil, nil, eSkillTag.ultSkill)
  for k, v in ipairs(self.config.playerGrid) do
    local role = LuaSkillCtrl:GetRoleWithPos(v[1], v[2])
    if role ~= nil then
      LuaSkillCtrl:CallBuff(self, role, self.config.buffList[1], 1, 99999, true, role)
      LuaSkillCtrl:CallBuff(self, role, self.config.buffList[2], 1, 9999, true, role)
    end
  end
  local emptyRole = LuaSkillCtrl:GetRoleWithPos(self.config.EmptyGrid[1], self.config.EmptyGrid[2])
  LuaSkillCtrl:CallBuff(self, emptyRole, self.config.buffId_wudi, 1, nil, true, emptyRole)
  LuaSkillCtrl:CallBuff(self, emptyRole, 198, 1, nil, true, emptyRole)
  self.timer_HMP = LuaSkillCtrl:StartTimer(nil, 75, BindCallback(self, self.CallAddMP), nil, -1, 50)
  local targetlist = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
  for i = 0, targetlist.Count - 1 do
    if targetlist ~= nil and targetlist[i].roleDataId == 1037 then
      self.hero = targetlist[i]
    end
  end
  self.isFirstCall = true
  self:StoryCallItem(self.progress)
  self.CorrodeCount = 0
  self:CallAddMP()
  self.ScreenEffectDegree = 0.01
  self.ScreenEffectTimer = LuaSkillCtrl:StartTimer(nil, 15, function()
    self:CallScreenEffect()
  end, nil, -1)
  self.nextGroup = 1
  if not LuaSkillCtrl.IsInVerify then
    self.win = UIManager:ShowWindow(UIWindowTypeID.Battle)
    if self.win ~= nil then
      self.win:SetUltAuto(false)
    end
  end
end

function bs_20263:OnAfterPlaySkill()
  self.checkTimer = LuaSkillCtrl:StartTimer(nil, 65, BindCallback(self, self.CheckCorrodeGrid), nil)
  self:RefershCD(self)
  if self.win ~= nil then
    self.win:SetUltAuto(false)
  end
end

function bs_20263:RefershCD(self)
  local skills = LuaSkillCtrl:GetAllUltSkills()
  if skills ~= nil then
    local skillCount = skills.Count
    if 0 < skillCount then
      for j = 0, skillCount - 1 do
        local curTotalCd = 1800
        local skill = skills[j]
        if skill.funcHeroId == self.hero.roleDataId and self.hero ~= self.caster then
          LuaSkillCtrl:CallResetCDForSingleSkill(skill, curTotalCd)
        end
      end
    end
  end
end

function bs_20263:CheckCorrodeGrid()
  local grids = self.config.CorrodeGrids
  if self.progress == 3 then
    for key, grid in ipairs(grids) do
      local role = LuaSkillCtrl:GetRoleWithPos(grid[1], grid[2])
      if role ~= nil then
        self:CorrodeItem(role)
      end
    end
  else
    for key, grid in ipairs(grids) do
      local role = LuaSkillCtrl:GetRoleWithPos(grid[1], grid[2])
      if role ~= nil then
        self:CorrodeItem(role)
      end
    end
  end
end

function bs_20263:ProgressControl(progress)
  if progress == 1 then
    for k, v in ipairs(self.config.ItemGrid) do
      LuaSkillCtrl:GetTargetWithGrid(v[1], v[2])
      LuaSkillCtrl:CallEffect(target, self.config.effectId_down, self)
      if k == #self.config.ItemGrid then
        LuaSkillCtrl:StartTimer(nil, 30, function()
          self:PlayAVGwithCount(BindCallback(self, self.storyFlow1))
        end)
      end
    end
  end
end

function bs_20263:storyFlow1()
  self:MuteUlt(self)
  if self.timer_HMP ~= nil then
    self.timer_HMP:Stop()
    self.timer_HMP = nil
  end
  self.uiBattle = UIManager:GetWindow(UIWindowTypeID.Battle)
  if self.uiBattle ~= nil then
    self.uiBattle:OnSpeedUpChange(1)
  end
  if self.ScreenEffectTimer ~= nil then
    self.ScreenEffectTimer:Stop()
    self.ScreenEffectTimer = nil
  end
  local effectTarget3 = LuaSkillCtrl:GetTargetWithGrid(1, 3)
  local role = LuaSkillCtrl:GetRoleWithPos(1, 3)
  local grid1 = LuaSkillCtrl:GetGridWithPos(2, 2)
  LuaSkillCtrl:StartTimer(nil, 25, function()
    LuaSkillCtrl:CallEffect(effectTarget3, self.config.effectId_up, self)
    LuaSkillCtrl:RemoveLife(99999, self, role, true, nil, false, false, eHurtType.RealDmg, true)
  end)
  LuaSkillCtrl:StartTimer(nil, 30, function()
    LuaSkillCtrl:MoveRoleToTarget(self, grid1, self.hero, false, BindCallback(self, self.storyFlow2))
  end)
  LuaSkillCtrl:StartTimer(nil, 15, BindCallback(self, self.PlayCorrode), nil, 1)
end

function bs_20263:storyFlow2()
  local grid = LuaSkillCtrl:GetGridWithPos(4, 2)
  LuaSkillCtrl:MoveRoleToTarget(self, grid, self.hero, true, BindCallback(self, self.storyFlow2_cb))
  LuaSkillCtrl:StartTimer(nil, 7, BindCallback(self, self.PlayCorrode), nil, 5)
end

function bs_20263:storyFlow2_cb()
  LuaSkillCtrl:StartTimer(nil, 20, function()
    self:storyFlow3()
  end)
end

function bs_20263:storyFlow3()
  local grid = LuaSkillCtrl:GetGridWithPos(5, 2)
  local cb = BindCallback(self, self.storyFlow4)
  LuaSkillCtrl:MoveRoleToTarget(self, grid, self.hero, false, BindCallback(self, self.storyFlow3_cb))
  LuaSkillCtrl:StartTimer(nil, 15, BindCallback(self, self.PlayCorrode), nil)
end

function bs_20263:storyFlow3_cb()
  LuaSkillCtrl:StartTimer(nil, 20, function()
    self:PlayAVGwithCount(BindCallback(self, self.storyFlow4))
  end)
end

function bs_20263:storyFlow4()
  LuaSkillCtrl:CallEffect(self.hero, self.config.CorrodeEffect[2], self)
  LuaSkillCtrl:CallBattleCamShakeByParam(0, 1.2, 1, 30)
  LuaSkillCtrl:StartTimer(nil, 7, function()
    self:CallScreenEffect()
  end, nil, 10)
  LuaSkillCtrl:SetGameScoreValue(4, 1000)
  LuaSkillCtrl:CallStartLocalScale(self.hero, Vector3.New(0, 0, 0), 0.2)
  LuaSkillCtrl:StartTimer(nil, 50, function()
    self:EndGame()
  end)
end

function bs_20263:EndGame()
  LuaSkillCtrl:ForceEndBattle(true)
end

function bs_20263:CallScreenEffect()
  if self.progress < 4 and self.ScreenEffectDegree < 0.7 then
    self.ScreenEffectDegree = self.ScreenEffectDegree + 0.01
    LuaSkillCtrl:ShowCameraEffectFunction(3, self.ScreenEffectDegree)
  end
  if self.progress >= 4 then
    self.ScreenEffectDegree = self.ScreenEffectDegree + 0.5
    LuaSkillCtrl:ShowCameraEffectFunction(3, self.ScreenEffectDegree)
  end
end

function bs_20263:CollectCallBack()
  local nextBarNum = self.config.BarIncrease[self.CorrodeCount]
  local increase = nextBarNum - self.barProgress
  self.barProgress = self.barProgress + increase
  LuaSkillCtrl:SetGameScoreValue(4, self.barProgress)
  if self.config.BarNum[self.progress + 1] ~= nil and self.barProgress >= self.config.BarNum[self.progress + 1] then
    self.progress = self.progress + 1
    self:ProgressControl(self.progress)
  end
end

function bs_20263:PlayAVGwithCount(cb)
  if self.nextAVG > #self.config.AvgList then
    return
  end
  LuaSkillCtrl:StartAvgWithPauseGame(self.config.AvgList[self.nextAVG], nil, cb)
  self.nextAVG = self.nextAVG + 1
end

function bs_20263:StoryCallItem(progress)
  local range = LuaSkillCtrl:CallRange(1, #self.config.ItemGrid)
  local grids = self.config.ItemGrid[range]
  for k, v in ipairs(grids) do
    local range1 = LuaSkillCtrl:CallRange(1, 4)
    if v[1] == 2 and v[2] == 0 and self.isFirstCall == true then
      self.isFirstCall = false
      range = 2
    end
    local itemId = self.config.ItemDataId[range1]
    self:ItemBorn(itemId, v[1], v[2])
  end
  self:RefershCD(self)
end

function bs_20263:ItemBorn(ItemId, x, y)
  local summonerId = ItemId
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
  local role = LuaSkillCtrl:GetRoleWithPos(x, y)
  for k, v in ipairs(self.config.Item_buff_list) do
    LuaSkillCtrl:CallBuff(self, role, v, 1, nil, true, role)
  end
end

function bs_20263:CorrodeItem(target)
  if target == nil then
    return
  end
  local effectId = self.config.CorrodeEffect[1]
  LuaSkillCtrl:CallEffect(target, self.config.CorrodeEffect[1], self)
  LuaSkillCtrl:StartTimer(nil, 20, BindCallback(self, self.DestoryItem, target, effectId))
end

function bs_20263:DestoryItem(target, effect)
  if effect ~= nil then
    effect = nil
  end
  for k, v in ipairs(self.config.Item_buff_list) do
    LuaSkillCtrl:DispelBuff(target, v, 0, true, false)
  end
  LuaSkillCtrl:RemoveLife(99999, self, target, false, nil, true, true, eHurtType.RealDmg, true)
  self.CorrodeCount = self.CorrodeCount + 1
  self:CollectCallBack()
  if self.CorrodeCount % 6 == 0 then
    if self.CorrodeCount >= #self.config.BarIncrease then
      return
    end
    if self.barProgress ~= 990 then
      LuaSkillCtrl:StartTimer(nil, 50, BindCallback(self, self.StoryCallItem, self.progress), nil)
    end
  end
end

function bs_20263:CallAddMP()
  LuaSkillCtrl:CallAddPlayerHmp(ConfigData.game_config.ultMpCost + 1000)
end

function bs_20263:PlayCorrode()
  if self.nextGroup > #self.config.grid_shang then
    return
  end
  local gridGroup = self.config.grid_shang[self.nextGroup]
  for k, v in ipairs(gridGroup) do
    local role = LuaSkillCtrl:GetRoleWithPos(v[1], v[2])
    if role ~= nil and (role.roleDataId == 1024 or role.roleDataId == 1025) then
      self:CorrodeRole(role)
    end
    LuaSkillCtrl:StartTimer(nil, 30, function()
      LuaSkillCtrl:CallCreateEfcGrid(v[1], v[2], self.config.CorrodeGridId)
    end)
  end
  self.nextGroup = self.nextGroup + 1
end

function bs_20263:CorrodeRole(role)
  if role == nil then
    return
  end
  for k, v in ipairs(self.config.Item_buff_list) do
    LuaSkillCtrl:DispelBuff(role, v, 0, true, false)
  end
  LuaSkillCtrl:StartTimer(nil, 30, function()
    LuaSkillCtrl:RemoveLife(99999, self, role, false, nil, true, true, eHurtType.RealDmg, true)
  end)
end

function bs_20263:MuteUlt(self)
  local costurlnum = 0 - LuaSkillCtrl:GetUltHMp()
  LuaSkillCtrl:CallAddPlayerHmp(costurlnum)
end

function bs_20263:LuaDispose()
  base.LuaDispose(self)
  LuaSkillCtrl:CloseCameraEffectFunction(3, true)
end

function bs_20263:OnCasterDie()
  base.OnCasterDie(self)
  LuaSkillCtrl:CloseCameraEffectFunction(3, true)
end

return bs_20263
