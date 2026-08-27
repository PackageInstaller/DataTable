local base = require("Game.ActivityWinter23.UI.Sector.UINActLevelWin23Item")
local UINActLevelAnni24Item = class("UINActLevelAnni24Item", base)

function UINActLevelAnni24Item:OnInit()
  base.OnInit(self)
end

function UINActLevelAnni24Item:InitSectorLevelItem(stageCfg, arrangeCfg, clickEvent, resLoader)
  base.InitSectorLevelItem(self, stageCfg, arrangeCfg, clickEvent, resLoader)
  self:RefreshChapterUI()
end

function UINActLevelAnni24Item:RefreshChapterUI()
  if IsNull(self.ui.img_BottomInfo) then
    return
  end
  local sectorLevelChapterCtrl = ControllerManager:GetController(ControllerTypeId.SectorLevelChapter, true)
  local chapterCfg = sectorLevelChapterCtrl:GetNowChapterCfg()
  if chapterCfg.chapter_ui == 0 then
    return
  end
  self.ui.img_BottomInfo:SetIndex(chapterCfg.chapter_ui - 1)
end

function UINActLevelAnni24Item:OnDelete()
  base.OnDelete(self)
end

return UINActLevelAnni24Item
