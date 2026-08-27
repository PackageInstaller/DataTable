local UINEventLadderGiftItem = class("UINEventLadderGiftItem", UIBaseNode)
local base = UIBaseNode
local CS_ClientConsts = CS.ClientConsts
local ShopEnum = require("Game.Shop.ShopEnum")
local UINBaseItemWithCount = require("Game.CommonUI.Item.UINBaseItemWithCount")

function UINEventLadderGiftItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.itemPool = UIItemPool.New(UINBaseItemWithCount, self.ui.uINBaseItemWithCount, false)
  UIUtil.AddButtonListener(self.ui.btn_Buy, self, self.OnClickBtnBuy)
end

function UINEventLadderGiftItem:InitEventLadderGiftItem(giftInfo, resloader, index, lastGiftInfo)
  self.giftInfo = giftInfo
  self.resloader = resloader
  self.index = index
  self.lastGiftInfo = lastGiftInfo
  self:RefreshLadderGiftItemNormalUI()
end

function UINEventLadderGiftItem:RefreshLadderGiftItemNormalUI()
  self.ui.obj_Arrow:SetActive(self.lastGiftInfo ~= nil)
  self.ui.tex_GiftName.text = LanguageUtil.GetLocaleText(self.giftInfo.groupCfg.name)
  self.ui.img_Icon.gameObject:SetActive(false)
  if self.giftInfo.defaultCfg.cur_price == 0 then
    self.ui.tex_Price:SetIndex(0)
  elseif self.giftInfo:IsUseItemPay() then
    self.ui.img_Icon.gameObject:SetActive(true)
    self.ui.img_Icon.sprite = CRH:GetSpriteByItemId(self.giftInfo.defaultCfg.costId, true)
    self.ui.tex_Price:SetIndex(1, tostring(self.giftInfo.defaultCfg.costCount))
  else
    local payCtrl = ControllerManager:GetController(ControllerTypeId.Pay)
    local payStr = payCtrl:GetPayPriceShow(self.giftInfo.defaultCfg.payId)
    self.ui.tex_Price:SetIndex(1, payStr)
  end
  local textureName = self.giftInfo.groupCfg.icon
  self.ui.img_Gift.gameObject:SetActive(false)
  self.resloader:LoadABAssetAsync(PathConsts:GetShopGiftBgPath(textureName), function(texture)
    if not IsNull(texture) then
      self.ui.img_Gift.gameObject:SetActive(true)
      self.ui.img_Gift.texture = texture
    end
  end)
  self.ui.obj_Discount.gameObject:SetActive(false)
  self.ui.img_tag.gameObject:SetActive(false)
  if not CS_ClientConsts.IsAudit and not ConfigData.game_config.payGiftdiscountHide and 0 < self.giftInfo.groupCfg.tagType then
    local groupCfg = self.giftInfo.groupCfg
    if groupCfg.tagType == ShopEnum.ePayGiftTag.Discount then
      self.ui.obj_Discount.gameObject:SetActive(true)
      if Consts.GameChannelType.IsInland() then
        self.ui.tex_Discount:SetIndex(1, tostring(10 - groupCfg.tagValue / 10))
      else
        self.ui.tex_Discount:SetIndex(0, tostring(groupCfg.tagValue))
      end
    else
      self.ui.img_tag.gameObject:SetActive(true)
      self.ui.img_tag:SetIndex(groupCfg.tagValue - 1)
      self.ui.tex_Tag:SetIndex(groupCfg.tagType - 2)
    end
  end
  local defaultCfg = self.giftInfo.defaultCfg
  local canShowNum = #defaultCfg.awardIds > 4 and 3 or #defaultCfg.awardIds
  local needShowMore = #defaultCfg.awardIds > 4
  self.itemPool:HideAll()
  for k = 1, canShowNum do
    local awardId = defaultCfg.awardIds[k]
    local itemCfg = ConfigData.item[awardId]
    local count = defaultCfg.awardCounts[k]
    local item = self.itemPool:GetOne()
    item:InitItemWithCount(itemCfg, count)
  end
  self.ui.obj_More:SetActive(needShowMore)
  self.ui.obj_More.transform:SetAsLastSibling()
  local payGiftCtrl = ControllerManager:GetController(ControllerTypeId.PayGift, true)
  local isCanBuy, tipId = payGiftCtrl:GetCanBuyGiftAndTipId(self.giftInfo)
  self.ui.obj_SoldOut:SetActive(false)
  self.ui.obj_Lock:SetActive(false)
  if not isCanBuy then
    self.ui.obj_SoldOut:SetActive(tipId == 0)
    self.ui.obj_Lock:SetActive(tipId == 1)
  end
end

function UINEventLadderGiftItem:OnClickBtnBuy()
  UIManager:ShowWindowAsync(UIWindowTypeID.QuickBuy, function(window)
    if IsNull(window) then
      return
    end
    window:SlideIn()
    window:InitBuyPayGift(self.giftInfo)
  end)
end

function UINEventLadderGiftItem:OnDelete()
end

return UINEventLadderGiftItem
