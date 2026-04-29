_class("UIHauteCoutureDrawPrizeItemPLM", UIHauteCoutureDrawPrizeItemBase)
UIHauteCoutureDrawPrizeItemPLM = UIHauteCoutureDrawPrizeItemPLM

function UIHauteCoutureDrawPrizeItemPLM:Constructor()
end

function UIHauteCoutureDrawPrizeItemPLM:OnShow(uiParams)
  self:InitWidget()
end

function UIHauteCoutureDrawPrizeItemPLM:InitWidget()
  self._atlas = self:GetAsset("UIHauteCoutureDrawPLM.spriteatlas", LoadType.SpriteAtlas)
  self.bg = self:GetUIComponent("Image", "bg")
  self.coinBg = self:GetGameObject("coinBg")
  self.coinNum = self:GetUIComponent("UILocalizationText", "coinNum")
  self.image = self:GetUIComponent("RawImageLoader", "Image")
  self.imageRt = self:GetUIComponent("RectTransform", "Image")
  self.receiveImg = self:GetGameObject("receiveImg")
  self.gray = self:GetGameObject("gray")
  self.amountText = self:GetUIComponent("UILocalizationText", "amountText")
  self._bgCanvas = self:GetUIComponent("CanvasGroup", "bg")
end

function UIHauteCoutureDrawPrizeItemPLM:PlayAnim(time)
  self._anim = self:GetUIComponent("Animation", "anim")
  self:StartTask(function(TT)
    YIELD(TT, time * 15)
    self._bgCanvas.alpha = 1
  end)
end

function UIHauteCoutureDrawPrizeItemPLM:_OnValue()
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
      self.bg.sprite = self._atlas:GetSprite("plmsenior_zjm_kuang02")
    elseif uiType == 3 then
      self.bg.sprite = self._atlas:GetSprite("plmsenior_zjm_kuang03")
    elseif uiType == 4 then
      self.bg.sprite = self._atlas:GetSprite("plmsenior_zjm_kuang04")
    end
    local rewardCount = self._itemCount
    if 1 < rewardCount then
      self.amountText:SetText("×" .. rewardCount)
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
    local icon
    local cfg = Cfg.cfg_senior_skin_draw({
      ComponentId = self._data.ComponentID
    })[1]
    if self._replaced then
      icon = cfg.ReplaceSpecailIcon
      local count = self:GetUIComponent("UILocalizationText", "ReviewCount")
      count:SetText(self._itemCount)
    else
      icon = cfg.SpecailIcon
    end
    self.image:LoadImage(icon)
  end
end

function UIHauteCoutureDrawPrizeItemPLM:Flush(state)
  self.receiveImg:SetActive(state)
end

function UIHauteCoutureDrawPrizeItemPLM:SetGray(gray)
  self.gray:SetActive(gray)
end

function UIHauteCoutureDrawPrizeItemPLM:BgOnClick(go)
  if self._itemId > RoleAssetID.RoleAssetPetSkinBegin and self._itemId < RoleAssetID.RoleAssetPetSkinEnd then
    self:ShowDialog("UIPetSkinsMainController", PetSkinUiOpenType.PSUOT_TIPS, self._itemId - 4000000)
  else
    self:ShowDialog("UIHauteCoutureDrawGetItemV2Controller", self._assetList, StringTable.Get(self._data.DesName), true, nil, self._ctx)
  end
end
