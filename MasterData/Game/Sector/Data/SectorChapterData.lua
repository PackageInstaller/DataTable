local SectorChapterData = class("SectorChapterData")

function SectorChapterData:ctor(sectorChapterId)
  local chapterCfg = ConfigData.sector_sector_resident[sectorChapterId]
  if chapterCfg == nil then
    error(string.format("sector_sector_resident is nil, id:%s", sectorChapterId))
    return
  end
  self._chapterCfg = chapterCfg
  self._sectorCfg = ConfigData.sector[self._chapterCfg.relevancy_parameter]
end

function SectorChapterData:GetSctChaptName()
  return LanguageUtil.GetLocaleText(self._sectorCfg.name)
end

function SectorChapterData:GetSctChaptEnName()
  return LanguageUtil.GetLocaleText(self._sectorCfg.name_en)
end

function SectorChapterData:GetSctChaptSerialNum()
  return LanguageUtil.GetLocaleText(self._chapterCfg.serial)
end

function SectorChapterData:GetSctChaptUIPosList()
  return self._chapterCfg.pos
end

function SectorChapterData:GetSctChaptRelevancy()
  return self._chapterCfg.relevancy_function, self._chapterCfg.relevancy_parameter
end

function SectorChapterData:GetSctChaptSectorId()
  return self._chapterCfg.relevancy_parameter
end

function SectorChapterData:GetSctChaptId()
  return self._chapterCfg.id
end

function SectorChapterData:GetSctChaptSectorCfg()
  return self._sectorCfg
end

function SectorChapterData:IsSctChanllengeOpen()
  return self._sectorCfg.task_is_open
end

function SectorChapterData:IsSectorChapterUnlock(ignoreBuy, ignoreUnlockSkipped)
  return PlayerDataCenter.sectorStage:IsSctChapterUnlock(self:GetSctChaptId(), ignoreBuy, ignoreUnlockSkipped)
end

function SectorChapterData:IsSectorChapterUnlockCostOk()
  if self._chapterCfg.costItemId == 0 then
    return true
  end
  local ok = PlayerDataCenter.sectorStage:IsSectorCostBuyOk(self._chapterCfg.relevancy_parameter)
  if ok then
    return true
  end
  local costItemId, costItemNum = self._chapterCfg.costItemId, self._chapterCfg.costItemNum
  return false, costItemId, costItemNum
end

function SectorChapterData:GetSctChapterUnlockColorIdx()
  return self._chapterCfg.unlock_color
end

function SectorChapterData:TryGetSctChaptIcon()
  if #self._chapterCfg.icon_pos == 0 then
    return false
  end
  local iconName = self._sectorCfg.scene_icon
  local iconPosList = self._chapterCfg.icon_pos
  return true, iconName, Vector2.New(iconPosList[1], iconPosList[2])
end

function SectorChapterData:GetSctChaptGoName()
  return self._chapterCfg.gameobject_name
end

function SectorChapterData:GetSctChaptShowPriority()
  return self._chapterCfg.show_priority
end

function SectorChapterData:IsSctChapterUnlockSkipped()
  return #self._chapterCfg.show_need_pass > 0
end

return SectorChapterData
