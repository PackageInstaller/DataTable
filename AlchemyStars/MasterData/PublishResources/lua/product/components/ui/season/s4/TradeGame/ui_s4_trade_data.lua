_class("UIS4TradeData", Object)
UIS4TradeData = UIS4TradeData

function UIS4TradeData:Constructor(campaign)
  self._campaign = campaign
end

function UIS4TradeData:GetComponentID()
  local comp = self:GetBusinessComp()
  if not comp then
    return
  end
  return comp:GetComponentCfgId()
end

function UIS4TradeData:GetBusinessComp()
  local process = self._campaign:GetLocalProcess()
  if process then
    return process:GetComponent(ECCampaignSeasonComponentID.BUSINESS)
  end
  return nil
end

function UIS4TradeData:GetBusinessCompInfo()
  local process = self._campaign:GetLocalProcess()
  if process then
    return process:GetComponentInfo(ECCampaignSeasonComponentID.BUSINESS)
  end
  return nil
end

function UIS4TradeData:GetTotalProcessComp()
  local process = self._campaign:GetLocalProcess()
  if process then
    return process:GetComponent(ECCampaignSeasonComponentID.TOTAL_PROCESS)
  end
  return nil
end

function UIS4TradeData:GetTotalProcessCompInfo()
  local process = self._campaign:GetLocalProcess()
  if process then
    return process:GetComponentInfo(ECCampaignSeasonComponentID.TOTAL_PROCESS)
  end
  return nil
end

function UIS4TradeData:GetRewardProcessComp()
  local process = self._campaign:GetLocalProcess()
  if process then
    return process:GetComponent(ECCampaignSeasonComponentID.REWARD_PROCESS)
  end
  return nil
end

function UIS4TradeData:GetRewardProcessCompInfo()
  local process = self._campaign:GetLocalProcess()
  if process then
    return process:GetComponentInfo(ECCampaignSeasonComponentID.REWARD_PROCESS)
  end
  return nil
end

function UIS4TradeData:GetHarbourInfo(id)
  local comp = self:GetBusinessComp()
  if comp then
    local info = comp:GetInfo(id)
    return info
  end
  return
end

function UIS4TradeData:GetHarborEvent(id)
  local comp = self:GetBusinessComp()
  if comp then
    local info = comp:GetHarborEvent(id)
    return info
  end
  return
end

function UIS4TradeData:GetInfo(id)
  local comp = self:GetBusinessComp()
  if comp then
    local hinfo, sinfo = comp:GetInfo(id)
    return hinfo, sinfo
  end
  return
end

function UIS4TradeData:CheckHarborLock(Id)
  local HarborCfg = Cfg.cfg_component_business_harbor
  local harborLv, shipLv = self:GetHarborShipLV(Id)
  if harborLv == 0 then
    return false
  end
  local NowHarborCfg = HarborCfg({HarborID = Id, Lv = harborLv})[1]
  local itemModule = GameGlobal.GetModule(ItemModule)
  local item = NowHarborCfg.LockItem
  local num = itemModule:GetItemCount(item[1])
  if num and num >= item[2] then
    return true
  else
    return false
  end
end

function UIS4TradeData:GetShipBaseValueByID(shipID)
  local comp = self:GetBusinessComp()
  local compInfo = self:GetBusinessCompInfo()
  if not comp then
    return
  end
  local shipLevel = compInfo.shipInfo[shipID]
  local componentId = comp:GetComponentCfgId()
  local cfg = Cfg.cfg_component_business_ship({
    ComponentID = componentId,
    ShipID = shipID,
    Lv = shipLevel
  })[1]
  return cfg.BaseValue
end

function UIS4TradeData:GetShipMaxValueByID(shipID)
  local comp = self:GetBusinessComp()
  if not comp then
    return
  end
  local componentId = comp:GetComponentCfgId()
  local cfg = Cfg.cfg_component_business_ship({ComponentID = componentId, ShipID = shipID})[1]
  return cfg.MaxValue
end

function UIS4TradeData:GetShipLoadValueByID(harbourID)
  local comp = self:GetBusinessComp()
  if not comp then
    return
  end
  local componentId = comp:GetComponentCfgId()
  local harborCfg = Cfg.cfg_component_business_harbor({ComponentID = componentId, HarborID = harbourID})[1]
  local shipCfg = Cfg.cfg_component_business_ship({ComponentID = componentId, ShipID = harbourID})[1]
  local commandValue, sailValue, fixValue, UnloadSpeed, Boatload = comp:GetNeedPro(harbourID, harborCfg.MaxLv, shipCfg.MaxLv)
  return UnloadSpeed, Boatload
end

function UIS4TradeData:GetShipNeedValueByID(shipID)
  local compInfo = self:GetBusinessCompInfo()
  local comp = self:GetBusinessComp()
  if not compInfo then
    return
  end
  local shipLevel = compInfo.shipInfo[shipID].lv
  local commandValue, sailValue, fixValue = comp:GetNeedPro(shipID)
  return {
    commandValue,
    sailValue,
    fixValue
  }
end

function UIS4TradeData:GetShipCurValueByID(shipID)
  local compInfo = self:GetBusinessCompInfo()
  local comp = self:GetBusinessComp()
  if not compInfo then
    return
  end
  local boatloadValue, commandValue, sailValue, fixValue, incomeRate, income, cdValue = comp:GetFinalPro(shipID)
  return {
    commandValue,
    sailValue,
    fixValue
  }
end

function UIS4TradeData:GetShipProfitAndTimeByID(shipID)
  local compInfo = self:GetBusinessCompInfo()
  local comp = self:GetBusinessComp()
  if not compInfo then
    return
  end
  local boatloadValue, commandValue, sailValue, fixValue, incomeRate, income, cdValue = comp:GetFinalPro(shipID)
  return {
    boatloadValue,
    incomeRate,
    income,
    cdValue
  }
end

function UIS4TradeData:GetShipNextValueByID(shipID)
  local compInfo = self:GetBusinessCompInfo()
  local comp = self:GetBusinessComp()
  if not compInfo then
    return
  end
  local componentId = comp:GetComponentCfgId()
  local shipLevel = compInfo.shipInfo[shipID].lv
  local shipCfg = Cfg.cfg_component_business_ship({ComponentID = componentId, ShipID = shipID})[1]
  local nextShipLevel = shipLevel == shipCfg.MaxLv and shipCfg.MaxLv or shipLevel + 1
  local boatloadValue, commandValue, sailValue, fixValue, incomeRate, income, cdValue = comp:GetFinalPro(shipID, nil, nil, nil, nil, nil, nextShipLevel)
  return {
    commandValue,
    sailValue,
    fixValue
  }
end

function UIS4TradeData:GetShipNextNeedValueByID(shipID)
  local compInfo = self:GetBusinessCompInfo()
  local comp = self:GetBusinessComp()
  if not compInfo then
    return
  end
  local componentId = comp:GetComponentCfgId()
  local shipLevel = compInfo.shipInfo[shipID].lv
  local shipCfg = Cfg.cfg_component_business_ship({ComponentID = componentId, ShipID = shipID})[1]
  local nextShipLevel = shipLevel == shipCfg.MaxLv and shipCfg.MaxLv or shipLevel + 1
  local commandValue, sailValue, fixValue, unloadSpeed, boatloadValue = comp:GetNeedPro(shipID, nil, nextShipLevel)
  return {
    commandValue,
    sailValue,
    fixValue
  }
end

function UIS4TradeData:GetShipOptionValue(shipID, optionValue)
  local comp = self:GetBusinessComp()
  local boatloadValue, commandValue, sailValue, fixValue, incomeRate, income, cdValue = comp:GetFinalPro(shipID, optionValue[1], optionValue[2], optionValue[3], optionValue[4])
  return {
    commandValue,
    sailValue,
    fixValue,
    boatloadValue
  }
end

function UIS4TradeData:GetCrewsByHarbourID(harbourID)
  local crews = {}
  local compInfo = self:GetBusinessCompInfo()
  if not compInfo then
    return
  end
  for id, info in pairs(compInfo.seamanInfo) do
    if info.work_id == harbourID then
      table.insert(crews, id)
    end
  end
  return crews
end

function UIS4TradeData:GetLockHarbourIDByCrewID(crewID)
  local comp = self:GetBusinessComp()
  local componentId = comp:GetComponentCfgId()
  local compInfo = self:GetBusinessCompInfo()
  if not compInfo then
    return
  end
  local harbourID = 1
  local cfgs = Cfg.cfg_component_business_harbor({ComponentID = componentId})
  for _, cfg in pairs(cfgs) do
    if table.icontains(cfg.SeamanPool, crewID) then
      harbourID = cfg.ID
      break
    end
  end
  return harbourID
end

function UIS4TradeData:GetAllBuyCrews()
  local compInfo = self:GetBusinessCompInfo()
  if not compInfo then
    return
  end
  local crews = {}
  for id, info in pairs(compInfo.seamanInfo) do
    table.insert(crews, id)
  end
  crews = self:SortCrew(crews)
  return crews
end

function UIS4TradeData:GetAllNoBuyCrews()
  local comp = self:GetBusinessComp()
  local componentId = comp:GetComponentCfgId()
  local compInfo = self:GetBusinessCompInfo()
  if not compInfo then
    return
  end
  local crews = self:GetAllBuyCrews()
  local noBuyCrews = {}
  local shipInfo = compInfo.shipInfo
  for i, info in pairs(shipInfo) do
    local harborLv, shipLv = self:GetHarborShipLV(i)
    local ship = Cfg.cfg_component_business_harbor({
      ComponentID = componentId,
      HarborID = i,
      Lv = harborLv
    })[1]
    for _, seamanID in pairs(ship.SeamanPool) do
      if not table.icontains(noBuyCrews, seamanID) and not table.icontains(crews, seamanID) then
        table.insert(noBuyCrews, seamanID)
      end
    end
  end
  noBuyCrews = self:SortCrew(noBuyCrews)
  return noBuyCrews
end

function UIS4TradeData:GetAllBuyCrewsExceptID(harbourID)
  local occupyCrews = self:GetCrewsByHarbourID(harbourID)
  local allBuyCrews = self:GetAllBuyCrews()
  local showCrews, noUsingCrews = {}, {}
  for _, v in pairs(allBuyCrews) do
    if not table.icontains(occupyCrews, v) then
      if self:GetCrewsUsingShipID(v) ~= 0 then
        table.insert(showCrews, v)
      else
        table.insert(noUsingCrews, v)
      end
    end
  end
  showCrews = self:SortCrew(showCrews)
  noUsingCrews = self:SortCrew(noUsingCrews)
  for _, v in pairs(noUsingCrews) do
    table.insert(showCrews, v)
  end
  return showCrews
end

function UIS4TradeData:SortCrew(crewIDTb)
  local resTb, cfgTb = {}, {}
  for _, id in pairs(crewIDTb) do
    local cfg = Cfg.cfg_component_business_seaman[id]
    table.insert(cfgTb, cfg)
  end
  table.sort(cfgTb, function(a, b)
    local aShip = self:GetCrewsUsingShipID(a.ID)
    local bShip = self:GetCrewsUsingShipID(b.ID)
    if aShip ~= 0 and bShip ~= 0 then
      if aShip == bShip then
        return a.SortID > b.SortID
      else
        return aShip < bShip
      end
    elseif aShip ~= 0 or bShip ~= 0 then
      return aShip ~= 0
    else
      return a.SortID > b.SortID
    end
  end)
  for _, cfg in pairs(cfgTb) do
    table.insert(resTb, cfg.ID)
  end
  return resTb
end

function UIS4TradeData:GetCrewsUsingShipID(crewID)
  local compInfo = self:GetBusinessCompInfo()
  if not compInfo then
    return
  end
  local crews = compInfo.seamanInfo
  return crews[crewID] and crews[crewID].work_id or 0
end

function UIS4TradeData:ChangeCrewWorkShip(TT, workID, crewID, isAdd)
  local asyncRes = AsyncRequestRes:New()
  local comp = self:GetBusinessComp()
  local crews = self:GetCrewsByHarbourID(workID)
  if isAdd then
    table.insert(crews, crewID)
  else
    table.removev(crews, crewID)
  end
  comp:HandleBusinessWorkSeamanReq(TT, asyncRes, workID, crews)
  return asyncRes
end

function UIS4TradeData:CheckShipIsFull(shipID)
  local crews = self:GetCrewsByHarbourID(shipID)
  return table.count(crews) >= 3
end

function UIS4TradeData:GetNowSpeedAndLoad(Id)
  local HarborCfg = Cfg.cfg_component_business_harbor
  local harborLv, shipLv = self:GetHarborShipLV(Id)
  local NowHarborCfg = HarborCfg({HarborID = Id, Lv = harborLv})[1]
  local NowSpeed = NowHarborCfg.UnloadSpeed
  local NowLoad = self:GetShipProfitAndTimeByID(Id)
  return NowSpeed, NowLoad[1]
end

function UIS4TradeData:GetLvUPHarborSpeed(Id)
  local HarborCfg = Cfg.cfg_component_business_harbor
  local harborLv, shipLv = self:GetHarborShipLV(Id)
  local LvUPHarborCfg = HarborCfg({
    HarborID = Id,
    Lv = harborLv + 1
  })[1]
  local LvUPSpeed = LvUPHarborCfg.UnloadSpeed
  return LvUPSpeed
end

function UIS4TradeData:GetLvUPShipLoad(Id)
  local LvUPShipCfg = Cfg.cfg_component_business_ship
  local harborLv, shipLv = self:GetHarborShipLV(Id)
  local LvUPShipCfg = LvUPShipCfg({
    ShipID = Id,
    Lv = shipLv + 1
  })[1]
  local LvUPLoad = LvUPShipCfg.Boatload
  return LvUPLoad
end

function UIS4TradeData:GetHarborShipLV(Id)
  local LvUPShipCfg = Cfg.cfg_component_business_ship
  local hinfo, sinfo = self:GetInfo(Id)
  local harborLv, shipLv
  if not hinfo then
    harborLv = 0
  else
    harborLv = hinfo.lv
  end
  if not sinfo then
    shipLv = 0
  else
    shipLv = sinfo.lv
  end
  return harborLv, shipLv
end

function UIS4TradeData:GetCoinCount()
  local itemModule = GameGlobal.GetModule(ItemModule)
  local coinId = 3001018
  local talentPointId = 3001019
  local coinNum = itemModule:GetItemCount(coinId)
  local talentPointNum = itemModule:GetItemCount(talentPointId)
  return coinNum, talentPointNum
end

function UIS4TradeData:GetIncomeParams(harbor_id, boatloadValue, commandValue, sailValue, fixValue, harbor_lv, ship_lv)
  local comp = self:GetBusinessComp()
  local boatloadValue, commandValue, sailValue, fixValue, incomeRate, income, cdValue = comp:GetFinalPro(harbor_id, boatloadValue, commandValue, sailValue, fixValue, harbor_lv, ship_lv)
  return incomeRate, income, cdValue
end

function UIS4TradeData:GetHarborShipMaxLevelByID(harbourID)
  local comp = self:GetBusinessComp()
  if not comp then
    return
  end
  local componentId = comp:GetComponentCfgId()
  local harborCfg = Cfg.cfg_component_business_harbor({ComponentID = componentId, HarborID = harbourID})[1]
  local shipCfg = Cfg.cfg_component_business_ship({ComponentID = componentId, ShipID = harbourID})[1]
  return harborCfg.MaxLv, shipCfg.MaxLv
end

function UIS4TradeData:GetHarborIDs()
  local comp = self:GetBusinessComp()
  if not comp then
    return
  end
  local componentId = comp:GetComponentCfgId()
  local harborIDs = {}
  local harborCfg = Cfg.cfg_component_business_harbor({ComponentID = componentId})
  for i, v in ipairs(harborCfg) do
    if not table.icontains(harborIDs, v.HarborID) then
      table.insert(harborIDs, v.HarborID)
    end
  end
  return harborIDs
end
