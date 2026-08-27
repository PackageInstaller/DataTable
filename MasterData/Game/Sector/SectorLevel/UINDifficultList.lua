local UINDifficultList = class("UINDifficultList", UIBaseNode)
local base = UIBaseNode
local UINInfinityLevelCanvas = require("Game.Sector.SectorLevel.UINInfinityLevelCanvas")
local UINActSummerLvLeftInfo = require("Game.ActivitySummer.UI.UINActSummerLvLeftInfo")
local UINChapterButtonGroup = require("Game.Sector.SectorLevelChapter.UINSectorLevelChapterButtonGroup")
local SectorStageDetailHelper = require("Game.Sector.SectorStageDetailHelper")
local activityFrameEnum = require("Game.ActivityFrame.ActivityFrameEnum")
local LevelCanvasClassType = {
  [1] = {
    prefab = "UI_SectorLevelMap",
    CanvasClass = require("Game.Sector.SectorLevel.UINDiffLevelCanvas")
  },
  [2] = {
    prefab = "UI_ActSum21LvMap",
    CanvasClass = require("Game.ActivitySummer.UI.Sector.UINDiffLevelMulLineActSum21Canvas")
  },
  [3] = {
    prefab = "UI_CharDunMap",
    CanvasClass = require("Game.Sector.SectorLevel.UINCharDunLevelCanvas")
  },
  [4] = {
    prefab = "UI_SectorLevelMap",
    CanvasClass = require("Game.Sector.SectorLevel.UINDiffLevelCanvas")
  },
  [5] = {
    prefab = "UI_Winter23ChapterMap",
    CanvasClass = require("Game.ActivityWinter23.UI.Sector.UINDiffLevelMulLineActWinter23Canvas")
  },
  [6] = {
    prefab = "UI_Carnival23ChapterMap",
    CanvasClass = require("Game.ActivityWinter23.UI.Sector.UINDiffLevelMulLineActWinter23Canvas")
  },
  [7] = {
    prefab = "UI_Summer23ChapterMap",
    CanvasClass = require("Game.ActivityWinter23.UI.Sector.UINDiffLevelMulLineActWinter23Canvas")
  },
  [8] = {
    prefab = "UI_Summer24ChapterMap",
    CanvasClass = require("Game.ActivityWinter23.UI.Sector.UINDiffLevelMulLineActWinter23Canvas")
  },
  [9] = {
    prefab = "UI_Anniversary24ChapterMap",
    CanvasClass = require("Game.ActivityWinter23.UI.Sector.UINDiffLevelMulLineActWinter23Canvas")
  }
}
local CS_Edge = CS.UnityEngine.RectTransform.Edge
local cs_DoTween = CS.DG.Tweening.DOTween
local cs_UIMnager = CS.UIManager.Instance
local difficultyLvBgNameCfg = {
  [1] = "pic_big",
  [2] = "hard_pic",
  [ConfigData.sector_stage.difficultyCount + 1] = "endless_pic"
}

function UINDifficultList:OnInit()
  self.isShowingInfinity = false
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.__onChangeDiffComplete = BindCallback(self, self.OnChangeLevelDifficultyComplete)
  self.__sectorLevelTipsGuides = {}
  self.__OnMainAvgStateChange = BindCallback(self, self._OnMainAvgStateChange)
  self.__OnMainLevelStateChange = BindCallback(self, self._OnMainLevelStateChange)
  self.__OnListenSectorRunEnd = BindCallback(self, self.OnListenSectorRunEnd)
  MsgCenter:AddListener(eMsgEventId.SectorActivityRunEnd, self.__OnListenSectorRunEnd)
  self.__OnListenHeroGrowRunEnd = BindCallback(self, self.OnListenHeroGrowRunEnd)
  MsgCenter:AddListener(eMsgEventId.HeroGrowActivityRunEnd, self.__OnListenHeroGrowRunEnd)
  self._OnChallengeTaskCompleteFunc = BindCallback(self, self._OnChallengeTaskComplete)
  MsgCenter:AddListener(eMsgEventId.OnChallengeTaskComplete, self._OnChallengeTaskCompleteFunc)
end

function UINDifficultList:PreSetSectorExtraDungeon(sectorId, dungeonDataDic, clickDungeonItemEvent, blueReddotFunc)
  self._dungeonReplyOnSectorId = sectorId
  self._extradungeonDataDic = dungeonDataDic
  self._clickDungeonEvent = clickDungeonItemEvent
  self._dungeonBlueReddotFunc = blueReddotFunc
end

function UINDifficultList:PreSetSectorSpecialState(state)
  self.levelState = state
end

function UINDifficultList:PreSetSectorSpecialLevelList(specialLevelList)
  self.specialLevelList = specialLevelList
end

function UINDifficultList:InitDifficeltLevel(resLoader, sectorId, autoStateCfg, isUnCompleteEp, levelItemClickEvent, levelAvgMainClickEvent, lAvgSubClickEvent, clickBackFunc)
  self.resLoader = resLoader
  self.sectorId = sectorId
  if isUnCompleteEp then
    self.lastEpStateCfg = autoStateCfg
  else
    self.lastEpStateCfg = nil
  end
  self.levelItemClickEvent = levelItemClickEvent
  self.levelAvgMainClickEvent = levelAvgMainClickEvent
  self.lAvgSubClickEvent = lAvgSubClickEvent
  self.clickBackFunc = clickBackFunc
  self:CheckShowExtraMount()
  local lastSelectDiff
  if autoStateCfg ~= nil then
    lastSelectDiff = autoStateCfg.difficulty
  else
    lastSelectDiff = PlayerDataCenter.sectorStage:GetSelectDifficult(sectorId)
  end
  if lastSelectDiff == ConfigData.sector_stage.difficultyCount + 1 then
    self.infinityLevelCanvas = self:GetInfinityLevelCanvasItem()
    self.infinityLevelCanvas:InitInfinityLevelCanvas(sectorId, autoStateCfg, isUnCompleteEp, function()
      if self.diffLevelCanva ~= nil then
        self.diffLevelCanvas:Hide()
      end
    end, self.resLoader)
    self.isShowingInfinity = true
  else
    if self.diffLevelCanvas == nil then
      self.diffLevelCanvas = self:GetDiffLevelCanvasItem(lastSelectDiff)
    end
    self:CheckAndGenChapterData()
    self.diffLevelCanvas:SetBackground(self:GetBgTexture(lastSelectDiff))
    if self.diffLevelCanvas.SetSpecialLevelState then
      if lastSelectDiff == 1 then
        self.diffLevelCanvas:SetSpecialLevelState(self.levelState)
      else
        self.diffLevelCanvas:SetSpecialLevelState(nil)
      end
    end
    if self.specialLevelList then
      if lastSelectDiff == 1 then
        self.diffLevelCanvas:SetSpecialLevelList(self.specialLevelList)
      else
        self.diffLevelCanvas:SetSpecialLevelList(nil)
      end
    end
    self.diffLevelCanvas:InitDiffLevelCanvas(sectorId, autoStateCfg, isUnCompleteEp, lastSelectDiff, self.levelItemClickEvent, self.levelAvgMainClickEvent, self.lAvgSubClickEvent, self.__onChangeDiffComplete, self.resLoader, self.__sectorLevelTipsGuides, self.clickBackFunc)
    if sectorId == self._dungeonReplyOnSectorId then
      self.diffLevelCanvas:SetDungeonListInSector(self._extradungeonDataDic, self._clickDungeonEvent, self._dungeonBlueReddotFunc)
    end
  end
  MsgCenter:AddListener(eMsgEventId.OnMainLevelStateChange, self.__OnMainLevelStateChange)
  MsgCenter:AddListener(eMsgEventId.OnMainAvgStateChange, self.__OnMainAvgStateChange)
end

function UINDifficultList:_OnMainLevelStateChange(sectorId, difficulty, stageId)
  if sectorId == self.sectorId and difficulty == PlayerDataCenter.sectorStage:GetSelectDifficult(sectorId) then
    local show = PlayerDataCenter.sectorStage:IsStageUnlock(stageId) and not PlayerDataCenter.sectorStage:IsStageComplete(stageId)
    self.diffLevelCanvas:SetSectorStageItemBlueDot(stageId, show)
  end
end

function UINDifficultList:_OnMainAvgStateChange(sectorId, difficulty, avgId)
  if sectorId == self.sectorId and difficulty == PlayerDataCenter.sectorStage:GetSelectDifficult(sectorId) then
    local avgPlayCtrl = ControllerManager:GetController(ControllerTypeId.AvgPlay)
    local show = avgPlayCtrl:IsAvgUnlock(avgId) and not avgPlayCtrl:IsAvgPlayed(avgId)
    self.diffLevelCanvas:SetSectorLAvgMainItemBlueDot(avgId, show)
  end
end

function UINDifficultList:GetDiffLevelCanvasItem(difficulty)
  local sectorType = ConfigData.sector[self.sectorId].sector_type
  local DiffLevelClassCfg = LevelCanvasClassType[sectorType or 0]
  if DiffLevelClassCfg == nil then
    DiffLevelClassCfg = LevelCanvasClassType[1]
  end
  local prefab = self.resLoader:LoadABAsset(PathConsts:GetUIPrefabPath(DiffLevelClassCfg.prefab))
  local go = prefab:Instantiate()
  local rectTransform = go.transform
  rectTransform:SetParent(self.transform)
  rectTransform.localScale = Vector3.New(1, 1, 1)
  rectTransform:SetAsLastSibling()
  rectTransform.localPosition = Vector3.New(0, 0, 0)
  rectTransform.offsetMax = Vector2.New(0, 0)
  rectTransform.offsetMin = Vector2.New(0, 0)
  local item = DiffLevelClassCfg.CanvasClass.New()
  item:Init(go)
  self:ResetLevelCanvasSize(item)
  return item
end

function UINDifficultList:GetInfinityLevelCanvasItem()
  if self.infinityLevelCanvas ~= nil then
    return self.infinityLevelCanvas
  end
  local item
  local prefab = self.resLoader:LoadABAsset(PathConsts:GetUIPrefabPath("UI_SectorLevelInfinityMap"))
  local go = prefab:Instantiate()
  local rectTransform = go.transform
  rectTransform:SetParent(self.transform)
  rectTransform.localScale = Vector3.New(1, 1, 1)
  rectTransform:SetAsLastSibling()
  rectTransform.localPosition = Vector3.New(0, 0, 0)
  rectTransform.offsetMax = Vector2.New(0, 0)
  rectTransform.offsetMin = Vector2.New(0, 0)
  item = UINInfinityLevelCanvas.New()
  item:Init(go)
  local difficulty = ConfigData.sector_stage.difficultyCount + 1
  item:SetBackground(self:GetBgTexture(difficulty))
  return item
end

function UINDifficultList:GetBgTexture(difficulty)
  if self.bgTextureCacheDic == nil then
    self.bgTextureCacheDic = {}
  end
  local textureName
  if self.chapterData ~= nil then
    if self.levelState then
      textureName = self.chapterData.chapterCfg.chapterFarm_pic_big
    else
      textureName = self.chapterData.chapterCfg.chapter_pic_big
    end
  end
  if string.IsNullOrEmpty(textureName) then
    local sectorCfg = ConfigData.sector[self.sectorId]
    if sectorCfg == nil then
      return nil
    end
    local difficultyBgName = difficultyLvBgNameCfg[difficulty] or difficultyLvBgNameCfg[1]
    textureName = sectorCfg[difficultyBgName]
    if textureName == nil then
      return nil
    end
  end
  local bgTexture = self.bgTextureCacheDic[textureName]
  if bgTexture == nil then
    local path = PathConsts:GetSectorBackgroundPath(textureName)
    bgTexture = self.resLoader:LoadABAsset(path)
    self.bgTextureCacheDic[textureName] = bgTexture
  end
  return bgTexture
end

function UINDifficultList:ChangeLevelDifficulty(difficulty, sectorId)
  if self.diffLevelCanvas and self.diffLevelCanvas.SetSpecialLevelState and difficulty == 1 then
    self.diffLevelCanvas:SetSpecialLevelState(self.levelState)
  end
  local lastSelectDiff = PlayerDataCenter.sectorStage:GetSelectDifficult(self.sectorId)
  if self.extraMount and self.extraMount.ChangeDifficultTypeFunc then
    self.extraMount:ChangeDifficultTypeFunc(difficulty)
  end
  self:CheckAndGenChapterData()
  if self.diffLevelCanvas and lastSelectDiff == difficulty and sectorId == self.sectorId and self.specialLevelList then
    self.diffLevelCanvas:ResetLevelGroupDataBySpecialLevelList(self.specialLevelList)
    if self.diffLevelCanvas.PlayDiffLevelCanvasSwitchTween then
      if self.diffLevelCanvas.SetStopTweenCompleteEvent then
        self.diffLevelCanvas:SetStopTweenCompleteEvent(true)
      end
      self.diffLevelCanvas:PlayDiffLevelCanvasSwitchTween(false)
    end
    self.diffLevelCanvas:SetBackground(self:GetBgTexture(difficulty))
    return
  end
  if lastSelectDiff == difficulty and sectorId == self.sectorId then
    return
  end
  if sectorId ~= nil then
    self.sectorId = sectorId
    if PlayerDataCenter.sectorStage:GetSelectSectorId() ~= sectorId then
      PlayerDataCenter.sectorStage:SetSelectSectorId(sectorId)
    end
  end
  local isUpTween = difficulty > lastSelectDiff
  PlayerDataCenter.sectorStage:SetSelectDifficult(difficulty)
  if difficulty == ConfigData.sector_stage.difficultyCount + 1 then
    self.infinityLevelCanvas = self:GetInfinityLevelCanvasItem()
    self.infinityLevelCanvas:Show()
    self.infinityLevelCanvas:InitInfinityLevelCanvas(self.sectorId, self.lastEpStateCfg, true, function()
      if self.diffLevelCanva ~= nil then
        self.diffLevelCanvas:Hide()
      end
    end)
    if self.diffLevelCanvas ~= nil then
      self.diffLevelCanvas:PlayDiffLevelCanvasSwitchTween(true)
    end
    self.isShowingInfinity = true
    return
  else
    self.isShowingInfinity = false
  end
  if self.newDiffLevelCanvas == nil then
    self.newDiffLevelCanvas = self:GetDiffLevelCanvasItem(difficulty)
  end
  self.newDiffLevelCanvas:SetBackground(self:GetBgTexture(difficulty))
  local lastEpStateCfg
  if self.lastEpStateCfg ~= nil and self.lastEpStateCfg.sector == self.sectorId and self.lastEpStateCfg.difficulty == difficulty then
    lastEpStateCfg = self.lastEpStateCfg
  end
  self.newDiffLevelCanvas:Show()
  if self.newDiffLevelCanvas.SetSpecialLevelState then
    if difficulty == 1 then
      self.newDiffLevelCanvas:SetSpecialLevelState(self.levelState)
    else
      self.newDiffLevelCanvas:SetSpecialLevelState(nil)
    end
  end
  if self.specialLevelList then
    if difficulty == 1 then
      self.newDiffLevelCanvas:SetSpecialLevelList(self.specialLevelList)
    else
      self.newDiffLevelCanvas:SetSpecialLevelList(nil)
    end
  end
  self.newDiffLevelCanvas:InitDiffLevelCanvas(self.sectorId, lastEpStateCfg, true, difficulty, self.levelItemClickEvent, self.levelAvgMainClickEvent, self.lAvgSubClickEvent, self.__onChangeDiffComplete, self.resLoader, self.__sectorLevelTipsGuides, self.clickBackFunc)
  if self.sectorId == self._dungeonReplyOnSectorId then
    self.newDiffLevelCanvas:SetDungeonListInSector(self._extradungeonDataDic, self._clickDungeonEvent, self._dungeonBlueReddotFunc)
  end
  if isUpTween then
    if self.diffLevelCanvas.PlayDiffLevelCanvasSwitchTween then
      self.diffLevelCanvas:PlayDiffLevelCanvasSwitchTween(isUpTween)
    end
  elseif self.newDiffLevelCanvas.PlayDiffLevelCanvasSwitchTween then
    self.newDiffLevelCanvas:PlayDiffLevelCanvasSwitchTween(isUpTween)
  end
end

function UINDifficultList:OnChangeLevelDifficultyComplete()
  self.diffLevelCanvas, self.newDiffLevelCanvas = self.newDiffLevelCanvas, self.diffLevelCanvas
  if not self.isShowingInfinity and self.infinityLevelCanvas ~= nil then
    self.infinityLevelCanvas:Hide()
  end
  if self.newDiffLevelCanvas ~= nil then
    self.newDiffLevelCanvas:Hide()
  end
end

function UINDifficultList:PlayMoveLeftTween(isLeft, offset, duration)
  if self.activityType == nil then
    return
  end
  if self.__moveLeftSeq == nil then
    local endValue = Vector2.New(1 - offset / (self.transform.rect.width + self.ui.moveLeftTwenOffset), 1)
    local seq = cs_DoTween.Sequence()
    seq:SetAutoKill(false)
    seq:Append(self.transform:DOAnchorMax(endValue, duration))
    self:TrySetExtraMount(seq, isLeft, duration)
    self.__moveLeftSeq = seq
    self.__moveLeftSeqDuration = duration
  end
  if isLeft then
    self.__moveLeftSeq:PlayForward()
  else
    self.__moveLeftSeq:PlayBackwards()
    self.diffLevelCanvas:PlayDiffLevelContentTween(self.__moveLeftSeqDuration)
  end
end

function UINDifficultList:PlayMoveLongLeftTween(isLeft, offset, duration)
  if self.activityType == nil then
    return
  end
  if self.activityType == activityFrameEnum.eActivityType.Winter23 then
    return
  end
  if self.__moveLeftLongSeq == nil then
    offset = offset * 2
    local endValue = Vector2.New(1 - offset / (self.transform.rect.width + self.ui.moveLeftTwenOffset), 1)
    local seq = cs_DoTween.Sequence()
    seq:SetAutoKill(false)
    seq:Append(self.transform:DOAnchorMax(endValue, duration))
    self:TrySetExtraMount(seq, isLeft, duration)
    self.__moveLeftLongSeq = seq
    self.__moveLeftLongSeqDuration = duration
  end
  if isLeft then
    self.__moveLeftLongSeq:PlayForward()
  else
    self.__moveLeftLongSeq:PlayBackwards()
    self.diffLevelCanvas:PlayDiffLevelContentTween(self.__moveLeftLongSeqDuration)
  end
end

function UINDifficultList:TrySetExtraMount(seq, isLeft, duration)
  if self.extraMount == nil or self._extraMountWidth == nil then
    return
  end
  local n = cs_UIMnager.BackgroundStretchSize.x * (cs_UIMnager.CurNotchValue / 100)
  local value = isLeft and -(self._extraMountWidth + n) / self.transform.rect.width or 0
  seq:Join(self.transform:DOAnchorMin(Vector2.New(value, 0), duration))
end

function UINDifficultList:RefreshUncompletedEp(lastEpStateCfg)
  self.lastEpStateCfg = lastEpStateCfg
  if self.isShowingInfinity then
    self.infinityLevelCanvas:RefreshUncompletedEp(lastEpStateCfg)
  else
    self.diffLevelCanvas:RefreshUncompletedEp(lastEpStateCfg)
  end
end

function UINDifficultList:RefreshCurDiffLevelState()
  if self.diffLevelCanvas ~= nil then
    self.diffLevelCanvas:RefreshLevelState()
  end
end

function UINDifficultList:LocationSectorStageItem(id, isAvg)
  if self.diffLevelCanvas == nil then
    return nil, nil
  end
  return self.diffLevelCanvas:LocationSectorStageItem(id, isAvg)
end

function UINDifficultList:GetSectorStageItem(stageId)
  if self.diffLevelCanvas == nil then
    return nil
  end
  return self.diffLevelCanvas:GetSectorStageItem(stageId)
end

function UINDifficultList:GetSectorLAvgMainItem(avgId)
  if self.diffLevelCanvas == nil then
    return nil
  end
  return self.diffLevelCanvas:GetSectorLAvgMainItem(avgId)
end

function UINDifficultList:GetSectorDungeonItem(dungeonId)
  if self.diffLevelCanvas == nil then
    return nil
  end
  return self.diffLevelCanvas:GetSectorDungeonItem(dungeonId)
end

function UINDifficultList:SetSectorStageItemTipsGuide(id, isAvg, show_dir)
  local tipsGuideDic = self.__sectorLevelTipsGuides[isAvg]
  if tipsGuideDic == nil then
    tipsGuideDic = {}
    self.__sectorLevelTipsGuides[isAvg] = tipsGuideDic
  end
  tipsGuideDic[id] = show_dir
  local stageItem, levelGroup = self:LocationSectorStageItem(id, isAvg)
  if stageItem ~= nil and levelGroup ~= nil then
    levelGroup:SectorLevelTryTipsGuide(stageItem, id, isAvg)
  end
end

function UINDifficultList:ClearSectorStageItemTipsGuide(id, isAvg)
  local tipsGuideDic = self.__sectorLevelTipsGuides[isAvg]
  if tipsGuideDic == nil then
    return
  end
  tipsGuideDic[id] = nil
  local stageItem, levelGroup = self:LocationSectorStageItem(id, isAvg)
  if stageItem ~= nil and levelGroup ~= nil then
    levelGroup:SectorLevelClearTipsGuide(stageItem)
  end
end

function UINDifficultList:CheckShowExtraMount()
  local chapterDiffCfg = ConfigData.sector_chapter_difficulty
  if chapterDiffCfg[self.sectorId] then
    self:CheckChapterShowExtraMount()
  end
  local actType, actId, actData = PlayerDataCenter.sectorEntranceHandler:GetActivityDataBySectorId(self.sectorId)
  if actData and actType == activityFrameEnum.eActivityType.SectorI then
    local _, activityData, inTime = PlayerDataCenter.allActivitySectorIData:GetDataBySectorId(self.sectorId)
    self:CheckSectorIShowExtraMount(actId, activityData, inTime)
  end
  self.activityType = actType
end

function UINDifficultList:CheckSectorIShowExtraMount(actId, activityData, inTime)
  local isHasLeftInfo = inTime and activityData:IsActivityRunning() and activityData:GetSectorICfg().rechallenge_stage ~= self.sectorId
  if not isHasLeftInfo then
    self._extraMountAnchorType = nil
    self._extraMountWidth = 0
    if self.extraMount ~= nil then
      self.extraMount:Delete()
      self.extraMount = nil
      self:RecoverCanvasSize()
    end
    return
  end
  if self.extraMount ~= nil then
    return
  end
  self._extraMountAnchorType = nil
  self._extraMountWidth = 0
  local prefab = self.resLoader:LoadABAsset(PathConsts:GetUIPrefabPath("UI_ActSum21LvLeftInfo"))
  local go = prefab:Instantiate(self.transform)
  self.extraMount = UINActSummerLvLeftInfo.New()
  self.extraMount:Init(go)
  self.extraMount:InittSummerLvLeftInfo(activityData, self.sectorId, function(sectroId)
    if not SectorStageDetailHelper.IsSectorNoCollide(sectroId, true) then
      return
    end
    if self.clickBackFunc ~= nil then
      self.clickBackFunc()
    end
    self:ChangeLevelDifficulty(1, sectroId)
    self.extraMount:RefreshSectorId(sectroId)
    self.extraMount.transform:SetAsLastSibling()
  end)
  self.extraMount.transform:SetAsLastSibling()
  if self.extraMount.transform.anchorMin.x == 0 and self.extraMount.transform.anchorMax.x == 0 then
    self._extraMountAnchorType = CS_Edge.Left
  elseif self.extraMount.transform.anchorMin.x == 1 and self.extraMount.transform.anchorMax.x == 1 then
    self._extraMountAnchorType = CS_Edge.Right
  end
  self._extraMountWidth = self.extraMount.transform.sizeDelta.x
end

function UINDifficultList:CheckChapterShowExtraMount()
  local sectorLevelChapterCtrl = ControllerManager:GetController(ControllerTypeId.SectorLevelChapter, true)
  local prefab = self.resLoader:LoadABAsset(PathConsts:GetUIPrefabPath("UI_Winter23ChapterButtonGroup"))
  local parent = UIManager:GetWindow(UIWindowTypeID.SectorLevel):GetSectorInfoNode()
  local go = prefab:Instantiate(parent)
  parent:SetActive(true)
  self.extraMount = UINChapterButtonGroup.New()
  self.extraMount:Init(go)
  self.extraMount:InitSectorChapterButtonGroup(function(sectroId)
    if not SectorStageDetailHelper.IsSectorNoCollide(sectroId, true) then
      return
    end
    if self.clickBackFunc ~= nil then
      self.clickBackFunc()
    end
    local diff = PlayerDataCenter.sectorStage:GetSelectDifficult(sectroId)
    self:ChangeLevelDifficulty(diff, sectroId)
    self.extraMount:RefreshSectorId(sectroId)
    self.extraMount.transform:SetAsLastSibling()
  end, nil, self.resLoader)
  self.extraMount.transform:SetAsLastSibling()
  local diff = PlayerDataCenter.sectorStage:GetSelectDifficult(self.sectorId)
  self.extraMount:ChangeDifficultTypeFunc(diff)
end

function UINDifficultList:CheckAndGenChapterData()
  local chapterDiffCfg = ConfigData.sector_chapter_difficulty
  if chapterDiffCfg[self.sectorId] then
    self.chapterData = self.chapterData or {}
    local sectorLevelChapterCtrl = ControllerManager:GetController(ControllerTypeId.SectorLevelChapter)
    if sectorLevelChapterCtrl == nil then
      return
    end
    local chapterId, chapterCfg
    if self.levelState then
      chapterId = sectorLevelChapterCtrl:GetNowMaxChapter()
      chapterCfg = sectorLevelChapterCtrl:GetChapterCfgByChapterId(chapterId)
    else
      chapterId = sectorLevelChapterCtrl:GetNowChapterId()
      chapterCfg = sectorLevelChapterCtrl:GetNowChapterCfg()
    end
    self.chapterData.chapterId = chapterId
    self.chapterData.chapterCfg = chapterCfg
  else
    self.chapterData = nil
  end
end

function UINDifficultList:ResetLevelCanvasSize(levelCanvas)
  if self.extraMount ~= nil then
    self.extraMount.transform:SetAsLastSibling()
  end
  if self._extraMountAnchorType == nil then
    return
  end
  if self._extraMountAnchorType == CS_Edge.Left then
    levelCanvas.transform.offsetMin = Vector2.New(self._extraMountWidth, 0)
  elseif self._extraMountAnchorType == CS_Edge.Right then
    levelCanvas.transform.offsetMax = Vector2.New(-self._extraMountWidth, 0)
  end
end

function UINDifficultList:RecoverCanvasSize()
  if self.diffLevelCanvas ~= nil then
    self.diffLevelCanvas.transform.offsetMin = Vector2.New(0, 0)
  end
  if self.newDiffLevelCanvas ~= nil then
    self.newDiffLevelCanvas.transform.offsetMax = Vector2.New(0, 0)
  end
end

function UINDifficultList:OnListenSectorRunEnd(actId)
  local id, data, inTime = PlayerDataCenter.allActivitySectorIData:GetDataBySectorId(self.sectorId)
  if id ~= actId then
    return
  end
  if self.sectorId == data:GetSectorICfg().hard_stage then
    self:CheckShowExtraMount()
    local detailUI = UIManager:GetWindow(UIWindowTypeID.SectorLevelDetail)
    if detailUI ~= nil then
      detailUI:RefreshDtailNormalNode()
    end
    return
  end
  UIUtil.ReturnUntil2Marker(UIWindowTypeID.SectorEntrance, false)
end

function UINDifficultList:OnListenHeroGrowRunEnd(actId)
  local heroGrowCtrl = ControllerManager:GetController(ControllerTypeId.ActivityHeroGrow)
  if heroGrowCtrl ~= nil then
    local id, isChallenge, canFight = heroGrowCtrl:IsHeroGrowChallengeSector(self.sectorId)
    if id == nil or canFight then
      return
    end
    if isChallenge and not canFight then
      if UIUtil.CheckIsHaveSpecialMarker(UIWindowTypeID.CharacterDungeon) then
        UIUtil.ReturnUntil2Marker(UIWindowTypeID.CharacterDungeon, false)
        return
      end
      if UIUtil.CheckIsHaveSpecialMarker(UIWindowTypeID.CharDunVer2) then
        UIUtil.ReturnUntil2Marker(UIWindowTypeID.CharDunVer2, false)
        return
      end
    end
  end
  UIUtil.ReturnUntil2Marker(UIWindowTypeID.SectorEntrance, false)
end

function UINDifficultList:_OnChallengeTaskComplete(stageId)
  local stageItem = self:GetSectorStageItem(stageId)
  if stageItem == nil then
    return
  end
  stageItem:UpdLvItemChallengeTask()
end

function UINDifficultList:OnDelete()
  if self.__moveLeftSeq ~= nil then
    self.__moveLeftSeq:Kill()
    self.__moveLeftSeq = nil
  end
  if self.__moveLeftLongSeq ~= nil then
    self.__moveLeftLongSeq:Kill()
    self.__moveLeftLongSeq = nil
  end
  MsgCenter:RemoveListener(eMsgEventId.OnMainAvgStateChange, self.__OnMainAvgStateChange)
  MsgCenter:RemoveListener(eMsgEventId.OnMainLevelStateChange, self.__OnMainLevelStateChange)
  MsgCenter:RemoveListener(eMsgEventId.SectorActivityRunEnd, self.__OnListenSectorRunEnd)
  MsgCenter:RemoveListener(eMsgEventId.HeroGrowActivityRunEnd, self.__OnListenHeroGrowRunEnd)
  MsgCenter:RemoveListener(eMsgEventId.OnChallengeTaskComplete, self._OnChallengeTaskCompleteFunc)
  if self.infinityLevelCanvas ~= nil then
    self.infinityLevelCanvas:Delete()
  end
  if self.diffLevelCanvas ~= nil then
    self.diffLevelCanvas:Delete()
  end
  if self.newDiffLevelCanvas ~= nil then
    self.newDiffLevelCanvas:Delete()
  end
  if self.extraMount ~= nil then
    self.extraMount:Delete()
    self.extraMount = nil
  end
  base.OnDelete(self)
end

return UINDifficultList
