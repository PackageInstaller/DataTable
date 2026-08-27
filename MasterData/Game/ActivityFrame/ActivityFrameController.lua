local ActivityFrameController = class("ActivityFrameController", ControllerBase)
local base = ControllerBase
local ActivityFrameData = require("Game.ActivityFrame.ActivityFrameData")
local ActivityFrameEnum = require("Game.ActivityFrame.ActivityFrameEnum")
local ActivityFrameOpenFunc = require("Game.ActivityFrame.ActivityFrameOpenFunc")
local ActivityFrameChangeFunc = require("Game.ActivityFrame.ActivityFrameChangeFunc")
local ActivityFrameRunningEndFunc = require("Game.ActivityFrame.ActivityFrameRunningEndFunc")
local ActivityFramePreviewFunc = require("Game.ActivityFrame.ActivityFramePreviewFunc")
local ActivityDailyFlushFunc = require("Game.ActivityFrame.ActivityDailyFlushFunc")
local HomeEnum = require("Game.Home.HomeEnum")
local CheckerTypeId, CheckerGlobalConfig = table.unpack(require("Game.Common.CheckCondition.CheckerGlobalConfig"))
local ConditionListener = require("Game.Common.CheckCondition.ConditonListener.ConditionListener")
local JumpManager = require("Game.Jump.JumpManager")
local SectorEnum = require("Game.Sector.SectorEnum")
local ActivityTinyGameData = require("Game.ActivityFrame.ActivityTinyGameData")
local ActDailyTaskData = require("Game.ActivityFrame.ActDailyTaskData")
local CheckerTimeTypeTable = {
  CheckerTypeId.TimeRange
}
local CheckerTimeEndTable = {-1}

function ActivityFrameController:ctor()
  self.AllActivityFrameDataDic = {}
  self.ActivityCatMapping = {}
  self._openEnteryDic = {}
  self._openCatDic = {}
  self._processDic = {}
  self._lockActDic = {}
  self._conditionListener = ConditionListener.New()
  self.__DealTimeListenAction = BindCallback(self, self.__DealTimeListen)
  for i = ActivityFrameEnum.eActivityState.WaitState, ActivityFrameEnum.eActivityState.DestroyState do
    self._processDic[i] = {}
  end
  self.__BC_Listern2PreConditona = BindCallback(self, self.__Listern2PreConditon)
  MsgCenter:AddListener(eMsgEventId.PreCondition, self.__BC_Listern2PreConditona)
  self.wechatActivityElems = {}
  self.ActivityStateDelaFunc = {
    [ActivityFrameEnum.eActivityState.WaitState] = BindCallback(self, ActivityFrameController.__WaitActivitys),
    [ActivityFrameEnum.eActivityState.PreviewState] = BindCallback(self, ActivityFrameController.__PreviewActivitys),
    [ActivityFrameEnum.eActivityState.OpenState] = BindCallback(self, ActivityFrameController.__OpenActivitys),
    [ActivityFrameEnum.eActivityState.RewardState] = BindCallback(self, ActivityFrameController.__DealActivityRunningEnd),
    [ActivityFrameEnum.eActivityState.DestroyState] = BindCallback(self, ActivityFrameController.__FinishActivitys)
  }
  self._tinyGameDic = {}
  self._tinyGameHighScore = {}
end

function ActivityFrameController:UpdateActivity(activityElemDic)
  local wechatActivityIds = {}
  local activityStateCollect = {}
  for id, activityElem in pairs(activityElemDic) do
    local actInfo = self.AllActivityFrameDataDic[id]
    if actInfo ~= nil then
      actInfo:UpdateActivityFrameData(activityElem)
    else
      actInfo = ActivityFrameData.CreateActivityFrameData(activityElem)
      local actState, isUnlock = self:__CalculateActivityState(actInfo)
      if actState ~= ActivityFrameEnum.eActivityState.DestroyState and actState ~= ActivityFrameEnum.eActivityState.None or not (actInfo:GetDurationTmForFrameCtrl() <= 0) then
        self.AllActivityFrameDataDic[id] = actInfo
        local actCat = actInfo:GetActivityFrameCat()
        local actId = actInfo:GetActId()
        self.ActivityCatMapping[actCat] = self.ActivityCatMapping[actCat] or {}
        self.ActivityCatMapping[actCat][actId] = id
        local enterTypeRedNode = self:__GetEnterReddot(actInfo.enterType, actInfo.actCat)
        if enterTypeRedNode ~= nil then
          local node = enterTypeRedNode:AddChild(actInfo:GetActivityFrameId())
          actInfo:SetActivityReddotForFrameCtrl(node)
        end
        if actInfo.actCat == ActivityFrameEnum.eActivityType.Tickets then
          wechatActivityIds[actInfo.actId] = true
        end
        if actState ~= ActivityFrameEnum.eActivityState.WaitState and not isUnlock then
          self._lockActDic[id] = true
        elseif not (actInfo:GetDurationTmForFrameCtrl() > 0) then
          if actState == ActivityFrameEnum.eActivityState.DestroyState or actState == ActivityFrameEnum.eActivityState.None then
            actInfo:SetActivityStateForFrameCtrl(actState)
          else
            activityStateCollect[actState] = activityStateCollect[actState] or {}
            table.insert(activityStateCollect[actState], id)
          end
        end
      end
    end
  end
  self:__DealStateCollect(activityStateCollect, false)
  if table.count(wechatActivityIds) then
    local actFrameCtr = NetworkManager:GetNetwork(NetworkTypeID.ActivityFrame)
    actFrameCtr:CS_ACTIVITY_Wechat_Detail(wechatActivityIds)
  end
  if FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_SignIn) then
    self:AddFakeSigninActivityData()
  end
  self:__DeleteExpireActUserData()
end

function ActivityFrameController:UpdateActivityTaskCompleted(taskRecord)
  if self.CompleteActivityTaskTable == nil then
    self.CompleteActivityTaskTable = {}
  end
  for taskId, table in pairs(taskRecord) do
    self.CompleteActivityTaskTable[taskId] = table ~= nil
  end
end

function ActivityFrameController:GetActIsLockByActFrameId(actFrameId)
  local isLock = self._lockActDic[actFrameId]
  return isLock
end

function ActivityFrameController:GetIdByActTypeAndActId(actType, actId)
  local catMapping = self.ActivityCatMapping[actType]
  return catMapping ~= nil and catMapping[actId] or nil
end

function ActivityFrameController:GetActivityFrameDataDic()
  return self.AllActivityFrameDataDic
end

function ActivityFrameController:GetActivityFrameData(actFrmaId)
  if actFrmaId == nil then
    return nil
  end
  return self.AllActivityFrameDataDic[actFrmaId]
end

function ActivityFrameController:GetActivityFrameDataByTypeAndId(actType, actId)
  local id = self:GetIdByActTypeAndActId(actType, actId)
  if id ~= nil then
    return self:GetActivityFrameData(id)
  end
  return nil
end

function ActivityFrameController:HideActivityByExtraLogic(actType, actId)
  local id = self:GetIdByActTypeAndActId(actType, actId)
  if id ~= nil then
    self:__FinishActivitys({id})
  end
end

function ActivityFrameController:IsHaveShowByEnterType(enterType)
  return self._openEnteryDic[enterType] ~= nil
end

function ActivityFrameController:GetShowByEnterType(enterType)
  local openActIdDic = self._openEnteryDic[enterType]
  if openActIdDic == nil then
    return nil
  end
  local dic = {}
  for actId, _ in pairs(openActIdDic) do
    dic[actId] = self.AllActivityFrameDataDic[actId]
  end
  return dic
end

function ActivityFrameController:GetIsHaveUnlockedActivity()
  for index, enterType in ipairs(ActivityFrameEnum.eActivityEnterTypePriority) do
    if self:IsHaveShowByEnterType(enterType) then
      return enterType
    end
  end
  return nil
end

function ActivityFrameController:GetAutoJumpTargetActivity()
  local needEnterType
  for index, enterType in ipairs(ActivityFrameEnum.eActivityEnterTypePriority) do
    if self:IsHaveShowByEnterType(enterType) then
      local enterTypeRedNode = self:__GetEnterReddot(enterType)
      if enterTypeRedNode ~= nil and enterTypeRedNode:GetRedDotCount() > 0 then
        return enterType
      end
      needEnterType = needEnterType == nil and enterType or needEnterType
    end
  end
  return needEnterType
end

function ActivityFrameController:IsExistOpenActByActType(actType)
  return self._openCatDic[actType] ~= nil
end

function ActivityFrameController:GetShowByActType(actType)
  return self._openCatDic[actType]
end

function ActivityFrameController:__GetEnterReddot(enterType, actCat)
  local enterTypeRedNode
  if enterType == ActivityFrameEnum.eActivityEnterType.Novice then
    _, enterTypeRedNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.ActivityInHome, RedDotStaticTypeId.ActivityFrameNovice)
  elseif enterType == ActivityFrameEnum.eActivityEnterType.LimitTime then
    _, enterTypeRedNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.ActivityInHome, RedDotStaticTypeId.ActivityFrameLimitTime)
  elseif enterType == ActivityFrameEnum.eActivityEnterType.Comeback then
    _, enterTypeRedNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.ActivityInHome, RedDotStaticTypeId.ActivityComeback)
  elseif enterType == ActivityFrameEnum.eActivityEnterType.KeyExertion then
    _, enterTypeRedNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.ActivityInHome, RedDotStaticTypeId.ActivityKeyExertion)
  elseif actCat == ActivityFrameEnum.eActivityType.SectorI then
    _, enterTypeRedNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.ActivityFrameSectorI)
  else
    _, enterTypeRedNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.ActivitySingle)
  end
  return enterTypeRedNode
end

function ActivityFrameController:InitEntranceRedDot()
  local sectorCtrl = ControllerManager:GetController(ControllerTypeId.SectorController)
  if not sectorCtrl then
    return
  end
  local lastSelectedIndex = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData):GetSectorLastSelectedPage() or SectorEnum.ePageIndex.main
  local curMapId = sectorCtrl:GetSctCurMapId()
  local nextMapId = curMapId + 1
  local nextMapUnlock, nextMapFirstSectorId = PlayerDataCenter.sectorStage:IsSectorMapUnlock(nextMapId)
  local isRead = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData):IsNewSectorMapRead(nextMapId)
  local isOpen = nextMapUnlock and not isRead
  local _, sctMainNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.SectorEntrance, RedDotStaticTypeId.SectorEntranceMain)
  local sctMainChapterNode = sctMainNode:AddChild(RedDotStaticTypeId.SectorEntranceMainChapter)
  if isOpen then
    sctMainChapterNode:SetRedDotCount(1)
  else
    sctMainChapterNode:SetRedDotCount(0)
  end
  local sctMainStrategyNode = sctMainNode:AddChild(RedDotStaticTypeId.SectorEntranceMainStrategy)
  local addCtrl = sectorCtrl.addCtrl
  local tempIsBlue, tempNum = addCtrl:GetSectorSOReddotNum()
  if 0 < tempNum then
    sctMainStrategyNode:SetRedDotCount(1)
  else
    sctMainStrategyNode:SetRedDotCount(0)
  end
  local dungeonCtrl = sectorCtrl.dungeonCtrl
  local weeklyCtrl = sectorCtrl.weeklyCtrl
  local dailyCtrl = sectorCtrl.dailyCtrl
  for _, id in ipairs(ConfigData.sector_entrance_dungeon.id_sort_list) do
    local dunCfg = ConfigData.sector_entrance_dungeon[id]
    local playModeCtrl
    local entranceType = dunCfg.system_id
    if dungeonCtrl.IsEntrancetypeDungeon(entranceType) then
      playModeCtrl = dungeonCtrl
    elseif dailyCtrl.IsEntrancetypeDaily(entranceType) then
      playModeCtrl = dailyCtrl
    elseif weeklyCtrl.IsEntrancetypeWeekly(entranceType) then
      playModeCtrl = weeklyCtrl
    end
    if playModeCtrl ~= nil and playModeCtrl:IsSectorPlayModeExist() and playModeCtrl:IsSectorPlayModeUnlock(entranceType) then
      local isBlue, num = playModeCtrl:GetPlayModeReddotTypeAndNum()
      local _, sctSrcNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.SectorEntrance, RedDotStaticTypeId.SectorEntranceSrcDun)
      local sctResNode = sctSrcNode:AddChild(entranceType)
      sctResNode:SetRedDotCount(0 < num and 1 or 0)
    end
  end
  local blackHoleCtrl = sectorCtrl.blackHoleCtrl
  local sixHeroTowerCtrl = sectorCtrl.sixHeroTowerCtrl
  for _, id in ipairs(ConfigData.sector_entrance_challenge.id_sort_list) do
    local dunCfg = ConfigData.sector_entrance_challenge[id]
    local playModeCtrl
    local entranceType = dunCfg.system_id
    if blackHoleCtrl.IsEntrancetypeBlackHole(entranceType) then
      playModeCtrl = blackHoleCtrl
    end
    if sixHeroTowerCtrl.IsEntrancetypeSixHeroTower(entranceType) then
      playModeCtrl = sixHeroTowerCtrl
    end
    if playModeCtrl ~= nil and playModeCtrl:IsSectorPlayModeExist() then
      local isBlue, num = playModeCtrl:GetPlayModeReddotTypeAndNum()
      local _, sctChallengeNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.SectorEntrance, RedDotStaticTypeId.SectorEntranceChallenge)
      local sctNode = sctChallengeNode:AddChild(entranceType)
      sctNode:SetRedDotCount(0 < num and 1 or 0)
    end
  end
end

function ActivityFrameController:GetSectorPageReddot(pageIndex)
  local isHave, isBlue
  if pageIndex == SectorEnum.ePageIndex.act then
    for id, entranceCfg in pairs(ConfigData.activity_entrance) do
      if entranceCfg.jump_id == JumpManager.eJumpTarget.DynActivity then
        local activityFrameId = entranceCfg.jump_arg[1]
        local activityFrameInfo = self:GetActivityFrameData(activityFrameId)
        if activityFrameInfo ~= nil and not activityFrameInfo:GetIsActivityFinished() then
          local actData = activityFrameInfo:GetActivityData()
          if actData ~= nil then
            local _isBlue, num = actData:GetActivityReddotNum()
            if 0 < num then
              isHave = true
              if _isBlue then
                isBlue = true
              else
                isBlue = false
                break
              end
            end
          end
        end
      end
    end
  elseif pageIndex == SectorEnum.ePageIndex.res then
    local _, sctSrcNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.SectorEntrance, RedDotStaticTypeId.SectorEntranceSrcDun)
    if 0 < sctSrcNode:GetRedDotCount() then
      isHave = true
      isBlue = true
    end
  elseif pageIndex == SectorEnum.ePageIndex.challenge then
    local _, sctChallengeNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.SectorEntrance, RedDotStaticTypeId.SectorEntranceChallenge)
    if 0 < sctChallengeNode:GetRedDotCount() then
      isHave = true
      isBlue = true
    end
    local sectorCtrl = ControllerManager:GetController(ControllerTypeId.SectorController)
    if sectorCtrl then
      local blackHoleCtrl = sectorCtrl.blackHoleCtrl
      local tempIsBlue, num = blackHoleCtrl:GetPlayModeReddotTypeAndNum()
      if 0 < num then
        isBlue = tempIsBlue
      end
    end
  elseif pageIndex == SectorEnum.ePageIndex.main then
    local _, sctMainNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.SectorEntrance, RedDotStaticTypeId.SectorEntranceMain)
    if 0 < sctMainNode:GetRedDotCount() then
      isHave = true
      isBlue = true
    end
    local sectorCtrl = ControllerManager:GetController(ControllerTypeId.SectorController)
    if sectorCtrl then
      local addCtrl = sectorCtrl.addCtrl
      local tempIsBlue, tempNum = addCtrl:GetSectorSOReddotNum()
      if 0 < tempNum then
        isBlue = tempIsBlue
      else
        isBlue = true
      end
    end
  end
  return isHave, isBlue
end

function ActivityFrameController:__CalculateActivityState(activityData)
  local activityState = ActivityFrameEnum.eActivityState.None
  if PlayerDataCenter.timestamp >= activityData:GetActivityDestroyTime() and activityData:GetActivityDestroyTime() ~= -1 then
    activityState = ActivityFrameEnum.eActivityState.DestroyState
  elseif PlayerDataCenter.timestamp >= activityData:GetActivityEndTime() and activityData:GetActivityEndTime() ~= -1 then
    activityState = ActivityFrameEnum.eActivityState.RewardState
  elseif PlayerDataCenter.timestamp >= activityData:GetActivityBornTime() then
    activityState = ActivityFrameEnum.eActivityState.OpenState
  elseif activityData:IsPreviewType() and PlayerDataCenter.timestamp >= activityData:GetActivityPreviewTime() then
    activityState = ActivityFrameEnum.eActivityState.PreviewState
  else
    activityState = ActivityFrameEnum.eActivityState.WaitState
  end
  return activityState, activityData:GetIsActivityUnlockForFrameCtrl()
end

function ActivityFrameController:__WaitActivitys(ids)
  if ids == nil or #ids <= 0 then
    return
  end
  for _, id in ipairs(ids) do
    local actInfo = self.AllActivityFrameDataDic[id]
    actInfo:SetActivityStateForFrameCtrl(ActivityFrameEnum.eActivityState.WaitState)
    if actInfo:IsPreviewType() then
      self:__AddTimeListen(id, actInfo:GetActivityPreviewTime(), ActivityFrameEnum.eActivityState.PreviewState)
    else
      self:__AddTimeListen(id, actInfo:GetActivityBornTime(), ActivityFrameEnum.eActivityState.OpenState)
    end
  end
end

function ActivityFrameController:__PreviewActivitys(ids, needCallFunc)
  if ids == nil or #ids <= 0 then
    return
  end
  for _, id in ipairs(ids) do
    local actInfo = self.AllActivityFrameDataDic[id]
    if not actInfo:GetIsActivityUnlockForFrameCtrl() then
      self._lockActDic[id] = true
    else
      actInfo:SetIsActivityUnlockForFrameCtrl()
      actInfo:SetActivityStateForFrameCtrl(ActivityFrameEnum.eActivityState.PreviewState)
      self:__DealCouldShowInfo(actInfo)
      self:__AddTimeListen(id, actInfo:GetActivityBornTime(), ActivityFrameEnum.eActivityState.OpenState)
      if needCallFunc and ActivityFramePreviewFunc[actInfo.actCat] ~= nil then
        ActivityFramePreviewFunc[actInfo.actCat](actInfo)
      end
    end
  end
  MsgCenter:Broadcast(eMsgEventId.ActivityPreview, ids)
end

function ActivityFrameController:__OpenActivitys(ids, needCallFunc)
  if ids == nil or #ids <= 0 then
    return
  end
  for _, id in ipairs(ids) do
    local actInfo = self.AllActivityFrameDataDic[id]
    if not actInfo:GetIsActivityUnlockForFrameCtrl() then
      self._lockActDic[id] = true
    elseif not (0 < actInfo:GetActivityDestroyTime()) or not (actInfo:GetActivityDestroyTime() < PlayerDataCenter.timestamp) then
      actInfo:SetIsActivityUnlockForFrameCtrl()
      local isCouldShow = actInfo:GetCouldShowActivity()
      actInfo:SetActivityStateForFrameCtrl(ActivityFrameEnum.eActivityState.OpenState)
      if not isCouldShow then
        self:__DealCouldShowInfo(actInfo)
      end
      if needCallFunc and ActivityFrameOpenFunc[actInfo.actCat] ~= nil then
        ActivityFrameOpenFunc[actInfo.actCat](actInfo)
      end
      if ActivityFrameChangeFunc[actInfo.actCat] ~= nil then
        ActivityFrameChangeFunc[actInfo.actCat](actInfo)
      end
      if actInfo:GetActivityEndTime() ~= -1 then
        self:__AddTimeListen(id, actInfo:GetActivityEndTime(), ActivityFrameEnum.eActivityState.RewardState)
      end
    end
  end
  MsgCenter:Broadcast(eMsgEventId.ActivityShowChange, ids, true)
end

function ActivityFrameController:__DealActivityRunningEnd(ids, needCallFunc)
  if ids == nil or #ids <= 0 then
    return
  end
  local finishIds
  for _, id in ipairs(ids) do
    local actInfo = self.AllActivityFrameDataDic[id]
    if actInfo ~= nil then
      actInfo:SetActivityStateForFrameCtrl(ActivityFrameEnum.eActivityState.RewardState)
      if needCallFunc and ActivityFrameRunningEndFunc[actInfo.actCat] ~= nil then
        ActivityFrameRunningEndFunc[actInfo.actCat](actInfo)
      end
      if actInfo:GetActivityDestroyTime() ~= -1 then
        if actInfo:GetActivityDestroyTime() <= actInfo:GetActivityEndTime() then
          finishIds = finishIds or {}
          table.insert(finishIds, id)
        else
          self:__AddTimeListen(id, actInfo:GetActivityDestroyTime(), ActivityFrameEnum.eActivityState.DestroyState)
        end
      end
    end
  end
  if finishIds ~= nil then
    self:__FinishActivitys(finishIds, true)
  end
end

function ActivityFrameController:__FinishActivitys(ids, needCallFunc)
  if ids == nil or #ids <= 0 then
    return
  end
  for _, id in ipairs(ids) do
    local actInfo = self.AllActivityFrameDataDic[id]
    if actInfo ~= nil then
      self.AllActivityFrameDataDic[id] = nil
      self.ActivityCatMapping[actInfo:GetActivityFrameCat()][actInfo:GetActId()] = nil
      actInfo:SetActivityStateForFrameCtrl(ActivityFrameEnum.eActivityState.DestroyState)
      self:__DealCouldHideInfo(actInfo)
      if ActivityFrameChangeFunc[actInfo.actCat] ~= nil then
        ActivityFrameChangeFunc[actInfo.actCat](actInfo)
      end
    end
  end
  MsgCenter:Broadcast(eMsgEventId.ActivityShowChange, ids, false)
end

function ActivityFrameController:__AddTimeListen(id, time, state)
  self._processDic[state][time] = self._processDic[state][time] or {}
  table.insert(self._processDic[state][time], id)
  if time < PlayerDataCenter.timestamp then
    self:__DealTimeListen(time)
    return
  end
  if not self._conditionListener:IsDuplicationKey(time) then
    self._conditionListener:AddConditionChangeListener(time, self.__DealTimeListenAction, CheckerTimeTypeTable, {time}, CheckerTimeEndTable)
  end
end

function ActivityFrameController:__DealTimeListen(listenId)
  for i = ActivityFrameEnum.eActivityState.WaitState, ActivityFrameEnum.eActivityState.DestroyState do
    for listenId, dealList in pairs(self._processDic[i]) do
      if listenId <= PlayerDataCenter.timestamp then
        self._processDic[i][listenId] = nil
        local func = self.ActivityStateDelaFunc[i]
        if func ~= nil then
          func(dealList, true)
        else
          error("actStateFunction is NIL state is " .. tostring(i))
        end
      end
    end
  end
end

function ActivityFrameController:__Listern2PreConditon(conditionId)
  local activityStateCollect
  for id, _ in pairs(self._lockActDic) do
    local actInfo = self.AllActivityFrameDataDic[id]
    if actInfo ~= nil and actInfo:IsHaveThisConditionForFrameCtrl(conditionId) then
      local actState, isUnlock = self:__CalculateActivityState(actInfo)
      if actState >= ActivityFrameEnum.eActivityState.DestroyState then
        self._lockActDic[id] = nil
      elseif isUnlock then
        self._lockActDic[id] = nil
        activityStateCollect = activityStateCollect or {}
        activityStateCollect[actState] = activityStateCollect[actState] or {}
        table.insert(activityStateCollect[actState], id)
      end
    end
  end
  if activityStateCollect ~= nil then
    self:__DealStateCollect(activityStateCollect, true)
  end
end

function ActivityFrameController:__DealStateCollect(activityStateCollect, needCallFunc)
  for actState, ids in pairs(activityStateCollect) do
    if actState == ActivityFrameEnum.eActivityState.RewardState then
      local preFunc = self.ActivityStateDelaFunc[ActivityFrameEnum.eActivityState.OpenState]
      if preFunc ~= nil then
        preFunc(ids, needCallFunc)
      else
        error("actStateFunction is NIL state is " .. tostring(actState))
      end
    end
    local func = self.ActivityStateDelaFunc[actState]
    if func ~= nil then
      func(ids, needCallFunc)
    else
      error("actStateFunction is NIL state is " .. tostring(actState))
    end
  end
end

function ActivityFrameController:__DealCouldShowInfo(actInfo, isAdd)
  local isCouldShow = actInfo:GetCouldShowActivity()
  if not isCouldShow then
    return
  end
  if actInfo:GetActivityReddotNode() == nil then
    local enterTypeRedNode = self:__GetEnterReddot(actInfo.enterType, actInfo.actCat)
    if enterTypeRedNode ~= nil then
      local node = enterTypeRedNode:AddChild(actInfo:GetActivityFrameId())
      actInfo:SetActivityReddotForFrameCtrl(node)
    end
  end
  local frameId = actInfo:GetActivityFrameId()
  local entryType = actInfo:GetEnterType()
  self._openEnteryDic[entryType] = self._openEnteryDic[entryType] or {}
  self._openEnteryDic[entryType][frameId] = true
  local actCat = actInfo:GetActivityFrameCat()
  self._openCatDic[actCat] = self._openCatDic[actCat] or {}
  self._openCatDic[actCat][frameId] = true
end

function ActivityFrameController:__DealCouldHideInfo(actInfo)
  local isCouldShow = actInfo:GetCouldShowActivity()
  if isCouldShow then
    return
  end
  local curNode = actInfo:GetActivityReddotNode()
  if curNode ~= nil then
    curNode:RemoveFromParent()
    actInfo:SetActivityReddotForFrameCtrl(nil)
  end
  local frameId = actInfo:GetActivityFrameId()
  local entryType = actInfo:GetEnterType()
  if self._openEnteryDic[entryType] ~= nil then
    self._openEnteryDic[entryType][frameId] = nil
    if table.count(self._openEnteryDic[entryType]) == 0 then
      self._openEnteryDic[entryType] = nil
    end
  end
  local actCat = actInfo:GetActivityFrameCat()
  if self._openCatDic[actCat] ~= nil then
    self._openCatDic[actCat][frameId] = nil
    if table.count(self._openCatDic[actCat]) == 0 then
      self._openCatDic[actCat] = nil
    end
  end
end

function ActivityFrameController:UpdateActivityDailyFlush()
  NetworkManager:GetNetwork(NetworkTypeID.ActivityFrame):CS_ActivityQuest_Detail(function()
    MsgCenter:Broadcast(eMsgEventId.ActivityTaskUpdate)
  end)
  for cat, idDic in pairs(self._openCatDic) do
    if ActivityDailyFlushFunc[cat] ~= nil then
      ActivityDailyFlushFunc[cat](idDic, self)
    end
  end
end

function ActivityFrameController:UpdateWechatActivityElems(datas, flag)
  self.wechatActivityElems = datas
  for actId, elem in pairs(self.wechatActivityElems) do
    if elem.redeemed or CS.ClientConsts.IsAudit then
      self:HideActivityByExtraLogic(ActivityFrameEnum.eActivityType.Tickets, actId)
    end
  end
end

function ActivityFrameController:UpdateWechatActivityFollowed(actId, flag)
  local elem = self.wechatActivityElems[actId]
  if elem ~= nil then
    elem.followed = flag
  end
end

function ActivityFrameController:UpdateWechatActivityRedeemed(actId)
  local elem = self.wechatActivityElems[actId]
  if elem ~= nil then
    elem.redeemed = true
    self:HideActivityByExtraLogic(ActivityFrameEnum.eActivityType.Tickets, actId)
  end
end

function ActivityFrameController:AddFakeSigninActivityData()
  local fackId = ActivityFrameEnum.eActiveityFakeId.dailySignIn
  if self.AllActivityFrameDataDic[fackId] == nil then
    local actData = ActivityFrameData.CreateActivityFrameDataFromFakeData({
      id = fackId,
      actCat = ActivityFrameEnum.eActivityType.dailySignIn,
      actId = fackId,
      enterType = ActivityFrameEnum.eActivityEnterType.LimitTime,
      order = 999
    })
    self.AllActivityFrameDataDic[fackId] = actData
    local actCat = actData:GetActivityFrameCat()
    local actId = actData:GetActId()
    self.ActivityCatMapping[actCat] = self.ActivityCatMapping[actCat] or {}
    self.ActivityCatMapping[actCat][actId] = fackId
    self:__OpenActivitys({fackId})
  end
end

function ActivityFrameController:GetExtraSectorStageFirstReward(sectorStageId)
  local actId = ConfigData.activity_reward.stageToActivityIdDic[sectorStageId]
  if actId == nil then
    return nil, nil
  end
  local actInfo = self:GetActivityFrameData(actId)
  if actInfo == nil or actInfo:IsActivityRunningTimeout() then
    return nil, nil
  end
  local stageToActivityIdCfg = ConfigData.activity_reward[actId][sectorStageId]
  if stageToActivityIdCfg == nil then
    error(" activity_reward is Error  sectorId and activityId is" .. tostring(sectorStageId) .. "," .. tostring(actId))
    return nil, nil
  end
  return stageToActivityIdCfg.stage_first_reward_ids, stageToActivityIdCfg.stage_first_reward_nums
end

function ActivityFrameController:TryResetActivityFinishTimeByType(actType, actId, startTm)
  local activityFrameId = self:GetIdByActTypeAndActId(actType, actId)
  if activityFrameId == nil then
    return
  end
  self:TryResetActivityFinishTimeByFrameId(activityFrameId, startTm)
end

function ActivityFrameController:TryResetActivityFinishTimeByFrameId(actFrameId, startTm)
  local activityData = self:GetActivityFrameData(actFrameId)
  if activityData == nil then
    return
  end
  local durationTm = activityData:GetDurationTmForFrameCtrl()
  if durationTm <= 0 then
    return
  end
  local finishTm = startTm + durationTm
  activityData:ResetFinishTmForFrameCtrl(startTm, finishTm)
  local oldActState = activityData:GetActivityFrameState()
  local process = self._processDic[oldActState]
  if process ~= nil then
    for time, list in pairs(process) do
      if table.contain(list, actFrameId) then
        table.removebyvalue(list, actFrameId)
        break
      end
    end
    self:__DealCouldHideInfo(activityData)
  end
  if activityData:IsActivityOpen() then
    return
  end
  activityData:SetForceOpenForFrameCtrl(true)
  self._lockActDic[actFrameId] = nil
  local actState, isUnlock = self:__CalculateActivityState(activityData)
  local activityStateCollect = {}
  activityStateCollect[actState] = {}
  table.insert(activityStateCollect[actState], actFrameId)
  self:__DealStateCollect(activityStateCollect, false)
end

function ActivityFrameController:UpdateAllTinyGame(msg)
  if msg.games ~= nil then
    for _, singleMsg in pairs(msg.games) do
      self:UpdateSingleTinyGame(singleMsg)
    end
  end
  if msg.cat2HighScore ~= nil then
    for gameType, score in pairs(msg.cat2HighScore) do
      gameType = gameType - 1
      self._tinyGameHighScore[gameType] = score
    end
  end
end

function ActivityFrameController:UpdateSingleTinyGame(singleMsg)
  local uid = singleMsg.uid
  local data = self._tinyGameDic[uid]
  if data == nil then
    data = ActivityTinyGameData.New()
    self._tinyGameDic[uid] = data
  end
  data:UpdateTinyGameData(singleMsg)
  MsgCenter:Broadcast(eMsgEventId.TinyGameDataChange, data)
end

function ActivityFrameController:GetTinyGameData(tinyGameUid)
  return self._tinyGameDic[tinyGameUid]
end

function ActivityFrameController:GetTinyGameHistoryHighScore(gameType)
  return self._tinyGameHighScore[gameType]
end

function ActivityFrameController:GetTinyGameDataListByActFrameId(actFrameId)
  local tinyGameDataList = {}
  for tinyGameUid, data in pairs(self._tinyGameDic) do
    if data:GetTinyGameActFrameId() == actFrameId then
      table.insert(tinyGameDataList, data)
    end
  end
  return tinyGameDataList
end

function ActivityFrameController:GetTinyGameDataUidByActFrameId(actFrameId, tinyGameType)
  local tinyGameDataList = {}
  for tinyGameUid, data in pairs(self._tinyGameDic) do
    if data:GetTinyGameActFrameId() == actFrameId and data:IsBrotatoGame() then
      return data:GetTinyGameUid()
    end
  end
  return 0
end

function ActivityFrameController:InitAllActDailyTaskData(msg)
  for k, v in pairs(msg.task) do
    self:AddActDailyTaskData(k, v)
  end
end

function ActivityFrameController:AddActDailyTaskData(actFrameId, msg)
  if self._actDailyTaskDataDic == nil then
    self._actDailyTaskDataDic = {}
  end
  if self._actDailyTaskDataDic[actFrameId] ~= nil then
    return
  end
  local data = ActDailyTaskData.New()
  data:InitActDailyTask(actFrameId)
  data:SetActDailyTaskIds(msg.receiveDailyTask)
  data:SetActDailyExpireTime(msg.nextRefreshTime)
  self._actDailyTaskDataDic[actFrameId] = data
end

function ActivityFrameController:GetActDailyTaskData(actFrameId)
  if self._actDailyTaskDataDic == nil then
    return nil
  end
  local taskData = self._actDailyTaskDataDic[actFrameId]
  return taskData
end

function ActivityFrameController:AddActivityTech(techTreeData)
  if self._actTreeDic == nil then
    self._actTreeDic = {}
  end
  self._actTreeDic[techTreeData:GetTreeId()] = techTreeData
end

function ActivityFrameController:GetActivityTech(techType)
  if self._actTreeDic == nil then
    return nil
  end
  return self._actTreeDic[techType]
end

function ActivityFrameController:__DeleteExpireActUserData()
  local userDataCache = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  local funcTable = {
    [ActivityFrameEnum.eActivityType.Carnival] = userDataCache.TryDeleteCarnival,
    [ActivityFrameEnum.eActivityType.DailyChallenge] = userDataCache.TryDeleteADCEnterTime,
    [ActivityFrameEnum.eActivityType.SectorIII] = userDataCache.TryDeleteSum22Activity,
    [ActivityFrameEnum.eActivityType.HeroGrow] = userDataCache.TryClearActivityHeroData,
    [ActivityFrameEnum.eActivityType.Hallowmas] = userDataCache.TryClearHallowmas,
    [ActivityFrameEnum.eActivityType.Comeback] = userDataCache.TryClearComebackPopLooked,
    [ActivityFrameEnum.eActivityType.Spring] = userDataCache.TryClearSpring,
    [ActivityFrameEnum.eActivityType.Winter23] = userDataCache.TryClearWinter23,
    [ActivityFrameEnum.eActivityType.Invitation] = userDataCache.TryClearInvitationLooked,
    [ActivityFrameEnum.eActivityType.EventWeeklyQA] = userDataCache.TryClearWeeklyQALooked,
    [ActivityFrameEnum.eActivityType.EventAngelaGift] = userDataCache.TryClearAngelaGiftLooked,
    [ActivityFrameEnum.eActivityType.SaveMoney] = userDataCache.TryClearSaveMoney,
    [ActivityFrameEnum.eActivityType.ActivityCarnival23] = userDataCache.TryClearCarnival23,
    [ActivityFrameEnum.eActivityType.LuckyRaffle] = userDataCache.TryClearLuckyRaffle,
    [ActivityFrameEnum.eActivityType.Divergent] = userDataCache.TryClearDivergent,
    [ActivityFrameEnum.eActivityType.CardSet] = userDataCache.TryClearCardSet,
    [ActivityFrameEnum.eActivityType.Anniversary23] = userDataCache.TryClearAnniversary,
    [ActivityFrameEnum.eActivityType.FlipCard] = userDataCache.TryClearFlipCard,
    [ActivityFrameEnum.eActivityType.SkinLimit] = userDataCache.TryClearSkinLimit,
    [ActivityFrameEnum.eActivityType.ActBlackHole] = userDataCache.TryClearBlackHole,
    [ActivityFrameEnum.eActivityType.LadderGift] = userDataCache.TryClearLadderGift,
    [ActivityFrameEnum.eActivityType.SteinsGate] = userDataCache.TryClearSteinsGate,
    [ActivityFrameEnum.eActivityType.HazeGift] = userDataCache.TryClearHazeGift,
    [ActivityFrameEnum.eActivityType.Spring24] = userDataCache.TryClearTreasureHunt,
    [ActivityFrameEnum.eActivityType.HeroGrowV3] = userDataCache.TryClearActivityHeroV3Data,
    [ActivityFrameEnum.eActivityType.Carnival24] = userDataCache.TryClearCarnival24,
    [ActivityFrameEnum.eActivityType.SignInLiveStream] = userDataCache.TryClearSignInLive,
    [ActivityFrameEnum.eActivityType.Bond] = userDataCache.TryClearBondAct,
    [ActivityFrameEnum.eActivityType.DeliverySimulator] = userDataCache.TryClearDSAct,
    [ActivityFrameEnum.eActivityType.ActAnniversary24] = userDataCache.TryClearAnni24
  }
  for type, func in pairs(funcTable) do
    if self.ActivityCatMapping[type] ~= nil then
      funcTable[type](userDataCache, self.ActivityCatMapping[type])
    end
  end
  userDataCache:TryClearCommonActUserData(self.ActivityCatMapping)
end

function ActivityFrameController:AddActivityDataUpdateTimeListen(activityFrameId, time, callback)
  if activityFrameId == nil or callback == nil then
    error(" activityFrameId or  callback is error")
    return
  end
  if time <= PlayerDataCenter.timestamp then
    error(" time is error , frameId is:" .. tostring(activityFrameId))
    return
  end
  if self._activityDataUpdateTimeListenDic == nil then
    self._activityDataUpdateTimeListenDic = {}
  end
  local timeFuncs = self._activityDataUpdateTimeListenDic[time]
  local activityDataUpdateTimeListenInfo = {activityFrameId = activityFrameId, callback = callback}
  if timeFuncs ~= nil then
    table.insert(timeFuncs, activityDataUpdateTimeListenInfo)
    return
  end
  timeFuncs = {}
  self._activityDataUpdateTimeListenDic[time] = timeFuncs
  table.insert(timeFuncs, activityDataUpdateTimeListenInfo)
  if timeFuncs[100] ~= nil and isGameDev then
    error(" activity time func too many ")
  end
  self._conditionListener:AddConditionChangeListener(-time, function()
    self:__ApplyActivityDataUpdateTimeListen(time)
  end, CheckerTimeTypeTable, {time}, CheckerTimeEndTable)
end

function ActivityFrameController:__ApplyActivityDataUpdateTimeListen(time)
  self._conditionListener:RemoveConditionChangeListener(-time)
  local timeFuncs = self._activityDataUpdateTimeListenDic[time]
  self._activityDataUpdateTimeListenDic[time] = nil
  for i, v in ipairs(timeFuncs) do
    local callback = v.callback
    local activityFrameId = v.activityFrameId
    local activityFrameData = self.AllActivityFrameDataDic[activityFrameId]
    if activityFrameData == nil or activityFrameData:IsActivityRunningTimeout() then
      return
    end
    local endTime = activityFrameData:GetActivityEndTime()
    if -1 < endTime and endTime <= PlayerDataCenter.timestamp then
      return
    end
    callback(activityFrameId)
  end
end

function ActivityFrameController:IsNeedShowActEntrance()
  for id, entranceCfg in pairs(ConfigData.activity_entrance) do
    if entranceCfg.jump_id == JumpManager.eJumpTarget.DynActivity then
      local activityFrameId = entranceCfg.jump_arg[1]
      local activityFrameInfo = self:GetActivityFrameData(activityFrameId)
      if activityFrameInfo ~= nil and not activityFrameInfo:GetIsActivityFinished() and (activityFrameInfo:GetIsActivityLocked() or activityFrameInfo:GetCouldShowActivity()) then
        return true
      end
    end
  end
  return false
end

function ActivityFrameController:isCompleteActivityTask(taskId)
  if self.CompleteActivityTaskTable == nil then
    return false
  end
  if self.CompleteActivityTaskTable[taskId] == nil then
    return false
  end
  return self.CompleteActivityTaskTable[taskId]
end

function ActivityFrameController:OnDelete()
  MsgCenter:RemoveListener(eMsgEventId.PreCondition, self.__BC_Listern2PreConditona)
  self._conditionListener:Delete()
  self.AllActivityFrameDataDic = nil
  base.OnDelete(self)
end

return ActivityFrameController
