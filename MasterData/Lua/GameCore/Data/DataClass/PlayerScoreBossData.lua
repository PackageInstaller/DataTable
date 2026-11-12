local PlayerScoreBossData = class("PlayerScoreBossData")
local LocalData = require("GameCore.Data.LocalData")

function PlayerScoreBossData:Init()
  self.BattleLv = 0
  self:InitBaseData()
  self.isGetScInfo = false
  EventManager.Add(EventId.IsNewDay, self, self.OnEvent_NewDay)
  self:InitTableData()
  self:InitRankData()
end

function PlayerScoreBossData:InitTableData()
  self.tabScoreNeed = {}
  
  local function foreach_Base(baseData)
    self.tabScoreNeed[baseData.Star] = baseData.ScoreNeed
  end
  
  ForEachTableLine(DataTable.ScoreBossStar, foreach_Base)
  self.maxStarNeed = 0
  self.tabScoreBossReward = {}
  
  local function foreach_Base(baseData)
    self.tabScoreBossReward[baseData.Id] = baseData
    if self.maxStarNeed < baseData.StarNeed then
      self.maxStarNeed = baseData.StarNeed
    end
  end
  
  ForEachTableLine(DataTable.ScoreBossReward, foreach_Base)
end

function PlayerScoreBossData:UnInit()
  EventManager.Remove(EventId.IsNewDay, self, self.OnEvent_NewDay)
end

function PlayerScoreBossData:InitBaseData()
  self.ControlId = 0
  self.Score = 0
  self.Star = 0
  self.tabStarRewards = {}
  self.tabScoreBossLevel = {}
  self.OpenLevelGroup = {}
  self.StartTime = 0
  self.EndTime = 0
  self.tabCachedBuildId = {}
end

function PlayerScoreBossData:GetInitInfoState()
  if self.ControlId ~= 0 then
    local nCurTime = CS.ClientManager.Instance.serverTimeStamp
    local tmpControl = ConfigTable.GetData("ScoreBossControl", self.ControlId + 1)
    if tmpControl then
      local startTime = CS.ClientManager.Instance:ISO8601StrToTimeStamp(tmpControl.StartTime)
      if nCurTime >= startTime then
        self.isGetScInfo = false
      end
    end
  end
  return self.isGetScInfo
end

function PlayerScoreBossData:GetScoreBossInstanceData(openPanelCallBack)
  local function msgCallback(_, mapMsgData)
    self:CacheScoreBossInstanceData(mapMsgData, openPanelCallBack)
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.score_boss_info_req, {}, nil, msgCallback)
end

function PlayerScoreBossData:CacheScoreBossInstanceData(mapMsgData, openPanelCallBack)
  self:InitBaseData()
  if mapMsgData == nil or mapMsgData.ControlId == 0 then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("ScoreBoss_Season_Error"))
    return
  end
  self.ControlId = mapMsgData.ControlId
  self.Score = mapMsgData.Score
  self.Star = mapMsgData.Star
  for i, v in pairs(mapMsgData.StarRewards) do
    table.insert(self.tabStarRewards, v)
  end
  self.maxRankCount = 0
  
  local function foreach_Base(baseData)
    if baseData.SeasonId == self.ControlId then
      self.maxRankCount = self.maxRankCount + 1
    end
  end
  
  ForEachTableLine(DataTable.ScoreBossRank, foreach_Base)
  local scoreBossControl = ConfigTable.GetData("ScoreBossControl", self.ControlId)
  if scoreBossControl ~= nil then
    local levelGroup = scoreBossControl.LevelGroup
    if 0 < #levelGroup then
      for i = 1, #levelGroup do
        table.insert(self.OpenLevelGroup, levelGroup[i])
        local tab = {}
        tab.LevelId = levelGroup[i]
        tab.BuildId = 0
        tab.CharId = {
          0,
          0,
          0
        }
        tab.Score = 0
        tab.Star = 0
        tab.SkillScore = 0
        self.tabScoreBossLevel[levelGroup[i]] = tab
      end
    end
    self.StartTime = CS.ClientManager.Instance:ISO8601StrToTimeStamp(scoreBossControl.StartTime)
    self.EndTime = CS.ClientManager.Instance:ISO8601StrToTimeStamp(scoreBossControl.EndTime) - ConfigTable.GetConfigNumber("SeasonEndThreshold")
  end
  for i, v in pairs(mapMsgData.Levels) do
    if self.tabScoreBossLevel[v.LevelId] then
      self.tabScoreBossLevel[v.LevelId].BuildId = v.BuildId
      for i1 = 1, #v.CharIds do
        self.tabScoreBossLevel[v.LevelId].CharId[i1] = v.CharIds[i1]
      end
      self.tabScoreBossLevel[v.LevelId].Score = v.Score
      self.tabScoreBossLevel[v.LevelId].Star = v.Star
      self.tabScoreBossLevel[v.LevelId].SkillScore = v.SkillScore
    else
      printError("ScoreBossControl 下发数据和配置数据对不上")
    end
  end
  if not self.isGetScInfo then
    EventManager.Hit("Get_ScoreBoss_InfoReq")
  end
  self.isGetScInfo = true
  self:RefreshRedMsg()
  if openPanelCallBack then
    openPanelCallBack()
  end
end

function PlayerScoreBossData:RefreshRedMsg()
  self.isHave = false
  for i, v in ipairs(self.tabScoreBossReward) do
    if self.Star >= v.StarNeed and table.indexof(self.tabStarRewards, v.StarNeed) == 0 then
      self.isHave = true
      break
    end
  end
  RedDotManager.SetValid(RedDotDefine.Map_ScoreBossStar, nil, self.isHave)
end

function PlayerScoreBossData:UpdateRedDot(mapMsgData)
  if nil == mapMsgData then
    return
  end
  RedDotManager.SetValid(RedDotDefine.Map_ScoreBossStar, nil, mapMsgData.New)
end

function PlayerScoreBossData:ChangeTabScoreBossLevel(nLevelId, nBuildId, nScore, nStar, nBehaviorScore, isReplace, tabOtherLevelId)
  if isReplace then
    self.tabScoreBossLevel[nLevelId].BuildId = nBuildId
    self.tabScoreBossLevel[nLevelId].CharId = self.entryLevelChar
    self.tabScoreBossLevel[nLevelId].Score = nScore
    self.tabScoreBossLevel[nLevelId].Star = nStar
    self.tabScoreBossLevel[nLevelId].SkillScore = nBehaviorScore
  elseif nScore >= self.tabScoreBossLevel[nLevelId].Score then
    self.tabScoreBossLevel[nLevelId].BuildId = nBuildId
    self.tabScoreBossLevel[nLevelId].CharId = self.entryLevelChar
    self.tabScoreBossLevel[nLevelId].Score = nScore
    self.tabScoreBossLevel[nLevelId].Star = nStar
    self.tabScoreBossLevel[nLevelId].SkillScore = nBehaviorScore
  end
  if 0 < #tabOtherLevelId then
    for i, v in pairs(tabOtherLevelId) do
      local tmpLevelId = v
      self.tabScoreBossLevel[tmpLevelId].BuildId = 0
      self.tabScoreBossLevel[tmpLevelId].CharId = {
        0,
        0,
        0
      }
      self.tabScoreBossLevel[tmpLevelId].Score = 0
      self.tabScoreBossLevel[tmpLevelId].Star = 0
      self.tabScoreBossLevel[tmpLevelId].SkillScore = 0
    end
  end
  local _totalStar = 0
  local _totalScore = 0
  for i, v in pairs(self.tabScoreBossLevel) do
    _totalStar = _totalStar + v.Star
    _totalScore = _totalScore + v.Score
  end
  self.Score = _totalScore
  self.Star = _totalStar
  self:RefreshRedMsg()
end

function PlayerScoreBossData:OnEvent_NewDay()
  local nCurTime = CS.ClientManager.Instance.serverTimeStamp
  if self.EndTime ~= 0 and nCurTime > self.EndTime then
    self:GetScoreBossInstanceData(nil)
    self:SendScoreBossApplyReq(function()
    end)
  end
end

function PlayerScoreBossData:SendEnterScoreBossApplyReq(nLevelId, nBuildId)
  local msg = {}
  msg.LevelId = nLevelId
  msg.BuildId = nBuildId
  
  local function msgCallback()
    self.CurHPLvScore = 0
    self.HPLvScore = 0
    self.CurHPDamage = 0
    self.BehaviorScore = 0
    self.BehaviorScoreCount = 0
    local curTimeStamp = CS.ClientManager.Instance.serverTimeStampWithTimeZone
    local sKey = LocalData.GetPlayerLocalData("ScoreBossRecordKey")
    if sKey ~= nil and sKey ~= "" then
      NovaAPI.DeleteRecFile(sKey)
    end
    sKey = tostring(curTimeStamp)
    LocalData.SetPlayerLocalData("ScoreBossRecordKey", sKey)
    self:EnterScoreBossInstance(nLevelId, nBuildId)
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.score_boss_apply_req, msg, nil, msgCallback)
end

function PlayerScoreBossData:EnterScoreBossInstance(nLevelId, nBuildId)
  self._EntryTime = CS.ClientManager.Instance.serverTimeStampWithTimeZone
  self.entryLevelId = nLevelId
  self.entryBuild = nBuildId
  if self.curLevel == nil then
    local luaClass = require("Game.Adventure.ScoreBoss.ScoreBossLevel")
    if luaClass == nil then
      return
    end
    self.curLevel = luaClass
  end
  if type(self.curLevel.BindEvent) == "function" and not self.isGoAgain then
    self.curLevel:BindEvent()
  end
  if type(self.curLevel.Init) == "function" then
    self.curLevel:Init(self, nLevelId, nBuildId, self.isGoAgain)
  end
  self.isGoAgain = false
end

function PlayerScoreBossData:EnterScoreBossInstanceEditor(nLevelId, tbChar, tbDisc, tbNote)
  if self.curLevel ~= nil then
    printError("当前关卡level不为空1")
    return
  end
  self.entryLevelId = nLevelId
  self.CurHPLvScore = 0
  self.HPLvScore = 0
  self.CurHPDamage = 0
  self.BehaviorScore = 0
  self.BehaviorScoreCount = 0
  local luaClass = require("Game.Editor.ScoreBoss.ScoreBossEditor")
  if luaClass == nil then
    return
  end
  self.curLevel = luaClass
  if type(self.curLevel.BindEvent) == "function" then
    self.curLevel:BindEvent()
  end
  if type(self.curLevel.Init) == "function" then
    self.curLevel:Init(self, nLevelId, tbChar, tbDisc, tbNote)
  end
end

function PlayerScoreBossData:LevelEnd()
  if nil ~= self.curLevel and type(self.curLevel.UnBindEvent) == "function" then
    self.curLevel:UnBindEvent()
  end
  self.curLevel = nil
end

function PlayerScoreBossData:CacheBuildCharTid(tab)
  self.entryLevelChar = tab
end

function PlayerScoreBossData:GetEntryBuildCharTid()
  return self.entryLevelChar
end

function PlayerScoreBossData:SetSelBuildId(nBuildId, levelId)
  self.tabCachedBuildId[levelId] = nBuildId
end

function PlayerScoreBossData:GetCachedBuild(levelId)
  return self.tabCachedBuildId[levelId] or 0
end

function PlayerScoreBossData:GetLevelBuild(levelId)
  if self.tabScoreBossLevel[levelId] and self.tabScoreBossLevel[levelId].BuildId ~= 0 then
    return self.tabScoreBossLevel[levelId].BuildId
  end
  return 0
end

function PlayerScoreBossData:GetLevelData(levelId)
  if self.tabScoreBossLevel[levelId] then
    return self.tabScoreBossLevel[levelId]
  end
  return nil
end

function PlayerScoreBossData:GetBuildChar(buildId, callBack)
  local function GetDataCallback(tbBuildData, mapAllBuild)
    local mapBuild = mapAllBuild[buildId]
    
    local tbCharId = {}
    if mapBuild ~= nil then
      for _, mapChar in ipairs(mapBuild.tbChar) do
        table.insert(tbCharId, mapChar.nTid)
      end
    end
    callBack(tbCharId)
  end
  
  PlayerData.Build:GetAllBuildBriefData(GetDataCallback)
end

function PlayerScoreBossData:JudgeOtherLevelHaveSameChar(entryLevelId, entryBuildId, callBack)
  local otherLevelId = {}
  
  local function GetDataCallback(tbBuildData, mapAllBuild)
    local entryBuild = mapAllBuild[entryBuildId]
    local entryChar = {}
    for _, mapChar in ipairs(entryBuild.tbChar) do
      table.insert(entryChar, mapChar.nTid)
    end
    for i, v in pairs(self.OpenLevelGroup) do
      if v ~= entryLevelId and self.tabScoreBossLevel[v] and self.tabScoreBossLevel[v].CharId[1] ~= 0 then
        for i1, v1 in pairs(self.tabScoreBossLevel[v].CharId) do
          local idx = table.indexof(entryChar, v1)
          if idx ~= 0 then
            table.insert(otherLevelId, self.tabScoreBossLevel[v].LevelId)
            break
          end
        end
      end
    end
    callBack(otherLevelId)
  end
  
  PlayerData.Build:GetAllBuildBriefData(GetDataCallback)
end

function PlayerScoreBossData:JudgeLevelCacheOtherChar(entryLevelId, entryBuildId, callBack)
  local tmpBuild = self:GetLevelBuild(entryLevelId)
  if tmpBuild == 0 or tmpBuild == entryBuildId then
    callBack(false)
    return
  end
  if self.tabScoreBossLevel[entryLevelId].CharId[1] ~= 0 then
    for i, v in pairs(self.tabScoreBossLevel[entryLevelId].CharId) do
      local idx = table.indexof(self.entryLevelChar, v)
      if idx == 0 then
        callBack(true)
        return
      end
    end
    callBack(false)
  else
    callBack(false)
  end
end

function PlayerScoreBossData:DamageToScore(damageValue, SwitchRate, battleLv)
  self.CurHPDamage = damageValue
  self.CurHPLvScore = math.floor(damageValue / SwitchRate)
  self.BattleLv = battleLv
  EventManager.Hit("ScoreBoss_Score_Change")
end

function PlayerScoreBossData:HPLevelChanged()
  self.HPLvScore = self.HPLvScore + self.CurHPLvScore
  self.CurHPLvScore = 0
  self.CurHPDamage = 0
  EventManager.Hit("ScoreBoss_Score_Change")
end

function PlayerScoreBossData:BehaviorToScore(nScore)
  self.BehaviorScore = nScore
  self.BehaviorScoreCount = self.BehaviorScoreCount + 1
  EventManager.Hit("ScoreBoss_Score_Change")
  EventManager.Hit("ScoreBoss_Score_SkillChange")
end

function PlayerScoreBossData:GetTotalScore()
  local totalScore = self.HPLvScore + self.CurHPLvScore + self.BehaviorScore
  return totalScore
end

function PlayerScoreBossData:GetBehaviorScore()
  return self.BehaviorScore, self.BehaviorScoreCount
end

function PlayerScoreBossData:GetDamageScore()
  return self.HPLvScore + self.CurHPLvScore
end

function PlayerScoreBossData:ScoreToStar()
  local tmpStar = 0
  local totalScore = self.HPLvScore + self.CurHPLvScore + self.BehaviorScore
  for i, v in pairs(self.tabScoreNeed) do
    if v <= totalScore and i > tmpStar then
      tmpStar = i
    end
  end
  return tmpStar
end

function PlayerScoreBossData:QuiteLevel()
  self:LevelEnd()
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    CS.WwiseAudioManager.Instance:PostEvent("ui_loading_combatSFX_mute", nil, false)
  end
  
  cs_coroutine.start(wait)
  CS.AdventureModuleHelper.ResumeLogic()
  
  local function levelEndCallback()
    EventManager.Remove("ADVENTURE_LEVEL_UNLOAD_COMPLETE", self, levelEndCallback)
    NovaAPI.EnterModule("MainMenuModuleScene", true)
  end
  
  EventManager.Add("ADVENTURE_LEVEL_UNLOAD_COMPLETE", self, levelEndCallback)
  CS.AdventureModuleHelper.LevelStateChanged(true, 0, true)
end

function PlayerScoreBossData:SureScoreBossSettleReq(totalStar, totalScore, isReplace, tabOtherLevelId)
  NovaAPI.StopRecord()
  local sKey = LocalData.GetPlayerLocalData("ScoreBossRecordKey")
  local tbSamples = UTILS.GetBattleSamples(sKey)
  local bSuccess, nCheckSum = NovaAPI.GetRecorderKey(sKey)
  local tbSendSample = {Sample = tbSamples, Checksum = nCheckSum}
  local msg = {}
  msg.Star = totalStar
  msg.Score = totalScore
  msg.sample = tbSendSample
  msg.DamageScore = math.floor(self.HPLvScore + self.CurHPLvScore)
  msg.SkillScore = self.BehaviorScore
  msg.BossResultLevel = self.BattleLv
  msg.Events = {
    List = PlayerData.Achievement:GetBattleAchievement(GameEnum.levelType.ScoreBoss, true)
  }
  
  local function msgCallback(_, mapMsgData)
    local oldRank = mapMsgData.oldRank
    local newRank = mapMsgData.newRank
    self:UploadRecordFile(mapMsgData.token)
    self:ChangeTabScoreBossLevel(self.entryLevelId, self.entryBuild, totalScore, totalStar, self.BehaviorScore, isReplace, tabOtherLevelId)
    CS.AdventureModuleHelper.ResumeLogic()
    EventManager.Hit("ScoreBossSettleSuccess", self.entryLevelId, totalScore, totalStar)
    self:LevelEnd()
    self._EndTime = CS.ClientManager.Instance.serverTimeStampWithTimeZone
    local leveData = ConfigTable.GetData("ScoreBossLevel", self.entryLevelId)
    local tabUpLevel = {}
    table.insert(tabUpLevel, {
      "role_id",
      tostring(PlayerData.Base._nPlayerId)
    })
    table.insert(tabUpLevel, {
      "game_cost_time",
      tostring(self.TotalTime)
    })
    table.insert(tabUpLevel, {
      "real_cost_time",
      tostring(self._EndTime - self._EntryTime)
    })
    table.insert(tabUpLevel, {
      "build_id",
      tostring(self.entryBuild)
    })
    table.insert(tabUpLevel, {
      "battle_id",
      tostring(leveData.MonsterId)
    })
    table.insert(tabUpLevel, {
      "total_score",
      tostring(totalScore)
    })
    table.insert(tabUpLevel, {
      "boss_result_level",
      tostring(self.BattleLv)
    })
    NovaAPI.UserEventUpload("boss_rush", tabUpLevel)
    self.isLevelClear = true
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.score_boss_settle_req, msg, nil, msgCallback)
end

function PlayerScoreBossData:UploadRecordFile(sToken)
  local sKey = LocalData.GetPlayerLocalData("ScoreBossRecordKey") or ""
  if sKey ~= nil and sKey ~= "" then
    if sToken ~= nil and sToken ~= "" then
      NovaAPI.UploadStartowerFile(sToken, sKey)
    else
      NovaAPI.DeleteRecFile(sKey)
    end
  end
  LocalData.SetPlayerLocalData("ScoreBossRecordKey", "")
end

function PlayerScoreBossData:SendScoreBossSettleReq(totalTime)
  self.TotalTime = totalTime
  CS.AdventureModuleHelper.PauseLogic()
  
  local function JudgeOther(otherLevelId)
    local totalScore = self.HPLvScore + self.CurHPLvScore + self.BehaviorScore
    local totalStar = self:ScoreToStar()
    if #otherLevelId == 0 then
      local function judgeCache(isReplace)
        if isReplace then
          local function ConfirmCb()
            self:SureScoreBossSettleReq(totalStar, totalScore, true, {})
          end
          
          local function CancelCb()
            self:QuiteLevel()
          end
          
          EventManager.Hit(EventId.OpenPanel, PanelId.ScoreBossReplaceBD, self.entryLevelId, ConfirmCb, CancelCb)
        else
          self:SureScoreBossSettleReq(totalStar, totalScore, false, {})
        end
      end
      
      self:JudgeLevelCacheOtherChar(self.entryLevelId, self.entryBuild, judgeCache)
    else
      local function judgeCache(isReplace)
        if isReplace then
          local function ConfirmCb()
            local function ConfirmClearCb()
              self:SureScoreBossSettleReq(totalStar, totalScore, true, otherLevelId)
            end
            
            local function CancelClearCb()
              self:QuiteLevel()
            end
            
            EventManager.Hit(EventId.OpenPanel, PanelId.ScoreBossClearBD, otherLevelId, ConfirmClearCb, CancelClearCb)
          end
          
          local function CancelCb()
            self:QuiteLevel()
          end
          
          EventManager.Hit(EventId.OpenPanel, PanelId.ScoreBossReplaceBD, self.entryLevelId, ConfirmCb, CancelCb)
        else
          local function ConfirmClearCb()
            self:SureScoreBossSettleReq(totalStar, totalScore, true, otherLevelId)
          end
          
          local function CancelClearCb()
            self:QuiteLevel()
          end
          
          EventManager.Hit(EventId.OpenPanel, PanelId.ScoreBossClearBD, otherLevelId, ConfirmClearCb, CancelClearCb)
        end
      end
      
      self:JudgeLevelCacheOtherChar(self.entryLevelId, self.entryBuild, judgeCache)
    end
  end
  
  self:JudgeOtherLevelHaveSameChar(self.entryLevelId, self.entryBuild, JudgeOther)
end

function PlayerScoreBossData:SendScoreBossStarRewardReceiveReq(cb, star)
  local msg = {}
  msg.Star = star
  
  local function msgCallback(_, mapMsgData)
    if star ~= 0 then
      table.insert(self.tabStarRewards, star)
    else
      self.tabStarRewards = {}
      for i, v in pairs(self.tabScoreBossReward) do
        if v.StarNeed <= self.Star then
          table.insert(self.tabStarRewards, v.StarNeed)
        end
      end
    end
    local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(mapMsgData)
    UTILS.OpenReceiveByDisplayItem(mapDecodedChangeInfo["proto.Res"], mapMsgData)
    cb()
    self:RefreshRedMsg()
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.score_boss_star_reward_receive_req, msg, nil, msgCallback)
end

function PlayerScoreBossData:SendEnterLvAgain()
  if self.curLevel ~= nil then
    self.curLevel.isCanPause = false
  end
  self.isGoAgain = true
  NovaAPI.StopRecord()
  CS.AdventureModuleHelper.LevelStateChanged(false)
  EventManager.Hit("BattleRestart")
end

function PlayerScoreBossData:EntryLvAgain()
  if self.isGoAgain then
    CS.AdventureModuleHelper.ClearCharacterDamageRecord(false)
    self.CurHPLvScore = 0
    self.HPLvScore = 0
    self.CurHPDamage = 0
    self.BehaviorScore = 0
    self.BehaviorScoreCount = 0
    local curTimeStamp = CS.ClientManager.Instance.serverTimeStampWithTimeZone
    local sKey = LocalData.GetPlayerLocalData("ScoreBossRecordKey")
    if sKey ~= nil and sKey ~= "" then
      NovaAPI.DeleteRecFile(sKey)
    end
    sKey = tostring(curTimeStamp)
    LocalData.SetPlayerLocalData("ScoreBossRecordKey", sKey)
    EventManager.Hit("ScoreBoss_Restart_Again")
    self:EnterScoreBossInstance(self.entryLevelId, self.entryBuild)
  end
end

function PlayerScoreBossData:SendScoreBossApplyReq(cb)
  self:InitRankData()
  
  local function msgCallback(_, mapMsgData)
    self:SetRankMsg(mapMsgData, cb)
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.score_boss_rank_req, {}, nil, msgCallback)
end

function PlayerScoreBossData:InitRankData()
  self.RankLastRefreshTime = 0
  self.RankSelfMsg = nil
  self.RankPlayerMsg = {}
  self.RankBorder = {}
  self.nRankTotalCount = 0
end

function PlayerScoreBossData:SetRankMsg(mapMsgData, cb)
  self.RankLastRefreshTime = mapMsgData.LastRefreshTime
  if mapMsgData.Self then
    self.RankSelfMsg = mapMsgData.Self
  end
  if mapMsgData.Rank then
    for i, v in pairs(mapMsgData.Rank) do
      table.insert(self.RankPlayerMsg, v)
    end
  end
  if mapMsgData.Border then
    for i, v in pairs(mapMsgData.Border) do
      table.insert(self.RankBorder, v)
    end
  end
  if mapMsgData.Total then
    self.nRankTotalCount = mapMsgData.Total
  end
  cb()
end

function PlayerScoreBossData:CheckRankDataLastest()
  if self.RankSelfMsg == nil or self.RankSelfMsg.Rank == 0 then
    return true
  end
  local mapSelfDataInList
  if self.RankSelfMsg.Rank <= #self.RankPlayerMsg then
    mapSelfDataInList = self.RankPlayerMsg[self.RankSelfMsg.Rank]
  else
    return false
  end
  if mapSelfDataInList == nil or mapSelfDataInList.NickName ~= self.RankSelfMsg.NickName or mapSelfDataInList.Score ~= self.RankSelfMsg.Score then
    return false
  end
  return true
end

function PlayerScoreBossData:GetRankSelfMsg()
  return self.RankSelfMsg
end

function PlayerScoreBossData:GetSelfRankIndex()
  if self.RankSelfMsg then
    return self.RankSelfMsg.Rank
  end
  return 0
end

function PlayerScoreBossData:GetRankBorderCount(index)
  return self.RankBorder[index] or 0
end

function PlayerScoreBossData:GetSelfBorderIndex()
  for i, v in pairs(self.RankBorder) do
    if v <= self.RankSelfMsg.Score then
      return i
    end
  end
  return 1
end

function PlayerScoreBossData:GetRankPlayerCount()
  return self.nRankTotalCount or 0
end

function PlayerScoreBossData:GetRankTableCount()
  return #self.RankPlayerMsg or 0
end

function PlayerScoreBossData:GetPlayerRankMsg(index)
  return self.RankPlayerMsg[index] or nil
end

function PlayerScoreBossData:GetVoiceKey()
  local isFirst = false
  if not self.isFirstVoice then
    isFirst = true
    self.isFirstVoice = true
  end
  local sTimeVoice = PlayerData.Voice:GetNPCGreetTimeVoiceKey()
  return isFirst, sTimeVoice
end

function PlayerScoreBossData:SendEnterScoreBossGM(nLevelId, nBuildId)
  self.StartTime = 1782849600
  self.EndTime = 2208888000
  self.CurHPLvScore = 0
  self.HPLvScore = 0
  self.CurHPDamage = 0
  self.BehaviorScore = 0
  self.BehaviorScoreCount = 0
  self._EntryTime = CS.ClientManager.Instance.serverTimeStampWithTimeZone
  self.entryLevelId = nLevelId
  self.entryBuild = nBuildId
  if self.curLevel == nil then
    local luaClass = require("Game.UI.GMTool.GMActivity.GMScoreBossLevel")
    if luaClass == nil then
      return
    end
    self.curLevel = luaClass
  end
  if type(self.curLevel.BindEvent) == "function" and not self.isGoAgain then
    self.curLevel:BindEvent()
  end
  if type(self.curLevel.Init) == "function" then
    self.curLevel:Init(self, nLevelId, nBuildId, self.isGoAgain)
  end
  self.isGoAgain = false
end

function PlayerScoreBossData:SendScoreBossSettleGM(totalTime)
  self.TotalTime = totalTime
  CS.AdventureModuleHelper.PauseLogic()
  local totalScore = self.HPLvScore + self.CurHPLvScore + self.BehaviorScore
  local totalStar = self:ScoreToStar()
  CS.AdventureModuleHelper.ResumeLogic()
  EventManager.Hit("ScoreBossSettleSuccess", self.entryLevelId, totalScore, totalStar)
  self:LevelEnd()
end

function PlayerScoreBossData:EntryLvAgainGM()
  if self.isGoAgain then
    CS.AdventureModuleHelper.ClearCharacterDamageRecord(false)
    self.CurHPLvScore = 0
    self.HPLvScore = 0
    self.CurHPDamage = 0
    self.BehaviorScore = 0
    self.BehaviorScoreCount = 0
    EventManager.Hit("ScoreBoss_Restart_Again")
    self:SendEnterScoreBossGM(self.entryLevelId, self.entryBuild)
  end
end

return PlayerScoreBossData
