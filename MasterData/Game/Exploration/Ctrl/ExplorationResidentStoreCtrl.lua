local ExplorationResidentStoreCtrl = class("ExplorationResidentStoreCtrl", ExplorationCtrlBase)
local ChipData = require("Game.PlayerData.Item.ChipData")
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")
local EpStoreRoomUtil = require("Game.Exploration.Util.EpStoreRoomUtil")
local cs_MessageCommon = CS.MessageCommon

function ExplorationResidentStoreCtrl:ctor(epCtrl)
  self.netWork = NetworkManager:GetNetwork(NetworkTypeID.Exploration)
  self.__onMoneyChange = BindCallback(self, self.UpdateMoney)
  MsgCenter:AddListener(eMsgEventId.EpMoneyChange, self.__onMoneyChange)
  self.__OnExitRoomComplete = BindCallback(self, self.__OnRoomExitComplete)
  MsgCenter:AddListener(eMsgEventId.OnExitRoomComplete, self.__OnExitRoomComplete)
  self._OnStorePurchaseFunc = BindCallback(self, self._OnStorePurchase)
  self._OnStoreLockFunc = BindCallback(self, self._OnStoreLockComplete)
end

function ExplorationResidentStoreCtrl:UpdateResidentStore(epResident)
  self.storeDataList = {}
  if self.storeLevel ~= nil and self.storeLevel < epResident.lv then
    self._hasLevelUp = true
    self._oldLv = self.storeLevel
  end
  if self.storeExp ~= nil and self.storeExp ~= epResident.exp then
    self._lastAddExp = math.max(epResident.exp - self.storeExp, 0)
  end
  self.storeLevel = epResident.lv
  self.storeExp = epResident.exp
  self.formBattle = epResident.fromBattle
  if self.formBattle then
    self._isRefresh = true
  end
  for idx, elem in ipairs(epResident.data) do
    local chipData = ChipData.NewChipForServer(elem.id)
    local storeElem = {
      idx = idx - 1,
      id = chipData.dataId,
      sold = elem.saled,
      locked = elem.locked,
      chipData = chipData
    }
    table.insert(self.storeDataList, storeElem)
  end
  local window = UIManager:GetWindow(UIWindowTypeID.EpResidentStore)
  if window ~= nil then
    window:UpdEpResidentStore(self.storeDataList, self.storeLevel, self.storeExp, self._isRefresh)
    self._isRefresh = false
  end
  self._hasEpResidentStore = true
  self.dynPlayer = ExplorationManager:GetDynPlayer()
end

function ExplorationResidentStoreCtrl:HasEpResidentStore()
  return self._hasEpResidentStore
end

function ExplorationResidentStoreCtrl:GetResidentStoreLastAddExp()
  return self._lastAddExp or 0
end

function ExplorationResidentStoreCtrl:OnResidentStoreRoomOpen(closeCallback)
  UIManager:ShowWindowAsync(UIWindowTypeID.EpResidentStore, function(window)
    if window == nil then
      return
    end
    window:InitEpResidentStore(self)
    window:UpdEpResidentStore(self.storeDataList, self.storeLevel, self.storeExp, self._isRefresh, true)
    self._isRefresh = false
    if closeCallback ~= nil then
      window:SetEpResidentStoreCloseFunc(closeCallback)
    end
  end)
end

function ExplorationResidentStoreCtrl:UpdateMoney()
  local window = UIManager:GetWindow(UIWindowTypeID.EpResidentStore)
  if window ~= nil then
    window:UpdEpResidentStore(self.storeDataList, self.storeLevel, self.storeExp, self._isRefresh, true)
  end
end

function ExplorationResidentStoreCtrl:__OnRoomExitComplete(roomType)
  self:_TryShowLevelUp()
end

function ExplorationResidentStoreCtrl:_TryShowLevelUp()
  if not self._hasLevelUp then
    return
  end
  self._hasLevelUp = false
  local cellingAdd = 0
  for lv = self._oldLv + 1, self.storeLevel do
    local shopCfg = self:GetResidentStoreCfg()[self.storeLevel]
    if shopCfg == nil then
      error("Cant get GetResidentStoreCfg, level = " .. tostring(lv))
    else
      cellingAdd = cellingAdd + shopCfg.function_limit_bonus
    end
  end
  cs_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(6007), true)
  cs_MessageCommon.ShowMessageTips(string.format(ConfigData:GetTipContent(6008), cellingAdd), true)
  cs_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(6009), true)
end

function ExplorationResidentStoreCtrl:CheckEpResidentStore(closeCallback)
  local showStore = false
  local curRoomData = self.epCtrl:GetCurrentRoomData()
  if curRoomData:GetIsInBigBossRoom() then
    if self.dynPlayer ~= nil then
      self.dynPlayer:HasEpMonsterLvUp(true)
    end
    return showStore
  end
  local isFirstRoom = curRoomData:IsStartRoom() and ExplorationManager:GetCurLevelIndex() == 0
  if self:HasEpResidentStore() and (self.formBattle or self.dynPlayer:GetOperatorDetailState() == proto_object_ExplorationCurGridState.ExplorationCurGridState_MonsterLvUpgrade or isFirstRoom) then
    local function autoOpenStoreFunc()
      if isFirstRoom or self._isRefresh then
        self:OnResidentStoreRoomOpen(closeCallback)
      else
        closeCallback()
      end
    end
    
    local function tryOpenSelectDebuffSelect()
      if self.dynPlayer:HasDebuffSelect() then
        UIManager:ShowWindowAsync(UIWindowTypeID.EpSelectDebuff, function(win)
          if win == nil then
            return
          end
          win:InitEpSelectDebuff(self.dynPlayer, autoOpenStoreFunc)
        end)
      else
        autoOpenStoreFunc()
      end
    end
    
    local hasMonsterLvUp, oldLevel, newLevel = self.dynPlayer:HasEpMonsterLvUp(true)
    if hasMonsterLvUp then
      UIManager:ShowWindowAsync(UIWindowTypeID.EpMonsterLevelUp, function(window)
        if window == nil then
          return
        end
        window:InitEpMonsterLevelUp(oldLevel, newLevel, tryOpenSelectDebuffSelect)
      end)
    else
      autoOpenStoreFunc()
    end
    showStore = true
  end
  self.formBattle = false
  return showStore
end

function ExplorationResidentStoreCtrl:ReqResidentStorePurchase(index, callBack)
  local elemData = self.storeDataList[index]
  local chipData = elemData.chipData
  local chipCount = self.dynPlayer:GetChipCount(chipData.dataId)
  if chipCount == 0 and self.dynPlayer:IsChipFull() then
    cs_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(6006))
    return
  end
  local elemData = self.storeDataList[index]
  local chipData = elemData.chipData
  self._purchaseCallback = callBack
  local cucurrency = ExplorationManager:GetDynPlayer():GetMoneyCount()
  if cucurrency >= chipData:GetChipBuyPrice(ExplorationManager:GetEpModuleTypeCfgId()) then
    self._purchaseChipData = chipData
    self.netWork:CS_EXPLORATION_RESIDENT_STORE_Purchase(elemData.idx, self._OnStorePurchaseFunc)
  else
    local currencyName = LanguageUtil.GetLocaleText(ConfigData.item[ConstGlobalItem.EpMoney].name)
    cs_MessageCommon.ShowMessageTips(currencyName .. ConfigData:GetTipContent(TipContent.exploration_Store_BuyItemInsufficient))
  end
end

function ExplorationResidentStoreCtrl:_OnStorePurchase()
  local chipData = self._purchaseChipData
  cs_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(TipContent.exploration_Stroe_BuySuccess, chipData:GetName()))
  ExplorationManager:GetEpDataCenter():AddNewChip(chipData.dataId)
  if self._purchaseCallback ~= nil then
    self._purchaseCallback()
  end
end

function ExplorationResidentStoreCtrl:ReqEpResidentStoreRefresh()
  local allLock = true
  for k, elem in ipairs(self.storeDataList) do
    if not elem.locked then
      allLock = false
      break
    end
  end
  if allLock then
    cs_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(6005))
    return
  end
  self.netWork:CS_EXPLORATION_RESIDENT_STORE_Refresh()
  self._isRefresh = true
end

function ExplorationResidentStoreCtrl:ReqEpResidentStoreLock(index, callBack)
  local elemData = self.storeDataList[index]
  self._lockElemData = elemData
  self._lockCallback = callBack
  self.netWork:CS_EXPLORATION_RESIDENT_STORE_LockUnlock(elemData.idx, self._OnStoreLockFunc)
end

function ExplorationResidentStoreCtrl:_OnStoreLockComplete()
  self._lockElemData.locked = not self._lockElemData.locked
  if self._lockCallback ~= nil then
    self._lockCallback(self._lockElemData.locked)
  end
end

function ExplorationResidentStoreCtrl:ReqEpResidentStoreLvUp(callBack)
  if self.storeLevel >= self:GetResidentStoreCfg().maxLevel then
    return
  end
  local nextLvCfg = self:GetResidentStoreCfg()[self.storeLevel + 1]
  if nextLvCfg == nil then
    error("Cant get GetResidentStoreCfg, level = " .. tostring(self.storeLevel + 1))
    return
  end
  local needMoney = (nextLvCfg.exp - self.storeExp) * ConfigData.game_config.epResidentStoreBuyExpCost
  if needMoney > self.dynPlayer:GetMoneyCount() then
    cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(35))
    return
  end
  self._ReqLvUpCallback = callBack
  self._OnStoreLvUpFunc = self._OnStoreLvUpFunc or BindCallback(self, self._OnStoreLvUp)
  self.netWork:CS_EXPLORATION_RESIDENT_STORE_PurchaseExp(self._OnStoreLvUpFunc)
end

function ExplorationResidentStoreCtrl:_OnStoreLvUp()
  self:_TryShowLevelUp()
  if self._ReqLvUpCallback ~= nil then
    self._ReqLvUpCallback()
  end
end

function ExplorationResidentStoreCtrl:GetResidentStoreCfg()
  local stageCfg = ExplorationManager:GetSectorStageCfg()
  local inTD = ExplorationManager:IsInTDExp()
  if inTD then
    local moudleId = ExplorationManager:GetEpModuleId()
    local towerDataShopCfg = ConfigData.tower_data_shop[moudleId]
    if towerDataShopCfg ~= nil then
      return towerDataShopCfg
    else
      error(" tower_data_shop miss id" .. tostring(moudleId))
    end
  end
  return ConfigData.weekly_challenge_shop
end

function ExplorationResidentStoreCtrl:GetResidentStoreRefreshPrice()
  local originPrice = ConfigData.game_config.epResidentStoreRefreshCost
  if originPrice == nil then
    return 0
  end
  local result = EpStoreRoomUtil.GetFinalRefreshPriceWithOriginPrice(originPrice)
  return result
end

function ExplorationResidentStoreCtrl:OnDelete()
  MsgCenter:RemoveListener(eMsgEventId.EpMoneyChange, self.__onMoneyChange)
  MsgCenter:RemoveListener(eMsgEventId.OnExitRoomComplete, self.__OnExitRoomComplete)
end

return ExplorationResidentStoreCtrl
