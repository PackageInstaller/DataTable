local ActivityBase = require("Game.ActivityFrame.ActivityBase")
local ActivitySectorIIIData = class("ActivitySectorIIIData", ActivityBase)
local SectorIIISectorLevelData = require("Game.ActivitySectorIII.SectorIIISectorLevelData")
local ActivitySectorIIIDungeonData = require("Game.ActivitySectorIII.ActivitySectorIIIDungeonData")
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")
local CheckerTypeId, CheckerGlobalConfig = table.unpack(require("Game.Common.CheckCondition.CheckerGlobalConfig"))
local ActivitySectorIIIEnum = require("Game.ActivitySectorIII.ActivitySectorIIIEnum")
local GameSnakeData = require("Game.TinyGames.Snake.GameSnakeData")
local ActTechData = require("Game.ActivitySectorII.Tech.Data.ActTechData")
local CommonLogicUtil = require("Game.Common.CommonLogicUtil.CommonLogicUtil")
local ActivityFrameEnum = require("Game.ActivityFrame.ActivityFrameEnum")
local CurActType = ActivityFrameEnum.eActivityType.SectorIII
local TinyGameEnum = require("Game.TinyGames.TinyGameEnum")

function ActivitySectorIIIData:InitSectorIIIData(msg)
  self:SetActFrameDataByType(CurActType, msg.actId)
  self:UpdateActFrameDataSingleMsg(msg)
  self._mainCfg = ConfigData.activity_summer_main[msg.actId]
  self._refreshTimes = 0
  self._expireTime = 0
  self._techRefTimes = 0
  self._techDataDic = {}
  self._taskIdList = {}
  self._farmDouble = false
  self._hardDungeonScore = {}
  self._dunTicketId = self._mainCfg.ticket_item
  self._actPointId = self._mainCfg.tech_item
  self._gameSnake = GameSnakeData.New(msg.gameUid, self._mainCfg.game_snake, TinyGameEnum.eType.snake)
  self._mapDataList = SectorIIISectorLevelData.GenSectorIIIMapDatas(self._mainCfg.main_sector)
  self:__GenDungeonData()
  self:InitSect3TechData()
  self:UpdateSectorIIIData(msg)
end

function ActivitySectorIIIData:UpdateSectorIIIData(msg)
  table.removeall(self._taskIdList)
  table.insertto(self._taskIdList, msg.quest.ids)
  self._expireTime = msg.quest.expiredTm
  self._refreshTimes = msg.quest.refreshCnt
  self._farmDouble = msg.farmDouble
  self._hardDungeonScore = msg.hardDungeonScore
  self:_UpdateTech(msg.tech)
  self:_SetSum22TechNextRefreshTime(msg.tech.nextRefreshTime)
  self:RefreshSectorIIITaskReddot()
  self:RefreshSectorIIIMapReddot()
end

function ActivitySectorIIIData:__GenDungeonData()
  self._dungeonDataDic = {}
  self._dungeonIdList = ConfigData.activity_summer_level_detail.level_list
  local id = 1
  for index, dunStageId in pairs(self._dungeonIdList) do
    local extraCfg = ConfigData.activity_summer_level_detail[dunStageId]
    if extraCfg and extraCfg.main_id == self:GetActId() then
      local dungeonData = ActivitySectorIIIDungeonData.New(dunStageId, self.actInfo, id)
      dungeonData:SetSectorIIDungeonExtraData(nil, extraCfg)
      self._dungeonDataDic[dunStageId] = dungeonData
      id = id + 1
    end
  end
end

function ActivitySectorIIIData:ReqCommitSectorIIITask(taskData, callback)
  local actNetwork = NetworkManager:GetNetwork(NetworkTypeID.ActivityFrame)
  actNetwork:CS_Activity_Quest_Commit(self:GetActFrameId(), taskData.id, callback)
end

function ActivitySectorIIIData:ReqChangeSectorIIITask(taskId, callback)
  local sectorIIINetwork = NetworkManager:GetNetwork(NetworkTypeID.ActivitySectorIII)
  sectorIIINetwork:CS_ACTIVITY_Summer2022_RefreshQuest(self:GetActId(), taskId, callback)
end

function ActivitySectorIIIData:RefreshSectorIIITaskReddot()
  local actRedDotNode = self:GetActivityReddot()
  if actRedDotNode == nil then
    return
  end
  local taskRed = actRedDotNode:AddChild(ActivitySectorIIIEnum.eActRedDotTypeId.task)
  if self:IsActivityRunning() then
    for _, taskId in ipairs(self._taskIdList) do
      local taskData = PlayerDataCenter.allTaskData:GetTaskDataById(taskId)
      if taskData ~= nil and taskData:CheckComplete() then
        taskRed:SetRedDotCount(1)
        return
      end
    end
  end
  taskRed:SetRedDotCount(0)
end

function ActivitySectorIIIData:RefreshSectorIIIMapReddot()
  local actRedDotNode = self:GetActivityReddot()
  if actRedDotNode == nil then
    return
  end
  local mapRed = actRedDotNode:AddChild(ActivitySectorIIIEnum.eActRedDotTypeId.map)
  if self:IsActivityRunning() then
    local avgPlayCtrl = ControllerManager:GetController(ControllerTypeId.AvgPlay)
    for i, data in ipairs(self._mapDataList) do
      if not data:GetIsBattle() and avgPlayCtrl:IsAvgUnlock(data.avgId) and not avgPlayCtrl:IsAvgPlayed(data.avgId) then
        mapRed:SetRedDotCount(1)
        return
      end
    end
  end
  mapRed:SetRedDotCount(0)
end

function ActivityBase:GetActivityReddotNum()
  local actRedDotNode = self:GetActivityReddot()
  if actRedDotNode == nil then
    error("can't get activity reddot node")
    return true, 0
  end
  for reddotType, _ in pairs(ActivitySectorIIIEnum.eActRedDotIsRedType) do
    local childNode = actRedDotNode:GetChild(reddotType)
    if childNode ~= nil and 0 < childNode:GetRedDotCount() then
      return false, actRedDotNode:GetRedDotCount()
    end
  end
  return true, actRedDotNode:GetRedDotCount()
end

function ActivitySectorIIIData:GetSectorIIIMainCfg()
  return self._mainCfg
end

function ActivitySectorIIIData:GetActSectorIIIExpireTime()
  return self._expireTime
end

function ActivitySectorIIIData:GetActSectorIIIHardDungeonScore()
  return self._hardDungeonScore
end

function ActivitySectorIIIData:_SetSum22TechNextRefreshTime(ts)
  self._techNextRefreshTime = ts
  self:UpdActSum22TechRedDot()
end

function ActivitySectorIIIData:GetSum22TechNextRefreshTime()
  return self._techNextRefreshTime
end

function ActivitySectorIIIData:SetActSum22TechSelectEntered()
  local userdata = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  local lastTs = userdata:SetSum22SelectTechLastEnterRefreshTs(self:GetActId(), self._techNextRefreshTime)
  self:UpdActSum22TechRedDot()
end

function ActivitySectorIIIData:UpdActSum22TechRedDot()
  local actReddot = self:GetActivityReddot()
  if actReddot == nil then
    return
  end
  local techSelectNode = actReddot:AddChild(ActivitySectorIIIEnum.eActRedDotTypeId.tech)
  if not self:IsActivityRunning() then
    techSelectNode:SetRedDotCount(0)
    return
  end
  local userdata = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  local lastTs = userdata:GetSum22SelectTechLastEnterRefreshTs(self:GetActId())
  local showRedDot = self._techNextRefreshTime ~= lastTs
  local showDotNum = self._mainCfg.point_tech_number
  showRedDot = showRedDot or showDotNum < PlayerDataCenter:GetItemCount(self._actPointId)
  if #self:GetActSum22TechSelectIdList() == 0 then
    showRedDot = false
  end
  techSelectNode:SetRedDotCount(showRedDot and 1 or 0)
end

function ActivitySectorIIIData:GetActSct3TechType()
  return self._mainCfg.tech_id
end

function ActivitySectorIIIData:GetSum22TechDesSrotList()
  return self._mainCfg.tech_des_sort
end

function ActivitySectorIIIData:InitSect3TechData()
  local techType = self:GetActSct3TechType()
  local techTypeCfg = ConfigData.activity_tech.actTechTypeList[techType]
  if techTypeCfg == nil then
    error("activity tech type is NIL,type is " .. tostring(techType))
  end
  
  local function genTechFunc(techId)
    self._techDataDic[techId] = self._techDataDic[techId] or ActTechData.CreatAWTechData(techId, CurActType, self:GetActId())
    return self._techDataDic[techId]
  end
  
  for _, techId in ipairs(techTypeCfg.techIds) do
    local techData = genTechFunc(techId)
    local previousTechId = techData:GetPreTechId()
    if previousTechId ~= nil then
      local previousTech = genTechFunc(previousTechId)
      techData:SetPreTechData(previousTech)
    end
  end
end

function ActivitySectorIIIData:_UpdateTech(techMsg)
  if techMsg == nil then
    return
  end
  for techId, singleMsg in pairs(techMsg.techData) do
    local techData = self._techDataDic[techId]
    if techData == nil then
      error("techData == nil, techId:" .. tostring(techId))
    else
      local oldLevel = techData:GetCurLevel()
      techData:UpdateWATechByMsg(singleMsg)
      local curLevel = techData:GetCurLevel()
      if oldLevel ~= curLevel then
        self:Sum22TechLevelUpInstallBonus(techData, oldLevel, curLevel)
      end
    end
  end
  self._refreshTechIdList = techMsg.refreshTechId
  self._refreshTechNum = techMsg.refreshNum
end

function ActivitySectorIIIData:Sum22TechLevelUpInstallBonus(techData, oldLevel, curLevel)
  local techId = techData:GetTechId()
  if 0 < oldLevel then
    local logicArray, para1Array, para2Array, para3Array = techData:GetTechLogic(oldLevel)
    for index, logic in ipairs(logicArray) do
      local para1 = para1Array[index]
      local para2 = para2Array[index]
      local para3 = para3Array[index]
      PlayerDataCenter.playerBonus:UninstallPlayerBonus(proto_csmsg_SystemFunctionID.SystemFunctionID_ActivityWinter, techId, logic, para1, para2, para3)
    end
  end
  local logicArray, para1Array, para2Array, para3Array = techData:GetTechLogic(curLevel)
  for index, logic in ipairs(logicArray) do
    local para1 = para1Array[index]
    local para2 = para2Array[index]
    local para3 = para3Array[index]
    PlayerDataCenter.playerBonus:InstallPlayerBonus(proto_csmsg_SystemFunctionID.SystemFunctionID_ActivityWinter, techId, logic, para1, para2, para3)
  end
end

function ActivitySectorIIIData:GetActSum22TechRefreshNum()
  return self._refreshTechNum or 0
end

function ActivitySectorIIIData:GetActSum22TechSelectIdList()
  return self._refreshTechIdList or table.emptytable
end

function ActivitySectorIIIData:GetSectorIIITechDic()
  return self._techDataDic
end

function ActivitySectorIIIData:GetSum22TechDataById(techId)
  return self._techDataDic[techId]
end

function ActivitySectorIIIData:GenSectorIIITechList()
  local list = {}
  for k, v in pairs(self._techDataDic) do
    table.insert(list, v)
  end
  return list
end

function ActivitySectorIIIData:GetSectorIIITaskIds()
  return self._taskIdList
end

function ActivitySectorIIIData:GetSectorIIITaskRefTimes()
  return self._refreshTimes, self._mainCfg.daily_task_refresh_max
end

function ActivitySectorIIIData:GetSectorIIIDungeonInfo()
  return self._dungeonDataDic, self._dungeonIdList
end

function ActivitySectorIIIData:GetSectorIIISectorMain()
  return self._mapDataList
end

function ActivitySectorIIIData:GetSectorIIIActivityIsRemaster()
  return self._mainCfg.return_id
end

function ActivitySectorIIIData:GetSectorIIIHardOpenTime()
  if self._hardOpenTime ~= nil then
    return self._hardOpenTime
  end
  for i, preId in ipairs(self._mainCfg.hard_pre_condition) do
    if preId == CheckerTypeId.TimeRange then
      self._countdownTime = self._mainCfg.hard_pre_para1[i]
      break
    end
  end
  self._countdownTime = self._countdownTime or 0
  return self._countdownTime
end

function ActivitySectorIIIData:GetSectorIIIMainNextOpenTime()
  return self._mainCfg.main2nd_start
end

function ActivitySectorIIIData:GetSectorIII_EffiMultRate()
  local rate = PlayerDataCenter.playerBonus:Get_Activity_EffiMultRate(self:GetActFrameId())
  return rate
end

function ActivitySectorIIIData:SectorIII_IsFarmDouble()
  return self._farmDouble
end

function ActivitySectorIIIData:SectorIII_SetFarmDouble(active)
  self._farmDouble = active
end

function ActivitySectorIIIData:GetSectorIII_PointMultRat()
  local itemRateDic = PlayerDataCenter.playerBonus:Get_Activity_PointMultRate(self:GetActFrameId())
  return itemRateDic
end

function ActivitySectorIIIData:GetSectorIIIDunTicketId()
  return self._dunTicketId
end

function ActivitySectorIIIData:GetSectorIIIDunPointId()
  return self._actPointId
end

function ActivitySectorIIIData:GetCommonActUnlockedBuffList()
  local actBuffUnlockDic = PlayerDataCenter.playerBonus:Get_Activity_UnlockBuff(self:GetActFrameId())
  return actBuffUnlockDic
end

function ActivitySectorIIIData:GetCommonActDelectedBuffList()
  local actBuffDelectDic = PlayerDataCenter.playerBonus:Get_Activity_DeleteBuff(self:GetActFrameId())
  return actBuffDelectDic
end

function ActivitySectorIIIData:GetActTinyGameData()
  return self._gameSnake
end

return ActivitySectorIIIData
