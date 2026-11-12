local PlayerTutorialData = class("PlayerTutorialData")
local LevelData = require("GameCore.Data.DataClass.Tutorial.TutorialLevelData")
local LocalData = require("GameCore.Data.LocalData")

function PlayerTutorialData:Init()
  self.curLevelId = 0
  self.tbLevelData = {}
  self.LevelIdList = {}
end

function PlayerTutorialData:CacheTutorialData(levelsData)
  self.tbLevelData = {}
  self.LevelIdList = {}
  
  local function forEachTableFunc(config)
    self:UpdateLevel({
      nlevelId = config.Id,
      LevelStatus = AllEnum.ActQuestStatus.UnComplete
    })
    table.insert(self.LevelIdList, config.Id)
  end
  
  ForEachTableLine(DataTable.TutorialLevel, forEachTableFunc)
  for _, level in pairs(levelsData) do
    self:UpdateLevel({
      nlevelId = level.LevelId,
      LevelStatus = self:QuestStateServer2Client(level.Passed, level.RewardReceived)
    })
  end
  
  local function sortFunc(a, b)
    return a < b
  end
  
  table.sort(self.LevelIdList, sortFunc)
  self.LevelData = LevelData.new()
  local bIsNew = LocalData.GetPlayerLocalData("Tutorial_IsNew")
  if bIsNew == nil then
    bIsNew = true
  end
  local bAllComplate = true
  if self.tbLevelData ~= nil then
    for _, levelData in pairs(self.tbLevelData) do
      if levelData.LevelStatus ~= AllEnum.ActQuestStatus.Received then
        bAllComplate = false
        break
      end
    end
  end
  if bAllComplate then
    bIsNew = false
  end
  self:RefreshRedDot(bIsNew)
end

function PlayerTutorialData:GetLevelLockType(levelId)
  local levelData = self:GetLevelData(levelId)
  if levelData.LevelStatus == AllEnum.ActQuestStatus.Complete or levelData.LevelStatus == AllEnum.ActQuestStatus.Received then
    return AllEnum.TutorialLevelLockType.None
  end
  local levelConfig = ConfigTable.GetData("TutorialLevel", levelId)
  if levelConfig == nil then
    return AllEnum.TutorialLevelLockType.None
  end
  if levelConfig.WorldClass > PlayerData.Base:GetWorldClass() then
    return AllEnum.TutorialLevelLockType.WorldClass
  end
  local preLevelData = self:GetLevelData(levelConfig.PreLevelId)
  if preLevelData == nil then
    return AllEnum.TutorialLevelLockType.None
  end
  if preLevelData.LevelStatus == AllEnum.ActQuestStatus.UnComplete then
    return AllEnum.TutorialLevelLockType.PreLevel
  end
  return AllEnum.TutorialLevelLockType.None
end

function PlayerTutorialData:GetLevelList()
  return self.LevelIdList
end

function PlayerTutorialData:UpdateLevel(levelData)
  self.tbLevelData[levelData.nlevelId] = levelData
end

function PlayerTutorialData:GetLevelData(levelId)
  return self.tbLevelData[levelId]
end

function PlayerTutorialData:GetProgress()
  local nReceivedCount = 0
  for _, data in pairs(self.tbLevelData) do
    if data.LevelStatus == AllEnum.ActQuestStatus.Received then
      nReceivedCount = nReceivedCount + 1
    end
  end
  return #self.LevelIdList, nReceivedCount
end

function PlayerTutorialData:GetNextLevelId(levelId)
  local nNextlevelId = 0
  local nIndex = table.indexof(self.LevelIdList, levelId)
  if 0 < nIndex and nIndex + 1 <= #self.LevelIdList then
    for i = nIndex + 1, #self.LevelIdList do
      if self:GetLevelLockType(self.LevelIdList[i]) == AllEnum.TutorialLevelLockType.None then
        nNextlevelId = self.LevelIdList[i]
        break
      end
    end
  end
  return nNextlevelId
end

function PlayerTutorialData:GetLevelReward(levelId, callback)
  local mapSendMsg = {Value = levelId}
  if self:GetLevelData(levelId).LevelStatus == AllEnum.ActQuestStatus.Received then
    if callback ~= nil then
      callback()
    end
    return
  end
  
  local function succ_cb(_, mapData)
    self:UpdateLevel({
      nlevelId = levelId,
      LevelStatus = AllEnum.ActQuestStatus.Received
    })
    local bIsNew = LocalData.GetPlayerLocalData("Tutorial_IsNew")
    self:RefreshRedDot(bIsNew)
    
    local function closeCallback()
      if callback ~= nil then
        callback()
      end
    end
    
    UTILS.OpenReceiveByChangeInfo(mapData, closeCallback)
    EventManager.Hit(EventId.TutorialQuestReceived, mapData)
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.tutorial_level_reward_receive_req, mapSendMsg, nil, succ_cb)
end

function PlayerTutorialData:EnterLevel(levelId, callback)
  self.curLevelId = levelId
  local levelConfig = ConfigTable.GetData("TutorialLevel", self.curLevelId)
  if levelConfig == nil then
    return
  end
  local buildData = ConfigTable.GetData("TrialBuild", levelConfig.TutorialBuild)
  if buildData == nil then
    return
  end
  local charIdList = {}
  local discIdList = {}
  for _, id in pairs(buildData.Char) do
    local charData = ConfigTable.GetData("TrialCharacter", id)
    if charData ~= nil then
      table.insert(charIdList, charData.CharId)
    end
  end
  for _, id in pairs(buildData.Disc) do
    local discData = ConfigTable.GetData("TrialDisc", id)
    if discData ~= nil then
      table.insert(discIdList, discData.DiscId)
    end
  end
  self.LevelData:InitLevelData(self.curLevelId, charIdList, discIdList)
  if callback ~= nil then
    callback()
  end
end

function PlayerTutorialData:FinishLevel(bResult)
  if not bResult then
    self.LevelData:FinishLevel(false)
    self.curLevelId = 0
  else
    local levelData = self:GetLevelData(self.curLevelId)
    if levelData ~= nil then
      if levelData.LevelStatus == AllEnum.ActQuestStatus.UnComplete then
        self.LevelData:FinishLevel(true)
        local mapSendMsg = {
          Value = self.curLevelId
        }
        
        local function func_cb()
          self:UpdateLevel({
            nlevelId = self.curLevelId,
            LevelStatus = AllEnum.ActQuestStatus.Complete
          })
          self.curLevelId = 0
        end
        
        HttpNetHandler.SendMsg(NetMsgId.Id.tutorial_level_settle_req, mapSendMsg, nil, func_cb)
      else
        self.LevelData:FinishLevel(true)
        self.curLevelId = 0
      end
    end
  end
end

function PlayerTutorialData:GetCurDicId()
  return self.LevelData:GetCurDicId()
end

function PlayerTutorialData:RefreshRedDot(bIsNew)
  LocalData.SetPlayerLocalData("Tutorial_IsNew", bIsNew)
  if bIsNew then
    RedDotManager.SetValid(RedDotDefine.TaskNewbie_Tutorial, nil, true)
    return
  end
  local bFuncUnlock = PlayerData.Base:CheckFunctionUnlock(GameEnum.OpenFuncType.TutorialLevel)
  if not bFuncUnlock then
    return
  end
  local bRedDot = false
  if self.tbLevelData ~= nil then
    for _, levelData in pairs(self.tbLevelData) do
      if levelData.LevelStatus == AllEnum.ActQuestStatus.Complete then
        bRedDot = true
        break
      end
    end
  end
  RedDotManager.SetValid(RedDotDefine.TaskNewbie_Tutorial, nil, bRedDot)
end

function PlayerTutorialData:QuestStateServer2Client(Passed, RewardReceived)
  if not Passed then
    return AllEnum.ActQuestStatus.UnComplete
  elseif Passed and not RewardReceived then
    return AllEnum.ActQuestStatus.Complete
  else
    return AllEnum.ActQuestStatus.Received
  end
end

return PlayerTutorialData
