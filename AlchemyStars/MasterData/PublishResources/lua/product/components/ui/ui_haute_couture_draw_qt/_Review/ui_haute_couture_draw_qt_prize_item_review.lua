require("ui_haute_couture_draw_prize_item_base")
_class("UIHauteCoutureDraw_QT_PrizeItem_Review", UIHauteCoutureDrawPrizeItemBase)
UIHauteCoutureDraw_QT_PrizeItem_Review = UIHauteCoutureDraw_QT_PrizeItem_Review

function UIHauteCoutureDraw_QT_PrizeItem_Review:Constructor()
end

function UIHauteCoutureDraw_QT_PrizeItem_Review:OnShow(uiParams)
  self:_InitWidgets()
  self._atlas = self:RootUIOwner():GetAsset("UIHauteCoutureQT.spriteatlas", LoadType.SpriteAtlas)
end

function UIHauteCoutureDraw_QT_PrizeItem_Review:_InitWidgets()
  self.bg = self:GetUIComponent("Image", "bg")
  self._receiveGo = self:GetGameObject("_receive")
  self._grayGo = self:GetGameObject("_gray")
  self._review = self:GetGameObject("Review")
end

function UIHauteCoutureDraw_QT_PrizeItem_Review:_OnValue()
  if self._specail then
    if self._replaced then
      local replaceGo = self:GetGameObject("replace")
      if replaceGo then
        replaceGo:SetActive(true)
      end
      local rewardCount = self._assetList[1].count
      local str = "X" .. rewardCount
      local txt = self:GetUIComponent("UILocalizedTMP", "txt")
      local txtshadow = self:GetUIComponent("UILocalizedTMP", "txtshadow")
      if txt then
        txt:SetText(str)
      end
      if txtshadow then
        txtshadow:SetText(str)
      end
    end
    return
  end
  self:_SetState()
  self:_SetCoin(self._coinNum)
  self:_SetRewardIcon(self._itemId)
  self:_SetRewardCount(self._data.RewardCount)
end

function UIHauteCoutureDraw_QT_PrizeItem_Review:_SetState()
  local uiType = self._data.UIType
  if uiType == 2 then
    self.bg.sprite = self._atlas:GetSprite("qt_senior_zjm_di03")
  elseif uiType == 3 then
    self.bg.sprite = self._atlas:GetSprite("qt_senior_zjm_di04")
  elseif uiType == 4 then
    self.bg.sprite = self._atlas:GetSprite("qt_senior_zjm_di05")
  end
end

function UIHauteCoutureDraw_QT_PrizeItem_Review:_SetCoin(num)
  local show = 0 < num
  self:GetGameObject("_coin"):SetActive(show)
  UIWidgetHelper.SetLocalizationText(self, "_coinNum_2_gold", "x" .. num)
end

function UIHauteCoutureDraw_QT_PrizeItem_Review:_SetRewardIcon(itemId)
  local widgetName = "_icon"
  local cfg = Cfg.cfg_item[itemId]
  if cfg == nil then
    Log.fatal("cfg_item is nil." .. itemId)
  else
    local icon = cfg.Icon
    UIWidgetHelper.SetRawImage(self, widgetName, icon)
  end
  if self:_IsHead(itemId) then
    local rt = self:GetUIComponent("RectTransform", widgetName)
    local sz = rt.sizeDelta
    sz.x = 190 * sz.y / 160
    rt.sizeDelta = sz
  end
end

function UIHauteCoutureDraw_QT_PrizeItem_Review:_IsHead(itemId)
  local cfg = Cfg.cfg_global.SeniorSkinhead
  local headIds = cfg and cfg.ArrayValue
  for k, v in pairs(headIds) do
    if v == itemId then
      return true
    end
  end
  return false
end

function UIHauteCoutureDraw_QT_PrizeItem_Review:_SetRewardCount(rewardCount)
  local str = ""
  if 0 < rewardCount then
    str = rewardCount < 1000 and rewardCount or math.floor(rewardCount / 1000) .. "k"
    str = "x" .. str
  end
  UIWidgetHelper.SetLocalizationText(self, "_count_2_gold", str)
end

function UIHauteCoutureDraw_QT_PrizeItem_Review:Flush(state)
  self._receiveGo:SetActive(state)
end

function UIHauteCoutureDraw_QT_PrizeItem_Review:SetGray(gray)
  self._grayGo:SetActive(gray)
end

function UIHauteCoutureDraw_QT_PrizeItem_Review:PlayAnimation(idx)
  local delay = 0 + idx * 80
  local animName = "uieff_UIHauteCoutureDraw_QT_PrizeItem_in"
  UIWidgetHelper.PlayAnimationInSequence(self, "_anim", "_anim", animName, delay, 733)
end

function UIHauteCoutureDraw_QT_PrizeItem_Review:BgOnClick(go)
  if self._itemId > RoleAssetID.RoleAssetPetSkinBegin and self._itemId < RoleAssetID.RoleAssetPetSkinEnd then
    self:ShowDialog("UIPetSkinsMainController", PetSkinUiOpenType.PSUOT_TIPS, self._itemId - 4000000)
  elseif self.clickCb then
    self.clickCb(self._assetList[1], go.transform.position)
  end
end

function UIHauteCoutureDraw_QT_PrizeItem_Review:CoinImgOnClick(go)
  if self.clickCb then
    self.clickCb(self._assetList[2], go.transform.position)
  end
end
