local UINActivityCollectFortuneDonateNode = class("UINActivityCollectFortuneDonateNode", UIBaseNode)
local base = UIBaseNode
local UINActivityCollectFortuneItem = require("Game.ActivityCollectFortune.UI.UINActivityCollectFortuneItem")
local UINActivityCollectFortuneFriendItem = require("Game.ActivityCollectFortune.UI.UINActivityCollectFortuneFriendItem")
local cs_MessageCommon = CS.MessageCommon

function UINActivityCollectFortuneDonateNode:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self._itemListPool = UIItemPool.New(UINActivityCollectFortuneItem, self.ui.GiftItem)
  self.ui.GiftItem:SetActive(false)
  self._itemDic = {}
  self._friendItemDic = {}
  self.ui.loop_scroll.onInstantiateItem = BindCallback(self, self.__OnInstantiateItem)
  self.ui.loop_scroll.onChangeItem = BindCallback(self, self.__OnChangeItem)
  self._DonateFunc = BindCallback(self, self.OnClickBtnDonate)
  UIUtil.AddButtonListener(self.ui.Btn_AddFriend, self, self.OnClickBtnAddFriend)
end

function UINActivityCollectFortuneDonateNode:BindCloseFunc(func)
  self._closeFunc = func
end

function UINActivityCollectFortuneDonateNode:InitActCollectFortuneDonateNode(actData, resLoader)
  UIUtil.SetTopStatus(self, self.OnClickBack)
  self._chooseItem = nil
  self._chooseCount = 0
  self._actData = actData
  self._resLoader = resLoader
  self:InitActCollectFortuneDonateGiftList()
  self:InitActCollectFortuneDonateFriendList()
end

function UINActivityCollectFortuneDonateNode:InitActCollectFortuneDonateGiftList()
  local mainCfg = self._actData:GetActCollectFortuneMainCfg()
  if mainCfg == nil then
    error("cant find collect fortune config!!")
    return
  end
  self._itemListPool:HideAll()
  self._itemIdList = {}
  local itemIdListWithIndex = self._actData:GetActCollectFortuneItemIdListWithIndex()
  for index, idList in ipairs(itemIdListWithIndex) do
    table.insert(self._itemIdList, idList[1])
    local id = idList[1]
    local count = PlayerDataCenter:GetItemCount(id)
    local item = self._itemListPool:GetOne()
    item:InitCollectFortuneItem(index, id, count, BindCallback(self, self.OnClickOperateItem))
    item:BindCollectFortuneOperateFunc(BindCallback(self, self.OnClickMinusItem))
  end
  self:RefreshDonateTimesText()
end

function UINActivityCollectFortuneDonateNode:ResetActCollectFortuneDonateGiftList()
  for index, id in ipairs(self._itemIdList) do
    local item = self._itemListPool.listItem[index]
    local count = PlayerDataCenter:GetItemCount(id)
    item:InitCollectFortuneItem(index, id, count, BindCallback(self, self.OnClickOperateItem))
    item:BindCollectFortuneOperateFunc(BindCallback(self, self.OnClickMinusItem))
    if self._chooseItem ~= nil and id == self._chooseItem then
      item:SetCollectFortuneItemOperateNum(self._chooseCount)
      item:SetCollectFortuneItemLocked(self._chooseCount > 0)
    else
      item:SetCollectFortuneItemOperateNum(0)
      item:SetCollectFortuneItemLocked(false)
    end
  end
end

function UINActivityCollectFortuneDonateNode:InitActCollectFortuneDonateFriendList()
  self._friendDataList = PlayerDataCenter.friendDataCenter:GetFreindList()
  local totalCount = #self._friendDataList
  if self.ui.loop_scroll.totalCount ~= totalCount then
    self.ui.loop_scroll.totalCount = totalCount
  end
  self.ui.loop_scroll:RefreshCells()
end

function UINActivityCollectFortuneDonateNode:UpdateDonateNodeByDayPass()
  self:RefreshDonateTimesText()
end

function UINActivityCollectFortuneDonateNode:RefreshDonateTimesText()
  local times = self._actData:GetActCollectFortuneGiftLimitTimes()
  if times == nil or times <= 0 then
    times = 0
  end
  local generalGiftCfg = self._actData:GetActCollectFortuneGeneralGiftCfg()
  local maxTimes = generalGiftCfg.gift_limit
  self.ui.Tex_Num:SetIndex(0, tostring(times), tostring(maxTimes))
end

function UINActivityCollectFortuneDonateNode:__OnInstantiateItem(go)
  local friendItem = UINActivityCollectFortuneFriendItem.New()
  friendItem:Init(go)
  self._itemDic[go] = friendItem
end

function UINActivityCollectFortuneDonateNode:__OnChangeItem(go, index)
  local friendItem = self._itemDic[go]
  local friendData = self._friendDataList[index + 1]
  local actItems = friendData:GetActShowItems()
  local itemIndexDic = self._actData:GetActCollectFortuneItemRevertIndexDic()
  local itemIdListWithIndex = self._actData:GetActCollectFortuneItemIdListWithIndex()
  local giftDataList = {}
  for itemId, num in pairs(actItems) do
    local index = itemIndexDic[itemId]
    if giftDataList[index] == nil then
      local realItemId = itemIdListWithIndex[index][1]
      giftDataList[index] = {
        index = index,
        itemId = realItemId,
        count = 0
      }
    end
    giftDataList[index].count = giftDataList[index].count + num
  end
  if table.count(giftDataList) < table.count(itemIdListWithIndex) then
    for index, idList in ipairs(itemIdListWithIndex) do
      if giftDataList[index] == nil then
        giftDataList[index] = {
          index = index,
          itemId = idList[1],
          count = 0
        }
      end
    end
  end
  friendItem:InitActCollectFortuneFriendItemByFriendData(friendData, giftDataList, self._DonateFunc, self._resLoader)
  self._friendItemDic[friendData:GetUserUID()] = friendItem
end

function UINActivityCollectFortuneDonateNode:OnClickOperateItem(index)
  local curDayTimes = self._actData:GetActCollectFortuneGiftLimitTimes()
  local generalGiftCfg = self._actData:GetActCollectFortuneGeneralGiftCfg()
  local maxTimes = generalGiftCfg.gift_limit
  if curDayTimes >= maxTimes then
    cs_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(50009))
    return
  end
  if self._chooseItem ~= nil and self._chooseItem ~= self._itemIdList[index] then
    cs_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(50004))
    return
  end
  local haveCount = PlayerDataCenter:GetItemCount(self._itemIdList[index])
  if haveCount <= 0 then
    cs_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(50005))
    return
  end
  if maxTimes <= curDayTimes + self._chooseCount then
    cs_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(50007))
    return
  end
  if self._chooseItem == nil then
    self._chooseItem = self._itemIdList[index]
    self._chooseCount = 1
  elseif self._chooseItem == self._itemIdList[index] then
    self._chooseCount = self._chooseCount + 1
  end
  local item = self._itemListPool.listItem[index]
  self._chooseCount = math.min(self._chooseCount, haveCount)
  item:SetCollectFortuneItemOperateNum(self._chooseCount)
  if 0 < self._chooseCount then
    for i, item in ipairs(self._itemListPool.listItem) do
      if i ~= index then
        item:SetCollectFortuneItemLocked(true)
      end
    end
  end
end

function UINActivityCollectFortuneDonateNode:OnClickMinusItem(index)
  if self._chooseItem == nil or self._chooseItem ~= self._itemIdList[index] then
    return
  end
  local item = self._itemListPool.listItem[index]
  self._chooseCount = math.max(0, self._chooseCount - 1)
  item:SetCollectFortuneItemOperateNum(self._chooseCount)
  if self._chooseCount == 0 then
    for i, item in ipairs(self._itemListPool.listItem) do
      if i ~= index then
        item:SetCollectFortuneItemLocked(false)
      end
    end
    self._chooseItem = nil
  end
end

function UINActivityCollectFortuneDonateNode:OnClickBtnAddFriend()
  local friendNetCtrl = NetworkManager:GetNetwork(NetworkTypeID.Friend)
  friendNetCtrl:CS_FRIEND_RefreshFriend()
  UIManager:ShowWindowAsync(UIWindowTypeID.UserFreined, function(win)
    if win == nil then
      return
    end
    win:InitUserFriend()
    win:OnClickAddFriend()
  end)
end

function UINActivityCollectFortuneDonateNode:OnClickBtnDonate(friendId)
  local curDayTimes = self._actData:GetActCollectFortuneGiftLimitTimes()
  local generalGiftCfg = self._actData:GetActCollectFortuneGeneralGiftCfg()
  local maxTimes = generalGiftCfg.gift_limit
  if self._chooseItem == nil or self._chooseCount <= 0 then
    if curDayTimes >= maxTimes then
      cs_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(50009))
    else
      cs_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(50006))
    end
    return
  end
  if curDayTimes >= maxTimes or maxTimes < curDayTimes + self._chooseCount then
    cs_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(50007))
    return
  end
  local actFrameNet = NetworkManager:GetNetwork(NetworkTypeID.ActivityFrame)
  if actFrameNet then
    local actLongId = self._actData:GetActFrameId()
    local receiver = friendId
    local sendItem = {}
    local itemIdRevertDic = self._actData:GetActCollectFortuneItemRevertIdDic()
    local curChooseId = itemIdRevertDic[self._chooseItem]
    sendItem[curChooseId] = self._chooseCount
    actFrameNet:CS_ACTIVITY_General_Gift_Item_Send(actLongId, receiver, sendItem, function()
      local rewards = table.deepCopy(generalGiftCfg.gift_send_reward)
      for id, num in pairs(rewards) do
        local count = num * self._chooseCount
        rewards[id] = count
      end
      UIUtil.ShowCommonReward(rewards)
      self._chooseItem = nil
      self._chooseCount = 0
      self:ResetActCollectFortuneDonateGiftList()
      self:RefreshDonateTimesText()
    end)
  end
end

function UINActivityCollectFortuneDonateNode:OnClickBack()
  if self._closeFunc ~= nil then
    self._closeFunc(self.gameObject)
  end
  self:Hide()
  UIUtil.PopFromBackStackByUiTab(self)
end

function UINActivityCollectFortuneDonateNode:OnDelete()
  self._itemListPool:DeleteAll()
  base.OnDelete(self)
end

return UINActivityCollectFortuneDonateNode
