local UINTimeLimitShopBar = class("UINTimeLimitShopBar", UIBaseNode)
local base = UIBaseNode
local ShopEnum = require("Game.Shop.ShopEnum")

function UINTimeLimitShopBar:OnInit()
  self.shopCtrl = ControllerManager:GetController(ControllerTypeId.Shop, true)
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.__RefreshTimeLimit = BindCallback(self, self.RefreshTimeLimit)
end

function UINTimeLimitShopBar:OnShow()
  self.shopCtrl:AddShopTimerCallback(self.__RefreshTimeLimit, "timeLimitBar")
end

function UINTimeLimitShopBar:HeadBarCommonInit(uiShop)
  self.OpenShopePageCallback = uiShop.__OnClickRefreshShop
end

function UINTimeLimitShopBar:RefreshHeadBarNode(shopData, shopCfg)
  if shopCfg ~= nil then
    self:SetShopId(shopCfg.id)
    return
  end
  self:SetShopId(shopData.shopId)
end

function UINTimeLimitShopBar:SetShopId(shopId)
  self.shopId = shopId
  local hav, inTime, outTime = self.shopCtrl:GetIsThisShopHasTimeLimit(self.shopId)
  if hav then
    self.outTime = outTime
  else
    self.outTime = nil
  end
  self:RefreshTimeLimit()
  self:RefreshTxtDes()
end

function UINTimeLimitShopBar:RefreshTxtDes()
  local desId = ConfigData.shop[self.shopId].info_des
  if desId == 0 then
    self.ui.tex_Adv.text = nil
    return
  end
  local desTxt = ConfigData.shop_des[desId].info_des
  self.ui.tex_Adv.text = LanguageUtil.GetLocaleText(desTxt)
end

function UINTimeLimitShopBar:RefreshTimeLimit()
  if self.outTime == nil then
    return
  end
  local remaindTime = self.outTime - PlayerDataCenter.timestamp
  local d, h, m, s = TimeUtil:TimestampToTimeInter(remaindTime, false, true)
  local hStr = 10 <= h and tostring(h) or "0" .. tostring(h)
  local mStr = 10 <= m and tostring(m) or "0" .. tostring(m)
  local sStr = 10 <= s and tostring(s) or "0" .. tostring(s)
  if 0 < d then
    self.ui.tex_Timer:SetIndex(0, tostring(d), hStr, mStr, sStr)
  else
    self.ui.tex_Timer:SetIndex(1, hStr, mStr, sStr)
  end
end

function UINTimeLimitShopBar:OnHide()
  self.shopCtrl:RemoveShopTimerCallback(self.__RefreshTimeLimit)
  base.OnHide(self)
end

function UINTimeLimitShopBar:OnDelete()
  base.OnDelete(self)
end

return UINTimeLimitShopBar
