_class("SmeltItemComponent", ICampaignComponent)
SmeltItemComponent = SmeltItemComponent

function SmeltItemComponent:Constructor()
  self._componentInfo = SmeltItemComponentInfo:New()
end

function SmeltItemComponent:ComponentInfo()
  if not self._componentInfo then
    self._componentInfo = SmeltItemComponentInfo:New()
  end
  return self._componentInfo
end

function SmeltItemComponent:GetComponentInfo()
  return self:ComponentInfo()
end

function SmeltItemComponent:GetComponentType()
  return CampaignComType.E_CAMPAIGN_SMELT_ITEM
end

function SmeltItemComponent:InitComponentInfo(a_load_info)
  local ret = ComponentDataHelper.ParseData(a_load_info.m_data, self._componentInfo)
  return ret
end

function SmeltItemComponent:GetCurList()
  local componentId = self:GetComponentCfgId()
  local cfgV = Cfg.cfg_component_smelt_item({ComponentID = componentId})
  if cfgV == nil then
    Log.exception("cfg_component_smelt_item 中找不到组件ID:", componentId)
    return nil
  end
  if self._componentInfo == nil then
    return nil
  end
  local idlist = {}
  for ck, cfg in pairs(cfgV) do
    if self._componentInfo.m_info[cfg.ID] == nil then
      if cfg.LockID ~= nil and cfg.LockID ~= 0 then
        if self._componentInfo.m_info[cfg.LockID] ~= nil then
          table.insert(idlist, cfg.ID)
        end
      else
        table.insert(idlist, cfg.ID)
      end
    end
  end
  return idlist
end

function SmeltItemComponent:HandleReceiveSmeltItemReward(TT, asyncRes, cfgID)
  local request = SmeltItemComponentReceiveRewardReq:New()
  request.m_cfg_id = cfgID
  local response = SmeltItemComponentReceiveRewardRep:New()
  local ComponentInfo = self:ComponentInfo()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, ComponentInfo.m_campaign_id, ComponentInfo.m_component_id, request, response)
  if response ~= nil and table.count(response.m_info) > 0 then
    self._componentInfo.m_info = response.m_info
  end
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= asyncRes.m_result then
    Log.error("[CampaignCom][SmeltItemComponent] HandleReceiveSmeltItemReward ret:", asyncRes.m_result)
    return nil
  end
  return response
end
