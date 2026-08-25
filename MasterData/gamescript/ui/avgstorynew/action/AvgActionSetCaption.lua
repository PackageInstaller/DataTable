local AbyssPlayerNameStageTidList = DT.GetOriginalConstant("AbyssPlayerNameStageTidList")
local AvgActionSetCaption = System.NewClass("AvgActionSetCaption", AvgActionBase)

function AvgActionSetCaption:DoAction(_, _, finishCb)
  finishCb()
  local dialogInfo = self.avgModel:GetDialogInfo()
  local titleParts = {}
  for part in string.gmatch(dialogInfo.Chapter or "", "([^;]*);?") do
    table.insert(titleParts, part)
  end
  local content = dialogInfo.Content or ""
  local chapter, titleEng, titlePart = table.unpack(titleParts)
  chapter = chapter or ""
  titleEng = titleEng or ""
  titlePart = titlePart or ""
  local lang = DataCenter.gameData.CurrTextLanguage
  if lang ~= cd.Lang.CN and lang ~= cd.Lang.TW then
    chapter = ""
    titleEng = ""
  end
  self.binder:SetText(self.ui.Text_Title, "")
  self.binder:SetText(self.ui.Text_Title2, StrUtils.ReplaceAvgContent(LT.Text(titleEng)))
  self.binder:SetText(self.ui.Text_Chapter, StrUtils.ReplaceAvgContent(LT.Text(chapter)))
  self.binder:SetText(self.ui.Text_Chapter2, StrUtils.ReplaceAvgContent(LT.Text(chapter)))
  self.binder:SetText(self.ui.Text_Part, StrUtils.ReplaceAvgContent(LT.Text(titlePart)))
  self.binder:SetText(self.ui.Text_Part2, StrUtils.ReplaceAvgContent(LT.Text(titlePart)))
  local dialogText = StrUtils.ReplaceAvgContent(content)
  local stageTid = StageCfgUtils.GetStageTidByAvgDialogTid(self.avgModel.storyId)
  if table.contains(AbyssPlayerNameStageTidList or {}, stageTid) then
    dialogText = StageCfgUtils.GetStageName(stageTid, self.ui.Text_Caption)
  end
  self.binder:SetText(self.ui.Text_Caption, dialogText)
  self.binder:SetText(self.ui.Text_Caption2, dialogText)
end

return AvgActionSetCaption
