local UINShopLeftPageSub = class("UINShopLeftPageSub", UIBaseNode)
local base = UIBaseNode
local ShopEnum = require("Game.Shop.ShopEnum")

function UINShopLeftPageSub:OnInit()
  self.shopCtrl = ControllerManager:GetController(ControllerTypeId.Shop, true)
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Sub, self, self.OnClickPage)
  self.__OnTimerRefresh = BindCallback(self, self.RefreshPageTime)
end

function UINShopLeftPageSub:InitPageSub(shopId, clickFunc, parentBtn)
  self.shopId = shopId
  self.shopCfg = ConfigData.shop[shopId]
  self.clickFunc = clickFunc
  self.parentBtn = parentBtn
  self.ui.tex_Name.text = LanguageUtil.GetLocaleText(self.shopCfg.name)
  self.ui.img_Buttom.color = self.ui.color_unSelectImg
  self.ui.obj_RedDot:SetActive(false)
  self.ui.obj_GiftTimeLimit:SetActive(false)
  self:RefreshPageSubRedDotState()
  self:RefreshState(false)
end

function UINShopLeftPageSub:OnClickPage()
  if self.clickFunc ~= nil then
    self.clickFunc(self.shopCfg.id)
  end
end

function UINShopLeftPageSub:RefreshState(isSelected)
  if isSelected then
    self.ui.img_Buttom.color = self.ui.color_selectImg
    self.ui.tex_Name.color = self.ui.color_selectedText
  else
    self.ui.img_Buttom.color = self.ui.color_unSelectImg
    self.ui.tex_Name.color = self.ui.color_unSelectText
  end
  if self.shopId == ShopEnum.ShopId.gift and not isSelected then
    self:RefreshPageSubRedDotState()
  end
end

function UINShopLeftPageSub:RefreshPageSubRedDotState()
  self.ui.obj_RedDot:SetActive(false)
  self.ui.blueDot:SetActive(false)
  local ok, shopNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.ShopWindow, self.shopCfg.id)
  local flag = ok and shopNode:GetRedDotCount() > 0
  local isBlue = self.shopCtrl:IsShopBlueReddot(self.shopCfg.id)
  self.isHaveRed = false
  if flag then
    local reddotObj = isBlue and self.ui.blueDot or self.ui.obj_RedDot
    reddotObj:SetActive(true)
    self.isHaveRed = true
  end
  self:RefreshNewGiftTag4Page(flag)
  return flag, isBlue
end

function UINShopLeftPageSub:RefreshTimelimitTag4Sub()
  local ishaveTimeLimit, startTime, endTime = self.shopCtrl:GetIsThisShopHasTimeLimit(self.shopId)
  local payGiftCtrl = ControllerManager:GetController(ControllerTypeId.PayGift, true)
  self.shopCtrl:RemoveShopTimerCallback(self.__OnTimerRefresh)
  self.ui.obj_GiftTimeLimit:SetActive(false)
  if payGiftCtrl:CheckPageIdIsGiftShop(self.shopId) then
    if not self.isHaveRed and not self.isHaveNewGift and ishaveTimeLimit then
      self.ui.obj_GiftTimeLimit:SetActive(true)
      self.latestTime = endTime
      self:RefreshPageTime()
      self.shopCtrl:AddShopTimerCallback(self.__OnTimerRefresh, "pageSub")
    end
  else
    self.ui.img_TimeIcon:SetActive(ishaveTimeLimit)
  end
end

function UINShopLeftPageSub:RefreshPageTime()
  if self.latestTime == nil or IsNull(self.ui.tex_GiftTimeLimit) then
    return
  end
  local remaindTime = self.latestTime - PlayerDataCenter.timestamp
  if remaindTime < 0 then
    remaindTime = 0
  end
  local d, h, m, s = TimeUtil:TimestampToTimeInter(remaindTime, false, true)
  if 0 < d then
    self.ui.tex_GiftTimeLimit:SetIndex(0, tostring(d))
  elseif 0 < h then
    self.ui.tex_GiftTimeLimit:SetIndex(1, tostring(h))
  elseif 0 < m then
    self.ui.tex_GiftTimeLimit:SetIndex(2, tostring(m))
  else
    self.ui.tex_GiftTimeLimit:SetIndex(3, tostring(s))
  end
end

function UINShopLeftPageSub:RefreshNewGiftTag4Page(isHaveRed)
  local payGiftCtrl = ControllerManager:GetController(ControllerTypeId.PayGift, true)
  self.isHaveNewGift = false
  self.ui.obj_NewGift:SetActive(false)
  if payGiftCtrl:CheckPageIdIsGiftShop(self.shopId) then
    local isHaveNewGift = payGiftCtrl:IsHaveNewGiftInShop(self.shopId)
    if not IsNull(self.ui.obj_NewGift) then
      self.ui.obj_NewGift:SetActive(isHaveNewGift and not isHaveRed)
    end
    if isHaveNewGift then
      self.isHaveNewGift = true
      self.ui.blueDot:SetActive(false)
    end
  end
  self:RefreshTimelimitTag4Sub()
end

function UINShopLeftPageSub:OnDelete()
  self.shopCtrl:RemoveShopTimerCallback(self.__OnTimerRefresh)
  base.OnDelete(self)
end

return UINShopLeftPageSub
