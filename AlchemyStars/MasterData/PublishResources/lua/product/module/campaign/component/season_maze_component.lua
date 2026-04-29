_class("SeasonMazeComponent", ICampaignComponent)
SeasonMazeComponent = SeasonMazeComponent

function SeasonMazeComponent:Constructor()
  self._componentInfo = SeasonMazeComponentInfo:New()
end

function SeasonMazeComponent:ComponentInfo()
  if not self._componentInfo then
    self._componentInfo = SeasonMazeComponentInfo:New()
  end
  return self._componentInfo
end

function SeasonMazeComponent:GetComponentInfo()
  return self:ComponentInfo()
end

function SeasonMazeComponent:GetComponentType()
  return CampaignComType.E_CAMPAIGN_SEASON_MAZE
end

function SeasonMazeComponent:InitComponentInfo(a_load_info)
  local ret = ComponentDataHelper.ParseData(a_load_info.m_data, self._componentInfo)
  return ret
end

function SeasonMazeComponent:CurOperate()
  local comInfo = self:ComponentInfo()
  return comInfo.cur_state
end

function SeasonMazeComponent:GetOnceNum(cfgId)
  local comInfo = self:ComponentInfo()
  local inon = comInfo.m_bag_info.once_item_list[cfgId]
  return inon or 0
end

function SeasonMazeComponent:GetEffectNum(effectType, id)
  local comInfo = self:ComponentInfo()
  if comInfo == nil then
    return 0
  end
  if effectType == SeasonMazeEffectType.SMET_Pet then
    local inon = comInfo.m_bag_info.pet_list[id]
    return inon and 1 or 0
  elseif effectType == SeasonMazeEffectType.SMET_Relic then
    local inon = comInfo.m_bag_info.relic_list[id]
    return inon and 1 or 0
  elseif effectType == SeasonMazeEffectType.SMET_Once then
    local inon = comInfo.m_bag_info.once_item_list[id]
    return inon or 0
  elseif effectType == SeasonMazeEffectType.SMET_Pro then
    return self:GetAttrValue(id)
  elseif effectType == SeasonMazeEffectType.SMET_Hand then
    local inon = comInfo.wait_hands[id]
    if inon == nil then
      inon = comInfo.fold_hands[id]
    end
    return inon and 1 or 0
  elseif effectType == SeasonMazeEffectType.SMET_Bead then
    local num = 0
    for k, v in pairs(comInfo.m_auto_bead_map) do
      if v.bead_info.cfg_id == id then
        num = num + 1
      end
    end
    return num
  end
  return 0
end

function SeasonMazeComponent:CampaignComponentPushNotify(notify_data)
  if SeasonMazeComponentNotifyType.SeasonMazeComponentNotifyType_Ore == notify_data.m_notify_type then
    self:NotifyOre(notify_data.m_data)
  end
  if SeasonMazeComponentNotifyType.SeasonMazeComponentNotifyType_Extract == notify_data.m_notify_type then
    self:NotifyExtract(notify_data.m_data)
  end
  if SeasonMazeComponentNotifyType.SeasonMazeComponentNotifyType_Boss == notify_data.m_notify_type then
    self:NotifyBoss(notify_data.m_data)
  end
  if SeasonMazeComponentNotifyType.SeasonMazeComponentNotifyType_Room == notify_data.m_notify_type then
    self:NotifyRoom(notify_data.m_data)
  end
  if SeasonMazeComponentNotifyType.SeasonMazeComponentNotifyType_OnceItem == notify_data.m_notify_type then
    self:NotifyOnceItem(notify_data.m_data)
  end
  if SeasonMazeComponentNotifyType.SeasonMazeComponentNotifyType_RandomRelic == notify_data.m_notify_type then
    self:NotifyRandomRelic(notify_data.m_data)
  end
  if SeasonMazeComponentNotifyType.SeasonMazeComponentNotifyType_NewHand == notify_data.m_notify_type then
    self:NotifyNewHand(notify_data.m_data)
  end
  if SeasonMazeComponentNotifyType.SeasonMazeComponentNotifyType_HandBag == notify_data.m_notify_type then
    self:NotifyHandBag(notify_data.m_data)
  end
  if SeasonMazeComponentNotifyType.SeasonMazeComponentNotifyType_CurState == notify_data.m_notify_type then
    self:NotifyCurState(notify_data.m_data)
  end
  if SeasonMazeComponentNotifyType.SeasonMazeComponentNotifyType_AutoBeadChange == notify_data.m_notify_type then
    self:NotifyAutoBeadChange(notify_data.m_data)
  end
  if SeasonMazeComponentNotifyType.SeasonMazeComponentNotifyType_AttrChange == notify_data.m_notify_type then
    self:NotifyAttrChange(notify_data.m_data)
  end
  if SeasonMazeComponentNotifyType.SeasonMazeComponentNotifyType_PetChange == notify_data.m_notify_type then
    self:NotifyPetChange(notify_data.m_data)
  end
  if SeasonMazeComponentNotifyType.SeasonMazeComponentNotifyType_SuitInfo == notify_data.m_notify_type then
    self:NotifySuitInfoChange(notify_data.m_data)
  end
  if SeasonMazeComponentNotifyType.SeasonMazeComponentNotifyType_Relic == notify_data.m_notify_type then
    self:NotifyRelicChange(notify_data.m_data)
  end
  if SeasonMazeComponentNotifyType.SeasonMazeComonentNotifyFormationChange == notify_data.m_notify_type then
    self:NotifyFormationChange(notify_data.m_data)
  end
  if SeasonMazeComponentNotifyType.SeasonMazeComponentNotifyType_AutoBeadSlotUnLock == notify_data.m_notify_type then
    self:NotifyBeadFitChange(notify_data.m_data)
  end
end

function SeasonMazeComponent:NotifyBeadFitChange(data)
  local ev = SeasonMazeNotifyAutoBeadSlotUnlock:New()
  local ret = ComponentDataHelper.ParseData(data, ev)
  if ret then
    self._componentInfo.m_auto_bead_fit_list = ev.auto_bead_fit
  else
    Log.error("[CampaignCom][SeasonMazeComponent] NotifyBeadFitChange ParseData error! ret:", ret)
  end
end

function SeasonMazeComponent:NotifyFormationChange(data)
  local ev = SeasonMazeNotifyFormationChange:New()
  local ret = ComponentDataHelper.ParseData(data, ev)
  if ret then
    self._componentInfo.m_formation_list = ev.m_formation_list
  else
    Log.error("[CampaignCom][SeasonMazeComponent] NotifyFormationChange ParseData error! ret:", ret)
  end
end

function SeasonMazeComponent:NotifyRelicChange(data)
  local ev = SeasonMazeNotifyRelicChange:New()
  local ret = ComponentDataHelper.ParseData(data, ev)
  if ret then
    for k, v in pairs(ev.relic_list) do
      self._componentInfo.m_bag_info.relic_list[k] = v
    end
  else
    Log.error("[CampaignCom][SeasonMazeComponent] NotifyRelicChange ParseData error! ret:", ret)
  end
end

function SeasonMazeComponent:NotifySuitInfoChange(data)
  local ev = SeasonMazeNotifySuitInfoChange:New()
  local ret = ComponentDataHelper.ParseData(data, ev)
  if ret then
    self._componentInfo.suit_info = ev.info
  else
    Log.error("[CampaignCom][SeasonMazeComponent] NotifySuitInfoChange ParseData error! ret:", ret)
  end
end

function SeasonMazeComponent:NotifyRoom(data)
  local ev = SeasonMazeNotifyRoom:New()
  local ret = ComponentDataHelper.ParseData(data, ev)
  if ret then
    for key, value in pairs(ev.rooms) do
      self._componentInfo.rooms[key] = value
    end
  else
    Log.error("SeasonMazeComponent:SeasonMazeNotifyRoom ParseData error! ret:", ret)
  end
end

function SeasonMazeComponent:NotifyOre(data)
  local ev = SeasonMazeNotifyOre:New()
  local ret = ComponentDataHelper.ParseData(data, ev)
  if ret then
    self._componentInfo.occupy_ore = ev.occupy_ore
  else
    Log.error("SeasonMazeComponent:NotifyOre ParseData error! ret:", ret)
  end
end

function SeasonMazeComponent:NotifyExtract(data)
  self._extra_hands_data = nil
  local ev = SeasonMazeNotifyExtract:New()
  local ret = ComponentDataHelper.ParseData(data, ev)
  if ret then
    self._extra_hands_data = ev
  else
    Log.error("SeasonMazeComponent:NotifyExtract ParseData error! ret:", ret)
  end
end

function SeasonMazeComponent:NotifyBoss(data)
  local ev = SeasonMazeNotifyBoss:New()
  local ret = ComponentDataHelper.ParseData(data, ev)
  if ret then
    for key, value in pairs(ev.boss_info) do
      self._componentInfo.boss_info[key] = value
    end
  else
    Log.error("SeasonMazeComponent:NotifyBoss ParseData error! ret:", ret)
  end
end

function SeasonMazeComponent:NotifyCurState(data)
  local ev = SeasonMazeNotifyCurState:New()
  local ret = ComponentDataHelper.ParseData(data, ev)
  if ret then
    self._componentInfo.cur_state = ev.cur_state
  else
    Log.error("SeasonMazeComponent:NotifyCurState ParseData error! ret:", ret)
  end
end

function SeasonMazeComponent:NotifyOnceItem(data)
  local ev = SeasonMazeNotifyOnceItem:New()
  local ret = ComponentDataHelper.ParseData(data, ev)
  if ret then
    for key, value in pairs(ev.list) do
      self._componentInfo.m_bag_info.once_item_list[key] = value
    end
  else
    Log.error("SeasonMazeComponent:NotifyOnceItem ParseData error! ret:", ret)
  end
end

function SeasonMazeComponent:NotifyRandomRelic(data)
  local ev = SeasonMazeNotifyRandomRelic:New()
  local ret = ComponentDataHelper.ParseData(data, ev)
  if ret then
    self._componentInfo.relic_random = ev.relic_random
  else
    Log.error("SeasonMazeComponent:NotifyRandomRelic ParseData error! ret:", ret)
  end
end

function SeasonMazeComponent:NotifyNewHand(data)
  local ev = SeasonMazeNotifyNewHand:New()
  local ret = ComponentDataHelper.ParseData(data, ev)
  if ret then
    self._componentInfo.new_hands = ev.new_hands
  else
    Log.error("SeasonMazeComponent:NotifyNewHand ParseData error! ret:", ret)
  end
end

function SeasonMazeComponent:NotifyHandBag(data)
  local ev = SeasonMazeNotifyHandBag:New()
  local ret = ComponentDataHelper.ParseData(data, ev)
  if ret then
    self._componentInfo.wait_hands = ev.wait_hands
    self._componentInfo.fold_hands = ev.fold_hands
    self._componentInfo.rand_hands = ev.rand_hands
  else
    Log.error("SeasonMazeComponent:NotifyHandBag ParseData error! ret:", ret)
  end
end

function SeasonMazeComponent:NotifyAttrChange(data)
  local ev = SeasonMazeNotifyAttrChange:New()
  local ret = ComponentDataHelper.ParseData(data, ev)
  if ret then
    for k, v in pairs(ev.attr_change) do
      local ov = self._componentInfo.attr_list[k]
      self._componentInfo.attr_list[k] = v
      GameGlobal.GetModule(SeasonMazeModule):SetAttrReason(k, ev.attr_reason[k], ov, v)
    end
  else
    Log.error("[CampaignCom][SeasonMazeComponent] NotifyAttrChange ParseData error! ret:", ret)
  end
end

function SeasonMazeComponent:NotifyAutoBeadChange(data)
  local ev = SeasonMazeNotifyAutoBeadChange:New()
  local ret = ComponentDataHelper.ParseData(data, ev)
  if ret then
    for k, v in pairs(ev.bead_map) do
      self._componentInfo.m_auto_bead_map[k] = v
    end
    self._componentInfo.m_new_auto_bead_cnt = ev.new_cnt
  else
    Log.error("[CampaignCom][SeasonMazeComponent] NotifyAutoBeadChange ParseData error! ret:", ret)
  end
end

function SeasonMazeComponent:NotifyPetChange(data)
  local ev = SeasonMazeNotifyPetChange:New()
  local ret = ComponentDataHelper.ParseData(data, ev)
  if ret then
    for i, v in pairs(ev.pet_list) do
      self._componentInfo.m_bag_info.pet_list[v.petID] = v
      local ore = self._componentInfo.occupy_ore[v.petID]
      if ore ~= nil and self:GetPetState(v.petID, ESeasonMazePetStateType.ESeasonMazePetStateType_Dispatch) ~= true then
        Log.info("派遣结束:", v.petID)
        self._componentInfo.occupy_ore[v.petID] = nil
        ToastManager.ShowToast(StringTable.Get("str_season_maze_ore_room_tips_back"))
      end
    end
  else
    Log.error("[CampaignCom][SeasonMazeComponent] NotifyPetStateChange ParseData error! ret:", ret)
  end
end

function SeasonMazeComponent:CopyInfo(msgInfo)
  self._componentInfo.enter_time = msgInfo.enter_time
  self._componentInfo.hard = msgInfo.hard
  self._componentInfo.rooms = msgInfo.rooms
  self._componentInfo.wait_hands = msgInfo.wait_hands
  self._componentInfo.fold_hands = msgInfo.fold_hands
  self._componentInfo.rand_hands = msgInfo.rand_hands
  self._componentInfo.boss_info = msgInfo.boss_info
  self._componentInfo.cur_hand = msgInfo.cur_hand
  self._componentInfo.past_hand = msgInfo.past_hand
  self._componentInfo.cur_point = msgInfo.cur_point
  self._componentInfo.do_layer_num = msgInfo.do_layer_num
  self._componentInfo.hard_num = msgInfo.hard_num
  self._componentInfo.tmp_point = msgInfo.tmp_point
  self._componentInfo.occupy_ore = msgInfo.occupy_ore
  self._componentInfo.cur_state = msgInfo.cur_state
  self._componentInfo.save_info = msgInfo.save_info
  self._componentInfo.slot_info = msgInfo.slot_info
  self._componentInfo.relic_random = msgInfo.relic_random
  self._componentInfo.new_hands = msgInfo.new_hands
  self._componentInfo.round_num = msgInfo.round_num
  self._componentInfo.suit_info = msgInfo.suit_info
  self._componentInfo.attr_list = msgInfo.attr_list
  self._componentInfo.m_formation_list = msgInfo.m_formation_list
  self._componentInfo.m_init_select = msgInfo.m_init_select
  self._componentInfo.m_auto_bead_map = msgInfo.m_auto_bead_map
  self._componentInfo.m_auto_bead_fit_list = msgInfo.m_auto_bead_fit_list
  self._componentInfo.m_new_auto_bead_cnt = msgInfo.m_new_auto_bead_cnt
  self._componentInfo.m_bag_info = msgInfo.m_bag_info
  self._componentInfo.m_world_boss_info = msgInfo.m_world_boss_info
  self._componentInfo.m_recruit_room_pet_list = msgInfo.m_recruit_room_pet_list
  self._componentInfo.m_recruit_room_reflush_cnt = msgInfo.m_recruit_room_reflush_cnt
  self._componentInfo.manunl_ban_pets = msgInfo.manunl_ban_pets
end

function SeasonMazeComponent:HandleSeasonMazeSelectHard(TT, asyncRes, harId, pet_list)
  local request = SeasonMazeSelectHardReq:New()
  local response = SeasonMazeSelectHardResult:New()
  request.hard = harId
  request.pet_list = pet_list
  local ComponentInfo = self:ComponentInfo()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, ComponentInfo.m_campaign_id, ComponentInfo.m_component_id, request, response)
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= asyncRes.m_result then
    asyncRes:SetResult(asyncRes.m_result)
    Log.error("SeasonMazeComponent:HandleSeasonMazeSelectHard ret:", asyncRes.m_result)
    return nil
  end
  self:CopyInfo(response.info)
  return response
end

function SeasonMazeComponent:HandleSeasonMazeRandomHand(TT, asyncRes)
  local request = SeasonMazeRandomHandReq:New()
  local response = SeasonMazeRandomHandResult:New()
  local ComponentInfo = self:ComponentInfo()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, ComponentInfo.m_campaign_id, ComponentInfo.m_component_id, request, response)
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= asyncRes.m_result then
    asyncRes:SetResult(asyncRes.m_result)
    Log.error("SeasonMazeComponent:HandleSeasonMazeRandomHand ret:", asyncRes.m_result)
    return nil
  end
  local cnt = table.count(ComponentInfo.round_num)
  ComponentInfo.round_num[cnt] = 0
  ComponentInfo.wait_hands = response.wait_hands
  ComponentInfo.fold_hands = response.fold_hands
  ComponentInfo.rand_hands = response.rand_hands
  return response
end

function SeasonMazeComponent:HandleSeasonMazeChooseHand(TT, asyncRes, id)
  local request = SeasonMazeChooseHandReq:New()
  local response = SeasonMazeChooseHandResult:New()
  request.id = id
  local ComponentInfo = self:ComponentInfo()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, ComponentInfo.m_campaign_id, ComponentInfo.m_component_id, request, response)
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= asyncRes.m_result then
    asyncRes:SetResult(asyncRes.m_result)
    Log.error("SeasonMazeComponent:HandleSeasonMazeChooseHand ret:", asyncRes.m_result)
    return nil
  end
  ComponentInfo.cur_hand = response.cur_hand
  ComponentInfo.wait_hands = response.wait_hands
  ComponentInfo.fold_hands = response.fold_hands
  ComponentInfo.rand_hands = response.rand_hands
  return response
end

function SeasonMazeComponent:HandleSeasonMazeGoPoint(TT, asyncRes, pointId, isTmp)
  local request = SeasonMazeGoPointReq:New()
  local response = SeasonMazeGoPointResult:New()
  request.id = pointId
  request.is_tmp = isTmp
  local ComponentInfo = self:ComponentInfo()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, ComponentInfo.m_campaign_id, ComponentInfo.m_component_id, request, response)
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= asyncRes.m_result then
    asyncRes:SetResult(asyncRes.m_result)
    Log.error("SeasonMazeComponent:HandleSeasonMazeGoPoint ret:", asyncRes.m_result)
    return nil
  end
  if isTmp then
    ComponentInfo.tmp_point = response.tmp_point
  else
    ComponentInfo.cur_hand = response.cur_hand
    for key, value in pairs(response.rooms) do
      ComponentInfo.rooms[key] = value
    end
    ComponentInfo.past_hand = response.past_hand
    ComponentInfo.cur_point = response.cur_point
  end
  return response
end

function SeasonMazeComponent:HandleSeasonMazeBattle(TT, asyncRes)
  local request = SeasonMazeBattleReq:New()
  local response = SeasonMazeBattleResult:New()
  local ComponentInfo = self:ComponentInfo()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, ComponentInfo.m_campaign_id, ComponentInfo.m_component_id, request, response)
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= asyncRes.m_result then
    asyncRes:SetResult(asyncRes.m_result)
    Log.error("SeasonMazeComponent:HandleSeasonMazeBattle ret:", asyncRes.m_result)
    return nil
  end
  for key, value in pairs(response.rooms) do
    ComponentInfo.rooms[key] = value
  end
  return response
end

function SeasonMazeComponent:HandleSeasonMazeEvent(TT, asyncRes, cfgId)
  local request = SeasonMazeEventReq:New()
  local response = SeasonMazeEventResult:New()
  request.cfg_id = cfgId
  local ComponentInfo = self:ComponentInfo()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, ComponentInfo.m_campaign_id, ComponentInfo.m_component_id, request, response)
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= asyncRes.m_result then
    asyncRes:SetResult(asyncRes.m_result)
    Log.error("SeasonMazeComponent:HandleSeasonMazeEvent ret:", asyncRes.m_result)
    return nil
  end
  for key, value in pairs(response.rooms) do
    ComponentInfo.rooms[key] = value
  end
  return response
end

function SeasonMazeComponent:HandleSeasonMazeResource(TT, asyncRes)
  local request = SeasonMazeResourceReq:New()
  local response = SeasonMazeResourceResult:New()
  local ComponentInfo = self:ComponentInfo()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, ComponentInfo.m_campaign_id, ComponentInfo.m_component_id, request, response)
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= asyncRes.m_result then
    asyncRes:SetResult(asyncRes.m_result)
    Log.error("SeasonMazeComponent:HandleSeasonMazeResource ret:", asyncRes.m_result)
    return nil
  end
  for key, value in pairs(response.rooms) do
    ComponentInfo.rooms[key] = value
  end
  return response
end

function SeasonMazeComponent:HandleSeasonMazeOre(TT, asyncRes, cfg_id, is_do, rd_index)
  local request = SeasonMazeOreReq:New()
  local response = SeasonMazeOreResult:New()
  request.cfg_id = cfg_id
  request.is_do = is_do
  request.rd_index = rd_index
  local ComponentInfo = self:ComponentInfo()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, ComponentInfo.m_campaign_id, ComponentInfo.m_component_id, request, response)
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= asyncRes.m_result then
    asyncRes:SetResult(asyncRes.m_result)
    Log.error("SeasonMazeComponent:HandleSeasonMazeOre ret:", asyncRes.m_result)
    return nil
  end
  if is_do then
    for key, value in pairs(response.rooms) do
      ComponentInfo.rooms[key] = value
    end
    for key, value in pairs(response.occupy_ore) do
      ComponentInfo.occupy_ore[key] = value
    end
  else
    ComponentInfo.occupy_ore[cfg_id] = nil
  end
  return response
end

function SeasonMazeComponent:HandleSeasonMazeBox(TT, asyncRes, index)
  local request = SeasonMazeBoxReq:New()
  local response = SeasonMazeBoxResult:New()
  request.index = index
  local ComponentInfo = self:ComponentInfo()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, ComponentInfo.m_campaign_id, ComponentInfo.m_component_id, request, response)
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= asyncRes.m_result then
    asyncRes:SetResult(asyncRes.m_result)
    Log.error("SeasonMazeComponent:HandleSeasonMazeBox ret:", asyncRes.m_result)
    return nil
  end
  for key, value in pairs(response.rooms) do
    ComponentInfo.rooms[key] = value
  end
  return response
end

function SeasonMazeComponent:HandleSeasonMazeRound(TT, asyncRes)
  local request = SeasonMazeRoundReq:New()
  local response = SeasonMazeRoundResult:New()
  local ComponentInfo = self:ComponentInfo()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, ComponentInfo.m_campaign_id, ComponentInfo.m_component_id, request, response)
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= asyncRes.m_result then
    asyncRes:SetResult(asyncRes.m_result)
    Log.error("SeasonMazeComponent:HandleSeasonMazeRound ret:", asyncRes.m_result)
    return nil
  end
  for key, value in pairs(response.rooms) do
    ComponentInfo.rooms[key] = value
  end
  return response
end

function SeasonMazeComponent:HandleSeasonMazeAltar(TT, asyncRes, cfg_id, is_delet, index)
  local request = SeasonMazeAltarReq:New()
  local response = SeasonMazeAltarResult:New()
  request.cfg_id = cfg_id
  request.is_delet = is_delet
  request.index = index
  local ComponentInfo = self:ComponentInfo()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, ComponentInfo.m_campaign_id, ComponentInfo.m_component_id, request, response)
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= asyncRes.m_result then
    asyncRes:SetResult(asyncRes.m_result)
    Log.error("SeasonMazeComponent:HandleSeasonMazeAltar ret:", asyncRes.m_result)
    return nil
  end
  local list = index == 0 and ComponentInfo.wait_hands or ComponentInfo.fold_hands
  if is_delet then
    table.removev(list, cfg_id)
  else
    table.removev(list, cfg_id)
    table.insert(ComponentInfo.wait_hands, response.cfg_id)
  end
  for key, value in pairs(response.rooms) do
    ComponentInfo.rooms[key] = value
  end
  return response
end

function SeasonMazeComponent:HandleSeasonMazeRoomEnd(TT, asyncRes)
  local request = SeasonMazeRoomEndReq:New()
  local response = SeasonMazeRoomEndResult:New()
  local ComponentInfo = self:ComponentInfo()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, ComponentInfo.m_campaign_id, ComponentInfo.m_component_id, request, response)
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= asyncRes.m_result then
    asyncRes:SetResult(asyncRes.m_result)
    Log.error("SeasonMazeComponent:HandleSeasonMazeRoomEnd ret:", asyncRes.m_result)
    return nil
  end
  if table.count(response.rooms) > 0 then
    for key, value in pairs(response.rooms) do
      ComponentInfo.rooms[key] = value
    end
  else
    self:CopyInfo(response.info)
  end
  local curRoom = self._componentInfo.rooms[self._componentInfo.cur_point]
  if curRoom ~= nil and (curRoom.type == SeasonMazeRoomType.SMRT_Shop or curRoom.type == SeasonMazeRoomType.SMRT_BeadShop) then
    self._componentInfo.slot_info.items = {}
    self._componentInfo.slot_info.reset_cnt = 0
    self._componentInfo.slot_info.dis_index = 0
  end
  self._componentInfo.cur_state = response.cur_state
  return response
end

function SeasonMazeComponent:HandleSeasonMazeChooseRelic(TT, asyncRes, index, operate)
  local request = SeasonMazeChooseRelicReq:New()
  local response = SeasonMazeChooseRelicResult:New()
  request.index = index
  request.operate = operate
  local ComponentInfo = self:ComponentInfo()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, ComponentInfo.m_campaign_id, ComponentInfo.m_component_id, request, response)
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= asyncRes.m_result then
    asyncRes:SetResult(asyncRes.m_result)
    Log.error("SeasonMazeComponent:HandleSeasonMazeChooseRelic ret:", asyncRes.m_result)
    return nil
  end
  ComponentInfo.relic_random = response.relic_random
  ComponentInfo.cur_state = response.cur_state
  return response
end

function SeasonMazeComponent:HandleSeasonMazeNewHand(TT, asyncRes, index)
  local request = SeasonMazeNewHandReq:New()
  local response = SeasonMazeNewHandResult:New()
  request.index = index
  local ComponentInfo = self:ComponentInfo()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, ComponentInfo.m_campaign_id, ComponentInfo.m_component_id, request, response)
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= asyncRes.m_result then
    asyncRes:SetResult(asyncRes.m_result)
    Log.error("SeasonMazeComponent:HandleSeasonMazeNewHand ret:", asyncRes.m_result)
    return nil
  end
  ComponentInfo.new_hands = response.new_hands
  ComponentInfo.cur_state = response.cur_state
  return response
end

function SeasonMazeComponent:HandleSeasonMazeGetMarket(TT, asyncRes)
  local request = SeasonMazeGetMarketReq:New()
  local response = SeasonMazeGetMarketResult:New()
  local ComponentInfo = self:ComponentInfo()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, ComponentInfo.m_campaign_id, ComponentInfo.m_component_id, request, response)
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= asyncRes.m_result then
    asyncRes:SetResult(asyncRes.m_result)
    Log.error("SeasonMazeComponent:HandleSeasonMazeGetMarket ret:", asyncRes.m_result)
    return nil
  end
  for key, value in pairs(response.rooms) do
    ComponentInfo.rooms[key] = value
  end
  return response
end

function SeasonMazeComponent:HandleSeasonMazeOperaMarket(TT, asyncRes, pst_id, unique_id)
  local request = SeasonMazeOperaMarketReq:New()
  local response = SeasonMazeOperaMarketResult:New()
  request.pst_id = pst_id
  request.unique_id = unique_id
  local ComponentInfo = self:ComponentInfo()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, ComponentInfo.m_campaign_id, ComponentInfo.m_component_id, request, response)
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= asyncRes.m_result then
    asyncRes:SetResult(asyncRes.m_result)
    Log.error("SeasonMazeComponent:HandleSeasonMazeOperaMarket ret:", asyncRes.m_result)
    return nil
  end
  for key, value in pairs(response.rooms) do
    ComponentInfo.rooms[key] = value
  end
  return response
end

function SeasonMazeComponent:HandleSeasonMazeRoundEnd(TT, asyncRes)
  local request = SeasonMazeRoundEndReq:New()
  local response = SeasonMazeRoundEndResult:New()
  local ComponentInfo = self:ComponentInfo()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, ComponentInfo.m_campaign_id, ComponentInfo.m_component_id, request, response)
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= asyncRes.m_result then
    asyncRes:SetResult(asyncRes.m_result)
    Log.error("SeasonMazeComponent:HandleSeasonMazeRoundEnd ret:", asyncRes.m_result)
    return nil
  end
  for key, value in pairs(ComponentInfo.round_num) do
    if value <= 0 then
      ComponentInfo.round_num[key] = 1
      break
    end
  end
  return response
end

function SeasonMazeComponent:HandleSeasonMazeClearing(TT, asyncRes, is_initiative)
  local request = SeasonMazeClearingReq:New()
  local response = SeasonMazeClearingResult:New()
  request.is_initiative = is_initiative or false
  local ComponentInfo = self:ComponentInfo()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, ComponentInfo.m_campaign_id, ComponentInfo.m_component_id, request, response)
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= asyncRes.m_result then
    asyncRes:SetResult(asyncRes.m_result)
    Log.error("SeasonMazeComponent:HandleSeasonMazeClearing ret:", asyncRes.m_result)
    return nil
  end
  self:CopyInfo(response.info)
  return response
end

function SeasonMazeComponent:HandleSeasonMazeUseOnce(TT, asyncRes, cfg_id, param)
  local request = SeasonMazeUseOnceReq:New()
  local response = SeasonMazeUseOnceResult:New()
  request.cfg_id = cfg_id
  request.param = param or 0
  local ComponentInfo = self:ComponentInfo()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, ComponentInfo.m_campaign_id, ComponentInfo.m_component_id, request, response)
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= asyncRes.m_result then
    asyncRes:SetResult(asyncRes.m_result)
    Log.error("SeasonMazeComponent:HandleSeasonMazeUseOnce ret:", asyncRes.m_result)
    return nil
  end
  for key, value in pairs(response.rooms) do
    ComponentInfo.rooms[key] = value
  end
  if 0 < table.count(response.fold_hands) then
    ComponentInfo.fold_hands = response.fold_hands
    ComponentInfo.rand_hands = response.rand_hands
    ComponentInfo.wait_hands = response.wait_hands
  end
  if 0 < response.cur_point then
    ComponentInfo.cur_point = response.cur_point
  end
  local componentId = self:GetComponentCfgId()
  local cfg = Cfg.cfg_component_season_maze_once({ComponentID = componentId, OnceID = cfg_id})
  if cfg and cfg[1] and cfg[1].Type == SeasonMazeEffectType.SMET_Once_Sprint then
    ComponentInfo.cur_hand.id = -1
    ComponentInfo.cur_hand.steps = self:GetAttrValue(SeasonMazeAttrType.SMAT_Round_Step_All)
  end
  return response
end

function SeasonMazeComponent:HandleSeasonMazeSaveLv(TT, asyncRes, num)
  local request = SeasonMazeSaveLvReq:New()
  local response = SeasonMazeSaveLvResult:New()
  request.num = num
  local ComponentInfo = self:ComponentInfo()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, ComponentInfo.m_campaign_id, ComponentInfo.m_component_id, request, response)
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= asyncRes.m_result then
    asyncRes:SetResult(asyncRes.m_result)
    Log.error("SeasonMazeComponent:HandleSeasonMazeSaveLv ret:", asyncRes.m_result)
    return nil
  end
  ComponentInfo.save_info = response.save_info
  return response
end

function SeasonMazeComponent:HandleSeasonMazeGetSlot(TT, asyncRes)
  local request = SeasonMazeGetSlotReq:New()
  local response = SeasonMazeGetSlotResult:New()
  local ComponentInfo = self:ComponentInfo()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, ComponentInfo.m_campaign_id, ComponentInfo.m_component_id, request, response)
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= asyncRes.m_result then
    asyncRes:SetResult(asyncRes.m_result)
    Log.error("SeasonMazeComponent:HandleSeasonMazeGetSlot ret:", asyncRes.m_result)
    return nil
  end
  ComponentInfo.slot_info = response.slot_info
  return response
end

function SeasonMazeComponent:HandleSeasonMazeOperaSlot(TT, asyncRes, index, is_re)
  local request = SeasonMazeOperaSlotReq:New()
  local response = SeasonMazeOperaSlotResult:New()
  request.index = index
  request.is_re = is_re
  local ComponentInfo = self:ComponentInfo()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, ComponentInfo.m_campaign_id, ComponentInfo.m_component_id, request, response)
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= asyncRes.m_result then
    asyncRes:SetResult(asyncRes.m_result)
    Log.error("SeasonMazeComponent:HandleSeasonMazeOperaSlot ret:", asyncRes.m_result)
    return nil
  end
  if is_re then
    ComponentInfo.slot_info = response.slot_info
  else
    for key, value in pairs(response.info) do
      ComponentInfo.slot_info.items[key] = value
    end
    if ComponentInfo.slot_info.dis_index == index then
      ComponentInfo.slot_info.dis_index = -1
    end
  end
  return response
end

function SeasonMazeComponent:HandleSeasonMazeChangeFormation(TT, asyncRes, teamInfo)
  local request = SeasonMazeChangeFormationReq:New()
  local response = SeasonMazeChangeFormationReply:New()
  request.formation_index = teamInfo.id
  request.info = teamInfo
  local ComponentInfo = self:ComponentInfo()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, ComponentInfo.m_campaign_id, ComponentInfo.m_component_id, request, response)
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= asyncRes.m_result then
    asyncRes:SetResult(asyncRes.m_result)
    Log.error("[CampaignCom][SeasonMazeComponent] HandleSeasonMazeChangeFormation ret:", asyncRes.m_result)
    return nil
  end
  ComponentInfo.m_formation_list[teamInfo.id] = teamInfo
  return response
end

function SeasonMazeComponent:HandleSeasonMazeInitPetSelect(TT, asyncRes, pet_list)
  local request = SeasonMazeInitSelectReq:New()
  local response = SeasonMazeInitSelectReply:New()
  request.pet_list = pet_list
  local ComponentInfo = self:ComponentInfo()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, ComponentInfo.m_campaign_id, ComponentInfo.m_component_id, request, response)
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= asyncRes.m_result then
    asyncRes:SetResult(asyncRes.m_result)
    Log.error("[CampaignCom][SeasonMazeComponent] HandleSeasonMazeInitPetSelect ret:", asyncRes.m_result)
    return nil
  end
  self._componentInfo.m_bag_info.pet_list = response.pet_list
  self._componentInfo.m_formation_list = response.formation_list
  return response
end

function SeasonMazeComponent:HandleSeasonMazeFitAutoBead(TT, asyncRes, bead_list)
  local request = SeasonMazeFitAutoBeadReq:New()
  local response = SeasonMazeFitAutoBeadReply:New()
  request.fit_beads = bead_list
  local ComponentInfo = self:ComponentInfo()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, ComponentInfo.m_campaign_id, ComponentInfo.m_component_id, request, response)
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= asyncRes.m_result then
    asyncRes:SetResult(asyncRes.m_result)
    Log.error("[CampaignCom][SeasonMazeComponent] HandleSeasonMazeFitAutoBead ret:", asyncRes.m_result)
    return nil
  end
  self._componentInfo.m_auto_bead_map = response.m_auto_bead_map
  self._componentInfo.m_auto_bead_fit_list = response.m_auto_bead_fit_list
  return response
end

function SeasonMazeComponent:HandleSeasonMazeAutoBeadCompose(TT, asyncRes, compose_list)
  local request = SeasonMazeAutoBeadComposeReq:New()
  local response = SeasonMazeAutoBeadComposeReply:New()
  request.compose_list = compose_list
  local ComponentInfo = self:ComponentInfo()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, ComponentInfo.m_campaign_id, ComponentInfo.m_component_id, request, response)
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= asyncRes.m_result then
    asyncRes:SetResult(asyncRes.m_result)
    Log.error("[CampaignCom][SeasonMazeComponent] HandleSeasonMazeAutoBeadCompose ret:", asyncRes.m_result)
    return nil
  end
  self._componentInfo.m_auto_bead_map = response.m_auto_bead_map
  self._componentInfo.m_auto_bead_fit_list = response.m_auto_bead_fit_list
  return response.m_new_bead
end

function SeasonMazeComponent:HandleSeasonMazeCure(TT, asyncRes)
  local request = SeasonMazeHealthyReq:New()
  local response = SeasonMazeHealthyReply:New()
  local ComponentInfo = self:ComponentInfo()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, ComponentInfo.m_campaign_id, ComponentInfo.m_component_id, request, response)
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= asyncRes.m_result then
    asyncRes:SetResult(asyncRes.m_result)
    Log.error("[CampaignCom][SeasonMazeComponent] HandleSeasonMazeCure ret:", asyncRes.m_result)
    return nil
  end
  self._componentInfo.m_bag_info.pet_list = response.pet_list
  return response
end

function SeasonMazeComponent:HandleSeasonMazeResurrectPet(TT, asyncRes, pet_id)
  local request = SeasonMazeResurrectPetReq:New()
  local response = SeasonMazeResurrectPetReply:New()
  request.pet_id = pet_id
  local ComponentInfo = self:ComponentInfo()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, ComponentInfo.m_campaign_id, ComponentInfo.m_component_id, request, response)
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= asyncRes.m_result then
    asyncRes:SetResult(asyncRes.m_result)
    Log.error("[CampaignCom][SeasonMazeComponent] HandleSeasonMazeResurrectPet ret:", asyncRes.m_result)
    return nil
  end
  if self._componentInfo.m_bag_info.pet_list[pet_id] then
    self._componentInfo.m_bag_info.pet_list[pet_id].state = 0
    self._componentInfo.m_bag_info.pet_list[pet_id].cur_blood_prcent = 1
  end
  return response
end

function SeasonMazeComponent:HandleSeasonMazePetRecruitList(TT, asyncRes)
  local request = SeasonMazePetRecruitListReq:New()
  local response = SeasonMazePetRecruitListReply:New()
  local ComponentInfo = self:ComponentInfo()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, ComponentInfo.m_campaign_id, ComponentInfo.m_component_id, request, response)
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= asyncRes.m_result then
    asyncRes:SetResult(asyncRes.m_result)
    Log.error("[CampaignCom][SeasonMazeComponent] HandleSeasonMazePetRecruitList ret:", asyncRes.m_result)
    return nil
  end
  return response
end

function SeasonMazeComponent:HandleSeasonMazePetRecruitSelect(TT, asyncRes, pet_id)
  local request = SeasonMazePetRecruitSelectReq:New()
  local response = SeasonMazePetRecruitSelectReply:New()
  request.pet_id = pet_id
  local ComponentInfo = self:ComponentInfo()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, ComponentInfo.m_campaign_id, ComponentInfo.m_component_id, request, response)
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= asyncRes.m_result then
    asyncRes:SetResult(asyncRes.m_result)
    Log.error("[CampaignCom][SeasonMazeComponent] HandleSeasonMazePetRecruitSelect ret:", asyncRes.m_result)
    return nil
  end
  return response
end

function SeasonMazeComponent:HandleSeasonMazePetRecruitReset(TT, asyncRes)
  local request = SeasonMazePetRecruitResetReq:New()
  local response = SeasonMazePetRecruitResetReply:New()
  local ComponentInfo = self:ComponentInfo()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, ComponentInfo.m_campaign_id, ComponentInfo.m_component_id, request, response)
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= asyncRes.m_result then
    asyncRes:SetResult(asyncRes.m_result)
    Log.error("[CampaignCom][SeasonMazeComponent] HandleSeasonMazePetRecruitReset ret:", asyncRes.m_result)
    return nil
  end
  return response
end

function SeasonMazeComponent:HandleSeasonMazeSelectFullBreakPet(TT, asyncRes, pet_id)
  local request = SeasonMazeSelectFullBreakPetReq:New()
  local response = SeasonMazeSelectFullBreakPetReply:New()
  request.pet_id = pet_id
  local ComponentInfo = self:ComponentInfo()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, ComponentInfo.m_campaign_id, ComponentInfo.m_component_id, request, response)
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= asyncRes.m_result then
    asyncRes:SetResult(asyncRes.m_result)
    Log.error("[CampaignCom][SeasonMazeComponent] HandleSeasonMazeSelectFullBreakPet ret:", asyncRes.m_result)
    return nil
  end
  return response
end

function SeasonMazeComponent:HandleSeasonMazeClearAllBeadNew(TT, asyncRes)
  local request = SeasonMazeClearAllBeadNewReq:New()
  local response = SeasonMazeClearAllBeadNewReply:New()
  local ComponentInfo = self:ComponentInfo()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, ComponentInfo.m_campaign_id, ComponentInfo.m_component_id, request, response)
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= asyncRes.m_result then
    asyncRes:SetResult(asyncRes.m_result)
    Log.error("[CampaignCom][SeasonMazeComponent] HandleSeasonMazeClearAllBeadNew ret:", asyncRes.m_result)
    return nil
  end
  for k, v in pairs(self._componentInfo.m_auto_bead_map) do
    v.bead_info.b_new = false
  end
  self._componentInfo.m_new_auto_bead_cnt = 0
  return response
end

function SeasonMazeComponent:HandleSeasonMazeRecruitRoomSelectProp(TT, asyncRes, prop)
  local request = SeasonMazeRecruitRoomSelectPropReq:New()
  local response = SeasonMazeRecruitRoomSelectPropResult:New()
  request.prop = prop
  local ComponentInfo = self:ComponentInfo()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, ComponentInfo.m_campaign_id, ComponentInfo.m_component_id, request, response)
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= asyncRes.m_result then
    asyncRes:SetResult(asyncRes.m_result)
    Log.error("[CampaignCom][SeasonMazeComponent] HandleSeasonMazeRecruitRoomSelectProp ret:", asyncRes.m_result)
    return nil
  end
  self._componentInfo.m_recruit_room_pet_list = response.cur_pets
  return response
end

function SeasonMazeComponent:HandleSeasonMazeRecruitRoomReflush(TT, asyncRes)
  local request = SeasonMazeRecruitRoomReflushReq:New()
  local response = SeasonMazeRecruitRoomReflushReply:New()
  local ComponentInfo = self:ComponentInfo()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, ComponentInfo.m_campaign_id, ComponentInfo.m_component_id, request, response)
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= asyncRes.m_result then
    asyncRes:SetResult(asyncRes.m_result)
    Log.error("[CampaignCom][SeasonMazeComponent] HandleSeasonMazeRecruitRoomReflush ret:", asyncRes.m_result)
    return nil
  end
  self._componentInfo.m_recruit_room_pet_list = response.pet_list
  self._componentInfo.m_recruit_room_reflush_cnt = self._componentInfo.m_recruit_room_reflush_cnt + 1
  return response
end

function SeasonMazeComponent:HandleSeasonMazeRecruitRoomSelect(TT, asyncRes, pet_id)
  local request = SeasonMazeRecruitRoomSelectReq:New()
  local response = SeasonMazeRecruitRoomSelectReply:New()
  request.pet_id = pet_id
  local ComponentInfo = self:ComponentInfo()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, ComponentInfo.m_campaign_id, ComponentInfo.m_component_id, request, response)
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= asyncRes.m_result then
    asyncRes:SetResult(asyncRes.m_result)
    Log.error("[CampaignCom][SeasonMazeComponent] HandleSeasonMazeRecruitRoomSelect ret:", asyncRes.m_result)
    return nil
  end
  self._componentInfo.m_recruit_room_pet_list = {}
  self._componentInfo.m_recruit_room_reflush_cnt = 0
  return response
end

function SeasonMazeComponent:HandleSeasonMazeRoomTransfer(TT, asyncRes, point_id)
  local request = SeasonMazeRoomTransferReq:New()
  local response = SeasonMazeRoomTransferResult:New()
  request.point_id = point_id
  local ComponentInfo = self:ComponentInfo()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, ComponentInfo.m_campaign_id, ComponentInfo.m_component_id, request, response)
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= asyncRes.m_result then
    asyncRes:SetResult(asyncRes.m_result)
    Log.error("[CampaignCom][SeasonMazeComponent] HandleSeasonMazeRoomTransfer ret:", asyncRes.m_result)
    return nil
  end
  for key, value in pairs(response.rooms) do
    ComponentInfo.rooms[key] = value
  end
  ComponentInfo.cur_point = response.cur_point
  return response
end

function SeasonMazeComponent:HandleSeasonMazeBanPet(TT, asyncRes, ban_list)
  local request = SeasonMazeManunlBanPetReq:New()
  local response = SeasonMazeManunlBanPetResult:New()
  request.ban_list = ban_list
  local ComponentInfo = self:ComponentInfo()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, ComponentInfo.m_campaign_id, ComponentInfo.m_component_id, request, response)
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= asyncRes.m_result then
    asyncRes:SetResult(asyncRes.m_result)
    Log.error("[CampaignCom][SeasonMazeComponent] HandleSeasonMazeBanPet ret:", asyncRes.m_result)
    return nil
  end
  ComponentInfo.manunl_ban_pets = ban_list
  return response
end

function SeasonMazeComponent:HandleCampaignLoadComponentRank(TT, asyncRes, sub_key)
  local rank_info = self.m_campaign_com_module:CampaignLoadComponentRank(TT, asyncRes, self:GetComponentCfgId(), sub_key)
  if asyncRes:GetSucc() then
    local addCnt = 0
    local cfgs = Cfg.cfg_component_season_maze_fake_rank({})
    for key, value in pairs(cfgs) do
      local info = RankShowSimpleOne:New()
      info.pstid = 0
      info.head = value.Head
      info.damage = value.Damage
      info.nick = value.Name
      info.head_bg = value.HeadBG
      info.frame_id = value.FrameID
      table.insert(rank_info.infos, info)
      addCnt = addCnt + 1
    end
    if 1 < table.count(rank_info.infos) and 0 < addCnt then
      table.sort(rank_info.infos, function(a, b)
        return a.damage > b.damage
      end)
    end
  end
  return rank_info
end

function SeasonMazeComponent:GetAttrValue(type)
  local attMap = self:GetComponentInfo().attr_list
  return attMap[type] or 0
end

function SeasonMazeComponent:GetPetState(petID, stateType)
  if self._componentInfo.m_bag_info.pet_list[petID] == nil then
    return false
  end
  local state = self._componentInfo.m_bag_info.pet_list[petID].state
  if state == nil then
    return false
  end
  local type = tonumber(stateType)
  return 1 << type & state > 0
end

function SeasonMazeComponent:GetCampaignMissionParamKeyMap()
  local ComponentInfo = self:ComponentInfo()
  local nCfgId = self:GetComponetCfgId(ComponentInfo.m_campaign_id, ComponentInfo.m_component_id)
  return {
    [ECampaignMissionParamKey.ECampaignMissionParamKey_ComCfgId] = nCfgId
  }
end

function SeasonMazeComponent:_CopyRoom(src, tar)
end
