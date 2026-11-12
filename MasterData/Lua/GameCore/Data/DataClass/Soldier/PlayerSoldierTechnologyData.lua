local ConfigData = require("GameCore.Data.ConfigData")
local SoldierAttrData = require("GameCore.Data.DataClass.Soldier.SoldierAttrData")
local PlayerSoldierTechnologyData = class("PlayerSoldierTechnologyData")

function PlayerSoldierTechnologyData:ctor()
  self.tbTechNodes = {}
end

function PlayerSoldierTechnologyData:InitData()
  self:InitConfig()
end

function PlayerSoldierTechnologyData:InitConfig()
  local function create(mapLineData)
    local mapNode = self.tbTechNodes[mapLineData.Season][mapLineData.Id]
    
    if not mapNode then
      mapNode = {
        nId = mapLineData.Id,
        nNodeId = mapLineData.NodeId,
        tbPreNodes = mapLineData.PreNodes,
        tbNextNodes = {},
        bActive = false,
        bReady = false
      }
      self.tbTechNodes[mapLineData.Season][mapLineData.Id] = mapNode
    end
    return mapNode
  end
  
  local function foreachNode(mapLineData)
    local nSeasonId = mapLineData.Season
    if not self.tbTechNodes[nSeasonId] then
      self.tbTechNodes[nSeasonId] = {}
    end
    create(mapLineData)
    if #mapLineData.PreNodes > 0 then
      for _, nPreId in ipairs(mapLineData.PreNodes) do
        local mapCfg = ConfigTable.GetData("SoldierTechNode", nPreId)
        if mapCfg then
          local mapPreNode = create(mapCfg)
          table.insert(mapPreNode.tbNextNodes, mapLineData.Id)
        end
      end
    end
  end
  
  ForEachTableLine(ConfigTable.Get("SoldierTechNode"), foreachNode)
end

function PlayerSoldierTechnologyData:GetClientEffectByNode(nSeasonId, tbActiveNode)
  local tbEffectType = {}
  local tbNodes = UTILS.ParseByteString(tbActiveNode)
  if self.tbTechNodes[nSeasonId] ~= nil then
    for nId, mapLine in pairs(self.tbTechNodes[nSeasonId]) do
      local bActive = UTILS.IsBitSet(tbNodes, mapLine.NodeId)
      if bActive and (not tbEffectType[mapLine.EffectClient] or tbEffectType[mapLine.EffectClient].Priority < mapLine.Priority) then
        tbEffectType[mapLine.EffectClient] = {
          ClientParams = mapLine.ClientParams,
          Priority = mapLine.Priority
        }
      end
    end
  end
  return tbEffectType
end

function PlayerSoldierTechnologyData:ParseServerData(nSeasonId, mapMsgData)
  if self.tbTechNodes[nSeasonId] ~= nil then
    local tbNodes = UTILS.ParseByteString(mapMsgData)
    for nId, v in pairs(self.tbTechNodes[nSeasonId]) do
      v.bActive = UTILS.IsBitSet(tbNodes, v.nNodeId)
    end
    self:RefreshNodesReady(nSeasonId)
    self:RefreshRedDot(nSeasonId)
  end
end

function PlayerSoldierTechnologyData:RefreshNodesReady(nSeasonId)
  local tbNodeList = self.tbTechNodes[nSeasonId]
  if not tbNodeList then
    return
  end
  for nId, mapNode in pairs(tbNodeList) do
    local mapCfg = ConfigTable.GetData("SoldierTechNode", nId)
    if mapCfg then
      local tbPre = mapCfg.PreNodes
      local bReady
      if #tbPre == 0 then
        bReady = true
      elseif mapCfg.PreNodesLogic then
        bReady = true
        for _, nPreId in ipairs(tbPre) do
          local mapPre = tbNodeList[nPreId]
          if not mapPre or not mapPre.bActive then
            bReady = false
            break
          end
        end
      else
        bReady = false
        for _, nPreId in ipairs(tbPre) do
          local mapPre = tbNodeList[nPreId]
          if mapPre and mapPre.bActive then
            bReady = true
            break
          end
        end
      end
      mapNode.bReady = bReady
    end
  end
end

function PlayerSoldierTechnologyData:RefreshRedDot(nSeasonId)
  local bRedDot = false
  if self.tbTechNodes[nSeasonId] ~= nil then
    for nId, v in pairs(self.tbTechNodes[nSeasonId]) do
      if not v.bActive and v.bReady then
        local mapCfg = ConfigTable.GetData("SoldierTechNode", nId)
        if mapCfg ~= nil then
          local nHasCount = PlayerData.Item:GetItemCountByID(mapCfg.ItemId1)
          if nHasCount >= mapCfg.ItemQty1 then
            bRedDot = true
            break
          end
        end
      end
    end
  end
  RedDotManager.SetValid(RedDotDefine.Soldier_TechNum, nil, bRedDot)
end

function PlayerSoldierTechnologyData:GetTechNodesBySeason(nSeasonId)
  return self.tbTechNodes[nSeasonId]
end

function PlayerSoldierTechnologyData:GetTechNode(nId, nSeasonId)
  if not nSeasonId then
    local mapCfg = ConfigTable.GetData("SoldierTechNode", nId)
    if not mapCfg then
      printError("自走棋科技树节点Id有误, 未找到配置表数据, Id: " .. nId)
      return {}
    end
    nSeasonId = mapCfg.Season
  end
  return self.tbTechNodes[nSeasonId][nId]
end

function PlayerSoldierTechnologyData:GetActiveNodeCount(nSeasonId)
  local nAllCount, nActiveCount = 0, 0
  local tbNodeList = self.tbTechNodes[nSeasonId]
  if tbNodeList ~= nil then
    for _, v in pairs(tbNodeList) do
      if v.bActive == true then
        nActiveCount = nActiveCount + 1
      end
      nAllCount = nAllCount + 1
    end
  end
  return nAllCount, nActiveCount
end

function PlayerSoldierTechnologyData:GetActiveClientEffect(nSeasonId)
  local tbClientBuffList = {}
  local tbNodeList = self.tbTechNodes[nSeasonId]
  if tbNodeList ~= nil then
    for _, v in pairs(tbNodeList) do
      if v.bActive then
        local mapCfg = ConfigTable.GetData("SoldierTechNode", v.nId)
        if mapCfg ~= nil and mapCfg.Type == GameEnum.SoldierTechNodeType.Attribute and #mapCfg.EffectClient > 0 then
          for _, nBuffId in ipairs(mapCfg.EffectClient) do
            table.insert(tbClientBuffList, nBuffId)
          end
        end
      end
    end
  end
  return tbClientBuffList
end

function PlayerSoldierTechnologyData:GetClientBattleBuffList(nSeasonId)
  local tbBuffList = {}
  local tbNodeList = self.tbTechNodes[nSeasonId]
  if tbNodeList ~= nil then
    for _, v in pairs(tbNodeList) do
      if v.bActive then
        local mapCfg = ConfigTable.GetData("SoldierTechNode", v.nId)
        if mapCfg ~= nil and mapCfg.Type == GameEnum.SoldierTechNodeType.Attribute and mapCfg.EffectBattle > 0 then
          table.insert(tbBuffList, mapCfg.EffectBattle)
        end
      end
    end
  end
  return tbBuffList
end

function PlayerSoldierTechnologyData:CheckTechNodeActiveById(nSeasonId, nId)
  if self.tbTechNodes[nSeasonId] ~= nil and self.tbTechNodes[nSeasonId][nId] ~= nil then
    return self.tbTechNodes[nSeasonId][nId].bActive
  end
  return false
end

function PlayerSoldierTechnologyData:GetActiveNodePreview(nSeasonId)
  local tbPreview = {}
  local tbAttr = {}
  local tbBattleAttr = {}
  local tbCore = {}
  local tbNodeList = self.tbTechNodes[nSeasonId]
  if tbNodeList ~= nil then
    for _, v in pairs(tbNodeList) do
      if v.bActive == true then
        local mapCfg = ConfigTable.GetData("SoldierTechNode", v.nId)
        if mapCfg ~= nil then
          if mapCfg.Type == GameEnum.SoldierTechNodeType.Attribute then
            if #mapCfg.EffectClient > 0 then
              for _, nBuffId in ipairs(mapCfg.EffectClient) do
                local mapBuffCfg = ConfigTable.GetData("SoldierClientBuff", nBuffId)
                if mapBuffCfg == nil then
                  goto lbl_123
                end
                for i = 1, 3 do
                  local nEffectType = mapBuffCfg["Effect" .. i]
                  local tbParam = mapBuffCfg["EffectParams" .. i]
                  if #tbParam == 2 and (nEffectType == GameEnum.SoldierClientEffect.AmendAttr or nEffectType == GameEnum.SoldierClientEffect.PercentAmendAttr or nEffectType == GameEnum.SoldierClientEffect.BaseAmendAttr or nEffectType == GameEnum.SoldierClientEffect.BasePercentAmendAttr) then
                    if tbAttr[nEffectType] == nil then
                      tbAttr[nEffectType] = {}
                    end
                    if tbAttr[nEffectType][tbParam[1]] == nil then
                      tbAttr[nEffectType][tbParam[1]] = 0
                    end
                    tbAttr[nEffectType][tbParam[1]] = tbAttr[nEffectType][tbParam[1]] + tonumber(tbParam[2])
                  end
                end
              end
            end
            if mapCfg.BattleType ~= GameEnum.SoldierTechBattleEffect.None then
              if tbBattleAttr[mapCfg.BattleType] == nil then
                tbBattleAttr[mapCfg.BattleType] = 0
              end
              tbBattleAttr[mapCfg.BattleType] = tbBattleAttr[mapCfg.BattleType] + mapCfg.BattleTypeParam
            end
            ::lbl_123::
          elseif mapCfg.Type == GameEnum.SoldierTechNodeType.Core then
            table.insert(tbCore, mapCfg.Id)
          end
        end
      end
    end
  end
  local tbAttachAttrCfg = {}
  for _, v in ipairs(SoldierAttrData.GetAttachAttrList()) do
    tbAttachAttrCfg[v.sKey] = v
  end
  for _, tbSub in pairs(tbAttr) do
    for sKey, nValue in pairs(tbSub) do
      local cfg = tbAttachAttrCfg[sKey]
      if cfg and cfg.bIntFloat then
        tbSub[sKey] = nValue * ConfigData.IntFloatPrecision
      end
    end
  end
  for eKey, nValue in pairs(tbBattleAttr) do
    tbBattleAttr[eKey] = nValue * ConfigData.IntFloatPrecision
  end
  tbPreview.tbAttr = tbAttr
  tbPreview.tbBattleAttr = tbBattleAttr
  tbPreview.tbCore = tbCore
  return tbPreview
end

function PlayerSoldierTechnologyData:SendSoldierTechDetailReq(nSeasonId, callback)
  local function netCallback(_, netMsg)
    self:ParseServerData(nSeasonId, netMsg.Value)
    
    if callback ~= nil then
      callback()
    end
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.soldier_technology_info_req, {Value = nSeasonId}, nil, netCallback)
end

function PlayerSoldierTechnologyData:SendSoldierTechNodeUnlockReq(nId, callback)
  local function netCallback(_, netMsg)
    local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(netMsg)
    
    HttpNetHandler.ProcChangeInfo(mapDecodedChangeInfo)
    local mapCfg = ConfigTable.GetData("SoldierTechNode", nId)
    if mapCfg ~= nil then
      local tbNodeList = self.tbTechNodes[mapCfg.Season]
      local mapNode = tbNodeList and tbNodeList[nId] or nil
      if mapNode ~= nil then
        mapNode.bActive = true
        self:RefreshNodesReady(mapCfg.Season)
        self:RefreshRedDot(mapCfg.Season)
      end
    end
    if callback ~= nil then
      callback()
    end
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.soldier_technology_node_unlock_req, {Value = nId}, nil, netCallback)
end

return PlayerSoldierTechnologyData
