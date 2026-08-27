local ActivityBase = require("Game.ActivityFrame.ActivityBase")
local ActivityAnniversary23Data = class("ActivityAnniversary23Data", ActivityBase)
local ActivityFrameEnum = require("Game.ActivityFrame.ActivityFrameEnum")
local CurActType = ActivityFrameEnum.eActivityType.Anniversary23
local ActivityFrameUtil = require("Game.ActivityFrame.ActivityFrameUtil")
local ActivityFrameData = require("Game.ActivityFrame.ActivityFrameData")
local ActivityAnniversary23Enum = require("Game.ActivityAnniversary23.Data.ActivityAnniversary23Enum")
local ActDailyTaskData = require("Game.ActivityFrame.ActDailyTaskData")
local ActTermTaskDataOne = require("Game.ActivityFrame.ActTermTaskDataOne")
local ActTechTree = require("Game.ActivityFrame.ActTechTree")
local WarChessSeasonAddtionData = require("Game.WarChessSeason.WarChessSeasonAddtionData")
local CheckerTypeId, CheckerGlobalConfig = table.unpack(require("Game.Common.CheckCondition.CheckerGlobalConfig"))
local ActMonsterCardPlayData = require("Game.ActivityFrame.ActivityMonsterCard.ActMonsterCardPlayData")
local ActHardLevelPlayData = require("Game.ActivityFrame.ActCommonHardLevel.ActHardLevelPlayData")

function ActivityAnniversary23Data:InitAnniversary23Data(msg)
  self:SetActFrameDataByType(CurActType, msg.actId)
  self:UpdateActFrameDataSingleMsg(msg)
  self._mainCfg = ConfigData.activity_anniversary_main[msg.actId]
  self:__InitDailyTaskData()
  self:__InitTermTaskData()
  self:__InitTechData()
  self:__InitMonsterCardData()
  self:__InitRecommendTaskCfg()
  self:__InitCommonHardLevelData()
  self:RefreshRedAnniversary23DailyTask()
  self:RefreshRedAnniversary23OnceTask()
  self:RefreshRedAnniversary23Shop()
  self:RefreshRedAnniversary23MainStory()
  self:RefreshRedAnniversary23WCSTask()
  self.__UpdateChildActivityRedCallback = BindCallback(self, self.__UpdateAnniversary23ChildActivityRed)
  self._childActivityRedDic = {}
  self:__InitAnniversary23ChildActivityRedListen()
  local actFrameId = self:GetActFrameId()
  local generakEpCfg = ConfigData.act_general_ep_main[actFrameId]
  if generakEpCfg ~= nil and #generakEpCfg.initial_protocol_all > 0 then
    local sectorId = generakEpCfg.main_stage
    ExplorationManager:AddEpNewEpBuffSelect(sectorId, generakEpCfg.initial_protocol_all)
  end
end

function ActivityAnniversary23Data:RefreshActivityTechData(tech)
  if self._actTechTree ~= nil and tech ~= nil then
    self._actTechTree:UpdateActTechTree(tech)
    self:RefreshRedAnniversary23Tech()
  end
end

function ActivityAnniversary23Data:RefreshActivityBpPoint(bpTable)
  ActivityBase.RefreshActivityBpPoint(self, bpTable)
  self:RefreshRedAnniversary23OnceTask()
  self:RefreshRedAnniversary23MainStory()
end

function ActivityAnniversary23Data:__InitTechData()
  local techTypeListCfg = ConfigData.activity_tech.actTechTypeList[self:GetActFrameId()]
  if techTypeListCfg == nil then
    return
  end
  self._actTechTree = ActTechTree.New()
  self._actTechTree:InitTechTree(self:GetActFrameId(), self)
  local RefreshRedTechCallback = BindCallback(self, self.RefreshRedAnniversary23Tech)
  self._actTechTree:BindActTechUpdateFunc(RefreshRedTechCallback)
  self._actTechTree:BindActTechAllResetFunc(RefreshRedTechCallback)
  local actFrameCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame)
  actFrameCtrl:AddActivityTech(self._actTechTree)
end

function ActivityAnniversary23Data:__InitMonsterCardData()
  local actFrameId = self:GetActFrameId()
  if ConfigData.activity_monster_card[actFrameId] == nil then
    return
  end
  self.actMonsterCardPlayData = ActMonsterCardPlayData.New(self)
end

function ActivityAnniversary23Data:__InitCommonHardLevelData()
  local actFrameId = self:GetActFrameId()
  if ConfigData.activity_hard_dungeon[actFrameId] == nil then
    return
  end
  self.actHardLevelData = ActHardLevelPlayData.New(self)
end

function ActivityAnniversary23Data:__InitDailyTaskData()
  local actFrameCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame)
  self._dailyTaskData = actFrameCtrl:GetActDailyTaskData(self:GetActFrameId())
  if self._dailyTaskData == nil then
    self._dailyTaskData = ActDailyTaskData.New()
    self._dailyTaskData:InitActDailyTask(self:GetActFrameId())
  end
  local RefreshRedWinter23DailyTaskCallback = BindCallback(self, self.RefreshRedAnniversary23DailyTask)
  self._dailyTaskData:BindActDailyTaskCommitFunc(RefreshRedWinter23DailyTaskCallback)
  self._dailyTaskData:BindActDailyTaskChangeFunc(RefreshRedWinter23DailyTaskCallback)
  self._dailyTaskData:BindActDailyTaskExpireFunc(RefreshRedWinter23DailyTaskCallback)
  self._dailyTaskData:RegisterActDailyRefresh()
end

function ActivityAnniversary23Data:__InitTermTaskData()
  self._termTaskData = ActTermTaskDataOne.New()
  self._termTaskData:InitTermTask(self:GetActFrameId())
  local RefreshRedWnter23OnceTaskCallback = BindCallback(self, self.RefreshRedAnniversary23OnceTask)
  self._termTaskData:BindTeramTaskCommitFunc(RefreshRedWnter23OnceTaskCallback)
  self._termTaskData:BindTeramTaskUnlockFunc(RefreshRedWnter23OnceTaskCallback)
end

function ActivityAnniversary23Data:__InitAnniversary23ChildActivityRedListen()
  local bpActFrameId = self._mainCfg.jump_activity_id[1]
  if bpActFrameId ~= nil then
    local bpReddot = self:__AddAnniversary23SingleChildRedListen(bpActFrameId)
    self._childActivityRedDic[ActivityAnniversary23Enum.reddotType.Jump1] = bpReddot
  end
  local flipActFrameId = self._mainCfg.jump_activity_id[2]
  if flipActFrameId ~= nil then
    local flipReddot = self:__AddAnniversary23SingleChildRedListen(flipActFrameId)
    self._childActivityRedDic[ActivityAnniversary23Enum.reddotType.Jump2] = flipReddot
  end
  self:__UpdateAnniversary23ChildActivityRed()
end

function ActivityAnniversary23Data:__AddAnniversary23SingleChildRedListen(activityId)
  local actFrameCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame, true)
  local actFrameData = actFrameCtrl:GetActivityFrameData(activityId)
  if actFrameData == nil then
    return
  end
  local childActivityReddot = actFrameData:GetActivityReddotNode()
  if childActivityReddot == nil then
    return
  end
  RedDotController:AddListener(childActivityReddot.nodePath, self.__UpdateChildActivityRedCallback)
  return childActivityReddot
end

function ActivityAnniversary23Data:__UpdateAnniversary23ChildActivityRed()
  for enum, childActivityReddot in pairs(self._childActivityRedDic) do
    self:__UpdateAnniversary23SingleChildRed(childActivityReddot, enum)
  end
end

function ActivityAnniversary23Data:__UpdateAnniversary23SingleChildRed(childActivityReddot, reddotEnum)
  local reddot = self:GetActivityReddot()
  if reddot == nil then
    return
  end
  if childActivityReddot ~= nil then
    local childReddot = reddot:AddChild(reddotEnum)
    local flag = childActivityReddot:GetRedDotCount() > 0
    local redCount = flag and 1 or 0
    if childReddot:GetRedDotCount() ~= redCount then
      childReddot:SetRedDotCount(redCount)
    end
  end
end

function ActivityAnniversary23Data:__RemoveAnniversary23ChildActivityRedListen()
  for enum, childActivityReddot in pairs(self._childActivityRedDic) do
    RedDotController:RemoveListener(childActivityReddot.nodePath, self.__UpdateChildActivityRedCallback)
  end
  self._childActivityRedDic = {}
end

function ActivityAnniversary23Data:RefreshRedAnniversary23DailyTask()
  local reddot = self:GetActivityReddot()
  if reddot == nil then
    return
  end
  if self._dailyTaskData == nil then
    return
  end
  local childReddot = reddot:AddChild(ActivityAnniversary23Enum.reddotType.DailyTask)
  local flag = self._dailyTaskData:IsExistDailyCompleteTask()
  local redCount = flag and 1 or 0
  if childReddot:GetRedDotCount() ~= redCount then
    childReddot:SetRedDotCount(redCount)
  end
end

function ActivityAnniversary23Data:RefreshRedAnniversary23OnceTask()
  local reddot = self:GetActivityReddot()
  if reddot == nil then
    return
  end
  local childReddot = reddot:AddChild(ActivityAnniversary23Enum.reddotType.OnceTask)
  local flag = self._termTaskData:IsExistTermCompleteTask()
  flag = flag or self:CheckTaskBpCanGetReward()
  local redCount = flag and 1 or 0
  if childReddot:GetRedDotCount() ~= redCount then
    childReddot:SetRedDotCount(redCount)
  end
end

function ActivityAnniversary23Data:RefreshRedAnniversary23WCSTask(taskData)
  local seasonId = self:GetAnvsr23WarchessSeasonId()
  if seasonId == 0 then
    return
  end
  local unlock = WarChessSeasonManager:IsWCSUnlock(seasonId)
  if not unlock then
    return
  end
  local actRed = self:GetActivityReddot()
  if actRed == nil then
    return
  end
  local envTaskRed = actRed:AddChild(ActivityAnniversary23Enum.reddotType.WCSEnvTask)
  if not self:IsActivityRunning() then
    envTaskRed:ClearChild()
    return
  end
  if taskData ~= nil then
    local _envId = ConfigData.warchess_season_general_env.taskEnvDic[taskData.id]
    if _envId ~= nil and taskData:CheckComplete() and WarChessSeasonManager:GetWCSEnvIsUnlock(_envId) then
      local envIdRed = envTaskRed:AddChild(_envId)
      if envIdRed:GetRedDotCount() ~= 1 then
        envIdRed:SetRedDotCount(1)
      end
    end
    return
  end
  local wcsCfg = WarChessSeasonManager:GetWCSCfg(seasonId)
  if wcsCfg == nil then
    return
  end
  for _, singEnvId in ipairs(wcsCfg.env_id) do
    if WarChessSeasonManager:GetWCSEnvIsUnlock(singEnvId) then
      local envIdRed = envTaskRed:AddChild(singEnvId)
      local envCfg = ConfigData.warchess_season_general_env[singEnvId]
      if envCfg ~= nil then
        local redCount = 0
        for _, taskId in ipairs(envCfg.env_task) do
          local taskData = PlayerDataCenter.allTaskData:GetTaskDataById(taskId)
          if taskData ~= nil and taskData:CheckComplete() then
            redCount = 1
            break
          end
        end
        envIdRed:SetRedDotCount(redCount)
      end
    end
  end
end

function ActivityAnniversary23Data:RefreshRedAnniversary23Shop()
  local reddot = self:GetActivityReddot()
  if reddot == nil then
    return
  end
  local flag = false
  local childReddot = reddot:AddChild(ActivityAnniversary23Enum.reddotType.Shop)
  local userDataCache = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  for i, v in ipairs(self._mainCfg.shop_list) do
    if not userDataCache:GetAnniversary23ShopLooked(self:GetActId(), v) then
      flag = true
      break
    end
  end
  local redCount = flag and 1 or 0
  if childReddot:GetRedDotCount() ~= redCount then
    childReddot:SetRedDotCount(redCount)
  end
end

function ActivityAnniversary23Data:RefreshRedAnniversary23MainStory()
  local reddot = self:GetActivityReddot()
  if reddot == nil then
    return
  end
  local flag = false
  local childReddot = reddot:AddChild(ActivityAnniversary23Enum.reddotType.MainStory)
  if self._avgIdDic == nil then
    self:__GenSectorAvgDic()
  end
  local avgPlayCtrl = ControllerManager:GetController(ControllerTypeId.AvgPlay, true)
  for k, v in pairs(self._avgIdDic) do
    local played = avgPlayCtrl:IsAvgPlayed(k)
    local unlock = avgPlayCtrl:IsAvgUnlock(k)
    if not played and unlock then
      flag = true
      break
    end
  end
  local redCount = flag and 1 or 0
  if childReddot:GetRedDotCount() ~= redCount then
    childReddot:SetRedDotCount(redCount)
  end
end

function ActivityAnniversary23Data:__GenSectorAvgDic()
  self._avgIdDic = {}
  local avgIds = ConfigData.story_avg.sectorAvgDic[self._mainCfg.story_stage]
  if avgIds == nil then
    return
  end
  for i, v in ipairs(avgIds) do
    self._avgIdDic[v] = true
  end
end

function ActivityAnniversary23Data:IsSeasonSectorAvg(avgId)
  if self._avgIdDic == nil then
    self:__GenSectorAvgDic()
  end
  return self._avgIdDic[avgId]
end

function ActivityAnniversary23Data:RefreshRedAnniversary23Tech()
  if self._actTechTree == nil then
    return
  end
  local reddot = self:GetActivityReddot()
  if reddot == nil then
    return
  end
  local reddotChild = reddot:AddChild(ActivityAnniversary23Enum.reddotType.Tech)
  local itemReddot = reddot:AddChild(ActivityAnniversary23Enum.reddotType.TechItemLimit)
  if not self:IsActivityRunning() then
    reddotChild:ClearChild()
    itemReddot:SetRedDotCount(0)
    return
  end
  local treeDic = self._actTechTree:GetTechDataDic()
  local techSpecialBranch = ConfigData.activity_tech_type[self:GetActFrameId()].tech_special_branch
  local branchDic = treeDic[techSpecialBranch]
  local hasLeveUpTech = false
  for k, techData in pairs(branchDic) do
    if techData:IsCouldLevelUp() then
      hasLeveUpTech = true
      break
    end
  end
  local reddotChildPage = reddotChild:AddChild(techSpecialBranch)
  reddotChildPage:SetRedDotCount(hasLeveUpTech and 1 or 0)
  local flag, itemId = self._actTechTree:GetTreeResetReturnItemId()
  if flag then
    if PlayerDataCenter:GetItemCount(itemId) >= 16000 then
      if not hasLeveUpTech then
        for k, techDataDic in pairs(treeDic) do
          if k ~= techSpecialBranch then
            for k, techData in pairs(techDataDic) do
              if techData:IsCouldLevelUp() then
                hasLeveUpTech = true
                break
              end
            end
          end
        end
      end
      itemReddot:SetRedDotCount(hasLeveUpTech and 1 or 0)
    else
      itemReddot:SetRedDotCount(0)
    end
  end
end

function ActivityAnniversary23Data:GetActivityReddotNum()
  local isBlue = true
  local actRedDotNode = self:GetActivityReddot()
  if actRedDotNode == nil then
    error("can't get activity reddot node")
    return false, 0
  end
  local num = actRedDotNode:GetRedDotCount()
  for i, v in ipairs(ActivityAnniversary23Enum.reddotIsRedType) do
    local redChild = actRedDotNode:GetChild(v)
    if redChild ~= nil and 0 < redChild:GetRedDotCount() then
      isBlue = false
      break
    end
  end
  return isBlue, num
end

function ActivityAnniversary23Data:CheckTaskBpCanGetReward()
  if self._termTaskData == nil then
    return false
  end
  local term
  local count = self._termTaskData:GetTermTaskStageCount()
  for i = 1, count do
    if not (self._termTaskData:GetTermOpenTime(i) > PlayerDataCenter.timestamp) then
      term = i
    end
  end
  if term == nil then
    return false
  end
  local bpTable = self:GetActivityBpPointByTerm(term)
  local allCfg = ConfigData.activity_general_quest_bp[self:GetActFrameId()]
  if allCfg == nil then
    error("cant get activity_general_quest_bp config!!")
    return false
  end
  local cfg = allCfg[term]
  if cfg == nil then
    error("cant get activity_general_quest_bp config!!")
    return false
  end
  local canGetReward = false
  for index, data in ipairs(cfg) do
    if bpTable.rewardGotPoint < data.point and bpTable.point >= data.point then
      canGetReward = true
      break
    end
  end
  return canGetReward
end

function ActivityAnniversary23Data:IsAnniversary23ShopLooked(shopId)
  local userDataCache = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  return userDataCache:GetAnniversary23ShopLooked(self:GetActId(), shopId)
end

function ActivityAnniversary23Data:SetAnniversary23ShopLooked(shopId)
  local userDataCache = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  userDataCache:SetAnniversary23ShopLooked(self:GetActId(), shopId)
  self:RefreshRedAnniversary23Shop()
end

function ActivityAnniversary23Data:GetAnniversary23DailyTaskData()
  return self._dailyTaskData
end

function ActivityAnniversary23Data:GetAnniversary23TermTaskData()
  return self._termTaskData
end

function ActivityAnniversary23Data:GetAnniversary23TechTree()
  return self._actTechTree
end

function ActivityAnniversary23Data:GetAnniversary23Cfg()
  return self._mainCfg
end

function ActivityAnniversary23Data:GetAnniversary23MainSector()
  local actFrameId = self:GetActFrameId()
  local mainSector = ConfigData.act_general_ep_main[actFrameId].main_stage
  return mainSector
end

function ActivityAnniversary23Data:IsAnniversary23BrotatoSectorId(sectorId)
  return self._mainCfg.brotato_sector_id == sectorId
end

function ActivityAnniversary23Data:GetBrotatoId()
  return self._mainCfg.brotato_id or 0
end

function ActivityAnniversary23Data:IsAnniversary23GuardSectorId(sectorId)
  return self._mainCfg.guard_sector_id == sectorId
end

function ActivityAnniversary23Data:OnDataRemoved()
  self:__RemoveAnniversary23ChildActivityRedListen()
  local actFrameId = self:GetActFrameId()
  local generakEpCfg = ConfigData.act_general_ep_main[actFrameId]
  if generakEpCfg ~= nil and #generakEpCfg.initial_protocol_all > 0 then
    local sectorId = generakEpCfg.main_stage
    ExplorationManager:RemoveEpNewEpBuffSelect(sectorId, generakEpCfg.initial_protocol_all)
  end
end

function ActivityAnniversary23Data:UpdataBrotatoData(msg)
  local brotatoId = self._mainCfg.brotato_id
  if 0 < brotatoId then
    local activityBrotatoLobbyCtrl = ControllerManager:GetController(ControllerTypeId.ActivityBrotatoLobby, true)
    activityBrotatoLobbyCtrl:UpdataBrotatoData(msg, brotatoId, self:GetActFrameId())
  end
end

function ActivityAnniversary23Data:GetAnvsr23WarchessSeasonId()
  return self._mainCfg.warchess_season_id
end

function ActivityAnniversary23Data:GetAnvsr23SeasonAddtion()
  if self._seasonAddtionData == nil then
    self._seasonAddtionData = WarChessSeasonAddtionData.New()
  end
  return self._seasonAddtionData
end

function ActivityAnniversary23Data:RefreshActivityMonsterCardData(monsterCardDataMsg, isFromDiff)
  if self.actMonsterCardPlayData == nil then
    error("not has actMonsterCardPlayData")
    return
  end
  self.actMonsterCardPlayData:ActMCPD_RefreshCardDatas(monsterCardDataMsg, isFromDiff)
  self:RefreshtMonsterCardRedDot()
end

function ActivityAnniversary23Data:GetMonsterCardData()
  return self.actMonsterCardPlayData
end

function ActivityAnniversary23Data:RefreshtMonsterCardRedDot()
  local isHaveBlueDot = self.actMonsterCardPlayData:ActMCPD_IsHaveBlue()
  local redCount = 0
  if isHaveBlueDot then
    redCount = 1
  end
  local reddot = self:GetActivityReddot()
  local childReddot = reddot:AddChild(ActivityAnniversary23Enum.reddotType.MonsterCard)
  if childReddot:GetRedDotCount() ~= redCount then
    childReddot:SetRedDotCount(redCount)
  end
end

function ActivityAnniversary23Data:RefreshCommonHardLevelPlayData(msg)
  if self.actHardLevelData == nil then
    error("not has actHardLevelData")
    return
  end
  self.actHardLevelData:AHLPD_RefreshByServerData(msg)
  self:RefreshtHardLevelRedDot()
end

function ActivityAnniversary23Data:GetCommonHardLevelPlayData()
  return self.actHardLevelData
end

function ActivityAnniversary23Data:RefreshtHardLevelRedDot()
  local isHaveBlueDot = self:IsActivityRunning() and self.actHardLevelData:AHLPD_GetIsHaveNotSeen()
  local redCount = 0
  if isHaveBlueDot then
    redCount = 1
  end
  local reddot = self:GetActivityReddot()
  local childReddot = reddot:AddChild(ActivityAnniversary23Enum.reddotType.HardLevel)
  if childReddot:GetRedDotCount() ~= redCount then
    childReddot:SetRedDotCount(redCount)
  end
end

return ActivityAnniversary23Data
