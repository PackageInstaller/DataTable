local UINRuleTouchShopBar = class("UINInfoBtnShopBar", UIBaseNode)
local base = UIBaseNode
local ShopEnum = require("Game.Shop.ShopEnum")

function UINRuleTouchShopBar:OnInit()
  self.shopCtrl = ControllerManager:GetController(ControllerTypeId.Shop, true)
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Rule, self, self._OnClickRuleBtn)
end

function UINRuleTouchShopBar:HeadBarCommonInit(uiShop)
end

function UINRuleTouchShopBar:RefreshHeadBarNode(shopData, shopCfg)
  local shopId = shopData.shopId
  local desId = ConfigData.shop[shopId].info_des
  if desId == 0 then
    return
  end
  local desTxt = ConfigData.shop_des[desId].info_des
  self.ui.tex_Adv.text = LanguageUtil.GetLocaleText(desTxt)
  self.ruleInfoId = ConfigData.shop_des[desId].info_rule
end

function UINRuleTouchShopBar:_OnClickRuleBtn()
  UIManager:ShowWindowAsync(UIWindowTypeID.CommonInfo, function(window)
    if window == nil then
      return
    end
    window:InitCommonInfoByRule(self.ruleInfoId, true)
  end)
end

function UINRuleTouchShopBar:OnHide()
  base.OnHide(self)
end

function UINRuleTouchShopBar:OnDelete()
  base.OnDelete(self)
end

return UINRuleTouchShopBar
