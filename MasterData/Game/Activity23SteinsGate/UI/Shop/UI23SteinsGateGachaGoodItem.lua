local base = UIBaseNode
local UI23SteinsGateGachaGoodsItem = class("UI23SteinsGateGachaGoodsItem", base)
local UINBaseItemWithCount = require("Game.CommonUI.Item.UINBaseItemWithCount")
local charToIndexTable = {
  ["0"] = 0,
  ["1"] = 1,
  ["2"] = 2,
  ["3"] = 3,
  ["4"] = 4,
  ["5"] = 5,
  ["6"] = 6,
  ["7"] = 7,
  ["8"] = 8,
  ["9"] = 9,
  ["/"] = 10
}

function UI23SteinsGateGachaGoodsItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_goodItem, self, self.OnSteinsGateGachaShopItemClicked)
  self.__OnBuyShopDataCallback = BindCallback(self, self.OnSteinsGateGachaShopItemClicked)
  self.baseGoodsItemWithCount = UINBaseItemWithCount.New()
  self.baseGoodsItemWithCount:Init(self.ui.obj_BaseItem)
end

function UI23SteinsGateGachaGoodsItem:InitUI23SteinsGateGachaGoodItem(goodsData, index, clickEvent)
  self.__shopGoodData = goodsData
  self.__dataIndex = index
  self.__clickEvent = clickEvent
  self._isEmpty = goodsData == nil
  if self._isEmpty then
    self:RefreshSteinsGateGachaGoodsItemEmpty(goodsData)
  else
    self:RefreshSteinsGateGachaGoodsItem(goodsData)
  end
end

function UI23SteinsGateGachaGoodsItem:RefreshSteinsGateGachaGoodsItem(goodsData)
  self:UpdateBaseGoodsItemWithCount(goodsData.itemCfg, goodsData.itemNum)
  self:UpdateTokenIcon(goodsData.currencyId)
  self:UpdateCount(goodsData.isSoldOut, goodsData.limitTime - goodsData.purchases, goodsData.limitTime, false)
  self:UpdatePrice(goodsData.currencyId, goodsData.newCurrencyNum)
  self:UpdateOverFlowTag(goodsData.itemId, goodsData.itemCfg.overflow_type)
  self:UpdateLEDDotLight(false, goodsData.isSoldOut)
  self:UpdateShadowImage(true)
end

function UI23SteinsGateGachaGoodsItem:RefreshSteinsGateGachaGoodsItemEmpty()
  self:UpdateBaseGoodsItemWithCount(nil, nil)
  self:UpdateCount(false, 0, 0, true)
  self:UpdatePrice(nil, nil)
  self:UpdateLEDDotLight(true, true)
  self:UpdateTokenIcon(nil)
  self:UpdateShadowImage(false)
end

function UI23SteinsGateGachaGoodsItem:UpdateItemImage(itemCfg)
  local sprite = CRH:GetSpriteByItemConfig(itemCfg)
  self.ui.img_Pic.sprite = sprite
end

function UI23SteinsGateGachaGoodsItem:UpdateItemNum(itemNum)
  self.ui.tex_itemCount.text = itemNum
end

function UI23SteinsGateGachaGoodsItem:UpdateBaseGoodsItemWithCount(itemCfg, itemNum)
  local isEmpty = itemCfg == nil
  self.baseGoodsItemWithCount.gameObject:SetActive(not isEmpty)
  if isEmpty then
    return
  end
  self.baseGoodsItemWithCount:InitItemWithCount(itemCfg, itemNum)
end

function UI23SteinsGateGachaGoodsItem:UpdateTokenIcon(currencyId)
  self.ui.img_Cost.gameObject:SetActive(currencyId ~= nil)
  if currencyId == nil then
    return
  end
  local priceItem = ConfigData.item[currencyId]
  self.ui.img_Cost.sprite = CRH:GetSprite(priceItem.small_icon)
end

function UI23SteinsGateGachaGoodsItem:UpdateCount(isSoldOut, lastCount, totalCount, isEmpty)
  self:UpdateSpriteCount(lastCount, totalCount, isEmpty)
  self.ui.obj_isSellOut:SetActive(isSoldOut)
end

function UI23SteinsGateGachaGoodsItem:UpdateSpriteCount(lastCount, totalCount, isEmpty)
  local countStr = string.format("%s/%s", string.format("%03d", lastCount), string.format("%03d", totalCount))
  local startPos = 1
  if #countStr ~= #self.ui.numItemList then
    error(string.format("数量大于999！ lastCount = %s totalCount = %s", lastCount, totalCount))
    countStr = "999/999"
  end
  for i = 1, #countStr do
    local word = string.sub(countStr, i, i)
    local numberIndex = self:__GetNumberSpriteIndex(word)
    local numberColor = isEmpty and self.ui.color_gray or self.ui.color_white
    self:__SetNumber(startPos, numberIndex, numberColor)
    startPos = startPos + 1
  end
end

function UI23SteinsGateGachaGoodsItem:UpdatePrice(currencyId, newCurrencyNum)
  local isEmpty = currencyId == nil
  self.ui.tex_Price.gameObject:SetActive(not isEmpty)
  if isEmpty then
    return
  end
  local priceItem = ConfigData.item[currencyId]
  self.ui.img_Cost.sprite = CRH:GetSprite(priceItem.small_icon)
  self.ui.tex_Price.text = tostring(newCurrencyNum)
end

function UI23SteinsGateGachaGoodsItem:UpdateOverFlowTag(itemId, overflow_type)
  if not IsNull(self.ui.img_Tag) then
    self.ui.img_Tag:SetActive(false)
    if overflow_type == eItemTransType.actMoneyX then
      local overflowNum = PlayerDataCenter:GetItemOverflowNum(itemId, 1)
      if overflowNum ~= 0 then
        self.ui.img_Tag:SetActive(true)
      end
    end
  end
end

function UI23SteinsGateGachaGoodsItem:UpdateLEDDotLight(isEmpty, isSoldOut)
  local redOrGreen = isEmpty or isSoldOut
  self.ui.img_Dot.color = redOrGreen and self.ui.color_red or self.ui.color_green
end

function UI23SteinsGateGachaGoodsItem:UpdateShadowImage(isActive)
  if not IsNull(self.ui.img_Shadow) then
    self.ui.img_Shadow.gameObject:SetActive(isActive)
  end
end

function UI23SteinsGateGachaGoodsItem:GetDungeonShopItemData()
  return self.__shopGoodData
end

function UI23SteinsGateGachaGoodsItem:GetDungeonShopDataIndex()
  return self.__dataIndex
end

function UI23SteinsGateGachaGoodsItem:IsSoldOut()
  if self.__shopGoodData == nil then
    return true
  end
  return self.__shopGoodData.isSoldOut
end

function UI23SteinsGateGachaGoodsItem:OnSteinsGateGachaShopItemClicked()
  if self.__clickEvent ~= nil and not self._isEmpty and not self:IsSoldOut() then
    self.__clickEvent(self.__dataIndex, self)
  end
end

function UI23SteinsGateGachaGoodsItem:__GetNumberSpriteIndex(char)
  return charToIndexTable[char]
end

function UI23SteinsGateGachaGoodsItem:__SetNumber(pos, numberIndex, color)
  if not IsNull(self.ui.numItemList[pos]) then
    self.ui.numItemList[pos]:SetIndex(numberIndex)
    self.ui.numItemList[pos].image.color = color
  end
end

function UI23SteinsGateGachaGoodsItem:PlaySteinsGateGachaGoodsItemSellOutAnim()
  self:__StopSellOutAnim()
  self.ui.img_isSellOut:DOFade(0, 0.3):From():SetDelay(self.__dataIndex * 0.02 + 0.05):SetLink(self.gameObject)
  self.ui.img_isSellOut.transform:DOScale(1.5, 0.3):From():SetDelay(self.__dataIndex * 0.02 + 0.05):SetLink(self.gameObject)
end

function UI23SteinsGateGachaGoodsItem:__StopSellOutAnim()
  self.ui.img_isSellOut:DOComplete()
  self.ui.img_isSellOut.transform:DOComplete()
end

function UI23SteinsGateGachaGoodsItem:PlaySteinsGateGachaGoodsItemAnim()
  self:__StopAnim()
  self.ui.anim_ItemCanvas:DOFade(0, 1):From():SetDelay(self.__dataIndex * 0.02):SetLink(self.gameObject)
  self.ui.img_Shadow:DOFade(0, 1):From():SetDelay(self.__dataIndex * 0.02):SetLink(self.ui.img_Shadow.gameObject)
end

function UI23SteinsGateGachaGoodsItem:__StopAnim()
  self.ui.anim_ItemCanvas:DOComplete()
  self.ui.img_Shadow:DOComplete()
end

function UI23SteinsGateGachaGoodsItem:OnDelete()
  self:__StopSellOutAnim()
  self:__StopAnim()
  self.baseGoodsItemWithCount:Delete()
  self.baseGoodsItemWithCount = nil
  base.OnDelete(self)
end

return UI23SteinsGateGachaGoodsItem
