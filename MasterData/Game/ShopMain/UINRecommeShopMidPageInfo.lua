local UINRecommeShopMidPageInfo = class("UINRecommeShopMidPageInfo", UIBaseNode)
local base = UIBaseNode

function UINRecommeShopMidPageInfo:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.gameObject:SetActive(false)
  self.payGiftCtrl = ControllerManager:GetController(ControllerTypeId.PayGift, true)
end

function UINRecommeShopMidPageInfo:InitRecommeShopMidPageInfo(middleCfg)
  local recommendId = middleCfg.jump_arg[2]
  self.middleData = self.payGiftCtrl:GetPayGiftDataById(recommendId)
  self:ShowMidPageInfo(self.middleData)
end

function UINRecommeShopMidPageInfo:ShowMidPageInfo(data)
  if data == nil then
    self.gameObject:SetActive(false)
    return
  end
  self.gameObject:SetActive(true)
  self.ui.tex_Name.text = LanguageUtil.GetLocaleText(data.groupCfg.name)
  local showOldPrice, oldPrice = data:TryGetPayGiftOldPrice()
  if showOldPrice then
    self.ui.tex_OldPrice.gameObject:SetActive(true)
    self.ui.tex_OldPrice.text = self:GetShopMidPageInfoPriceStr(oldPrice)
  else
    self.ui.tex_OldPrice.gameObject:SetActive(false)
  end
  local priceNum = data.defaultCfg.cur_price
  if not data:IsUseItemPay() and LanguageUtil.LanguageInt == eLanguageType.EN_US then
    priceNum = FormatNum(priceNum / 100)
  end
  self.ui.tex_CurrentPrice.text = self:GetShopMidPageInfoPriceStr(priceNum)
  local _, times, limitTimes = data:GetLimitBuyCount()
  local limitType = data.defaultCfg.limit_type
  if type(limitType) ~= "number" or limitType < 1 or 4 < limitType then
    self.ui.img_Tag.gameObject:SetActive(false)
  else
    self.ui.img_Tag.gameObject:SetActive(true)
    self.ui.tex_Tag:SetIndex(limitType - 1, tostring(limitTimes - times))
  end
end

function UINRecommeShopMidPageInfo:GetShopMidPageInfoPriceStr(price)
  return ConfigData:GetTipContent(TipContent.RecommandShopPayPriceUnit, tostring(price))
end

return UINRecommeShopMidPageInfo
