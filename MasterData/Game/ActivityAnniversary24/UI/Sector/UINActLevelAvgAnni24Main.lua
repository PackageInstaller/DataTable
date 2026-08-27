local base = require("Game.ActivityWinter23.UI.Sector.UINActLevelAvgWin23Main")
local UINActLevelAvgAnni24Main = class("UINActLevelAvgAnni24Main", base)

function UINActLevelAvgAnni24Main:OnInit()
  base.OnInit(self)
end

function UINActLevelAvgAnni24Main:InitActLAvgMain(avgCfg, arrangeCfg, clickEvent, resLoader)
  base.InitActLAvgMain(self, avgCfg, arrangeCfg, clickEvent, resLoader)
  self:RefreshChapterUI()
end

function UINActLevelAvgAnni24Main:RefreshChapterUI()
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

function UINActLevelAvgAnni24Main:OnDelete()
  base.OnDelete(self)
end

return UINActLevelAvgAnni24Main
