_class("UIHauteCoutureDrawPrizeItemBLH", UIHauteCoutureDrawPrizeItemBase)
UIHauteCoutureDrawPrizeItemBLH = UIHauteCoutureDrawPrizeItemBLH

function UIHauteCoutureDrawPrizeItemBLH:Constructor()
end

function UIHauteCoutureDrawPrizeItemBLH:OnShow(uiParams)
  self:InitWidget()
end

function UIHauteCoutureDrawPrizeItemBLH:InitWidget()
  self._atlas = self:GetAsset("UIHauteCoutureBLH.spriteatlas", LoadType.SpriteAtlas)
  self.bg = self:GetUIComponent("Image", "bg")
  self.coinBg = self:GetGameObject("coinBg")
  self.coinNum = self:GetUIComponent("UILocalizationText", "coinNum")
  self.image = self:GetUIComponent("RawImageLoader", "Image")
  self.imageRt = self:GetUIComponent("RectTransform", "Image")
  self.receiveImg = self:GetGameObject("receiveImg")
  self.gray = self:GetGameObject("gray")
  self.amountText = self:GetUIComponent("UILocalizationText", "amountText")
  self.review_Image = self:GetGameObject("Review_Image")
end

function UIHauteCoutureDrawPrizeItemBLH:_OnValue()
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
      self.bg.sprite = self._atlas:GetSprite("blhsenior_zjm_kuang02")
      local color = Color(0.8784313725490196, 0.8274509803921568, 0.6588235294117647)
      self.coinNum.color = color
      self.amountText.color = color
    elseif uiType == 3 then
      self.bg.sprite = self._atlas:GetSprite("blhsenior_zjm_kuang03")
      local color = Color(0.8784313725490196, 0.9372549019607843, 0.9607843137254902)
      self.coinNum.color = color
      self.amountText.color = color
    elseif uiType == 4 then
      self.bg.sprite = self._atlas:GetSprite("blhsenior_zjm_kuang04")
      local color = Color(0.9568627450980393, 0.8352941176470589, 0.7529411764705882)
      self.coinNum.color = color
      self.amountText.color = color
    end
    local rewardCount = self._data.RewardCount
    if 1 < rewardCount then
      local str = ""
      if rewardCount < 1000 then
        str = rewardCount
      else
        str = math.floor(rewardCount / 1000) .. "k"
      end
      self.amountText:SetText("×" .. str)
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
  else
    self.review_Image:SetActive(self._replaced)
  end
end

function UIHauteCoutureDrawPrizeItemBLH:Flush(state)
  self.receiveImg:SetActive(state)
end

function UIHauteCoutureDrawPrizeItemBLH:SetGray(gray)
  self.gray:SetActive(gray)
end

function UIHauteCoutureDrawPrizeItemBLH:BgOnClick(go)
  if self._itemId > RoleAssetID.RoleAssetPetSkinBegin and self._itemId < RoleAssetID.RoleAssetPetSkinEnd then
    self:ShowDialog("UIPetSkinsMainController", PetSkinUiOpenType.PSUOT_TIPS, self._itemId - 4000000)
  else
    self:ShowDialog("UIHauteCoutureDrawGetItemV2Controller", self._assetList, StringTable.Get(self._data.DesName), true, nil, self._ctx)
  end
end
