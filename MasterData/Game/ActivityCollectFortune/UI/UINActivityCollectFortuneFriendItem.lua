local UINActivityCollectFortuneFriendItem = class("UINActivityCollectFortuneFriendItem", UIBaseNode)
local base = UIBaseNode
local UINUserHead = require("Game.CommonUI.Head.UINUserHead")
local UINActivityCollectFortuneFriendGiftItem = require("Game.ActivityCollectFortune.UI.UINActivityCollectFortuneFriendGiftItem")

function UINActivityCollectFortuneFriendItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.userHeadNode = UINUserHead.New()
  self.userHeadNode:Init(self.ui.UINUserHead)
  self._itemListPool = UIItemPool.New(UINActivityCollectFortuneFriendGiftItem, self.ui.GiftItem)
  self.ui.GiftItem:SetActive(false)
  if self.ui.Btn_Operate then
    UIUtil.AddButtonListener(self.ui.Btn_Operate, self, self.OnClickBtnOperate)
  end
end

function UINActivityCollectFortuneFriendItem:InitActCollectFortuneFriendItemByFriendData(friendData, giftDataList, operateFunc, resloader)
  self._cacheData = friendData
  self._friendId = friendData:GetUserUID()
  self._giftDataList = giftDataList
  self._operateFunc = operateFunc
  self._resLoader = resloader
  self:InitFriendItemUI()
  self:InitGiftItemUI()
end

function UINActivityCollectFortuneFriendItem:InitActCollectFortuneFriendItemByGiftData(giftData, giftDataList, operateFunc, resloader)
  self._cacheData = giftData
  self._friendId = giftData.sender
  self._giftDataList = giftDataList
  self._operateFunc = operateFunc
  self._resLoader = resloader
  self:InitFriendItemUI()
  self:InitGiftItemUI()
end

function UINActivityCollectFortuneFriendItem:InitFriendItemUI()
  local friendData = PlayerDataCenter.friendDataCenter:TryGetFriendData(self._friendId)
  if friendData == nil then
    error("cant find friendData!! UID:" .. tostring(self._friendId))
  end
  self.ui.tex_Name.text = friendData:GetAlias()
  self.ui.tex_Level.text = friendData:GetUserLevel()
  self.userHeadNode:InitUserHeadUI(friendData:GetAvatarId(), friendData:GetAvatarFrameId(), self._resLoader)
  self:RefreshFrienOnlineState(friendData)
end

function UINActivityCollectFortuneFriendItem:InitFriendItemBtnText(index)
  if self.ui.Tex_Operate then
    self.ui.Tex_Operate:SetIndex(index - 1)
  end
end

function UINActivityCollectFortuneFriendItem:RefreshFrienOnlineState(friendData)
  local lastOfflineTs = friendData:GetOnlineState()
  if lastOfflineTs == nil then
    self.ui.obj_OnLine:SetActive(false)
    self.ui.obj_OffLine:SetActive(false)
    return
  elseif lastOfflineTs == 0 then
    self.ui.obj_OnLine:SetActive(true)
    self.ui.obj_OffLine:SetActive(false)
    return
  end
  self.ui.obj_OnLine:SetActive(false)
  self.ui.obj_OffLine:SetActive(true)
  local timepassCtrl = ControllerManager:GetController(ControllerTypeId.TimePass, false)
  local isToday, dayPassTimeStamp = timepassCtrl:GetIsLogicToday(lastOfflineTs)
  if not isToday then
    local timeSpan = dayPassTimeStamp - lastOfflineTs
    local day = math.floor(timeSpan / 86400)
    self.ui.tex_Time:SetIndex(1, tostring(day))
  else
    local timeSpan = PlayerDataCenter.timestamp - lastOfflineTs
    local hour = math.floor(timeSpan / 3600)
    self.ui.tex_Time:SetIndex(0, tostring(hour))
  end
end

function UINActivityCollectFortuneFriendItem:InitGiftItemUI()
  self._itemListPool:HideAll()
  if self._giftDataList == nil then
    return
  end
  for _, data in ipairs(self._giftDataList) do
    local item = self._itemListPool:GetOne()
    item:InitActCollectFortuneFriendGiftItem(data)
  end
end

function UINActivityCollectFortuneFriendItem:OnClickBtnOperate()
  if self._operateFunc ~= nil then
    self._operateFunc(self._friendId, self._cacheData)
  end
end

function UINActivityCollectFortuneFriendItem:OnDelete()
  self._itemListPool:DeleteAll()
  base.OnDelete(self)
end

return UINActivityCollectFortuneFriendItem
