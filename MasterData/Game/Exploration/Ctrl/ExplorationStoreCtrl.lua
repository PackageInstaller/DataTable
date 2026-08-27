local ExplorationStoreCtrl = class("ExplorationStoreCtrl", ExplorationCtrlBase)
local cs_MessageCommon = CS.MessageCommon
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")
local EpStoreRoomUtil = require("Game.Exploration.Util.EpStoreRoomUtil")

function ExplorationStoreCtrl:ctor(epCtrl)
  self.netWork = NetworkManager:GetNetwork(NetworkTypeID.StoreRoom)
  self.epCtrl = epCtrl
  self.waitRefersh = false
  self.__onStoreRoomUpdate = BindCallback(self, self.__OnStoreRoomUpdate)
  MsgCenter:AddListener(eMsgEventId.OnStoreRoomUpdate, self.__onStoreRoomUpdate)
end

function ExplorationStoreCtrl:OnStoreRoomOpen(roomData, isFirstOpen)
  if roomData == nil then
    return
  end
  self.roomData = roomData
  self.currPosition = roomData.position
  self.storeDataList = roomData.storeRoomData.data
  self.currencyId = roomData.storeRoomData.currencyId
  self.dynPlayer = ExplorationManager:GetDynPlayer()
  UIManager:ShowWindowAsync(UIWindowTypeID.EpStoreRoom, function(window)
    if window == nil then
      return
    end
    self.uiWindow = window
    self.uiWindow:InitStoreRoom(self, self.storeDataList)
    ExplorationManager.epCtrl.campFetterCtrl:OnOpenStore()
    self.epCtrl.autoCtrl:OnEnterEpStoreRoom(self.storeDataList, self.currencyId, isFirstOpen)
    if isFirstOpen and not self.epCtrl.autoCtrl:IsAutoModeRunning() then
      GuideManager:TryTriggerGuide(eGuideCondition.InEpStoreRoom)
    end
  end)
end

function ExplorationStoreCtrl:SendStoreQuit()
  self.netWork:CS_EXPLORATION_STORE_Quit(self.roomData.position)
end

function ExplorationStoreCtrl:GetEpStoreRefreshPrice()
  if self.roomData.storeRoomData.extraFetterFreeRefreshTimes > 0 then
    return 0
  else
    local refreshTimes = self.roomData:GetEpStoreRoomRefreshTimes()
    local shopRoomCfg = ConfigData.exploration_shop[self.roomData.storeRoomData.storeId]
    local refreshCostNum = shopRoomCfg.init_fresh_price + shopRoomCfg.increase_fresh_price * refreshTimes
    local result = EpStoreRoomUtil.GetFinalRefreshPriceWithOriginPrice(refreshCostNum)
    return result
  end
end

function ExplorationStoreCtrl:ReqEpStoreRefresh()
  local price = self:GetEpStoreRefreshPrice()
  local currMoney = self.dynPlayer:GetItemCount(self.currencyId)
  if 0 < price and price > currMoney then
    cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(TipContent.exploration_Treasure_MoneyInsufficient))
    return
  end
  self.waitRefersh = true
  self.netWork:CS_EXPLORATION_STORE_Refresh(self.roomData.position, function()
    AudioManager:PlayAudioById(1039)
  end)
end

function ExplorationStoreCtrl:OnStoreQuit()
  if self.uiWindow ~= nil then
    self.uiWindow:Delete()
    self.uiWindow = nil
  end
  self.curBuyIndex = nil
  MsgCenter:Broadcast(eMsgEventId.OnExitRoomComplete, ExplorationEnum.eExitRoomCompleteType.StoreRoom)
end

function ExplorationStoreCtrl:SendStorePurchase(index, price, completeAction)
  self.curBuyIndex = index
  local storeData = self.storeDataList[self.curBuyIndex]
  if storeData == nil then
    return
  end
  local money = self.dynPlayer:GetMoneyCount()
  local couldLoanMoney = self.epCtrl.campFetterCtrl:GetCouldLeonMoney()
  if price <= money + couldLoanMoney or price <= 0 then
    self.waitRefersh = true
    self.netWork:CS_EXPLORATION_STORE_Purchase(index - 1, self.roomData.position, function()
      local name
      if storeData.epBuffData ~= nil then
        name = storeData.epBuffData:GetEpBuffName()
      elseif storeData.chipData ~= nil then
        name = LanguageUtil.GetLocaleText(storeData.chipData:GetName())
        local chipId = storeData.chipData.dataId
        ExplorationManager:GetEpDataCenter():AddNewChip(chipId)
      end
      cs_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(TipContent.exploration_Stroe_BuySuccess, name))
      if completeAction ~= nil then
        completeAction()
      end
    end)
  else
    local currencyName = LanguageUtil.GetLocaleText(ConfigData.item[self.currencyId].name)
    cs_MessageCommon.ShowMessageTips(currencyName .. ConfigData:GetTipContent(TipContent.exploration_Store_BuyItemInsufficient))
  end
end

function ExplorationStoreCtrl:SendStoreSell(chipData, completeAction)
  self.netWork:CS_EXPLORATION_STORE_Sold(self.roomData.position, chipData.dataId, function()
    self.waitRefersh = true
    cs_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(TipContent.exploration_Store_SellSuc, chipData:GetName()))
    if completeAction ~= nil then
      completeAction()
    end
  end)
end

function ExplorationStoreCtrl:__OnStoreRoomUpdate(roomData)
  if self.waitRefersh and self.currPosition == roomData.position then
    self.waitRefersh = false
    self:OnStoreRoomOpen(roomData)
  end
end

function ExplorationStoreCtrl:OnDelete()
  MsgCenter:RemoveListener(eMsgEventId.OnStoreRoomUpdate, self.__onStoreRoomUpdate)
  self.uiWindow = nil
end

return ExplorationStoreCtrl
