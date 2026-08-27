local UINShopNormalRechargeItem = class("UINShopNormalRechargeItem", UIBaseNode)
local base = UIBaseNode

function UINShopNormalRechargeItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_quartzItem, self, self.OnClickBuyRecharge)
  self._RefreshGoodsRecharge = BindCallback(self, self.RefreshRechargeSuccess)
  MsgCenter:AddListener(eMsgEventId.ShopRechargeComplete, self._RefreshGoodsRecharge)
end

function UINShopNormalRechargeItem:InitRechargeItem(goodData, resloader)
  self.goodData = goodData
  self.ui.tex_Name.text = LanguageUtil.GetLocaleText(goodData.goodCfg.name)
  self.payCtrl = ControllerManager:GetController(ControllerTypeId.Pay, true)
  self.payId = self.goodData.goodCfg.pay_id
  local _, priceInter = self.payCtrl:GetPayPriceShow(self.payId)
  local priceUnit = self.payCtrl:GetPayShowUnitStr()
  self.ui.tex_CNY.text = tostring(priceInter)
  self.ui.tex_icon.text = priceUnit
  local textureName = self.goodData.goodCfg.icon
  resloader:LoadABAssetAsync(PathConsts:GetShopGiftBgPath(textureName), function(texture)
    if not IsNull(texture) then
      self.ui.img_Quartz.texture = texture
    end
  end)
  self:RefreshRechargeItem()
end

function UINShopNormalRechargeItem:RefreshRechargeItem()
  if self.goodData.isSoldOut then
    self:Hide()
    return
  end
  local _, rewardCounts = self.payCtrl:GetPayRewards(self.payId, self.goodData.hasDouble)
  if rewardCounts ~= nil and 1 < #rewardCounts then
    local rechargeCfg = ConfigData.pay_recharge[self.payId]
    if #rechargeCfg.limitedRewardIdList > 0 then
      self.ui.tex_extrTitle:SetIndex(1)
    else
      self.ui.tex_extrTitle:SetIndex(0)
    end
    self.ui.extraNode:SetActive(true)
    self.ui.tex_ExtraNum.text = tostring(rewardCounts[2])
    self.ui.onlyOneDouble:SetActive(self.goodData.hasDouble)
    self.ui.img_JpTag:SetActive(Consts.GameChannelType.IsJp())
  else
    self.ui.extraNode:SetActive(false)
  end
  self:RefreshRechargeLeftTime()
end

function UINShopNormalRechargeItem:RefreshRechargeLeftTime()
  self.ui.obj_Time:SetActive(false)
  if self.goodData.isSoldOut then
    return
  end
  local hasTimeLimit, inTime, startTime, endTime = self.goodData:GetStillTime()
  if not hasTimeLimit then
    return
  end
  if not inTime then
    return true
  end
  self.ui.obj_Time:SetActive(true)
  local remaindTime = endTime - PlayerDataCenter.timestamp
  local d, h, m, s = TimeUtil:TimestampToTimeInter(remaindTime, false, true)
  if 0 < d then
    self.ui.tex_Time:SetIndex(0, tostring(d), tostring(h))
    return
  end
  if 0 < h then
    self.ui.tex_Time:SetIndex(1, tostring(h), tostring(m))
    return
  end
  if 0 < s then
    m = m + 1
  end
  self.ui.tex_Time:SetIndex(2, tostring(m))
end

function UINShopNormalRechargeItem:RefreshRechargeSuccess(shopId)
  if self.goodData.shopId == shopId then
    self:RefreshRechargeItem()
  end
end

function UINShopNormalRechargeItem:OnClickBuyRecharge()
  local shopCtrl = ControllerManager:GetController(ControllerTypeId.Shop, true)
  shopCtrl:ReqShopRecharge(self.payId)
end

function UINShopNormalRechargeItem:OnDelete()
  MsgCenter:RemoveListener(eMsgEventId.ShopRechargeComplete, self._RefreshGoodsRecharge)
  base.OnDelete(self)
end

return UINShopNormalRechargeItem
