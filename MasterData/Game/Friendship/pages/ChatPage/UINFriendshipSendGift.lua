local UINFriendshipSendGift = class("UINFriendshipSendGift", UIBaseNode)
local base = UIBaseNode
local UINFriendshipGiftItem = require("Game.Friendship.pages.ChatPage.UINFriendshipGiftItem")

function UINFriendshipSendGift:OnInit()
  self.networkCtrl = NetworkManager:GetNetwork(NetworkTypeID.Friendship)
  self.resloader = nil
  self.targetHeroID = nil
  self.sendNum = 0
  self.selectedGiftId = nil
  self.selectedGitfNum = 0
  self.selectedGitfMaxSendNum = 0
  self.selectedGitgIntimacyValue = 0
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Add, self, self.AddOne)
  self.ui.btn_Add.onPress:AddListener(BindCallback(self, self.AccelerateAddOne))
  UIUtil.AddButtonListener(self.ui.btn_Sub, self, self.SubOne)
  self.ui.btn_Sub.onPress:AddListener(BindCallback(self, self.SubOne))
  UIUtil.AddButtonListener(self.ui.btn_Max, self, self.OnMax)
  UIUtil.AddButtonListener(self.ui.btn_Reset, self, self.OnReset)
  UIUtil.AddButtonListener(self.ui.btn_GiveGift, self, self.Send)
  self.__RegenerateGifts = BindCallback(self, self.RegenerateGifts)
  MsgCenter:AddListener(eMsgEventId.UpdateItem, self.__RegenerateGifts)
  self.giftPool = UIItemPool.New(UINFriendshipGiftItem, self.ui.giftItem)
  self.ui.giftItem:SetActive(false)
  self.ui.tex_Count.text = tostring(self.sendNum)
end

function UINFriendshipSendGift:InitResloader(resloader)
  self.resloader = resloader
end

function UINFriendshipSendGift:InitSendGift(heroID, refreshIntimacyBarCallBack)
  self.targetHeroID = heroID
  self.refreshIntimacyBarCallBack = refreshIntimacyBarCallBack
  self.sendNum = 0
  self.ui.tex_Count.text = tostring(self.sendNum)
  self:RegenerateGifts()
end

function UINFriendshipSendGift:RegenerateGifts()
  self.giftPool:HideAll()
  self.selectedGiftId = nil
  local giftList = {}
  local like = ConfigData.friendship_hero[self.targetHeroID].likeGifts
  local dislike = ConfigData.friendship_hero[self.targetHeroID].dislikeGifts
  for key, value in pairs(ConfigData.friendship_gift) do
    local giftData = {
      id = value.id,
      isLike = like[value.id],
      isDislike = dislike[value.id]
    }
    table.insert(giftList, giftData)
  end
  table.sort(giftList, Bind(self, self.SortGifts))
  for _, gift in ipairs(giftList) do
    local gitfItem = self.giftPool:GetOne(true)
    local itemNum = PlayerDataCenter:GetItemCount(gift.id)
    gitfItem:InitGiftItem(self.targetHeroID, self.resloader, gift.id, itemNum, function()
      if self.selectedGiftId == gift.id then
        return
      end
      self.selectedGiftId = gift.id
      self.sendNum = 0
      self.ui.tex_Count.text = tostring(self.sendNum)
      self.selectedGitfNum = itemNum
      self.selectedGitgIntimacyValue = gitfItem:GetIntimacyAddNum()
      self.selectedGitfMaxSendNum = math.ceil(self:GetMaxAddableEXP() / self.selectedGitgIntimacyValue)
      self.refreshIntimacyBarCallBack()
    end, function()
      self.selectedGiftId = nil
      self.sendNum = 0
      self.ui.tex_Count.text = tostring(self.sendNum)
      self.selectedGitfNum = 0
      self.refreshIntimacyBarCallBack()
    end)
  end
end

function UINFriendshipSendGift:SortGifts(giftA, giftB)
  local isLikeA = giftA.isLike
  local isLikeB = giftB.isLike
  local isDislikeA = giftA.isDislike
  local isDislikeB = giftB.isDislike
  if isLikeA == isLikeB then
    if isDislikeA == isDislikeB then
      if PlayerDataCenter:GetItemCount(giftA.id) > 0 == (PlayerDataCenter:GetItemCount(giftB.id) > 0) then
        return giftA.id > giftB.id
      else
        return PlayerDataCenter:GetItemCount(giftA.id) > 0
      end
    else
      return not isDislikeA
    end
  else
    return isLikeA
  end
end

function UINFriendshipSendGift:AddOne()
  if self.sendNum + 1 > self.selectedGitfNum or self.sendNum + 1 > self.selectedGitfMaxSendNum then
    return
  end
  self.sendNum = self.sendNum + 1
  self.ui.tex_Count.text = tostring(self.sendNum)
  self.refreshIntimacyBarCallBack(self.sendNum * self.selectedGitgIntimacyValue)
end

function UINFriendshipSendGift:AccelerateAddOne()
  local pressedTime = self.ui.btn_Add:GetPressedTime()
  local addNum = math.ceil(pressedTime)
  if self.sendNum + addNum > self.selectedGitfNum or self.sendNum + addNum > self.selectedGitfMaxSendNum then
    local newAddNum = math.min(self.selectedGitfNum - self.sendNum, self.selectedGitfMaxSendNum - self.sendNum)
    if 0 < newAddNum then
      addNum = newAddNum
    else
      return
    end
  end
  self.sendNum = self.sendNum + addNum
  self.ui.tex_Count.text = tostring(self.sendNum)
  self.refreshIntimacyBarCallBack(self.sendNum * self.selectedGitgIntimacyValue)
end

function UINFriendshipSendGift:SubOne()
  if self.sendNum > 0 then
    self.sendNum = self.sendNum - 1
    self.ui.tex_Count.text = tostring(self.sendNum)
    self.refreshIntimacyBarCallBack(self.sendNum * self.selectedGitgIntimacyValue)
  end
end

function UINFriendshipSendGift:OnMax()
  if self.selectedGitfNum >= self.selectedGitfMaxSendNum then
    self.sendNum = self.selectedGitfMaxSendNum
    self.ui.tex_Count.text = tostring(self.sendNum)
    self.refreshIntimacyBarCallBack(self.sendNum * self.selectedGitgIntimacyValue)
  else
    self.sendNum = self.selectedGitfNum
    self.ui.tex_Count.text = tostring(self.sendNum)
    self.refreshIntimacyBarCallBack(self.sendNum * self.selectedGitgIntimacyValue)
  end
end

function UINFriendshipSendGift:OnReset()
  self.sendNum = 0
  self.ui.tex_Count.text = tostring(self.sendNum)
  self.refreshIntimacyBarCallBack()
end

function UINFriendshipSendGift:Send()
  if self.targetHeroID == nil or self.sendNum <= 0 or self.selectedGiftId == nil then
    return
  end
  self.networkCtrl:CS_INTIMACY_Presentation(self.targetHeroID, self.selectedGiftId, self.sendNum)
end

function UINFriendshipSendGift:GetMaxAddableEXP()
  local nowLevel = PlayerDataCenter.allFriendshipData:GetLevel(self.targetHeroID)
  local nowExp = PlayerDataCenter.allFriendshipData:GetExp(self.targetHeroID)
  local AddableEXP = 0
  for level = nowLevel, #ConfigData.friendship_level do
    AddableEXP = AddableEXP + ConfigData.friendship_level[level].friendship
  end
  AddableEXP = AddableEXP - nowExp
  return AddableEXP
end

function UINFriendshipSendGift:OnClose()
  self.sendNum = 0
  self.ui.tex_Count.text = tostring(self.sendNum)
  self.refreshIntimacyBarCallBack()
end

function UINFriendshipSendGift:OnDelete()
  MsgCenter:RemoveListener(eMsgEventId.UpdateItem, self.__RegenerateGifts)
  base.OnDelete(self)
end

return UINFriendshipSendGift
