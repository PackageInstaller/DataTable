local ExplorationTreasureCtrl = class("ExplorationTreasureCtrl", ExplorationCtrlBase)
local cs_MessageCommon = CS.MessageCommon
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")
local EpStoreRoomUtil = require("Game.Exploration.Util.EpStoreRoomUtil")
local MAX_TREASURE_LOCK_NUM = 2

function ExplorationTreasureCtrl:ctor(epCtrl)
  self.netWork = NetworkManager:GetNetwork(NetworkTypeID.ItemRoom)
  self.treasureDataDic = {}
  self.lockNum = 0
  self.currPosition = nil
  self.epCtrl = epCtrl
  self.waitRefersh = false
  self.uiWindow = nil
  self.__OnTreasureRoomUpdate = BindCallback(self, self.__RefreshRoomData)
  MsgCenter:AddListener(eMsgEventId.OnTreasureRoomUpdate, self.__OnTreasureRoomUpdate)
end

function ExplorationTreasureCtrl:OnTreasureRoomOpen(roomData, isFirstOpen)
  isFirstOpen = isFirstOpen or false
  if roomData == nil then
    return
  end
  self.dynPlayer = ExplorationManager:GetDynPlayer()
  self.roomData = roomData
  self.currPosition = roomData.position
  local treasureData = roomData.treasureData
  local roomCfg = self:__GetCfg(treasureData.boxId)
  if roomCfg == nil then
    error("Room cfg is nil,ID:" .. tostring(treasureData.boxId))
    return
  end
  roomData.cfg = roomCfg
  for i, refreshTime in ipairs(roomCfg.times) do
    if refreshTime >= treasureData.freshCnt or refreshTime == -1 then
      roomData.refreshCostId = roomCfg.costId
      roomData.refreshCostNum = roomCfg.costNums[i]
      break
    end
  end
  self.treasureDataDic[treasureData.boxId] = roomData
  UIManager:ShowWindowAsync(UIWindowTypeID.EpTreasureRoom, function(window)
    if window == nil then
      return
    end
    self.uiWindow = window
    self.uiWindow:InitTreasureRoom(self, roomData, isFirstOpen)
    self.epCtrl.autoCtrl:OnEnterEpTreasureRoom(roomData.treasureData, isFirstOpen)
  end)
end

function ExplorationTreasureCtrl:__RefreshRoomData(roomData)
  if self.waitRefersh and self.currPosition == roomData.position then
    self:OnTreasureRoomOpen(roomData)
    self.waitRefersh = false
  end
end

function ExplorationTreasureCtrl:GetTreasureRoomRefreshPrice()
  if self.roomData == nil then
    return 0
  end
  local originPrice = self.roomData.refreshCostNum
  if originPrice == nil then
    return 0
  end
  local result = EpStoreRoomUtil.GetFinalRefreshPriceWithOriginPrice(originPrice)
  return result
end

function ExplorationTreasureCtrl:__GetCfg(boxId)
  self.cfgTable = {
    [1] = {},
    [2] = ConfigData.treasure_logic2
  }
  local treasureCfg = ConfigData.exploration_treasure[boxId]
  return self.cfgTable[treasureCfg.logic][treasureCfg.treasure_id]
end

function ExplorationTreasureCtrl:SendItemSelect(idx, action)
  self.netWork:CS_EXPLORATION_ITEM_Select(self.currPosition, idx, function()
    if action ~= nil then
      action()
    end
    if self.uiWindow ~= nil then
      self.uiWindow:Delete()
      self.uiWindow = nil
    end
    self.lockNum = 0
    MsgCenter:Broadcast(eMsgEventId.OnExitRoomComplete, ExplorationEnum.eExitRoomCompleteType.TreasureRoom)
  end)
end

function ExplorationTreasureCtrl:SendTreasureRoomQuit()
  self.netWork:CS_EXPLORATION_ITEM_Quit(self.currPosition)
end

function ExplorationTreasureCtrl:OnTreasureRoomQuit()
  if self.uiWindow ~= nil then
    self.uiWindow:Delete()
    self.uiWindow = nil
  end
  self.lockNum = 0
  MsgCenter:Broadcast(eMsgEventId.OnExitRoomComplete, ExplorationEnum.eExitRoomCompleteType.TreasureRoom)
end

function ExplorationTreasureCtrl:SendItemLockOrUnlock(chipItem)
  if chipItem == nil then
    return
  end
  self.curlockItem = chipItem
  self.curlockState = chipItem.lockState
  if not self.curlockState and self.lockNum == MAX_TREASURE_LOCK_NUM then
    cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(TipContent.exploration_Treasure_AlertNotSelectAllReward))
    return
  end
  local idx = chipItem.idx
  self.netWork:CS_EXPLORATION_ITEM_LockUnlock(self.currPosition, idx)
end

function ExplorationTreasureCtrl:OnItemLockOrUnlock()
  if self.curlockState then
    self.lockNum = self.lockNum - 1
    self.curlockItem.lockState = false
  else
    self.lockNum = self.lockNum + 1
    self.curlockItem.lockState = true
  end
  self.curlockItem:ChangelockUi()
end

function ExplorationTreasureCtrl:SendRefreshTreasureRoom(boxId)
  local roomData = self.treasureDataDic[boxId]
  if roomData == nil then
    error("ExplorationTreasureCtrl:SendRefreshTreasureRoom error: boxId is nil" .. tostring(boxId))
    return
  end
  local maxTimes = 0
  if roomData.cfg ~= nil then
    maxTimes = roomData.cfg.maxRefreshTime
  end
  local refreshTime = 0
  if 0 <= maxTimes then
    refreshTime = maxTimes - roomData.treasureData.freshCnt
  end
  if 0 < refreshTime or maxTimes == -1 then
    if self.dynPlayer:GetMoneyCount() >= roomData.refreshCostNum or 0 >= roomData.refreshCostNum then
      self.netWork:CS_EXPLORATION_ITEM_Fresh(self.currPosition)
    else
      cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(TipContent.exploration_Treasure_MoneyInsufficient))
    end
  else
    cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(TipContent.exploration_Treasure_RefreshNumInsufficient))
  end
end

function ExplorationTreasureCtrl:OnRefreshTreasureRoom(active)
  self.waitRefersh = active
end

function ExplorationTreasureCtrl:OnDelete()
  MsgCenter:RemoveListener(eMsgEventId.OnTreasureRoomUpdate, self.__OnTreasureRoomUpdate)
  self.uiWindow = nil
end

return ExplorationTreasureCtrl
