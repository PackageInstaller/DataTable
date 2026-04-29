_class("UIHauteCoutureDrawPrizeItemBLHReview2", UIHauteCoutureDrawPrizeItemBase)
UIHauteCoutureDrawPrizeItemBLHReview2 = UIHauteCoutureDrawPrizeItemBLHReview2

function UIHauteCoutureDrawPrizeItemBLHReview2:Constructor()
end

function UIHauteCoutureDrawPrizeItemBLHReview2:OnShow(uiParams)
  self:InitWidget()
end

function UIHauteCoutureDrawPrizeItemBLHReview2:InitWidget()
  self._atlas = self:GetAsset("UIHauteCoutureBLH.spriteatlas", LoadType.SpriteAtlas)
  self.bg = self:GetUIComponent("Image", "bg")
  self.coinBg = self:GetGameObject("coinBg")
  self.coinNum = self:GetUIComponent("UILocalizationText", "coinNum")
  self.image = self:GetUIComponent("RawImageLoader", "Image")
  self.imageRt = self:GetUIComponent("RectTransform", "Image")
  self.receiveImg = self:GetGameObject("receiveImg")
  self.gray = self:GetGameObject("gray")
  self.black = self:GetGameObject("black")
  self.amountText = self:GetUIComponent("UILocalizationText", "amountText")
  self.review_Image = self:GetGameObject("Review_Image")
  self._anim = self:GetUIComponent("Animation", "anim")
end

function UIHauteCoutureDrawPrizeItemBLHReview2:_OnValue()
  if not self._specail then
    if self._coinNum > 0 then
      self.coinBg:SetActive(true)
      self.coinNum:SetText("×" .. self._coinNum)
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
      self.bg.sprite = self._atlas:GetSprite("blhsenior_zjm_kuang02_re")
      local color = Color(0.8784313725490196, 0.8274509803921568, 0.6588235294117647)
      self.coinNum.color = color
      self.amountText.color = color
    elseif uiType == 3 then
      self.bg.sprite = self._atlas:GetSprite("blhsenior_zjm_kuang03_re")
      local color = Color(0.8784313725490196, 0.9372549019607843, 0.9607843137254902)
      self.coinNum.color = color
      self.amountText.color = color
    elseif uiType == 4 then
      self.bg.sprite = self._atlas:GetSprite("blhsenior_zjm_kuang04_re")
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
    if 0 < self._itemCount then
      self.coinBg:SetActive(true)
      self.coinNum:SetText("×" .. self._itemCount)
    else
      self.coinBg:SetActive(false)
    end
  end
end

function UIHauteCoutureDrawPrizeItemBLHReview2:Flush(state)
  self.receiveImg:SetActive(state)
end

function UIHauteCoutureDrawPrizeItemBLHReview2:SetGray(gray)
  self.gray:SetActive(not gray)
end

function UIHauteCoutureDrawPrizeItemBLHReview2:SetBlack(black)
  self.black:SetActive(not black)
end

function UIHauteCoutureDrawPrizeItemBLHReview2:SetData(prizeSortOrder, componentId, specail, ctx, replaced, callback)
  self._data = Cfg.cfg_component_senior_skin_weight({ComponentID = componentId, RewardSortOrder = prizeSortOrder})[1]
  if replaced then
    self._itemId = self._data.ReplaceRewardID
    self._itemCount = self._data.ReplaceRewardCount
  else
    self._itemId = self._data.RewardID
    self._itemCount = self._data.RewardCount
  end
  self._coinNum = self._data.AppendGlow
  self._specail = specail
  self._replaced = replaced
  self._ctx = ctx
  self._componentId = componentId
  self._callback = callback
  self:_OnValue()
  self:_InsertReward()
end

function UIHauteCoutureDrawPrizeItemBLHReview2:BgOnClick(go)
  if self._specail and self._itemId > RoleAssetID.RoleAssetPetSkinBegin and self._itemId < RoleAssetID.RoleAssetPetSkinEnd then
    self:ShowDialog("UIPetSkinsMainController", PetSkinUiOpenType.PSUOT_TIPS, self._itemId - 4000000)
  end
end

function UIHauteCoutureDrawPrizeItemBLHReview2:CoinImgOnClick(go)
  if not self._specail then
    self._callback(RoleAssetID.RoleAssetGlow, go.transform.position)
  end
end

function UIHauteCoutureDrawPrizeItemBLHReview2:ItemImageOnClick(go)
  if not self._specail then
    self._callback(self._itemId, go.transform.position)
  end
end

function UIHauteCoutureDrawPrizeItemBLHReview2:PlayGetAnim()
  local yieldTime = 1567
  local animName = "uianim_UIHauteCoutureDrawPrizeItemSpecialBLH_Review2_get"
  self:Lock("UIHauteCoutureDrawPrizeItemBLHReview2_PlayGetAnim")
  if self._specail then
    yieldTime = 1567
    animName = "uianim_UIHauteCoutureDrawPrizeItemSpecialBLH_Review2_get"
  else
    yieldTime = 1934
    animName = "uianim_UIHauteCoutureDrawPrizeItemBLH_Review2_get"
  end
  self:StartTask(function(TT)
    self._anim:Play(animName)
    YIELD(TT, yieldTime)
    self:UnLock("UIHauteCoutureDrawPrizeItemBLHReview2_PlayGetAnim")
  end)
  return yieldTime
end
