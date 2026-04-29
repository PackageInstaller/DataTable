_class("UISeasonBuildViewS3", UICustomWidget)
UISeasonBuildViewS3 = UISeasonBuildViewS3

function UISeasonBuildViewS3:OnShow(uiParams)
  self:InitWidget()
end

function UISeasonBuildViewS3:InitWidget()
  self.imgBuild = self:GetUIComponent("RawImageLoader", "imgBuild")
end

function UISeasonBuildViewS3:Init(context)
  self._context = context
end

function UISeasonBuildViewS3:Refresh()
  local level = self._context:GetCurLevel()
  local cfg = self._context:GetBuildCfgByLevel(level)
  if cfg then
    local showCfg = Cfg.cfg_season_castle_show[cfg.ID]
    if showCfg then
      self.imgBuild:LoadImage(showCfg.Bg)
    end
  end
end
