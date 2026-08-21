_class("BusinessComponent", ICampaignComponent)
BusinessComponent = BusinessComponent

function BusinessComponent:Constructor()
  self._componentInfo = BusinessComponentInfo:New()
end

function BusinessComponent:ComponentInfo()
  if not self._componentInfo then
    self._componentInfo = BusinessComponentInfo:New()
  end
  return self._componentInfo
end

function BusinessComponent:GetComponentInfo()
  return self:ComponentInfo()
end

function BusinessComponent:GetComponentType()
  return CampaignComType.E_CAMPAIGN_BUSINESS
end

function BusinessComponent:InitComponentInfo(a_load_info)
  local ret = ComponentDataHelper.ParseData(a_load_info.m_data, self._componentInfo)
  return ret
end

function BusinessComponent:GetInfo(harbor_id)
  local ComponentInfo = self:ComponentInfo()
  local info = ComponentInfo.harborInfo[harbor_id]
  if info ~= nil then
    return info, ComponentInfo.shipInfo[harbor_id]
  end
  local componentId = self:GetComponentCfgId()
  local cfgHarbor = Cfg.cfg_component_business_harbor({
    ComponentID = componentId,
    HarborID = harbor_id,
    Lv = 1
  })
  if cfgHarbor == nil or cfgHarbor[1] == nil then
    Log.exception("cfg_component_business_harbor 中找不到组件, ID:", componentId)
    return nil, nil
  end
  cfgHarbor = cfgHarbor[1]
  if cfgHarbor.LockItem[1] > 0 then
    local count = GameGlobal.GetModule(ItemModule):GetItemCount(cfgHarbor.LockItem[1])
    if count <= cfgHarbor.LockItem[2] then
      return nil, nil
    end
  end
  local hinfo = BusinessHarborInfo:New()
  hinfo.lv = 1
  ComponentInfo.harborInfo[harbor_id] = hinfo
  local sinfo = BusinessShipInfo:New()
  sinfo.lv = 1
  ComponentInfo.shipInfo[harbor_id] = sinfo
  return hinfo, sinfo
end

function BusinessComponent:GetHarborEvent(harbor_id)
  local ids = {}
  local ComponentInfo = self:ComponentInfo()
  if self:GetInfo(harbor_id) == nil then
    return ids
  end
  local componentId = self:GetComponentCfgId()
  local cfg = Cfg.cfg_component_business_global[ComponentInfo.globalId]
  if cfg == nil or cfg[1] == nil then
    Log.exception("cfg_component_business_global 中找不到, ID:", ComponentInfo.globalId)
    return ids
  end
  local ecom = table.clone(ComponentInfo.eventIdCom)
  
  local function cb(randomIds)
    if table.count(ecom) == table.count(cfg.EventPool) then
      ecom = {}
    end
    for k1, v1 in pairs(cfg.EventPool) do
      if table.intable(ecom, v1) == false then
        table.insert(randomIds, v1)
      end
    end
  end
  
  for i = 1, cfg.OnceRound do
    local randomIds = {}
    cb(randomIds)
    local len = #randomIds
    if len == 0 then
      Log.exception("cfg_component_business_global [table.count(randomIds) == 0] ID:", componentId)
      return ids
    end
    local index = math.random(1, len)
    local newId = randomIds[index]
    table.insert(ids, newId)
    table.insert(ecom, newId)
  end
  return ids
end

function BusinessComponent:GetNeedPro(harbor_id, harbor_lv, ship_lv)
  local harborInfo, shipInfo = self:GetInfo(harbor_id)
  if harborInfo == nil or shipInfo == nil then
    return 0
  end
  local componentId = self:GetComponentCfgId()
  local cfgHarbor = Cfg.cfg_component_business_harbor({
    ComponentID = componentId,
    HarborID = harbor_id,
    Lv = harbor_lv and harbor_lv or harborInfo.lv
  })
  if cfgHarbor == nil or cfgHarbor[1] == nil then
    Log.exception("cfg_component_business_harbor 中找不到组件, ID:", componentId)
    return 0
  end
  local cfgShip = Cfg.cfg_component_business_ship({
    ComponentID = componentId,
    ShipID = harbor_id,
    Lv = ship_lv and ship_lv or shipInfo.lv
  })
  if cfgShip == nil or cfgShip[1] == nil then
    Log.exception("cfg_component_business_ship 中找不到组件, ID:", componentId)
    return 0
  end
  cfgHarbor = cfgHarbor[1]
  cfgShip = cfgShip[1]
  return cfgShip.NeedValue[BusinessProType.BPT_Command + 1], cfgShip.NeedValue[BusinessProType.BPT_Sail + 1], cfgShip.NeedValue[BusinessProType.BPT_Fix + 1], cfgHarbor.UnloadSpeed, cfgShip.Boatload
end

function BusinessComponent:GetFinalPro(harbor_id, boatloadValue, commandValue, sailValue, fixValue, harbor_lv, ship_lv)
  local harborInfo, shipInfo = self:GetInfo(harbor_id)
  if harborInfo == nil or shipInfo == nil then
    return 0
  end
  local componentId = self:GetComponentCfgId()
  local cfgHarbor = Cfg.cfg_component_business_harbor({
    ComponentID = componentId,
    HarborID = harbor_id,
    Lv = harbor_lv and harbor_lv or harborInfo.lv
  })
  if cfgHarbor == nil or cfgHarbor[1] == nil then
    Log.exception("cfg_component_business_harbor 中找不到组件, ID:", componentId)
    return 0
  end
  local cfgShip = Cfg.cfg_component_business_ship({
    ComponentID = componentId,
    ShipID = harbor_id,
    Lv = ship_lv and ship_lv or shipInfo.lv
  })
  if cfgShip == nil or cfgShip[1] == nil then
    Log.exception("cfg_component_business_ship 中找不到组件, ID:", componentId)
    return 0
  end
  cfgHarbor = cfgHarbor[1]
  cfgShip = cfgShip[1]
  boatloadValue = boatloadValue and boatloadValue or 0
  commandValue = commandValue and commandValue or 0
  sailValue = sailValue and sailValue or 0
  fixValue = fixValue and fixValue or 0
  boatloadValue = boatloadValue + cfgShip.Boatload
  if boatloadValue < 0 then
    boatloadValue = 0
  end
  commandValue = commandValue + cfgShip.BaseValue[BusinessProType.BPT_Command + 1]
  sailValue = sailValue + cfgShip.BaseValue[BusinessProType.BPT_Sail + 1]
  fixValue = fixValue + cfgShip.BaseValue[BusinessProType.BPT_Fix + 1]
  for key, value in pairs(shipInfo.seamans) do
    local cfgSeaman = Cfg.cfg_component_business_seaman[value]
    if cfgSeaman == nil then
      Log.exception("cfg_component_business_seaman 中找不到, ID:", value)
      return 0
    end
    commandValue = commandValue + cfgSeaman.ProValue[BusinessProType.BPT_Command + 1]
    sailValue = sailValue + cfgSeaman.ProValue[BusinessProType.BPT_Sail + 1]
    fixValue = fixValue + cfgSeaman.ProValue[BusinessProType.BPT_Fix + 1]
  end
  
  local function callBack(inValue, inNeed)
    if inNeed <= inValue then
      return (inValue / inNeed - 1.0) * cfgShip.PassRate + 1.0
    else
      return inValue / inNeed * (1.0 - cfgShip.NoPassRate - cfgShip.MinRate) + cfgShip.MinRate
    end
  end
  
  local a = callBack(commandValue, cfgShip.NeedValue[BusinessProType.BPT_Command + 1])
  a = a + callBack(sailValue, cfgShip.NeedValue[BusinessProType.BPT_Sail + 1])
  a = a + callBack(fixValue, cfgShip.NeedValue[BusinessProType.BPT_Fix + 1])
  local incomeRate = a / BusinessProType.BPT_Max
  local income = incomeRate * (boatloadValue + cfgShip.BaseRewardValue)
  income = math.floor(income)
  local cdValue = cfgShip.Boatload // cfgHarbor.UnloadSpeed
  cdValue = math.floor(cdValue) * 3600
  return boatloadValue, commandValue, sailValue, fixValue, incomeRate, income, cdValue
end

function BusinessComponent:HandleBusinessSelectReq(TT, asyncRes, harbor_id)
  local request = BusinessSelectReq:New()
  request.harbor_id = harbor_id
  local response = BusinessSelectResult:New()
  local ComponentInfo = self:ComponentInfo()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, ComponentInfo.m_campaign_id, ComponentInfo.m_component_id, request, response)
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= asyncRes.m_result then
    Log.error("[CampaignCom][BusinessComponent] HandleBusinessSelectReq ret:", asyncRes.m_result)
    return nil
  else
    ComponentInfo.harborId = harbor_id
  end
  return response
end

function BusinessComponent:HandleBusinessHarborReq(TT, asyncRes, cfgID)
  local request = BusinessHarborReq:New()
  request.cfg_id = cfgID
  local response = BusinessHarborResult:New()
  local ComponentInfo = self:ComponentInfo()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, ComponentInfo.m_campaign_id, ComponentInfo.m_component_id, request, response)
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= asyncRes.m_result then
    Log.error("[CampaignCom][BusinessComponent] HandleBusinessHarborReq ret:", asyncRes.m_result)
    return nil
  else
    for key, value in pairs(response.info) do
      ComponentInfo.harborInfo[key] = value
    end
  end
  return response
end

function BusinessComponent:HandleBusinessShipReq(TT, asyncRes, cfgID)
  local request = BusinessShipReq:New()
  request.cfg_id = cfgID
  local response = BusinessShipResult:New()
  local ComponentInfo = self:ComponentInfo()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, ComponentInfo.m_campaign_id, ComponentInfo.m_component_id, request, response)
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= asyncRes.m_result then
    Log.error("[CampaignCom][BusinessComponent] HandleBusinessShipReq ret:", asyncRes.m_result)
    return nil
  else
    for key, value in pairs(response.info) do
      ComponentInfo.shipInfo[key] = value
    end
  end
  return response
end

function BusinessComponent:HandleBusinessHireSeamanReq(TT, asyncRes, cfg_id_harbor, cfg_id_seaman)
  local request = BusinessHireSeamanReq:New()
  request.cfg_id_harbor = cfg_id_harbor
  request.cfg_id_seaman = cfg_id_seaman
  local response = BusinessHireSeamanResult:New()
  local ComponentInfo = self:ComponentInfo()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, ComponentInfo.m_campaign_id, ComponentInfo.m_component_id, request, response)
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= asyncRes.m_result then
    Log.error("[CampaignCom][BusinessComponent] HandleBusinessHireSeamanReq ret:", asyncRes.m_result)
    return nil
  else
    for key, value in pairs(response.info) do
      ComponentInfo.seamanInfo[key] = value
    end
  end
  return response
end

function BusinessComponent:HandleBusinessWorkSeamanReq(TT, asyncRes, work_id, seamans)
  local request = BusinessWorkSeamanReq:New()
  request.work_id = work_id
  request.seamans = seamans
  local response = BusinessWorkSeamanResult:New()
  local ComponentInfo = self:ComponentInfo()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, ComponentInfo.m_campaign_id, ComponentInfo.m_component_id, request, response)
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= asyncRes.m_result then
    Log.error("[CampaignCom][BusinessComponent] HandleBusinessWorkSeamanReq ret:", asyncRes.m_result)
    return nil
  else
    for key, value in pairs(response.shipInfo) do
      ComponentInfo.shipInfo[key] = value
    end
    for key, value in pairs(response.seamanInfo) do
      ComponentInfo.seamanInfo[key] = value
    end
  end
  return response
end

function BusinessComponent:HandleBusinessSailingReq(TT, asyncRes, harbor_id, event_ids, event_op, income, cd_time)
  local request = BusinessSailingReq:New()
  request.harbor_id = harbor_id
  request.event_ids = event_ids
  request.event_op = event_op
  request.income = income
  request.cd_time = cd_time
  local response = BusinessSailingResult:New()
  local ComponentInfo = self:ComponentInfo()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, ComponentInfo.m_campaign_id, ComponentInfo.m_component_id, request, response)
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= asyncRes.m_result then
    Log.error("[CampaignCom][BusinessComponent] HandleBusinessSailingReq ret:", asyncRes.m_result)
    return nil
  else
    for key, value in pairs(response.harborInfo) do
      ComponentInfo.harborInfo[key] = value
    end
    for key, value in pairs(response.globalInfo) do
      ComponentInfo.globalInfo[key] = value
    end
    for key, value in pairs(response.eventInfo) do
      ComponentInfo.eventInfo[key] = value
    end
    ComponentInfo.globalId = response.globalId
    ComponentInfo.globalNum = response.globalNum
    ComponentInfo.eventIdCom = response.eventIdCom
  end
  return response
end

function BusinessComponent:GetServerTime()
  local time_mod = GameGlobal.GameLogic():GetModule(SvrTimeModule)
  local tmSecond, nMilliSecond = math.modf(time_mod:GetServerTime() / 1000)
  return tmSecond
end

function BusinessComponent:HasRed()
  local curTime = self:GetServerTime()
  local componentId = self:GetComponentCfgId()
  local cfgHarbor = Cfg.cfg_component_business_harbor({ComponentID = componentId})
  if cfgHarbor == nil then
    Log.exception("cfg_component_business_harbor 中找不到组件, ID:", componentId)
    return false
  end
  local reTab = {}
  for key, value in pairs(cfgHarbor) do
    if reTab[value.HarborID] == nil then
      reTab[value.HarborID] = true
      local harborInfo, shipInfo = self:GetInfo(value.HarborID)
      if harborInfo ~= nil and curTime >= harborInfo.cdEnd then
        return true
      end
    end
  end
  return false
end

function BusinessComponent:HasRedHarborLv()
  local curTime = self:GetServerTime()
  local componentId = self:GetComponentCfgId()
  local cfgHarbor = Cfg.cfg_component_business_harbor({ComponentID = componentId})
  if cfgHarbor == nil then
    Log.exception("cfg_component_business_harbor 中找不到组件, ID:", componentId)
    return false
  end
  local reTab = {}
  for key, value in pairs(cfgHarbor) do
    if reTab[value.HarborID] == nil then
      reTab[value.HarborID] = true
      local harborInfo, shipInfo = self:GetInfo(value.HarborID)
      if harborInfo ~= nil then
        local cfgmap = Cfg.cfg_component_business_harbor({
          ComponentID = componentId,
          HarborID = value.HarborID,
          Lv = harborInfo.lv + 1
        })
        if cfgmap ~= nil and cfgmap[1] ~= nil then
          local cfg = cfgmap[1]
          local isen = false
          if cfg.LockItem[1] > 0 then
            local count = GameGlobal.GetModule(ItemModule):GetItemCount(cfg.LockItem[1])
            if count >= cfg.LockItem[2] then
              isen = true
            end
          else
            isen = true
          end
          if isen == true then
            if cfg.CostItem == nil then
              return true
            else
              for senK, sennV in pairs(cfg.CostItem) do
                local count = GameGlobal.GetModule(ItemModule):GetItemCount(sennV[1])
                if count >= sennV[2] then
                  return true
                end
              end
            end
          end
        end
      end
    end
  end
  return false
end

function BusinessComponent:HasRedShipLv()
  local curTime = self:GetServerTime()
  local componentId = self:GetComponentCfgId()
  local cfgShip = Cfg.cfg_component_business_ship({ComponentID = componentId})
  if cfgShip == nil then
    Log.exception("cfg_component_business_ship 中找不到组件, ID:", componentId)
    return false
  end
  local reTab = {}
  for key, value in pairs(cfgShip) do
    if reTab[value.ShipID] == nil then
      reTab[value.ShipID] = true
      local harborInfo, shipInfo = self:GetInfo(value.ShipID)
      if shipInfo ~= nil then
        local cfgmap = Cfg.cfg_component_business_ship({
          ComponentID = componentId,
          ShipID = value.ShipID,
          Lv = shipInfo.lv + 1
        })
        if cfgmap ~= nil and cfgmap[1] ~= nil then
          local cfg = cfgmap[1]
          if cfg.CostItem == nil then
            return true
          else
            for senK, sennV in pairs(cfg.CostItem) do
              local count = GameGlobal.GetModule(ItemModule):GetItemCount(sennV[1])
              if count >= sennV[2] then
                return true
              end
            end
          end
        end
      end
    end
  end
  return false
end
