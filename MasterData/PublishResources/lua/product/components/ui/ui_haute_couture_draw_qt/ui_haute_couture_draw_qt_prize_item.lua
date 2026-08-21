require("ui_haute_couture_draw_prize_item_base")
_class("UIHauteCoutureDraw_QT_PrizeItem", UIHauteCoutureDrawPrizeItemBase)
UIHauteCoutureDraw_QT_PrizeItem = UIHauteCoutureDraw_QT_PrizeItem

function UIHauteCoutureDraw_QT_PrizeItem:Constructor()
end

function UIHauteCoutureDraw_QT_PrizeItem:OnShow(uiParams)
end

function UIHauteCoutureDraw_QT_PrizeItem:_OnValue()
  if self._specail then
    return
  end
  self:_SetState(self._data.UIType)
  self:_SetCoin(self._coinNum)
  self:_SetRewardIcon(self._itemId)
  self:_SetRewardCount(self._data.RewardCount)
end

function UIHauteCoutureDraw_QT_PrizeItem:_SetState(state)
  local tb = {
    {""},
    {
      "_count_2_gold",
      "_coinBg_2_gold",
      "_coinNum_2_gold"
    },
    {
      "_count_3_silver",
      "_coinBg_3_silver",
      "_coinNum_3_silver"
    },
    {
      "_count_4_bronze",
      "_coinBg_4_bronze",
      "_coinNum_4_bronze"
    }
  }
  local objs = UIWidgetHelper.GetObjGroupByWidgetName(self, tb)
  UIWidgetHelper.SetObjGroupShow(objs, state)
end

function UIHauteCoutureDraw_QT_PrizeItem:_SetCoin(num)
  local show = 0 < num
  self:GetGameObject("_coin"):SetActive(show)
  local tb2 = {
    "_coinNum_2_gold",
    "_coinNum_3_silver",
    "_coinNum_4_bronze"
  }
  for _, v in ipairs(tb2) do
    UIWidgetHelper.SetLocalizationText(self, v, num)
  end
end

function UIHauteCoutureDraw_QT_PrizeItem:_SetRewardIcon(itemId)
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

function UIHauteCoutureDraw_QT_PrizeItem:_IsHead(itemId)
  local cfg = Cfg.cfg_global.SeniorSkinhead
  local headIds = cfg and cfg.ArrayValue
  for k, v in pairs(headIds) do
    if v == itemId then
      return true
    end
  end
  return false
end

function UIHauteCoutureDraw_QT_PrizeItem:_SetRewardCount(rewardCount)
  local str = ""
  if 1 < rewardCount then
    str = rewardCount < 1000 and rewardCount or math.floor(rewardCount / 1000) .. "k"
  end
  local tb = {
    "_count_2_gold",
    "_count_3_silver",
    "_count_4_bronze"
  }
  for _, v in ipairs(tb) do
    UIWidgetHelper.SetLocalizationText(self, v, str)
  end
end

function UIHauteCoutureDraw_QT_PrizeItem:Flush(state)
  self:GetGameObject("_receive"):SetActive(state)
end

function UIHauteCoutureDraw_QT_PrizeItem:SetGray(gray)
  self:GetGameObject("_gray"):SetActive(gray)
end

function UIHauteCoutureDraw_QT_PrizeItem:PlayAnimation(idx)
  local delay = 0 + idx * 80
  local animName = "uieff_UIHauteCoutureDraw_QT_PrizeItem_in"
  UIWidgetHelper.PlayAnimationInSequence(self, "_anim", "_anim", animName, delay, 733)
end

function UIHauteCoutureDraw_QT_PrizeItem:BgOnClick(go)
  if self._specail then
    self:ShowDialog("UIPetSkinsMainController", PetSkinUiOpenType.PSUOT_TIPS, self._itemId - 4000000)
  else
    self:ShowDialog("UIHauteCoutureDrawGetItemV2Controller", self._assetList, StringTable.Get(self._data.DesName), true, nil, self._ctx)
  end
end
