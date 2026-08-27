local bs_20261 = class("bs_20261", LuaSkillBase)
local base = LuaSkillBase
bs_20261.config = {
  timeDuration = 15,
  storyWait = 30,
  storyFlow = {
    38,
    20,
    1
  },
  gridId = 1132,
  grid_shang = {
    {
      {3, 1},
      {4, 0},
      {5, 0},
      {5, 1},
      {5, 2},
      {4, 2}
    },
    {
      {3, 0},
      {6, 0},
      {3, 2},
      {6, 2}
    },
    {
      {2, 2},
      {1, 1},
      {1, 3},
      {7, 2},
      {7, 1},
      {7, 3}
    },
    {
      {0, 3},
      {0, 2},
      {0, 1},
      {8, 1},
      {9, 2},
      {8, 3},
      {0, 0},
      {9, 0}
    },
    {
      {1, 2},
      {8, 2}
    },
    {
      {1, 0},
      {2, 0},
      {2, 1},
      {8, 0},
      {7, 0},
      {6, 1}
    },
    {
      {1, 4},
      {8, 4}
    },
    {
      {0, 5},
      {0, 6},
      {1, 5},
      {2, 6},
      {8, 5},
      {7, 5},
      {7, 6},
      {9, 6},
      {2, 3},
      {6, 3}
    },
    {
      {1, 6},
      {8, 6}
    },
    {
      {3, 3},
      {3, 4},
      {2, 5},
      {3, 6},
      {5, 3},
      {6, 4},
      {6, 5},
      {6, 6},
      {4, 3}
    },
    {
      {3, 5},
      {5, 5}
    },
    {
      {4, 4},
      {5, 4},
      {4, 6},
      {5, 6}
    }
  },
  corrodeSpeeds = {
    4,
    2,
    2
  },
  corrodeItems = {
    {0, 0},
    {9, 0},
    {1, 2},
    {8, 2},
    {1, 6},
    {8, 6}
  },
  dbGrids = {
    {
      {0, 6},
      {9, 6}
    },
    {
      {1, 6},
      {8, 6}
    },
    {
      {2, 6},
      {7, 6}
    },
    {
      {3, 6},
      {5, 6}
    },
    {
      {4, 6},
      {5, 6}
    }
  },
  dbEffect = 70001,
  summonerId = {
    1000023,
    1000024,
    1000025,
    1000026
  },
  effectId_down = 10936,
  buffId_1000 = 1000,
  maxHpPer = 150,
  powPer = 700,
  skill_intensityPer = 700,
  critPer = 1000,
  critDamagePer = 1000,
  defPer = 1000,
  sunderPer = 1000,
  magic_resPer = 1000,
  magic_penPer = 1000,
  buffGrid = {
    {1, 2},
    {8, 2},
    {1, 6},
    {8, 6}
  },
  buff_miansi = 88,
  buff_bati = 198,
  buff_xuanyun = 1000,
  effect_shang = 503,
  effect_bomb = 212501,
  effect_xuanyun = 1,
  effectId_bomb_loop = 212500,
  effectId_bomb_end = 212501,
  action_loop_time = 75,
  buff_jitui = 1278,
  effect_end = 501102,
  effect_jitui = 12065,
  grid_out = {
    {3, 5},
    {4, 6},
    {5, 6},
    {5, 5},
    {5, 4},
    {4, 4}
  }
}

function bs_20261:ctor()
end

function bs_20261:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.timeValue = self.arglist[1]
  self.totalTime = self.arglist[1]
  self.nextGroup = 1
  self.corrodeSpeed = 5
  self.corrodeCount = 0
  self.corrodeItem = {}
  self.roleNext = 0
  self.isLastLevel = false
  if self.arglist[2] == 1 then
    self.isLastLevel = true
  end
  LuaSkillCtrl:SetGameScoreAcitve(2, true)
  LuaSkillCtrl:SetGameScoreValue(2, self.timeValue // 15)
  local arriveCallBack = BindCallback(self, self.OnArriveAction)
  self.countTimer = LuaSkillCtrl:StartTimer(nil, self.config.timeDuration, arriveCallBack, self, -1)
  self.isStopCount = false
  self.call_grid = {}
end

function bs_20261:AfterBattleStart()
  for k, v in ipairs(self.config.buffGrid) do
    local role = LuaSkillCtrl:GetRoleWithPos(v[1], v[2])
    if role ~= nil then
      LuaSkillCtrl:CallBuff(self, role, self.config.buff_miansi, 1, nil, true, role)
      LuaSkillCtrl:CallBuff(self, role, self.config.buff_bati, 1, nil, true, role)
    end
  end
end

function bs_20261:OnArriveAction()
  self.corrodeCount = self.corrodeCount + 1
  if self.corrodeCount >= self.corrodeSpeed then
    self:PlayCorrode()
    self.corrodeCount = 0
  end
  if self.isStopCount then
    return
  end
  self.timeValue = self.timeValue - self.config.timeDuration
  local showTime = self.timeValue // 15
  LuaSkillCtrl:SetGameScoreValue(2, showTime)
  if showTime == self.config.storyFlow[1] then
    self:storyFlow1()
  elseif showTime == self.config.storyFlow[2] then
    self:storyFlow2()
  elseif showTime == self.config.storyFlow[3] then
    self:storyFlow3()
  end
end

function bs_20261:storyFlow1()
  LuaSkillCtrl:StartAvgWithPauseGame("23summer_s05_2", nil, BindCallback(self, self.storyFlow1_cb))
  self.corrodeSpeed = self.config.corrodeSpeeds[1]
end

function bs_20261:storyFlow1_cb()
  LuaSkillCtrl:StartTimer(nil, 45, function()
    local list = {
      {1, 1},
      {7, 1},
      {1, 4},
      {3, 4}
    }
    local range = LuaSkillCtrl:CallRange(1, 4)
    self:RandomCallMonster(list[range][1], list[range][2])
  end, self, -1, 6)
end

function bs_20261:storyFlow2()
  LuaSkillCtrl:StartAvgWithPauseGame("23summer_s05_3", nil, BindCallback(self, self.StoryDestroy))
  self.corrodeSpeed = self.config.corrodeSpeeds[2]
end

function bs_20261:storyFlow3()
  self.isStopCount = true
  self.corrodeSpeed = self.config.corrodeSpeeds[3]
  local story4 = BindCallback(self, self.storyFlow4)
  local summonerNum = 7
  self.SummonerCount = 0
  LuaSkillCtrl:CallBattleCamShakeByParam(0, 2, 1, 50)
  self.timer_callMonster = LuaSkillCtrl:StartTimer(nil, 15, BindCallback(self, self.TimerCallMonster, story4, summonerNum), self, summonerNum - 1, 15)
end

function bs_20261:storyFlow4()
  local story5 = BindCallback(self, self.storyFlow5)
  LuaSkillCtrl:StartAvgWithPauseGame("23summer_s05_4", nil, story5)
end

function bs_20261:storyFlow5()
  LuaSkillCtrl:StartTimer(nil, 7, function()
    local pf = LuaSkillCtrl:GetGuardProfession()
    LuaSkillCtrl:CallEffect(pf, self.config.effect_end, self)
    local enemyList = LuaSkillCtrl:GetAllEnmyRoles()
    for i = 1, #enemyList do
      if enemyList[i] ~= nil then
        LuaSkillCtrl:CallBuff(self, enemyList[i], self.config.buff_jitui, 1, 7, true, pf)
        LuaSkillCtrl:RemoveLife(999999, self, enemyList[i], false, nil, true, true, eHurtType.RealDmg, true)
      end
    end
    local roleList = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
    local nextpos = 1
    for i = 0, roleList.Count - 1 do
      if roleList[i] ~= nil then
        LuaSkillCtrl:CallBuff(self, roleList[i], self.config.buff_xuanyun, 1, 999, true, roleList[i])
      end
    end
    if self.timer_callMonster ~= nil then
      self.timer_callMonster:Stop()
      self.timer_callMonster = nil
    end
    LuaSkillCtrl:StartTimer(nil, 20, BindCallback(self, self.TPOut, roleList), nil, roleList.Count)
    LuaSkillCtrl:StartTimer(nil, 90, BindCallback(self, self.EndGame))
  end)
end

function bs_20261:TPOut(roleList)
  if self.roleNext == roleList.Count then
    self:EndGame()
  end
  if self.roleNext < roleList.Count then
    LuaSkillCtrl:CallEffect(roleList[self.roleNext], self.config.effect_end, self)
    LuaSkillCtrl:CallStartLocalScale(roleList[self.roleNext], Vector3.New(0.0, 0.0, 0.0), 0.1)
  end
  self.roleNext = self.roleNext + 1
end

function bs_20261:EndGame()
  LuaSkillCtrl:ForceEndBattle(true)
end

function bs_20261:TimerCallMonster(cb, summonerNum)
  local grid1 = LuaSkillCtrl:FindEmptyGridsWithinRange(0, 3, 3)
  local grid2 = LuaSkillCtrl:FindEmptyGridsWithinRange(8, 3, 3)
  self:RandomCallMonster(grid1[0].x, grid1[0].y)
  self:RandomCallMonster(grid2[0].x, grid2[0].y)
  self.SummonerCount = self.SummonerCount + 1
  if self.SummonerCount > summonerNum - 1 then
    LuaSkillCtrl:StartTimer(nil, self.config.storyWait, cb, self)
  end
end

function bs_20261:RandomCallMonster(x, y)
  local range = LuaSkillCtrl:CallRange(1, 4)
  local summonerId = self.config.summonerId[range]
  local role = LuaSkillCtrl:GetRoleWithPos(x, y)
  if role ~= nil then
    local grid = LuaSkillCtrl:FindEmptyGridAroundRole(role)
    if grid == nil then
      return
    end
    x, y = grid.x, grid.y
  end
  LuaSkillCtrl:StartTimer(nil, 15, function()
    local role_temp = LuaSkillCtrl:GetRoleWithPos(x, y)
    if role_temp ~= nil then
      local temp_grid = LuaSkillCtrl:FindEmptyGridWithinRange(role_temp, 3)
      x, y = temp_grid.x, temp_grid.y
    end
    local summoner = LuaSkillCtrl:CreateSummoner(self, summonerId, x, y, eBattleRoleBelong.enemy)
    summoner:SetAttr(eHeroAttr.maxHp, self.caster.maxHp * self.config.maxHpPer // 1000)
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
  end)
  local target = LuaSkillCtrl:GetTargetWithGrid(x, y)
  LuaSkillCtrl:CallEffect(target, self.config.effectId_down, self)
end

function bs_20261:StoryDestroy()
  self.skill_left = 0
  LuaSkillCtrl:StartTimer(nil, 15, function()
    for k, v in ipairs(self.config.corrodeItems) do
      local role = LuaSkillCtrl:GetRoleWithPos(v[1], v[2])
      if role ~= nil then
        self.effect_loop_212500 = LuaSkillCtrl:CallEffect(role, self.config.effectId_bomb_loop, self)
        LuaSkillCtrl:EffectSetCountValue(self.effect_loop_212500, self.skill_left)
        if self.skill_left > 4 then
          LuaSkillCtrl:DispelBuff(role, self.config.buff_miansi, 0, true, false)
          LuaSkillCtrl:CallEffect(role, self.config.effect_bomb, self, nil, role)
          LuaSkillCtrl:RemoveLife(999999, self, role, false, nil, true, true, eHurtType.RealDmg, true)
        end
      end
    end
    self.skill_left = self.skill_left + 1
  end, 4, 15)
end

function bs_20261:PlayCorrode()
  if self.nextGroup > #self.config.grid_shang then
    return
  end
  local gridGroup = self.config.grid_shang[self.nextGroup]
  for k, v in ipairs(gridGroup) do
    LuaSkillCtrl:CallCreateEfcGrid(v[1], v[2], self.config.gridId)
    local role = LuaSkillCtrl:GetRoleWithPos(v[1], v[2])
    if role ~= nil and (role.roleDataId == 1018 or role.roleDataId == 1017 or role.roleDataId == 1000) then
      self:CorrodeRole(role)
    end
  end
  self.nextGroup = self.nextGroup + 1
end

function bs_20261:CorrodeRole(role)
  if role == nil then
    return
  end
  self.corrodeItem[#self.corrodeItem + 1] = role
  LuaSkillCtrl:CallEffect(role, self.config.effect_shang, self)
  LuaSkillCtrl:CallBuff(self, role, self.config.buff_xuanyun, 1, nil, true, role)
end

function bs_20261:LuaDispose()
  base.LuaDispose(self)
  if self.timer_callMonster ~= nil then
    self.timer_callMonster:Stop()
    self.timer_callMonster = nil
  end
end

function bs_20261:OnCasterDie()
  base.OnCasterDie(self)
  if self.timer_callMonster ~= nil then
    self.timer_callMonster:Stop()
    self.timer_callMonster = nil
  end
end

return bs_20261
