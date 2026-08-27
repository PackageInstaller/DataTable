local UINShopLeftPage = class("UINShopLeftPage", UIBaseNode)
local base = UIBaseNode
local ShopEnum = require("Game.Shop.ShopEnum")

function UINShopLeftPage:OnInit()
  self.shopCtrl = ControllerManager:GetController(ControllerTypeId.Shop, true)
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Page, self, self.OnClickPage)
  self.ui.obj_NewGift:SetActive(false)
end

function UINShopLeftPage:InitPage(groupCfg, clickShopFunc, resloader, specialId)
  self.leftPageCfg = groupCfg
  self.clickShopFunc = clickShopFunc
  self.ui.obj_RedDot:SetActive(false)
  self.ui.img_Buttom:SetIndex(0)
  self.ui.img_Icon.sprite = AtlasUtil.GetSpriteFromAtlas("UI_Shop", self.leftPageCfg.icon, resloader)
  local shopId
  if specialId == nil or specialId == 0 then
    shopId = self.leftPageCfg.sub_ids[1]
  else
    shopId = specialId
  end
  self.shopCfg = ConfigData.shop[shopId]
  self.ui.tex_Name.text = LanguageUtil.GetLocaleText(self.shopCfg.name)
  self.ui.tex_NameEn.text = LanguageUtil.GetLocaleText(self.shopCfg.name_en)
  self:RefreshRedDotState()
  self:RefreshTimelimitTag4Page()
  self:RefreshState(false)
end

function UINShopLeftPage:OnClickPage()
  if self.shopCfg ~= nil and self.clickShopFunc ~= nil then
    self.clickShopFunc(self.shopCfg.id)
  end
end

function UINShopLeftPage:RefreshState(isSelected)
  if isSelected then
    self.ui.img_Buttom:SetIndex(1)
    self.ui.tex_Name.color = self.ui.color_selectedText
    self.ui.tex_NameEn.color = self.ui.color_selectedText
    self.ui.img_Icon.color = self.ui.color_selectedText
  else
    self.ui.img_Buttom:SetIndex(0)
    self.ui.tex_Name.color = self.ui.color_unSelectText
    self.ui.tex_NameEn.color = self.ui.color_unSelectText
    self.ui.img_Icon.color = self.ui.color_unSelectText
  end
  if self.shopCfg.id == ShopEnum.ShopId.gift and not isSelected then
    self:RefreshRedDotState()
  end
  if (self.shopCfg.id == ShopEnum.ShopId.skin or self.shopCfg.id == ShopEnum.ShopId.recharge) and not isSelected then
    self:RefreshRedDotState()
  end
  return isSelected
end

function UINShopLeftPage:RefreshRedDotState()
  self.ui.obj_RedDot:SetActive(false)
  self.ui.blueDot:SetActive(false)
  local isHaveRed = false
  local ok, shopNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.ShopWindow, self.shopCfg.id)
  if ok and shopNode:GetRedDotCount() > 0 then
    if self.shopCtrl:IsShopBlueReddot(self.shopCfg.id) then
      self.ui.blueDot:SetActive(true)
    else
      self.ui.obj_RedDot:SetActive(true)
      isHaveRed = true
    end
  end
  self:RefreshNewGiftTag4Page(isHaveRed)
end

function UINShopLeftPage:RefreshTimelimitTag4Page()
  local ishaveTimeLimit = false
  for i, shopId in ipairs(self.leftPageCfg.sub_ids) do
    if self.shopCtrl:GetIsThisShopHasTimeLimit(shopId) then
      ishaveTimeLimit = true
      break
    end
  end
  if self.leftPageCfg.special_id ~= 0 and self.shopCtrl:GetIsThisShopHasTimeLimit(self.leftPageCfg.special_id) then
    ishaveTimeLimit = true
  end
  local payGiftCtrl = ControllerManager:GetController(ControllerTypeId.PayGift, true)
  if payGiftCtrl:CheckPageIdIsGiftShop(self.shopCfg.id) then
    ishaveTimeLimit = false
  end
  self.ui.img_TimeIcon:SetActive(ishaveTimeLimit)
end

function UINShopLeftPage:RefreshNewGiftTag4Page(isHaveRed)
  if self.shopCfg.id == ShopEnum.ShopId.gift then
    local payGiftCtrl = ControllerManager:GetController(ControllerTypeId.PayGift, true)
    local isHaveNewGift = payGiftCtrl:IsHaveNewGiftInShop()
    self.ui.obj_NewGift:SetActive(isHaveNewGift and not isHaveRed)
    if isHaveNewGift then
      self.ui.blueDot:SetActive(false)
    end
  end
  if self.shopCfg.id == ShopEnum.ShopId.skin or self.shopCfg.id == ShopEnum.ShopId.vow then
    local shopCtrl = ControllerManager:GetController(ControllerTypeId.Shop, true)
    shopCtrl:IsHaveNewSkinGoodItemInShop(function(isHaveNewGift)
      self.ui.obj_NewGift:SetActive(isHaveNewGift and not isHaveRed)
      if isHaveNewGift then
        self.ui.blueDot:SetActive(false)
      end
    end, self.shopCfg.id)
  end
  if self.shopCfg.id == ShopEnum.ShopId.recharge then
    local shopCtrl = ControllerManager:GetController(ControllerTypeId.Shop, true)
    shopCtrl:IsHaveNewRechargeGoodItemInShop(function(isHaveNewGift)
      self.ui.obj_NewGift:SetActive(isHaveNewGift and not isHaveRed)
      if isHaveNewGift then
        self.ui.blueDot:SetActive(false)
      end
    end)
  end
end

function UINShopLeftPage:OnDelete()
  base.OnDelete(self)
end

return UINShopLeftPage
