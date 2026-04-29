require("component_base")
_class("TurnCardComponent", ICampaignComponent)
TurnCardComponent = TurnCardComponent

function TurnCardComponent:Constructor()
  self.m_component_info = TurnCardComponentInfo:New()
  self.unturned_matrix = {}
end

function TurnCardComponent:ComponentInfo()
  if not self.m_component_info then
    self.m_component_info = TurnCardComponentInfo:New()
  end
  return self.m_component_info
end

function TurnCardComponent:GetComponentInfo()
  return self:ComponentInfo()
end

function TurnCardComponent:GetComponentType()
  return CampaignComType.E_CAMPAIGN_COM_TURNCARD
end

function TurnCardComponent:InitComponentInfo(a_load_info)
  local ret = ComponentDataHelper.ParseData(a_load_info.m_data, self.m_component_info)
  return ret
end

function TurnCardComponent:HandleTurnCardOperate(TT, asyncRes, turn_card_id, cell_index)
  local request = TurnCardOperateReq:New()
  request.turn_card_id = turn_card_id
  request.index = cell_index
  local response = TurnCardOperateRep:New()
  local ComponentInfo = self:ComponentInfo()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, ComponentInfo.m_campaign_id, ComponentInfo.m_component_id, request, response)
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= asyncRes.m_result then
    Log.error("[CampaignCom][TurnCardComponent] HandleTurnCardOperate ret:", asyncRes.m_result)
    return nil
  end
  if self.unturned_matrix[turn_card_id] ~= nil then
    self.unturned_matrix[turn_card_id][cell_index] = nil
  end
  asyncRes:SetSucc(true)
  return response.reward
end

function TurnCardComponent:CampaignComponentPushNotify(notify_data)
  if TurnCardComponentNotifyType.TurnCardComponentNotifyType_InfoChanged == notify_data.m_notify_type then
    local ev = NotifyTurnCardComponentInfoChanged:New()
    local ret = ComponentDataHelper.ParseData(notify_data.m_data, ev)
    if ret then
      self.m_component_info.m_matrix = ev.m_matrix
      for key, value in pairs(self.m_component_info.m_matrix) do
        self.unturned_matrix[key] = self:UnturnedCell(value)
      end
    else
      Log.error("[CampaignCom][TurnCardComponent] CampaignComponentPushNotify ParseData error! ret:", ret)
    end
  end
end

function TurnCardComponent:IsLackItem(cost_item)
  local lack_item = false
  local roleModule = GameGlobal.GetModule(RoleModule)
  for _, cost_roleasset in pairs(cost_item) do
    local left_item = roleModule:GetAssetCount(cost_roleasset[1])
    if left_item < cost_roleasset[2] then
      lack_item = true
      return lack_item
    end
  end
  return lack_item
end

function TurnCardComponent:UnturnedCell(matrix_item_list)
  local unturned_cell_index = {}
  for _, each_item in pairs(matrix_item_list.m_matrix_item) do
    for cell_index, is_turn in pairs(each_item.m_is_turn) do
      if is_turn == false then
        unturned_cell_index[cell_index] = cell_index
      end
    end
  end
  return unturned_cell_index
end
