local UINFriendshipGiftItem = class("UINFriendshipGiftItem", UIBaseNode)
local base = UIBaseNode

function UINFriendshipGiftItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddValueChangedListener(self.ui.tog_giftItem, self, self.OnTogValueChange)
end

function UINFriendshipGiftItem:InitGiftItem(heroId, resloader, giftItemID, itemNum, callback, callbackCancle)
  self.heroId = heroId
  self.resloader = resloader
  self.giftItemID = giftItemID
  self.itemCfg = ConfigData.item[giftItemID]
  self.callback = callback
  self.itemNum = itemNum
  self.callbackCancle = callbackCancle
  self.ui.tex_Name.text = LanguageUtil.GetLocaleText(self.itemCfg.name)
  self.ui.img_Icon.sprite = CRH:GetSprite(self.itemCfg.icon)
  self.ui.tex_Count.text = tostring(self.itemNum)
  if self.itemNum == 0 then
    self.ui.img_Icon.color = self.ui.color_gray
    self.ui.tog_giftItem.interactable = false
  else
    self.ui.img_Icon.color = self.ui.color_white
    self.ui.tog_giftItem.interactable = true
  end
  self.ui.tog_giftItem.isOn = false
  self:SetLikeDegree()
end

function UINFriendshipGiftItem:OnTogValueChange(bool)
  if bool then
    if self.callback ~= nil then
      self.callback()
    end
  elseif self.callbackCancle ~= nil then
    self.callbackCancle()
  end
end

function UINFriendshipGiftItem:GetIntimacyAddNum()
  if ConfigData.friendship_hero[self.heroId].likeGifts[self.giftItemID] then
    return ConfigData.friendship_gift[self.giftItemID].gift_like
  end
  if ConfigData.friendship_hero[self.heroId].dislikeGifts[self.giftItemID] then
    return ConfigData.friendship_gift[self.giftItemID].gift_dislike
  end
  return ConfigData.friendship_gift[self.giftItemID].gift_base
end

function UINFriendshipGiftItem:SetLikeDegree()
  if ConfigData.friendship_hero[self.heroId].likeGifts[self.giftItemID] then
    self.ui.img_Heart.color = self.ui.color_heart
    self.ui.imgInfo_Heart:SetIndex(0)
  elseif ConfigData.friendship_hero[self.heroId].dislikeGifts[self.giftItemID] then
    self.ui.img_Heart.color = self.ui.color_white
    self.ui.imgInfo_Heart:SetIndex(2)
  else
    self.ui.img_Heart.color = self.ui.color_white
    self.ui.imgInfo_Heart:SetIndex(1)
  end
end

function UINFriendshipGiftItem:OnDelete()
  base.OnDelete(self)
end

return UINFriendshipGiftItem
