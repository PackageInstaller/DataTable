local ActivityBase = require("Game.ActivityFrame.ActivityBase")
local ActivityCarnival23Data = class("ActivityCarnival23Data", ActivityBase)
local ActivityFrameEnum = require("Game.ActivityFrame.ActivityFrameEnum")
local CurActType = ActivityFrameEnum.eActivityType.ActivityCarnival23
local ActivityFrameUtil = require("Game.ActivityFrame.ActivityFrameUtil")
local ActivityFrameData = require("Game.ActivityFrame.ActivityFrameData")
local ActivityCarnival23Enum = require("Game.ActivityCarnival23.Data.ActivityCarnival23Enum")
local ActDailyTaskData = require("Game.ActivityFrame.ActDailyTaskData")
local ActTermTaskDataMul = require("Game.ActivityFrame.ActTermTaskDataMul")
local CheckerTypeId, CheckerGlobalConfig = table.unpack(require("Game.Common.CheckCondition.CheckerGlobalConfig"))

function ActivityCarnival23Data:InitCarnival23Data(msg)
  self:SetActFrameDataByType(CurActType, msg.actId)
  self:UpdateActFrameDataSingleMsg(msg)
  self._mainCfg = ConfigData.activity_carnival23_main[msg.actId]
  self:__InitDailyTaskData()
  self:__InitTermTaskData()
  self:__InitActivityBattlePass()
  self:UpdateCarnival23Data(msg)
  self:RefreshRedCarnival23DailyTask()
  self:RefreshRedCarnival23OnceTask()
  self:RefreshRedCarnival23ActivityBP()
  self:RefreshRedCarnival23Shop()
  self:RefreshRedCarnival23Main()
  self:RefreshRedCarnival23ExtraSector()
end

function ActivityCarnival23Data:UpdateCarnival23Data(msg)
  self.recordSectorId = msg.recordSectorId
end

function ActivityCarnival23Data:__InitDailyTaskData()
  local actFrameCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame)
  self._dailyTaskData = actFrameCtrl:GetActDailyTaskData(self:GetActFrameId())
  if self._dailyTaskData == nil then
    self._dailyTaskData = ActDailyTaskData.New()
    self._dailyTaskData:InitActDailyTask(self:GetActFrameId())
  end
  local RefreshRedWinter23DailyTaskCallback = BindCallback(self, self.RefreshRedCarnival23DailyTask)
  self._dailyTaskData:BindActDailyTaskCommitFunc(RefreshRedWinter23DailyTaskCallback)
  self._dailyTaskData:BindActDailyTaskChangeFunc(RefreshRedWinter23DailyTaskCallback)
  self._dailyTaskData:BindActDailyTaskExpireFunc(RefreshRedWinter23DailyTaskCallback)
  self._dailyTaskData:RegisterActDailyRefresh()
end

function ActivityCarnival23Data:__InitTermTaskData()
  self._termTaskData = ActTermTaskDataMul.New()
  self._termTaskData:InitTermTask(self:GetActFrameId())
  local RefreshRedWnter23OnceTaskCallback = BindCallback(self, self.RefreshRedCarnival23OnceTask)
  self._termTaskData:BindTeramTaskCommitFunc(RefreshRedWnter23OnceTaskCallback)
  self._termTaskData:BindTeramTaskUnlockFunc(RefreshRedWnter23OnceTaskCallback)
end

function ActivityCarnival23Data:__InitActivityBattlePass()
  local actFrameCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame, true)
  local actFrameData = actFrameCtrl:GetActivityFrameData(self:GetCarnival23Cfg().activity_id)
  if actFrameData == nil then
    return
  end
  local RefreshRedActivityBpCallback = BindCallback(self, self.RefreshRedCarnival23ActivityBP)
  PlayerDataCenter.battlepassData:SetBattlePassUpdateCallbackByActId(actFrameData:GetActId(), RefreshRedActivityBpCallback)
end

function ActivityCarnival23Data:RefreshRedCarnival23DailyTask()
  local reddot = self:GetActivityReddot()
  if reddot == nil then
    return
  end
  if self._dailyTaskData == nil then
    return
  end
  local childReddot = reddot:AddChild(ActivityCarnival23Enum.reddotType.DailyTask)
  local flag = self._dailyTaskData:IsExistDailyCompleteTask()
  local redCount = flag and 1 or 0
  if childReddot:GetRedDotCount() ~= redCount then
    childReddot:SetRedDotCount(redCount)
  end
end

function ActivityCarnival23Data:RefreshRedCarnival23OnceTask()
  local reddot = self:GetActivityReddot()
  if reddot == nil then
    return
  end
  local childReddot = reddot:AddChild(ActivityCarnival23Enum.reddotType.OnceTask)
  local flag = self._termTaskData:IsExistTermCompleteTask()
  local redCount = flag and 1 or 0
  if childReddot:GetRedDotCount() ~= redCount then
    childReddot:SetRedDotCount(redCount)
  end
end

function ActivityCarnival23Data:RefreshRedCarnival23ExtraSector()
  local reddot = self:GetActChildRedDot(ActivityCarnival23Enum.reddotType.SectorExLooked)
  if reddot == nil then
    return
  end
  local flag = self:GetExtraSectorIsLooked()
  if not self:IsActivityRunning() then
    flag = true
  end
  local redCount = not flag and 1 or 0
  if reddot:GetRedDotCount() ~= redCount then
    reddot:SetRedDotCount(redCount)
  end
end

function ActivityCarnival23Data:RefreshRedCarnival23ActivityBP()
  local reddot = self:GetActivityReddot()
  if reddot == nil then
    return
  end
  local actFrameCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame, true)
  local actFrameData = actFrameCtrl:GetActivityFrameData(self:GetCarnival23Cfg().activity_id)
  if actFrameData == nil then
    return
  end
  local bpData = PlayerDataCenter.battlepassData:GetBattlePassByActId(actFrameData:GetActId())
  if bpData == nil then
    return
  end
  local childReddot = reddot:AddChild(ActivityCarnival23Enum.reddotType.ActivityBP)
  local flag = false
  if bpData:PassHaveRewardTake() then
    flag = true
  end
  if bpData:IsBattlePassRunning() and bpData:GetHasBpTaskComplete() and not bpData:IsPassFullLevel() then
    flag = true
  end
  local redCount = flag and 1 or 0
  if childReddot:GetRedDotCount() ~= redCount then
    childReddot:SetRedDotCount(redCount)
  end
end

function ActivityCarnival23Data:RefreshRedCarnival23Shop()
  local reddot = self:GetActivityReddot()
  if reddot == nil then
    return
  end
  local flag = false
  local childReddot = reddot:AddChild(ActivityCarnival23Enum.reddotType.Shop)
  local userDataCache = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  for i, v in ipairs(self._mainCfg.shop_list) do
    if not userDataCache:GetCarnival23ShopLooked(self:GetActId(), v) then
      flag = true
      break
    end
  end
  local redCount = flag and 1 or 0
  if childReddot:GetRedDotCount() ~= redCount then
    childReddot:SetRedDotCount(redCount)
  end
end

function ActivityCarnival23Data:RefreshRedCarnival23Main()
  local reddot = self:GetActivityReddot()
  if reddot == nil then
    return
  end
  local flag = false
  local childReddot = reddot:AddChild(ActivityCarnival23Enum.reddotType.main)
  local enterFlag, defaultSectorId = self:GetLastCarnival23MainSector()
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

function ActivityCarnival23Data:GetActivityReddotNum()
  local isBlue = true
  local actRedDotNode = self:GetActivityReddot()
  if actRedDotNode == nil then
    error("can't get activity reddot node")
    return false, 0
  end
  local num = actRedDotNode:GetRedDotCount()
  for i, v in ipairs(ActivityCarnival23Enum.reddotIsRedType) do
    local redChild = actRedDotNode:GetChild(v)
    if redChild ~= nil and 0 < redChild:GetRedDotCount() then
      isBlue = false
      break
    end
  end
  return isBlue, num
end

function ActivityCarnival23Data:GetWinter23SeconedUnlock()
end

function ActivityCarnival23Data:IsCarnival23ShopLooked(shopId)
  local userDataCache = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  return userDataCache:GetCarnival23ShopLooked(self:GetActId(), shopId)
end

function ActivityCarnival23Data:SetCarnival23ShopLooked(shopId)
  local userDataCache = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  userDataCache:SetCarnival23ShopLooked(self:GetActId(), shopId)
  self:RefreshRedCarnival23Shop()
end

function ActivityCarnival23Data:SetCarnival23ClientRecordSector(recordSectorId)
  local userDataCache = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  userDataCache:SetCarnival23FirstEnterSectorId(self:GetActId(), recordSectorId)
  self.recordSectorId = recordSectorId
  self:RefreshRedCarnival23Main()
end

function ActivityCarnival23Data:GetCarnival23DailyTaskData()
  return self._dailyTaskData
end

function ActivityCarnival23Data:GetCarnival23TermTaskData()
  return self._termTaskData
end

function ActivityCarnival23Data:GetCarnival23Cfg()
  return self._mainCfg
end

function ActivityCarnival23Data:GetExtraSectorId()
  return self._mainCfg.extra_stage
end

function ActivityCarnival23Data:GetCarnival23TinyGame()
  if self._mainCfg ~= nil then
    return self._mainCfg.game_brotato
  end
  return -1
end

function ActivityCarnival23Data:SetCarnival23TinyGameStageId(stageId)
  self._tinyGameStageId = stageId
end

function ActivityCarnival23Data:GetCarnival23TinyGameStageId()
  return self._tinyGameStageId
end

function ActivityCarnival23Data:GetRelationStage(stageId)
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

function ActivityCarnival23Data:GetLastCarnival23MainSector()
  if not self.recordSectorId or self.recordSectorId == 0 then
    local userDataCache = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
    local clientDiff = userDataCache:GetCarnival23FirstEnterSectorId(self:GetActId())
    self.recordSectorId = clientDiff or nil
  end
  return self.recordSectorId == self._mainCfg.normal_sector or self.recordSectorId == self._mainCfg.hard_stage, self.recordSectorId
end

function ActivityCarnival23Data:IsCarnival23Sector(sectorId)
  return self._mainCfg.hard_stage == sectorId or self._mainCfg.normal_sector == sectorId
end

function ActivityCarnival23Data:GetRepeatArrangeType()
  return self._mainCfg.farm_stage_arrange
end

function ActivityCarnival23Data:GetIsExterUnlock()
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

function ActivityCarnival23Data:GetBrotatoHighestScore()
  if self.brotatoMaxScore ~= nil then
    return self.brotatoMaxScore
  end
  return -1
end

function ActivityCarnival23Data:GetExtraSectorIsLooked()
  local userData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  local isLooked = userData:GetCarnival23ExtraSectorLooked(self:GetActId())
  return isLooked
end

function ActivityCarnival23Data:SetExtraSectorIsLooked()
  local userData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  userData:SetCarnival23ExtraSectorLooked(self:GetActId())
  self:RefreshRedCarnival23ExtraSector()
end

return ActivityCarnival23Data
