local ActivityBase = require("Game.ActivityFrame.ActivityBase")
local ActivityWinter23Data = class("ActivityWinter23Data", ActivityBase)
local ActivityFrameEnum = require("Game.ActivityFrame.ActivityFrameEnum")
local CurActType = ActivityFrameEnum.eActivityType.Winter23
local ActivityFrameUtil = require("Game.ActivityFrame.ActivityFrameUtil")
local ActivityWinter23Enum = require("Game.ActivityWinter23.Data.ActivityWinter23Enum")
local ActTechTree = require("Game.ActivityFrame.ActTechTree")
local ActDailyTaskData = require("Game.ActivityFrame.ActDailyTaskData")
local ActTermTaskDataMul = require("Game.ActivityFrame.ActTermTaskDataMul")
local WarChessSeasonAddtionData = require("Game.WarChessSeason.WarChessSeasonAddtionData")
local CheckerTypeId, CheckerGlobalConfig = table.unpack(require("Game.Common.CheckCondition.CheckerGlobalConfig"))

function ActivityWinter23Data:InitWinter23Data(msg)
  self:SetActFrameDataByType(CurActType, msg.actId)
  self:UpdateActFrameDataSingleMsg(msg)
  self._mainCfg = ConfigData.activity_winter23_main[msg.actId]
  self:__InitTechData()
  self:__InitDailyTaskData()
  self:__InitTermTaskData()
  self:UpdateWinter23Data(msg)
  self._termTaskData:RegisterActTermRefresh()
  self:RefreshRedWinter23DailyTask()
  self:RefreshRedWinter23Tech()
  self:RefreshRedWnter23OnceTask()
  self:RefreshRedWinter23Shop()
  self:SetMiniGameData(msg.bird)
  self:SetMiniGameMineMaxScore(msg.bird.highestScore)
  self:SetMiniGameIsGottenJoinRewards(msg.bird.joinRewards)
  self:RefreshRedWinter23Main()
end

function ActivityWinter23Data:UpdateWinter23Data(msg)
  if msg.tech ~= nil then
    self._actTechTree:UpdateActTechTree(msg.tech)
  end
  self.recordSectorId = msg.recordSectorId
end

function ActivityWinter23Data:__InitTechData()
  self._actTechTree = ActTechTree.New()
  self._actTechTree:InitTechTree(self._mainCfg.tech_id, self)
  local RefreshRedTechCallback = BindCallback(self, self.RefreshRedWinter23Tech)
  self._actTechTree:BindActTechUpdateFunc(RefreshRedTechCallback)
  self._actTechTree:BindActTechAllResetFunc(RefreshRedTechCallback)
  local actFrameCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame)
  actFrameCtrl:AddActivityTech(self._actTechTree)
end

function ActivityWinter23Data:__InitDailyTaskData()
  local actFrameCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame)
  self._dailyTaskData = actFrameCtrl:GetActDailyTaskData(self:GetActFrameId())
  if self._dailyTaskData == nil then
    self._dailyTaskData = ActDailyTaskData.New()
    self._dailyTaskData:InitActDailyTask(self:GetActFrameId())
  end
  local RefreshRedWinter23DailyTaskCallback = BindCallback(self, self.RefreshRedWinter23DailyTask)
  self._dailyTaskData:BindActDailyTaskCommitFunc(RefreshRedWinter23DailyTaskCallback)
  self._dailyTaskData:BindActDailyTaskChangeFunc(RefreshRedWinter23DailyTaskCallback)
  self._dailyTaskData:BindActDailyTaskExpireFunc(RefreshRedWinter23DailyTaskCallback)
  self._dailyTaskData:RegisterActDailyRefresh()
end

function ActivityWinter23Data:__InitTermTaskData()
  self._termTaskData = ActTermTaskDataMul.New()
  self._termTaskData:InitTermTask(self:GetActFrameId())
  local RefreshRedWnter23OnceTaskCallback = BindCallback(self, self.RefreshRedWnter23OnceTask)
  self._termTaskData:BindTeramTaskCommitFunc(RefreshRedWnter23OnceTaskCallback)
  self._termTaskData:BindTeramTaskUnlockFunc(RefreshRedWnter23OnceTaskCallback)
end

function ActivityWinter23Data:RefreshRedWinter23Tech()
  local reddot = self:GetActivityReddot()
  if reddot == nil then
    return
  end
  local childReddot = reddot:AddChild(ActivityWinter23Enum.reddotType.Tech)
  local spBranch = self._mainCfg.tech_special_branch
  local flag = ActivityFrameUtil.CalActTechRedWithSpBranchAndItem(self, self._actTechTree, spBranch, 16000)
  local redCount = flag and 1 or 0
  if childReddot:GetRedDotCount() ~= redCount then
    childReddot:SetRedDotCount(redCount)
  end
end

function ActivityWinter23Data:RefreshRedWinter23DailyTask()
  local reddot = self:GetActivityReddot()
  if reddot == nil then
    return
  end
  if self._dailyTaskData == nil then
    return
  end
  local childReddot = reddot:AddChild(ActivityWinter23Enum.reddotType.DailyTask)
  local flag = self._dailyTaskData:IsExistDailyCompleteTask()
  local redCount = flag and 1 or 0
  if childReddot:GetRedDotCount() ~= redCount then
    childReddot:SetRedDotCount(redCount)
  end
end

function ActivityWinter23Data:RefreshRedWnter23OnceTask()
  local reddot = self:GetActivityReddot()
  if reddot == nil then
    return
  end
  local childReddot = reddot:AddChild(ActivityWinter23Enum.reddotType.OnceTask)
  local flag = self._termTaskData:IsExistTermCompleteTask()
  local redCount = flag and 1 or 0
  if childReddot:GetRedDotCount() ~= redCount then
    childReddot:SetRedDotCount(redCount)
  end
end

function ActivityWinter23Data:RefreshRedWinter23Shop()
  local reddot = self:GetActivityReddot()
  if reddot == nil then
    return
  end
  local flag = false
  local childReddot = reddot:AddChild(ActivityWinter23Enum.reddotType.Shop)
  local userDataCache = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  for i, v in ipairs(self._mainCfg.shop_list) do
    if not userDataCache:GetWinter23ShopLooked(self:GetActId(), v) then
      flag = true
      break
    end
  end
  local redCount = flag and 1 or 0
  if childReddot:GetRedDotCount() ~= redCount then
    childReddot:SetRedDotCount(redCount)
  end
end

function ActivityWinter23Data:RefreshRedWinter23Main()
  local reddot = self:GetActivityReddot()
  if reddot == nil then
    return
  end
  local flag = false
  local childReddot = reddot:AddChild(ActivityWinter23Enum.reddotType.main)
  local enterFlag, defaultSectorId = self:GetLastWinter23MainSector()
  if not enterFlag then
    flag = true
  else
    local avgPlayCtrl = ControllerManager:GetController(ControllerTypeId.AvgPlay)
    if avgPlayCtrl:IsPlayedAllMainAvg(defaultSectorId, 1, nil, nil, true) ~= 0 then
      flag = true
    end
  end
  if not self:IsActivityRunning() then
    flag = false
  end
  local redCount = flag and 1 or 0
  if childReddot:GetRedDotCount() ~= redCount then
    childReddot:SetRedDotCount(redCount)
  end
end

function ActivityWinter23Data:GetActivityReddotNum()
  local isBlue = true
  local actRedDotNode = self:GetActivityReddot()
  if actRedDotNode == nil then
    error("can't get activity reddot node")
    return false, 0
  end
  local num = actRedDotNode:GetRedDotCount()
  for i, v in ipairs(ActivityWinter23Enum.reddotIsRedType) do
    local redChild = actRedDotNode:GetChild(v)
    if redChild ~= nil and 0 < redChild:GetRedDotCount() then
      isBlue = false
      break
    end
  end
  return isBlue, num
end

function ActivityWinter23Data:GetWinter23SeconedUnlock()
  return CheckCondition.CheckLua(self._mainCfg.second_pre_condition, self._mainCfg.second_pre_para1, self._mainCfg.second_pre_para2)
end

function ActivityWinter23Data:IsWinter23ShopLooked(shopId)
  local userDataCache = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  return userDataCache:GetWinter23ShopLooked(self:GetActId(), shopId)
end

function ActivityWinter23Data:SetWinter23ShopLooked(shopId)
  local userDataCache = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  userDataCache:SetWinter23ShopLooked(self:GetActId(), shopId)
  self:RefreshRedWinter23Shop()
end

function ActivityWinter23Data:IsWinter23ChapterLooked(chapterId)
  if not self.chapterReads then
    return false
  end
  return self.chapterReads[chapterId]
end

function ActivityWinter23Data:SetWinter23ClientRecordSector(recordSectorId)
  local userDataCache = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  userDataCache:SetWinter23FirstEnterSectorId(self:GetActId(), recordSectorId)
  self.recordSectorId = recordSectorId
end

function ActivityWinter23Data:GetWinter23TechTree()
  return self._actTechTree
end

function ActivityWinter23Data:GetWinter23DailyTaskData()
  return self._dailyTaskData
end

function ActivityWinter23Data:GetWinter23TermTaskData()
  return self._termTaskData
end

function ActivityWinter23Data:GetWinter23Cfg()
  return self._mainCfg
end

function ActivityWinter23Data:GetRelationStage(stageId)
  if not self:IsActivityRunning() then
    return nil
  end
  local stageCfg = ConfigData.sector_stage[stageId]
  if stageCfg == nil or stageCfg.sector ~= self._mainCfg.hard_stage then
    return nil
  end
  local sectorDiffDic = ConfigData.sector_stage.sectorDiffDic[self._mainCfg.normal_sector]
  if sectorDiffDic == nil then
    return nil
  end
  sectorDiffDic = sectorDiffDic[stageCfg.difficulty]
  if sectorDiffDic == nil then
    return nil
  end
  local relationId = sectorDiffDic[stageCfg.num]
  if relationId == nil then
    return nil
  end
  return ConfigData.sector_stage[relationId]
end

function ActivityWinter23Data:GetLastWinter23MainSector()
  if not self.recordSectorId or self.recordSectorId == 0 then
    local userDataCache = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
    local clientDiff = userDataCache:GetWinter23FirstEnterSectorId(self:GetActId())
    self.recordSectorId = clientDiff or nil
  end
  return self.recordSectorId == self._mainCfg.normal_sector or self.recordSectorId == self._mainCfg.hard_stage, self.recordSectorId
end

function ActivityWinter23Data:IsWinter23Sector(sectorId)
  return self._mainCfg.hard_stage == sectorId or self._mainCfg.normal_sector == sectorId or self._mainCfg.warchess_guide_sector == sectorId
end

function ActivityWinter23Data:GetRepeatStageList(sectorId)
  local farm_stage_id = self._mainCfg.farm_stage_id
  local list = {}
  for i, v in pairs(farm_stage_id) do
    local stageCfg = ConfigData.sector_stage[v]
    if stageCfg.sector == sectorId then
      table.insert(list, stageCfg.id)
    end
  end
  return list
end

function ActivityWinter23Data:GetRepeatArrangeType()
  return self._mainCfg.farm_stage_arrange
end

function ActivityWinter23Data:GetWarChessGreenHandSectorId()
  return self._mainCfg.warchess_guide_sector
end

function ActivityWinter23Data:GetMiniGameId()
  return self._mainCfg.game_penguin
end

function ActivityWinter23Data:GetMiniGameIsGottenJoinRewards()
  if self.minigameMsg == nil then
    error("not get minigameMsg")
  end
  return self.minigameMsg.isGottenJoinRewards
end

function ActivityWinter23Data:GetMiniGameMaxScore()
  if self.minigameMsg == nil then
    error("not get minigameMsg")
  end
  return self.minigameMsg.highestScore
end

function ActivityWinter23Data:GetWinter23WarchessSeasonId()
  return self._mainCfg.warchess_season_id
end

function ActivityWinter23Data:GetHallowmasSeasonAddtion()
  if self._seasonAddtionData == nil then
    self._seasonAddtionData = WarChessSeasonAddtionData.New()
  end
  return self._seasonAddtionData
end

function ActivityWinter23Data:GetIsExterUnlock()
  local checkLevelIds = self._mainCfg.extra_obj_unlock
  if checkLevelIds == nil or #checkLevelIds <= 0 then
    return false
  end
  for _, stageId in pairs(checkLevelIds) do
    local isUnlock = CheckCondition.CheckLua({
      CheckerTypeId.CompleteStage
    }, {stageId})
    if isUnlock then
      return true
    end
  end
  return false
end

function ActivityWinter23Data:SetMiniGameData(minigameMsg)
  self.minigameMsg = minigameMsg
end

function ActivityWinter23Data:SetMiniGameIsGottenJoinRewards(bool)
  if self.minigameMsg == nil then
    error("not get minigameMsg")
  end
  self.minigameMsg.isGottenJoinRewards = bool
end

function ActivityWinter23Data:SetMiniGameMineMaxScore(score)
  if self.minigameMsg == nil then
    error("not get minigameMsg")
  end
  if (score or 0) < self.minigameMsg.highestScore then
    warn("highest score not above current highest score")
    return
  end
  self.minigameMsg.highestScore = score
end

return ActivityWinter23Data
