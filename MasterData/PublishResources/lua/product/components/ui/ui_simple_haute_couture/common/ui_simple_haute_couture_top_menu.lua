_class("UISimpleHauteCoutureTopMenu", UICustomWidget)
UISimpleHauteCoutureTopMenu = UISimpleHauteCoutureTopMenu

function UISimpleHauteCoutureTopMenu:Constructor()
end

function UISimpleHauteCoutureTopMenu:OnShow(uiParams)
  self:_GetComponents()
  self:AttachEvent(GameEventType.ItemCountChanged, self.OnItemCountChanged)
  self:AttachEvent(GameEventType.DiamondCountChanged, self.OnItemCountChanged)
end

function UISimpleHauteCoutureTopMenu:_GetComponents()
  self._ticketIcon = self:GetUIComponent("Image", "ticketIcon")
  self._ticketText = self:GetUIComponent("UILocalizationText", "ticketText")
  self._moneyIcon = self:GetUIComponent("Image", "moneyIcon")
  self._moneyText = self:GetUIComponent("UILocalizationText", "moneyText")
  self._scoreIcon = self:GetUIComponent("Image", "scoreIcon")
  self._scoreText = self:GetUIComponent("UILocalizationText", "ScoreText")
  self._ticketPanelObj = self:GetGameObject("ticketPanel")
  self._moneyPanelObj = self:GetGameObject("moneyPanel")
  self._scorePanelObj = self:GetGameObject("scorePanel")
  self.atlas = self:GetAsset("UICommon.spriteatlas", LoadType.SpriteAtlas)
  self._ticketAddObj = self:GetGameObject("TicketAdd")
  self._btnZJJSFObj = self:GetGameObject("BtnZJJSF")
  self._btnTSFObj = self:GetGameObject("BtnTSF")
  self:ShowHideTSFBtn(false)
end

function UISimpleHauteCoutureTopMenu:SetData(topTipsInfo, ticketID, costID, scoreID, ticketCallback, hideTicket, hideMoney, hideScore)
  self._topTipsInfo = topTipsInfo
  self._showExchangeList = {
    ticketID,
    costID,
    scoreID
  }
  self._ticketCallback = ticketCallback
  self._ticketPanelObj:SetActive(not hideTicket)
  self._moneyPanelObj:SetActive(not hideMoney)
  self._scorePanelObj:SetActive(not hideScore)
  self:_Init()
end

function UISimpleHauteCoutureTopMenu:_Init()
  local mShop = self:GetModule(ShopModule)
  local itemModule = self:GetModule(ItemModule)
  local count1, freeCount1 = mShop:GetDiamondCount()
  self._moneyText:SetText(count1)
  self._ticketText:SetText(itemModule:GetItemCount(self._showExchangeList[1]))
  self._scoreText:SetText(itemModule:GetItemCount(self._showExchangeList[3]))
  self._cfg1 = Cfg.cfg_top_tips[self._showExchangeList[1]]
  self._cfg2 = Cfg.cfg_top_tips[self._showExchangeList[2]]
  self._cfg3 = Cfg.cfg_top_tips[self._showExchangeList[3]]
  if self._cfg1 then
    self._ticketIcon.sprite = self.atlas:GetSprite(self._cfg1.Icon)
  else
    Log.exception("请在cfg_top_tips中配置：", self._showExchangeList[1])
  end
  self._moneyIcon.sprite = self.atlas:GetSprite(self._cfg2.Icon)
  if self._cfg3 then
    self._scoreIcon.sprite = self.atlas:GetSprite(self._cfg3.Icon)
  else
    Log.exception("请在cfg_top_tips中配置：", self._showExchangeList[3])
  end
end

function UISimpleHauteCoutureTopMenu:OnItemCountChanged()
  self:_Init()
end

function UISimpleHauteCoutureTopMenu:TicketTexBtnOnClick()
  if self._topTipsInfo then
    local go = self:GetGameObject("ticketIcon")
    self._topTipsInfo:SetData(self._showExchangeList[1], go)
  end
end

function UISimpleHauteCoutureTopMenu:TicketAddOnClick()
  if self._ticketCallback then
    self._ticketCallback()
  end
end

function UISimpleHauteCoutureTopMenu:MoneyTexBtnOnClick()
  if self._topTipsInfo then
    local go = self:GetGameObject("moneyIcon")
    self._topTipsInfo:SetData(self._showExchangeList[2], go)
  end
end

function UISimpleHauteCoutureTopMenu:MoneyAddOnClick()
  local mShop = self:GetModule(ShopModule)
  local clientShop = mShop:GetClientShop()
  clientShop:OpenRechargeShop()
end

function UISimpleHauteCoutureTopMenu:ScoreTexBtnOnClick()
  if self._topTipsInfo then
    local go = self:GetGameObject("scoreIcon")
    self._topTipsInfo:SetData(self._showExchangeList[3], go)
  end
end

function UISimpleHauteCoutureTopMenu:HideTicketAddBtn()
  self._ticketAddObj:SetActive(false)
end

function UISimpleHauteCoutureTopMenu:ShowHideTSFBtn(isShow)
  local roleModule = GameGlobal.GetModule(RoleModule)
  local isJapanZone = roleModule:IsJapanZone()
  if isJapanZone then
    self._btnZJJSFObj:SetActive(isShow)
    self._btnTSFObj:SetActive(isShow)
  else
    self._btnZJJSFObj:SetActive(false)
    self._btnTSFObj:SetActive(false)
  end
end

function UISimpleHauteCoutureTopMenu:BtnZJJSFOnClick()
  self:ShowDialog("UIPayLawContentController", 2)
end

function UISimpleHauteCoutureTopMenu:BtnTSFOnClick()
  self:ShowDialog("UIPayLawContentController", 1)
end
