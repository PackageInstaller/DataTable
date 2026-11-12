local PlayerSoldierRecommendData = class("PlayerSoldierRecommendData")
local ClientManager = CS.ClientManager.Instance
local LocalData = require("GameCore.Data.LocalData")
local SoldierAttrData = require("GameCore.Data.DataClass.Soldier.SoldierAttrData")

function PlayerSoldierRecommendData:ctor()
end

function PlayerSoldierRecommendData:InitData()
  self.nRecommendId = nil
  self.nInSoldierRecommendId = nil
  self.bInSoldierChanged = nil
  self.tbRecommendList = {}
  self.tbSystemRecommendList = {}
  self.mapRecommendDataById = {}
  self:PreloadSystemRecommendList()
  self.tbSoldierPositionEffectData = {}
  
  local function func_ForEach_SoldierPositionEffect(mapLineData)
    if mapLineData.PositionType == GameEnum.SoldierPositionType.FightPosition then
      self.tbSoldierPositionEffectData[mapLineData.Index] = mapLineData.Id
    end
  end
  
  ForEachTableLine(DataTable.SoldierPositionEffect, func_ForEach_SoldierPositionEffect)
end

function PlayerSoldierRecommendData:SetRecommendData(nRecommendId, bInSoldier)
  if bInSoldier then
    self.nInSoldierRecommendId = nRecommendId
    self.bInSoldierChanged = true
  else
    self.nRecommendId = nRecommendId
  end
  EventManager.Hit("SoldierRecommend_Update")
  self:SaveData()
end

function PlayerSoldierRecommendData:GetRecommendData(bInSoldier)
  local nRecommendId = self:GetRecommendId()
  local nInSoldierRecommendId = self:GetInSoldierRecommendId()
  if bInSoldier then
    if self:GetInSoldierChanged() then
      if nInSoldierRecommendId == 0 then
        return nil
      end
      return self:GetRecommendDataById(nInSoldierRecommendId)
    else
      if nRecommendId == 0 then
        return nil
      end
      return self:GetRecommendDataById(nRecommendId)
    end
  else
    if nRecommendId == 0 then
      return nil
    end
    return self:GetRecommendDataById(nRecommendId)
  end
end

function PlayerSoldierRecommendData:SaveData()
  self.nRecommendId = self:GetRecommendId()
  self.nInSoldierRecommendId = self:GetInSoldierRecommendId()
  self.bInSoldierChanged = self:GetInSoldierChanged()
  LocalData.SetPlayerLocalData("SoldierRecommend_Id", tostring(self.nRecommendId))
  LocalData.SetPlayerLocalData("SoldierInSoldierRecommend_Id", tostring(self.nInSoldierRecommendId))
  LocalData.SetPlayerLocalData("SoldierInSoldierChanged", self.bInSoldierChanged)
end

function PlayerSoldierRecommendData:GetSoldierPositionEffectDataId(nIndex)
  return self.tbSoldierPositionEffectData[nIndex]
end

function PlayerSoldierRecommendData:GetAllRecommendData()
  return self.mapRecommendDataById
end

function PlayerSoldierRecommendData:ClearInSoldierRecommendData()
  self.nInSoldierRecommendId = 0
  self.bInSoldierChanged = false
  self:SaveData()
end

function PlayerSoldierRecommendData:CheckChessRecommendState(nChessId)
  local recommendData = self:GetRecommendData(true)
  if recommendData == nil then
    return false
  end
  for _, charData in ipairs(recommendData.charList) do
    if charData.nId == nChessId then
      return true
    end
  end
  return false
end

function PlayerSoldierRecommendData:CheckPartnerRecommendState(nPartnerType)
  local recommendData = self:GetRecommendData(true)
  if recommendData == nil then
    return false
  end
  if recommendData.tbPartner == nil then
    return false
  end
  for _, partnerData in ipairs(recommendData.tbPartner) do
    if partnerData.nType == nPartnerType then
      return true
    end
  end
  return false
end

function PlayerSoldierRecommendData:GetRecommendId()
  if self.nRecommendId == nil then
    local sReportId = LocalData.GetPlayerLocalData("SoldierRecommend_Id") or ""
    self.nRecommendId = sReportId == "0" and 0 or sReportId
  end
  return self.nRecommendId
end

function PlayerSoldierRecommendData:GetInSoldierRecommendId()
  if self.nInSoldierRecommendId == nil then
    local sReportId = LocalData.GetPlayerLocalData("SoldierInSoldierRecommend_Id") or ""
    self.nInSoldierRecommendId = sReportId == "0" and 0 or sReportId
  end
  return self.nInSoldierRecommendId
end

function PlayerSoldierRecommendData:GetInSoldierChanged()
  if self.bInSoldierChanged == nil then
    local sValue = LocalData.GetPlayerLocalData("SoldierInSoldierChanged")
    self.bInSoldierChanged = sValue == true or sValue == "true"
  end
  return self.bInSoldierChanged
end

function PlayerSoldierRecommendData:RequestRecommendList(callback)
  local function cb(_, netMsg)
    self:SetRecommendList(netMsg.Reports or {})
    
    if callback ~= nil then
      callback()
    end
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.soldier_battle_report_favorite_list_req, {}, nil, cb)
end

function PlayerSoldierRecommendData:SendFavoriteRecommend(sCode, callback)
  local function cb(_, netMsg)
    if callback ~= nil then
      callback()
    end
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.soldier_battle_report_favorite_req, {Value = sCode}, nil, cb)
end

function PlayerSoldierRecommendData:SendUnfavoriteRecommend(sCode, callback)
  local function cb(_, netMsg)
    if callback ~= nil then
      callback()
    end
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.soldier_battle_report_unfavorite_req, {Value = sCode}, nil, cb)
end

function PlayerSoldierRecommendData:GetCurRecommendList()
  return self.tbRecommendList
end

function PlayerSoldierRecommendData:GetCollectRecommendList()
  return self.tbRecommendList
end

function PlayerSoldierRecommendData:GetSystemRecommendList()
  return self.tbSystemRecommendList
end

function PlayerSoldierRecommendData:SetRecommendList(tbReports)
  self.tbRecommendList = {}
  self.mapRecommendDataById = {}
  for _, mapRecommendData in ipairs(self.tbSystemRecommendList) do
    self.mapRecommendDataById[tostring(mapRecommendData.nRecommendId)] = mapRecommendData
  end
  for _, mapReport in ipairs(tbReports) do
    local mapRecommendData = self:CreateRecommendData(mapReport)
    if mapRecommendData ~= nil then
      table.insert(self.tbRecommendList, mapRecommendData)
      self.mapRecommendDataById[tostring(mapRecommendData.nRecommendId)] = mapRecommendData
    end
  end
  self:ClearInvalidRecommendData()
end

function PlayerSoldierRecommendData:ClearInvalidRecommendData()
  local bChanged = false
  if self:GetRecommendId() ~= 0 and self:GetRecommendDataById(self:GetRecommendId()) == nil then
    self.nRecommendId = 0
    bChanged = true
  end
  if self:GetInSoldierRecommendId() ~= 0 and self:GetRecommendDataById(self:GetInSoldierRecommendId()) == nil then
    self.nInSoldierRecommendId = 0
    bChanged = true
  end
  if bChanged then
    self:SaveData()
    EventManager.Hit("SoldierRecommend_Update")
  end
end

function PlayerSoldierRecommendData:PreloadSystemRecommendList()
  local function funcForEachRecommend(mapLineData)
    local mapRecommendData = self:CreateSystemRecommendData(mapLineData)
    
    if mapRecommendData ~= nil then
      table.insert(self.tbSystemRecommendList, mapRecommendData)
      self.mapRecommendDataById[tostring(mapRecommendData.nRecommendId)] = mapRecommendData
    end
  end
  
  ForEachTableLine(DataTable.SoldierRecommendBuilds, funcForEachRecommend)
end

function PlayerSoldierRecommendData:CreateSystemRecommendData(mapLineData)
  if mapLineData == nil then
    return nil
  end
  local mapRecommendData = {
    nRecommendId = mapLineData.Id,
    nCharId = mapLineData.CharacterId,
    charList = {},
    tbStrategyCardId = mapLineData.StrategyCard or {},
    tbPartner = {},
    tbExtraPartner = {},
    sTitle = mapLineData.Title,
    sDesc = mapLineData.Desc or "",
    sVersion = "",
    bSystemRecommend = true
  }
  mapRecommendData.nBossTemplateId = mapLineData.BossTemplate
  for nIndex = 1, 3 do
    local tbCharData = mapLineData["Front" .. nIndex]
    if tbCharData ~= nil then
      table.insert(mapRecommendData.charList, {
        nId = tbCharData[1],
        nStar = tbCharData[2],
        nPositionType = 1,
        nPosIndex = tbCharData[4] or nIndex
      })
    end
  end
  local tbBackChar = mapLineData.Back and decodeJson(mapLineData.Back)
  if type(tbBackChar) == "table" then
    for nCharId, nStar in pairs(tbBackChar) do
      table.insert(mapRecommendData.charList, {
        nId = tonumber(nCharId),
        nStar = tonumber(nStar),
        nPositionType = 2,
        nPosIndex = 0
      })
    end
  end
  table.sort(mapRecommendData.charList, function(mapA, mapB)
    if mapA.nPositionType ~= mapB.nPositionType then
      return mapA.nPositionType < mapB.nPositionType
    end
    if mapA.nPositionType == 1 then
      return (mapA.nPosIndex or 0) < (mapB.nPosIndex or 0)
    end
    local mapCharCfgA = ConfigTable.GetData("SoldierCharacter", mapA.nId)
    local mapCharCfgB = ConfigTable.GetData("SoldierCharacter", mapB.nId)
    if mapCharCfgA.Rarity ~= mapCharCfgB.Rarity then
      return mapCharCfgA.Rarity > mapCharCfgB.Rarity
    end
    return mapA.nId < mapB.nId
  end)
  local tbPartnerAdd = mapLineData.PartnerAdd and decodeJson(mapLineData.PartnerAdd)
  if type(tbPartnerAdd) == "table" then
    for nPartnerId, nAddLevel in pairs(tbPartnerAdd) do
      local mapPartnerCfg = ConfigTable.GetData("SoldierPartner", tonumber(nPartnerId))
      if mapPartnerCfg ~= nil then
        mapRecommendData.tbExtraPartner[mapPartnerCfg.PartnerType] = tonumber(nAddLevel)
      end
    end
  end
  local _, tbUIData = SoldierAttrData.CalcActivePartners(mapRecommendData.charList, mapRecommendData.tbExtraPartner, {})
  mapRecommendData.tbPartner = tbUIData
  return mapRecommendData
end

function PlayerSoldierRecommendData:CreateRecommendData(mapReport)
  if mapReport == nil or mapReport.ReportId == nil or mapReport.ReportId == "" then
    return nil
  end
  local mapRecommendData = {
    nRecommendId = mapReport.ReportId,
    nCharId = 0,
    charList = {},
    tbStrategyCardId = mapReport.CardIds or {},
    tbPartner = {},
    tbExtraPartner = {},
    mapReport = mapReport,
    bSystemRecommend = false
  }
  mapRecommendData.nBossTemplateId = mapReport.BossAbilityId
  local mapChallengeCfg = ConfigTable.GetData("SoldierGradeChallenge", mapReport.GradeChallengeId)
  mapRecommendData.sTitle = mapChallengeCfg and mapChallengeCfg.Name or mapReport.ReportId
  mapRecommendData.sDesc = mapReport.Version or ""
  mapRecommendData.sVersion = mapReport.Version or ""
  for nIndex, mapChess in ipairs(mapReport.Chess or {}) do
    table.insert(mapRecommendData.charList, {
      nId = mapChess.Id,
      nStar = mapChess.Star,
      nPositionType = nIndex <= 3 and 1 or 2,
      nPosIndex = nIndex <= 3 and nIndex or 0
    })
  end
  if mapRecommendData.charList[1] ~= nil then
    mapRecommendData.nCharId = mapRecommendData.charList[1].nId
  end
  local _, tbUIData = SoldierAttrData.CalcActivePartners(mapRecommendData.charList, {}, {})
  mapRecommendData.tbPartner = tbUIData
  self:BuildCustomRecommendTitle(mapRecommendData)
  return mapRecommendData
end

function PlayerSoldierRecommendData:BuildCustomRecommendTitle(mapRecommendData)
  local tbActivePartner = {}
  for _, mapPartnerData in ipairs(mapRecommendData.tbPartner) do
    if mapPartnerData.nActiveLevel > 0 then
      table.insert(tbActivePartner, mapPartnerData)
    end
  end
  table.sort(tbActivePartner, function(mapA, mapB)
    if mapA.nActiveLevel ~= mapB.nActiveLevel then
      return mapA.nActiveLevel > mapB.nActiveLevel
    end
    return mapA.nType < mapB.nType
  end)
  local tbTitlePart = {}
  for nIndex = 1, math.min(2, #tbActivePartner) do
    local mapPartnerData = tbActivePartner[nIndex]
    local mapPartnerGroupCfg = CacheTable.GetData("_SoldierPartnerGroup", mapPartnerData.nType)
    if mapPartnerGroupCfg ~= nil then
      table.insert(tbTitlePart, tostring(mapPartnerData.nActiveNum) .. mapPartnerGroupCfg.Name)
    end
  end
  if 0 < #tbTitlePart then
    mapRecommendData.sTitle = table.concat(tbTitlePart, " ")
  end
end

function PlayerSoldierRecommendData:GetRecommendDataById(sReportId)
  if sReportId == nil or sReportId == 0 or sReportId == "" then
    return nil
  end
  return self.mapRecommendDataById[tostring(sReportId)]
end

return PlayerSoldierRecommendData
