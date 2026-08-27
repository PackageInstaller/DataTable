local UINDiffLevelMulLineCanvas = require("Game.Sector.SectorLevel.UINDiffLevelMulLineCanvas")
local UINDiffLevelMulLineActWinter23Canvas = class("UINDiffLevelMulLineActWinter23Canvas", UINDiffLevelMulLineCanvas)
local base = UINDiffLevelMulLineCanvas
local SectorLevelDetailEnum = require("Game.Sector.Enum.SectorLevelDetailEnum")
local ActivityFrameEnum = require("Game.ActivityFrame.ActivityFrameEnum")
local sectorLevelUtil = require("Game.Sector.SectorLevel.SectorLevelUtil")

function UINDiffLevelMulLineActWinter23Canvas:OnInit()
  base.OnInit(self)
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.ui.switchTween.onComplete:AddListener(BindCallback(self, self.OnSwitchTweenComplete))
  self.ui.switchTween.onRewind:AddListener(BindCallback(self, self.OnSwitchTweenRewind))
end

function UINDiffLevelMulLineActWinter23Canvas:InitDiffLevelCanvas(sectorId, autoStateCfg, isUnCompleteEp, difficulty, levelItemClickEvent, levelAvgMainClickEvent, lAvgSubClickEvent, tweenCompleteEvent, resLoader, sectorLevelTipsGuides, clickBackFunc)
  base.InitDiffLevelCanvas(self, sectorId, autoStateCfg, isUnCompleteEp, difficulty, levelItemClickEvent, levelAvgMainClickEvent, lAvgSubClickEvent, tweenCompleteEvent, resLoader, sectorLevelTipsGuides, clickBackFunc)
end

function UINDiffLevelMulLineActWinter23Canvas:InitLevelGroupData()
  self.finalPage = nil
  self.splitPointPage = nil
  self.layourDic = nil
  self:_ReGenArrangeCfg()
  if self.levelState then
    self.levelGroupDataList, self.lastLocalsDataList, self.lastCompletedStage, self.finalPage, self._sectorStageIdGroupMapping = sectorLevelUtil.GetLevelGroupByOneLineAndNoAvg(self.arrangeCfg, self:GetLevelList(), self._sectorStageIdGroupMapping)
  else
    self.levelGroupDataList, self.lastLocalsDataList, self.lastCompletedStage, self.finalPage, self._sectorStageIdGroupMapping, self._sectorAvgIdGroupMapping = sectorLevelUtil.GetLevelGroupByNormalMulLine(self.arrangeCfg, self:GetLevelList(), self._sectorStageIdGroupMapping, self._sectorAvgIdGroupMapping)
  end
end

function UINDiffLevelMulLineActWinter23Canvas:SetSpecialLevelList(specialLevelList)
  base.SetSpecialLevelList(self, specialLevelList)
  self.ui.obj_comingSoon:SetActive(false)
  self:RefreshSectorActivityExtraMount(specialLevelList)
end

function UINDiffLevelMulLineActWinter23Canvas:ResetLevelGroupDataBySpecialLevelList(specialLevelList)
  base.ResetLevelGroupDataBySpecialLevelList(self, specialLevelList)
  self.ui.obj_comingSoon:SetActive(false)
  self:RefreshSectorActivityExtraMount(specialLevelList)
end

function UINDiffLevelMulLineActWinter23Canvas:_ReGenArrangeCfg()
  if self.levelState then
    local chapterDiffCfg = ConfigData.sector_chapter_difficulty
    if chapterDiffCfg[self.sectorId] then
      local sectorChapterCtrl = ControllerManager:GetController(ControllerTypeId.SectorLevelChapter)
      local newArrangeType = sectorChapterCtrl:GetRepeatArrangeType()
      self.arrangeCfg = ConfigData.level_arrange[newArrangeType]
    end
  else
    local sectorCfg = ConfigData.sector[self.sectorId]
    local levelArrangeType = sectorCfg.level_arrange[self.difficulty]
    local arrangeCfg = ConfigData.level_arrange[levelArrangeType]
    if arrangeCfg == nil then
      error(string.format("Can't find level arrange Cfg,arrangeId:%s, difficulty:%s, sectorId:%s", levelArrangeType, difficulty, sectorId))
      return
    end
    self.arrangeCfg = arrangeCfg
  end
end

function UINDiffLevelMulLineCanvas:GenAllSpecialListDic()
  local sectorLevelChapterCtrl = ControllerManager:GetController(ControllerTypeId.SectorLevelChapter, true)
  local spList = sectorLevelChapterCtrl:GetLevelListByRepeatId()
  local specialDic = {}
  for i, v in pairs(spList) do
    specialDic[v] = true
  end
  return specialDic
end

function UINDiffLevelMulLineActWinter23Canvas:RefreshSectorActivityExtraMount(specialLevelList)
  if not specialLevelList or 0 < #specialLevelList then
    return
  end
  local sectorChapterCtrl = ControllerManager:GetController(ControllerTypeId.SectorLevelChapter)
  if sectorChapterCtrl then
    local delayTime = sectorChapterCtrl:GetChapterOpenTime()
    self.ui.obj_comingSoon:SetActive(true)
    self.ui.tex_Num.text = string.format("%02d", sectorChapterCtrl:GetNowChapterId())
    self.ui.tex_Time.text = TimeUtil:TimestampToDateString(delayTime, false, true, ConfigData:GetTipContent(921))
  end
end

function UINDiffLevelMulLineActWinter23Canvas:SetStopTweenCompleteEvent(bool)
  self.stopTween = bool
end

function UINDiffLevelMulLineActWinter23Canvas:PlayDiffLevelCanvasSwitchTween(isUpTween)
  self.gameObject.transform:SetAsLastSibling()
  if isUpTween then
    self.ui.switchTween:DORestart()
    self.ui.switchSubTween:DORestart()
  else
    self.__isBackwardsTween = true
    self.ui.switchTween:DOComplete()
    self.ui.switchTween:DOPlayBackwards()
    self.ui.switchSubTween:DOComplete()
    self.ui.switchSubTween:DOPlayBackwards()
  end
  local continueWindow = UIManager:ShowWindow(UIWindowTypeID.ClickContinue)
  continueWindow:InitContinue(nil, nil, nil, Color.clear, false)
end

function UINDiffLevelMulLineActWinter23Canvas:OnSwitchTweenComplete()
  if self.__isBackwardsTween then
    return
  end
  self:OnSwitchTweenEndEvent()
end

function UINDiffLevelMulLineActWinter23Canvas:OnSwitchTweenRewind()
  if not self.__isBackwardsTween then
    return
  end
  self.__isBackwardsTween = false
  self:OnSwitchTweenEndEvent()
end

function UINDiffLevelMulLineActWinter23Canvas:OnSwitchTweenEndEvent()
  UIManager:HideWindow(UIWindowTypeID.ClickContinue)
  self.ui.switchTween:DORewind()
  self.ui.switchSubTween:DORewind()
  if self.tweenCompleteEvent ~= nil and not self.stopTween then
    self.tweenCompleteEvent()
  end
  self.stopTween = false
end

function UINDiffLevelMulLineActWinter23Canvas:GetLevelList()
  return self.specialLevelList or base.GetLevelList(self)
end

function UINDiffLevelMulLineActWinter23Canvas:OnDelete()
  base.OnDelete(self)
end

return UINDiffLevelMulLineActWinter23Canvas
