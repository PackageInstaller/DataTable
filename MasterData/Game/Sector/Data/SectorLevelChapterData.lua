local SectorLevelChapterData = class("SectorLevelChapterData")

function SectorLevelChapterData:ctor()
  self:ResetSctLvChapterData()
end

function SectorLevelChapterData:ResetSctLvChapterData()
  self.sectorId = nil
  self.isRepeat = nil
  self.chapterId = nil
  self.closeCallback = nil
  self.isFirstEnter = nil
  self.repeatName = nil
  self.mainName = nil
  self.repeatArrangeType = nil
  self.nowStageId = nil
  self.sectorList = nil
  self.chapterReads = nil
  self.isChapterRedOpen = nil
  self.redChapterIndex = nil
  self.closeRepeatShow = nil
  self.isSpecialShowChapter = nil
end

function SectorLevelChapterData:SetChapterBaseInfo(sectorId, isRepeat, closeCallback, chapterId)
  self.sectorId = sectorId
  self.isRepeat = isRepeat
  self.chapterId = chapterId
  self.closeCallback = closeCallback
end

function SectorLevelChapterData:GetRepeatStageList(sectorId)
  local farmDescCfg = ConfigData.sector_chapter_farm_desc
  local list = {}
  for i, v in pairs(farmDescCfg) do
    local stageCfg = ConfigData.sector_stage[i]
    if stageCfg and stageCfg.sector == sectorId then
      table.insert(list, stageCfg.id)
    end
  end
  table.sort(list)
  return list
end

function SectorLevelChapterData:IsNotRepeatStageAndComplete(stageId)
  if not PlayerDataCenter.sectorStage:IsStageComplete(stageId) then
    return false
  end
  return self:IsNotRepeatStage(stageId)
end

function SectorLevelChapterData:IsNotRepeatStage(stageId)
  local farmDescCfg = ConfigData.sector_chapter_farm_desc
  for i, v in pairs(farmDescCfg) do
    if stageId == i then
      return false
    end
  end
  return true
end

function SectorLevelChapterData:GetSectorId()
  return self.sectorId
end

function SectorLevelChapterData:SetSectorId(value)
  self.sectorId = value
end

function SectorLevelChapterData:GetIsRepeat()
  return self.isRepeat
end

function SectorLevelChapterData:SetIsRepeat(value)
  self.isRepeat = value
end

function SectorLevelChapterData:GetChapterId()
  return self.chapterId
end

function SectorLevelChapterData:SetChapterId(value)
  self.chapterId = value
end

function SectorLevelChapterData:GetCloseCallback()
  return self.closeCallback
end

function SectorLevelChapterData:SetCloseCallback(value)
  self.closeCallback = value
end

function SectorLevelChapterData:GetIsFirstEnter()
  return self.isFirstEnter
end

function SectorLevelChapterData:SetIsFirstEnter(value)
  self.isFirstEnter = value
end

function SectorLevelChapterData:GetRepeatName()
  return self.repeatName
end

function SectorLevelChapterData:SetRepeatName(value)
  self.repeatName = value
end

function SectorLevelChapterData:GetMainName()
  return self.mainName
end

function SectorLevelChapterData:SetMainName(value)
  self.mainName = value
end

function SectorLevelChapterData:GetNowStageId()
  return self.nowStageId
end

function SectorLevelChapterData:SetNowStageId(value)
  self.nowStageId = value
end

function SectorLevelChapterData:GetSectorList()
  return self.sectorList
end

function SectorLevelChapterData:SetSectorList(value)
  self.sectorList = value
end

function SectorLevelChapterData:GetChapterReads()
  return self.chapterReads
end

function SectorLevelChapterData:SetChapterReads(chapterId)
  self.chapterReads = self.chapterReads or {}
  self.chapterReads[chapterId] = true
end

function SectorLevelChapterData:GetIsChapterRedOpen()
  return self.isChapterRedOpen
end

function SectorLevelChapterData:SetIsChapterRedOpen(value)
  self.isChapterRedOpen = value
end

function SectorLevelChapterData:GetRedChapterIndex()
  return self.redChapterIndex
end

function SectorLevelChapterData:SetRedChapterIndex(value)
  self.redChapterIndex = value
end

function SectorLevelChapterData:GetRepeatArrangeType()
  return self.repeatArrangeType
end

function SectorLevelChapterData:SetRepeatArrangeType(value)
  self.repeatArrangeType = value
end

function SectorLevelChapterData:GetCloseRepeatShow()
  return self.closeRepeatShow
end

function SectorLevelChapterData:SetCloseRepeatShow(value)
  self.closeRepeatShow = value
end

function SectorLevelChapterData:SetIsSpecialShowChapter(value)
  self.isSpecialShowChapter = value
end

function SectorLevelChapterData:GetIsSpecialShowChapter()
  return self.isSpecialShowChapter
end

function SectorLevelChapterData:GetNowChapterCfg()
  return ConfigData.sector_chapter_chapters[self.sectorId][self.chapterId]
end

return SectorLevelChapterData
