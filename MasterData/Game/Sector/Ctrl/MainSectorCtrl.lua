local base = require("Game.Sector.Ctrl.SectorCtrlBase")
local MainSectorCtrl = class("MainSectorCtrl", base)
local cs_GameObject = CS.UnityEngine.GameObject
local cs_MessageCommon = CS.MessageCommon
local cs_DoTween = CS.DG.Tweening.DOTween
local SectorItemEntity = require("Game.Sector.Entity.SectorItemEntity")
local UISectorSceneCanvas = require("Game.Sector.UIScene.UISectorSceneCanvas")
local SectorChapterData = require("Game.Sector.Data.SectorChapterData")
local util = require("XLua.Common.xlua_util")
local SectorLevelDetailEnum = require("Game.Sector.Enum.SectorLevelDetailEnum")
local JumpManager = require("Game.Jump.JumpManager")
local SectorEnum = require("Game.Sector.SectorEnum")
local ActivityFrameEnum = require("Game.ActivityFrame.ActivityFrameEnum")
local SectorStageDetailHelper = require("Game.Sector.SectorStageDetailHelper")
local SectorUtil = require("Game.Sector.SectorUtil")
local eSectorState = require("Game.Sector.Enum.eSectorState")

function MainSectorCtrl:ctor(sectorCtrl)
  self.__onClickSectorItem = BindCallback(self, self.OnSectorItemClicked)
  self.__ResetToNormalState = BindCallback(self, self.ResetToNormalState)
  self.__EnterSectorLevelFunc = BindCallback(self, self.EnterSectorLevelWin)
end

function MainSectorCtrl:_OnEnterMainSectorScene()
  self._forceFocusId = nil
  self.sctCtrl:PlaySectorBgm()
  local sectorRoot = cs_GameObject.Find("SectorRoot").transform
  self.bind = {}
  UIUtil.LuaUIBindingTable(sectorRoot, self.bind)
  self.sctCtrl.camCtrl:OnSctCamEnterScene(self.bind.camRoot)
  self.sectorToHomeGo = self.sctCtrl.camCtrl:GetSctCamPdSector2Home().gameObject
  self.homeToSectorGo = self.sctCtrl.camCtrl:GetSctCamPdHome2Sector().gameObject
  self.sctItemDic = {}
  local uiCanvas = UISectorSceneCanvas.New()
  uiCanvas:Init(self.bind.uISectorSceneCanvas)
  uiCanvas:InitSctSceneCanvas()
  self.sctSceneUI = uiCanvas
  self:_InitSectorItems()
  CS.EventTriggerListener.Get(self.bind.homeCollider):onClick("+", function()
    if self.sctCtrl:IsDisableClick() then
      return
    end
    if not self.sctCtrl:IsSectorCouldReturnHome() then
      return
    end
    UIUtil.ReturnHome()
  end)
end

function MainSectorCtrl:OnSctStateChange(curSctState, newSctState)
  if curSctState == newSctState then
    return
  end
  if newSctState == eSectorState.Normal or newSctState == eSectorState.None then
    self:EnbleSectorUI3D(true)
  else
    self:EnbleSectorUI3D(false)
  end
end

function MainSectorCtrl:_OnSectorToHomeDirectorStopped()
  local homeCtrl = ControllerManager:GetController(ControllerTypeId.HomeController)
  if homeCtrl ~= nil then
    homeCtrl:PreLoadMainBg(function()
      self:_LoadSectorToHome()
    end)
  else
    self:_LoadSectorToHome()
  end
end

function MainSectorCtrl:_LoadSectorToHome()
  CS.GSceneManager.Instance:LoadSceneByAB(Consts.SceneName.Main, function()
    ControllerManager:GetController(ControllerTypeId.HomeController, true):OnEnterHome()
    ControllerManager:DeleteController(ControllerTypeId.SectorController)
    UIManager:CreateWindowAsync(UIWindowTypeID.Home, function(window)
      if window == nil then
        return
      end
      window:SetFrom2Home(AreaConst.Sector, true)
    end)
  end)
end

function MainSectorCtrl:TryPlayTimeLine(from, lastSatgeData)
  self.sectorToHomeGo:SetActive(false)
  self.homeToSectorGo:SetActive(true)
  if from == AreaConst.Home or from == AreaConst.Oasis then
    self:_PlayHome2SectorTl()
  end
end

function MainSectorCtrl:TryPlayUnlockVideo()
  if not GuideManager.inGuide and self.sctCtrl:GetSctJumpInCallback() == nil and self.needPlayEndVideo ~= nil and self.needPlayEndVideo.flag then
    local win = UIManager:ShowWindow(UIWindowTypeID.SectorUnlockMovie)
    local couldPlay = win:TryPlayVideo(self.needPlayEndVideo, function()
      self.needPlayEndVideo.flag = nil
      self.__isPlayingVideo = false
    end)
    if couldPlay then
      self.__isPlayingVideo = true
      while self.__isPlayingVideo do
        coroutine.yield(nil)
      end
      local sectorId = self.needPlayEndVideo.sectorId - 1
      local unlockSectorId = self.needPlayEndVideo.sectorId
      self:ShowUnlockSectorEffect(unlockSectorId, nil, true)
    end
  end
end

function MainSectorCtrl:TryPlayUnlockAnim()
  if not GuideManager.inGuide and self.needPlayEndVideo ~= nil and self.needPlayEndVideo.Animaflag then
    self:ShowUnlockSectorEffect(self.needPlayEndVideo.sectorId)
    UIManager:ShowWindow(UIWindowTypeID.MovieBlack)
  end
end

function MainSectorCtrl:EnterMainSector(from, lastSatgeData)
  self:_OnEnterMainSectorScene()
end

function MainSectorCtrl:ResetToNormalState(toHome, needFocus)
  self.sctCtrl:SetSctState(eSectorState.Normal)
  self.sctSceneUI:Show()
  local sectorUI = UIManager:GetWindow(UIWindowTypeID.SectorEntrance)
  local completeIntro = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_CompleteIntro)
  if completeIntro and sectorUI ~= nil and not sectorUI.active then
    sectorUI:Show()
  end
  if needFocus then
    self:DetectedGeneralDungeonUnlock()
  end
  if toHome or JumpManager:GetIsJumping() or self.__isPlayingUnlockAnima or self.__isPlayingVideo or GuideManager:TryTriggerGuide(eGuideCondition.InSectorSceneNormal) then
  end
end

function MainSectorCtrl:OnSectorItemClicked(sectorId, difficuty, stageCfg)
  if self.sctCtrl:IsDisableClick() and not JumpManager:GetIsJumping() then
    return
  end
  PlayerDataCenter.sectorEntranceHandler:EnterSctChapter(sectorId, difficuty, stageCfg)
end

function MainSectorCtrl:EnterSectorLevelWin(sectorId, difficuty, stageCfg, extraCloseFunc, enterOverCallback)
  UIManager:ShowWindowAsync(UIWindowTypeID.SectorLevel, function(window)
    if window == nil then
      return
    end
    if ConfigData.sector_sector_resident.sectorId2ChapterIdMap[sectorId] ~= nil then
      self.sctCtrl:SetSctState(eSectorState.SelectMainSectorLevel)
    end
    if extraCloseFunc == nil then
      window:InitSectorLevel(sectorId, self.__ResetToNormalState, difficuty, stageCfg, self.__isPlayingVideo or self.__isPlayingUnlockAnima)
    else
      window:InitSectorLevel(sectorId, extraCloseFunc, difficuty, stageCfg, self.__isPlayingVideo or self.__isPlayingUnlockAnima)
    end
    self:RecordSelectModelDataLocaly(sectorId * 10)
    if enterOverCallback ~= nil then
      enterOverCallback()
    end
  end)
end

function MainSectorCtrl:_InitSectorItems()
  self.lastSectorId = nil
  local lastSectorPriority = 0
  self.needPlayEndVideo = {
    sectorId = nil,
    chapterId = nil,
    flag = nil,
    Animaflag = nil
  }
  local nowUnlockChapterId = 0
  local nowUnlockChapterPriority = 0
  local nowUnlockSectorId = 0
  local curSectorMapId = self.sctCtrl:GetSctCurMapId()
  self._chaptDataDic = {}
  self._sctChaptDataDic = {}
  local sctChapterIdList = ConfigData.sector_sector_resident.sectorMapChapterDic[curSectorMapId]
  for k, chaptId in ipairs(sctChapterIdList) do
    if not CS.ClientConsts.IsAudit or chaptId ~= 6 then
      local chaptData = SectorChapterData.New(chaptId)
      local sectorId = chaptData:GetSctChaptSectorId()
      self._chaptDataDic[chaptId] = chaptData
      self._sctChaptDataDic[sectorId] = chaptData
      self:_TryCreateStcEntity(chaptData)
      local unFinish = PlayerDataCenter.allActivitySectorIData:IsUnfinishSectorI(sectorId)
      if not unFinish then
        if chaptData:IsSectorChapterUnlock() then
          local focusId = self:__GetSectorFocusId(sectorId)
          local focusCfg = ConfigData.sector_unlock_mention[focusId]
          if focusCfg ~= nil and lastSectorPriority < focusCfg.focus_priority then
            self.lastSectorId = sectorId
            lastSectorPriority = focusCfg.focus_priority
          end
        end
        if chaptData:IsSectorChapterUnlock(true) and not PlayerDataCenter.sectorStage:IsSectorChapterUnlockShow(chaptId) and ConfigData.sector[sectorId] and (ConfigData.sector[sectorId].sector_movie or ConfigData.sector[sectorId].show_anim) then
          local setCompleteChapterId
          local curChpPriority = chaptData:GetSctChaptShowPriority()
          if nowUnlockChapterPriority < curChpPriority or curChpPriority == nowUnlockChapterPriority and chaptId > nowUnlockChapterId then
            if 0 < nowUnlockChapterId then
              setCompleteChapterId = nowUnlockChapterId
            end
            nowUnlockChapterId = chaptId
            nowUnlockChapterPriority = curChpPriority
            nowUnlockSectorId = sectorId
          else
            setCompleteChapterId = chaptId
          end
          if setCompleteChapterId then
            SectorUtil.SectorChapterUnlockShowComplete(setCompleteChapterId)
          end
        end
      end
    end
  end
  self.sctSceneUI.sctChaptNode:InitSectorNode(self._sctChaptDataDic, curSectorMapId)
  local nowMaxUnlockSectorCfg = ConfigData.sector[nowUnlockSectorId]
  if nowMaxUnlockSectorCfg ~= nil then
    if nowMaxUnlockSectorCfg.sector_movie then
      self.needPlayEndVideo.sectorId = nowUnlockSectorId
      self.needPlayEndVideo.chapterId = nowUnlockChapterId
      self.needPlayEndVideo.flag = true
    elseif nowMaxUnlockSectorCfg.show_anim then
      self.needPlayEndVideo.sectorId = nowUnlockSectorId
      self.needPlayEndVideo.chapterId = nowUnlockChapterId
      self.needPlayEndVideo.Animaflag = true
      local sctItemEntity = self.sctItemDic[nowUnlockSectorId]
      if sctItemEntity then
        sctItemEntity:SetEmissiveNum(0)
      end
      local chaptItem = self.sctSceneUI.sctChaptNode:GetSctChaptItemBySectorId(nowUnlockSectorId)
      if chaptItem then
        chaptItem:SetSctChaptItemAlpha(0)
      end
    end
  end
  if curSectorMapId == 1 then
    self.sctSceneUI:CreateNewBeeSectorItem(SectorEnum.NewbeeSectorId, self.__onClickSectorItem)
  end
  if self.lastSectorId == nil then
    if curSectorMapId == 1 then
      self.lastSectorId = SectorEnum.NewbeeSectorId
    else
      local chaptId = sctChapterIdList[1]
      local chaptData = self._chaptDataDic[chaptId]
      self.lastSectorId = chaptData:GetSctChaptSectorId()
    end
  end
  local homeCtrl = ControllerManager:GetController(ControllerTypeId.HomeController)
  if homeCtrl ~= nil then
    homeCtrl:UnloadMainBg()
  end
end

function MainSectorCtrl:_TryCreateStcEntity(chaptData)
  local name = chaptData:GetSctChaptGoName()
  if string.IsNullOrEmpty(name) then
    return
  end
  local path = "Scene/Root/" .. name
  local go = cs_GameObject.Find(path)
  if IsNull(go) then
    error("Cant get GameObject : " .. path)
    return
  end
  local sectorId = chaptData:GetSctChaptSectorId()
  local sctItemEntity = SectorItemEntity.New()
  sctItemEntity:InitSectorItemEntity(go, chaptData)
  self.sctItemDic[sectorId] = sctItemEntity
  return true
end

function MainSectorCtrl:RecordSelectModelDataLocaly(sectorId)
  if self.localModelData == nil then
    self.localModelData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  end
  if self.localModelData ~= nil then
    self.localModelData:RecordLastSectorSelected(sectorId)
  end
end

function MainSectorCtrl:OnMainSctBtnHomeClicked()
  if not self.sctCtrl:ExitSectorCtrl() then
    return false
  end
  AudioManager:PlayAudioById(1017)
  if self.sectorToHomeGo ~= nil then
    self.sectorToHomeGo:SetActive(true)
    self.homeToSectorGo:SetActive(false)
  end
  TimelineUtil.Play(self.sctCtrl.camCtrl:GetSctCamPdSector2Home(), function()
    self:_OnSectorToHomeDirectorStopped()
  end)
end

function MainSectorCtrl:_PlayHome2SectorTl()
  UIUtil.AddOneCover("homeToSectorDirector")
  TimelineUtil.Play(self.sctCtrl.camCtrl:GetSctCamPdHome2Sector(), function()
    self:_OnHomeToSectorDirectorStopped()
    UIUtil.CloseOneCover("homeToSectorDirector")
  end)
end

function MainSectorCtrl:_OnHomeToSectorDirectorStopped()
  if self.sctCtrl:IsSctState(eSectorState.None) then
    if self.__sectorFromArg == nil and not self:IsHave2PlayUnlockSectorShow() then
      self:ResetToNormalState()
    else
      self.sctCtrl:SetSctState(eSectorState.Normal)
    end
  end
end

function MainSectorCtrl:EnbleSectorUI3D(enable)
  if self.sctSceneUI ~= nil then
    if enable then
      self.sctSceneUI:Show()
    else
      self.sctSceneUI:Hide()
    end
  end
end

function MainSectorCtrl:ShowUnlockSectorEffect(sectorId, finishCallback, isLeftSector)
  self.__isPlayingVideo = false
  self.__isPlayingUnlockAnima = true
  UIUtil.ReturnUntil2Marker(UIWindowTypeID.SectorEntrance)
  self._forceFocusId = self:__GetSectorFocusId(sectorId)
  self.sctCtrl.camCtrl:SetForceFocus(self._forceFocusId)
  SectorUtil.SectorChapterUnlockShowComplete(self.needPlayEndVideo.chapterId)
  local sectorWindow = UIManager:GetWindow(UIWindowTypeID.SectorEntrance)
  local doTweenSequence = cs_DoTween.Sequence()
  doTweenSequence:AppendCallback(function()
    UIUtil.AddOneCover("sectorUnlockAnima")
    UIUtil.HideTopStatus()
    if sectorWindow ~= nil then
      sectorWindow:Hide()
    end
  end)
  doTweenSequence:AppendInterval(0.5)
  local sctItemEntity = self.sctItemDic[sectorId]
  if sctItemEntity then
    sctItemEntity:SctItemEnttUnlockTween(doTweenSequence)
  end
  local chaptItem = self.sctSceneUI.sctChaptNode:GetSctChaptItemBySectorId(sectorId)
  if chaptItem then
    chaptItem:SetSctChaptItemShowTween(doTweenSequence)
  end
  doTweenSequence:AppendInterval(1)
  doTweenSequence:AppendCallback(function()
    UIUtil.ReShowTopStatus()
    if sectorWindow ~= nil then
      sectorWindow:Show()
    end
    
    local function CloseFunc()
      if self.__afterUnlockSectorShowCallback ~= nil then
        self.__afterUnlockSectorShowCallback()
      end
      self.__isPlayingVideo = nil
      self.__isPlayingUnlockAnima = nil
      if not isLeftSector then
        self:ResetToNormalState()
      end
      if finishCallback ~= nil then
        finishCallback()
      end
      UIUtil.CloseOneCover("sectorUnlockAnima")
      NoticeManager:ContinueShowNotice("sector")
      self._forceFocusId = nil
    end
    
    self.needPlayEndVideo.Animaflag = false
    local win = UIManager:GetWindow(UIWindowTypeID.MovieBlack)
    if win ~= nil then
      win:SlowClose(1, function()
        CloseFunc()
      end)
    else
      CloseFunc()
    end
  end)
  doTweenSequence:SetAutoKill(true)
end

function MainSectorCtrl:IsHave2PlayUnlockSectorShow()
  return self.needPlayEndVideo ~= nil and (self.needPlayEndVideo.Animaflag or self.needPlayEndVideo.flag)
end

function MainSectorCtrl:SetAfterUnlockSectorShowCallback(callback)
  self.__afterUnlockSectorShowCallback = callback
end

function MainSectorCtrl:DetectedGeneralSector(sectorId)
  local forceFocusId = self:__GetSectorFocusId(sectorId)
  self.sctCtrl.camCtrl:SetForceFocus(forceFocusId)
end

function MainSectorCtrl:DetectedGeneralDungeonUnlock()
  local lastSectorId = self:__GetSectorFocusId(self.lastSectorId)
  if self._forceFocusId == nil then
    lastSectorId = self:FocusSectorAndMentioned(lastSectorId)
  else
    lastSectorId = self._forceFocusId
  end
  self.sctCtrl.camCtrl:SetForceFocus(lastSectorId)
  return lastSectorId
end

function MainSectorCtrl:FocusSectorAndMentioned(sectorMentionId)
  local focusMetionList = ConfigData.sector_unlock_mention
  local remoteLastSectorMentionId = PlayerDataCenter:GetLastRemoteSectorMentionId()
  local remoteFocus = 0
  if focusMetionList[remoteLastSectorMentionId] ~= nil then
    remoteFocus = focusMetionList[remoteLastSectorMentionId].focus_priority
  end
  if focusMetionList[sectorMentionId] ~= nil and remoteFocus < focusMetionList[sectorMentionId].focus_priority then
    self:RecordSelectModelDataLocaly(sectorMentionId)
    local completeRecord = BindCallback(self, function(table, id)
      PlayerDataCenter:RecordLastRemoteSectorMentionId(id)
    end, sectorMentionId)
    NetworkManager:GetNetwork(NetworkTypeID.Object):CS_User_ClientLastSectorMention(sectorMentionId, completeRecord)
    return sectorMentionId
  end
  if self.localModelData == nil then
    self.localModelData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
    if self.localModelData == nil then
      return sectorMentionId
    end
  end
  local localSectorMentionId = self.localModelData:GetLastLocalSectorMentionId()
  if localSectorMentionId ~= nil and 0 < localSectorMentionId and focusMetionList[sectorMentionId] ~= nil then
    local sectorId = self:GetSectorIdByFocusId(localSectorMentionId)
    if self._sctChaptDataDic[sectorId] ~= nil or self.sctCtrl:GetSctCurMapId() == 1 and sectorId == SectorEnum.NewbeeSectorId then
      return localSectorMentionId
    end
  end
  return sectorMentionId
end

function MainSectorCtrl:GetSctChapterDataDic()
  return self._sctChaptDataDic
end

function MainSectorCtrl:__GetSectorFocusId(sectorId)
  return sectorId * 10
end

function MainSectorCtrl:GetSectorIdByFocusId(focusId)
  return focusId / 10
end

function MainSectorCtrl:GetMainSctSceneUI()
  return self.sctSceneUI
end

function MainSectorCtrl:ExitMainSector()
  self.sctCtrl.camCtrl:OnSctCamExitScene()
  if self.sctSceneUI ~= nil then
    self.sctSceneUI:Delete()
    self.sctSceneUI = nil
  end
  UIUtil.PopFromBackStackByUiTab(self)
end

function MainSectorCtrl:OnDelete()
  self:ExitMainSector()
end

return MainSectorCtrl
