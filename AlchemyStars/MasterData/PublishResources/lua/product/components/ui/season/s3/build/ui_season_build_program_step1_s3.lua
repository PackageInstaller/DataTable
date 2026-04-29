_class("UISeasonBuildProgramStep1S3", UICustomWidget)
UISeasonBuildProgramStep1S3 = UISeasonBuildProgramStep1S3

function UISeasonBuildProgramStep1S3:OnShow(uiParams)
  self:InitWidget()
end

function UISeasonBuildProgramStep1S3:InitWidget()
  self.txtTitle = self:GetUIComponent("UILocalizationText", "txtDesc")
  self.txtTask = self:GetUIComponent("UILocalizationText", "txtTask")
  self.unFinishGo = self:GetGameObject("unFinish")
  self.finishGo = self:GetGameObject("finish")
end

function UISeasonBuildProgramStep1S3:SetData(context)
  self._context = context
  local level = self._context:GetCurLevel()
  local quest = self._context:GetQuestByBuildLevel(level)
  local finish = quest.Finish
  self.unFinishGo:SetActive(not finish)
  self.finishGo:SetActive(finish)
  local cfg = self._context:GetBuildCfgByLevel(level)
  local showCfg = Cfg.cfg_season_castle_show[cfg.ID]
  if showCfg then
    self.txtTitle:SetText(StringTable.Get(showCfg.TaskTitle))
    self.txtTask:SetText(StringTable.Get(showCfg.TaskDesc))
  end
end
