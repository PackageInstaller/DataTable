local PlayerDormData = class("PlayerDormData")
local LocalData = require("GameCore.Data.LocalData")

function PlayerDormData:Init()
  self.nMaxInteractionCount = ConfigTable.GetConfigNumber("DormRoleInteractionMaxNum")
  self.nMaxGiftSendCount = ConfigTable.GetConfigNumber("DormRoleAffinityGiftMaxNum")
  self.nMaxRoleGiftSendCount = ConfigTable.GetConfigNumber("DormRoleAffinityGiftDailyNum")
  self.mapDormRoomInfo = {}
  self.mapFurnitureBag = {}
  self.mapPresetData = {}
  self.mapFurnitureUsedCount = {}
  self.mapDromBaseInfo = {}
  self.tbReceivedLayoutReward = {}
  self.CachedFriendData = {}
  self.tbInteractionRoleIds = {}
  self.mapFriendDetail = {}
  self.mapAffinityGiftRoleCount = {}
  self.bHasRoomData = false
  self.bHasBagData = false
  self.nPresetCount = 0
  self.tbAchievementIds = {}
  self.mapAchievementCompleteTime = {}
  self.cachedCollection = 0
  self.nLastSaveTime = 0
  self.nLastLikeInfoTime = 0
  self.nEnterRoomSceneId = nil
  self.bEnterIsGuide = false
  printLog("dorm init")
  EventManager.Add(EventId.IsNewDay, self, self.OnEvent_NewDay)
  self.nHonorMaxLevel = 0
  
  local function foreachHonorLevel(mapData)
    if mapData.Id > self.nHonorMaxLevel then
      self.nHonorMaxLevel = mapData.Id
    end
  end
  
  ForEachTableLine(ConfigTable.Get("DormHonorTitle"), foreachHonorLevel)
end

function PlayerDormData:UnInit()
  EventManager.Remove(EventId.IsNewDay, self, self.OnEvent_NewDay)
end

function PlayerDormData:OnEvent_NewDay()
  self.bHasRoomData = false
  self.bHasBagData = false
  self.CachedFriendData = {}
  self.tbInteractionRoleIds = {}
  RedDotManager.SetValid(RedDotDefine.DormServer, nil, true)
end

function PlayerDormData:SetEnterDormParam(nRoomSceneId, bIsGuide)
  self.nEnterRoomSceneId = nRoomSceneId
  self.bEnterIsGuide = bIsGuide == true
end

function PlayerDormData:EnterDorm()
  local function GetRoomInfoCallback(mapDormRoomInfo, mapDormBaseInfo)
    if next(mapDormRoomInfo) == nil then
      return
    end
    
    local function TransitionCallback()
      EventManager.Hit(EventId.OpenPanel, PanelId.DormPanel)
    end
    
    local nStyle = 6
    EventManager.Hit(EventId.SetTransition, nStyle, TransitionCallback, AllEnum.MainViewCorner.Dorm)
    printLog("dorm enter")
  end
  
  local function GetBagInfoCallback()
    self:GetRoomInfo(GetRoomInfoCallback)
  end
  
  self:GetBagInfo(GetBagInfoCallback)
end

function PlayerDormData:GetGuideState()
  local ret = self.bEnterIsGuide == true
  self.bEnterIsGuide = false
  return ret
end

function PlayerDormData:GetRoomInfo(callback)
  print("GetRoomInfo")
  if self.bHasRoomData == true then
    if callback ~= nil and type(callback) == "function" then
      callback(clone(self.mapDormRoomInfo), clone(self.mapDromBaseInfo))
    end
  else
    local function NetCallback(_, mapNetMsg)
      self.tbReceivedLayoutReward = mapNetMsg.ReceivedRewardIds
      
      self.tbInteractionRoleIds = mapNetMsg.InteractionRoleIds
      self.mapAffinityGiftRoleCount = {}
      for _, value in ipairs(mapNetMsg.AffinityGiftRoleInfos) do
        self.mapAffinityGiftRoleCount[value.RoleId] = value.SendGiftCnt
      end
      for _, mapInfo in ipairs(mapNetMsg.DormList) do
        if mapInfo.FurnitureList == nil or #mapInfo.FurnitureList == 0 then
          local mapRoomConfig = ConfigTable.GetData("DormRoom", mapInfo.DormRoomId)
          if mapRoomConfig ~= nil then
            local nDefaultId = mapRoomConfig.DefaultLayoutId
            if nDefaultId ~= 0 then
              mapInfo.FurnitureList = self:SetDefaultFurnitureList(nDefaultId)
            end
          end
        end
        self.mapDormRoomInfo[mapInfo.DormRoomId] = mapInfo
      end
      self.bHasRoomData = true
      self.mapDromBaseInfo = mapNetMsg.DormInfo
      if self.mapDromBaseInfo.DormName == "@" then
        self.mapDromBaseInfo.DormName = ""
      end
      self.tbAchievementIds = {}
      self.mapAchievementCompleteTime = {}
      for _, achievementInfo in ipairs(self.mapDromBaseInfo.AchievementList) do
        if table.indexof(self.tbAchievementIds, achievementInfo.AchievementId) < 1 then
          table.insert(self.tbAchievementIds, achievementInfo.AchievementId)
          self.mapAchievementCompleteTime[achievementInfo.AchievementId] = achievementInfo.CompleteTime
        end
      end
      if callback ~= nil and type(callback) == "function" then
        callback(clone(self.mapDormRoomInfo))
      end
      if self.bHasBagData then
        self:UpdateAllUsedCount()
      end
      self.nLastLikeInfoTime = CS.ClientManager.Instance.serverTimeStamp
      self:RefreshRedDotReward()
      self:RefreshRedDotAchievement()
      self:RefreshRedDotQuest()
      self:RefreshRedDotFurnitureReward()
      RedDotManager.SetValid(RedDotDefine.DormServer, nil, false)
    end
    
    HttpNetHandler.SendMsg(NetMsgId.Id.dorm_info_list_req, {}, nil, NetCallback)
  end
end

function PlayerDormData:GetBagInfo(callback)
  if self.bHasBagData == true then
    if callback ~= nil and type(callback) == "function" then
      callback(clone(self.mapFurnitureBag))
    end
  else
    local function NetCallback(_, mapNetMsg)
      for _, mapInfo in ipairs(mapNetMsg.DormBagList) do
        self.mapFurnitureBag[mapInfo.ItemTplInfo.Tid] = mapInfo.ItemTplInfo.Qty
      end
      self.bHasBagData = true
      if self.bHasRoomData then
        self:UpdateAllUsedCount()
      end
      if callback ~= nil and type(callback) == "function" then
        callback(clone(self.mapFurnitureBag))
      end
    end
    
    HttpNetHandler.SendMsg(NetMsgId.Id.dorm_bag_list_req, {}, nil, NetCallback)
  end
end

function PlayerDormData:CacheFurnitureChange(tbData)
  if type(tbData) ~= "table" then
    return
  end
  local nLevelBefore = self:GetHonorTitleLevel()
  for _, mapItem in ipairs(tbData) do
    if mapItem.IsFirst then
      local mapFurnitureConfig = ConfigTable.GetData("DormFurniture", mapItem.Tid)
      if mapFurnitureConfig ~= nil then
        self.cachedCollection = self.cachedCollection + mapFurnitureConfig.CollectionValue
      end
    end
    if self.bHasBagData then
      if self.mapFurnitureBag[mapItem.Tid] == nil then
        self.mapFurnitureBag[mapItem.Tid] = 0
      end
      self.mapFurnitureBag[mapItem.Tid] = self.mapFurnitureBag[mapItem.Tid] + mapItem.Qty
    end
  end
  local nLevelAfter = self:GetHonorTitleLevel()
  if nLevelBefore < nLevelAfter then
    self:UploadDormEvent("1", nil, nil, nLevelBefore, nLevelAfter)
  end
  self:RefreshRedDotAchievement()
  self:RefreshRedDotFurnitureReward()
  EventManager.Hit("DormFurnitureChanged")
end

function PlayerDormData:UploadDormEvent(sAction, nRoomId, nLayoutId, nLevelBefore, nLevelAfter)
  local tab = {}
  table.insert(tab, {
    "role_id",
    tostring(PlayerData.Base._nPlayerId)
  })
  table.insert(tab, {
    "action",
    tostring(sAction)
  })
  if tostring(sAction) == "2" then
    table.insert(tab, {
      "room_type",
      tostring(nRoomId or 0)
    })
    table.insert(tab, {
      "room_layout",
      tostring(nLayoutId or 0)
    })
  else
    table.insert(tab, {
      "dorm_level_before",
      tostring(nLevelBefore or 0)
    })
    table.insert(tab, {
      "dorm_level_after",
      tostring(nLevelAfter or 0)
    })
  end
  NovaAPI.UserEventUpload("Dorm", tab)
end

function PlayerDormData:GetPresetInfo(callback)
  if self.bHasPresetData == true then
    if callback ~= nil and type(callback) == "function" then
      callback(clone(self.mapPresetData), self.nPresetCount)
    end
  else
    local function NetCallback(_, mapNetMsg)
      self.nPresetCount = mapNetMsg.Num
      
      for _, mapInfo in pairs(mapNetMsg.PresetList) do
        self.mapPresetData[mapInfo.BuildId] = mapInfo
      end
      self.bHasPresetData = true
      if callback ~= nil and type(callback) == "function" then
        callback(clone(self.mapPresetData), self.nPresetCount)
      end
    end
    
    HttpNetHandler.SendMsg(NetMsgId.Id.dorm_furniture_preset_list_req, {}, nil, NetCallback)
  end
end

function PlayerDormData:GetRoleInfo(nRoomId)
  if self.mapDormRoomInfo[nRoomId] == nil then
    return {}
  end
  local ret = clone(self.mapDormRoomInfo[nRoomId].RoleList)
  return ret
end

function PlayerDormData:GetPlayerBaseInfo()
  if not self.bHasRoomData == true then
    return nil
  end
  return self.mapDromBaseInfo
end

function PlayerDormData:SetRoleVisitState(nRoomId)
  local mapRoomData = self.mapDormRoomInfo[nRoomId]
  if mapRoomData ~= nil then
    for index, value in ipairs(mapRoomData.RoleList) do
      if value.IsVisit == true then
        value.IsVisit = false
      end
    end
  end
end

function PlayerDormData:SaveDormFurniture(nRoomId, mapData, BuildId, callback)
  local mapDormCfg = ConfigTable.GetData("DormRoom", nRoomId)
  if mapDormCfg == nil then
    return
  end
  local nCurTime = CS.ClientManager.Instance.serverTimeStamp
  if nCurTime - self.nLastSaveTime < 5 then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Dorm_FurnitreSaveCDHint"))
    return
  end
  
  local function NetCallback(_, NetMsg)
    if BuildId == 0 then
      if self.mapDormRoomInfo[nRoomId] == nil then
        self.mapDormRoomInfo[nRoomId] = {
          DormRoomId = nRoomId,
          RoleList = {},
          RoomName = ""
        }
      end
      self.mapDormRoomInfo[nRoomId].FurnitureList = mapData
      if self.bHasBagData then
        self:UpdateAllUsedCount()
      end
    else
      if self.mapPresetData[BuildId] == nil then
        self.mapPresetData[BuildId] = {
          DormType = mapDormCfg.RoomType,
          BuildId = BuildId,
          CreateTime = NetMsg.Value,
          BuildName = ""
        }
      else
        self.mapPresetData[BuildId].DormType = mapDormCfg.RoomType
        self.mapPresetData[BuildId].CreateTime = NetMsg.Value
      end
      self.mapPresetData[BuildId].FurnitureList = mapData
    end
    if callback ~= nil and type(callback) == "function" then
      callback(NetMsg.Value)
    end
  end
  
  local msgData = {
    DormRoomId = nRoomId,
    FurniturePosInfoList = mapData,
    BuildId = BuildId
  }
  self.nLastSaveTime = nCurTime
  HttpNetHandler.SendMsg(NetMsgId.Id.dorm_furniture_save_req, msgData, nil, NetCallback)
end

function PlayerDormData:GetUsedCount()
  return clone(self.mapFurnitureUsedCount)
end

function PlayerDormData:UpdateAllUsedCount()
  self.mapFurnitureUsedCount = {}
  for _, mapRoomInfo in pairs(self.mapDormRoomInfo) do
    for _, mapFurniture in ipairs(mapRoomInfo.FurnitureList) do
      if self.mapFurnitureUsedCount[mapRoomInfo.DormRoomId] == nil then
        self.mapFurnitureUsedCount[mapRoomInfo.DormRoomId] = {}
      end
      if self.mapFurnitureUsedCount[mapRoomInfo.DormRoomId][mapFurniture.FurnitureId] == nil then
        self.mapFurnitureUsedCount[mapRoomInfo.DormRoomId][mapFurniture.FurnitureId] = 0
      end
      self.mapFurnitureUsedCount[mapRoomInfo.DormRoomId][mapFurniture.FurnitureId] = self.mapFurnitureUsedCount[mapRoomInfo.DormRoomId][mapFurniture.FurnitureId] + 1
    end
  end
end

function PlayerDormData:SetDefaultFurnitureList(nDefaultId)
  local ret = {}
  local mapLayoutCfgData = ConfigTable.GetData("DormLayoutReward", nDefaultId)
  if mapLayoutCfgData ~= nil then
    local nLayoutFurnitrueCount = mapLayoutCfgData.FurnitureCount
    for i = 1, nLayoutFurnitrueCount do
      local nLayoutId = nDefaultId * 100 + i
      local mapLayoutData = ConfigTable.GetData("DormRoomLayout", nLayoutId)
      if mapLayoutData ~= nil then
        table.insert(ret, {
          FurnitureId = mapLayoutData.FurnitureId,
          X = mapLayoutData.Pos[1],
          Y = mapLayoutData.Pos[2],
          Z = mapLayoutData.Pos[3],
          Rotation = mapLayoutData.Rot
        })
      end
    end
  end
  return ret
end

function PlayerDormData:CheckCanRenameDorm()
  local nRenameCD = ConfigTable.GetConfigNumber("DormNameResetTimeLimit")
  local nCurTime = CS.ClientManager.Instance.serverTimeStamp
  local nLastTime = self.mapDromBaseInfo.RestNameTime or 0
  if nCurTime < nLastTime + nRenameCD then
    local nPastTime = nLastTime + nRenameCD - nCurTime
    local day = math.ceil(nPastTime / 86400)
    if 1 < day then
      EventManager.Hit(EventId.OpenMessageBox, orderedFormat(ConfigTable.GetUIText("Dorm_Rename_TimeCDWarning1"), day))
    else
      EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Dorm_Rename_TimeCDWarning2"))
    end
    return false
  end
  return true
end

function PlayerDormData:CheckCanRenameRoom(nRoomId)
  if self.mapDormRoomInfo[nRoomId] == nil then
    return false
  end
  local nRenameCD = ConfigTable.GetConfigNumber("DormNameResetTimeLimit")
  local nCurTime = CS.ClientManager.Instance.serverTimeStamp
  local nLastTime = self.mapDormRoomInfo[nRoomId].RestNameTime or 0
  if nCurTime < nLastTime + nRenameCD then
    local nPastTime = nLastTime + nRenameCD - nCurTime
    local day = math.ceil(nPastTime / 86400)
    if 1 < day then
      EventManager.Hit(EventId.OpenMessageBox, orderedFormat(ConfigTable.GetUIText("Dorm_Rename_TimeCDWarning3"), day))
    else
      EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Dorm_Rename_TimeCDWarning4"))
    end
    return false
  end
  return true
end

function PlayerDormData:RenameDorm(nRoomId, sName, callback)
  if not self.bHasRoomData then
    return
  end
  local nRenameCD = ConfigTable.GetConfigNumber("DormNameResetTimeLimit")
  local nCurTime = CS.ClientManager.Instance.serverTimeStamp
  if nRoomId == 0 then
    local nLastTime = self.mapDromBaseInfo.RestNameTime or 0
    if nCurTime < nLastTime + nRenameCD then
      local nPastTime = nLastTime + nRenameCD - nCurTime
      local day = math.ceil(nPastTime / 86400)
      if 1 < day then
        EventManager.Hit(EventId.OpenMessageBox, {
          nType = AllEnum.MessageBox.Alert,
          sContent = orderedFormat(ConfigTable.GetUIText("Dorm_Rename_TimeCDWarning1"), day)
        })
      else
        EventManager.Hit(EventId.OpenMessageBox, {
          nType = AllEnum.MessageBox.Alert,
          sContent = ConfigTable.GetUIText("Dorm_Rename_TimeCDWarning2")
        })
      end
      return
    end
  else
    if self.mapDormRoomInfo[nRoomId] == nil then
      return
    end
    local nLastTime = self.mapDormRoomInfo[nRoomId].RestNameTime or 0
    if nCurTime < nLastTime + nRenameCD then
      local nPastTime = nLastTime + nRenameCD - nCurTime
      local day = math.ceil(nPastTime / 86400)
      if 1 < day then
        EventManager.Hit(EventId.OpenMessageBox, {
          nType = AllEnum.MessageBox.Alert,
          sContent = orderedFormat(ConfigTable.GetUIText("Dorm_Rename_TimeCDWarning3"), day)
        })
      else
        EventManager.Hit(EventId.OpenMessageBox, {
          nType = AllEnum.MessageBox.Alert,
          sContent = ConfigTable.GetUIText("Dorm_Rename_TimeCDWarning4")
        })
      end
      return
    end
  end
  
  local function NetCallback()
    if nRoomId ~= 0 then
      if self.mapDormRoomInfo[nRoomId] ~= nil then
        self.mapDormRoomInfo[nRoomId].RoomName = sName
        self.mapDormRoomInfo[nRoomId].RestNameTime = CS.ClientManager.Instance.serverTimeStamp
      end
    else
      self.mapDromBaseInfo.DormName = sName
      self.mapDromBaseInfo.RestNameTime = CS.ClientManager.Instance.serverTimeStamp
    end
    EventManager.Hit("DormNameUpdate", nRoomId, sName)
    if type(callback) == "function" and callback ~= nil then
      callback()
    end
  end
  
  local msg = {Value = sName, Version = nRoomId}
  HttpNetHandler.SendMsg(NetMsgId.Id.dorm_info_update_name_req, msg, nil, NetCallback)
end

function PlayerDormData:UpdateInvitationRole(nRoomId, tbRoleId, callback)
  local function NetCallback()
    local mapRoomInfo = self.mapDormRoomInfo[nRoomId]
    
    local tmpRet = {}
    if mapRoomInfo ~= nil then
      for _, mapRoleInfo in ipairs(mapRoomInfo.RoleList) do
        local mapRoleCfgData = ConfigTable.GetData("DormRole", mapRoleInfo.RoleId)
        local bNpc = true
        if mapRoleCfgData ~= nil then
          bNpc = mapRoleCfgData.RoleType == GameEnum.DormRoleType.NPC
        end
        if mapRoleInfo.IsInvitationRole and bNpc then
          table.insert(tmpRet, mapRoleInfo)
        end
      end
      for _, nRoleId in ipairs(tbRoleId) do
        table.insert(tmpRet, {
          RoleId = nRoleId,
          IsVisit = true,
          IsInvitationRole = false
        })
      end
    end
    mapRoomInfo.RoleList = tmpRet
    for nId, mapRoomData in pairs(self.mapDormRoomInfo) do
      if nRoomId ~= nId then
        local tbRoleList = {}
        for _, mapRoleData in ipairs(mapRoomData.RoleList) do
          if table.indexof(tbRoleId, mapRoleData.RoleId) < 1 then
            table.insert(tbRoleList, mapRoleData)
          end
        end
        mapRoomData.RoleList = tbRoleList
      end
    end
    if type(callback) == "function" and callback ~= nil then
      callback(self.mapDormRoomInfo)
    end
  end
  
  local tbRoleInfo = {}
  for _, nRoleId in ipairs(tbRoleId) do
    table.insert(tbRoleInfo, {RoleId = nRoleId})
  end
  local msg = {DormRoomId = nRoomId, InvitationRoleList = tbRoleInfo}
  HttpNetHandler.SendMsg(NetMsgId.Id.dorm_invitation_role_req, msg, nil, NetCallback)
end

function PlayerDormData:CheckLayoutReceived(nLayoutId)
  return table.indexof(self.tbReceivedLayoutReward, nLayoutId) > 0
end

function PlayerDormData:DormLayoutRewardReceive(tbLayoutId, callback)
  local function NetCallback(_, msgData)
    for _, nLayoutId in ipairs(tbLayoutId) do
      table.insert(self.tbReceivedLayoutReward, nLayoutId)
    end
    if type(callback) == "function" and callback ~= nil then
      callback(msgData)
    end
    EventManager.Hit("DormLayoutRewardReceive")
    self:RefreshRedDotFurnitureReward()
  end
  
  local msg = {LayoutIds = tbLayoutId}
  HttpNetHandler.SendMsg(NetMsgId.Id.dorm_layout_reward_receive_req, msg, nil, NetCallback)
end

function PlayerDormData:CheckHasRewardById(nRewardId)
  return table.indexof(self.mapDromBaseInfo.rewardIds, nRewardId) > 0
end

function PlayerDormData:DormRewardReceive(rewardIds, callback)
  local function NetCallback(_, netMsg)
    for _, rewardId in ipairs(rewardIds) do
      local nIdx = table.indexof(self.mapDromBaseInfo.rewardIds, rewardId)
      
      if 0 < nIdx then
        table.remove(self.mapDromBaseInfo.rewardIds, nIdx)
      end
      self:RefreshRedDotReward()
    end
    if type(callback) == "function" and callback ~= nil then
      callback(netMsg, clone(self.mapDromBaseInfo.rewardIds))
    end
  end
  
  local msg = {rewardIds = rewardIds}
  HttpNetHandler.SendMsg(NetMsgId.Id.dorm_reward_receive_req, msg, nil, NetCallback)
end

function PlayerDormData:DormSetRoomBgm(tbMsg, callback)
  local bUnchanged = true
  for _, value in ipairs(tbMsg) do
    if self.mapDormRoomInfo[value.DormRoomId] ~= nil and self.mapDormRoomInfo[value.DormRoomId].DiscId ~= value.DiscId then
      bUnchanged = false
      break
    end
  end
  if bUnchanged then
    EventManager.Hit("DormBGMSetSuccess", tbMsg)
    if type(callback) == "function" and callback ~= nil then
      callback()
    end
    return
  end
  
  local function NetCallback()
    for _, value in ipairs(tbMsg) do
      if self.mapDormRoomInfo[value.DormRoomId] ~= nil then
        self.mapDormRoomInfo[value.DormRoomId].DiscId = value.DiscId
      end
    end
    EventManager.Hit("DormBGMSetSuccess", tbMsg)
    if type(callback) == "function" and callback ~= nil then
      callback()
    end
  end
  
  local msg = {BGMList = tbMsg}
  HttpNetHandler.SendMsg(NetMsgId.Id.dorm_room_bgm_req, msg, nil, NetCallback)
end

function PlayerDormData:DormAffinityGiftSend(nRoomId, nCharId, tbGift, callback)
  local mapAffinityBefore = PlayerData.Char:GetCharAffinityData(nCharId)
  local nGiftCount = 0
  
  local function NetCallback(_, msgData)
    if self.mapAffinityGiftRoleCount[nCharId] == nil then
      self.mapAffinityGiftRoleCount[nCharId] = 0
    end
    self.mapAffinityGiftRoleCount[nCharId] = self.mapAffinityGiftRoleCount[nCharId] + nGiftCount
    if msgData.Info == nil then
      if type(callback) == "function" and callback ~= nil then
        callback()
      end
      return
    end
    local nExpChange = self:CalcAffinityExpChange(msgData.Info.CharId, mapAffinityBefore.Level, mapAffinityBefore.Exp, msgData.Info.AffinityLevel, msgData.Info.AffinityExp)
    msgData.Info.nExpChange = nExpChange
    msgData.Info.nLevelChange = msgData.Info.AffinityLevel - mapAffinityBefore.Level
    msgData.Info.nBeforeLevel = mapAffinityBefore.Level
    msgData.Info.nBeforeExp = mapAffinityBefore.Exp
    if type(callback) == "function" and callback ~= nil then
      callback(msgData.Info)
    end
  end
  
  local msg = {
    CharId = nCharId,
    DormRoomId = nRoomId,
    Items = tbGift
  }
  for _, mapItemTpl in ipairs(tbGift) do
    nGiftCount = nGiftCount + mapItemTpl.Qty
  end
  HttpNetHandler.SendMsg(NetMsgId.Id.dorm_affinity_gift_send_req, msg, nil, NetCallback)
end

function PlayerDormData:DormGetFriendList(callback)
  local function NetCallback(_, msgData)
    local tempData = clone(self.mapFriendDetail)
    
    self.mapFriendDetail = {}
    for _, value in ipairs(msgData.Friends) do
      local tempLikeNumber = 0
      if tempData[value.uid] ~= nil then
        tempLikeNumber = tempData[value.uid].LikeNum
      end
      self.mapFriendDetail[value.uid] = value
      self.mapFriendDetail[value.uid].LikeNum = math.max(self.mapFriendDetail[value.uid].LikeNum, tempLikeNumber)
      if self.mapFriendDetail[value.uid].DormName == "@" then
        self.mapFriendDetail[value.uid].DormName = ""
      end
    end
    if type(callback) == "function" and callback ~= nil then
      callback(clone(self.mapFriendDetail))
    end
  end
  
  local msg = {}
  HttpNetHandler.SendMsg(NetMsgId.Id.dorm_friend_list_req, msg, nil, NetCallback)
end

function PlayerDormData:DormGetFriendInfoByUid(nUid)
  if self.mapFriendDetail[nUid] == nil then
  end
  return (clone(self.mapFriendDetail[nUid]))
end

function PlayerDormData:DormGetFriendVisitData(nUid, DormRoomId, callback)
  local function NetCallback(_, msgData)
    if self.CachedFriendData[nUid] == nil then
      self.CachedFriendData[nUid] = {}
    end
    if self.CachedFriendData[nUid].mapDormDetail == nil then
      self.CachedFriendData[nUid].mapDormDetail = {}
    end
    for _, mapDormRoomInfo in ipairs(msgData.DormList) do
      if mapDormRoomInfo.FurnitureList == nil or #mapDormRoomInfo.FurnitureList == 0 then
        local mapRoomConfig = ConfigTable.GetData("DormRoom", mapDormRoomInfo.DormRoomId)
        if mapRoomConfig ~= nil then
          local nDefaultId = mapRoomConfig.DefaultLayoutId
          if nDefaultId ~= 0 then
            mapDormRoomInfo.FurnitureList = self:SetDefaultFurnitureList(nDefaultId)
          end
        end
      end
      self.CachedFriendData[nUid].mapDormDetail[mapDormRoomInfo.DormRoomId] = mapDormRoomInfo
    end
    self.CachedFriendData[nUid].expire = CS.ClientManager.Instance.serverTimeStamp + 600
    if type(callback) == "function" and callback ~= nil then
      callback(clone(self.CachedFriendData[nUid]))
    end
  end
  
  if self.CachedFriendData[nUid] ~= nil and self.CachedFriendData[nUid].expire ~= nil and self.CachedFriendData[nUid].expire > CS.ClientManager.Instance.serverTimeStamp and self.CachedFriendData[nUid].mapDormDetail ~= nil and self.CachedFriendData[nUid].mapDormDetail[DormRoomId] ~= nil then
    if type(callback) == "function" and callback ~= nil then
      callback(clone(self.CachedFriendData[nUid]))
    end
  else
    local msg = {FriendId = nUid, DormRoomId = DormRoomId}
    HttpNetHandler.SendMsg(NetMsgId.Id.dorm_friend_visit_req, msg, nil, NetCallback)
  end
end

function PlayerDormData:DormGetCachedFriendVisitData(nUid)
  return self.CachedFriendData[nUid]
end

function PlayerDormData:DormRoleInteraction(tbRoleIds, callback)
  local mapAffinityBefore = {}
  
  local function NetCallback(_, msgData)
    if self.tbInteractionRoleIds == nil then
      self.tbInteractionRoleIds = {}
    end
    for _, mapRoleId in ipairs(tbRoleIds) do
      local nIdx = table.indexof(self.tbInteractionRoleIds, mapRoleId.RoleId)
      if nIdx < 1 then
        table.insert(self.tbInteractionRoleIds, mapRoleId.RoleId)
      end
    end
    for _, mapData in ipairs(msgData.InfoList) do
      local nExpChange = 0
      if mapAffinityBefore[mapData.AffinityInfo.CharId] ~= nil then
        nExpChange = self:CalcAffinityExpChange(mapData.AffinityInfo.CharId, mapAffinityBefore[mapData.AffinityInfo.CharId].Level, mapAffinityBefore[mapData.AffinityInfo.CharId].Exp, mapData.AffinityInfo.AffinityLevel, mapData.AffinityInfo.AffinityExp)
      end
      mapData.AffinityInfo.nExpChange = nExpChange
      mapData.AffinityInfo.nLevelChange = mapData.AffinityInfo.AffinityLevel - mapAffinityBefore[mapData.AffinityInfo.CharId].Level
      mapData.AffinityInfo.nBeforeLevel = mapAffinityBefore[mapData.AffinityInfo.CharId].Level
      mapData.AffinityInfo.nBeforeExp = mapAffinityBefore[mapData.AffinityInfo.CharId].Exp
    end
    if type(callback) == "function" and callback ~= nil then
      callback(msgData.InfoList, msgData.Change)
    end
    EventManager.Hit("DormRoleInteraction")
  end
  
  local msg = {RoleInteractions = tbRoleIds}
  for _, mapCharInfo in ipairs(tbRoleIds) do
    mapAffinityBefore[mapCharInfo.RoleId] = PlayerData.Char:GetCharAffinityData(mapCharInfo.RoleId)
  end
  HttpNetHandler.SendMsg(NetMsgId.Id.dorm_role_interaction_req, msg, nil, NetCallback)
end

function PlayerDormData:DormFriendLike(nUid, callback)
  local nTotalCount = 0
  for _, mapFriendDetail in pairs(self.mapFriendDetail) do
    nTotalCount = nTotalCount + (mapFriendDetail.IsLike and 1 or 0)
  end
  local nLikeCountLimit = ConfigTable.GetConfigNumber("DormLikeLimit") or 999
  if nTotalCount >= nLikeCountLimit then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Dorm_Friend_LikeLimit"))
    return
  end
  
  local function NetCallback()
    local mapFriend = self.mapFriendDetail[nUid]
    if mapFriend ~= nil then
      mapFriend.IsLike = true
      mapFriend.LikeNum = (mapFriend.LikeNum or 0) + 1
    end
    if type(callback) == "function" and callback ~= nil then
      callback()
    end
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("DormTips_LikeSuccess"))
    EventManager.Hit("DormFriendLikeSuc", nUid)
  end
  
  local msg = {FriendId = nUid}
  HttpNetHandler.SendMsg(NetMsgId.Id.dorm_friend_like_req, msg, nil, NetCallback)
end

function PlayerDormData:DormUpdatePresetName(nBuildId, sName, callback)
  local function NetCallback()
    if self.mapPresetData[nBuildId] ~= nil then
      self.mapPresetData[nBuildId].BuildName = sName
      
      EventManager.Hit("DormUpdatePresetNameSuc", nBuildId, sName)
    end
    if type(callback) == "function" and callback ~= nil then
      callback()
    end
  end
  
  local msg = {Value = sName, Version = nBuildId}
  HttpNetHandler.SendMsg(NetMsgId.Id.dorm_update_preset_name_req, msg, nil, NetCallback)
end

function PlayerDormData:DormSetRoomScene(nRoomId, nScene, callback)
  local function NetCallback()
    if self.mapDormRoomInfo[nRoomId] ~= nil then
      self.mapDormRoomInfo[nRoomId].RoomScene = nScene
    end
    if type(callback) == "function" and callback ~= nil then
      callback()
    end
  end
  
  local msg = {Value = nScene, Version = nRoomId}
  HttpNetHandler.SendMsg(NetMsgId.Id.dorm_set_room_scene_req, msg, nil, NetCallback)
end

function PlayerDormData:CheckRoleSendGift(nRoleId)
  local nCount = 0
  for nCharId, nCharCount in pairs(self.mapAffinityGiftRoleCount) do
    nCount = nCount + nCharCount
  end
  if nCount >= self.nMaxGiftSendCount then
    print("今日送礼次数已达上限")
    return true
  end
  local nRoleCount = self.mapAffinityGiftRoleCount[nRoleId] or 0
  return nRoleCount > self.nMaxRoleGiftSendCount
end

function PlayerDormData:CheckRoleInteraction(nRoleId)
  if #self.tbInteractionRoleIds >= self.nMaxInteractionCount then
    print(ConfigTable.GetUIText("Dorm_Interaction_DayLimitHint"))
    return true
  end
  return table.indexof(self.tbInteractionRoleIds, nRoleId) > 0
end

function PlayerDormData:GetRoleInteractionDayCount()
  return math.max(self.nMaxInteractionCount - #self.tbInteractionRoleIds, 0)
end

function PlayerDormData:CalcAffinityExpChange(nCharId, nLastLevel, nLastExp, nNewLevel, nNewExp)
  local nChangeExp = nNewExp - nLastExp
  local mapCharAffinity = ConfigTable.GetData("CharAffinityTemplate", nCharId)
  if mapCharAffinity == nil then
    return nChangeExp
  end
  local templateId = mapCharAffinity.TemplateId
  local mapLevelCfg = CacheTable.GetData("_AffinityLevel", templateId) or {}
  for nLevel = nLastLevel + 1, nNewLevel do
    local mapCfg = mapLevelCfg[nLevel]
    if mapCfg ~= nil then
      nChangeExp = nChangeExp + mapCfg.NeedExp
    end
  end
  return nChangeExp
end

function PlayerDormData:GetCharGiftCountDay(nCharId)
  local nCount = 0
  for nCharId, nCharCount in pairs(self.mapAffinityGiftRoleCount) do
    nCount = nCount + nCharCount
  end
  local nSumTotalCount = self.nMaxGiftSendCount - nCount
  local nCharCount = self.mapAffinityGiftRoleCount[nCharId] or 0
  local nSumCharCount = self.nMaxRoleGiftSendCount - nCharCount
  return math.max(math.min(nSumTotalCount, nSumCharCount), 0)
end

function PlayerDormData:GetPanelDefaultMode()
  local nCachedMode = LocalData.GetPlayerLocalData("DormDefaultMode")
  if nCachedMode == nil then
    nCachedMode = 1
  end
  return tonumber(nCachedMode)
end

function PlayerDormData:SetPanelDefaultMode(nMode)
  LocalData.SetPlayerLocalData("DormDefaultMode", nMode)
end

function PlayerDormData:GetDormQuestDataWithGroup()
  if not self.bHasRoomData then
    return 0, 0, {}
  end
  local ret = {}
  local mapQuest = PlayerData.Quest:GetDormQuestData()
  local nCurGroup = self.mapDromBaseInfo.TaskGroup.Version
  local nGroupState = self.mapDromBaseInfo.TaskGroup.Value
  local mapGroupQuestData = {}
  if 0 < nCurGroup then
    for nQuestId, mapQuestData in pairs(mapQuest) do
      local mapQuestCfgData = ConfigTable.GetData("DormQuest", nQuestId)
      if mapQuestCfgData ~= nil and nCurGroup == mapQuestCfgData.DormQuestGroup then
        mapGroupQuestData[nQuestId] = mapQuestData
      end
    end
    
    local function foreachDormQuest(mapData)
      if mapData.DormQuestGroup == nCurGroup and mapGroupQuestData[mapData.Id] == nil then
        mapGroupQuestData[mapData.Id] = {
          nTid = mapData.Id,
          nGoal = 0,
          nCurProgress = 0,
          nStatus = 2,
          nExpire = -1
        }
      end
    end
    
    ForEachTableLine(DataTable.DormQuest, foreachDormQuest)
    for _, value in pairs(mapGroupQuestData) do
      table.insert(ret, value)
    end
  end
  return nCurGroup, nGroupState, ret
end

function PlayerDormData:UpdateGroup(newValue)
  self.mapDromBaseInfo.TaskGroup = newValue
end

function PlayerDormData:ReceiveDormAchievement(tbIds, callback)
  local msg = {
    AchievementIds = {}
  }
  for _, value in ipairs(tbIds) do
    if table.indexof(self.tbAchievementIds, value) < 1 then
      table.insert(msg.AchievementIds, value)
    end
  end
  if #msg.AchievementIds <= 0 then
    return
  end
  
  local function netCallback(_, msgData)
    for _, value in ipairs(msgData.AchievementList) do
      local nIdx = table.indexof(self.tbAchievementIds, value.AchievementId)
      if nIdx < 1 then
        table.insert(self.tbAchievementIds, value.AchievementId)
      end
      self.mapAchievementCompleteTime[value.AchievementId] = value.CompleteTime
    end
    if callback ~= nil and type(callback) == "function" then
      callback(msgData)
    end
    self:RefreshRedDotAchievement()
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.dorm_achievement_reward_receive_req, msg, nil, netCallback)
end

function PlayerDormData:GetDormAchievementData()
  if not self.bHasBagData or not self.bHasRoomData then
    return {}, 0
  end
  local totalCollection = 0
  for nFurnitureId, nCount in pairs(self.mapFurnitureBag) do
    if 0 < nCount then
      local mapFurnitureCfgData = ConfigTable.GetData("DormFurniture", nFurnitureId)
      if mapFurnitureCfgData ~= nil then
        totalCollection = totalCollection + mapFurnitureCfgData.CollectionValue
      end
    end
  end
  return clone(self.tbAchievementIds), totalCollection
end

function PlayerDormData:GetDormAchievementCompleteTime(nId)
  return self.mapAchievementCompleteTime[nId] or 0
end

function PlayerDormData:UnlockRoom(nRoomId)
  if nRoomId == nil then
    return
  end
  if nRoomId ~= 701001 then
    table.insert(self.tbNewRoom, nRoomId)
    self:SetNewRoomLocalData()
    self:RefreshRedDotNewRoom()
  end
  if self.mapDormRoomInfo[nRoomId] ~= nil or not self.bHasRoomData then
    return
  end
  self.mapDormRoomInfo[nRoomId] = {}
  local mapRoomConfig = ConfigTable.GetData("DormRoom", nRoomId)
  if mapRoomConfig ~= nil then
    local nDefaultId = mapRoomConfig.DefaultLayoutId
    if nDefaultId ~= 0 then
      self.mapDormRoomInfo[nRoomId].FurnitureList = self:SetDefaultFurnitureList(nDefaultId)
    end
  end
  self.mapDormRoomInfo[nRoomId].DormRoomId = nRoomId
  self.mapDormRoomInfo[nRoomId].RoleList = {}
  self.mapDormRoomInfo[nRoomId].DiscId = 0
  self.mapDormRoomInfo[nRoomId].RoomName = ""
  self.mapDormRoomInfo[nRoomId].RoomScene = 0
  self:UpdateAllUsedCount()
end

function PlayerDormData:GetDormCharSkin(nRoleId)
  return nRoleId * 100 + 1
end

function PlayerDormData:UpdateLikeInfo(callback)
  local nCurTime = CS.ClientManager.Instance.serverTimeStamp
  if nCurTime - self.nLastLikeInfoTime < 300 then
    callback(self.mapDromBaseInfo.LikeNum, self.mapDromBaseInfo.DayVisitNum, self.mapDromBaseInfo.VisitTotalNum)
    return
  end
  
  local function netCallback(_, netMsg)
    self.mapDromBaseInfo.LikeNum = netMsg.DormChangeData.LikeNum
    self.mapDromBaseInfo.DayVisitNum = netMsg.DormChangeData.DayVisitNum
    self.mapDromBaseInfo.VisitTotalNum = netMsg.DormChangeData.VisitTotalNum
    callback(self.mapDromBaseInfo.LikeNum, self.mapDromBaseInfo.DayVisitNum, self.mapDromBaseInfo.VisitTotalNum)
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.dorm_get_change_data_req, {}, nil, netCallback)
  self.nLastLikeInfoTime = nCurTime
end

function PlayerDormData:CheckGetFurnitureById(nFurId)
  if self.bHasBagData ~= true then
    return false
  end
  return self.mapFurnitureBag[nFurId] ~= nil and self.mapFurnitureBag[nFurId] > 0
end

function PlayerDormData:CacheDormHotInfo(mapData)
  if mapData ~= nil then
    self.cachedCollection = mapData.CollectionValue
    PlayerData.Guide:SetGuideNewbie(mapData.Newbies)
  end
  local sKey = "PlayerDormNewRoom"
  local sData = LocalData.GetPlayerLocalData(sKey)
  if sData == nil then
    self.tbNewRoom = {}
  else
    self.tbNewRoom = decodeJson(sData)
  end
  self:RefreshRedDotNewRoom()
end

function PlayerDormData:GetHonorTitleLevel(nCollection)
  local nRet = 0
  local nCollection = nCollection == nil and self.cachedCollection or nCollection
  for i = 1, self.nHonorMaxLevel do
    local mapHornorLevelData = ConfigTable.GetData("DormHonorTitle", i)
    if mapHornorLevelData ~= nil then
      if nCollection >= mapHornorLevelData.NeedExp then
        nRet = i
      else
        return nRet
      end
    end
  end
  return nRet
end

function PlayerDormData:GetHonorTitleData(nLevel)
  local mapRet = {}
  local mapMaxLevel = ConfigTable.GetData("DormHonorTitle", self.nHonorMaxLevel)
  local mapLevel = ConfigTable.GetData("DormHonorTitle", nLevel)
  mapRet[nLevel] = mapLevel
  mapRet[self.nHonorMaxLevel] = mapMaxLevel
  return mapRet, self.nHonorMaxLevel
end

function PlayerDormData:GetRoomNameById(nRoomId)
  local mapRoomConfigData = ConfigTable.GetData("DormRoom", nRoomId)
  if self.bHasRoomData ~= true then
    return mapRoomConfigData == nil and "" or mapRoomConfigData.DefaultName
  end
  local mapInfo = self.mapDormRoomInfo[nRoomId]
  if mapInfo == nil then
    return mapRoomConfigData == nil and "" or mapRoomConfigData.DefaultName
  end
  return mapInfo.RoomName == nil or mapInfo.RoomName == "" and mapRoomConfigData.DefaultName or mapInfo.RoomName
end

function PlayerDormData:GetNewRoom()
  if #self.tbNewRoom == 0 then
    return {}
  end
  local tempNewRoom = clone(self.tbNewRoom)
  self.tbNewRoom = {}
  self:RefreshRedDotNewRoom()
  self:SetNewRoomLocalData()
  return tempNewRoom
end

function PlayerDormData:SetNewRoomLocalData()
  local sKey = "PlayerDormNewRoom"
  local RapidJson = require("rapidjson")
  local sData = RapidJson.encode(self.tbNewRoom)
  LocalData.SetPlayerLocalData(sKey, sData)
end

function PlayerDormData:RefreshRedDotReward()
  if not self.bHasRoomData then
    return
  end
  local bHasReward = #self.mapDromBaseInfo.rewardIds > 0
  RedDotManager.SetValid(RedDotDefine.DormReward, nil, bHasReward)
end

function PlayerDormData:RefreshRedDotNewRoom()
  local bHasNew = #self.tbNewRoom > 0
  RedDotManager.SetValid(RedDotDefine.DormElevator, nil, bHasNew)
end

function PlayerDormData:RefreshRedDotFurnitureReward()
  if not self.bHasBagData or not self.bHasRoomData then
    return
  end
  
  local function CheckFurnitureRewardCanReceive(nLayoutId)
    local mapRewardCfg = ConfigTable.GetData("DormLayoutReward", nLayoutId)
    if mapRewardCfg == nil then
      return false
    end
    local nCount = mapRewardCfg.FurnitureCount
    local nTempCount = {}
    for i = 1, nCount do
      local mapLayoutCfgData = ConfigTable.GetData("DormRoomLayout", nLayoutId * 100 + i)
      if mapLayoutCfgData ~= nil then
        if nTempCount[mapLayoutCfgData.FurnitureId] == nil then
          nTempCount[mapLayoutCfgData.FurnitureId] = 0
        end
        nTempCount[mapLayoutCfgData.FurnitureId] = nTempCount[mapLayoutCfgData.FurnitureId] + 1
        if self.mapFurnitureBag[mapLayoutCfgData.FurnitureId] == nil or self.mapFurnitureBag[mapLayoutCfgData.FurnitureId] < nTempCount[mapLayoutCfgData.FurnitureId] then
          return false
        end
      end
    end
    return true
  end
  
  local bHasFurnitureReward = false
  
  local function foreachTableLine(mapData)
    if mapData.noShow then
      return
    end
    if self:CheckLayoutReceived(mapData.Id) then
      return
    end
    if not bHasFurnitureReward and table.indexof(self.tbReceivedLayoutReward, mapData.Id) < 1 and CheckFurnitureRewardCanReceive(mapData.Id) then
      bHasFurnitureReward = true
    end
  end
  
  ForEachTableLine(DataTable.DormLayoutReward, foreachTableLine)
  RedDotManager.SetValid(RedDotDefine.DormRecord_Furniture, nil, bHasFurnitureReward)
end

function PlayerDormData:RefreshRedDotAchievement()
  local nTotal = self.cachedCollection
  
  local function CheckAchievementCanReceive(mapData)
    local mapAchievementCfgData = mapData
    if mapAchievementCfgData == nil then
      return false
    end
    local nGoal = mapAchievementCfgData.CompleteParams[1]
    if nGoal == nil then
      nGoal = 1
    end
    return nGoal <= nTotal
  end
  
  local bHasAchievement = false
  if not self.bHasRoomData then
    return
  end
  
  local function forEachAchievement(mapData)
    if bHasAchievement then
      return
    end
    if self.mapAchievementCompleteTime[mapData.Id] == nil then
      local bCanReceive = CheckAchievementCanReceive(mapData)
      if bCanReceive then
        bHasAchievement = true
      end
    end
  end
  
  ForEachTableLine(DataTable.DormAchievement, forEachAchievement)
  RedDotManager.SetValid(RedDotDefine.DormRecord_Achievement, nil, bHasAchievement)
end

function PlayerDormData:RefreshRedDotQuest()
  if not self.bHasRoomData then
    return
  end
  local nCurGroup, nGroupState, tbQuest = PlayerData.PlayerDormData:GetDormQuestDataWithGroup()
  local bQuestAllComplete = true
  local bHasQuest = false
  for _, mapQuest in ipairs(tbQuest) do
    if mapQuest.nStatus < 2 then
      bQuestAllComplete = false
    end
    if mapQuest.nStatus == 1 then
      bHasQuest = true
      break
    end
  end
  if not bHasQuest and bQuestAllComplete and nGroupState < 1 then
    bHasQuest = true
  end
  RedDotManager.SetValid(RedDotDefine.DormQuest, nil, bHasQuest)
end

return PlayerDormData
