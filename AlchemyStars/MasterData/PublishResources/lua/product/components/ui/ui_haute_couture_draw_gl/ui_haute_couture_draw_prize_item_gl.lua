_class("UIHauteCoutureDrawPrizeItemGL", UIHauteCoutureDrawPrizeItemBase)
UIHauteCoutureDrawPrizeItemGL = UIHauteCoutureDrawPrizeItemGL

function UIHauteCoutureDrawPrizeItemGL:Constructor()
end

function UIHauteCoutureDrawPrizeItemGL:OnShow(uiParams)
  self:InitWidget()
end

function UIHauteCoutureDrawPrizeItemGL:InitWidget()
  self._atlas = self:GetAsset("UIHauteCoutureGL.spriteatlas", LoadType.SpriteAtlas)
  self.bg = self:GetUIComponent("Image", "bg")
  self.coinBg = self:GetGameObject("coinBg")
  self.coinNum = self:GetUIComponent("UILocalizationText", "coinNum")
  self.image = self:GetUIComponent("RawImageLoader", "Image")
  self.imageRt = self:GetUIComponent("RectTransform", "Image")
  self.receiveImg = self:GetGameObject("receiveImg")
  self.gray = self:GetGameObject("gray")
  self.amountText = self:GetUIComponent("UILocalizationText", "amountText")
  self._review = self:GetGameObject("Review")
end

function UIHauteCoutureDrawPrizeItemGL:_OnValue()
  if not self._specail then
    if self._coinNum > 0 then
      self.coinBg:SetActive(true)
      self.coinNum:SetText("x" .. self._coinNum)
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
      self.bg.sprite = self._atlas:GetSprite("gl_senior_zjm_di06")
    elseif uiType == 3 then
      self.bg.sprite = self._atlas:GetSprite("gl_senior_zjm_di07")
    elseif uiType == 4 then
      self.bg.sprite = self._atlas:GetSprite("gl_senior_zjm_di08")
    end
    local rewardCount = self._itemCount
    if 0 < rewardCount then
      self.amountText:SetText("X" .. rewardCount)
    else
      self.amountText:SetText("")
    end
    local cfg = Cfg.cfg_global.SeniorSkinhead
    local headIds = cfg and cfg.ArrayValue
    if headIds then
      for k, v in pairs(headIds) do
        if v == self._itemId then
          local sz = self.imageRt.sizeDelta
          sz.x = 190 * sz.y / 160
          self.imageRt.sizeDelta = sz
          break
        end
      end
    end
  else
    local icon
    local cfg = Cfg.cfg_senior_skin_draw({
      ComponentId = self._data.ComponentID
    })[1]
    if self._replaced then
      icon = cfg.ReplaceSpecailIcon
      self._review:SetActive(true)
      local count = self:GetUIComponent("UILocalizationText", "ReviewCount")
      count:SetText(self._itemCount)
    else
      icon = cfg.SpecailIcon
      self._review:SetActive(false)
    end
    self.image:LoadImage(icon)
  end
end

function UIHauteCoutureDrawPrizeItemGL:Flush(state)
  self.receiveImg:SetActive(state)
end

function UIHauteCoutureDrawPrizeItemGL:SetGray(gray)
  self.gray:SetActive(gray)
end

function UIHauteCoutureDrawPrizeItemGL:BgOnClick(go)
  if self._itemId > RoleAssetID.RoleAssetPetSkinBegin and self._itemId < RoleAssetID.RoleAssetPetSkinEnd then
    self:ShowDialog("UIPetSkinsMainController", PetSkinUiOpenType.PSUOT_TIPS, self._itemId - 4000000)
  elseif self.clickCb then
    self.clickCb(self._assetList[1], go.transform.position)
  end
end

function UIHauteCoutureDrawPrizeItemGL:CoinImgOnClick(go)
  if self.clickCb then
    self.clickCb(self._assetList[2], go.transform.position)
  end
end
