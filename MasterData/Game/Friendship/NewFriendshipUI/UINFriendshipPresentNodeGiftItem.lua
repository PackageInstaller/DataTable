local UINFriendshipPresentNodeGiftItem = class("UINFriendshipPresentNodeGiftItem", UIBaseNode)
local base = UIBaseNode
local UINBaseItem = require("Game.CommonUI.Item.UINBaseItem")
local eLiskeDegree = require("Game.Friendship.NewFriendshipUI.eLikeDegree")

function UINFriendshipPresentNodeGiftItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_presentItem, self, self.AddOne)
  self.ui.btn_presentItem.onPress:AddListener(BindCallback(self, self.PressAdd))
  UIUtil.AddButtonListener(self.ui.btn_Minus, self, self.MineOne)
  self.baseItem = UINBaseItem.New()
  self.baseItem:Init(self.ui.uINBaseItem)
end

function UINFriendshipPresentNodeGiftItem:InitGiftItem(heroId, resloader, giftData, addExpCallback, minExpCallback, changeSelectCallback)
  self.giftData = giftData
  local giftItemID = giftData.id
  self.heroId = heroId
  self.resloader = resloader
  self.giftItemID = giftItemID
  self.itemCfg = ConfigData.item[giftItemID]
  self.itemNum = PlayerDataCenter:GetItemCount(giftItemID)
  local baseBtnEnable = self.itemNum ~= nil and self.itemNum < 1
  self.baseItem.ui.btn_Root.enabled = baseBtnEnable
  self.addExpCallback = addExpCallback
  self.minExpCallback = minExpCallback
  self.changeSelectCallback = changeSelectCallback
  self.baseItem:InitBaseItem(self.itemCfg)
  self.ui.tex_Name.text = LanguageUtil.GetLocaleText(self.itemCfg.name)
  self.gameObject.name = "gift_" .. tostring(giftItemID)
  self.ui.tex_ExtrCount.text = tostring(self.itemNum)
  self:SetLikeDegree()
  self.ui.tex_Count.text = tostring(self.giftData.selectNum)
  self.ui.tex_Count.text = tostring(self.giftData.selectNum)
  self:SetNumVisible()
end

function UINFriendshipPresentNodeGiftItem:SetLikeDegree()
  if self.giftData.likeDegree == eLiskeDegree.like then
    self.ui.img_emoji:SetIndex(0)
  elseif self.giftData.likeDegree == eLiskeDegree.dislike then
    self.ui.img_emoji:SetIndex(2)
  else
    self.ui.img_emoji:SetIndex(1)
  end
end

function UINFriendshipPresentNodeGiftItem:GetIntimacyAddNum()
  return self.giftData.addValue
end

function UINFriendshipPresentNodeGiftItem:AddOne()
  local expAdd = self:GetIntimacyAddNum()
  if self.giftData.selectNum < self.itemNum and self.addExpCallback(expAdd, expAdd) then
    self.giftData.selectNum = self.giftData.selectNum + 1
    AudioManager:PlayAudioById(1064)
  end
  self.changeSelectCallback(self.giftItemID, self.giftData.selectNum)
  self.ui.tex_Count.text = tostring(self.giftData.selectNum)
  self:SetNumVisible()
end

function UINFriendshipPresentNodeGiftItem:PressAdd()
  local pressedTime = self.ui.btn_presentItem:GetPressedTime()
  local addNum = math.ceil(pressedTime * pressedTime / 5)
  if not (self.giftData.selectNum + addNum <= self.itemNum) then
    addNum = self.itemNum - self.giftData.selectNum
  end
  if addNum <= 0 then
    return
  end
  local expAdd = self:GetIntimacyAddNum()
  local could, maxExp = self.addExpCallback(expAdd * addNum, expAdd)
  if could then
    local beforeSelectNum = self.giftData.selectNum
    self.giftData.selectNum = self.giftData.selectNum + math.min(addNum, math.ceil(maxExp / self:GetIntimacyAddNum()))
    if beforeSelectNum < self.giftData.selectNum then
      AudioManager:PlayAudioById(1064)
    end
  end
  self.changeSelectCallback(self.giftItemID, self.giftData.selectNum)
  self.ui.tex_Count.text = tostring(self.giftData.selectNum)
  self:SetNumVisible()
end

function UINFriendshipPresentNodeGiftItem:MineOne()
  if self.giftData.selectNum > 0 and self.minExpCallback(self:GetIntimacyAddNum()) then
    self.giftData.selectNum = self.giftData.selectNum - 1
  end
  self.changeSelectCallback(self.giftItemID, self.giftData.selectNum)
  self.ui.tex_Count.text = tostring(self.giftData.selectNum)
  self:SetNumVisible()
end

function UINFriendshipPresentNodeGiftItem:SetNumVisible()
  self.ui.obj_selectCount:SetActive(self.giftData.selectNum > 0)
  self.ui.obj_btn_Minus:SetActive(self.giftData.selectNum > 0)
end

function UINFriendshipPresentNodeGiftItem:OnDelete()
  base.OnDelete(self)
end

return UINFriendshipPresentNodeGiftItem
