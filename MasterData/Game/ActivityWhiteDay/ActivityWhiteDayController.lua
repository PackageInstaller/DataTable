local ActivityWhiteDayController = class("ActivityWhiteDayController", ControllerBase)
local base = ControllerBase
local ActWhiteDayData = require("Game.ActivityWhiteDay.Data.ActWhiteDayData")
local eDynConfigData = require("Game.ConfigData.eDynConfigData")
local ActivityWhiteDaySceneCtrl = require("Game.ActivityWhiteDay.ActivityWhiteDaySceneCtrl")
local SectorStageDetailHelper = require("Game.Sector.SectorStageDetailHelper")

function ActivityWhiteDayController:OnInit()
  self.whiteDayNetWork = NetworkManager:GetNetwork(NetworkTypeID.WhiteDay)
  self.__AWDDataDic = {}
  ConfigData:LoadDynCfg(eDynConfigData.activity_white_day)
  ConfigData:LoadDynCfg(eDynConfigData.activity_white_day_factory)
  ConfigData:LoadDynCfg(eDynConfigData.activity_white_day_order)
  ConfigData:LoadDynCfg(eDynConfigData.activity_white_day_line)
  ConfigData:LoadDynCfg(eDynConfigData.activity_white_day_assist_hero)
  ConfigData:LoadDynCfg(eDynConfigData.activity_white_day_photo)
  ConfigData:LoadDynCfg(eDynConfigData.activity_white_day_event)
  self.__onItemUpdate = BindCallback(self, self.__OnItemUpdate)
  MsgCenter:AddListener(eMsgEventId.UpdateItem, self.__onItemUpdate)
  self.__onTaskUpdate = BindCallback(self, self.__OnTaskUpdate)
  MsgCenter:AddListener(eMsgEventId.TaskUpdate, self.__onTaskUpdate)
  self.__OnWDSceneDestroy = BindCallback(self, self.OnWDSceneDestroy)
  self._wdSceneCtrl = ActivityWhiteDaySceneCtrl.New(self)
  self.orderReddotTimerId = TimerManager:StartTimer(1, self.__OnTimeUpdate, self, false, nil, true)
  self.__2048GameCtrl = nil
end

function ActivityWhiteDayController:GetWhiteDaySceneCtrl()
  return self._wdSceneCtrl
end

function ActivityWhiteDayController:OnWhiteDayActivityOpen(actId)
  if self.__AWDDataDic[actId] ~= nil then
    return
  end
  local AWDData = ActWhiteDayData.New(actId)
  self.__AWDDataDic[actId] = AWDData
end

function ActivityWhiteDayController:OnWhiteDayActivityClose(actId)
  local AWDData = self.__AWDDataDic[actId]
  self.__AWDDataDic[actId] = nil
  if table.count(self.__AWDDataDic) <= 0 then
    ControllerManager:DeleteController(ControllerTypeId.WhiteDay)
  end
end

function ActivityWhiteDayController:UpdataSingleWhiteDayActivity(msg)
  if msg == nil then
    return
  end
  local actId = msg.actId
  local AWDData = self:GetWhiteDayDataByActId(actId)
  if AWDData == nil then
    self:OnWhiteDayActivityOpen(actId)
    AWDData = self:GetWhiteDayDataByActId(actId)
  end
  AWDData:UpdateByAWDByMsg(msg)
  self:__RefreshWDTask()
end

function ActivityWhiteDayController:UpdateAllWhiteDayActivity(msgs)
  if msgs == nil then
    return
  end
  for _, msg in pairs(msgs) do
    self:UpdataSingleWhiteDayActivity(msg)
  end
end

function ActivityWhiteDayController:GetWhiteDayDataByActId(actId)
  return self.__AWDDataDic[actId]
end

function ActivityWhiteDayController:GetWDFactoryLineUIPos(lineId)
  return self._wdSceneCtrl:GetWDFactoryLineUIPos(lineId)
end

function ActivityWhiteDayController:_PlayNormalBgm()
  AudioManager:PlayAudioById(3320)
  AudioManager:SetSourceSelectorLabel(eAudioSourceType.BgmSource, eAuSelct.Home.name, eAuSelct.Home.oasisDay)
end

function ActivityWhiteDayController:TryOpenWhiteDay(actId, allLoadOverCallabck)
  if actId == nil then
    return false
  end
  local AWDData = self:GetWhiteDayDataByActId(actId)
  if AWDData == nil then
    return false
  end
  if UIManager:GetWindow(UIWindowTypeID.WhiteDay) ~= nil then
    if allLoadOverCallabck ~= nil then
      allLoadOverCallabck()
    end
    return
  end
  if AWDData:IsActivityOpen() and not AWDData:IsActivityRunning() then
    UIManager:ShowWindowAsync(UIWindowTypeID.WhiteDayAlbum, function(window)
      if window == nil then
        return
      end
      window:InitWDAlbun(self, AWDData)
    end)
    return
  end
  
  local function openFunc()
    if AWDData == nil or not AWDData:IsActivityRunning() then
      self:CloseWhiteDay()
      return
    end
    local sceneName = AWDData:GetWDCfg().scene
    if #sceneName == 0 then
      error(" whiteSceneName is NIL")
      return
    end
    UIManager:DeleteAllWindow()
    UIUtil.AddOneCover("TryOpenWhiteDay", SafePack(nil, nil, nil, Color.black, false))
    CS.GSceneManager.Instance:LoadSceneByAB(sceneName, function()
      self._curLoadedSceneName = sceneName
      UIUtil.CloseOneCover("TryOpenWhiteDay")
      if AWDData == nil or not AWDData:IsActivityRunning() then
        self:CloseWhiteDay()
        return
      end
      MsgCenter:AddListener(eMsgEventId.OnSceneUnload, self.__OnWDSceneDestroy)
      self._wdSceneCtrl:OnEnterWhiteDayScene(AWDData)
      UIManager:ShowWindowAsync(UIWindowTypeID.WhiteDay, function(win)
        if AWDData == nil or not AWDData:IsActivityRunning() then
          UIUtil.ReturnHome()
          return
        end
        if win ~= nil then
          win:InitWhiteDayUI(self, AWDData)
        end
        if allLoadOverCallabck ~= nil then
          allLoadOverCallabck()
        end
        GuideManager:TryTriggerGuide(eGuideCondition.ActWhiteDayMain)
      end)
    end)
    self:_PlayNormalBgm()
  end
  
  local avgId = AWDData:GetAWDFirstEnterAvgId()
  if avgId ~= nil and 0 < avgId then
    local avgPlayCtrl = ControllerManager:GetController(ControllerTypeId.AvgPlay)
    local played = avgPlayCtrl:IsAvgPlayed(avgId)
    if not played and AWDData:IsActivityRunning() then
      ControllerManager:GetController(ControllerTypeId.Avg, true):StartAvg(nil, avgId, openFunc)
    else
      openFunc()
    end
  else
    openFunc()
  end
  return true
end

function ActivityWhiteDayController:CloseWhiteDay()
  UIManager:DeleteAllWindow()
  UIUtil.AddOneCover("WDBack2Main", SafePack(nil, nil, nil, Color.black, false))
  CS.GSceneManager.Instance:LoadSceneByAB(Consts.SceneName.Main, function()
    UIUtil.CloseOneCover("WDBack2Main")
    ControllerManager:GetController(ControllerTypeId.HomeController, true):OnEnterHome()
    UIManager:ShowWindowAsync(UIWindowTypeID.Home, function(window)
      if window == nil then
        return
      end
      window:SetFrom2Home(AreaConst.FactoryDorm, true)
    end)
  end)
end

function ActivityWhiteDayController:OnWDSceneDestroy(sceneNmae)
  if sceneNmae == self._curLoadedSceneName then
    self._curLoadedSceneName = nil
    if self._wdSceneCtrl ~= nil then
      self._wdSceneCtrl:OnExitWhiteDayScene()
    end
    MsgCenter:RemoveListener(eMsgEventId.OnSceneUnload, self.__OnWDSceneDestroy)
  end
end

function ActivityWhiteDayController:OpenWhitrDaySector(AWDData, successCallback)
  local sectorId = AWDData:GetAWDSectorId()
  if not SectorStageDetailHelper.IsSectorNoCollide(sectorId, true) then
    return
  end
  UIManager:HideWindow(UIWindowTypeID.WhiteDay)
  UIManager:ShowWindowAsync(UIWindowTypeID.SectorLevel, function(window)
    if window == nil then
      return
    end
    if successCallback ~= nil then
      successCallback()
    end
    window:InitSectorLevel(sectorId, function()
      UIManager:ShowWindowOnly(UIWindowTypeID.WhiteDay)
    end, nil, nil, nil)
    window:SetCustomEnterFmtCallback(function(enterFmtData)
      if enterFmtData ~= nil then
        enterFmtData:SetFmtForbidSupport(true)
        enterFmtData:SetIsShowSupportHolder(true)
      end
    end)
  end)
end

function ActivityWhiteDayController:IsWDSector(sectorId)
  for actId, AWDData in pairs(self.__AWDDataDic) do
    if AWDData:GetAWDSectorId() == sectorId then
      return true, AWDData
    end
  end
  return false
end

function ActivityWhiteDayController:TryEnterWDSector(sectorId, successCallback)
  local isWDSector, AWDData = self:IsWDSector(sectorId)
  if isWDSector and AWDData:IsActivityRunning() then
    local actId = AWDData:GetActId()
    self:TryOpenWhiteDay(actId, function()
      self:OpenWhitrDaySector(AWDData, successCallback)
    end)
    return true
  end
  return false
end

function ActivityWhiteDayController:WDTryShowFactroyLevelUp(AWDData, callback)
  local beforeLevelUpLevel = AWDData:GetWDBeforeLevelUpLevel()
  AWDData:SetWDHasShowedLevelUp()
  if beforeLevelUpLevel == nil then
    if callback ~= nil then
      callback()
    end
    return
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.WhiteDayFactoryLevelUp, function(window)
    if window == nil then
      if callback ~= nil then
        callback()
      end
      return
    end
    window:InitWDFactoryLevelUp(AWDData, beforeLevelUpLevel, callback)
  end)
end

function ActivityWhiteDayController:SetWD2048GameCtrl(ctrl)
  self.__2048GameCtrl = ctrl
end

function ActivityWhiteDayController:GetWD2048GameCtrl()
  return self.__2048GameCtrl
end

function ActivityWhiteDayController:WDStartLineOrder(actFrameId, orderId, assistHeroId, lineId)
  self.whiteDayNetWork:CS_Activity_Factory_Product(actFrameId, lineId, orderId, assistHeroId, function()
    MsgCenter:Broadcast(eMsgEventId.WhiteDayOrderChange, lineId)
    self._wdSceneCtrl:AddWDBindRole(lineId, assistHeroId)
    local voiceId = ConfigData:GetVoicePointRandom(eVoicePointType.InFactory, nil, assistHeroId)
    local cvCtr = ControllerManager:GetController(ControllerTypeId.Cv, true)
    cvCtr:PlayCv(assistHeroId, voiceId)
  end)
end

function ActivityWhiteDayController:WDAccLineOrder(actFrameId, itemId, itemNum, lineId, callback)
  self.whiteDayNetWork:CS_Activity_Factory_Order_Speed(actFrameId, lineId, itemId, itemNum, function()
    MsgCenter:Broadcast(eMsgEventId.WhiteDayOrderChange, lineId, true)
    if callback ~= nil then
      callback()
    end
  end)
end

function ActivityWhiteDayController:WDFinishLineOrder(actFrameId, lineId, callback)
  self.whiteDayNetWork:CS_Activity_Factory_Collect(actFrameId, lineId, function(args)
    if args.Count == 0 then
      error("args.Count == 0")
      return
    end
    local rewardDic = args[0]
    MsgCenter:Broadcast(eMsgEventId.WhiteDayOrderChange, lineId)
    if callback ~= nil then
      callback(rewardDic)
    end
    self._wdSceneCtrl:RemoveWDBindRole(lineId)
  end)
end

function ActivityWhiteDayController:WDRandomPickPhoto(AWDData, callback)
  local actFrameId = AWDData:GetActFrameId()
  self.whiteDayNetWork:CS_Activity_Polariod_Lottery(actFrameId, function(args)
    if args.Count == 0 then
      error("args.Count == 0")
      return
    end
    local photoId = args[0]
    MsgCenter:Broadcast(eMsgEventId.WhiteDayPhotoChange, photoId)
    if callback ~= nil then
      callback(photoId)
    end
    AWDData:RefreshWDReddot4AlbumAvg()
  end)
end

function ActivityWhiteDayController:WDPickPhoto(AWDData, photoId, callback)
  local actFrameId = AWDData:GetActFrameId()
  self.whiteDayNetWork:CS_Activity_Polariod_SelfSelect(actFrameId, photoId, function()
    MsgCenter:Broadcast(eMsgEventId.WhiteDayPhotoChange, photoId)
    if callback ~= nil then
      callback(photoId)
    end
    AWDData:RefreshWDReddot4AlbumAvg()
  end)
end

function ActivityWhiteDayController:WDEndlessTaskCommit(AWDData, taskId, callback)
  local actFrameId = AWDData:GetActFrameId()
  local network = NetworkManager:GetNetwork(NetworkTypeID.ActivityFrame)
  network:CS_Activity_Quest_Commit(actFrameId, taskId, callback)
end

function ActivityWhiteDayController:WDTaskCommit(AWDData, taskData, callback)
  NetworkManager:GetNetwork(NetworkTypeID.Task):SendCommitQuest(taskData, function()
    if callback ~= nil then
      callback()
    end
    AWDData:RefreshWDReddot4Task()
  end)
end

function ActivityWhiteDayController:__OnItemUpdate(itemUpdate, resourceData, itemUpdateCount)
  for actId, AWDData in pairs(self.__AWDDataDic) do
    for itemId, _ in pairs(itemUpdate) do
      if itemUpdateCount[itemId] ~= nil and 0 < itemUpdateCount[itemId] then
        local randomItemId = AWDData:GetWDRandomPhotoItemIdAndNum()
        local pickItemId = AWDData:GetWDExchangePhotoItemIdAndNum()
        if randomItemId == itemId or pickItemId == itemId then
          AWDData:SetWDReddot4Album(true)
          break
        end
      end
    end
  end
end

function ActivityWhiteDayController:__OnTaskUpdate()
  for actId, AWDData in pairs(self.__AWDDataDic) do
    AWDData:RefreshWDReddot4Task()
  end
end

function ActivityWhiteDayController:__OnTimeUpdate()
  for actId, AWDData in pairs(self.__AWDDataDic) do
    AWDData:RefreshWDReddot4Order()
  end
end

function ActivityWhiteDayController:__RefreshWDTask()
  local win = UIManager:GetWindow(UIWindowTypeID.WhiteDayTask)
  if win ~= nil then
    win:RefreshWDTaskList()
  end
end

function ActivityWhiteDayController:OnDelete()
  ConfigData:ReleaseDynCfg(eDynConfigData.activity_white_day)
  ConfigData:ReleaseDynCfg(eDynConfigData.activity_white_day_factory)
  ConfigData:ReleaseDynCfg(eDynConfigData.activity_white_day_order)
  ConfigData:ReleaseDynCfg(eDynConfigData.activity_white_day_line)
  ConfigData:ReleaseDynCfg(eDynConfigData.activity_white_day_assist_hero)
  ConfigData:ReleaseDynCfg(eDynConfigData.activity_white_day_photo)
  ConfigData:ReleaseDynCfg(eDynConfigData.activity_white_day_event)
  MsgCenter:RemoveListener(eMsgEventId.UpdateItem, self.__onItemUpdate)
  MsgCenter:RemoveListener(eMsgEventId.TaskUpdate, self.__onTaskUpdate)
  base.OnDelete(self)
  if self.orderReddotTimerId ~= nil then
    TimerManager:StopTimer(self.orderReddotTimerId)
    self.orderReddotTimerId = nil
  end
  self._wdSceneCtrl:Delete()
  self._wdSceneCtrl = nil
end

return ActivityWhiteDayController
