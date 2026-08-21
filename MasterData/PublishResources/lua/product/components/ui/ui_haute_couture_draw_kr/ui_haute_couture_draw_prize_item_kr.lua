_class("UIHauteCoutureDrawPrizeItemKR", UIHauteCoutureDrawPrizeItemBase)
UIHauteCoutureDrawPrizeItemKR = UIHauteCoutureDrawPrizeItemKR

function UIHauteCoutureDrawPrizeItemKR:Constructor()
end

function UIHauteCoutureDrawPrizeItemKR:OnShow(uiParams)
  self:InitWidget()
end

function UIHauteCoutureDrawPrizeItemKR:InitWidget()
  self._atlas = self:GetAsset("UIHauteCoutureKR.spriteatlas", LoadType.SpriteAtlas)
  self.bg = self:GetUIComponent("Image", "bg")
  self.coinBg = self:GetGameObject("coinBg")
  self.coinNum = self:GetUIComponent("UILocalizationText", "coinNum")
  self.image = self:GetUIComponent("RawImageLoader", "Image")
  self.imageRt = self:GetUIComponent("RectTransform", "Image")
  self.receiveImg = self:GetGameObject("receiveImg")
  self.receiveRL = self:GetUIComponent("RawImageLoader", "receiveImg")
  self.gray = self:GetGameObject("gray")
  self.amountText = self:GetUIComponent("UILocalizationText", "amountText")
end

function UIHauteCoutureDrawPrizeItemKR:_OnValue()
  if not self._specail then
    if self._coinNum > 0 then
      self.coinBg:SetActive(true)
      self.coinNum:SetText(self._coinNum)
    else
      self.coinBg:SetActive(false)
    end
    local cfg = Cfg.cfg_item[self._itemId]
    if cfg == nil then
      Log.fatal("cfg_item is nil." .. self._itemId)
    else
      local icon = cfg.Icon
      self.image:LoadImage(icon)
    end
    local uiType = self._data.UIType
    if uiType == 2 then
      self.bg.sprite = self._atlas:GetSprite("krsenior_zjm_kuang01")
    elseif uiType == 3 then
      self.bg.sprite = self._atlas:GetSprite("krsenior_zjm_kuang02")
    elseif uiType == 4 then
      self.bg.sprite = self._atlas:GetSprite("krsenior_zjm_kuang03")
    end
    local rewardCount = self._data.RewardCount
    if 1 < rewardCount then
      self.amountText:SetText("X" .. rewardCount)
    else
      self.amountText:SetText("")
    end
    local cfg = Cfg.cfg_global.SeniorSkinhead
    local headIds = cfg and cfg.ArrayValue
    for k, v in pairs(headIds) do
      if v == self._itemId then
        local sz = self.imageRt.sizeDelta
        sz.x = 190 * sz.y / 160
        self.imageRt.sizeDelta = sz
        break
      end
    end
    self.receiveRL:LoadImage("krsenior_re_zjm_mask1")
  else
    self.coinBg:SetActive(false)
    if self._replaced then
      local cfg = Cfg.cfg_senior_skin_draw({
        ComponentId = self._componentId
      })[1]
      self.image:LoadImage(cfg.ReplaceSpecailIcon)
    end
    self.receiveRL:LoadImage("krsenior_re_zjm_mask2")
  end
end

function UIHauteCoutureDrawPrizeItemKR:Flush(state)
  self.receiveImg:SetActive(state)
end

function UIHauteCoutureDrawPrizeItemKR:SetGray(gray)
  self.gray:SetActive(gray)
end

function UIHauteCoutureDrawPrizeItemKR:BgOnClick(go)
  if self._specail and not self._replaced then
    self:ShowDialog("UIPetSkinsMainController", PetSkinUiOpenType.PSUOT_TIPS, self._itemId - 4000000)
  else
    self:ShowDialog("UIHauteCoutureDrawGetItemV2Controller", self._assetList, StringTable.Get(self._data.DesName), true, nil, self._ctx)
  end
end
