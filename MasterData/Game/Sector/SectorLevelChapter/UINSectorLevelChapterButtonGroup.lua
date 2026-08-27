local UINSectorLevelChapterButtonGroup = class("UINSectorLevelChapterButtonGroup", UIBaseNode)
local base = UIBaseNode
local UINActSectorChapterBtn = require("Game.Sector.SectorLevelChapter.UINSectorLevelChapterBtn")
local UINActSectorChapterButtonList = require("Game.Sector.SectorLevelChapter.UINChapterList")
local chapterEnum = require("Game.Sector.Enum.SectorLevelChapterEnum")
local SectorStageDetailHelper = require("Game.Sector.SectorStageDetailHelper")

function UINSectorLevelChapterButtonGroup:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_ChapterList, self, self.OnClickOpenFullSelectChapter)
  UIUtil.AddButtonListener(self.ui.btn_selectLeft, self, self.OnClickSelectChapterLeft)
  UIUtil.AddButtonListener(self.ui.btn_selectRight, self, self.OnClickSelectChapterRight)
  self._switchCallback = BindCallback(self, self.OnClickSwitchBtn)
  self._switchChapterCallback = BindCallback(self, self.SwitchSelectChapter)
  self._switchLevelCallback = BindCallback(self, self.SwitchLevelCallback)
  self.chapterBtnPool = UIItemPool.New(UINActSectorChapterBtn, self.ui.btn_chapter)
  self.ui.btn_chapter:SetActive(false)
  self.__RefreshButtonGroupRedDot = BindCallback(self, self.RefreshChapterButtonGroupUIRedDot)
  MsgCenter:AddListener(eMsgEventId.OnMainLevelStateChange, self.__RefreshButtonGroupRedDot)
  self.chapterCtrl = ControllerManager:GetController(ControllerTypeId.SectorLevelChapter)
end

function UINSectorLevelChapterButtonGroup:InitSectorChapterButtonGroup(selectFunc, outDataFunc, resloader)
  self.selectFunc = selectFunc
  self.resloader = resloader
  self.chapterList = UINActSectorChapterButtonList.New()
  self.chapterList:Init(self.ui.obj_chapterList)
  local isRepeat = self.chapterCtrl:GetIsRepeat()
  local sectorList = self.chapterCtrl:GetSectorList()
  local curSectorId = self.chapterCtrl:GetSectorId()
  local closeShowRepeat = self.chapterCtrl:GetCloseRepeatShow()
  if not closeShowRepeat then
    self.stageBtn = self.chapterBtnPool:GetOne()
    self:RefreshButtonShow(true, isRepeat and chapterEnum.levelSelectButtonType.mainButton or chapterEnum.levelSelectButtonType.repeatButton)
  end
  if 1 < #sectorList then
    self.modeBtn = self.chapterBtnPool:GetOne()
    local modeId = curSectorId == sectorList[1] and chapterEnum.levelSelectButtonType.normalDiffButton or chapterEnum.levelSelectButtonType.hardDiffButton
    self:RefreshButtonShow(false, modeId)
  end
  self:RefreshChapterShow()
  if ControllerManager:GetController(ControllerTypeId.SectorLevelChapter):GetIsFirstEnter() then
    self:_OpenChapterLvSwitch()
  end
  self:RefreshChapterObjActive()
end

function UINSectorLevelChapterButtonGroup:RefreshClearChapterObjActive()
  local isRepeat = self.chapterCtrl:GetIsRepeat()
  self.ui.obj_chapter:SetActive(not isRepeat)
end

function UINSectorLevelChapterButtonGroup:RefreshChapterObjActive()
  self:RefreshClearChapterObjActive()
  self:RefreshChapterShow()
end

function UINSectorLevelChapterButtonGroup:RefreshButtonShow(isStage, modeId)
  if isStage then
    self.stageBtn:InitSectorChapterLvBtn(modeId, self._switchCallback)
  else
    self.modeBtn:InitSectorChapterLvBtn(modeId, self._switchCallback)
  end
end

function UINSectorLevelChapterButtonGroup:RefreshChapterShow()
  local curChapterId = self.chapterCtrl:GetNowChapterId()
  if not curChapterId then
    return
  end
  local sectorChapterCfgList = self.chapterCtrl:GetChapterCfgList()
  if #sectorChapterCfgList == 1 then
    self.ui.btn_selectLeft.gameObject:SetActive(false)
    self.ui.btn_selectRight.gameObject:SetActive(false)
    self.ui.btn_ChapterList.gameObject:SetActive(false)
    return
  end
  self.ui.tex_midNum.text = string.format("%02d", curChapterId)
  self.ui.tex_leftNum.text = string.format("%02d", curChapterId - 1)
  self.ui.tex_rightNum.text = string.format("%02d", curChapterId + 1)
  self.ui.btn_selectLeft.gameObject:SetActive(true)
  self.ui.btn_selectRight.gameObject:SetActive(true)
  self.ui.btn_ChapterList.gameObject:SetActive(true)
  self:RefreshChapterButtonGroupUIRedDot()
  if curChapterId == 1 then
    self.ui.tex_leftNum.text = ""
    self.ui.btn_selectLeft.gameObject:SetActive(false)
  end
  if curChapterId == #sectorChapterCfgList then
    self.ui.tex_rightNum.text = ""
    self.ui.btn_selectRight.gameObject:SetActive(false)
  end
end

function UINSectorLevelChapterButtonGroup:RefreshChapterButtonGroupUIRedDot()
  self:SetChapterButtonGroupUIRedDot(false)
  local chaptersCfg = self.chapterCtrl:GetChapterCfgList()
  local curChapterId = self.chapterCtrl:GetNowChapterId()
  local oldChapterStageIds = chaptersCfg[curChapterId].stage_id
  if 0 < #oldChapterStageIds and PlayerDataCenter.sectorStage:IsStageUnlock(oldChapterStageIds[1]) then
    self.chapterCtrl:SetChapterLooked(curChapterId)
  end
  for i, cfg in pairs(chaptersCfg) do
    local isLooked = self.chapterCtrl:GetChapterLooked(cfg.chapter_id)
    local lastChapterCfg = chaptersCfg[cfg.chapter_id]
    if lastChapterCfg then
      local stageIds = chaptersCfg[cfg.chapter_id].stage_id
      if not isLooked and 0 < #stageIds and PlayerDataCenter.sectorStage:IsStageUnlock(stageIds[1]) and not PlayerDataCenter.sectorStage:IsStageComplete(stageIds[1]) then
        self:SetChapterButtonGroupUIRedDot(true, cfg.chapter_id)
        break
      end
    end
  end
end

function UINSectorLevelChapterButtonGroup:SetChapterButtonGroupUIRedDot(bool, redIndex)
  redIndex = redIndex or 1
  self.chapterCtrl:SetIsChapterRedOpen(bool)
  self.chapterCtrl:SetRedChapterIndex(redIndex)
  local curChapterId = self.chapterCtrl:GetNowChapterId()
  self.ui.obj_RightRedDot:SetActive(false)
  self.ui.obj_LeftRedDot:SetActive(false)
  if redIndex - curChapterId == -1 then
    self.ui.obj_LeftRedDot:SetActive(bool)
  elseif redIndex - curChapterId == 1 then
    self.ui.obj_RightRedDot:SetActive(bool)
  end
end

function UINSectorLevelChapterButtonGroup:RefreshSectorId(sectorId)
  self.chapterCtrl:SetSectorId(sectorId)
  self:RefreshSelectBtnState()
end

function UINSectorLevelChapterButtonGroup:_OpenChapterLvSwitch()
  local sectorList = self.chapterCtrl:GetSectorList()
  local curSectorId = self.chapterCtrl:GetSectorId()
  UIManager:ShowWindowAsync(UIWindowTypeID.SectorChapterLvSwitch, function(win)
    if win == nil then
      return
    end
    win:InitSectorChapterLvSwitch(sectorList, curSectorId == sectorList[1] and 1 or 2, self.resloader, self._switchLevelCallback)
  end)
end

function UINSectorLevelChapterButtonGroup:OnClickSwitchBtn(modeId)
  if modeId == chapterEnum.levelSelectButtonType.repeatButton or modeId == chapterEnum.levelSelectButtonType.mainButton then
    self:_SwitchRepeatMode()
  elseif modeId == chapterEnum.levelSelectButtonType.normalDiffButton or modeId == chapterEnum.levelSelectButtonType.hardDiffButton then
    self:_OpenChapterLvSwitch()
  end
end

function UINSectorLevelChapterButtonGroup:SwitchLevelCallback(levelIndex)
  if not SectorStageDetailHelper.IsSectorNoCollide(levelIndex, true) then
    return
  end
  local sectorList = self.chapterCtrl:GetSectorList()
  self.chapterCtrl:ChangeMainEpSector(levelIndex)
  local modeId
  if levelIndex == sectorList[1] then
    modeId = chapterEnum.levelSelectButtonType.normalDiffButton
  else
    modeId = chapterEnum.levelSelectButtonType.hardDiffButton
  end
  self:RefreshChapterShow()
  self:RefreshButtonShow(false, modeId)
end

function UINSectorLevelChapterButtonGroup:_SwitchRepeatMode()
  local isRepeat = self.chapterCtrl:ChangeMainEpRepeat()
  local modeId
  if isRepeat then
    modeId = chapterEnum.levelSelectButtonType.mainButton
    self.ui.ani_chapter:Play("UI_Winter23ChapterButtonGroupChapterOut")
    local aniClip = self.ui.ani_chapter:GetClip("UI_Winter23ChapterButtonGroupChapterOut")
    local aniTime = 0
    if aniClip then
      aniTime = aniClip.length
    end
    if self.outChapterTimer then
      TimerManager:StopTimer(self.outChapterTimer)
      self.outChapterTimer = nil
    end
    self.outChapterTimer = TimerManager:StartTimer(aniTime, function()
      self:RefreshChapterObjActive()
    end, nil, true)
  else
    modeId = chapterEnum.levelSelectButtonType.repeatButton
    self:RefreshChapterObjActive()
  end
  self:RefreshButtonShow(true, modeId)
end

function UINSectorLevelChapterButtonGroup:OnClickOpenFullSelectChapter()
  self.chapterList:Show()
  local sectorChapterCfg = self.chapterCtrl:GetChapterCfgList()
  local curChapterId = self.chapterCtrl:GetNowChapterId()
  self.chapterList:InitSectorChapterList(sectorChapterCfg, curChapterId, self._switchChapterCallback)
  local isRedDotOpen = self.chapterCtrl:GetIsChapterRedOpen()
  local redIndex = self.chapterCtrl:GetRedChapterIndex()
  self.chapterList:SetRedDotStart(isRedDotOpen, redIndex)
end

function UINSectorLevelChapterButtonGroup:OnClickSelectChapterLeft()
  local curChapterId = self.chapterCtrl:GetNowChapterId()
  if curChapterId == 1 then
    return
  end
  curChapterId = curChapterId - 1
  self.chapterCtrl:ChangeMainEpChapter(curChapterId)
  self:RefreshChapterShow()
end

function UINSectorLevelChapterButtonGroup:RefreshSelectChapter(selectId)
end

function UINSectorLevelChapterButtonGroup:OnClickSelectChapterRight()
  local curChapterId = self.chapterCtrl:GetNowChapterId()
  local chaptersCfg = self.chapterCtrl:GetChapterCfgList()
  if curChapterId == #chaptersCfg then
    return
  end
  curChapterId = curChapterId + 1
  self.chapterCtrl:ChangeMainEpChapter(curChapterId)
  self:RefreshChapterShow()
end

function UINSectorLevelChapterButtonGroup:SwitchSelectChapter(index)
  self.chapterList:Hide()
  local curChapterId = self.chapterCtrl:GetNowChapterId()
  if curChapterId == index then
    return
  end
  curChapterId = index
  self.chapterCtrl:ChangeMainEpChapter(curChapterId)
  self:RefreshChapterShow()
end

function UINSectorLevelChapterButtonGroup:ChangeDifficultTypeFunc(diff)
  if diff == 1 then
    self:RefreshClearChapterObjActive()
  else
    self.ui.obj_chapter:SetActive(false)
  end
end

function UINSectorLevelChapterButtonGroup:OnDelete()
  base.OnDelete(self)
  MsgCenter:RemoveListener(eMsgEventId.OnMainLevelStateChange, self.__RefreshButtonGroupRedDot)
  if self.outChapterTimer then
    TimerManager:StopTimer(self.outChapterTimer)
    self.outChapterTimer = nil
  end
end

return UINSectorLevelChapterButtonGroup
