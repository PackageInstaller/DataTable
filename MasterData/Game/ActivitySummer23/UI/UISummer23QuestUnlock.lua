local UISummer23QuestUnlock = class("UISummer23QuestUnlock", UIBaseWindow)
local base = UIBaseWindow
local SectorChapterEnum = require("Game.Sector.Enum.SectorLevelChapterEnum")

function UISummer23QuestUnlock:OnInit()
  UIUtil.SetTopStatus(self, self.Delete, nil, nil, nil, true)
end

function UISummer23QuestUnlock:InitSummer23QuestUnlock(carnival23Data)
  local mainCfg = carnival23Data:GetCarnival23Cfg()
  local sectorLevelChapterCtrl = ControllerManager:GetController(ControllerTypeId.SectorLevelChapter, true)
  local sectorId = mainCfg.normal_sector
  sectorLevelChapterCtrl:ChangeChapterDataType(SectorChapterEnum.chapterDataType.actCarnival23)
  local chapterNum = sectorLevelChapterCtrl:GetLastUnCompleteChapter(sectorId)
  self.ui.tex_Chapter.text = ConfigData:GetTipContent(349, chapterNum)
end

function UISummer23QuestUnlock:OnDelete()
  base.OnDelete(self)
end

return UISummer23QuestUnlock
