local base = require("Game.ActivityWinter23.UI.Sector.UINActLevelWin23RepeatItem")
local UINActLevelAnni24RepeatItem = class("UINActLevelAnni24RepeatItem", base)

function UINActLevelAnni24RepeatItem:OnInit()
  base.OnInit(self)
end

function UINActLevelAnni24RepeatItem:InitSectorLevelItem(stageCfg, arrangeCfg, clickEvent, resLoader)
  base.InitSectorLevelItem(self, stageCfg, arrangeCfg, clickEvent, resLoader)
  self:RefreshChapterUI()
end

function UINActLevelAnni24RepeatItem:RefreshChapterUI()
  if IsNull(self.ui.img_BottomInfo) then
    return
  end
  local sectorLevelChapterCtrl = ControllerManager:GetController(ControllerTypeId.SectorLevelChapter, true)
  local chapterId = sectorLevelChapterCtrl:GetChapterIdByRepeatStageId(self.stageCfg.id)
  if chapterId == 0 then
    return
  end
  local sectorId = sectorLevelChapterCtrl:GetSectorId()
  local chapterCfg = ConfigData.sector_chapter_chapters[sectorId][chapterId]
  if chapterCfg.chapter_ui == 0 then
    return
  end
  self.ui.img_BottomInfo:SetIndex(chapterCfg.chapter_ui - 1)
end

function UINActLevelAnni24RepeatItem:OnDelete()
  base.OnDelete(self)
end

return UINActLevelAnni24RepeatItem
