local UINActivityCollectFortuneGiftNode = class("UINActivityCollectFortuneGiftNode", UIBaseNode)
local base = UIBaseNode
local UINActivityCollectFortuneGiftLotteryToggleItem = require("Game.ActivityCollectFortune.UI.UINActivityCollectFortuneGiftLotteryToggleItem")
local UINActivityCollectFortuneFriendItem = require("Game.ActivityCollectFortune.UI.UINActivityCollectFortuneFriendItem")
local ActivityCollectFortuneEnum = require("Game.ActivityCollectFortune.Data.ActivityCollectFortuneEnum")
local cs_MessageCommon = CS.MessageCommon
local cs_LayoutRebuilder = CS.UnityEngine.UI.LayoutRebuilder

function UINActivityCollectFortuneGiftNode:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self._toggleItemList = {}
  for index, comp in ipairs(self.ui.ToggleArray) do
    local toggle = UINActivityCollectFortuneGiftLotteryToggleItem.New()
    toggle:Init(comp.gameObject)
    UIUtil.AddValueChangedListener(comp, self, self.OnGiftLotteryToggleItemChanged, index)
    table.insert(self._toggleItemList, toggle)
  end
  self._itemDic = {}
  self._friendItemDic = {}
  self.ui.loop_scroll.onInstantiateItem = BindCallback(self, self.__OnInstantiateItem)
  self.ui.loop_scroll.onChangeItem = BindCallback(self, self.__OnChangeItem)
  self.__OnClickBtnReceive = BindCallback(self, self.OnClickBtnReceive)
  self.__OnClickBtnReturn = BindCallback(self, self.OnClickBtnReturn)
  self.OperateFuncs = {
    [1] = self.__OnClickBtnReceive,
    [2] = self.__OnClickBtnReturn
  }
  UIUtil.AddButtonListener(self.ui.Btn_GetAll, self, self.OnClickBtnGetAll)
end

function UINActivityCollectFortuneGiftNode:InitCollectFortuneGiftNode(actData, clickReturnFunc, resLoader)
  self._actData = actData
  self._clickReturnFunc = clickReturnFunc
  self._resLoader = resLoader
  local mainCfg = actData:GetActCollectFortuneMainCfg()
  if mainCfg == nil then
    error("cant find activity collectfortune config!!")
    return
  end
  for index, toggleItem in ipairs(self._toggleItemList) do
    toggleItem:InitCollectFortuneToggleItem()
  end
  local index = ActivityCollectFortuneEnum.eGiftNodeType.Receive
  local toggleItem = self._toggleItemList[index]
  toggleItem:SetToggleItemIsSelected(true)
end

function UINActivityCollectFortuneGiftNode:RefreshCollectFortuneGiftList(index)
  self.__chooseTabIndex = index
  local list
  if index == ActivityCollectFortuneEnum.eGiftNodeType.History then
    list = self._actData:GetActCollectFortuneReceivedList()
  else
    list = self._actData:GetActCollectFortuneToReceiveList()
  end
  self._giftDataList = list
  local totalCount = #list
  local isInReceiveNode = index == ActivityCollectFortuneEnum.eGiftNodeType.Receive
  self.ui.DownNode:SetActive(isInReceiveNode)
  if isInReceiveNode then
    local generalGiftCfg = ConfigData.activity_general_gift_item[self._actData:GetActFrameId()]
    if generalGiftCfg == nil then
      error("cant find activity_general_gift_item config!! actId:" .. tostring(self._actData:GetActFrameId()))
      return
    end
    local maxCount = generalGiftCfg.waiting_limit
    self.ui.Tex_DailyCap:SetIndex(0, tostring(totalCount), tostring(maxCount))
  end
  if self.ui.loop_scroll.totalCount ~= totalCount then
    self.ui.loop_scroll.totalCount = totalCount
  end
  self.ui.loop_scroll:RefreshCells()
end

function UINActivityCollectFortuneGiftNode:__OnInstantiateItem(go)
  local friendItem = UINActivityCollectFortuneFriendItem.New()
  friendItem:Init(go)
  self._itemDic[go] = friendItem
end

function UINActivityCollectFortuneGiftNode:__OnChangeItem(go, index)
  local friendItem = self._itemDic[go]
  local giftData = self._giftDataList[index + 1]
  local giftDataList = {}
  local idIndexDic = self._actData:GetActCollectFortuneItemRevertIndexDic()
  for itemId, num in pairs(giftData.SendItems) do
    local index = idIndexDic[itemId]
    local sendGiftData = {
      index = index,
      itemId = itemId,
      count = num
    }
    table.insert(giftDataList, sendGiftData)
  end
  friendItem:InitActCollectFortuneFriendItemByGiftData(giftData, giftDataList, self.OperateFuncs[self.__chooseTabIndex], self._resLoader)
  friendItem:InitFriendItemBtnText(self.__chooseTabIndex)
  if self._friendItemDic[giftData.sender] == nil then
    self._friendItemDic[giftData.sender] = {}
  end
  self._friendItemDic[giftData.sender][giftData.sendTm] = friendItem
  cs_LayoutRebuilder.ForceRebuildLayoutImmediate(self.ui.loop_scroll.transform)
end

function UINActivityCollectFortuneGiftNode:OnClickBtnReceive(friendId, giftData, isAll)
  local actFrameNet = NetworkManager:GetNetwork(NetworkTypeID.ActivityFrame)
  if actFrameNet == nil then
    error("cant find activityFrameNetworkCtrl!")
    return
  end
  local actLongId = self._actData:GetActFrameId()
  if isAll then
    actFrameNet:CS_ACTIVITY_General_Gift_Item_Receive(actLongId, nil, nil, true, function()
      self:RefreshCollectFortuneGiftList(self.__chooseTabIndex)
    end)
  else
    actFrameNet:CS_ACTIVITY_General_Gift_Item_Receive(actLongId, giftData.sender, giftData.sendTm, nil, function()
      self:RefreshCollectFortuneGiftList(self.__chooseTabIndex)
    end)
  end
end

function UINActivityCollectFortuneGiftNode:OnClickBtnReturn()
  if self._clickReturnFunc ~= nil then
    self._clickReturnFunc()
  end
end

function UINActivityCollectFortuneGiftNode:OnClickBtnGetAll()
  local totalCount = #self._giftDataList
  if totalCount == 0 then
    cs_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(50011))
    return
  end
  self:OnClickBtnReceive(nil, nil, true)
end

function UINActivityCollectFortuneGiftNode:OnGiftLotteryToggleItemChanged(index, isOn)
  if isOn then
    self:RefreshCollectFortuneGiftList(index)
  end
  local item = self._toggleItemList[index]
  local color = self.ui.NotChooseColor
  local textColor = self.ui.TextNotChooseColor
  if isOn then
    color = self.ui.ChooseColor
    textColor = self.ui.TextChooseColor
  end
  item:OnToggleItemValueChanged(isOn, color, textColor)
end

function UINActivityCollectFortuneGiftNode:OnDelete()
  for _, item in ipairs(self._toggleItemList) do
    item:Delete()
  end
  base.OnDelete(self)
end

return UINActivityCollectFortuneGiftNode
