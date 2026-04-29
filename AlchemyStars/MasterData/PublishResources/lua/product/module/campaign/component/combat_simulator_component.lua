_class("CombatSimulatorComponent", ICampaignComponent)
CombatSimulatorComponent = CombatSimulatorComponent

function CombatSimulatorComponent:Constructor()
  self.m_component_info = CCombatSimulatorComponentInfo:New()
end

function CombatSimulatorComponent:ComponentInfo()
  if not self.m_component_info then
    self.m_component_info = CCombatSimulatorComponentInfo:New()
  end
  return self.m_component_info
end

function CombatSimulatorComponent:GetComponentInfo()
  return self:ComponentInfo()
end

function CombatSimulatorComponent:GetComponentType()
  return CampaignComType.E_CAMPAIGN_COM_CombatSimulator
end

function CombatSimulatorComponent:InitComponentInfo(a_load_info)
  local ret = ComponentDataHelper.ParseData(a_load_info.m_data, self.m_component_info)
  return ret
end

function CombatSimulatorComponent:GetCampaignMissionComponentId(select_cartridge_pstid)
  local itemModule = GameGlobal.GetModule(ItemModule)
  local item = itemModule:FindItem(select_cartridge_pstid)
  local cartridge_tpl_id = item:GetTemplateID()
  local match_com_id = Cfg.cfg_item_cartridge[cartridge_tpl_id].MatchComId
  return match_com_id
end

function CombatSimulatorComponent:GetCampaignMissionParamKeyMap(select_hard_id, select_cartridge_pstid)
  local ComponentInfo = self:ComponentInfo()
  local nCfgId = self:GetComponetCfgId(ComponentInfo.m_campaign_id, ComponentInfo.m_component_id)
  local l_paramKeyMap = {
    [ECampaignMissionParamKey.ECampaignMissionParamKey_ComCfgId] = nCfgId,
    [ECampaignMissionParamKey.ECampaignMissionParamKey_CSHardId] = select_hard_id,
    [ECampaignMissionParamKey.ECampaignMissionParamKey_CartridgePstId] = select_cartridge_pstid
  }
  return l_paramKeyMap
end

function CombatSimulatorComponent:GetCartridgeItemList()
  local pItemModule = GameGlobal.GetModule(ItemModule)
  local l_item_list = pItemModule:GetItemListBySubType(ItemSubType.ItemSubType_Cam_Cartridge)
  return l_item_list
end

function CombatSimulatorComponent:GetCartridgeGiftCount()
  local pItemModule = GameGlobal.GetModule(ItemModule)
  local l_component_info = self:GetComponentInfo()
  local gift_count = pItemModule:GetItemCount(l_component_info.cartridge_gift_template_id)
  return gift_count
end

function CombatSimulatorComponent:HandleCombatSimulatorComponentRefresh(TT, asyncRes)
  local request = CombatSimulatorComponentRefreshReq:New()
  local response = CombatSimulatorComponentRefreshRep:New()
  local ComponentInfo = self:ComponentInfo()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, ComponentInfo.m_campaign_id, ComponentInfo.m_component_id, request, response)
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= asyncRes.m_result then
    Log.error("[CampaignCom][CombatSimulatorComponent] HandleCombatSimulatorComponentRefresh ret:", asyncRes.m_result)
  end
  self.m_component_info.next_gift_time = response.next_gift_time
end

function CombatSimulatorComponent:HandleCombatSimulatorComponentDelCartridge(TT, asyncRes, item_pstid)
  local request = CombatSimulatorComponentDelCartridgeReq:New()
  local response = CombatSimulatorComponentDelCartridgeRep:New()
  request.cartridge_pst_id = item_pstid
  local ComponentInfo = self:ComponentInfo()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, ComponentInfo.m_campaign_id, ComponentInfo.m_component_id, request, response)
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= asyncRes.m_result then
    Log.error("[CampaignCom][CombatSimulatorComponent] HandleCombatSimulatorComponentDelCartridge ret:", asyncRes.m_result)
  end
end

function CombatSimulatorComponent:HandleCombatSimulatorComponentOpenGift(TT, asyncRes)
  local request = CombatSimulatorComponentOpenGiftReq:New()
  local response = CombatSimulatorComponentOpenGiftRep:New()
  local ComponentInfo = self:ComponentInfo()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, ComponentInfo.m_campaign_id, ComponentInfo.m_component_id, request, response)
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= asyncRes.m_result then
    Log.error("[CampaignCom][CombatSimulatorComponent] HandleCompleteStoryTreeMission ret:", asyncRes.m_result)
    return
  end
  return response.item_template_id
end

function CombatSimulatorComponent:GetCartridgeCeiling()
  return self:GetComponentInfo().max_cartridge_num
end

function CombatSimulatorComponent:GetCartridgeNextGiftTime()
  return self:GetComponentInfo().next_gift_time
end

function CombatSimulatorComponent:GetCartridgeNexTickSec()
  return self:GetComponentInfo().create_cartridge_tick_sec
end

function CombatSimulatorComponent:SortCartridgeItemList(list)
  table.sort(list, function(a, b)
    local cfga = Cfg.cfg_item_cartridge[a:GetTemplateID()]
    local cfgb = Cfg.cfg_item_cartridge[b:GetTemplateID()]
    if cfga.SortID ~= cfgb.SortID then
      return cfga.SortID < cfgb.SortID
    end
    if a:IsNewOverlay() ~= b:IsNewOverlay() then
      return a:IsNewOverlay()
    end
    return a:GetGainTime() > b:GetGainTime()
  end)
end
