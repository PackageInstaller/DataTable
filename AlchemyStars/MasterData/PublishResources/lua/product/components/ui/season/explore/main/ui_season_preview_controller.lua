_class("UISeasonPreviewController", UIController)
UISeasonPreviewController = UISeasonPreviewController

function UISeasonPreviewController:LoadDataOnEnter(TT, res)
  res:SetSucc(true)
end

function UISeasonPreviewController:OnShow(uiParams)
  self:InitWidget()
  self.previewId = uiParams[1]
  self:OnValue()
end

function UISeasonPreviewController:InitWidget()
  local topBtns = self:GetUIComponent("UISelectObjectPath", "TopBtns")
  self._backBtns = topBtns:SpawnObject("UICommonTopButton")
  self._backBtns:SetData(function()
    self:CloseDialog()
  end, nil, nil, true)
  self.bg = self:GetUIComponent("RawImageLoader", "bg")
  self.petImage = self:GetUIComponent("RawImageLoader", "petImage")
  self.titleBg = self:GetUIComponent("RawImageLoader", "titleBg")
  self.countdownBg = self:GetUIComponent("RawImageLoader", "countdownBg")
  self.txtTitle = self:GetUIComponent("UILocalizationText", "txtTitle")
  self.txtcontent = self:GetUIComponent("UILocalizationText", "txtcontent")
  self.txtCountdown = self:GetUIComponent("UILocalizationText", "txtCountdown")
end

function UISeasonPreviewController:OnValue()
  local cfg = Cfg.cfg_season_preview[self.previewId]
  if not cfg then
    Log.error("err UISeasonPreviewController can't cfg_season_preview find  with id = " .. self.previewId)
    return
  end
  self.bg:LoadImage(cfg.PopBg)
  self.petImage:LoadImage(cfg.PopPetImg)
  self.titleBg:LoadImage(cfg.PopTitleImg)
  self.countdownBg:LoadImage(cfg.PopTimeImg)
  self.txtTitle:SetText(StringTable.Get(cfg.PopTitleTxt))
  self.txtcontent:SetText(StringTable.Get(cfg.PopContentTxt))
  self.txtCountdown:SetText(StringTable.Get("str_season_preview_open_time", cfg.SeasonOpenTime))
end
