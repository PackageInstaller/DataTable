local SeasonMazeRelicHrefInfoType = {Default = 1}
_enum("SeasonMazeRelicHrefInfoType", SeasonMazeRelicHrefInfoType)
_class("UISeasonMaze_RelicHrefInfo", UIController)
UISeasonMaze_RelicHrefInfo = UISeasonMaze_RelicHrefInfo

function UISeasonMaze_RelicHrefInfo:OnShow(uiParams)
  self._offset = self:GetGameObject("offset")
  self._txtName = self:GetUIComponent("UILocalizationText", "txtName")
  self._imgIcon = self:GetUIComponent("RawImageLoader", "imgIcon")
  self._txtDesc = self:GetUIComponent("UILocalizationText", "txtDesc")
  self:Flush(uiParams[1])
end

function UISeasonMaze_RelicHrefInfo:OnHide()
  self._offset = nil
  self._txtName = nil
  self._imgIcon = nil
  self._txtDesc = nil
end

function UISeasonMaze_RelicHrefInfo:Flush(hrefName)
  if not hrefName then
    self:CloseSelfDialog()
    return
  end
  local id = tonumber(hrefName)
  local cfgv = Cfg.cfg_season_maze_relic_href_desc[id]
  if not cfgv then
    self:CloseSelfDialog()
    return
  end
  local name = StringTable.Get(cfgv.Name)
  self._txtName:SetText(name)
  local desc = StringTable.Get(cfgv.Desc)
  self._txtDesc:SetText(desc)
end

function UISeasonMaze_RelicHrefInfo:BgOnClick()
  self:CloseSelfDialog()
end

function UISeasonMaze_RelicHrefInfo:CloseSelfDialog()
  GameGlobal.UIStateManager():CloseDialog(self:GetName())
end
