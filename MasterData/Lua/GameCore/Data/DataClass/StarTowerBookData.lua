local StarTowerBookData = class("StarTowerBookData")
local MAPSTATUS = {
  [0] = AllEnum.BookQuestStatus.UnComplete,
  [1] = AllEnum.BookQuestStatus.Complete,
  [2] = AllEnum.BookQuestStatus.Received
}

function StarTowerBookData:Init()
  self.mapPotentialBookBrief = {}
  self.mapPotentialBook = {}
  self.mapFateCardBook = {}
  self.mapPotentialQuest = {}
  self.mapFateCardQuest = {}
  self.mapEntranceCfg = {}
  self.bFateCardInit = false
  self.bEventInit = false
  EventManager.Add(EventId.UpdateWorldClass, StarTowerBookData, self.OnEvent_UpdateWorldClass)
  EventManager.Add(EventId.StarTowerPass, StarTowerBookData, self.OnEvent_StarTowerPass)
  self:InitConfig()
end

function StarTowerBookData:InitConfig()
  local function foreachEntranceTableLine(line)
    table.insert(self.mapEntranceCfg, line)
  end
  
  ForEachTableLine(ConfigTable.Get("StarTowerBookEntrance"), foreachEntranceTableLine)
  
  local function foreachPotentialTableLine(line)
    local nCharId = line.Id
    local mapCharCfg = ConfigTable.GetData_Character(nCharId)
    if mapCharCfg ~= nil and mapCharCfg.Available then
      local nAllCount = 0
      self.mapPotentialBook[nCharId] = {}
      self.mapPotentialBook[nCharId].Init = false
      self.mapPotentialBook[nCharId].PotentialList = {}
      self.mapPotentialBookBrief[nCharId] = {}
      
      local function addPotentialList(tbList)
        for _, v in pairs(tbList) do
          nAllCount = nAllCount + 1
        end
      end
      
      addPotentialList(line.MasterSpecificPotentialIds)
      addPotentialList(line.MasterNormalPotentialIds)
      addPotentialList(line.AssistSpecificPotentialIds)
      addPotentialList(line.AssistNormalPotentialIds)
      addPotentialList(line.CommonPotentialIds)
      self.mapPotentialBookBrief[nCharId].AllCount = nAllCount
      self.mapPotentialBookBrief[nCharId].Count = 0
      self.mapPotentialBookBrief[nCharId].Rarity = mapCharCfg.Grade
    end
  end
  
  ForEachTableLine(ConfigTable.Get("CharPotential"), foreachPotentialTableLine)
  
  local function foreachPotentialRewardTableLine(line)
    if self.mapPotentialQuest[line.CharId] == nil then
      self.mapPotentialQuest[line.CharId] = {}
    end
    self.mapPotentialQuest[line.CharId][line.Id] = {}
    self.mapPotentialQuest[line.CharId][line.Id].Status = AllEnum.BookQuestStatus.UnComplete
    local nAllProgress = 0
    local nParam = 0
    local sDesc = ""
    if line.Cond == GameEnum.towerBookPotentialCond.TowerBookCharPotentialQuantity then
      local params = decodeJson(line.Params)
      nParam = tonumber(params[1])
      nAllProgress = tonumber(params[2])
      local mapCharCfg = ConfigTable.GetData_Character(nParam)
      if mapCharCfg ~= nil and self.mapPotentialBookBrief[nParam] ~= nil then
        local nAllCount = self.mapPotentialBookBrief[nParam].AllCount
        if nAllProgress == nAllCount then
          sDesc = orderedFormat(ConfigTable.GetUIText("StarTower_Book_Potential_Quest_Desc_2"), mapCharCfg.Name)
        else
          sDesc = orderedFormat(ConfigTable.GetUIText("StarTower_Book_Potential_Quest_Desc_1"), mapCharCfg.Name, nAllProgress)
        end
      end
    end
    self.mapPotentialQuest[line.CharId][line.Id].Cond = line.Cond
    self.mapPotentialQuest[line.CharId][line.Id].Param = nParam
    self.mapPotentialQuest[line.CharId][line.Id].AllProgress = nAllProgress
    self.mapPotentialQuest[line.CharId][line.Id].CurProgress = 0
    local tbReward = {
      RewardId = line.ItemId,
      RewardCount = line.ItemQty
    }
    self.mapPotentialQuest[line.CharId][line.Id].Reward = tbReward
    self.mapPotentialQuest[line.CharId][line.Id].Desc = sDesc
  end
  
  ForEachTableLine(ConfigTable.Get("StarTowerBookPotentialReward"), foreachPotentialRewardTableLine)
  
  local function foreachFateCardTableLine(line)
    if not line.IsBanned then
      self.mapFateCardBook[line.Id] = {
        Sort = line.SortId,
        Status = AllEnum.FateCardBookStatus.Lock
      }
    end
  end
  
  ForEachTableLine(ConfigTable.Get("StarTowerBookFateCard"), foreachFateCardTableLine)
  
  local function foreachFateCardQuestTableLine(line)
    if self.mapFateCardQuest[line.BundleId] == nil then
      self.mapFateCardQuest[line.BundleId] = {}
    end
    self.mapFateCardQuest[line.BundleId][line.Id] = {
      Id = line.Id,
      Desc = UTILS.ParseParamDesc(line.Desc, line),
      Status = AllEnum.BookQuestStatus.UnComplete,
      CurProgress = 0,
      AllProgress = 0
    }
    local tbReward = {}
    for i = 1, 3 do
      if 0 < line["Tid" .. i] then
        table.insert(tbReward, {
          RewardId = line["Tid" .. i],
          RewardCount = line["Qty" .. i]
        })
      end
    end
    self.mapFateCardQuest[line.BundleId][line.Id].Reward = tbReward
    if line.FinishType == GameEnum.towerBookFateCardFinishType.FateCardCount then
      local param = decodeJson(line.FinishParams)
      self.mapFateCardQuest[line.BundleId][line.Id].AllProgress = tonumber(param[1])
    elseif line.FinishType == GameEnum.towerBookFateCardFinishType.FateCardCollect then
      local param = decodeJson(line.FinishParams)
      for _, id in ipairs(param) do
        self.mapFateCardQuest[line.BundleId][line.Id].AllProgress = self.mapFateCardQuest[line.BundleId][line.Id].AllProgress + 1
      end
    end
  end
  
  ForEachTableLine(ConfigTable.Get("StarTowerBookFateCardQuest"), foreachFateCardQuestTableLine)
end

function StarTowerBookData:CharPotentialBookChange(mapMsgData)
  for _, v in ipairs(mapMsgData.CharPotentials) do
    local nCharId = v.CharId
    local mapCharCfg = ConfigTable.GetData_Character(nCharId)
    local tbPotentials = v.Potentials
    if self.mapPotentialBook[nCharId] ~= nil then
      local mapPotentialList = self.mapPotentialBook[nCharId].PotentialList
      for _, v in ipairs(tbPotentials) do
        local nLastLevel = mapPotentialList[v.Id] or 0
        if nLastLevel == 0 and mapCharCfg ~= nil and mapCharCfg.Available then
          RedDotManager.SetValid(RedDotDefine.StarTowerBook_Potential_New, v.Id, true)
        end
        mapPotentialList[v.Id] = v.Level
      end
    end
  end
  self:RefreshPotentialQuest()
  for _, v in ipairs(mapMsgData.CharIds) do
    local mapCfg = ConfigTable.GetData_Character(v)
    if mapCfg ~= nil and mapCfg.Available then
      local nElement = mapCfg.EET
      RedDotManager.SetValid(RedDotDefine.StarTowerBook_Potential_Reward, {nElement, v}, true)
      RedDotManager.SetValid(RedDotDefine.StarTowerBook_Potential_Reward, {0, v}, true)
    end
  end
  EventManager.Hit("PotentialBookDataChange")
end

function StarTowerBookData:RefreshPotentialQuest()
  for nCharId, list in pairs(self.mapPotentialQuest) do
    if self.mapPotentialBook[nCharId] ~= nil and self.mapPotentialBook[nCharId].Init then
      local bCanReceive = false
      local nCharPotentialCount = 0
      for _, v in pairs(self.mapPotentialBook[nCharId].PotentialList) do
        nCharPotentialCount = nCharPotentialCount + 1
      end
      for nId, data in pairs(list) do
        if data.Status ~= AllEnum.BookQuestStatus.Received then
          if data.Cond == GameEnum.towerBookPotentialCond.TowerBookCharPotentialQuantity then
            if self.mapPotentialBookBrief[data.Param] ~= nil then
              self.mapPotentialQuest[nCharId][nId].CurProgress = nCharPotentialCount
              local nStatus = self.mapPotentialQuest[nCharId][nId].CurProgress >= self.mapPotentialQuest[nCharId][nId].AllProgress and AllEnum.BookQuestStatus.Complete or AllEnum.BookQuestStatus.UnComplete
              self.mapPotentialQuest[nCharId][nId].Status = nStatus
            else
              self.mapPotentialQuest[nCharId][nId].Status = AllEnum.BookQuestStatus.UnComplete
            end
          end
          if self.mapPotentialQuest[nCharId][nId].Status == AllEnum.BookQuestStatus.Complete then
            bCanReceive = true
          end
        end
      end
      local mapCfg = ConfigTable.GetData_Character(nCharId)
      if mapCfg ~= nil and mapCfg.Available then
        local nElement = mapCfg.EET
        RedDotManager.SetValid(RedDotDefine.StarTowerBook_Potential_Reward, {nElement, nCharId}, bCanReceive)
        RedDotManager.SetValid(RedDotDefine.StarTowerBook_Potential_Reward, {0, nCharId}, bCanReceive)
      end
    end
  end
end

function StarTowerBookData:GetCharPotentialBriefBook()
  local mapBrief = {}
  for nCharId, v in pairs(self.mapPotentialBookBrief) do
    local nUnlock = PlayerData.Char:CheckCharUnlock(nCharId) and 1 or 0
    local mapData = {
      nCharId = nCharId,
      nCount = v.Count or 0,
      nAllCount = v.AllCount,
      nUnlock = nUnlock,
      nRarity = v.Rarity
    }
    table.insert(mapBrief, mapData)
  end
  table.sort(mapBrief, function(a, b)
    if a.nUnlock == b.nUnlock then
      if a.nRarity == b.nRarity then
        return a.nCharId < b.nCharId
      end
      return a.nRarity < b.nRarity
    end
    return a.nUnlock > b.nUnlock
  end)
  return mapBrief
end

function StarTowerBookData:TryGetCharPotentialBook(nCharId, callback)
  if self.mapPotentialBook[nCharId] == nil or not self.mapPotentialBook[nCharId].Init then
    self:SendPotentialBookMsg(nCharId, callback)
  elseif callback ~= nil then
    callback()
  end
end

function StarTowerBookData:GetCharPotentialBook(nCharId)
  if self.mapPotentialBook[nCharId] ~= nil then
    return self.mapPotentialBook[nCharId].PotentialList
  end
end

function StarTowerBookData:GetAllCharPotential(nCharId)
  local mapAllPotential = {}
  local mapPotentialData = self:GetCharPotentialBook(nCharId)
  local mapCfg = ConfigTable.GetData("CharPotential", nCharId)
  if mapCfg ~= nil then
    local function funcSort(tbSort)
      table.sort(tbSort, function(a, b)
        local mapCfgA = ConfigTable.GetData_Item(a.nId)
        
        local mapCfgB = ConfigTable.GetData_Item(b.nId)
        if mapCfgA ~= nil and mapCfgB ~= nil then
          if mapCfgA.Rarity == mapCfgB.Rarity then
            return a.nId < b.nId
          end
          return mapCfgA.Rarity < mapCfgB.Rarity
        end
        return a.nId < b.nId
      end)
    end
    
    mapAllPotential.MasterSpecificIds = {}
    for _, v in pairs(mapCfg.MasterSpecificPotentialIds) do
      table.insert(mapAllPotential.MasterSpecificIds, {
        nId = v,
        nLevel = mapPotentialData[v] or 0,
        nSpecial = 1
      })
    end
    funcSort(mapAllPotential.MasterSpecificIds)
    mapAllPotential.MasterNormalIds = {}
    for _, v in pairs(mapCfg.MasterNormalPotentialIds) do
      table.insert(mapAllPotential.MasterNormalIds, {
        nId = v,
        nLevel = mapPotentialData[v] or 0,
        nSpecial = 0
      })
    end
    mapAllPotential.AssistSpecificIds = {}
    for _, v in pairs(mapCfg.AssistSpecificPotentialIds) do
      table.insert(mapAllPotential.AssistSpecificIds, {
        nId = v,
        nLevel = mapPotentialData[v] or 0,
        nSpecial = 1
      })
    end
    funcSort(mapAllPotential.AssistSpecificIds)
    mapAllPotential.AssistNormalIds = {}
    for _, v in pairs(mapCfg.AssistNormalPotentialIds) do
      table.insert(mapAllPotential.AssistNormalIds, {
        nId = v,
        nLevel = mapPotentialData[v] or 0,
        nSpecial = 0
      })
    end
    for _, v in pairs(mapCfg.CommonPotentialIds) do
      table.insert(mapAllPotential.MasterNormalIds, {
        nId = v,
        nLevel = mapPotentialData[v] or 0,
        nSpecial = 0
      })
      table.insert(mapAllPotential.AssistNormalIds, {
        nId = v,
        nLevel = mapPotentialData[v] or 0,
        nSpecial = 0
      })
    end
    funcSort(mapAllPotential.MasterNormalIds)
    funcSort(mapAllPotential.AssistNormalIds)
  end
  return mapAllPotential
end

function StarTowerBookData:GetCharPotentialQuest(nCharId)
  if self.mapPotentialQuest[nCharId] ~= nil then
    return self.mapPotentialQuest[nCharId]
  end
end

function StarTowerBookData:GetCharPotentialCount(nCharId)
  if self.mapPotentialBookBrief[nCharId] == nil then
    return 0, 0
  end
  if self.mapPotentialBook[nCharId] == nil or not self.mapPotentialBook[nCharId].Init then
    return self.mapPotentialBookBrief[nCharId].Count, self.mapPotentialBookBrief[nCharId].AllCount
  end
  local nCount = 0
  for _, v in pairs(self.mapPotentialBook[nCharId].PotentialList) do
    nCount = nCount + 1
  end
  return nCount, self.mapPotentialBookBrief[nCharId].AllCount
end

function StarTowerBookData:TryGetFateCardBook(callback)
  if not self.bFateCardInit then
    self:SendGetFateCardBookMsg(callback)
  elseif callback ~= nil then
    callback()
  end
end

function StarTowerBookData:CheckFateCardBundleUnlock(nBundleId)
  local nWorldClass = PlayerData.Base:GetWorldClass()
  local mapCfg = ConfigTable.GetData("StarTowerBookFateCardBundle", nBundleId)
  if mapCfg ~= nil then
    local bWorldClass = mapCfg.WorldClass == 0 and true or nWorldClass >= mapCfg.WorldClass
    local bStarTower = mapCfg.StarTowerId == 0 and true or PlayerData.StarTower:CheckPassedId(mapCfg.StarTowerId)
    local bCollect = true
    for _, v in pairs(mapCfg.CollectCards) do
      bCollect = bCollect and self.mapFateCardBook[v].Status == AllEnum.FateCardBookStatus.Collect
      if not bCollect then
        break
      end
    end
    local bUnlock = true
    for _, v in pairs(mapCfg.UnlockCards) do
      bUnlock = bUnlock and self.mapFateCardBook[v].Status ~= AllEnum.FateCardBookStatus.Lock
      if not bUnlock then
        break
      end
    end
    if bWorldClass and bStarTower and bCollect and bUnlock then
      return true
    end
  end
  return false
end

function StarTowerBookData:CheckFateCardUnLock(nId)
  local nWorldClass = PlayerData.Base:GetWorldClass()
  local mapCfg = ConfigTable.GetData("StarTowerBookFateCard", nId)
  if mapCfg ~= nil then
    local bBundleUnlock = self:CheckFateCardBundleUnlock(mapCfg.BundleId)
    if not bBundleUnlock then
      return false
    end
    local bWorldClass = mapCfg.WorldClass == 0 and true or nWorldClass >= mapCfg.WorldClass
    local bStarTower = mapCfg.StarTowerId == 0 and true or PlayerData.StarTower:CheckPassedId(mapCfg.StarTowerId)
    local bCollect = true
    for _, v in pairs(mapCfg.CollectCards) do
      bCollect = bCollect and self.mapFateCardBook[v].Status == AllEnum.FateCardBookStatus.Collect
      if not bCollect then
        break
      end
    end
    local bUnlock = true
    for _, v in pairs(mapCfg.UnlockCards) do
      bUnlock = bUnlock and self.mapFateCardBook[v].Status ~= AllEnum.FateCardBookStatus.Lock
      if not bUnlock then
        break
      end
    end
    if bWorldClass and bStarTower and bCollect and bUnlock then
      return true
    end
  end
  return false
end

function StarTowerBookData:UpdateFateCardStatus()
  local mapFateCardLock = {}
  for nId, v in pairs(self.mapFateCardBook) do
    if v.Status == AllEnum.FateCardBookStatus.Lock then
      table.insert(mapFateCardLock, nId)
    end
  end
  
  local function check(tbLock)
    local tempUnlock = {}
    local tempLock = {}
    for _, nId in ipairs(tbLock) do
      if self:CheckFateCardUnLock(nId) then
        self.mapFateCardBook[nId].Status = AllEnum.FateCardBookStatus.UnLock
        table.insert(tempUnlock, nId)
      else
        table.insert(tempLock, nId)
      end
    end
    if #tempUnlock == 0 then
      return
    else
      check(tempLock)
    end
  end
  
  check(mapFateCardLock)
  self:UpdateFateCardQuest()
end

function StarTowerBookData:UpdateFateCardQuest()
  local nCollectCount = 0
  local tbBundleCollect = {}
  for nId, v in pairs(self.mapFateCardBook) do
    if v.Status == AllEnum.FateCardBookStatus.Collect then
      nCollectCount = nCollectCount + 1
      local mapCfg = ConfigTable.GetData("StarTowerBookFateCard", nId)
      if mapCfg ~= nil then
        local nBundleId = mapCfg.BundleId
        if tbBundleCollect[nBundleId] == nil then
          tbBundleCollect[nBundleId] = 0
        end
        tbBundleCollect[nBundleId] = tbBundleCollect[nBundleId] + 1
      end
    end
  end
  for nBundleId, list in pairs(self.mapFateCardQuest) do
    for nId, data in pairs(list) do
      if data.Status == AllEnum.BookQuestStatus.UnComplete then
        local mapCfg = ConfigTable.GetData("StarTowerBookFateCardQuest", nId)
        if mapCfg ~= nil then
          if mapCfg.FinishType == GameEnum.towerBookFateCardFinishType.FateCardCount then
            local param = decodeJson(mapCfg.FinishParams)
            local nBundleParam = 0
            if 1 < #param and param[2] ~= 0 then
              nBundleParam = param[2]
            end
            if nBundleParam == 0 then
              self.mapFateCardQuest[nBundleId][nId].CurProgress = nCollectCount
            else
              self.mapFateCardQuest[nBundleId][nId].CurProgress = tbBundleCollect[nBundleParam] or 0
            end
            if self.mapFateCardQuest[nBundleId][nId].CurProgress >= self.mapFateCardQuest[nBundleId][nId].AllProgress then
              self.mapFateCardQuest[nBundleId][nId].Status = AllEnum.BookQuestStatus.Complete
            end
          elseif mapCfg.FinishType == GameEnum.towerBookFateCardFinishType.FateCardCollect then
            local param = decodeJson(mapCfg.FinishParams)
            local bCollect = true
            local nProgress = 0
            for _, id in ipairs(param) do
              if self.mapFateCardBook[id].Status ~= AllEnum.FateCardBookStatus.Collect then
                bCollect = false
              else
                nProgress = nProgress + 1
              end
            end
            self.mapFateCardQuest[nBundleId][nId].CurProgress = nProgress
            if bCollect then
              self.mapFateCardQuest[nBundleId][nId].Status = AllEnum.BookQuestStatus.Complete
            end
          end
        end
      end
    end
  end
end

function StarTowerBookData:RefreshFateCardRedDot()
  for nBundleId, list in pairs(self.mapFateCardQuest) do
    local bCanReceive = false
    for _, data in pairs(list) do
      if data.Status == AllEnum.BookQuestStatus.Complete then
        bCanReceive = true
        break
      end
    end
    RedDotManager.SetValid(RedDotDefine.StarTowerBook_FateCard_Reward, nBundleId, bCanReceive)
  end
end

function StarTowerBookData:FateCardBookChange(mapMsgData)
  for _, v in ipairs(mapMsgData.Cards) do
    if nil ~= self.mapFateCardBook[v] then
      self.mapFateCardBook[v].Status = AllEnum.FateCardBookStatus.Collect
      RedDotManager.SetValid(RedDotDefine.StarTowerBook_FateCard_New, v, true)
    end
  end
  self:UpdateFateCardStatus()
  self:RefreshFateCardRedDot()
end

function StarTowerBookData:FateCardBookRewardChange(mapMsgData)
  if mapMsgData.Option then
    for _, v in ipairs(mapMsgData.List) do
      RedDotManager.SetValid(RedDotDefine.StarTowerBook_FateCard_Reward, v, true)
    end
  else
    for _, v in ipairs(mapMsgData.List) do
      RedDotManager.SetValid(RedDotDefine.StarTowerBook_FateCard_Reward, v, false)
    end
  end
end

function StarTowerBookData:GetFateCardBundleQuest(nBundleId)
  local mapQuest = {}
  if self.mapFateCardQuest[nBundleId] ~= nil then
    for nId, data in pairs(self.mapFateCardQuest[nBundleId]) do
      data.Id = nId
      table.insert(mapQuest, data)
    end
  end
  return mapQuest
end

function StarTowerBookData:GetAllFateCardBundle()
  local mapBundle = {}
  
  local function foreachTableLine(line)
    mapBundle[line.Id] = {
      nSort = line.SortId,
      tbCardList = {}
    }
  end
  
  ForEachTableLine(DataTable.StarTowerBookFateCardBundle, foreachTableLine)
  for nId, v in pairs(self.mapFateCardBook) do
    local mapCfg = ConfigTable.GetData("StarTowerBookFateCard", nId)
    if mapCfg ~= nil then
      local nBundleId = mapCfg.BundleId
      if mapBundle[nBundleId] ~= nil then
        table.insert(mapBundle[nBundleId].tbCardList, {
          nId = nId,
          nStatus = v.Status,
          nSort = v.Sort
        })
      end
    end
  end
  return mapBundle
end

function StarTowerBookData:GetAllEventBookData()
  local mapEventBook = {}
  local mapQuestData = PlayerData.Quest:GetStarTowerBookQuestData()
  
  local function foreachEventRewardTableLine(line)
    if not line.IsBanned then
      local tbData = {}
      tbData.Id = line.Id
      tbData.Status = mapQuestData[line.Id] ~= nil and MAPSTATUS[mapQuestData[line.Id].nStatus] or AllEnum.BookQuestStatus.Received
      tbData.CfgData = line
      tbData.nGoal = mapQuestData[line.Id] ~= nil and mapQuestData[line.Id].nGoal or 0
      tbData.nCurProgress = mapQuestData[line.Id] ~= nil and mapQuestData[line.Id].nCurProgress or 0
      table.insert(mapEventBook, tbData)
    end
  end
  
  ForEachTableLine(ConfigTable.Get("StarTowerBookEventReward"), foreachEventRewardTableLine)
  table.sort(mapEventBook, function(a, b)
    if a.CfgData.Sort == b.CfgData.Sort then
      return a.CfgData.Id < b.CfgData.Id
    end
    return a.CfgData.Sort < b.CfgData.Sort
  end)
  return mapEventBook
end

function StarTowerBookData:GetRandomEntranceCfg()
  local nIndex = math.random(1, #self.mapEntranceCfg)
  return self.mapEntranceCfg[nIndex]
end

function StarTowerBookData:UpdateServerRedDot(msgData)
  for _, v in ipairs(msgData.CharIds) do
    local mapCfg = ConfigTable.GetData_Character(v)
    if mapCfg ~= nil and mapCfg.Available then
      local nElement = mapCfg.EET
      RedDotManager.SetValid(RedDotDefine.StarTowerBook_Potential_Reward, {nElement, v}, true)
      RedDotManager.SetValid(RedDotDefine.StarTowerBook_Potential_Reward, {0, v}, true)
    end
  end
  for _, v in ipairs(msgData.Bundles) do
    RedDotManager.SetValid(RedDotDefine.StarTowerBook_FateCard_Reward, v, true)
  end
end

function StarTowerBookData:SendPotentialBriefListMsg(callback)
  local function sucCall(_, mapMsgData)
    if mapMsgData.Infos ~= nil then
      for _, v in ipairs(mapMsgData.Infos) do
        local nCharId = v.CharId
        
        if nil ~= self.mapPotentialBookBrief[nCharId] then
          self.mapPotentialBookBrief[nCharId].Count = v.Count
        end
      end
    end
    if callback ~= nil then
      callback()
    end
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.star_tower_book_potential_brief_list_get_req, {}, nil, sucCall)
end

function StarTowerBookData:SendPotentialBookMsg(nCharId, callback)
  local function sucCall(_, mapMsgData)
    if mapMsgData.Potentials ~= nil then
      if nil == self.mapPotentialBook[nCharId] then
        self.mapPotentialBook[nCharId] = {}
      end
      self.mapPotentialBook[nCharId].Init = true
      for _, v in ipairs(mapMsgData.Potentials) do
        self.mapPotentialBook[nCharId].PotentialList[v.Id] = v.Level
      end
    end
    if mapMsgData.ReceivedIds ~= nil then
      for _, v in ipairs(mapMsgData.ReceivedIds) do
        local mapCfg = ConfigTable.GetData("StarTowerBookPotentialReward", v)
        if mapCfg ~= nil and self.mapPotentialQuest[mapCfg.CharId] ~= nil then
          self.mapPotentialQuest[mapCfg.CharId][v].Status = AllEnum.BookQuestStatus.Received
        end
      end
    end
    self:RefreshPotentialQuest()
    if callback ~= nil then
      callback()
    end
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.star_tower_book_char_potential_get_req, {Value = nCharId}, nil, sucCall)
end

function StarTowerBookData:SendReceivePotentialRewardMsg(nCharId, callback)
  local function sucCall(_, mapMsgData)
    for _, v in ipairs(mapMsgData.ReceivedIds) do
      local mapCfg = ConfigTable.GetData("StarTowerBookPotentialReward", v)
      
      if mapCfg ~= nil and self.mapPotentialQuest[mapCfg.CharId] ~= nil then
        self.mapPotentialQuest[mapCfg.CharId][v].Status = AllEnum.BookQuestStatus.Received
      end
    end
    local mapCharCfg = ConfigTable.GetData_Character(nCharId)
    if mapCharCfg ~= nil and mapCharCfg.Available then
      RedDotManager.SetValid(RedDotDefine.StarTowerBook_Potential_Reward, {
        mapCharCfg.EET,
        nCharId
      }, false)
      RedDotManager.SetValid(RedDotDefine.StarTowerBook_Potential_Reward, {0, nCharId}, false)
    end
    EventManager.Hit("ReceivePotentialBookReward")
    UTILS.OpenReceiveByChangeInfo(mapMsgData.Change, callback)
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.star_tower_book_potential_reward_receive_req, {Value = nCharId}, nil, sucCall)
end

function StarTowerBookData:SendReceiveAllPotentialRewardMsg(callback)
  local function sucCall(_, mapMsgData)
    for _, v in ipairs(mapMsgData.ReceivedIds) do
      local mapCfg = ConfigTable.GetData("StarTowerBookPotentialReward", v)
      
      if mapCfg ~= nil and self.mapPotentialQuest[mapCfg.CharId] ~= nil then
        self.mapPotentialQuest[mapCfg.CharId][v].Status = AllEnum.BookQuestStatus.Received
      end
    end
    local tbCharHave = PlayerData.Char:GetCharIdList()
    for k, v in pairs(tbCharHave) do
      local nCharId = v.nId
      local mapCharCfg = ConfigTable.GetData_Character(nCharId)
      if mapCharCfg ~= nil and mapCharCfg.Available then
        RedDotManager.SetValid(RedDotDefine.StarTowerBook_Potential_Reward, {
          mapCharCfg.EET,
          nCharId
        }, false)
        RedDotManager.SetValid(RedDotDefine.StarTowerBook_Potential_Reward, {0, nCharId}, false)
      end
    end
    EventManager.Hit("ReceivePotentialBookReward")
    UTILS.OpenReceiveByChangeInfo(mapMsgData.Change, callback)
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.star_tower_book_potential_reward_receive_req, {Value = 0}, nil, sucCall)
end

function StarTowerBookData:SendGetFateCardBookMsg(callback)
  local function sucCall(_, mapMsgData)
    self.bFateCardInit = true
    
    for _, v in ipairs(mapMsgData.Cards) do
      if nil ~= self.mapFateCardBook[v] then
        self.mapFateCardBook[v].Status = AllEnum.FateCardBookStatus.Collect
      end
    end
    self:UpdateFateCardStatus()
    for _, v in ipairs(mapMsgData.Quests) do
      local mapCfg = ConfigTable.GetData("StarTowerBookFateCardQuest", v)
      if mapCfg ~= nil then
        local nBundleId = mapCfg.BundleId
        if self.mapFateCardQuest[nBundleId] ~= nil then
          self.mapFateCardQuest[nBundleId][v].Status = AllEnum.BookQuestStatus.Received
          RedDotManager.SetValid(RedDotDefine.StarTowerBook_FateCard_Reward, nBundleId, false)
        end
      end
    end
    self:RefreshFateCardRedDot()
    if callback ~= nil then
      callback()
    end
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.tower_book_fate_card_detail_req, {}, nil, sucCall)
end

function StarTowerBookData:SendReceiveFateCardRewardMsg(nBundleId, nQuestId, callback)
  local function sucCall(_, mapMsgData)
    if self.mapFateCardQuest[nBundleId] ~= nil then
      for nId, v in pairs(self.mapFateCardQuest[nBundleId]) do
        if v.Status == AllEnum.BookQuestStatus.Complete then
          self.mapFateCardQuest[nBundleId][nId].Status = AllEnum.BookQuestStatus.Received
        end
      end
    end
    RedDotManager.SetValid(RedDotDefine.StarTowerBook_FateCard_Reward, nBundleId, false)
    EventManager.Hit("ReceiveFateCardBookReward")
    UTILS.OpenReceiveByChangeInfo(mapMsgData, callback)
  end
  
  local msgData = {
    CardBundleId = nBundleId,
    QuestId = nQuestId or 0
  }
  HttpNetHandler.SendMsg(NetMsgId.Id.tower_book_fate_card_reward_receive_req, msgData, nil, sucCall)
end

function StarTowerBookData:SendReceiveFateCardAllRewardMsg(callback)
  local function sucCall(_, mapMsgData)
    local tbFateCardBundleList = PlayerData.StarTowerBook:GetAllFateCardBundle()
    
    for nBundleId, _ in pairs(tbFateCardBundleList) do
      if self.mapFateCardQuest[nBundleId] ~= nil then
        for nId, v in pairs(self.mapFateCardQuest[nBundleId]) do
          if v.Status == AllEnum.BookQuestStatus.Complete then
            self.mapFateCardQuest[nBundleId][nId].Status = AllEnum.BookQuestStatus.Received
          end
        end
      end
      RedDotManager.SetValid(RedDotDefine.StarTowerBook_FateCard_Reward, nBundleId, false)
    end
    EventManager.Hit("ReceiveFateCardBookReward")
    UTILS.OpenReceiveByChangeInfo(mapMsgData, callback)
  end
  
  local msgData = {CardBundleId = 0, QuestId = 0}
  HttpNetHandler.SendMsg(NetMsgId.Id.tower_book_fate_card_reward_receive_req, msgData, nil, sucCall)
end

function StarTowerBookData:OnEvent_UpdateWorldClass()
end

function StarTowerBookData:OnEvent_StarTowerPass()
end

return StarTowerBookData
