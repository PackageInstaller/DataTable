_class("UISeasonStorySkipS3", UIController)
UISeasonStorySkipS3 = UISeasonStorySkipS3

function UISeasonStorySkipS3:OnShow(uiParams)
  self._eventID = uiParams[1]
  self._callback = uiParams[2]
  self:_GetComponents()
  self:_InitComponent()
end

function UISeasonStorySkipS3:OnHide()
end

function UISeasonStorySkipS3:_GetComponents()
  self._skipTxt = self:GetUIComponent("UILocalizationText", "skipTxt")
end

function UISeasonStorySkipS3:_InitComponent()
  local cfg = Cfg.cfg_season_story_event[self._eventID]
  self._skipTxt:SetText(StringTable.Get(cfg.SkipTxt))
end

function UISeasonStorySkipS3:CancelBtnOnClick()
  self:CloseDialog()
end

function UISeasonStorySkipS3:ConfirmBtnOnClick()
  self:CloseDialog()
  if self._callback then
    self._callback()
  end
end
