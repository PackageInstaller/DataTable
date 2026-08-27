local ActivityHistoryTinyGameController = class("ActivityHistoryTinyGameController", ControllerBase)
local base = ControllerBase
local HistoryTinyGameData = require("Game.ActivityHistoryTinyGame.Data.HistoryTinyGameData")

function ActivityHistoryTinyGameController:OnInit()
  self._frameCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame)
  self.__HTGDataDic = {}
  self.__TaskUpdateCallback = BindCallback(self, self.__TaskUpdate)
  MsgCenter:AddListener(eMsgEventId.TaskUpdate, self.__TaskUpdateCallback)
  self.__TaskReceiveCallback = BindCallback(self, self.__TaskReceive)
  MsgCenter:AddListener(eMsgEventId.TaskCommitComplete, self.__TaskReceiveCallback)
  self.__AvgPlayedCallBack = BindCallback(self, self.__AvgPlayed)
  MsgCenter:AddListener(eMsgEventId.AVGLogicPlayed, self.__AvgPlayedCallBack)
  self.__ExpireDealCallback = BindCallback(self, self.__ExpireDeal)
end

function ActivityHistoryTinyGameController:OnActivityOpen(actId)
  if self.__HTGDataDic[actId] ~= nil then
    return
  end
  local HTGData = HistoryTinyGameData.New(actId)
  self.__HTGDataDic[actId] = HTGData
end

function ActivityHistoryTinyGameController:OnActivityClose(actId)
  local HTGData = self.__HTGDataDic[actId]
  self.__HTGDataDic[actId] = nil
  if table.count(self.__HTGDataDic) <= 0 then
    ControllerManager:DeleteController(ControllerTypeId.HistoryTinyGameActivity)
  end
end

function ActivityHistoryTinyGameController:UpdataSingleActivity(msg)
  if msg == nil then
    return
  end
  local actId = msg.actId
  local HTGData = self:GetDataByActId(actId)
  if HTGData == nil then
    self:OnActivityOpen(actId)
    HTGData = self:GetDataByActId(actId)
  end
  HTGData:UpdateHTGDataByMsg(msg)
  self._frameCtrl:AddActivityDataUpdateTimeListen(HTGData:GetActFrameId(), HTGData:GetTinyGameNextTm() + 1, self.__ExpireDealCallback)
end

function ActivityHistoryTinyGameController:__ExpireDeal(activityFrameId)
  local actFrameData = self._frameCtrl:GetActivityFrameData(activityFrameId)
  local data = self.__HTGDataDic[actFrameData:GetActId()]
  if data == nil then
    return
  end
  local tinyNetCtrl = NetworkManager:GetNetwork(NetworkTypeID.ActivityHistoryTinyGame)
  tinyNetCtrl:CS_ACTIVITY_TinyGame_RefreshQuestAll(data:GetActId(), function(args)
    if args.Count == 0 then
      error("args.Count == 0")
      return
    end
    local msg = args[0]
    data:UpdateHTGDailyTask(msg)
    self._frameCtrl:AddActivityDataUpdateTimeListen(activityFrameId, data:GetTinyGameNextTm() + 1, self.__ExpireDealCallback)
    MsgCenter:Broadcast(eMsgEventId.ActivityTinyGameTaskExpired)
  end)
end

function ActivityHistoryTinyGameController:GetDataByActId(actId)
  return self.__HTGDataDic[actId]
end

function ActivityHistoryTinyGameController:GetOneHTGData()
  for k, v in pairs(self.__HTGDataDic) do
    return v
  end
end

function ActivityHistoryTinyGameController:TryOpenHistoryTinyGame(actId, allLoadOverCallabck, isOpenMain)
  if actId == nil then
    return false
  end
  local HTGData = self:GetDataByActId(actId)
  if HTGData == nil then
    return false
  end
  local win = UIManager:GetWindow(UIWindowTypeID.ActivityMiniGameMain)
  if win ~= nil then
    if allLoadOverCallabck ~= nil then
      allLoadOverCallabck()
    end
    if isOpenMain then
      win:OnHTGOpenSubUI(1)
    end
    return
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.ActivityMiniGameMain, function(win)
    if HTGData == nil or not HTGData:IsActivityOpen() then
      UIUtil.ReturnHome()
      return
    end
    if win ~= nil then
      local homeWin = UIManager:GetWindow(UIWindowTypeID.Home)
      if homeWin ~= nil then
        win:SetFromWhichUI(eBaseWinFromWhere.home)
        homeWin:OpenOtherWin()
        local oasisCtrl = ControllerManager:GetController(ControllerTypeId.OasisController)
        if oasisCtrl ~= nil then
          oasisCtrl.weatherCtrl:StopWeatherEffect()
        end
      end
      win:InitMiniGameGroupMain(HTGData, function()
        local oasisCtrl = ControllerManager:GetController(ControllerTypeId.OasisController)
        if oasisCtrl ~= nil then
          oasisCtrl.weatherCtrl:RandomNewWeather()
        end
      end)
    end
    if allLoadOverCallabck ~= nil then
      allLoadOverCallabck()
    end
  end)
  local avgPlayCtrl = ControllerManager:GetController(ControllerTypeId.AvgPlay)
  
  local function AVG2()
    local avgId2 = HTGData:GetSecondAvgId()
    if avgId2 ~= nil and 0 < avgId2 then
      local played = avgPlayCtrl:IsAvgPlayed(avgId2)
      if not played and HTGData:IsActivityRunning() then
        ControllerManager:GetController(ControllerTypeId.Avg, true):StartAvg(nil, avgId2)
      end
    end
  end
  
  local avgId1 = HTGData:GetFirstAvgId()
  if avgId1 ~= nil and 0 < avgId1 then
    local played = avgPlayCtrl:IsAvgPlayed(avgId1)
    if not played and HTGData:IsActivityRunning() then
      ControllerManager:GetController(ControllerTypeId.Avg, true):StartAvg(nil, avgId1, function()
        GuideManager:StartNewGuide(HTGData:GetAfterFirstAvgGuideId())
      end)
      return
    end
  else
    AVG2()
  end
  return true
end

function ActivityHistoryTinyGameController:__TaskUpdate(taskData)
  for k, v in pairs(self.__HTGDataDic) do
    v:RefreshHTGTaskReddot(taskData.id)
    v:RefreshHTGAvgReddot(nil, taskData.id)
  end
end

function ActivityHistoryTinyGameController:__TaskReceive(taskStc)
  for k, v in pairs(self.__HTGDataDic) do
    v:RefreshHTGTaskReddot(taskStc.id)
    v:RefreshHTGAvgReddot(nil, taskStc.id)
  end
end

function ActivityHistoryTinyGameController:__AvgPlayed(avgId)
  for k, v in pairs(self.__HTGDataDic) do
    v:RefreshHTGAvgReddot(avgId, nil)
  end
end

function ActivityHistoryTinyGameController:OnDelete()
  MsgCenter:RemoveListener(eMsgEventId.TaskUpdate, self.__TaskUpdateCallback)
  MsgCenter:RemoveListener(eMsgEventId.TaskCommitComplete, self.__TaskReceiveCallback)
  MsgCenter:RemoveListener(eMsgEventId.AVGLogicPlayed, self.__AvgPlayedCallBack)
end

return ActivityHistoryTinyGameController
