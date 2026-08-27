local UISectorLevel = class("UISectorLevel", UIBaseWindow)
local base = UIBaseWindow
local ActivityFrameEnum = require("Game.ActivityFrame.ActivityFrameEnum")
local SectorLevelDetailEnum = require("Game.Sector.Enum.SectorLevelDetailEnum")
local UINDifficultList = require("Game.Sector.SectorLevel.UINDifficultList")
local UINSectorInfoNormal = require("Game.Sector.SectorLevel.UINSectorInfoNormal")
local UINSectoroInfoCharDun = require("Game.Sector.SectorLevel.UINSectoroInfoCharDun")
local SectorStageDetailHelper = require("Game.Sector.SectorStageDetailHelper")
local cs_MessageCommon = CS.MessageCommon
local cs_ResLoader = CS.ResLoader

function UISectorLevel:OnInit()
  self.resLoader = cs_ResLoader.Create()
  self.__onLevelItemClicked = BindCallback(self, self.OnLevelItemClicked)
  self.__onLevelAvgMainClicked = BindCallback(self, self.OnLevelAvgMainItemClicked)
  self.__onLevelAvgSubClickEvent = BindCallback(self, self.OnLevelAvgSubClicked)
  self.__OnDungeonItemClicked = BindCallback(self, self.OnDungeonItemClicked)
  self.__OnSelectDiffCallback = BindCallback(self, self.OnSelectDifficulty)
  self.difficultListNode = UINDifficultList.New()
  self.difficultListNode:Init(self.ui.difficultList)
  self.__onHasUncompletedEp = BindCallback(self, self.UpdateUncompletedEp)
  MsgCenter:AddListener(eMsgEventId.OnHasUncompletedEp, self.__onHasUncompletedEp)
  self.__onAVGCtrlPlayEnd = BindCallback(self, self.OnAVGCtrlPlayEnd)
  MsgCenter:AddListener(eMsgEventId.AVGCtrlPlayEnd, self.__onAVGCtrlPlayEnd)
  self.__onMainAvgStateChange = BindCallback(self, self.OnMainAvgStateChange)
  MsgCenter:AddListener(eMsgEventId.OnMainAvgStateChange, self.__onMainAvgStateChange)
  AudioManager:PlayAudioById(1073)
end

function UISectorLevel:InitSectorLevel(sectorId, closeAction, autoDifficulty, autoStageCfg, isPlayingUnlock, from)
  local playMoudle = SectorStageDetailHelper.SectorPlayMoudle(sectorId)
  self.__lastEpStateCfg = SectorStageDetailHelper.TryGetUncompletedStateCfg(playMoudle)
  local userDataCache = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  local guideTipId = ConfigData.game_config.guideTipLevelIcon
  UIUtil.SetTopStatus(self, self.OnClickBackBtn, nil, function()
    if not userDataCache:IsGuidPicLooked(guideTipId) then
      userDataCache:RecordGuidPicLooked(guideTipId)
      UIUtil.SetTopStateInfoBuledot(false)
    end
    local GuidePicture = require("Game.Guide.GuidePicture.GuidePicture")
    GuidePicture.OpenGuidePicture(guideTipId, nil)
  end)
  UIUtil.SetTopStateInfoBuledot(not userDataCache:IsGuidPicLooked(guideTipId))
  self.__sectorId = sectorId
  self.sectorCfg = ConfigData.sector[self.__sectorId]
  self.__closeAction = closeAction
  if PlayerDataCenter.sectorStage:GetSelectSectorId() ~= sectorId then
    PlayerDataCenter.sectorStage:SetSelectSectorId(sectorId)
  end
  if autoDifficulty ~= nil and PlayerDataCenter.sectorStage:GetSelectDifficult(sectorId) ~= autoDifficulty then
    PlayerDataCenter.sectorStage:SetSelectDifficult(autoDifficulty)
  end
  local lastDifficulty = self.__lastEpStateCfg == nil and autoDifficulty ~= nil and autoDifficulty or PlayerDataCenter.sectorStage:GetSelectDifficult(sectorId)
  self:__InitSectorBaseInfo(lastDifficulty)
  local isUnCompleteEp = false
  if self.__lastEpStateCfg ~= nil then
    autoStageCfg = self.__lastEpStateCfg
    isUnCompleteEp = true
  end
  self.difficultListNode:PreSetSectorSpecialState(self.levelState)
  self.difficultListNode:PreSetSectorSpecialLevelList(self.specialLevelList)
  self.difficultListNode:InitDifficeltLevel(self.resLoader, sectorId, autoStageCfg, isUnCompleteEp, self.__onLevelItemClicked, self.__onLevelAvgMainClicked, self.__onLevelAvgSubClickEvent, BindCallback(self, self.__ClickLevelListBgFunc))
  if self.sectorCfg.sector_level_perform and from ~= AreaConst.Exploration and not self:_CheckSectorInActivityNotShowAniMode(sectorId) then
    UIManager:ShowWindowAsync(UIWindowTypeID.AniModeChange, function(win)
      if win == nil then
        return
      end
      win:ShowAniModeChangeSectorLvDiff(lastDifficulty)
    end)
  end
  if not isPlayingUnlock then
    self:__TryTriggerSectorLevelGuide()
  end
  local avgPlayCtrl = ControllerManager:GetController(ControllerTypeId.AvgPlay)
  avgPlayCtrl:TryPlayTaskAvg(4, nil)
  self.__customEnterFmtCallback = nil
end

function UISectorLevel:_CheckSectorInActivityNotShowAniMode(sectorId)
  if sectorId == 6 then
    local actId, data, inRuning = PlayerDataCenter.allActivitySectorIData:GetDataBySectorIdRunning(sectorId)
    return inRuning
  end
  return false
end

function UISectorLevel:SetCustomEnterFmtCallback(callback)
  self.__customEnterFmtCallback = callback
  local window = UIManager:GetWindow(UIWindowTypeID.SectorLevelDetail)
  if window ~= nil then
    window:SetDetailCustomEnterFmtCallback(self.__customEnterFmtCallback)
  end
end

function UISectorLevel:SetCustomExBattleStartCallback(callback)
  self.__customExBattleStartCallback = callback
  local window = UIManager:GetWindow(UIWindowTypeID.SectorLevelDetail)
  if window ~= nil then
    window:SetDetailExBattleStartCallback(self.__customExBattleStartCallback)
  end
end

function UISectorLevel:SetSelectCanEnterCallback(callback)
  self.__selectCanEnterCallback = callback
  local window = UIManager:GetWindow(UIWindowTypeID.SectorLevelDetail)
  if window ~= nil then
    window:SetDetailSelectCanEnterCallback(self.__selectCanEnterCallback)
  end
end

function UISectorLevel:__TryTriggerSectorLevelGuide()
  if GuideManager:TryTriggerGuide(eGuideCondition.FInSectorLevel) then
  end
  if GuideManager:TryTriggerGuide(eGuideCondition.InSectorLevel) then
  end
end

function UISectorLevel:__InitSectorBaseInfo(lastDifficulty)
  self.ui.sectorInfo:SetActive(false)
  local _, _, inTime = PlayerDataCenter.allActivitySectorIData:GetDataBySectorId(self.__sectorId)
  if inTime then
    return
  end
  local actType, actId, actFrameData = PlayerDataCenter.sectorEntranceHandler:GetActivityDataBySectorId(self.__sectorId)
  if actType == ActivityFrameEnum.eActivityType.HeroGrow then
    local actData
    local heroGrowCtrl = ControllerManager:GetController(ControllerTypeId.ActivityHeroGrow)
    if heroGrowCtrl ~= nil then
      actData = heroGrowCtrl:GetHeroGrowActivity(actId)
    end
    self.ui.sectorInfo:SetActive(true)
    if self.charDunSectorInfoNode == nil then
      local prefab = self.resLoader:LoadABAsset(PathConsts:GetUIPrefabPath("UI_CharDunSectorInfo"))
      local go = prefab:Instantiate(self.ui.sectorInfo.transform)
      self.charDunSectorInfoNode = UINSectoroInfoCharDun.New()
      self.charDunSectorInfoNode:Init(go)
    end
    local OnChangeLevelDifficulty = BindCallback(self, self.ChangeSectorDifficulty)
    self.charDunSectorInfoNode:UpdateSectoroInfoCharDun(self.sectorCfg, actData, OnChangeLevelDifficulty)
    if actData ~= nil then
      local dungeonlevelDic = actData:GetHeroGrowDungeonDic()
      if dungeonlevelDic ~= nil then
        local mainSectorId = actData:GetHeroGrowCfg().main_stage
        self.difficultListNode:PreSetSectorExtraDungeon(mainSectorId, dungeonlevelDic, BindCallback(self, self.OnDungeonItemClicked), BindCallback(actData, actData.GetHeroGrowDungeonBattle))
      end
    end
    return
  elseif actType == ActivityFrameEnum.eActivityType.Carnival then
    self.ui.sectorInfo:SetActive(true)
    if self.normalSectorInfoNode == nil then
      local prefab = self.resLoader:LoadABAsset(PathConsts:GetUIPrefabPath("UI_NormalSectorInfo"))
      local go = prefab:Instantiate(self.ui.sectorInfo.transform)
      self.normalSectorInfoNode = UINSectorInfoNormal.New()
      self.normalSectorInfoNode:Init(go)
    end
    self.normalSectorInfoNode:UpdateSectorInfoNormal(self.sectorCfg, lastDifficulty, self.__OnSelectDiffCallback)
    self.normalSectorInfoNode:HideDiffSelect()
    return
  end
  if self.sectorCfg.is_special then
    return
  end
  self.ui.sectorInfo:SetActive(true)
  if self.normalSectorInfoNode == nil then
    local prefab = self.resLoader:LoadABAsset(PathConsts:GetUIPrefabPath("UI_NormalSectorInfo"))
    local go = prefab:Instantiate(self.ui.sectorInfo.transform)
    self.normalSectorInfoNode = UINSectorInfoNormal.New()
    self.normalSectorInfoNode:Init(go)
  end
  self.normalSectorInfoNode:UpdateSectorInfoNormal(self.sectorCfg, lastDifficulty, self.__OnSelectDiffCallback)
end

function UISectorLevel:SctLVShowSectorName(isShowSelect, changePos)
  self.ui.sectorInfo:SetActive(true)
  if self.normalSectorInfoNode == nil then
    local prefab = self.resLoader:LoadABAsset(PathConsts:GetUIPrefabPath("UI_NormalSectorInfo"))
    local go = prefab:Instantiate(self.ui.sectorInfo.transform)
    self.normalSectorInfoNode = UINSectorInfoNormal.New()
    self.normalSectorInfoNode:Init(go)
  end
  if isShowSelect then
    local lastDifficulty = PlayerDataCenter.sectorStage:GetSelectDifficult(self.__sectorId)
    self.normalSectorInfoNode:UpdateSectorInfoNormal(self.sectorCfg, lastDifficulty, self.__OnSelectDiffCallback, changePos)
    return
  end
  self.normalSectorInfoNode:UpdateSectorInfoNormal(self.sectorCfg)
end

function UISectorLevel:SetSpecialState(state)
  self.levelState = state
end

function UISectorLevel:SetSpecialLevelList(specialLevelList)
  self.specialLevelList = specialLevelList
end

function UISectorLevel:ChangeSectorDifficulty(diffculty, sectorId)
  self.__sectorId = sectorId
  self.__difficulty = diffculty
  local playMoudle = SectorStageDetailHelper.SectorPlayMoudle(sectorId)
  self.__lastEpStateCfg = SectorStageDetailHelper.TryGetUncompletedStateCfg(playMoudle)
  self.difficultListNode:PreSetSectorSpecialState(self.levelState)
  self.difficultListNode:PreSetSectorSpecialLevelList(self.specialLevelList)
  self.difficultListNode:ChangeLevelDifficulty(diffculty, sectorId)
end

function UISectorLevel:OnLevelItemClicked(levelItem)
  local stageCfg = levelItem:GetLevelStageData()
  local isLocked
  if not levelItem:IsLevelUnlock() then
    local unLockInfo = PlayerDataCenter.sectorStage:GetGetUnlockInfo(stageCfg.id)
    cs_MessageCommon.ShowMessageTipsWithErrorSound(unLockInfo)
    isLocked = true
  end
  local actId, flag, canClick = PlayerDataCenter.allActivitySectorIData:IsSecorIRechallengeStage(stageCfg.id)
  if actId ~= nil and flag and not canClick then
    cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(7008))
    return
  end
  local heroGrowCtrl = ControllerManager:GetController(ControllerTypeId.ActivityHeroGrow)
  if heroGrowCtrl ~= nil then
    local actId, isChange, canFight = heroGrowCtrl:IsHeroGrowChallengeStage(stageCfg.id)
    if actId ~= nil and isChange then
      if not canFight then
        cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(7008))
        return
      end
      local data = heroGrowCtrl:GetHeroGrowActivity(actId)
      if data == nil or data:IsHeroGrowLimiTimes() and data:GetHeroGrowChallengeCount() <= 0 then
        cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(7008))
        return
      end
    end
  end
  if self.__lastEpStateCfg ~= nil and self.__lastEpStateCfg.num ~= stageCfg.num then
    local playmoudle = SectorStageDetailHelper.SectorPlayMoudle(self.__sectorId)
    SectorStageDetailHelper.TryToShowCurrentLevelTips(playmoudle)
    return
  end
  local lastSelectLevelItem = self.difficultListNode:GetSectorStageItem(self.selectLevelId)
  if lastSelectLevelItem ~= nil then
    lastSelectLevelItem:SeletedLevelItem(false, true)
    self.selectLevelId = nil
  end
  local selectLAvgMain = self.difficultListNode:GetSectorLAvgMainItem(self.selectLAvgMainId)
  if selectLAvgMain ~= nil then
    selectLAvgMain:SelectedLAvgMain(false)
    self.selectLAvgMainId = nil
  end
  self.selectLevelId = stageCfg.id
  levelItem:SeletedLevelItem(true, true)
  UIUtil.AddOneCover("InitSectorLevelDetail")
  self:ShowLevelDetailWindow(function(window)
    window:InitSectorLevelDetail(stageCfg.sector, stageCfg.id, isLocked)
    UIUtil.CloseOneCover("InitSectorLevelDetail")
  end)
end

function UISectorLevel:ShowLevelDetailWindow(callback)
  local function openFunc()
    UIManager:ShowWindowAsync(UIWindowTypeID.SectorLevelDetail, function(window)
      window:SetLevelDetaiHideStartEvent(function()
        self.difficultListNode:PlayMoveLeftTween(false)
        
        local selectLevelItem = self.difficultListNode:GetSectorStageItem(self.selectLevelId)
        if selectLevelItem ~= nil then
          selectLevelItem:SeletedLevelItem(false, true)
          self.selectLevelId = nil
        end
        local selectAvgItem = self.difficultListNode:GetSectorLAvgMainItem(self.selectLAvgMainId)
        if selectAvgItem ~= nil then
          selectAvgItem:SelectedLAvgMain(false)
          self.selectLAvgMainId = nil
        end
      end)
      window:SetLevelDetaiHideEndEvent(function()
        if self._delayopenFunc ~= nil then
          self._delayopenFunc()
          self._delayopenFunc = nil
        end
        if not self.__waitChangeDifficulty then
          return
        end
        self.__waitChangeDifficulty = false
        self.difficultListNode:ChangeLevelDifficulty(self.__difficulty)
      end)
      window:SetDetailCustomEnterFmtCallback(self.__customEnterFmtCallback)
      window:SetDetailExBattleStartCallback(self.__customExBattleStartCallback)
      window:SetDetailSelectCanEnterCallback(self.__selectCanEnterCallback)
      local width, duration = window:GetLevelDetailWidthAndDuration()
      self.difficultListNode:PlayMoveLeftTween(true, width, duration)
      self.levelDetailWindow = window
      callback(window)
    end)
  end
  
  if self.dungeonLevelDetail ~= nil and self.dungeonLevelDetail.active then
    UIUtil.OnClickBackByWinId(UIWindowTypeID.DungeonLevelDetail)
    self._delayopenFunc = openFunc
  else
    openFunc()
  end
end

function UISectorLevel:OnDungeonItemClicked(levelDungeonItem)
  local function openFunc()
    UIUtil.AddOneCover("InitSectorLevelDetail")
    
    local dungeonLevelData = levelDungeonItem:GetSectorLevelDungeon()
    UIManager:ShowWindowAsync(UIWindowTypeID.DungeonLevelDetail, function(window)
      if window == nil then
        return
      end
      window:SetDunLevelDetaiHideStartEvent(function()
        self.difficultListNode:PlayMoveLongLeftTween(false)
        local selectLevelItem = self.difficultListNode:GetSectorDungeonItem(self.selectLevelId)
        if selectLevelItem ~= nil then
          selectLevelItem:SetLevelDungonSelect(false, true)
        end
      end)
      window:SetDunLevelDetaiHideEndEvent(function()
        if self._delayopenFunc ~= nil then
          self._delayopenFunc()
          self._delayopenFunc = nil
        end
        if not self.__waitChangeDifficulty then
          return
        end
        self.__waitChangeDifficulty = false
        self.difficultListNode:ChangeLevelDifficulty(self.__difficulty)
      end)
      local width, duration = window:GetDLevelDetailWidthAndDuration()
      self.difficultListNode:PlayMoveLongLeftTween(true, width, duration)
      window:InitDungeonLevelDetail(dungeonLevelData, not dungeonLevelData:GetIsLevelUnlock())
      UIUtil.CloseOneCover("InitSectorLevelDetail")
      self.dungeonLevelDetail = window
    end)
  end
  
  if self.levelDetailWindow ~= nil and self.levelDetailWindow.active then
    UIUtil.OnClickBackByWinId(UIWindowTypeID.SectorLevelDetail)
    self._delayopenFunc = openFunc
  else
    openFunc()
  end
end

function UISectorLevel:LocationSectorStageItem(stageId, isAvg)
  local item = self.difficultListNode:LocationSectorStageItem(stageId, isAvg)
  if item == nil then
    return
  end
  if isAvg then
    self:OnLevelAvgMainItemClicked(item)
  else
    self:OnLevelItemClicked(item)
  end
end

function UISectorLevel:OnLevelAvgMainItemClicked(lAvgMainItem)
  local avgCfg = lAvgMainItem:GetLAvgMainCfg()
  local isLocked
  if not lAvgMainItem:IsLAvgMainUnlock() then
    local lockTip = CheckCondition.GetUnlockInfoLua(avgCfg.pre_condition, avgCfg.pre_para1, avgCfg.pre_para2)
    cs_MessageCommon.ShowMessageTipsWithErrorSound(lockTip)
    isLocked = true
  end
  local selectLevelItem = self.difficultListNode:GetSectorStageItem(self.selectLevelId)
  if selectLevelItem ~= nil then
    selectLevelItem:SeletedLevelItem(false, true)
    self.selectLevelId = nil
  end
  local selectLAvgMain = self.difficultListNode:GetSectorLAvgMainItem(self.selectLAvgMainId)
  if selectLAvgMain ~= nil then
    selectLAvgMain:SelectedLAvgMain(false)
    self.selectLAvgMainId = nil
  end
  self.selectLAvgMainId = avgCfg.id
  lAvgMainItem:SelectedLAvgMain(true)
  self:ShowLevelDetailWindow(function(window)
    window:InitSectorLevelAvgDetail(self.__sectorId, avgCfg, function()
      self.difficultListNode:LocationSectorStageItem(avgCfg.id, true)
    end, isLocked)
  end)
end

function UISectorLevel:OnLevelAvgSubClicked(lAvgSubItem)
  local avgCfg = lAvgSubItem:GetLAvgSubCfg()
  local avgPlayCtrl = ControllerManager:GetController(ControllerTypeId.AvgPlay)
  if not avgPlayCtrl:IsAvgUnlock(avgCfg.id) then
    error("Avg is not unlock,avgId = " .. avgCfg.id)
    return
  end
  local selectLevelItem = self.difficultListNode:GetSectorStageItem(self.selectLevelId)
  if selectLevelItem ~= nil then
    selectLevelItem:SeletedLevelItem(false, true)
    self.selectLevelId = nil
  end
  local selectLAvgMain = self.difficultListNode:GetSectorLAvgMainItem(self.selectLAvgMainId)
  if selectLAvgMain ~= nil then
    selectLAvgMain:SelectedLAvgMain(false)
    self.selectLAvgMainId = nil
  end
  self:ShowLevelDetailWindow(function(window)
    window:InitSectorLevelAvgDetail(self.__sectorId, avgCfg, function()
      lAvgSubItem:RefreshLAvgSubPlayed()
      self.difficultListNode:LocationSectorStageItem(avgCfg.id, true)
    end)
  end)
end

function UISectorLevel:OnMainAvgStateChange(sectorId, difficulty, avgId)
  self.difficultListNode:RefreshCurDiffLevelState()
end

function UISectorLevel:UpdateUncompletedEp()
  local playMoudle = SectorStageDetailHelper.SectorPlayMoudle(self.__sectorId)
  self.__lastEpStateCfg = SectorStageDetailHelper.TryGetUncompletedStateCfg(playMoudle)
  self.difficultListNode:RefreshUncompletedEp(self.__lastEpStateCfg)
  self.difficultListNode:RefreshCurDiffLevelState()
end

function UISectorLevel:OnSelectDifficulty(difficulty)
  if PlayerDataCenter.sectorStage:GetSelectDifficult(self.__sectorId) == difficulty then
    return false
  end
  self.__difficulty = difficulty
  if self.levelDetailWindow ~= nil and self.levelDetailWindow.active then
    self.levelDetailWindow:OnClickSectorLevelDetailBackBtn()
    self.__waitChangeDifficulty = true
  else
    self.difficultListNode:ChangeLevelDifficulty(difficulty)
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.AniModeChange, function(win)
    if win == nil then
      return
    end
    AudioManager:PlayAudioById(1073)
    win:ShowAniModeChangeSectorLvDiff(difficulty)
  end)
  return true
end

function UISectorLevel:GetSectorInfoNode()
  return self.ui.sectorInfo
end

function UISectorLevel:GetDifficultListNode()
  return self.difficultListNode
end

function UISectorLevel:SetTaskTaskUnlock(bool)
end

function UISectorLevel:OnClickBackBtn(fromHome)
  self:Delete()
  if self.__closeAction ~= nil then
    self.__closeAction(fromHome, true)
  end
end

function UISectorLevel:__ClickLevelListBgFunc()
  if self.levelDetailWindow ~= nil and self.levelDetailWindow.active then
    UIUtil.OnClickBackByWinId(UIWindowTypeID.SectorLevelDetail)
  elseif self.dungeonLevelDetail ~= nil and self.dungeonLevelDetail.active then
    UIUtil.OnClickBackByWinId(UIWindowTypeID.DungeonLevelDetail)
  end
end

function UISectorLevel:OnAVGCtrlPlayEnd()
  if GuideManager:TryTriggerGuide(eGuideCondition.InSectorLevel) then
  end
end

function UISectorLevel:GetSelectedStageId()
  return self.selectLevelId
end

function UISectorLevel:GetSelectedLAvgMainId()
  return self.selectLAvgMainId
end

function UISectorLevel:OnDelete()
  self.difficultListNode:Delete()
  if self.normalSectorInfoNode ~= nil then
    self.normalSectorInfoNode:Delete()
  end
  if self.charDunSectorInfoNode ~= nil then
    self.charDunSectorInfoNode:Delete()
  end
  MsgCenter:RemoveListener(eMsgEventId.AVGCtrlPlayEnd, self.__onAVGCtrlPlayEnd)
  MsgCenter:RemoveListener(eMsgEventId.OnHasUncompletedEp, self.__onHasUncompletedEp)
  MsgCenter:RemoveListener(eMsgEventId.OnMainAvgStateChange, self.__onMainAvgStateChange)
  UIManager:DeleteWindow(UIWindowTypeID.SectorLevelDetail)
  UIManager:DeleteWindow(UIWindowTypeID.AniModeChange)
  UIManager:DeleteWindow(UIWindowTypeID.DungeonLevelDetail)
  if self.SectorTaskController ~= nil then
    self.SectorTaskController:OnDelete()
    self.SectorTaskController = nil
  end
  self.resLoader:Put2Pool()
  self.resLoader = nil
  base.OnDelete(self)
end

return UISectorLevel
