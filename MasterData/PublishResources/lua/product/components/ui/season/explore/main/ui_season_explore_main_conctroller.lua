_class("UISeasonExploreMainController", UIController)
UISeasonExploreMainController = UISeasonExploreMainController

function UISeasonExploreMainController:LoadDataOnEnter(TT, res)
  res:SetSucc(true)
end

function UISeasonExploreMainController:OnShow(uiParams)
  self.seasonModule = GameGlobal.GetModule(SeasonModule)
  self:InitWidget()
  self._timerHolder = UITimerHolder:New()
  self:_OnValue()
  self:AttachEvent(GameEventType.ItemCountChanged, self.OnItemCountChange)
end

function UISeasonExploreMainController:OnHide()
  self._timerHolder:Dispose()
  self:DetachEvent(GameEventType.ItemCountChanged, self.OnItemCountChange)
end

function UISeasonExploreMainController:InitWidget()
  local topBtns = self:GetUIComponent("UISelectObjectPath", "TopBtns")
  self._backBtns = topBtns:SpawnObject("UICommonTopButton")
  self._backBtns:SetData(function()
    self:SwitchState(UIStateType.UIMain)
  end, function()
    UISeasonHelper.ShowSeasonHelperBook(2)
  end, nil, false, function()
    self:FocusSeasonBg()
  end)
  self.previewName = self:GetUIComponent("UILocalizationText", "previewName")
  self.previewPet = self:GetUIComponent("RawImageLoader", "preViewPet")
  self.previewCountDown = self:GetUIComponent("UILocalizationText", "previewCountDown")
  self.coinNum = self:GetUIComponent("UILocalizationText", "coinNum")
  self.coinNumTop = self:GetUIComponent("UILocalizationText", "coinNumTop")
  self.imgCoin = self:GetUIComponent("Image", "imgCoin")
  self.previewBtnGo = self:GetGameObject("previewBtn")
  self.newCollectionGo = self:GetGameObject("newCollection")
  self.newMealGo = self:GetGameObject("newMeal")
  self.newPreviewGo = self:GetGameObject("newPreview")
  self.newExchangeGo = self:GetGameObject("newExchange")
  self.showBtnGo = self:GetGameObject("showBtn")
  self.contentGo = self:GetGameObject("content")
  self.curSeasonImage = self:GetUIComponent("RawImageLoader", "curSean")
  self.curSeasonImageGo = self:GetGameObject("curSean")
  local topTipsPool = self:GetUIComponent("UISelectObjectPath", "toptips")
  self._topTipsInfo = topTipsPool:SpawnObject("UITopTipsContext")
  self.tipsPos = self:GetGameObject("tipsPos")
  self.curCountDownTxt = self:GetUIComponent("UILocalizationText", "curCountDownTxt")
end

function UISeasonExploreMainController:_OnValue()
  self:RefreshPreview()
  self:RefrshCurSeason()
  self:RefreshNews()
  self:RefreshExchangeInfo()
end

function UISeasonExploreMainController:FocusSeasonBg()
  self.showBtnGo:SetActive(true)
  self.contentGo:SetActive(false)
end

function UISeasonExploreMainController:RefrshCurSeason()
  self.seasonId = nil
  local curSample = self.seasonModule:GetCurSeasonSample()
  self.seasonId = curSample.id
  local svrTime = GameGlobal.GetModule(SvrTimeModule):GetServerTime() * 0.001
  if svrTime > curSample.begin_time and svrTime < curSample.end_time then
    self.curSeasonImageGo:SetActive(true)
    local cfg = Cfg.cfg_season_campaign_client[self.seasonId]
    if cfg then
      self.curSeasonImage:LoadImage(cfg.Theme)
    else
      Log.error("can't find cfg_season_campaign_client with id = " .. self.seasonId)
      self.curSeasonImageGo:SetActive(false)
    end
    local closeTime = curSample.end_time
    local timerName = "SeasonCountDown"
    
    local function countDown()
      local now = self:GetModule(SvrTimeModule):GetServerTime() / 1000
      local time = math.ceil(closeTime - now)
      local timeStr = UIActivityHelper.GetFormatTimerStr(time)
      if self._curSeasontimeString ~= timeStr then
        self.curCountDownTxt:SetText(StringTable.Get("str_season_clsoe_countdown", timeStr))
        self._curSeasontimeString = timeStr
      end
      if time < 0 then
        self._timerHolder:StopTimer(timerName)
        self.curCountDownTxt:SetText("")
        self.curSeasonImageGo:SetActive(false)
      end
    end
    
    countDown()
    self._timerHolder:StartTimerInfinite(timerName, 1000, countDown)
  else
    self.curSeasonImageGo:SetActive(false)
  end
end

function UISeasonExploreMainController:RefreshPreview()
  local cfg, openTime = UISeasonExploreHelper.GetPreviewCfg()
  self.preViewCfg = cfg
  self.previewBtnGo:SetActive(self.preViewCfg ~= nil)
  if not self.preViewCfg then
    return
  end
  self.previewPet:LoadImage(self.preViewCfg.PetIcon)
  self.previewName:SetText(self.preViewCfg.Title)
  local timerName = "PreviewCountDown"
  
  local function countDown()
    local now = self:GetModule(SvrTimeModule):GetServerTime() / 1000
    local time = math.ceil(openTime - now)
    local timeStr = UIActivityHelper.GetFormatTimerStr(time)
    if self._timeString ~= timeStr then
      self.previewCountDown:SetText(StringTable.Get("str_season_preview_countdown", timeStr))
      self._timeString = timeStr
    end
    if time < 0 then
      self._timerHolder:StopTimer(timerName)
    end
  end
  
  countDown()
  self._timerHolder:StartTimerInfinite(timerName, 1000, countDown)
end

function UISeasonExploreMainController:RefreshNews()
  local previewNew = false
  if self.preViewCfg then
    previewNew = not UISeasonExploreHelper.IsPreviewHasClicked(self.preViewCfg.ID)
  end
  self.newPreviewGo:SetActive(previewNew)
  local collectionNew = UISeasonExploreHelper.IsSeasonCgHasNew() or UISeasonExploreHelper.IsSeasonMusicHasNew() or UISeasonExploreHelper.IsSeasonRareItemHasNew()
  self.newCollectionGo:SetActive(collectionNew)
end

function UISeasonExploreMainController:RefreshExchangeInfo()
  local coinType = RoleAssetID.RoleAssetHistory
  local cfg = Cfg.cfg_top_tips[coinType]
  if cfg then
    local atlas = self:GetAsset("UICommon.spriteatlas", LoadType.SpriteAtlas)
    self.imgCoin.sprite = atlas:GetSprite(cfg.Icon)
  end
  local itemModule = self:GetModule(ItemModule)
  local countStr = HelperProxy:GetInstance():Format9999W(itemModule:GetItemCount(coinType))
  self.coinNum:SetText(countStr)
  self.coinNumTop:SetText(countStr)
end

function UISeasonExploreMainController:OnItemCountChange()
  self:RefreshExchangeInfo()
end

function UISeasonExploreMainController:CollectionBtnOnClick(go)
  self:ShowDialog("UISeasonCollectionController", function()
    self:RefreshNews()
  end)
end

function UISeasonExploreMainController:MedalBtnOnClick(go)
  self:ShowDialog("UIMedalGroupListController")
end

function UISeasonExploreMainController:PreviewBtnOnClick(go)
  if self.preViewCfg then
    UISeasonExploreHelper.SetPreviewAsClicked(self.preViewCfg.ID)
    self.newPreviewGo:SetActive(false)
    self:ShowDialog("UISeasonPreviewController", self.preViewCfg.ID)
  end
end

function UISeasonExploreMainController:ExChangeBtnOnClick(go)
  GameGlobal.GetUIModule(SeasonModule):EnterExchangeShopSeasonTab()
end

function UISeasonExploreMainController:ReviewBtnOnClick(go)
end

function UISeasonExploreMainController:StartBtnOnClick(go)
  local curSample = self.seasonModule:GetCurSeasonSample()
  local svrTime = GameGlobal.GetModule(SvrTimeModule):GetServerTime() * 0.001
  if svrTime > curSample.begin_time and svrTime < curSample.end_time then
    GameGlobal.GetUIModule(SeasonModule):OpenSeasonThemeUI()
  else
    ToastManager.ShowToast(StringTable.Get("str_season_no_tips"))
  end
end

function UISeasonExploreMainController:ShowBtnOnClick(go)
  self.showBtnGo:SetActive(false)
  self.contentGo:SetActive(true)
end

function UISeasonExploreMainController:PlotBtnOnClick(go)
  local plotId = Cfg.cfg_global.season_system_first_plot.IntValue
  GameGlobal.UIStateManager():ShowDialog("UIStoryController", plotId)
end

function UISeasonExploreMainController:ImgCoinOnClick(go)
  local coinType = RoleAssetID.RoleAssetHistory
  self._topTipsInfo:SetData(coinType, self.tipsPos)
end
