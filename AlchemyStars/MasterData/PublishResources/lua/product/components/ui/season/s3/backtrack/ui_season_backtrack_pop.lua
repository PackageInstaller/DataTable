_class("UISeasonBackTrackPop", UIController)
UISeasonBackTrackPop = UISeasonBackTrackPop

function UISeasonBackTrackPop:LoadDataOnEnter(TT, res)
  res:SetSucc(true)
end

function UISeasonBackTrackPop:OnShow(uiParams)
  self._id = uiParams[1]
  self:InitWidget()
end

function UISeasonBackTrackPop:InitWidget()
  self._desc = self:GetUIComponent("UILocalizationText", "Desc")
  local cfg = Cfg.cfg_season_backtrack[self._id]
  if cfg then
    self._desc.text = StringTable.Get("str_season_backtrack_pop_desc", StringTable.Get(cfg.Name))
  end
end

function UISeasonBackTrackPop:ConfirmBtnOnClick(go)
  local seasonModule = self:GetModule(SeasonModule)
  if self._id == seasonModule:GetCurSeasonID() then
    seasonModule.uiModule:BackToCurSeason()
  else
    seasonModule.uiModule:SeasonBackTrack(self._id)
  end
  Log.info("UISeasonBackTrackPop backtrack to ", self._id)
end

function UISeasonBackTrackPop:CancelBtnOnClick(go)
  self:CloseDialog()
end

function UISeasonBackTrackPop:BackgroundOnClick(go)
  self:CloseDialog()
end
