local ActivityBase = require("Game.ActivityFrame.ActivityBase")
local Act23SteinsGateData = class("Act23SteinsGateData", ActivityBase)
local ActivityFrameEnum = require("Game.ActivityFrame.ActivityFrameEnum")
local ActDailyTaskData = require("Game.ActivityFrame.ActDailyTaskData")
local Act23SteinsGateEnum = require("Game.Activity23SteinsGate.Data.Act23SteinsGateEnum")
local ActTermTaskDataOne = require("Game.ActivityFrame.ActTermTaskDataOne")
local ActCommonRepeatDungeonLevelData = require("Game.ActivityFrame.Data.ActCommonRepeatDungeonLevelData")
local ActDungeonLevelCollect = require("Game.ActivityFrame.ActDungeonLevelCollect")
local CurActType = ActivityFrameEnum.eActivityType.SteinsGate
local Act23SGStoryData = require("Game.Activity23SteinsGate.Data.StoryLine.Act23SGStoryData")
local Act23SGInteractData = require("Game.Activity23SteinsGate.Data.Interact.Act23SteinsGateInteractData")
local ActInternalUnlockInfo = require("Game.Common.Activity.ActInternalUnlockInfo")
local eActInteract = require("Game.ActivityLobby.Activity.2023SteinsGate.eActInteract")

function Act23SteinsGateData:InitAct23SteinsGateData(msg)
  self._actId = msg.actId
  self:SetActFrameDataByType(CurActType, self._actId)
  self._mainCfg = ConfigData.activity_23steinsgate_main[self._actId]
  self.sgInteractData = Act23SGInteractData.New()
  self.sgInteractData:InitInteractData(self:GetActFrameId())
  self.sgStoryData = Act23SGStoryData.New(self)
  self:__InitDailyTaskData()
  self:__InitTermTaskData()
  self:__InitUnlockInfo()
  self:UpdateSteinsGateData(msg)
  self:RefreshRedSteinsGateDailyTask()
  self:RefreshRedSteinsGateOnceTask()
  self:RefreshRedSteinsGate_H5MiniGame()
  self:RefreshRedSteinsGate_Brotato()
  self:SGLinkCardSetReddot()
end

function Act23SteinsGateData:UpdateSteinsGateData(msg)
  self:UpdataBrotatoData(msg)
end

function Act23SteinsGateData:__InitDailyTaskData()
  local actFrameCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame)
  self._dailyTaskData = actFrameCtrl:GetActDailyTaskData(self:GetActFrameId())
  if self._dailyTaskData == nil then
    self._dailyTaskData = ActDailyTaskData.New()
    self._dailyTaskData:InitActDailyTask(self:GetActFrameId())
  end
  local RefreshRedSteinsGateDailyTaskCallback = BindCallback(self, self.RefreshRedSteinsGateDailyTask)
  self._dailyTaskData:BindActDailyTaskCommitFunc(RefreshRedSteinsGateDailyTaskCallback)
  self._dailyTaskData:BindActDailyTaskChangeFunc(RefreshRedSteinsGateDailyTaskCallback)
  self._dailyTaskData:BindActDailyTaskExpireFunc(RefreshRedSteinsGateDailyTaskCallback)
  self._dailyTaskData:RegisterActDailyRefresh()
end

function Act23SteinsGateData:__InitTermTaskData()
  self._termTaskData = ActTermTaskDataOne.New()
  self._termTaskData:InitTermTask(self:GetActFrameId())
  local RefreshRedSteinsGateOnceTaskCallback = BindCallback(self, self.RefreshRedSteinsGateOnceTask)
  self._termTaskData:BindTeramTaskCommitFunc(RefreshRedSteinsGateOnceTaskCallback)
  self._termTaskData:BindTeramTaskUnlockFunc(RefreshRedSteinsGateOnceTaskCallback)
end

function Act23SteinsGateData:__InitUnlockInfo()
  self._unlockInfo = ActInternalUnlockInfo.New()
  local interactIdUnlockDic = {}
  local saveUserData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  local isLookedRepeat = saveUserData:GetSteinsGateRepeatLooked(self:GetActId())
  if not isLookedRepeat then
    interactIdUnlockDic[eActInteract.eLbIntrctEntityId.RepeatDg] = true
  end
  local isLookedCardSet = saveUserData:GetSteinsGateCardSetLooked(self:GetActId())
  if not isLookedCardSet then
    interactIdUnlockDic[eActInteract.eLbIntrctEntityId.CardSet] = true
  end
  self._unlockInfo:InitInteractUnlockInfo(interactIdUnlockDic)
  self:CheckIsSteinsGateInteractUnlock()
end

function Act23SteinsGateData:RefreshRedSteinsGateDailyTask()
  local reddot = self:GetActivityReddot()
  if reddot == nil then
    return
  end
  if self._dailyTaskData == nil then
    return
  end
  local childReddot = reddot:AddChild(Act23SteinsGateEnum.reddotType.DailyTask)
  local flag = self._dailyTaskData:IsExistDailyCompleteTask()
  local redCount = flag and 1 or 0
  if childReddot:GetRedDotCount() ~= redCount then
    childReddot:SetRedDotCount(redCount)
  end
end

function Act23SteinsGateData:RefreshRedSteinsGateOnceTask()
  local reddot = self:GetActivityReddot()
  if reddot == nil then
    return
  end
  local childReddot = reddot:AddChild(Act23SteinsGateEnum.reddotType.OnceTask)
  local flag = self._termTaskData:IsExistTermCompleteTask()
  local redCount = flag and 1 or 0
  if childReddot:GetRedDotCount() ~= redCount then
    childReddot:SetRedDotCount(redCount)
  end
end

function Act23SteinsGateData:RefreshRedSteinsGate_H5MiniGame()
  local reddot = self:GetActivityReddot()
  if reddot == nil then
    return
  end
  local childReddot = reddot:AddChild(Act23SteinsGateEnum.reddotType.H5MiniGame)
  local flag = true
  local redCount = flag and 0 or 1
  if childReddot:GetRedDotCount() ~= redCount then
    childReddot:SetRedDotCount(redCount)
  end
end

function Act23SteinsGateData:RefreshRedSteinsGate_Brotato()
  local reddot = self:GetActivityReddot()
  if reddot == nil then
    return
  end
  local childReddot = reddot:AddChild(Act23SteinsGateEnum.reddotType.Brotato)
  local saveUserData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  local flag = saveUserData:GetSteinsGateBrotatoLooked(self:GetActId())
  local redCount = flag and 0 or 1
  if childReddot:GetRedDotCount() ~= redCount then
    childReddot:SetRedDotCount(redCount)
  end
end

function Act23SteinsGateData:GetSteinsLobbyIndex()
  local cfg = self:GetNowSteinsGateStoryLineCfg()
  return cfg.lobby_index
end

function Act23SteinsGateData:GetSteinsGateDailyTaskData()
  return self._dailyTaskData
end

function Act23SteinsGateData:GetSteinsGateTermTaskData()
  return self._termTaskData
end

function Act23SteinsGateData:GetSteinsGateCfg()
  return self._mainCfg
end

function Act23SteinsGateData:GetSteinsGateRepeatDgData()
  local actFrameId = self:GetActFrameId()
  local lvList = ConfigData.act_general_repeat_dg.level_list_dic[actFrameId]
  if lvList == nil then
    error("Cant get act_general_repeat_dg cfg, actFrameId = " .. tostring(actFrameId))
    return
  end
  local dungeonLevelDataList = {}
  for i, dungeon_id in ipairs(lvList) do
    local dungeonCfg = ConfigData.act_general_repeat_dg[actFrameId][dungeon_id]
    local dungeonLevelData = ActCommonRepeatDungeonLevelData.New(dungeon_id)
    dungeonLevelData:InitActCmRepeatDungeonLvData(dungeonCfg, i, self)
    table.insert(dungeonLevelDataList, dungeonLevelData)
  end
  local dungeonCollect = ActDungeonLevelCollect.New()
  dungeonCollect:InitActDungeonLevelCollectCommon(dungeonLevelDataList, self)
  return dungeonCollect
end

function Act23SteinsGateData:GetSteinsGateStoryLineCfgByInteractId(interactId)
  local nodeId = ConfigData.activity_23steinsgate_storyline.interact2NodeId[interactId]
  return ConfigData.activity_23steinsgate_storyline[nodeId]
end

function Act23SteinsGateData:GetNowSteinsGateStoryLineCfg()
  local nowNodeData = self.sgStoryData:GetCurOpenNode()
  return nowNodeData:Act23GSSN_GetNodeCfg()
end

function Act23SteinsGateData:GetSteinsGateStorySectorId()
  return self._mainCfg.story_sector
end

function Act23SteinsGateData:IsSteinsGateEpSectorId(sectorId)
  return table.contain(self._mainCfg.level_sector, sectorId)
end

function Act23SteinsGateData:IsSteinsGateBrotatoSectorId(sectorId)
  return self._mainCfg.brotato_sector == sectorId
end

function Act23SteinsGateData:GetSteinsGateInteractData()
  return self.sgInteractData
end

function Act23SteinsGateData:GetSteinsGateStotyData()
  return self.sgStoryData
end

function Act23SteinsGateData:GetSteinsGateUnlockInfo()
  return self._unlockInfo
end

function Act23SteinsGateData:RefreshAllStoryData()
  self.sgStoryData:Act23SG_UpdateAllData()
end

function Act23SteinsGateData:GetSteinsGateTipInfo()
  local curNode = self.sgStoryData:GetCurNode()
  if curNode:Act23GSSN_GetIsClear() then
    return false
  end
  local title = ConfigData:GetTipContent(45001, curNode:Act23GSSN_GetNodeTitle("."))
  return true, title
end

function Act23SteinsGateData:UpdataBrotatoData(msg)
  local brotatoId = self._mainCfg.game_brotato
  if 0 < brotatoId then
    local activityBrotatoLobbyCtrl = ControllerManager:GetController(ControllerTypeId.ActivityBrotatoLobby, true)
    activityBrotatoLobbyCtrl:UpdataBrotatoData(msg, brotatoId, self:GetActFrameId())
  end
end

function Act23SteinsGateData:CheckIsSteinsGateInteractUnlock()
  local actDungeonLevelCollect = self:GetSteinsGateRepeatDgData()
  if actDungeonLevelCollect ~= nil and actDungeonLevelCollect:IsDgLevelCollectUnlock() then
    local saveUserData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
    local isLooked = saveUserData:GetSteinsGateRepeatLooked(self:GetActId())
    if not isLooked then
      self._unlockInfo:AddInteractUnlockInfo(eActInteract.eLbIntrctEntityId.RepeatDg)
    end
  end
  local cardSetActCtrl = ControllerManager:GetController(ControllerTypeId.ActivityCardSet)
  if cardSetActCtrl ~= nil then
    local actCardSetData = cardSetActCtrl:GetOneActCardSetData()
    if actCardSetData ~= nil and actCardSetData:IsActivityRunning() and actCardSetData:GetActivityIsUnlock() then
      local saveUserData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
      local isLooked = saveUserData:GetSteinsGateCardSetLooked(self:GetActId())
      if not isLooked then
        self._unlockInfo:AddInteractUnlockInfo(eActInteract.eLbIntrctEntityId.CardSet)
      end
    end
  end
end

function Act23SteinsGateData:GetSteinsGateLockTipByType(entityId)
  if entityId == eActInteract.eLbIntrctEntityId.RepeatDg then
    local actDungeonLevelCollect = self:GetSteinsGateRepeatDgData()
    if actDungeonLevelCollect ~= nil then
      return actDungeonLevelCollect:GetDgLevelCollectUnlockTip()
    end
  elseif entityId == eActInteract.eLbIntrctEntityId.CardSet then
    local cardSetActCtrl = ControllerManager:GetController(ControllerTypeId.ActivityCardSet)
    if cardSetActCtrl ~= nil then
      local actCardSetData = cardSetActCtrl:GetOneActCardSetData()
      if actCardSetData ~= nil then
        return actCardSetData:GetActivityLockTip(true)
      end
    end
  end
  return nil
end

function Act23SteinsGateData:SGLinkCardSetReddot()
  local cardSetActCtrl = ControllerManager:GetController(ControllerTypeId.ActivityCardSet)
  if cardSetActCtrl ~= nil then
    local rootNode = self:GetActivityReddot()
    local subActRedNodeRoot = rootNode:AddChild(Act23SteinsGateEnum.reddotType.CardSetTask)
    cardSetActCtrl:ReSetReddotRoot(subActRedNodeRoot)
  end
end

function Act23SteinsGateData:GetActivityReddotNum()
  local isBlue = true
  local actRedDotNode = self:GetActivityReddot()
  if actRedDotNode == nil then
    error("can't get activity reddot node")
    return false, 0
  end
  local num = actRedDotNode:GetRedDotCount()
  for i, v in ipairs(Act23SteinsGateEnum.reddotIsRedType) do
    local redChild = actRedDotNode:GetChild(v)
    if redChild ~= nil and 0 < redChild:GetRedDotCount() then
      isBlue = false
      break
    end
  end
  return isBlue, num
end

return Act23SteinsGateData
