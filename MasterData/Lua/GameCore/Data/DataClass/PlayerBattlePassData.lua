local PlayerBattlePassData = class("PlayerBattlePassData")

function PlayerBattlePassData:Init()
  self.nSeasonId = 0
  self.nCurMode = 0
  self.nVersion = 0
  self.nDeadlineTS = 0
  self.nLevel = 0
  self.nExp = 0
  self.nMaxLevel = 0
  self.nExpThisWeek = 0
  self.tbBaseReward = nil
  self.tbPremiumReward = nil
  self.hasData = false
  EventManager.Add(EventId.IsNewDay, self, self.OnEvent_NewDay)
  EventManager.Add("BattlePassNeedRefresh", self, self.OnEvent_NeedRefresh)
  self:InitConfig()
end

function PlayerBattlePassData:UnInit()
  EventManager.Remove(EventId.IsNewDay, self, self.OnEvent_NewDay)
end

function PlayerBattlePassData:InitConfig()
  local function forEachBattlePassLevel(mapData)
    if mapData.ID > self.nMaxLevel then
      self.nMaxLevel = mapData.ID
    end
  end
  
  ForEachTableLine(DataTable.BattlePassLevel, forEachBattlePassLevel)
  self.mapBattlePassName = {}
  
  local function func_ForEach_Line(mapData)
    self.mapBattlePassName[mapData.LuxuryProductId] = ConfigTable.GetUIText("BattlePassRewardLuxury")
    self.mapBattlePassName[mapData.PremiumProductId] = ConfigTable.GetUIText("BattlePassRewardPremium")
    self.mapBattlePassName[mapData.ComplementaryProductId] = ConfigTable.GetUIText("BattlePassRewardLuxury")
  end
  
  ForEachTableLine(DataTable.BattlePass, func_ForEach_Line)
end

function PlayerBattlePassData:CacheBattlePassInfo(mapData)
  if mapData == nil then
    return
  end
  print("当前赛季ID：" .. mapData.Id)
  self.nSeasonId = mapData.Id
  self.nCurMode = mapData.Mode
  self.nVersion = mapData.Version
  self.nDeadlineTS = mapData.Deadline
  self.nLevel = mapData.Level
  self.nExp = mapData.Exp
  self.nExpThisWeek = mapData.ExpThisWeek
  self.tbBaseReward = UTILS.ParseByteString(mapData.BasicReward)
  self.tbPremiumReward = UTILS.ParseByteString(mapData.PremiumReward)
  local nExpLimit = ConfigTable.GetConfigNumber("BattlePassWeeklyExpLimit")
  if nExpLimit < self.nExpThisWeek then
    self.nExpThisWeek = self.nExpThisWeek
  end
  self:UpdateRewardRedDot()
  RedDotManager.SetValid(RedDotDefine.BattlePass_Quest_Server, nil, false)
  if mapData.DailyQuests ~= nil then
    PlayerData.Quest:CacheAllQuest(mapData.DailyQuests.List)
  end
  if mapData.WeeklyQuests ~= nil then
    PlayerData.Quest:CacheAllQuest(mapData.WeeklyQuests.List)
  end
  self.hasData = true
end

function PlayerBattlePassData:UpdateQuestRedDot(bCanDailyReceive, bCanWeekReceive)
  local nExpLimit = ConfigTable.GetConfigNumber("BattlePassWeeklyExpLimit")
  self.nExpThisWeek = self.nExpThisWeek
  if nExpLimit <= self.nExpThisWeek then
    RedDotManager.SetValid(RedDotDefine.BattlePass_Quest_Daily, nil, false)
    RedDotManager.SetValid(RedDotDefine.BattlePass_Quest_Week, nil, false)
  else
    local bMaxLevel = self.nLevel >= self.nMaxLevel
    RedDotManager.SetValid(RedDotDefine.BattlePass_Quest_Daily, nil, bCanDailyReceive and not bMaxLevel)
    RedDotManager.SetValid(RedDotDefine.BattlePass_Quest_Week, nil, bCanWeekReceive and not bMaxLevel)
  end
end

function PlayerBattlePassData:UpdateRewardRedDot()
  local bCanReceive = false
  local mapReward = {}
  local nRewardCount = 0
  
  local function foreachReward(mapData)
    if mapData.ID == self.nSeasonId then
      mapReward[mapData.Level] = mapData
      nRewardCount = nRewardCount + 1
    end
  end
  
  ForEachTableLine(DataTable.BattlePassReward, foreachReward)
  for i = 1, nRewardCount do
    if mapReward[i] ~= nil then
      local bNormalReceive = UTILS.IsBitSet(self.tbBaseReward, i)
      local bVipReceive = UTILS.IsBitSet(self.tbPremiumReward, i)
      if i <= self.nLevel and (not bNormalReceive or 0 < self.nCurMode and not bVipReceive) then
        bCanReceive = true
        break
      end
    end
  end
  RedDotManager.SetValid(RedDotDefine.BattlePass_Reward, nil, bCanReceive)
  local nExpLimit = ConfigTable.GetConfigNumber("BattlePassWeeklyExpLimit")
  if self.nLevel >= self.nMaxLevel or nExpLimit <= self.nExpThisWeek then
    RedDotManager.SetValid(RedDotDefine.BattlePass_Quest_Week, nil, false)
    RedDotManager.SetValid(RedDotDefine.BattlePass_Quest_Daily, nil, false)
  end
end

function PlayerBattlePassData:OnPremiumBuySuccess(mapData)
  if self.nLevel ~= mapData.Level then
    local mapLevelData = {
      nOldLevel = self.nLevel,
      nOldExp = self.nExp,
      nLevel = mapData.Level,
      nExp = self.nExp
    }
    
    local function callback()
      EventManager.Remove("MallOrderClear", self, callback)
      
      local function levelupCallback()
        local mapReward = PlayerData.Item:ProcessRewardChangeInfo(mapData.CollectResp.Items)
        local tbSelectedItem = {}
        for _, mapItemData in ipairs(mapReward.tbReward) do
          local mapItemCfgData = ConfigTable.GetData_Item(mapItemData.id)
          if mapItemCfgData ~= nil and mapItemCfgData.Stype == GameEnum.itemStype.OutfitCYO then
            table.insert(tbSelectedItem, mapItemData.id)
          end
        end
        if 0 < #tbSelectedItem then
          EventManager.Hit(EventId.OpenPanel, PanelId.Consumable, tbSelectedItem)
        end
        EventManager.Hit("BattlePassLevelUpPanelClose")
      end
      
      EventManager.Hit(EventId.OpenPanel, PanelId.BattlePassUpgrade, levelupCallback, mapLevelData)
    end
    
    EventManager.Add("MallOrderClear", self, callback)
  else
    local function callback()
      EventManager.Remove("MallOrderClear", self, callback)
      
      if mapData.Mode == 1 then
        local msg = {
          nType = AllEnum.MessageBox.Alert,
          sContent = ConfigTable.GetUIText("BattlePassRewardPremium_ReceiveTip")
        }
        EventManager.Hit(EventId.OpenMessageBox, msg)
      end
    end
    
    EventManager.Add("MallOrderClear", self, callback)
  end
  self.nVersion = mapData.Version
  self.nCurMode = mapData.Mode
  self.nLevel = mapData.Level
  self:UpdateRewardRedDot()
  EventManager.Hit("BattlePassPremiumSuccess")
end

function PlayerBattlePassData:OnQuestReceive(msgData)
  self.nLevel = msgData.Level
  self.nExp = msgData.Exp
  local nExpLimit = ConfigTable.GetConfigNumber("BattlePassWeeklyExpLimit")
  self.nExpThisWeek = msgData.ExpThisWeek
  if nExpLimit < self.nExpThisWeek then
    self.nExpThisWeek = self.nExpThisWeek
  end
  self:UpdateRewardRedDot()
end

function PlayerBattlePassData:GetBattlePassName(sId)
  return self.mapBattlePassName[sId]
end

function PlayerBattlePassData:OnEvent_NewDay()
  self.hasData = false
end

function PlayerBattlePassData:OnEvent_NeedRefresh()
  self.hasData = false
end

function PlayerBattlePassData:NetMsg_BuyBattlePassLevel(nLevel, callback)
  local msg = {
    Value = nLevel,
    Version = self.nVersion
  }
  local mapLevelData = {
    nOldLevel = self.nLevel,
    nOldExp = self.nExp
  }
  
  local function msgCallback(_, msgData)
    self.nLevel = msgData.Level
    mapLevelData.nLevel = self.nLevel
    mapLevelData.nExp = self.nExp
    
    local function callabck()
      EventManager.Hit("BattlePassLevelUpPanelClose")
    end
    
    EventManager.Hit(EventId.OpenPanel, PanelId.BattlePassUpgrade, callabck, mapLevelData)
    EventManager.Hit("BattlePassBuyLevel")
    if callback ~= nil and type(callback) == "function" then
      callback()
    end
    self:UpdateRewardRedDot()
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.battle_pass_level_buy_req, msg, nil, msgCallback)
end

function PlayerBattlePassData:NetMsg_BattlePassRewardReceive(bAll, nLevel, bBasic, callback)
  local msg = {}
  if bAll then
    msg.All = {}
  elseif bBasic then
    msg.Basic = nLevel
  else
    msg.Premium = nLevel
  end
  msg.Version = self.nVersion
  
  local function msgCallback(_, msgData)
    self.tbBaseReward = UTILS.ParseByteString(msgData.BasicReward)
    self.tbPremiumReward = UTILS.ParseByteString(msgData.PremiumReward)
    EventManager.Hit("UpdateBattlePassReward", msgData.Change)
    self:UpdateRewardRedDot()
    if callback ~= nil and type(callback) == "function" then
      callback()
    end
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.battle_pass_reward_receive_req, msg, nil, msgCallback)
end

function PlayerBattlePassData:GetBattlePassInfo(callback)
  local function GetMsgCallback()
    if not self.hasData then
      printError("未获取到战令数据")
      
      return
    end
    local mapRet = {}
    local mapReward = {}
    local nRewardCount = 0
    
    local function foreachReward(mapData)
      if mapData.ID == self.nSeasonId then
        mapReward[mapData.Level] = mapData
        nRewardCount = nRewardCount + 1
      end
    end
    
    ForEachTableLine(DataTable.BattlePassReward, foreachReward)
    mapRet.nSeasonId = self.nSeasonId
    mapRet.nCurMode = self.nCurMode
    mapRet.nVersion = self.nVersion
    mapRet.nDeadlineTS = self.nDeadlineTS
    mapRet.nLevel = self.nLevel
    mapRet.nExp = self.nExp
    mapRet.nExpThisWeek = self.nExpThisWeek
    mapRet.tbReward = {}
    for i = 1, nRewardCount do
      if mapReward[i] ~= nil then
        local bNormalReceive = UTILS.IsBitSet(self.tbBaseReward, i)
        local bVipReceive = UTILS.IsBitSet(self.tbPremiumReward, i)
        table.insert(mapRet.tbReward, {
          nLevel = i,
          nNormalTid = mapReward[i].Tid1,
          nNormalQty = mapReward[i].Qty1,
          nVipTid1 = mapReward[i].Tid2,
          nVipQty1 = mapReward[i].Qty2,
          nVipTid2 = mapReward[i].Tid3,
          nVipQty2 = mapReward[i].Qty3,
          bNormalReceive = bNormalReceive,
          bVipReceive = bVipReceive,
          bFocus = mapReward[i].Focus
        })
      end
    end
    callback(mapRet)
  end
  
  if self.hasData then
    GetMsgCallback()
  else
    HttpNetHandler.SendMsg(NetMsgId.Id.battle_pass_info_req, {}, nil, GetMsgCallback)
  end
end

function PlayerBattlePassData:GetRefreshTime()
  if self.nSeasonId == 0 then
    return "-"
  end
  local mapSeasonCfgData = ConfigTable.GetData("BattlePass", self.nSeasonId)
  if mapSeasonCfgData == nil then
    return "-"
  end
  local nEndTime = CS.ClientManager.Instance:ISO8601StrToTimeStamp(mapSeasonCfgData.EndTime)
  local curTime = CS.ClientManager.Instance.serverTimeStamp
  local remainTime = nEndTime - curTime
  if remainTime < 0 then
    return "-"
  end
  local sTimeStr = "-"
  local remainTime = nEndTime - curTime
  if 86400 <= remainTime then
    local day = math.floor(remainTime / 86400)
    local hour = math.floor((remainTime - day * 86400) / 3600)
    if hour == 0 then
      day = day - 1
      hour = 24
    end
    sTimeStr = orderedFormat(ConfigTable.GetUIText("Energy_LeftTime_Day"), day, hour)
  elseif 3600 <= remainTime then
    local hour = math.floor(remainTime / 3600)
    local min = math.floor((remainTime - hour * 3600) / 60)
    if min == 0 then
      hour = hour - 1
      min = 60
    end
    sTimeStr = orderedFormat(ConfigTable.GetUIText("Energy_LeftTime_Hour"), hour, min)
  else
    sTimeStr = ConfigTable.GetUIText("Energy_LeftTime_LessThenHour")
  end
  return sTimeStr
end

function PlayerBattlePassData:GetCurrentSeasonIdFromConfig()
  local nCurTime = CS.ClientManager.Instance.serverTimeStamp
  local nSeasonId = 0
  
  local function forEach(mapData)
    if mapData.StartTime ~= nil and mapData.EndTime ~= nil then
      local nStart = CS.ClientManager.Instance:ISO8601StrToTimeStamp(mapData.StartTime)
      local nEnd = CS.ClientManager.Instance:ISO8601StrToTimeStamp(mapData.EndTime)
      if nStart <= nCurTime and nEnd > nCurTime then
        nSeasonId = mapData.ID
      end
    end
  end
  
  ForEachTableLine(DataTable.BattlePass, forEach)
  return nSeasonId
end

function PlayerBattlePassData:GetRemainTime()
  local nSeasonId = self.nSeasonId
  if nSeasonId == 0 then
    nSeasonId = self:GetCurrentSeasonIdFromConfig()
    if nSeasonId == 0 then
      return 0
    end
  end
  local mapSeasonCfgData = ConfigTable.GetData("BattlePass", nSeasonId)
  if mapSeasonCfgData == nil then
    return 0
  end
  local nEndTime = CS.ClientManager.Instance:ISO8601StrToTimeStamp(mapSeasonCfgData.EndTime)
  local curTime = CS.ClientManager.Instance.serverTimeStamp
  local nRemainTime = nEndTime - curTime
  if nRemainTime < 0 then
    return 0
  end
  return nRemainTime
end

function PlayerBattlePassData:GetHasBattlePass()
  if self.hasData then
    return self.nSeasonId > 0
  else
    local function IsOpenCardPool(sStartTime, sEndTime)
      if string.len(sStartTime) == 0 or string.len(sEndTime) == 0 then
        return true
      end
      local nowTime = CS.ClientManager.Instance.serverTimeStamp
      return nowTime > String2Time(sStartTime) and nowTime < String2Time(sEndTime)
    end
    
    local ret = false
    
    local function func_ForEach_Gacha(mapGacha)
      if IsOpenCardPool(mapGacha.StartTime, mapGacha.EndTime) then
        ret = true
      end
    end
    
    ForEachTableLine(DataTable.BattlePass, func_ForEach_Gacha)
    return ret
  end
end

function PlayerBattlePassData:GetMaxLevel()
  return self.nMaxLevel
end

return PlayerBattlePassData
