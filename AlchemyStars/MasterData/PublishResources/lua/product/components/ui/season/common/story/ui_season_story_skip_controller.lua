_class("UISeasonStorySkipController", UIController)
UISeasonStorySkipController = UISeasonStorySkipController

function UISeasonStorySkipController:OnShow(uiParams)
  self._eventID = uiParams[1]
  self._callback = uiParams[2]
  self:_GetComponents()
  self:_InitComponent()
end

function UISeasonStorySkipController:OnHide()
end

function UISeasonStorySkipController:_GetComponents()
  self._skipTxt = self:GetUIComponent("UILocalizationText", "skipTxt")
end

function UISeasonStorySkipController:_InitComponent()
  local cfg = Cfg.cfg_season_story_event[self._eventID]
  self._skipTxt:SetText(StringTable.Get(cfg.SkipTxt))
end

function UISeasonStorySkipController:CancelBtnOnClick()
  self:CloseDialog()
end

function UISeasonStorySkipController:ConfirmBtnOnClick()
  self:CloseDialog()
  if self._callback then
    self._callback()
  end
end
