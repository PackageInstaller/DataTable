local UINFriendshipPresentNode = class("UINFriendshipPresentNode", UIBaseNode)
local base = UIBaseNode
local UINFriendshipPresentNodeGiftItem = require("Game.Friendship.NewFriendshipUI.UINFriendshipPresentNodeGiftItem")
local eLiskeDegree = require("Game.Friendship.NewFriendshipUI.eLikeDegree")

function UINFriendshipPresentNode:OnInit()
  self.networkCtrl = NetworkManager:GetNetwork(NetworkTypeID.Friendship)
  self.resloader = nil
  self.targetHeroID = nil
  self.selectedGifts = {}
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_ClearSelect, self, self.OnReset)
  UIUtil.AddButtonListener(self.ui.btn_Give, self, self.Send)
  self.__RegenerateGifts = BindCallback(self, self.RegenerateGifts)
  MsgCenter:AddListener(eMsgEventId.UpdateItem, self.__RegenerateGifts)
  self.ui.loop_scroll.onInstantiateItem = BindCallback(self, self.m_OnNewItem)
  self.ui.loop_scroll.onChangeItem = BindCallback(self, self.m_OnChangeItem)
  self.__ChangeSelect = Bind(self, self.ChangeSelect)
end

function UINFriendshipPresentNode:InitResloader(resloader, addExpCallback, minExpCallback, friendshipLevelUI)
  self.resloader = resloader
  self.addExpCallback = addExpCallback
  self.minExpCallback = minExpCallback
  self.friendshipLevelUI = friendshipLevelUI
end

function UINFriendshipPresentNode:InitSendGift(heroID)
  self.targetHeroID = heroID
  self.sendNum = {}
  self:RegenerateGifts()
end

function UINFriendshipPresentNode:GetLikeDegree(heroId, giftItemID)
  if ConfigData.friendship_hero[heroId].likeGifts[giftItemID] then
    return eLiskeDegree.like
  elseif ConfigData.friendship_hero[heroId].dislikeGifts[giftItemID] then
    return eLiskeDegree.dislike
  else
    return eLiskeDegree.normal
  end
end

function UINFriendshipPresentNode:GetIntimacyAddNum(likeDegree, giftItemID)
  if likeDegree == eLiskeDegree.like then
    return ConfigData.friendship_gift[giftItemID].gift_like
  elseif likeDegree == eLiskeDegree.dislike then
    return ConfigData.friendship_gift[giftItemID].gift_dislike
  else
    return ConfigData.friendship_gift[giftItemID].gift_base
  end
end

function UINFriendshipPresentNode:RegenerateGifts()
  self.selectedGiftId = {}
  self.selectedGitfNums = {}
  local giftList = {}
  for key, value in pairs(ConfigData.friendship_gift) do
    local likeDegree = self:GetLikeDegree(self.targetHeroID, value.id)
    local addValue = self:GetIntimacyAddNum(likeDegree, value.id)
    local giftData = {
      giftCfg = value,
      id = value.id,
      likeDegree = likeDegree,
      addValue = addValue,
      selectNum = 0
    }
    table.insert(giftList, giftData)
  end
  table.sort(giftList, Bind(self, self.SortGifts))
  self.__giftList = giftList
  self.ui.loop_scroll.totalCount = #giftList
  if self.giftDic == nil then
    self.giftDic = {}
    self.ui.loop_scroll:RefillCells()
  else
    self:OnReset()
  end
end

function UINFriendshipPresentNode:m_OnNewItem(go)
  local gitfItem = UINFriendshipPresentNodeGiftItem.New()
  gitfItem:Init(go)
  self.giftDic[go] = gitfItem
end

function UINFriendshipPresentNode:m_OnChangeItem(go, index)
  local gitfItem = self.giftDic[go]
  if gitfItem == nil then
    error("Can't find levelItem by gameObject")
    return
  end
  local giftData = self.__giftList[index + 1]
  if giftData == nil then
    error("Can't find levelData by index, index = " .. tonumber(index))
  end
  gitfItem:InitGiftItem(self.targetHeroID, self.resloader, giftData, self.addExpCallback, self.minExpCallback, self.__ChangeSelect)
end

function UINFriendshipPresentNode:SortGifts(giftA, giftB)
  local isLikeA = giftA.likeDegree == eLiskeDegree.like
  local isLikeB = giftB.likeDegree == eLiskeDegree.like
  if isLikeA ~= isLikeB then
    return isLikeA
  end
  local isDislikeA = giftA.likeDegree == eLiskeDegree.dislike
  local isDislikeB = giftB.likeDegree == eLiskeDegree.dislike
  if isDislikeA ~= isDislikeB then
    return not isDislikeA
  end
  local itemCfgA = ConfigData.item[giftA.id]
  local itemCfgB = ConfigData.item[giftB.id]
  if itemCfgA.quality ~= itemCfgB.quality then
    return itemCfgA.quality > itemCfgB.quality
  end
  local numA = PlayerDataCenter:GetItemCount(giftA.id)
  local numB = PlayerDataCenter:GetItemCount(giftB.id)
  if numA ~= numB then
    return numA > numB
  end
  return giftA.id > giftB.id
end

function UINFriendshipPresentNode:ChangeSelect(itemId, itemNum)
  if itemNum == 0 then
    if self.selectedGifts[itemId] ~= nil then
      self.selectedGifts[itemId] = nil
    end
  else
    self.selectedGifts[itemId] = itemNum
  end
  self:RefreshPresentConfirmBtn()
end

function UINFriendshipPresentNode:OnReset()
  for _, giftData in ipairs(self.__giftList) do
    if giftData.selectNum ~= 0 then
      self.minExpCallback(giftData.addValue * giftData.selectNum)
      giftData.selectNum = 0
    end
  end
  self.selectedGifts = {}
  self.ui.loop_scroll:RefreshCells()
end

function UINFriendshipPresentNode:Send()
  if table.count(self.selectedGifts) < 1 then
    return
  end
  local data = self.friendshipLevelUI.whenAddData
  local tweenDiffData = self.friendshipLevelUI.tweenDiffData
  self.lastLevel = PlayerDataCenter.allFriendshipData:GetLevel(self.targetHeroID)
  self.networkCtrl:CS_INTIMACY_Presentation(self.targetHeroID, self.selectedGifts, function()
    local level = PlayerDataCenter.allFriendshipData:GetLevel(self.targetHeroID)
    if level ~= self.lastLevel then
      UIManager:ShowWindow(UIWindowTypeID.HeroLevelUpSuccess):FriendShipLevelUp(self.lastLevel, level)
    end
    self.lastLevel = nil
    self:OnReset()
    local win = UIManager:GetWindow(UIWindowTypeID.FriendShip)
    if win ~= nil then
      win.friendshipLevelUI:ShowExpBarTween(tweenDiffData)
    end
  end, data.level, data.exp)
end

function UINFriendshipPresentNode:OnClose()
  self.sendNum = 0
  self.ui.tex_Count.text = tostring(self.sendNum)
end

function UINFriendshipPresentNode:RefreshPresentConfirmBtn()
  self.ui.img_Give.color = self.ui.color_gray
  self.ui.btn_Give.interactable = false
  self.ui.btn_ClearSelect.gameObject:SetActive(false)
  if PlayerDataCenter.allFriendshipData:IsFriendShipMaxLevel(self.targetHeroID) then
    return
  end
  local isSelect = false
  if table.count(self.selectedGifts) ~= 0 then
    for itemId, num in pairs(self.selectedGifts) do
      if 0 < num then
        isSelect = true
      end
    end
  end
  if isSelect then
    self.ui.img_Give.color = self.ui.color_orange
    self.ui.btn_Give.interactable = true
    self.ui.btn_ClearSelect.gameObject:SetActive(true)
  end
end

function UINFriendshipPresentNode:OnDelete()
  MsgCenter:RemoveListener(eMsgEventId.UpdateItem, self.__RegenerateGifts)
  base.OnDelete(self)
end

return UINFriendshipPresentNode
