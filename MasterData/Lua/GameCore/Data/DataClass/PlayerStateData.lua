local PlayerStateData = class("PlayerStateData")

function PlayerStateData:Init()
  self.tbWorldClassRewardState = {}
  self.tbCharAdvanceRewards = {}
  self.tbCharAffinityReward = {}
  self.bNewAchievement = false
  self.bFriendState = false
  self.bMailOverflow = false
  self.bInStarTowerSweep = false
  self.nVampireId = 0
end

function PlayerStateData:CacheStateData(mapMsgData)
  if mapMsgData ~= nil then
    self:CacheStarTowerStateData(mapMsgData.StarTower)
    self:CacheCharAdvanceRewardsState(mapMsgData.CharAdvanceRewards)
    self:CacheWorldClassRewardState(mapMsgData.WorldClassReward)
    self:CacheAchievementState(mapMsgData.Achievement.New)
    self:CacheFriendState(mapMsgData)
    RedDotManager.SetValid(RedDotDefine.BattlePass_Quest_Server, nil, mapMsgData.BattlePass.State == 1 or mapMsgData.BattlePass.State == 3)
    RedDotManager.SetValid(RedDotDefine.BattlePass_Reward, nil, mapMsgData.BattlePass.State >= 2)
    PlayerData.Mail:UpdateMailRed(mapMsgData.Mail.New)
    RedDotManager.SetValid(RedDotDefine.Mall_Free, nil, mapMsgData.MallPackage.New)
    RedDotManager.SetValid(RedDotDefine.Friend_Apply, nil, mapMsgData.Friend)
    RedDotManager.SetValid(RedDotDefine.Friend_Energy, nil, mapMsgData.FriendEnergy.State)
    RedDotManager.SetValid(RedDotDefine.StarTowerBook_Affinity_Reward, "server", mapMsgData.NpcAffinityReward)
    PlayerData.Quest:UpdateServerQuestRedDot(mapMsgData.TravelerDuelQuest)
    PlayerData.Quest:UpdateServerQuestRedDot(mapMsgData.TravelerDuelChallengeQuest)
    self.nLastReceiveIdleRewardTime = mapMsgData.TravelerDuelIdleReward or CS.ClientManager.Instance.serverTimeStamp
    PlayerData.InfinityTower:UpdateBountyRewardState(mapMsgData.InfinityTower)
    PlayerData.StarTowerBook:UpdateServerRedDot(mapMsgData.StarTowerBook)
    PlayerData.ScoreBoss:UpdateRedDot(mapMsgData.ScoreBoss)
    PlayerData.Activity:UpdateActivityState(mapMsgData.Activities)
    PlayerData.StorySet:UpdateStorySetState(mapMsgData.StorySet)
    PlayerData.TraceHunt:UpdateBossRewardRedDot(mapMsgData.TraceHunt.BossRewardCanReceive)
    if mapMsgData.Soldier ~= nil then
      PlayerData.SoldierData:UpdateSoldierState(mapMsgData.Soldier)
    end
    if mapMsgData.GuideMission ~= nil then
      RedDotManager.SetValid(RedDotDefine.GuideMission_Server, nil, mapMsgData.GuideMission.New)
    end
    RedDotManager.SetValid(RedDotDefine.DormServer, nil, mapMsgData.DormStateFlag > 0)
    self.nVampireId = mapMsgData.VampireSurvivorId
  else
    self.bMailState = false
  end
end

function PlayerStateData:CacheWorldClassRewardState(WorldClassReward)
  self.tbWorldClassRewardState = {
    string.byte(WorldClassReward.Flag, 1, -1)
  }
  PlayerData.Base:RefreshWorldClassRedDot()
end

function PlayerStateData:CacheWorldClassRewardStateInBoard(WorldClassReward)
  if WorldClassReward == nil then
    return
  end
  self.tbWorldClassRewardState = {
    string.byte(WorldClassReward, 1, -1)
  }
end

function PlayerStateData:CacheAchievementState(bNew)
  self.bNewAchievement = bNew
end

function PlayerStateData:CacheFriendState(mapMsgData)
  self.bFriendState = mapMsgData.Friend or mapMsgData.FriendEnergy.State
end

function PlayerStateData:CacheStarTowerStateData(mapData)
  if mapData ~= nil then
    self.mapStarTowerState = mapData
    if self.mapStarTowerState.BuildId ~= 0 then
      self.mapStarTowerState.Id = 0
    end
    if self.mapStarTowerState.Floor == 0 then
      self.mapStarTowerState.Floor = 1
    end
  else
    self.mapStarTowerState = {
      BuildId = 0,
      Id = 0,
      Floor = 1,
      Sweep = false
    }
  end
end

function PlayerStateData:CacheCharAdvanceRewardsState(CharAdRewards)
  if CharAdRewards == nil then
    return
  end
  if CharAdRewards == {} then
    return
  end
  for _, v in ipairs(CharAdRewards) do
    self.tbCharAdvanceRewards[v.CharId] = string.byte(v.Flag, 1, -1)
  end
  self:RefreshCharAdvanceRewardRedDot()
end

function PlayerStateData:CacheCharactersAdRewards_Notify(mapMsgData)
  if mapMsgData == nil then
    return
  end
  self.tbCharAdvanceRewards[mapMsgData.CharId] = string.byte(mapMsgData.Flag, 1, -1)
  self:RefreshCharAdvanceRewardRedDot()
end

function PlayerStateData:GetCharAdvanceRewards(nCharId, nAdvance)
  if self.tbCharAdvanceRewards[nCharId] then
    return self.tbCharAdvanceRewards[nCharId] >> nAdvance - 1 & 1 == 1
  else
    return false
  end
end

function PlayerStateData:GetCanPickedAdvanceRewards(nCharId, nMaxAdvance)
  if self.tbCharAdvanceRewards[nCharId] then
    for nIndex = 1, nMaxAdvance do
      if self.tbCharAdvanceRewards[nCharId] >> nIndex - 1 & 1 == 1 then
        return nIndex
      end
    end
  else
    return 0
  end
end

function PlayerStateData:HasPendingStarTowerBuild()
  return self.mapStarTowerState ~= nil and self.mapStarTowerState.BuildId ~= 0
end

function PlayerStateData:OpenStarTowerBuildSave(callback)
  if not self:HasPendingStarTowerBuild() then
    if callback ~= nil then
      callback()
    end
    return
  end
  local nBuildId = self.mapStarTowerState.BuildId
  print("正在保存的BuildId" .. nBuildId)
  self.mapStarTowerState.BuildId = 0
  
  local function buildDetailcallback(mapBuild)
    if type(mapBuild) ~= "table" then
      if callback ~= nil then
        callback()
      end
      return
    end
    EventManager.Hit(EventId.OpenPanel, PanelId.StarTowerBuildSave, false, mapBuild, callback)
  end
  
  PlayerData.Build:GetBuildDetailData(buildDetailcallback, nBuildId)
end

function PlayerStateData:CheckState()
  if self:HasPendingStarTowerBuild() then
    self:OpenStarTowerBuildSave()
    return true
  end
  return false
end

function PlayerStateData:CheckVampireState(callback)
  if self.nVampireId > 0 then
    local mapVampireCfgData = ConfigTable.GetData("VampireSurvivor", self.nVampireId)
    if mapVampireCfgData == nil then
      if callback ~= nil and type(callback) == "function" then
        callback(false)
      end
      self.nVampireId = 0
      return
    end
    if mapVampireCfgData.Type == GameEnum.vampireSurvivorType.Turn then
      local curSeason, nLevel = PlayerData.VampireSurvivor:GetCurSeason()
      if nLevel ~= self.nVampireId then
        if callback ~= nil and type(callback) == "function" then
          callback(false)
        end
        self.nVampireId = 0
        return
      end
    end
    
    local function GetDataCallback()
      local function ConfirmCallback()
        self.nVampireId = 0
        
        PlayerData.VampireSurvivor:ReEnterVampireSurvivor(self.nVampireId)
      end
      
      local function CancelCallback()
        local function netMsgCallback(_, msgData)
          if mapVampireCfgData ~= nil and mapVampireCfgData.Type == GameEnum.vampireSurvivorType.Turn then
            PlayerData.VampireSurvivor:AddPointAndLevel(msgData.Defeat.FinalScore, 0, msgData.Defeat.SeasonId)
          end
          PlayerData.VampireSurvivor:CacheScoreByLevel(self.nVampireId, msgData.Defeat.FinalScore)
          EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("VampireReconnnect_Abandon"))
          self.nVampireId = 0
        end
        
        local msg = {
          KillCount = {
            0,
            0,
            0,
            0,
            0,
            0,
            0,
            0,
            0,
            0
          },
          Time = 0,
          Defeat = true,
          Events = {
            List = {}
          }
        }
        HttpNetHandler.SendMsg(NetMsgId.Id.vampire_survivor_settle_req, msg, nil, netMsgCallback)
      end
      
      local data = {
        nType = AllEnum.MessageBox.Confirm,
        sContent = orderedFormat(ConfigTable.GetUIText("VampireReconnnect_Hint") or "", mapVampireCfgData.Name),
        sConfirm = ConfigTable.GetUIText("RoguelikeReenter_Yes"),
        sCancel = ConfigTable.GetUIText("RoguelikeReenter_No"),
        sContentSub = "",
        callbackConfirm = ConfirmCallback,
        callbackCancel = CancelCallback,
        bCloseNoHandler = true,
        bRedCancel = true
      }
      EventManager.Hit(EventId.OpenMessageBox, data)
    end
    
    local function success(bSuccess)
      EventManager.Remove("GetTalentDataVampire", self, success)
      if bSuccess then
        if callback ~= nil and type(callback) == "function" then
          callback(true)
        end
        GetDataCallback()
      else
        self.nVampireId = 0
        printError("GetTalentDataVampire Failed")
        if callback ~= nil and type(callback) == "function" then
          callback(false)
        end
      end
    end
    
    EventManager.Add("GetTalentDataVampire", self, success)
    local ret, _, _ = PlayerData.VampireSurvivor:GetTalentData()
    if ret ~= nil then
      success(true)
    end
  elseif callback ~= nil and type(callback) == "function" then
    callback(false)
  end
end

function PlayerStateData:GetStarTowerState()
  return self.mapStarTowerState
end

function PlayerStateData:CheckStarTowerState()
  if self.mapStarTowerState == nil then
    return false
  end
  local bState = self.mapStarTowerState.Id ~= 0
  if bState then
    print(string.format("正在进行的遗迹:%s", self.mapStarTowerState.Id))
    local nMaxCount = ConfigTable.GetConfigNumber("StarTowerReconnMaxCnt")
    
    local function confirmCallback()
      self.mapStarTowerState.ReConnection = self.mapStarTowerState.ReConnection + 1
      if self.mapStarTowerState.Sweep then
        PlayerData.StarTower:ReenterTowerFastBattle()
      else
        PlayerData.StarTower:ReenterTower(self.mapStarTowerState.Id)
      end
    end
    
    local function cancelCallback()
      local function giveUpCallback()
        PlayerData.StarTower:GiveUpReconnect(self.mapStarTowerState.Id, self.mapStarTowerState.CharIds, self.mapStarTowerState.ReConnection < nMaxCount)
      end
      
      giveUpCallback()
    end
    
    if 0 > self.mapStarTowerState.ReConnection then
      local msg = {
        nType = AllEnum.MessageBox.Confirm,
        sContent = ConfigTable.GetUIText("Roguelike_Reenter_Hint_Clear"),
        sConfirm = ConfigTable.GetUIText("RoguelikeReenter_Yes"),
        sCancel = ConfigTable.GetUIText("RoguelikeReenter_No"),
        callbackConfirm = confirmCallback,
        callbackCancel = cancelCallback,
        bCloseNoHandler = true,
        bRedCancel = true
      }
      EventManager.Hit(EventId.OpenMessageBox, msg)
    elseif nMaxCount > self.mapStarTowerState.ReConnection then
      local sHint = orderedFormat(ConfigTable.GetUIText("Roguelike_Reenter_Hint") or "", nMaxCount - self.mapStarTowerState.ReConnection, nMaxCount)
      local msg = {
        nType = AllEnum.MessageBox.Confirm,
        sContent = sHint,
        sConfirm = ConfigTable.GetUIText("RoguelikeReenter_Yes"),
        sCancel = ConfigTable.GetUIText("RoguelikeReenter_No"),
        callbackConfirm = confirmCallback,
        callbackCancel = cancelCallback,
        bCloseNoHandler = true,
        bRedCancel = true
      }
      EventManager.Hit(EventId.OpenMessageBox, msg)
    else
      local msg = {
        nType = AllEnum.MessageBox.Alert,
        sContent = ConfigTable.GetUIText("Roguelike_Reenter_Hint_Limit"),
        sTitle = "",
        sConfirm = ConfigTable.GetUIText("RoguelikeReenter_Yes"),
        callbackConfirm = cancelCallback
      }
      EventManager.Hit(EventId.OpenMessageBox, msg)
    end
    EventManager.Hit("HaveRoguelikeState")
  end
  return bState
end

function PlayerStateData:GetStarTowerRecon()
  return self.mapStarTowerState.ReConnection
end

function PlayerStateData:GetWorldClassRewardState()
  return self.tbWorldClassRewardState
end

function PlayerStateData:ResetWorldClassRewardState(nLv)
  local nIndex = math.ceil(nLv / 8)
  local bActive = 1 << nLv - (nIndex - 1) * 8 - 1 & self.tbWorldClassRewardState[nIndex] > 0
  if bActive then
    self.tbWorldClassRewardState[nIndex] = self.tbWorldClassRewardState[nIndex] & ~(1 << nLv - (nIndex - 1) * 8 - 1)
  end
  PlayerData.Base:RefreshWorldClassRedDot()
end

function PlayerStateData:ResetIntervalWorldClassRewardState(nMinLevel, nMaxLevel)
  for nLv = nMinLevel, nMaxLevel do
    local nIndex = math.ceil(nLv / 8)
    local bActive = 1 << nLv - (nIndex - 1) * 8 - 1 & self.tbWorldClassRewardState[nIndex] > 0
    if bActive then
      self.tbWorldClassRewardState[nIndex] = self.tbWorldClassRewardState[nIndex] & ~(1 << nLv - (nIndex - 1) * 8 - 1)
    end
  end
  PlayerData.Base:RefreshWorldClassRedDot()
end

function PlayerStateData:ResetAllWorldClassRewardState()
  for k, _ in pairs(self.tbWorldClassRewardState) do
    self.tbWorldClassRewardState[k] = 0
  end
  PlayerData.Base:RefreshWorldClassRedDot()
end

function PlayerStateData:SetMailOverflow(bOverflow)
  self.bMailOverflow = bOverflow
end

function PlayerStateData:GetMailOverflow()
  return self.bMailOverflow
end

function PlayerStateData:SetStarTowerSweepState(bInSweep)
  self.bInStarTowerSweep = bInSweep
end

function PlayerStateData:GetStarTowerSweepState()
  return self.bInStarTowerSweep
end

function PlayerStateData:RefreshCharAdvanceRewardRedDot()
  local tbAdvanceLevel = PlayerData.Char:GetAdvanceLevelTable()
  for charId, v in pairs(self.tbCharAdvanceRewards) do
    local charCfg = ConfigTable.GetData_Character(charId)
    if nil ~= charCfg then
      local nGrade = charCfg.Grade
      local tbLevelAttr = tbAdvanceLevel[nGrade]
      local maxAdvance = #tbLevelAttr - 1
      for i = 1, maxAdvance do
        local bReceive = v >> i - 1 & 1 == 1
        RedDotManager.SetValid(RedDotDefine.Role_AdvanceReward, {charId, i}, bReceive)
      end
    end
  end
end

function PlayerStateData:RefreshTrekkerVersusIdleRewardRedDot(nNewTime)
  local nActId = 0
  
  local function foreachActData(mapData)
    if mapData.ActivityType == GameEnum.activityType.TrekkerVersus then
      nActId = mapData.Id > nActId and mapData.Id or nActId
    end
  end
  
  ForEachTableLine(DataTable.Activity, foreachActData)
  local actData = PlayerData.Activity:GetActivityDataById(nActId)
  local bRedDotOn = false
  if actData ~= nil then
    local tbIdleReward = actData:GetIdleReward()
    if tbIdleReward ~= nil and 0 < #tbIdleReward then
      if nNewTime ~= nil then
        self.nLastReceiveIdleRewardTime = nNewTime
      end
      local nElapsedTime = CS.ClientManager.Instance.serverTimeStamp - self.nLastReceiveIdleRewardTime
      if nElapsedTime >= 3600 * ConfigTable.GetConfigNumber("TrekkerVersusIdleRewardRedDotTime") then
        bRedDotOn = true
      end
    end
  end
  local bInActGroup, nActGroupId = PlayerData.Activity:IsActivityInActivityGroup(nActId)
  if bInActGroup then
    RedDotManager.SetValid(RedDotDefine.TrekkerVersusIdleReward, {nActGroupId, nActId}, bRedDotOn)
  end
end

return PlayerStateData
