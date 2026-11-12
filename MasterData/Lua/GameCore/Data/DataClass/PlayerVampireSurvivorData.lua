local PlayerVampireSurvivorData = class("PlayerVampireSurvivorData")
local mapDropId = {
  [GameEnum.dropEntityType.HP] = 106,
  [GameEnum.dropEntityType.MP] = 107,
  [GameEnum.dropEntityType.ATK] = 108,
  [GameEnum.dropEntityType.VampireClear] = 109,
  [GameEnum.dropEntityType.VampireGet] = 110
}

function PlayerVampireSurvivorData:Init()
  self.tbPassedId = {}
  self.mapRecord = {}
  self.mapScore = {}
  self.mapRecordSeason = {}
  self.bInitTalent = false
  self.mapActiveTalent = {}
  self.nFateCardCount = 0
  self.nTalentPoints = 0
  self.nTalentResetTime = 0
  self.nSeasonScore = 0
  self.nCurSeasonId = 0
  self.nTalentPointMax = 0
  self.ObtainCount = 0
  self.bFirstIn = true
  self.bSuccessBattle = false
  local mapQuestGroup = {}
  
  local function forEachTableLine(mapData)
    if mapQuestGroup[mapData.GroupId] == nil then
      mapQuestGroup[mapData.GroupId] = {}
    end
    table.insert(mapQuestGroup[mapData.GroupId], mapData.Id)
  end
  
  ForEachTableLine(DataTable.VampireSurvivorQuest, forEachTableLine)
  
  local function forEachTalent(mapData)
    self.nTalentPointMax = self.nTalentPointMax + mapData.Point
  end
  
  ForEachTableLine(DataTable.VampireTalent, forEachTalent)
  for _, tbId in pairs(mapQuestGroup) do
    table.sort(tbId)
  end
  CacheTable.Set("_VampireQuestGroup", mapQuestGroup)
  EventManager.Add(EventId.IsNewDay, self, self.OnEvent_NewDay)
end

function PlayerVampireSurvivorData:UnInit()
  self.tbPassedId = {}
  self.mapRecord = {}
  self.mapRecordSeason = {}
  EventManager.Remove(EventId.IsNewDay, self, self.OnEvent_NewDay)
end

function PlayerVampireSurvivorData:EnterVampireSurvivor(nLevelId, nBuildId1, nBuildId2)
  local function NetCallback(_, netMsg)
    local luaClass = require("Game.Adventure.VampireSurvivor.VampireSurvivorLevelData")
    
    if luaClass == nil then
      return
    end
    self.curLevel = luaClass
    if type(self.curLevel.BindEvent) == "function" then
      self.curLevel:BindEvent()
    end
    if type(self.curLevel.Init) == "function" then
      self.curLevel:Init(self, nLevelId, nBuildId1, nBuildId2, netMsg.Events, netMsg.Reward, netMsg.Select)
    end
  end
  
  local Builds = {
    {
      Type = PlayerData.Build:IsUseTrialRuntime(nBuildId1) and 2 or 1,
      BuildId = nBuildId1
    }
  }
  if 0 < nBuildId2 then
    table.insert(Builds, {
      Type = PlayerData.Build:IsUseTrialRuntime(nBuildId2) and 2 or 1,
      BuildId = nBuildId2
    })
  end
  local msg = {Id = nLevelId, Builds = Builds}
  HttpNetHandler.SendMsg(NetMsgId.Id.vampire_survivor_apply_req, msg, nil, NetCallback)
end

function PlayerVampireSurvivorData:ReEnterVampireSurvivor(nVampireId)
  local function NetCallback(_, netMsg)
    local luaClass = require("Game.Adventure.VampireSurvivor.VampireSurvivorLevelData")
    
    if luaClass == nil then
      return
    end
    self.curLevel = luaClass
    if type(self.curLevel.BindEvent) == "function" then
      self.curLevel:BindEvent()
    end
    local nBuildId1 = 0
    local nBuildId2 = 0
    local mapSceneFirst
    for _, mapScene in ipairs(netMsg.Scenes) do
      if mapScene.SceneType == 2 and mapScene.Build ~= nil then
        nBuildId2 = mapScene.Build.BuildId or 0
      end
      if mapScene.SceneType == 1 then
        if mapScene.Build ~= nil then
          nBuildId1 = mapScene.Build.BuildId or 0
        end
        mapSceneFirst = mapScene
      end
    end
    if mapSceneFirst == nil then
      return
    end
    
    local function GetAllBuildCallback(tbBuildData, mapAllBuild)
      if mapAllBuild[nBuildId2] == nil then
        local function netMsgCallback(_, msgData)
          local mapVampireCfgData = ConfigTable.GetData("VampireSurvivor", nVampireId)
          
          if mapVampireCfgData ~= nil and mapVampireCfgData.Type == GameEnum.vampireSurvivorType.Turn then
            PlayerData.VampireSurvivor:AddPointAndLevel(msgData.Defeat.FinalScore, 0, msgData.Defeat.SeasonId)
          end
          PlayerData.VampireSurvivor:CacheScoreByLevel(nVampireId, msgData.Defeat.FinalScore)
          EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("VampireReconnnect_Abandon"))
        end
        
        local msg = {
          KillCount = {
            0,
            0,
            0,
            0,
            0,
            0,
            0,
            0,
            0,
            0
          },
          Time = 0,
          Defeat = true,
          Events = {
            List = {}
          }
        }
        HttpNetHandler.SendMsg(NetMsgId.Id.vampire_survivor_settle_req, msg, nil, netMsgCallback)
        EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("VampireReConnect_BuildDeleted"))
      elseif type(self.curLevel.Init) == "function" then
        self.curLevel:InitReEnter(self, netMsg.Id, nBuildId1, nBuildId2, netMsg.Events, netMsg.Reward, netMsg.FateCardIds, netMsg.ClientData, mapSceneFirst)
      end
    end
    
    PlayerData.Build:GetSelectableBuildBriefData(GetAllBuildCallback, AllEnum.RegionBossFormationType.Vampire)
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.vampire_survivor_info_req, {}, nil, NetCallback)
end

function PlayerVampireSurvivorData:EnterVampireEditor(floorId, tbChar, isFirstHalf, tbDisc, tbNote)
  local floorData = ConfigTable.GetData("VampireFloor", floorId)
  if floorData == nil then
    printError("吸血鬼floorData 为空,floor id === " .. floorId)
    return
  end
  local luaClass = require("Game.Editor.VampireSurvivor.VampireSurvivorEditor")
  if luaClass == nil then
    return
  end
  self.curLevel = luaClass
  if type(self.curLevel.BindEvent) == "function" then
    self.curLevel:BindEvent()
  end
  if type(self.curLevel.Init) == "function" then
    self.curLevel:Init(self, floorId, tbChar, isFirstHalf, tbDisc, tbNote)
  end
end

function PlayerVampireSurvivorData:GetFloorBuff(floorId, isFirstHalf)
  local floorData = ConfigTable.GetData("VampireFloor", floorId)
  if isFirstHalf then
    return floorData.FHAffixId
  else
    return floorData.SHAffixId
  end
end

function PlayerVampireSurvivorData:LevelEnd()
  if self.curLevel == nil then
    return
  else
    if type(self.curLevel.UnBindEvent) == "function" then
      self.curLevel:UnBindEvent()
    end
    self.curLevel = nil
  end
end

function PlayerVampireSurvivorData:CacheLevelData(mapData)
  if mapData == nil then
    return
  end
  self.tbPassedId = {}
  for _, mapRecord in ipairs(mapData.Records) do
    self.mapRecord[mapRecord.Id] = mapRecord.BuildIds
    self.mapScore[mapRecord.Id] = mapRecord.Score
    if mapRecord.Passed then
      table.insert(self.tbPassedId, mapRecord.Id)
    end
  end
  self.mapRecordSeason = mapData.Season
  self.nSeasonScore = mapData.SeasonScore
end

function PlayerVampireSurvivorData:GetCachedBuildId(nLevelId)
  local mapVampireCfgData = ConfigTable.GetData("VampireSurvivor", nLevelId)
  local bSeason = false
  if mapVampireCfgData ~= nil then
    bSeason = mapVampireCfgData.Type == GameEnum.vampireSurvivorType.Turn
  end
  if bSeason then
    return self.mapRecordSeason.BuildIds
  end
  if self.mapRecord[nLevelId] == nil then
    return nil
  else
    return self.mapRecord[nLevelId]
  end
end

function PlayerVampireSurvivorData:CacheSelectedBuildId(nLevelId, nIdx, nBuildId)
  if nIdx == 0 then
    printError("索引为0！")
    return
  end
  local mapVampireCfgData = ConfigTable.GetData("VampireSurvivor", nLevelId)
  local bSeason = false
  if mapVampireCfgData ~= nil then
    bSeason = mapVampireCfgData.Type == GameEnum.vampireSurvivorType.Turn
  end
  if bSeason then
    if self.mapRecordSeason == nil then
      self.mapRecordSeason = {}
    end
    if self.mapRecordSeason.BuildIds == nil then
      self.mapRecordSeason.BuildIds = {}
      self.mapRecordSeason.BuildIds[nIdx] = nBuildId
      self.mapRecordSeason.BuildIds[2 / nIdx] = 0
    else
      self.mapRecordSeason.BuildIds[nIdx] = nBuildId
    end
    EventManager.Hit("VampireSurvivorChangeBuild")
    return
  end
  if self.mapRecord[nLevelId] == nil then
    self.mapRecord[nLevelId] = {}
    self.mapRecord[nLevelId][nIdx] = nBuildId
    self.mapRecord[nLevelId][2 / nIdx] = 0
  else
    self.mapRecord[nLevelId][nIdx] = nBuildId
  end
  EventManager.Hit("VampireSurvivorChangeBuild")
end

function PlayerVampireSurvivorData:ExchangeBuild(nLevelId)
  local mapVampireCfgData = ConfigTable.GetData("VampireSurvivor", nLevelId)
  local bSeason = false
  if mapVampireCfgData ~= nil then
    bSeason = mapVampireCfgData.Type == GameEnum.vampireSurvivorType.Turn
  end
  if bSeason then
    if self.mapRecordSeason == nil then
      self.mapRecordSeason = {}
    end
    if self.mapRecordSeason.BuildIds == nil then
      self.mapRecordSeason.BuildIds = {0, 0}
    else
      local temp = self.mapRecordSeason.BuildIds[1]
      self.mapRecordSeason.BuildIds[1] = self.mapRecordSeason.BuildIds[2] == nil and 0 or self.mapRecordSeason.BuildIds[2]
      self.mapRecordSeason.BuildIds[2] = temp
    end
  elseif self.mapRecord[nLevelId] == nil then
    self.mapRecord[nLevelId] = {0, 0}
  else
    local temp = self.mapRecord[nLevelId][1]
    self.mapRecord[nLevelId][1] = self.mapRecord[nLevelId][2] == nil and 0 or self.mapRecord[nLevelId][2]
    self.mapRecord[nLevelId][2] = temp
  end
  EventManager.Hit("VampireSurvivorChangeBuild")
end

function PlayerVampireSurvivorData:CheckLevelUnlock(nLevelId)
  local mapLevelData = ConfigTable.GetData("VampireSurvivor", nLevelId)
  if mapLevelData == nil then
    return true
  end
  local nNeedWorldClass = mapLevelData.NeedWorldClass
  local nCurWorldClass = PlayerData.Base:GetWorldClass()
  if nNeedWorldClass > nCurWorldClass then
    return false, 1, nNeedWorldClass
  end
  local prev = mapLevelData.PreLevelId
  if 0 < prev and 1 > table.indexof(self.tbPassedId, prev) then
    local mapLevelDataPrev = ConfigTable.GetData("VampireSurvivor", prev)
    local sName = ""
    if mapLevelDataPrev ~= nil then
      sName = mapLevelDataPrev.Name
    end
    return false, 2, sName
  end
  return true
end

function PlayerVampireSurvivorData:GetTalentData()
  local function GetTalentCallback(_, mapData)
    self:CacheTalentData(mapData)
    
    self.bInitTalent = true
    EventManager.Hit("GetTalentDataVampire", true)
  end
  
  if self.bInitTalent then
    return self.mapActiveTalent, self.nTalentPoints, self.nTalentResetTime
  end
  HttpNetHandler.SendMsg(NetMsgId.Id.vampire_talent_detail_req, {}, nil, GetTalentCallback)
  return nil
end

function PlayerVampireSurvivorData:GetActivedTalent()
  local ret = {}
  if not self.bInitTalent then
    printError("TalentData not init!")
    return ret
  end
  for nTalentId, bActive in pairs(self.mapActiveTalent) do
    if bActive then
      table.insert(ret, nTalentId)
    end
  end
  return ret
end

function PlayerVampireSurvivorData:ResetTalent(callback)
  local function msgCallback(_, msgData)
    local curTime = CS.ClientManager.Instance.serverTimeStamp
    
    self.nTalentResetTime = curTime + tonumber(ConfigTable.GetConfigValue("VampireTalentResetTimeInterval"))
    self.mapActiveTalent = {}
    if callback ~= nil and type(callback) == "function" then
      callback()
    end
  end
  
  local curTime = CS.ClientManager.Instance.serverTimeStamp
  local tbActivedTalent = self:GetActivedTalent()
  if #tbActivedTalent == 0 then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("VampireTalent_NoTalent"))
    return
  end
  if curTime > self.nTalentResetTime then
    HttpNetHandler.SendMsg(NetMsgId.Id.vampire_talent_reset_req, {}, nil, msgCallback)
  else
    EventManager.Hit(EventId.OpenMessageBox, orderedFormat(ConfigTable.GetUIText("VampireTalent_ResetTime"), self.nTalentResetTime - curTime))
  end
end

function PlayerVampireSurvivorData:ActiveTalent(nTalentId, callback)
  local function msgCallback(_, msgData)
    self.mapActiveTalent[nTalentId] = true
    
    self.nTalentPoints = self:CalTalentPoint(self.mapActiveTalent, self.nFateCardCount)
    RedDotManager.SetValid(RedDotDefine.VampireTalent, nil, self:CheckCanAciveTalent())
    if callback ~= nil and type(callback) == "function" then
      callback(nTalentId)
    end
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.vampire_talent_unlock_req, {Value = nTalentId}, nil, msgCallback)
end

function PlayerVampireSurvivorData:GetActivedTalentEft()
  local tbActivedTalent = self:GetActivedTalent()
  local ret = {}
  for _, nTalentId in ipairs(tbActivedTalent) do
    local talentData = ConfigTable.GetData("VampireTalent", nTalentId)
    if talentData ~= nil and talentData.EffectId ~= 0 then
      table.insert(ret, talentData.EffectId)
    end
  end
  return ret
end

function PlayerVampireSurvivorData:GetActivedDropItem()
  local tbActivedTalent = self:GetActivedTalent()
  local tbActived = {}
  local mapPropData = {}
  local ret = {}
  for _, nTalentId in ipairs(tbActivedTalent) do
    local talentData = ConfigTable.GetData("VampireTalent", nTalentId)
    if talentData ~= nil then
      if talentData.Effect == GameEnum.vampireTalentEffect.ActiveDrop then
        local tbParam = decodeJson(talentData.Params)
        if tbParam ~= nil then
          if table.indexof(tbActived, tbParam[1]) < 1 then
            table.insert(tbActived, tbParam[1])
          end
          local nType = tonumber(tbParam[1])
          if nType ~= nil then
            if mapPropData[nType] == nil then
              mapPropData[nType] = {
                nProb = 0,
                nGrowth = 0,
                nMaxCount = 0
              }
            end
            local nParam1 = tonumber(tbParam[2])
            mapPropData[nType].nProb = math.max(mapPropData[nType].nProb, nParam1 == nil and 0 or nParam1)
            local nParam2 = tonumber(tbParam[3])
            mapPropData[nType].nGrowth = math.max(mapPropData[nType].nGrowth, nParam2 == nil and 0 or nParam2)
            local nParam3 = tonumber(tbParam[4])
            mapPropData[nType].nMaxCount = math.max(mapPropData[nType].nMaxCount, nParam3 == nil and 0 or nParam3)
          end
        end
      elseif talentData.Effect == GameEnum.vampireTalentEffect.DropItemPropUp then
        local tbParam = decodeJson(talentData.Params)
        if tbParam ~= nil then
          local nType = tonumber(tbParam[1])
          if nType ~= nil then
            if mapPropData[nType] == nil then
              mapPropData[nType] = {
                nProb = 0,
                nGrowth = 0,
                nMaxCount = 0
              }
            end
            local nParam1 = tonumber(tbParam[2])
            mapPropData[nType].nProb = math.max(mapPropData[nType].nProb, nParam1 == nil and 0 or nParam1)
            local nParam2 = tonumber(tbParam[3])
            mapPropData[nType].nGrowth = math.max(mapPropData[nType].nGrowth, nParam2 == nil and 0 or nParam2)
            local nParam3 = tonumber(tbParam[4])
            mapPropData[nType].nMaxCount = math.max(mapPropData[nType].nMaxCount, nParam3 == nil and 0 or nParam3)
          end
        end
      end
    end
  end
  for _, nType in ipairs(tbActived) do
    if mapDropId[nType] ~= nil then
      local stActorInfo = CS.VampireDropData(mapDropId[nType], 0, 0, 0)
      if mapPropData[nType] ~= nil then
        stActorInfo.DropProb = mapPropData[nType].nProb
        stActorInfo.GrowthProb = mapPropData[nType].nGrowth
        stActorInfo.DropMaxCount = mapPropData[nType].nMaxCount
      end
      table.insert(ret, stActorInfo)
    end
  end
  return ret
end

function PlayerVampireSurvivorData:GetCurTalentPoint()
  if not self.bInitTalent then
    printError("TalentData not init!")
    return 0
  end
  return self.nTalentPoints
end

function PlayerVampireSurvivorData:GetActiveExFateCard()
  local tbActivedTalent = self:GetActivedTalent()
  for _, nTalentId in ipairs(tbActivedTalent) do
    local talentData = ConfigTable.GetData("VampireTalent", nTalentId)
    if talentData ~= nil and talentData.Effect == GameEnum.vampireTalentEffect.UnlockspecialFateCard then
      return true
    end
  end
  return false
end

function PlayerVampireSurvivorData:GetCurScore()
  return self.nSeasonScore
end

function PlayerVampireSurvivorData:GetScoreByLevel(nLevelId)
  return self.mapScore[nLevelId] == nil and 0 or self.mapScore[nLevelId]
end

function PlayerVampireSurvivorData:CacheScoreByLevel(nLevelId, nScore)
  if self.mapScore[nLevelId] ~= nil and nScore <= self.mapScore[nLevelId] then
    return
  end
  self.mapScore[nLevelId] = nScore
end

function PlayerVampireSurvivorData:CacheTalentData(mapData)
  local tbNodes = UTILS.ParseByteString(mapData.Nodes)
  
  local function forEachTalent(mapData)
    local bActive = UTILS.IsBitSet(tbNodes, mapData.Id)
    self.mapActiveTalent[mapData.Id] = bActive
  end
  
  ForEachTableLine(DataTable.VampireTalent, forEachTalent)
  self.nTalentResetTime = mapData.ResetTime
  self.nFateCardCount = mapData.ActiveCount
  self.nTalentPoints = self:CalTalentPoint(self.mapActiveTalent, self.nFateCardCount)
  self.ObtainCount = mapData.ObtainCount
  self.nActiveExp = self.nTalentPoints - self:CalTalentPoint(self.mapActiveTalent, self.nFateCardCount - self.ObtainCount)
  RedDotManager.SetValid(RedDotDefine.VampireTalent, nil, self:CheckCanAciveTalent())
end

function PlayerVampireSurvivorData:GetIsTalentPointMax()
  local nFateCardPoint = ConfigTable.GetConfigNumber("FateCardBookToVampireTalentPoint")
  if nFateCardPoint == nil then
    nFateCardPoint = 1
  end
  local nCurCount = self.nFateCardCount * nFateCardPoint
  return nCurCount >= self.nTalentPointMax
end

function PlayerVampireSurvivorData:CheckOpenHint()
  if self.nActiveExp > 0 then
    HttpNetHandler.SendMsg(NetMsgId.Id.vampire_talent_show_req, {}, nil, nil)
    local ret1 = self.ObtainCount
    local ret2 = self.nActiveExp
    self.ObtainCount = 0
    self.nActiveExp = 0
    return true, ret1, ret2
  end
  return false, 0, 0
end

function PlayerVampireSurvivorData:ResetTalentPoint()
  local nFateCardPoint = ConfigTable.GetConfigNumber("FateCardBookToVampireTalentPoint")
  if nFateCardPoint == nil then
    nFateCardPoint = 1
  end
  self.nTalentPoints = math.min(self.nTalentPointMax, nFateCardPoint * self.nFateCardCount)
  RedDotManager.SetValid(RedDotDefine.VampireTalent, nil, self:CheckCanAciveTalent())
end

function PlayerVampireSurvivorData:AddTalentPoint(tbFateCard)
  if tbFateCard ~= nil then
    self.nFateCardCount = self.nFateCardCount + #tbFateCard
  end
  self.ObtainCount = self.ObtainCount + #tbFateCard
  self.nActiveExp = math.max(0, self:CalTalentPoint(self.mapActiveTalent, self.nFateCardCount) - self.nTalentPoints)
  self.nTalentPoints = self:CalTalentPoint(self.mapActiveTalent, self.nFateCardCount)
  RedDotManager.SetValid(RedDotDefine.VampireTalent, nil, self:CheckCanAciveTalent())
end

function PlayerVampireSurvivorData:GetRefreshTiem()
  local nSeasonId = self:GetCurSeason()
  if nSeasonId == 0 then
    return ""
  end
  local mapSeasonCfgData = ConfigTable.GetData("VampireRankSeason", nSeasonId)
  if mapSeasonCfgData == nil then
    return ""
  end
  local nEndTime = CS.ClientManager.Instance:ISO8601StrToTimeStamp(mapSeasonCfgData.EndTime)
  local curTime = CS.ClientManager.Instance.serverTimeStamp
  local remainTime = nEndTime - curTime
  if remainTime < 0 then
    return ""
  end
  local sTimeStr = ""
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

function PlayerVampireSurvivorData:GetCurSeason()
  local ret = 0
  local nLevel = 0
  local nCurTime = CS.ClientManager.Instance.serverTimeStamp
  
  local function foreachVampireSeason(mapData)
    local starttime = CS.ClientManager.Instance:ISO8601StrToTimeStamp(mapData.OpenTime)
    local endtime = CS.ClientManager.Instance:ISO8601StrToTimeStamp(mapData.EndTime)
    if starttime < nCurTime and endtime > nCurTime then
      ret = mapData.Id
      nLevel = mapData.MissionId
    end
  end
  
  ForEachTableLine(DataTable.VampireRankSeason, foreachVampireSeason)
  return ret, nLevel
end

function PlayerVampireSurvivorData:AddPointAndLevel(nPoint, nLevelId, nSeasonId)
  if nLevelId ~= 0 and table.indexof(self.tbPassedId) < 1 then
    table.insert(self.tbPassedId, nLevelId)
  end
  if nSeasonId ~= nil and nSeasonId ~= self:GetCurSeason() then
    return
  end
  self.nSeasonScore = self.nSeasonScore + nPoint
end

function PlayerVampireSurvivorData:CheckCanAciveTalent()
  local function checkPrecAcitve(tbPrev)
    if tbPrev == nil or #tbPrev == 0 then
      return true
    end
    for _, nId in ipairs(tbPrev) do
      if self.mapActiveTalent[nId] ~= true then
        return false
      end
    end
    return true
  end
  
  local ret = false
  
  local function foreachTalent(mapData)
    if self.mapActiveTalent[mapData.Id] == true then
      return
    end
    local tbPrev = mapData.Prev
    if checkPrecAcitve(tbPrev) and mapData.Point <= self.nTalentPoints then
      ret = true
    end
  end
  
  ForEachTableLine(DataTable.VampireTalent, foreachTalent)
  return ret
end

function PlayerVampireSurvivorData:CalTalentPoint(mapActiveTalent, nCards)
  local nActivedPoint = 0
  local nFateCardPoint = ConfigTable.GetConfigNumber("FateCardBookToVampireTalentPoint")
  if nFateCardPoint == nil then
    nFateCardPoint = 1
  end
  for nTalentId, bActive in pairs(mapActiveTalent) do
    if bActive then
      local mapTalentCfg = ConfigTable.GetData("VampireTalent", nTalentId)
      if mapTalentCfg ~= nil then
        nActivedPoint = nActivedPoint + mapTalentCfg.Point
      end
    end
  end
  local totalPoint = math.min(self.nTalentPointMax, nFateCardPoint * nCards)
  return totalPoint - nActivedPoint
end

function PlayerVampireSurvivorData:OnNotifyRefresh(nSeasonId)
  self.mapRecordSeason = {
    Id = nSeasonId,
    Score = 0,
    BuildIds = {},
    Passed = false
  }
  self.nSeasonScore = 0
  PlayerData.Quest:ClearVampireSeasonQuest(nSeasonId)
  EventManager.Hit("VampireSeasonRefresh")
end

function PlayerVampireSurvivorData:SetBattleSuccess()
  self.bSuccessBattle = true
end

function PlayerVampireSurvivorData:CheckBattleSuccess()
  if self.bSuccessBattle == true then
    self.bSuccessBattle = false
    return true
  end
  return false
end

function PlayerVampireSurvivorData:IsActiveTalent(nId)
  local mapTalentData = ConfigTable.GetData("VampireTalent", nId)
  if mapTalentData == nil then
    return 3
  end
  if self.mapActiveTalent[nId] then
    return 1
  else
    local tbPrev = mapTalentData.Prev
    if tbPrev == nil or #tbPrev == 0 then
      return 2
    end
    for _, nPrevId in ipairs(tbPrev) do
      if self.mapActiveTalent[nPrevId] then
        return 2
      end
    end
    return 3
  end
end

function PlayerVampireSurvivorData:GetHardUnlock()
  local ret = {
    false,
    false,
    false
  }
  
  local function forEachVampire(mapData)
    if self:CheckLevelUnlock(mapData.Id) then
      if mapData.Type == GameEnum.vampireSurvivorType.Normal then
        ret[1] = true
      elseif mapData.Type == GameEnum.vampireSurvivorType.Hard then
        ret[2] = true
      end
    end
  end
  
  ForEachTableLine(DataTable.VampireSurvivor, forEachVampire)
  local nCurSeasonId, nLevelId = self:GetCurSeason()
  if nCurSeasonId ~= 0 then
    ret[3] = self:CheckLevelUnlock(nLevelId)
  end
  return ret
end

function PlayerVampireSurvivorData:GetSeasonQuestCount(nHard)
  local tbScore, tbPass = PlayerData.Quest:GetVampireQuestData()
  local cur, total = 0, 0
  for _, mapPassData in ipairs(tbPass) do
    local mapCfg = ConfigTable.GetData("VampireSurvivorQuest", mapPassData.nTid)
    if mapCfg ~= nil and mapCfg.Type == nHard then
      total = total + 1
      if mapPassData.nStatus == 2 then
        cur = cur + 1
      end
    end
  end
  for _, mapPassData in ipairs(tbScore) do
    local mapCfg = ConfigTable.GetData("VampireSurvivorQuest", mapPassData.nTid)
    if mapCfg ~= nil and mapCfg.Type == nHard then
      total = total + 1
      if mapPassData.nStatus == 2 then
        cur = cur + 1
      end
    end
  end
  return cur, total
end

function PlayerVampireSurvivorData:CacheScore(nScore)
  self.nSeasonScore = nScore
end

function PlayerVampireSurvivorData:CachePassedId(tbIds)
  self.tbPassedId = tbIds
end

function PlayerVampireSurvivorData:GetFirstIn()
  local bFirst = self.bFirstIn
  if self.bFirstIn == true then
    self.bFirstIn = false
  end
  return bFirst
end

return PlayerVampireSurvivorData
