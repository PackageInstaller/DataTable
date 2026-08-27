local DormBriefData = class("DormBriefData")
local DormEnum = require("Game.Dorm.DormEnum")

function DormBriefData:ctor()
  self.__dormHasReward = false
  self.dormComfort = 0
  self.__comfortLevel = 0
end

local function RoomBinaryLock(unlockBinary, roomId)
  local sign = 1 << roomId
  return unlockBinary & sign == 0
end

function DormBriefData.CreateDormBriefByServer(dormBrief)
  local dormBriefData = DormBriefData.New()
  dormBriefData:UpdateDormBriefByServer(dormBrief)
  dormBriefData:_InitUnlock(dormBrief)
  return dormBriefData
end

function DormBriefData:_InitUnlock(dormBrief)
  for houseId, houseUnlockCfg in pairs(ConfigData.dorm_room_unlock) do
    local unlockBinary = dormBrief.unlockedRoom[houseId]
    local OnUnlockRoomFunc = BindCallback(self, self._OnUnlockRoom, houseId)
    for roomId, unlockCfg in pairs(houseUnlockCfg) do
      if unlockBinary == nil or RoomBinaryLock(unlockBinary, roomId) then
        UnlockCenter:AddUnlockElemEvent(OnUnlockRoomFunc, unlockCfg.unlock_logic, unlockCfg.unlock_para1)
      end
    end
  end
end

function DormBriefData:_OnUnlockRoom(houseId, logicId, para1)
  local dormNetwork = NetworkManager:GetNetwork(NetworkTypeID.Dorm)
  dormNetwork:CS_DORM_BriefDetailWhenUnlock()
end

function DormBriefData:SetDmHouseInUnlock(houseId, isInUnlock)
  self._inUnlockHouseDic = self._inUnlockHouseDic or {}
  self._inUnlockHouseDic[houseId] = isInUnlock
end

function DormBriefData:CheckDmHouseUnlock()
  local isSystemOpen = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Dorm)
  if not isSystemOpen then
    return
  end
  for k, houseId in ipairs(ConfigData.dorm_house.id_sort_list) do
    if self.unlockedRoom[houseId] == nil and (not self._inUnlockHouseDic or not self._inUnlockHouseDic[houseId]) then
      local houseCfg = ConfigData.dorm_house[houseId]
      if houseCfg.unlock_logic == DormEnum.eDmHouseUnlockLogic.CostItem and (houseCfg.unlock_house_before == 0 or self.unlockedRoom[houseCfg.unlock_house_before]) then
        local ownNum = PlayerDataCenter:GetItemCount(houseCfg.unlock_item_id)
        if ownNum >= houseCfg.unlock_item_num then
          local dormNetwork = NetworkManager:GetNetwork(NetworkTypeID.Dorm)
          dormNetwork:CS_DORM_DormPurchase(houseId)
          return
        end
      end
    end
  end
end

function DormBriefData:CheckDmItemChange(itemDic)
  local hasChange = false
  for itemId, v in pairs(ConfigData.dorm_house.dmHouseUnlockItemIdDic) do
    if itemDic[itemId] ~= nil then
      hasChange = true
      break
    end
  end
  if not hasChange then
    return
  end
  self:CheckDmHouseUnlock()
end

function DormBriefData:UpdateDormBriefByServer(dormBrief)
  self.rewardsRecord = dormBrief.RewardsRecord
  self.unlockedRoom = dormBrief.unlockedRoom
  self.furnitureTotal = dormBrief.furnitureTotal
  self._hasThemeFnt = false
  for itemId, num in pairs(self.furnitureTotal) do
    local fntCfg = ConfigData.dorm_furniture[itemId]
    if fntCfg and fntCfg.is_theme then
      self._hasThemeFnt = true
      break
    end
  end
  if not self:UpdateHistoryMaxComfort(dormBrief.comfort) then
    self:__CalcDormLevelAndReward()
  end
  self:RefreshNewDormHouseReddot()
end

function DormBriefData:UpdateDormBriefFurnitureTotal(updateDic)
  if updateDic then
    if not self.furnitureTotal then
      self.furnitureTotal = {}
    end
    for k, v in pairs(updateDic) do
      if not self.furnitureTotal[k] then
        self.furnitureTotal[k] = v
      else
        self.furnitureTotal[k] = self.furnitureTotal[k] + v
        if self.furnitureTotal[k] == 0 then
          self.furnitureTotal[k] = nil
        end
      end
      if not self._hasThemeFnt then
        local fntCfg = ConfigData.dorm_furniture[k]
        if fntCfg and fntCfg.is_theme then
          self._hasThemeFnt = true
        end
      end
    end
  end
end

function DormBriefData:RefreshNewDormHouseReddot()
  local unlockDorm = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Dorm)
  if not unlockDorm then
    return
  end
  local ok, newHouseNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.Dorm, RedDotStaticTypeId.DormNewHouse)
  if not ok then
    return
  end
  local saveUserData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  local count = 0
  for k, houseId in ipairs(ConfigData.dorm_house.id_sort_list) do
    if houseId ~= 1 and self.unlockedRoom[houseId] and 0 < self.unlockedRoom[houseId] then
      local readedNew = saveUserData:GetNewDormHouseReaded(houseId)
      if not readedNew then
        count = count + 1
      end
    end
  end
  newHouseNode:SetRedDotCount(count)
end

function DormBriefData:GetDormHouseIsNew(houseId)
  if houseId == 1 then
    return false
  end
  local saveUserData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  if self.unlockedRoom[houseId] and self.unlockedRoom[houseId] > 0 then
    local readedNew = saveUserData:GetNewDormHouseReaded(houseId)
    return not readedNew
  end
  return false
end

function DormBriefData:SetDormHouseNewReaded(houseId)
  if houseId == 1 then
    return
  end
  local saveUserData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  local changed = saveUserData:SetNewDormHouseReaded(houseId, true)
  if changed then
    local ok, newHouseNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.Dorm, RedDotStaticTypeId.DormNewHouse)
    newHouseNode:OffsetRedDotCount(-1)
  end
end

function DormBriefData:SetDmHouseUnlockableReaded(houseId)
  local saveUserData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  saveUserData:SetUnlockableDormHouseReaded(houseId, true)
end

function DormBriefData:IsDormComfortPicked(level)
  local sign = 1 << level - 1
  return self.rewardsRecord & sign > 0
end

function DormBriefData:RecordComfortPicked(level)
  local sign = 1 << level - 1
  self.rewardsRecord = self.rewardsRecord | sign
  self:__CalcDormLevelAndReward()
end

function DormBriefData:HistoryMaxComfort()
  return self.dormComfort
end

function DormBriefData:UpdateHistoryMaxComfort(comfort)
  if comfort <= self.dormComfort then
    return false
  end
  self.dormComfort = comfort
  self:__CalcDormLevelAndReward()
  MsgCenter:Broadcast(eMsgEventId.DormMaxComfortChanged, self.dormComfort, self.__comfortLevel)
  return true
end

function DormBriefData:IsDormHasReward()
  return self.__dormHasReward
end

function DormBriefData:GetDormComfortLevel()
  return self.__comfortLevel, ConfigData.dorm_comfort.max_level
end

function DormBriefData:GetDormComfortLevelCfg()
  return ConfigData.dorm_comfort[self.__comfortLevel]
end

function DormBriefData:__CalcDormLevelAndReward()
  local dormHasReward = false
  local templevel = 1
  for _, level in ipairs(ConfigData.dorm_comfort.level_sort) do
    local comfortCfg = ConfigData.dorm_comfort[level]
    if comfortCfg == nil then
      error("dorm comfort cfg is null,id:" .. tostring(level))
      return nil
    end
    if self.dormComfort >= comfortCfg.comfort then
      templevel = level
      if not dormHasReward and #comfortCfg.rewardIds > 0 and not self:IsDormComfortPicked(level) then
        dormHasReward = true
      end
    else
      break
    end
  end
  if self.__comfortLevel ~= templevel then
    if 0 < self.__comfortLevel then
      local levelCfg = ConfigData.dorm_comfort[self.__comfortLevel]
      for k, logic in ipairs(levelCfg.logic) do
        local para1 = levelCfg.para1[k]
        local para2 = levelCfg.para2[k]
        local para3 = levelCfg.para3[k]
        PlayerDataCenter.playerBonus:UninstallPlayerBonus(proto_csmsg_SystemFunctionID.SystemFunctionID_Dorm, 0, logic, para1, para2, para3)
      end
    end
    self.__comfortLevel = templevel
    local levelCfg = ConfigData.dorm_comfort[self.__comfortLevel]
    for k, logic in ipairs(levelCfg.logic) do
      local para1 = levelCfg.para1[k]
      local para2 = levelCfg.para2[k]
      local para3 = levelCfg.para3[k]
      PlayerDataCenter.playerBonus:InstallPlayerBonus(proto_csmsg_SystemFunctionID.SystemFunctionID_Dorm, 0, logic, para1, para2, para3)
    end
  end
  self:__UpdateDormHasReward(dormHasReward)
end

function DormBriefData:__UpdateDormHasReward(hasReward)
  if self.__dormHasReward == hasReward then
    return
  end
  self.__dormHasReward = hasReward
  local ok, comfortNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.Dorm, RedDotStaticTypeId.DormComfort)
  if hasReward then
    comfortNode:SetRedDotCount(1)
  else
    comfortNode:SetRedDotCount(0)
  end
end

function DormBriefData:GetFurnitureItemCountInDorm(itemId)
  local count = self.furnitureTotal[itemId]
  if count then
    return count
  end
  return 0
end

function DormBriefData:ExistDormFntItem(fntItemId)
  if self:GetFurnitureItemCountInDorm(fntItemId) > 0 then
    return true
  end
  return PlayerDataCenter.itemDic[fntItemId] ~= nil
end

function DormBriefData:IsHasAnyDmtThemeFntInstalled()
  return self._hasThemeFnt
end

return DormBriefData
