_class("SerialAutoFightModule", GameModule)
SerialAutoFightModule = SerialAutoFightModule

function SerialAutoFightModule:Constructor()
  self:ResetModuleData()
  self:ResetAutoPickStuff()
  self:AttachEvent(GameEventType.UIShowEnd, self.OnUIShowEnd)
end

function SerialAutoFightModule:ResetModuleData()
  self._matchType = nil
  self._missionId = 0
  self._taskId = 0
  self._running = false
  self._winCount = 0
  self._fightCount = 0
  self._totalCount = 0
  self._battleResultComplated = false
  self._inited = false
  self._rewardList = {}
  self._activityRewardList = {}
  self._returnHelpRewardList = {}
  self._waitingUI = {}
  self._waitTime = 3
  self._campaignWaitUI = nil
  self._autoDatas = nil
  self._matchResult = {}
end

function SerialAutoFightModule:ResetAutoPickStuff()
  self._apStuff = SerialAutoPickStuffData:New()
  self._jumpData = SerialAutoFightJumpData:New()
end

function SerialAutoFightModule:GetApsData()
  return self._apStuff
end

function SerialAutoFightModule:GetJumpData()
  return self._jumpData
end

function SerialAutoFightModule:Dispose()
  GameModule.Dispose(self)
  self._apStuff:Dispose()
  self._apStuff = nil
  self._jumpData:Dispose()
  self._jumpData = nil
end

function SerialAutoFightModule:SetAutoFightDatas(matchType, totalCount, autoData)
  self:ResetModuleData()
  self._matchType = matchType
  self._totalCount = totalCount
  self._autoDatas = autoData
  self._inited = true
  self._apStuff:SetAutoFight()
end

function SerialAutoFightModule:SetSerialAutoFight(matchType, totalCount, campWaitUI, towerData)
  self:ResetModuleData()
  self._matchType = matchType
  self._totalCount = totalCount
  self._inited = true
  self._campaignWaitUI = campWaitUI
  self._towerData = towerData
  self._apStuff:SetAutoFight()
end

function SerialAutoFightModule.QuickSetData(active, matchType, totalCount, campWaitUI, towerData)
  local module = GameGlobal.GetModule(SerialAutoFightModule)
  if active then
    module:SetSerialAutoFight(matchType, totalCount, campWaitUI, towerData)
  else
    module:ResetModuleData()
  end
end

function SerialAutoFightModule.QuickSetData_Campaign(active, campaignType, matchType, totalCount)
  local campStageUI, campWaitUI = CampaignConst.GetCampaignAutoFightInfo(campaignType)
  SerialAutoFightModule.QuickSetData(active, matchType, totalCount, campWaitUI)
end

function SerialAutoFightModule.QuickSetData_Tower(active, id)
  SerialAutoFightModule.QuickSetData(active, MatchType.MT_Tower, 99999, nil, {id = id})
end

function SerialAutoFightModule:CancelSerialAutoFight()
  GameGlobal.TaskManager():KillTask(self._taskId)
  self:ResetModuleData()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.CancelSerialAutoFight)
end

function SerialAutoFightModule:GetTicketCount()
  if not self._inited then
    return 0
  end
  if not self._autoDatas then
    return 0
  end
  local autoData = self._autoDatas[self._fightCount + 1]
  if not autoData then
    return 0
  end
  return autoData.ticketCount
end

function SerialAutoFightModule:GetTicketCountByIndex(idx)
  if not self._inited then
    return 0
  end
  if not self._autoDatas then
    return 0
  end
  local autoData = self._autoDatas[idx]
  if not autoData then
    return 0
  end
  return autoData.ticketCount
end

function SerialAutoFightModule:GetAutoFightDatas_Tower()
  return self._towerData and self._towerData.id
end

function SerialAutoFightModule:GetMatchType()
  return self._matchType
end

function SerialAutoFightModule:IsInited()
  return self._inited
end

function SerialAutoFightModule:IsRunning()
  return self._running
end

function SerialAutoFightModule:GetWinCount()
  return self._winCount
end

function SerialAutoFightModule:GetFightCount()
  return self._fightCount
end

function SerialAutoFightModule:GetTotalCount()
  return self._totalCount
end

function SerialAutoFightModule:GetRewardList()
  return self._rewardList
end

function SerialAutoFightModule:GetResult()
  return self._matchResult
end

function SerialAutoFightModule:GetActivityRewardList()
  return self._activityRewardList
end

function SerialAutoFightModule:GetReturnHelpRewardList()
  return self._returnHelpRewardList
end

function SerialAutoFightModule:GetWaitTime()
  return self._waitTime
end

function SerialAutoFightModule:SetBattleResultComplated()
  self._battleResultComplated = true
end

function SerialAutoFightModule:OnUIShowEnd(uiName, uiParams)
  local cb = self._waitingUI[uiName]
  if cb then
    cb(uiParams)
    self._waitingUI[uiName] = nil
  end
end

function SerialAutoFightModule:WaitForUIShow(TT, uiName, callback)
  self._waitingUI[uiName] = callback
  while self._waitingUI[uiName] do
    YIELD(TT, 200)
  end
end

function SerialAutoFightModule:StartSerialFight()
  if not self._inited then
    return
  end
  if self._running then
    return
  end
  self._running = true
  self._taskId = GameGlobal.TaskManager():StartTask(function(TT)
    if self._matchType == MatchType.MT_Mission then
      self:_DoAutoFight(TT)
      self:WaitForUIShow(TT, "UIDiscovery", function()
        GameGlobal.EventDispatcher():Dispatch(GameEventType.FakeInput, {
          ui = "UIDiscovery",
          input = "ShowSerialRewards",
          args = {}
        })
      end)
    elseif self._matchType == MatchType.MT_Tower then
      self:_DoAutoFight(TT)
      self:WaitForUIShow(TT, "UITowerLayerController", function()
        GameGlobal.EventDispatcher():Dispatch(GameEventType.FakeInput, {
          ui = "UITowerLayerController",
          input = "ShowSerialRewards",
          args = {}
        })
      end)
    elseif self._matchType == MatchType.MT_ResDungeon then
      self:_DoAutoFight(TT)
      self:WaitForUIShow(TT, "UIResDetailController", function()
        GameGlobal.EventDispatcher():Dispatch(GameEventType.FakeInput, {
          ui = "UIResDetailController",
          input = "ShowSerialRewards",
          args = {}
        })
      end)
    elseif self._matchType == MatchType.MT_Campaign then
      self:_DoAutoFight(TT)
      self:WaitForUIShow(TT, self._campaignWaitUI, function()
        GameGlobal.EventDispatcher():Dispatch(GameEventType.FakeInput, {
          ui = self._campaignWaitUI,
          input = "ShowSerialRewards",
          args = {}
        })
      end)
    elseif self._matchType == MatchType.MT_Season then
      self:_DoAutoFight(TT)
      self:WaitForUIShow(TT, self._campaignWaitUI, function()
        GameGlobal.EventDispatcher():Dispatch(GameEventType.FakeInput, {
          ui = self._campaignWaitUI,
          input = "ShowSerialRewards",
          args = {}
        })
      end)
    end
  end)
end

function SerialAutoFightModule:_DoAutoFight(TT)
  while self._fightCount < self._totalCount do
    while not self._battleResultComplated do
      YIELD(TT, 100)
    end
    self._battleResultComplated = false
    local count = self._fightCount + 1
    self:_CalcRewards(count)
    if not self:_CheckRunning() then
      self._running = false
      GameGlobal.EventDispatcher():Dispatch(GameEventType.FakeInput, {
        ui = "UIBattleResultComplete",
        input = "bgOnClick",
        args = {}
      })
      self._fightCount = self._fightCount + 1
      self._totalCount = self._fightCount
      return
    end
    for waitTime = 3, 1, -1 do
      self._waitTime = waitTime
      GameGlobal.EventDispatcher():Dispatch(GameEventType.SerialAutoFightWaitTime, waitTime)
      YIELD(TT, 1000)
    end
    self:_NextFightInBattleResult()
    self._waitTime = 3
    YIELD(TT, 1000)
    for waitTime = 3, 1, -1 do
      self._waitTime = waitTime
      GameGlobal.EventDispatcher():Dispatch(GameEventType.SerialAutoFightWaitTime, waitTime)
      YIELD(TT, 1000)
    end
    self._waitTime = 3
    self._fightCount = self._fightCount + 1
    GameGlobal.EventDispatcher():Dispatch(GameEventType.FakeInput, {
      ui = "UITeams",
      input = "btnFightOnClick",
      args = {}
    })
  end
end

function SerialAutoFightModule:_CheckRunning(count)
  if self._matchType == MatchType.MT_Tower then
    local gameMatchModule = self:GetModule(GameMatchModule)
    local matchResult = gameMatchModule:GetMachResult()
    local isVictory = matchResult.m_bVictory
    local towerModule = GameGlobal.GetModule(TowerModule)
    local nextCfg = towerModule:GetNextStageCfg(matchResult.m_nID)
    local haveNext = nextCfg ~= nil
    return isVictory and haveNext
  else
    return self._fightCount + 1 < self._totalCount
  end
end

function SerialAutoFightModule:_NextFightInBattleResult()
  local func = self._matchType == MatchType.MT_Tower and "NextFightTeams_Tower" or "againFightBtnOnClick"
  GameGlobal.EventDispatcher():Dispatch(GameEventType.FakeInput, {
    ui = "UIBattleResultComplete",
    input = func,
    args = {}
  })
end

function SerialAutoFightModule:_CalcRewards(count)
  local gameMatchModule = self:GetModule(GameMatchModule)
  local matchResult = gameMatchModule:GetMachResult()
  table.insert(self._matchResult, matchResult.m_bVictory)
  if matchResult.m_bVictory then
    self._winCount = self._winCount + 1
    if table.count(matchResult.m_activity_rewards) > 0 then
      for index, value in ipairs(matchResult.m_activity_rewards) do
        value.type = StageAwardType.Activity
      end
      local activityAwards = {}
      table.appendArray(activityAwards, matchResult.m_activity_rewards)
      self._activityRewardList[count] = activityAwards
    else
      self._activityRewardList[count] = nil
    end
    if 0 < table.count(matchResult.m_back_rewards) then
      for index, value in ipairs(matchResult.m_back_rewards) do
        value.type = StageAwardType.Activity
      end
      local returnAwards = {}
      table.appendArray(returnAwards, matchResult.m_back_rewards)
      self._returnHelpRewardList[count] = returnAwards
    else
      self._returnHelpRewardList[count] = nil
    end
    local normalAwards = {}
    table.appendArray(normalAwards, matchResult.m_vecAwardNormal)
    table.appendArray(normalAwards, matchResult.m_vecAwardPerfect)
    table.appendArray(normalAwards, matchResult.m_vecExtAward)
    table.appendArray(normalAwards, matchResult.m_vecDoubleExtAward)
    table.appendArray(normalAwards, matchResult.m_vecFirstPassAward)
    table.sort(normalAwards, function(a, b)
      local qa = Cfg.cfg_item[a.assetid].Color
      local qb = Cfg.cfg_item[b.assetid].Color
      if qa == qb then
        return a.assetid < b.assetid
      end
      return qa > qb
    end)
    self._rewardList[count] = normalAwards
  else
    self._rewardList[count] = nil
  end
end

function SerialAutoFightModule:MergeRewards()
  local original = self._rewardList
  local map = {}
  self._mergedAwardList = {}
  for i = 1, self._totalCount do
    local awards = original[i]
    if awards then
      for i, reward in ipairs(awards) do
        if not map[reward.assetid] then
          map[reward.assetid] = reward.count
        else
          map[reward.assetid] = map[reward.assetid] + reward.count
        end
      end
    end
  end
  for id, cnt in pairs(map) do
    local asset = RoleAsset:New()
    asset.assetid = id
    asset.count = cnt
    self._mergedAwardList[#self._mergedAwardList + 1] = asset
  end
  table.sort(self._mergedAwardList, function(a, b)
    local qa = Cfg.cfg_item[a.assetid].Color
    local qb = Cfg.cfg_item[b.assetid].Color
    if qa == qb then
      return a.assetid < b.assetid
    end
    return qa > qb
  end)
  return self._mergedAwardList
end

function SerialAutoFightModule:GetMergedActivityRewards()
  local original = self._activityRewardList
  local map = {}
  self._mergedActivityRewardList = {}
  for i = 1, self._totalCount do
    local awards = original[i]
    if awards then
      for i, reward in ipairs(awards) do
        if not map[reward.assetid] then
          map[reward.assetid] = reward.count
        else
          map[reward.assetid] = map[reward.assetid] + reward.count
        end
      end
    end
  end
  for id, cnt in pairs(map) do
    local asset = RoleAsset:New()
    asset.assetid = id
    asset.count = cnt
    asset.type = StageAwardType.Activity
    self._mergedActivityRewardList[#self._mergedActivityRewardList + 1] = asset
  end
  table.sort(self._mergedActivityRewardList, function(a, b)
    local qa = Cfg.cfg_item[a.assetid].Color
    local qb = Cfg.cfg_item[b.assetid].Color
    if qa == qb then
      return a.assetid < b.assetid
    end
    return qa > qb
  end)
  return self._mergedActivityRewardList
end

function SerialAutoFightModule:GetMergedReturnHelpRewards()
  local original = self._returnHelpRewardList
  local map = {}
  self._mergedReturnHelpRewardList = {}
  for i = 1, self._totalCount do
    local awards = original[i]
    if awards then
      for i, reward in ipairs(awards) do
        if not map[reward.assetid] then
          map[reward.assetid] = reward.count
        else
          map[reward.assetid] = map[reward.assetid] + reward.count
        end
      end
    end
  end
  for id, cnt in pairs(map) do
    local asset = RoleAsset:New()
    asset.assetid = id
    asset.count = cnt
    asset.type = StageAwardType.Normal
    self._mergedReturnHelpRewardList[#self._mergedReturnHelpRewardList + 1] = asset
  end
  table.sort(self._mergedReturnHelpRewardList, function(a, b)
    local qa = Cfg.cfg_item[a.assetid].Color
    local qb = Cfg.cfg_item[b.assetid].Color
    if qa == qb then
      return a.assetid < b.assetid
    end
    return qa > qb
  end)
  return self._mergedReturnHelpRewardList
end

function SerialAutoFightModule:GetTotalRewards()
  local normal = self._rewardList or {}
  local activity = self._activityRewardList or {}
  local returnSys = self._returnHelpRewardList or {}
  local all = {
    normal,
    activity,
    returnSys
  }
  local total = {}
  for _, rewards in pairs(all) do
    for __, assets in pairs(rewards) do
      for ___, asset in pairs(assets) do
        local id = asset.assetid
        local count = asset.count
        if not total[id] then
          total[id] = NewRoleAsset(id, count)
          total[id].type = asset.type
        else
          total[id].count = total[id].count + count
        end
      end
    end
  end
  local total = table.toArray(total)
  table.sort(total, function(a, b)
    local qa = Cfg.cfg_item[a.assetid].Color
    local qb = Cfg.cfg_item[b.assetid].Color
    if qa == qb then
      return a.assetid < b.assetid
    end
    return qa > qb
  end)
  return total
end
