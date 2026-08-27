local UINHeroFragOverFlowShopBar = class("UINHeroFragOverFlowShopBar", UIBaseNode)
local base = UIBaseNode
local ShopEnum = require("Game.Shop.ShopEnum")
local cs_MessageCommon = CS.MessageCommon

function UINHeroFragOverFlowShopBar:OnInit()
  self.shopCtrl = ControllerManager:GetController(ControllerTypeId.Shop, true)
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Rule, self, self._OnClickRuleBtn)
  UIUtil.AddButtonListener(self.ui.btn_Exchange, self, self._OnClickExchangeBtn)
  self.__UpdateTime = BindCallback(self, self.UpdateTime)
  self.__RefreshExchangeBtn = BindCallback(self, self._RefreshExchangeBtn)
  self.__RefreshCallback = BindCallback(self, self.RefreshCallback)
  MsgCenter:AddListener(eMsgEventId.HeroFragConvert, self.__RefreshExchangeBtn)
end

function UINHeroFragOverFlowShopBar:OnShow()
  self.shopCtrl:AddShopTimerCallback(self.__UpdateTime, "UINHeroFragOverFlowShopBar")
end

function UINHeroFragOverFlowShopBar:HeadBarCommonInit(uiShop)
  self.OpenShopePageCallback = uiShop.__OnClickRefreshShop
  self.shopCtrl = uiShop.shopCtrl
end

function UINHeroFragOverFlowShopBar:RefreshHeadBarNode(shopData, shopCfg)
  self.shopData = shopData
  self.shopId = shopData.shopId
  self:RefreshTxtDes()
  self:UpdateTime()
  self:_RefreshExchangeBtn()
end

function UINHeroFragOverFlowShopBar:RefreshTxtDes()
  local desId = ConfigData.shop[self.shopId].info_des
  if desId == 0 then
    self.ui.tex_Adv.text = nil
    return
  end
  local desTxt = ConfigData.shop_des[desId].info_des
  self.ui.tex_Adv.text = LanguageUtil.GetLocaleText(desTxt)
  self.ruleInfoId = ConfigData.shop_des[desId].info_rule
end

function UINHeroFragOverFlowShopBar:UpdateTime()
  local time = self.shopData:GetRemainAutoRefreshTime()
  local d, h, m, s = TimeUtil:TimestampToTimeInter(time, false, true)
  local hStr = 10 <= h and tostring(h) or "0" .. tostring(h)
  local mStr = 10 <= m and tostring(m) or "0" .. tostring(m)
  local sStr = 10 <= s and tostring(s) or "0" .. tostring(s)
  if 0 < d then
    self.ui.tex_Timer:SetIndex(0, tostring(d), hStr, mStr, sStr)
  else
    self.ui.tex_Timer:SetIndex(1, hStr, mStr, sStr)
  end
  if time < -1 then
    self.shopCtrl:ReqShopDetail(self.shopData.shopId, self.__RefreshCallback)
    self.shopCtrl:RemoveShopTimerCallback(self.__UpdateTime)
  end
end

function UINHeroFragOverFlowShopBar:_OnClickRuleBtn()
  UIManager:ShowWindowAsync(UIWindowTypeID.CommonInfo, function(window)
    if window == nil then
      return
    end
    window:InitCommonInfoByRule(self.ruleInfoId, true)
  end)
end

function UINHeroFragOverFlowShopBar:_RefreshExchangeBtn()
  self.isHave = false
  for key, heroData in pairs(PlayerDataCenter.heroDic) do
    if heroData:IsCouldFragConvert() then
      self.isHave = true
      break
    end
  end
  if self.isHave then
    self.ui.img_btn_Exchange.color = Color.Temp(0.9921569, 0.4862745, 0.08627451)
    self.ui.text_btn_Exchange:SetIndex(0)
  else
    self.ui.img_btn_Exchange.color = Color.Temp(0.5960785, 0.5960785, 0.5960785)
    self.ui.text_btn_Exchange:SetIndex(1)
  end
end

function UINHeroFragOverFlowShopBar:_OnClickExchangeBtn()
  if not self.isHave then
    return
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.HeroChipOverflowWindow, function(win)
    if win == nil then
      return
    end
    win:InitByCouldUseFragList()
  end)
end

function UINHeroFragOverFlowShopBar:RefreshCallback()
  self:_TryHideShowMessageCommon(function()
    cs_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(329))
  end)
  if self.OpenShopePageCallback ~= nil then
    local win = UIManager:GetWindow(UIWindowTypeID.QuickBuy)
    if win ~= nil then
      win:SlideOut()
    end
    self.OpenShopePageCallback(self.shopData.shopId)
  end
end

function UINHeroFragOverFlowShopBar:_TryHideShowMessageCommon(Func)
  local window = UIManager:GetWindow(UIWindowTypeID.MessageCommon)
  if window ~= nil and window.active then
    window:Hide()
    if Func ~= nil then
      Func()
    end
    cs_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(329))
  end
end

function UINHeroFragOverFlowShopBar:OnHide()
  self.shopCtrl:RemoveShopTimerCallback(self.__UpdateTime)
  base.OnHide(self)
end

function UINHeroFragOverFlowShopBar:OnDelete()
  MsgCenter:RemoveListener(eMsgEventId.HeroFragConvert, self.__RefreshExchangeBtn)
  base.OnDelete(self)
end

return UINHeroFragOverFlowShopBar
