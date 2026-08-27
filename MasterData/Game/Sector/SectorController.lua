local SectorController = class("SectorController", ControllerBase)
local SectorCameraCtrl = require("Game.Sector.Ctrl.SectorCameraCtrl")
local MainSectorCtrl = require("Game.Sector.Ctrl.MainSectorCtrl")
local eSectorState = require("Game.Sector.Enum.eSectorState")
local SectorStageDetailHelper = require("Game.Sector.SectorStageDetailHelper")
local util = require("XLua.Common.xlua_util")
local Cs_GSceneManager_Ins = CS.GSceneManager.Instance
local cs_MessageCommon = CS.MessageCommon
local SectorAdditionCtrl = require("Game.Sector.Ctrl.SectorAdditionCtrl")
local SectorDungeonCtrl = require("Game.Sector.Ctrl.SubPlayMode.SectorDungeonCtrl")
local SectorWeeklyChallengeCtrl = require("Game.Sector.Ctrl.SubPlayMode.SectorWeeklyChallengeCtrl")
local SectorDailyDungeonCtrl = require("Game.Sector.Ctrl.SubPlayMode.SectorDailyDungeonCtrl")
local SectorBlackHoleCtrl = require("Game.Sector.Ctrl.SubPlayMode.SectorBlackHoleCtrl")
local SectorSixHeroTowerCtrl = require("Game.Sector.Ctrl.SubPlayMode.SectorSixHeroTowerCtrl")
local SectorEnum = require("Game.Sector.SectorEnum")
local CS_ClientConsts = CS.ClientConsts

function SectorController:ctor()
  self.ctrls = {}
  self.camCtrl = SectorCameraCtrl.New(self)
  self.mainSctCtrl = MainSectorCtrl.New(self)
  self.addCtrl = SectorAdditionCtrl.New(self)
  self.dungeonCtrl = SectorDungeonCtrl.New(self)
  self.weeklyCtrl = SectorWeeklyChallengeCtrl.New(self)
  self.dailyCtrl = SectorDailyDungeonCtrl.New(self)
  self.blackHoleCtrl = SectorBlackHoleCtrl.New(self)
  self.sixHeroTowerCtrl = SectorSixHeroTowerCtrl.New(self)
end

function SectorController:OnInit()
  self:SetSctState(eSectorState.None)
end

function SectorController:SetSctState(sctState)
  if self.sctState == sctState then
    return
  end
  self.mainSctCtrl:OnSctStateChange(self.sctState, sctState)
  self.sctState = sctState
  if sctState == eSectorState.SelectMainSectorLevel or sctState == eSectorState.CorverSector then
    UIManager:HideWindow(UIWindowTypeID.SectorEntrance)
  else
    UIManager:ShowWindowOnly(UIWindowTypeID.SectorEntrance)
  end
end

function SectorController:IsSctState(sctState)
  return self.sctState == sctState
end

function SectorController:ResetToNormalState(toHome, needFocus)
  self:SetSctState(eSectorState.Normal)
  self.mainSctCtrl:ResetToNormalState(toHome, needFocus)
end

function SectorController:IsSectorNormalState()
  return self.sctState == eSectorState.Normal
end

function SectorController:PlaySectorBgm()
  AudioManager:PlayAudioById(3002)
  AudioManager:SetSourceSelectorLabel(eAudioSourceType.BgmSource, eAuSelct.Home.name, eAuSelct.Home.sector)
end

function SectorController:_CurNeedEnterMapId()
  local lastestMapId
  
  local function GetSectorMapIdFunc(sectorId)
    if sectorId == SectorEnum.NewbeeSectorId then
      return 1
    end
    local chapterId = ConfigData.sector_sector_resident.sectorId2ChapterIdMap[sectorId]
    if chapterId then
      return ConfigData.sector_sector_resident[chapterId].map_id
    end
  end
  
  local uncompleteSectorId = SectorStageDetailHelper.TryGetUncompleteStageSectorId()
  if uncompleteSectorId then
    lastestMapId = GetSectorMapIdFunc(uncompleteSectorId)
    if lastestMapId then
      return lastestMapId
    end
  end
  if CS_ClientConsts.IsAudit then
    return 1
  end
  local localModelData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  if localModelData then
    local localSectorMentionId = localModelData:GetLastLocalSectorMentionId()
    local sectorId = self.mainSctCtrl:GetSectorIdByFocusId(localSectorMentionId)
    lastestMapId = GetSectorMapIdFunc(sectorId)
    if lastestMapId then
      return lastestMapId
    end
  end
  local lastestMapId = 1
  for mapId, _ in pairs(ConfigData.sector_sector_resident.sectorMapChapterDic) do
    if PlayerDataCenter.sectorStage:IsSectorMapUnlock(mapId) and mapId > lastestMapId then
      lastestMapId = mapId
    end
  end
  return lastestMapId
end

function SectorController:InitSectorCtrl(enterFunc, loadingAsyncOp)
  self._sectorMapId = self:_CurNeedEnterMapId()
  self:_LoadingSector(self._sectorMapId, enterFunc, loadingAsyncOp)
end

function SectorController:_LoadingSector(sectorMapId, enterFunc, loadingAsyncOp)
  local sctMapCfg = ConfigData.sector_sector_map[sectorMapId]
  if sctMapCfg == nil then
    error("Cant get sector_sector_map, sectorMapId:" .. tostring(sectorMapId))
    return
  end
  
  local function callback()
    if enterFunc ~= nil then
      enterFunc(self)
    end
    PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData):SetNewSectorMapRead(sectorMapId)
  end
  
  if loadingAsyncOp == nil then
    Cs_GSceneManager_Ins:LoadSceneByAB(sctMapCfg.src_name, callback)
  else
    Cs_GSceneManager_Ins:LoadSceneAsyncByAB(sctMapCfg.src_name, callback, util.cs_generator(loadingAsyncOp))
  end
end

function SectorController:SwitchSectorMap(targetSectorMapId, afterLoadFunc)
  local function loadedSectorFunc(sectorCtrl)
    MsgCenter:Broadcast(eMsgEventId.OnSectorMapSwich)
    
    sectorCtrl:SetFrom(AreaConst.Sector)
    UIManager:ShowWindow(UIWindowTypeID.CommonMask):InitCommonMask(Color.black):CommonMaskFadeOut(0.1, function()
      UIManager:HideWindow(UIWindowTypeID.CommonMask)
    end)
    if afterLoadFunc then
      afterLoadFunc()
    end
  end
  
  local function exitFunc()
    self._isEntered = false
    self.mainSctCtrl:ExitMainSector()
    self._sectorMapId = targetSectorMapId
    self:_LoadingSector(targetSectorMapId, loadedSectorFunc)
  end
  
  UIManager:ShowWindow(UIWindowTypeID.CommonMask):InitCommonMask(Color.black):CommonMaskFadeIn(0.2, exitFunc)
end

function SectorController:SwitchNextSectorMap(isNext, afterLoadFunc)
  local nextMapId = self._sectorMapId + (isNext and 1 or -1)
  if ConfigData.sector_sector_map[nextMapId] == nil then
    return false
  end
  local nextMapUnlock = PlayerDataCenter.sectorStage:IsSectorMapUnlock(nextMapId)
  if not nextMapUnlock then
    local unLockInfo = PlayerDataCenter.sectorStage:GetSectorMapUnlockInfo(nextMapId)
    cs_MessageCommon.ShowMessageTipsWithErrorSound(unLockInfo)
    return false
  end
  self:SwitchSectorMap(nextMapId, afterLoadFunc)
  return true
end

function SectorController:SetFrom(from, lastPlayData)
  if self._isEntering then
    error("重复进入扇区,请检查")
  end
  if self._isEntered then
    return
  end
  self._isEntered = false
  self._isEntering = true
  self.mainSctCtrl:EnterMainSector(from, lastPlayData)
  local lastSelectedIndex = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData):GetSectorLastSelectedPage() or SectorEnum.ePageIndex.main
  self:InitSectorEntranceUI()
  
  local function waitEnterCo()
    self.mainSctCtrl:DetectedGeneralDungeonUnlock()
    self.mainSctCtrl:TryPlayTimeLine(from, lastPlayData)
    self.mainSctCtrl:TryPlayUnlockVideo()
    self.mainSctCtrl:TryPlayUnlockAnim()
    while UIManager:GetWindow(UIWindowTypeID.MovieBlack) ~= nil do
      coroutine.yield(nil)
    end
    while UIManager:GetWindow(UIWindowTypeID.SectorEntrance) == nil do
      coroutine.yield(nil)
    end
    self.camCtrl:InitSectorCameraCtrl()
    local jumpInCallback = self:GetSctJumpInCallback()
    if jumpInCallback ~= nil then
      jumpInCallback()
      self:SetJumpInCallback(nil)
    else
      UIManager:GetWindow(UIWindowTypeID.SectorEntrance):OnClickSEPageBtn(lastSelectedIndex)
    end
    if self.__loadCoExtrCBList ~= nil then
      local list = self.__loadCoExtrCBList
      self.__loadCoExtrCBList = nil
      for _, callback in ipairs(list) do
        callback()
      end
    end
    if self.sctState == eSectorState.None then
      self:ResetToNormalState()
    end
    PlayerDataCenter.sectorEntranceHandler:DealUncompleteLevel4TryEnterSector()
    self._isEntered = true
    self._isEntering = false
  end
  
  self.__fromEpCoroutine = GR.StartCoroutine(util.cs_generator(waitEnterCo))
end

function SectorController:AddLoadCoCallback(callback)
  if self._isEntered then
    if callback ~= nil then
      callback()
    end
    return
  end
  if self.__loadCoExtrCBList == nil then
    self.__loadCoExtrCBList = {}
  end
  table.insert(self.__loadCoExtrCBList, callback)
end

function SectorController:SetJumpInCallback(jumpInCallback)
  self.__JumpInCallback = jumpInCallback
end

function SectorController:GetSctJumpInCallback()
  return self.__JumpInCallback
end

function SectorController:GetSctCurMapId()
  return self._sectorMapId
end

function SectorController:GetMainSectorCtrl()
  return self.mainSctCtrl
end

function SectorController:InitSectorEntranceUI()
  UIManager:ShowWindowAsync(UIWindowTypeID.SectorEntrance, function(win)
    local completeIntro = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_CompleteIntro)
    win:InitSectorEntrance(self)
    UIUtil.SetTopStatus(win, function()
      self:OnTryRenturn()
    end, {
      ConstGlobalItem.SKey
    }, nil, nil, not completeIntro)
    if not completeIntro then
      win:Hide()
    end
  end)
end

function SectorController:GetCouldPlayUnlockAnim()
  return not GuideManager.inGuide and self:GetSctJumpInCallback() == nil
end

function SectorController:EnterSectorLevelWin(sectorId, difficuty, stageCfg, extraCloseFunc, enterOverCallback)
  self.mainSctCtrl:EnterSectorLevelWin(sectorId, difficuty, stageCfg, extraCloseFunc, enterOverCallback)
end

function SectorController:IsSectorCouldReturnHome()
  local completeIntro = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_CompleteIntro)
  if not completeIntro then
    return false
  end
  if self.sctState == eSectorState.None then
    return false
  end
  return true
end

function SectorController:OnTryRenturn()
  self.mainSctCtrl:OnMainSctBtnHomeClicked()
end

function SectorController:ExitSectorCtrl()
  if not self:IsSectorCouldReturnHome() then
    return false
  end
  self:SetSctState(eSectorState.None)
  if self.__fromEpCoroutine ~= nil then
    GR.StopCoroutine(self.__fromEpCoroutine)
    self.__fromEpCoroutine = nil
  end
  ControllerManager:DeleteController(ControllerTypeId.SectorController)
  ControllerManager:DeleteController(ControllerTypeId.RecommeFormation)
  return true
end

function SectorController:OnBtnHomeClicked()
  self.mainSctCtrl:OnMainSctBtnHomeClicked()
end

function SectorController:OnStrategyOverviewClose()
  if ControllerManager:GetController(ControllerTypeId.SectorController) == nil then
    return
  end
  self.mainSctCtrl:ResetToNormalState()
end

function SectorController:EnableSectorCamDrag()
  return self.sctState == eSectorState.Normal
end

function SectorController:IsDisableClick()
  return self.camCtrl:InSctCamDrag() or self.sctState ~= eSectorState.Normal
end

function SectorController:IsHave2PlayUnlockSectorShow()
  return self.mainSctCtrl:IsHave2PlayUnlockSectorShow()
end

function SectorController:TryGetShowTypeID(sectorId, arrangeCfg, assignShowType)
  if assignShowType ~= nil and 0 < assignShowType then
    return assignShowType
  end
  local sectorCfg = ConfigData.sector[sectorId]
  if sectorCfg == nil then
    error("Cant get sectorCfg, sectorId = " .. tostring(sectorId))
    return nil
  end
  local showTypeDic = sectorCfg.show_typeDic
  if showTypeDic == nil then
    return nil
  end
  local typeID = arrangeCfg.typeId or 0
  local showTypeID = showTypeDic[typeID]
  return showTypeID
end

function SectorController:__TryPlayFirstEnterSectorIIAvg(SectorIIData, callback)
  local avgId = SectorIIData:GetSectorIIFirstEnterAvgId()
  if avgId ~= nil and 0 < avgId then
    local avgPlayCtrl = ControllerManager:GetController(ControllerTypeId.AvgPlay)
    local played = avgPlayCtrl:IsAvgPlayed(avgId)
    if not played and SectorIIData:IsActivityRunning() then
      ControllerManager:GetController(ControllerTypeId.Avg, true):StartAvg(nil, avgId, callback)
    elseif callback ~= nil then
      callback()
    end
  end
end

function SectorController:OnDelete()
  for k, v in pairs(self.ctrls) do
    v:OnDelete()
  end
  self.ctrls = nil
  UIManager:DeleteWindow(UIWindowTypeID.SectorEntrance)
  UIManager:DeleteWindow(UIWindowTypeID.SectorLevel)
  PersistentManager:SaveModelData(PersistentConfig.ePackage.UserData)
end

return SectorController
