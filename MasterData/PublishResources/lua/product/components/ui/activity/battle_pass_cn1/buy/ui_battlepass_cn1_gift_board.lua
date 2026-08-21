_class("UIBattlePassCN1GiftBoard", UICustomWidget)
UIBattlePassCN1GiftBoard = UIBattlePassCN1GiftBoard

function UIBattlePassCN1GiftBoard:OnShow()
end

function UIBattlePassCN1GiftBoard:OnHide()
end

function UIBattlePassCN1GiftBoard:SetData(campaign, type, callback)
  self._campaign = campaign
  self._type = type
  self._callback = callback
  self._cmptId, self._component, self._componentInfo = UIActivityBattlePassHelper.Component_BuyGift(self._campaign)
  local giftId = self._component:GetFirstGiftIDByType(self._type)
  local price = self._component:GetGiftPriceForShowById(giftId, true, true)
  self._dynamicListInfo = self._component:GetGiftCfgShowAwardById(giftId)
  self._dynamicListInfo = self:_RemoveFirstData(self._dynamicListInfo)
  UIBattlePassStyleHelper.FitStyle_Widget(self._campaign, self)
  self:_SetState(self._type)
  self:_SetBg()
  self:_SetTitle()
  self:_SetMainImg()
  self:_SetDescImg()
  self:_SetDesc()
  self:_SetPriceSign()
  self:_SetPrice(price)
  self:_SetBuyBtn()
  self:_SetRewards()
end

function UIBattlePassCN1GiftBoard:_SetState(state)
  local tb = {
    [CampaignGiftType.ECGT_ADVANCED] = {
      "Title",
      "Price",
      "desc1",
      "desc2"
    },
    [CampaignGiftType.ECGT_LUXURY] = {
      "Title_Deluxe",
      "Price_Deluxe",
      "desc3_Deluxe"
    },
    [CampaignGiftType.ECGT_ADDITIONALBUY] = {
      "Title_Deluxe",
      "Price_Deluxe",
      "desc3_Deluxe"
    }
  }
  self._stateObj = UIWidgetHelper.GetObjGroupByWidgetName(self, tb, self._stateObj)
  UIWidgetHelper.SetObjGroupShow(self._stateObj, state)
end

function UIBattlePassCN1GiftBoard:_TypeConvertStyleKey()
  local convert = {
    [CampaignGiftType.ECGT_ADVANCED] = "_advanced",
    [CampaignGiftType.ECGT_LUXURY] = "_luxury",
    [CampaignGiftType.ECGT_ADDITIONALBUY] = "_addition"
  }
  return convert[self._type]
end

function UIBattlePassCN1GiftBoard:_SetBg()
  local tb = UIBattlePassStyleHelper.GetStyleInfo_KeyWidgetName(self._campaign, self, "_Bg")
  local key = self:_TypeConvertStyleKey()
  local styleInfo = tb[key] or {}
  UIStyleHelper.FitStyle_Widget(styleInfo, self, "_bg")
end

function UIBattlePassCN1GiftBoard:_SetTitle()
  local tb = {
    [CampaignGiftType.ECGT_ADVANCED] = "str_activity_battlepass_elite",
    [CampaignGiftType.ECGT_LUXURY] = "str_activity_battlepass_deluxe",
    [CampaignGiftType.ECGT_ADDITIONALBUY] = "str_activity_battlepass_deluxe"
  }
  local text = StringTable.Get(tb[self._type])
  UIWidgetHelper.SetLocalizationText(self, "txtTitle", text)
  UIWidgetHelper.SetLocalizationText(self, "txtTitle_Deluxe", text)
end

function UIBattlePassCN1GiftBoard:_SetMainImg()
  local tb = UIBattlePassStyleHelper.GetStyleInfo_KeyWidgetName(self._campaign, self, "_mainImg")
  local key = self:_TypeConvertStyleKey()
  local styleInfo = tb[key] or {}
  UIStyleHelper.FitStyle_Widget(styleInfo, self, "_mainImg")
end

function UIBattlePassCN1GiftBoard:_SetDescImg()
  local tb = UIBattlePassStyleHelper.GetStyleInfo_KeyWidgetName(self._campaign, self, "_descImg")
  local key = self:_TypeConvertStyleKey()
  local styleInfo = tb[key] or {}
  UIStyleHelper.FitStyle_Widget(styleInfo, self, "_descImg")
end

function UIBattlePassCN1GiftBoard:_SetDesc()
  local strId = UIActivityBattlePassHelper.GetStrIdInCampaign(self._campaign, "str_activity_battlepass_n5_cg_name_1")
  local text2 = StringTable.Get(strId)
  UIWidgetHelper.SetLocalizationText(self, "desc1", text2)
  if self._type == CampaignGiftType.ECGT_LUXURY or self._type == CampaignGiftType.ECGT_ADDITIONALBUY then
    local tb = UIBattlePassStyleHelper.GetStyleInfo_KeyWidgetName(self._campaign, self, "_deluxeDesc")
    local color = tb.color.textColor
    local text = StringTable.Get("str_activity_battlepass_buy_deluxe_desc_color", color)
    UIWidgetHelper.SetLocalizationText(self, "desc3_Deluxe", text)
  end
end

function UIBattlePassCN1GiftBoard:_SetPriceSign()
  local isShow = UIActivityZhHelper.IsZh()
  self:GetGameObject("txtPriceSign"):SetActive(isShow)
  self:GetGameObject("txtPriceSign_Deluxe"):SetActive(isShow)
end

function UIBattlePassCN1GiftBoard:_SetPrice(price)
  UIWidgetHelper.SetLocalizationText(self, "txtPrice", tostring(price))
  UIWidgetHelper.SetLocalizationText(self, "txtPrice_Deluxe", tostring(price))
end

function UIBattlePassCN1GiftBoard:_SetBuyBtn()
  local tb = {
    [CampaignGiftType.ECGT_ADVANCED] = self._componentInfo.m_buy_state ~= BuyGiftStateType.EBGST_INIT,
    [CampaignGiftType.ECGT_LUXURY] = self._componentInfo.m_buy_state == BuyGiftStateType.EBGST_LUXURY,
    [CampaignGiftType.ECGT_ADDITIONALBUY] = self._componentInfo.m_buy_state == BuyGiftStateType.EBGST_LUXURY
  }
  local allreadyBuy = tb[self._type]
  self:GetGameObject("buyBtn"):SetActive(not allreadyBuy)
  self:GetGameObject("Purchased"):SetActive(allreadyBuy)
end

function UIBattlePassCN1GiftBoard:_SetRewards()
  local objs = UIWidgetHelper.SpawnObjects(self, "Content", "UIBattlePassCN1IconText", #self._dynamicListInfo)
  for i, v in ipairs(objs) do
    local info = self._dynamicListInfo[i]
    v:SetData(i, info.ShowIcon, info.ShowDesc)
    UIBattlePassStyleHelper.FitStyle_Widget(self._campaign, v)
  end
end

function UIBattlePassCN1GiftBoard:_RemoveFirstData(tb)
  local newTb = {}
  for i, v in ipairs(tb) do
    if i ~= 1 then
      table.insert(newTb, v)
    end
  end
  return newTb
end

function UIBattlePassCN1GiftBoard:BuyBtnOnClick(go)
  Log.info("UIBattlePassCN1GiftBoard:BuyBtnOnClick")
  if self._callback then
    self._callback(self._type)
  end
end
