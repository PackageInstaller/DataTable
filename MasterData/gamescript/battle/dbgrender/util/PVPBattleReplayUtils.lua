local PVPBattleReplayUtils = {}

function PVPBattleReplayUtils.PlayPVPReplay(battleUuid, watchUid, callback)
  local panelOpenMap, panelOpenParams = PVPBattleReplayUtils.GetPanelOpenedInfo()
  UIManager.Instance:Reopen(Urls.PVPReplayBattlePanel, battleUuid, watchUid, function()
    if not bg.battleData then
      return
    end
    PVPBattleReplayUtils.BattleReplayBack(panelOpenMap, panelOpenParams)
  end)
end

function PVPBattleReplayUtils.GetPanelOpenedInfo()
  local panelOpenMap = {
    [Urls.SocialOtherPlayerInfoPanel] = UIManager.Instance:GetWindow(Urls.SocialOtherPlayerInfoPanel),
    [Urls.SocialPlayerInfoPanel] = UIManager.Instance:GetWindow(Urls.SocialPlayerInfoPanel),
    [Urls.DailyChallengeBoardEntryPanel] = UIManager.Instance:GetWindow(Urls.DailyChallengeBoardEntryPanel),
    [Urls.CopyRecordsView] = UIManager.Instance:GetWindow(Urls.CopyRecordsView),
    [Urls.AbyssRankView] = UIManager.Instance:GetWindow(Urls.AbyssRankView)
  }
  local panelOpenParams = {}
  if panelOpenMap[Urls.AbyssRankView] then
    panelOpenParams.callback = PVPBattleReplayUtils.OnReturnToAbyssRankView
  end
  return panelOpenMap, panelOpenParams
end

function PVPBattleReplayUtils.OnReturnToAbyssRankView()
  StageExitPanelManager.Instance:PushOnlyCallback(function()
    UIManager.Instance:Reopen(Urls.AbyssView)
    FrameWaiter.OnNextFrame(function()
      local activityTid = AbyssExtModel.Instance:GetCurrActivityTid()
      AbyssController.Instance:OpenAbyssRankView(activityTid)
    end, 3)
  end, Urls.AbyssView)
  StageExitPanelManager.Instance:OnStageExit()
end

function PVPBattleReplayUtils.BattleReplayBack(panelOpenMap, panelOpenParams)
  if not bg.battleData then
    return
  end
  panelOpenMap = panelOpenMap or {}
  panelOpenParams = panelOpenParams or {}
  local isPVE = bg.battleData.gameplayType == bc.BattleGameplayType.PVE
  local isPVP = bg.battleData.gameplayType == bc.BattleGameplayType.PVP
  if panelOpenMap[Urls.SocialPlayerInfoPanel] or panelOpenMap[Urls.SocialOtherPlayerInfoPanel] then
    local targetUid = panelOpenMap[Urls.SocialPlayerInfoPanel] and PlayerDataUtils.GetPlayerUid() or CopyRecordsModel.Instance:GetOtherRecordUid()
    local playerPanelType = isPVE and CommonDefine.PlayerPanelType.PVE or CommonDefine.PlayerPanelType.PVP
    StageExitPanelManager.Instance:PushOnlyCallback(function()
      SocialDataUtils.OpenPlayerInfoPanel(SocialDefine.PlayerInfoPage.Overview, targetUid, playerPanelType)
    end)
    StageExitPanelManager.Instance:OnStageExit()
  elseif not bg.battleData then
    SceneMgr.Instance:EnterTown()
  elseif isPVE then
    if panelOpenParams.callback then
      panelOpenParams.callback()
      return
    end
    local stageTid = bg.battleData and bg.battleData.stageId
    if stageTid then
      StageExitPanelManager.Instance:PushWhenWorldStageRecover(stageTid)
      StageExitPanelManager.Instance:OnStageExit()
      if panelOpenMap[Urls.CopyRecordsView] then
        CopyRecordsController.Instance:OpenCopyRecordsView(stageTid)
      elseif panelOpenMap[Urls.DailyChallengeBoardEntryPanel] then
        RankingBoardDataUtils.OpenDailyChallengeBoardEntryPanel()
      end
    end
  elseif isPVP then
    SceneMgr.Instance:EnterTown()
  else
    SceneMgr.Instance:EnterTown()
  end
end

function PVPBattleReplayUtils.CloseReplay()
  UIManager.Instance:CloseByUrl(Urls.PVEReplayBattlePanel)
  UIManager.Instance:CloseByUrl(Urls.PVPReplayBattlePanel)
end

function PVPBattleReplayUtils.GetShareContentFromCurBattle()
  if not bg.battleData then
    return
  end
  local recordData = {}
  recordData.battleUuid = bg.battleData.battleUuid
  recordData.statsData = PvPSettleDataUtils.GetStatsData()
  recordData.selfUid = DataCenter.playerData.DRole.uid
  recordData.opponentUid = 0
  for uid, stats in pairs(recordData.statsData) do
    if uid ~= recordData.selfUid then
      recordData.opponentUid = uid
      break
    end
  end
  do return PVPBattleReplayUtils.GetShareContent end
  return PVPBattleReplayUtils.GetShareContent, recordData, pairs(recordData.statsData)
end

function PVPBattleReplayUtils.GetPlayCode(battleType, battleUuid, playerUid)
  local base52PlayerUid = PVPBattleReplayUtils.DecimalToBase52(playerUid)
  local playCode = string.format("%s#%s#%s", battleUuid, battleType, base52PlayerUid)
  print("------------play code and share code", playCode)
  return playCode
end

function PVPBattleReplayUtils.ParsePlayCode(playCode)
  local slotDataList = string.split(playCode, "#")
  local battleUuid = slotDataList[1]
  local replayType = slotDataList[2]
  local base52PlayerUid = slotDataList[3]
  local playerUid = PVPBattleReplayUtils.Base52ToDecimal(base52PlayerUid)
  print("-------------parse play code", battleUuid, replayType, playerUid)
  return {
    replayType = replayType,
    battleUuid = battleUuid,
    playerUid = tonumber(playerUid or 0)
  }
end

function PVPBattleReplayUtils.GetShareContent(recordData)
  local shareCode = LT.Text("PvPReplayCode")
  local GetCollectionName = PvpCollectCfgUtils.GetCollectionName
  local replaceMap = {}
  local replayType = CommonDefine.ReplayType.PVP
  replaceMap[0] = PVPBattleReplayUtils.GetPlayCode(replayType, recordData.battleUuid, recordData.selfUid)
  replaceMap[1] = LT.Text(PlayerDataUtils.GetName() or "")
  replaceMap[2] = PlayerDataUtils.GetPlayerUid()
  replaceMap[25] = PvpDefine.GetPVPModeName(recordData.matchType, recordData.pvpType)
  replaceMap[26] = recordData.selfUid
  replaceMap[27] = recordData.opponentUid
  local statsData = recordData.statsData
  local selfUid = recordData.selfUid
  local playerData = statsData[selfUid]
  replaceMap[3] = playerData.name
  for i = 1, 4 do
    local awakerIndex = 4
    local awaker = playerData.awakerList[i]
    local tid = awaker and awaker.awakers.tid
    local awakerName = GetCollectionName(tid)
    if awakerName then
      replaceMap[i + awakerIndex - 1] = awakerName
    end
  end
  for i = 1, 4 do
    local weaponIndex = 8
    local weapon = playerData.weaponList[i]
    local weaponName = GetCollectionName(weapon and weapon.tid)
    if weaponName then
      replaceMap[i + weaponIndex - 1] = weaponName
    end
  end
  replaceMap[12] = GetCollectionName(playerData.keeperSkillList[1] and playerData.keeperSkillList[1].tid)
  replaceMap[13] = GetCollectionName(playerData.keeperSkillList[2] and playerData.keeperSkillList[2].tid)
  local opponentUid = recordData.opponentUid
  playerData = statsData[opponentUid]
  replaceMap[14] = LT.Text(playerData.name or "")
  for i = 1, 4 do
    local awakerIndex = 15
    local awaker = playerData.awakerList[i]
    local tid = awaker and awaker.awakers.tid
    local awakerName = GetCollectionName(tid)
    if awakerName then
      replaceMap[i + awakerIndex - 1] = awakerName
    end
  end
  for i = 1, 4 do
    local weaponIndex = 19
    local weapon = playerData.weaponList[i]
    local weaponName = GetCollectionName(weapon and weapon.tid)
    if weaponName then
      replaceMap[i + weaponIndex - 1] = weaponName
    end
  end
  replaceMap[23] = GetCollectionName(playerData.keeperSkillList[1] and playerData.keeperSkillList[1].tid)
  replaceMap[24] = GetCollectionName(playerData.keeperSkillList[2] and playerData.keeperSkillList[2].tid)
  for k, v in pairs(replaceMap) do
    shareCode = shareCode:replace(string.format("{%s}", k), v)
  end
  return shareCode
end

function PVPBattleReplayUtils.GetReplayInfoFromCode(shareCode)
  local battle_uid_pattern = "%w+-%w+-%w+-%w+-%w+#%w#%w+"
  local matchedStr = string.match(shareCode, battle_uid_pattern)
  if not matchedStr then
    return
  end
  local _, replayInfo = xpcall(function()
    do return PVPBattleReplayUtils.ParsePlayCode end
    return PVPBattleReplayUtils.ParsePlayCode, matchedStr
  end, function(err)
    Logger.Warn("解析对战回放码失败: %s", err)
  end)
  return replayInfo
end

function PVPBattleReplayUtils.GetPvPReplayDetail(battleUuid, playerUid, cb)
  ProtoManager.Instance:ReqServer("GameRequest", "GetReplayDetail", function(recordData)
    if cb then
      cb(recordData)
    end
  end, function()
  end, battleUuid, playerUid)
end

function PVPBattleReplayUtils.DecimalToBase52(n)
  local characters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
  local base = 52
  local result = ""
  while n > 0 do
    local remainder = n % base
    result = string.sub(characters, remainder + 1, remainder + 1) .. result
    n = math.floor(n / base)
  end
  if "" == result then
    result = "a"
  end
  return result
end

function PVPBattleReplayUtils.Base52ToDecimal(s)
  local characters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
  local base = 52
  local length = #s
  local result = 0
  for i = 1, length do
    local char = string.sub(s, i, i)
    local value = string.find(characters, char) - 1
    result = result * base + value
  end
  return result
end

return PVPBattleReplayUtils
