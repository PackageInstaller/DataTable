_class("HomelandModule", GameModule)
HomelandModule = HomelandModule

function HomelandModule:Constructor()
  self.m_homeland_info = {}
  self.m_group_id_set = {}
  self._RareFishingPosition = {}
  self._bite_fish_id = -1
  self.m_match_end_time = 0
  self.m_match_main_id = 0
  self.m_pet_ability_id = 0
  self._wishing_reward = {}
  self._svrTimeModule = nil
  self._task_group_timeline = {}
  self._task_group_close_timeline = {}
  self._task_group_close_time = {}
  self._last_update_tick = 0
  self.m_RequestGroup = nil
  self._storyTask_autoReq = false
end

function HomelandModule:Init()
  HomelandModule.super.Init(self)
  self.caller:RegisterPushHandler(CEventHomelandTreasureUpdate, self.HandleTreasureUpdate, self)
  self.caller:RegisterPushHandler(CEventHomelandShopUpdate, self.HandleShopUpdate, self)
  self.caller:RegisterPushHandler(CEventHomelandForgeUpdate, self.HandleForgeUpdate, self)
  self.caller:RegisterPushHandler(CEventHomelandCultivationUpdate, self.HandleCultivationUpdate, self)
  self.caller:RegisterPushHandler(CEventHomelandVisitItemUpdate, self.HandleVisitItemUpdate, self)
  self.caller:RegisterPushHandler(CEventHomelandDormitoryUpdate, self.HandleDormitoryUpdate, self)
  self.caller:RegisterPushHandler(CEventPushEventChange, self.HandlePushEventChange, self)
  self.caller:RegisterPushHandler(CEventPushLevelInfo, self.HandlePushLevelInfo, self)
  self.caller:RegisterPushHandler(CEventHomelandVisitUpdate, self.HandleHomelandVisitUpdate, self)
  self.caller:RegisterPushHandler(CEventPushHomelandFunctionUnlocked, self.HandleFunctionUnlocked, self)
  self.caller:RegisterPushHandler(CEventHomelandStoryTaskUpdate, self.HandleStoryTaskUpdate, self)
  self.caller:RegisterPushHandler(CEventHomelandRefreshRarePositionPush, self.HandleRefreshRarePositionUpdate, self)
end

function HomelandModule:Dispose()
  self.caller:UnRegisterPushHandler(CEventHomelandTreasureUpdate)
  self.caller:UnRegisterPushHandler(CEventHomelandShopUpdate)
  self.caller:UnRegisterPushHandler(CEventHomelandForgeUpdate)
  self.caller:UnRegisterPushHandler(CEventHomelandCultivationUpdate)
  self.caller:UnRegisterPushHandler(CEventHomelandVisitItemUpdate)
  self.caller:UnRegisterPushHandler(CEventHomelandDormitoryUpdate)
  self.caller:UnRegisterPushHandler(CEventPushEventChange)
  self.caller:UnRegisterPushHandler(CEventPushLevelInfo)
  self.caller:UnRegisterPushHandler(CEventHomelandVisitUpdate)
  self.caller:UnRegisterPushHandler(CEventPushHomelandFunctionUnlocked)
  self.caller:UnRegisterPushHandler(CEventHomelandStoryTaskUpdate)
  self.caller:UnRegisterPushHandler(CEventHomelandRefreshRarePositionPush)
  HomelandModule.super.Dispose(self)
end

function HomelandModule:SetTaskGroupTimeline(task_group_timeline)
  self._task_group_timeline = task_group_timeline
end

function HomelandModule:SetTaskGroupCloseTimeline(task_group_close_timeline)
  for index, value in ipairs(task_group_close_timeline) do
    for _index, _value in ipairs(value.task_group_list) do
      self._task_group_close_time[_value] = value.valid_time
    end
  end
  self:MergeTaskGroupTimeline(self._task_group_close_timeline, task_group_close_timeline)
end

function HomelandModule:MergeTaskGroupTimeline(target_timeline, task_group_timeline)
  if not task_group_timeline or #task_group_timeline <= 0 then
    return
  end
  local l_num = #task_group_timeline
  local first_valid_time = task_group_timeline[1].valid_time
  local l_targetindex
  for _index, _value in ipairs(target_timeline) do
    if first_valid_time <= _value.valid_time then
      l_targetindex = _index - 1
      break
    end
  end
  if l_targetindex == nil then
    l_targetindex = #target_timeline
  end
  local l_end_index
  for _index, _value in ipairs(task_group_timeline) do
    l_end_index = l_targetindex + _index
    target_timeline[l_end_index] = _value
  end
end

function HomelandModule:HandleFunctionUnlocked(msg)
  self.m_homeland_info.unlock_functions = msg.unlock_functions
  GameGlobal.EventDispatcher():Dispatch(GameEventType.HomeLandFunctionUnlock, msg.function_unlock_type)
end

function HomelandModule:SetRecvGroupId(group_id_set)
  self.m_group_id_set = group_id_set
end

function HomelandModule:SetFunctionUnlockMask(unlock_mask)
  self.m_homeland_info.unlock_functions = unlock_mask
end

function HomelandModule:_GetUnlockFunctionBit(function_type)
  return function_type % EHomelandFunctionUnlock.HOMELAND_FUNCTION_UNLOCK_MASK_BIT
end

function HomelandModule:_GetUnlockFunctionDict(function_type)
  if not self.m_homeland_info or not self.m_homeland_info.unlock_functions then
    return 0
  end
  if function_type >= EHomelandFunctionUnlock.HOMELAND_FUNCTION_UNLOCK_MASK_BIT then
    return self.m_homeland_info.unlock_functions[2]
  else
    return self.m_homeland_info.unlock_functions[1]
  end
end

function HomelandModule:CheckFunctionUnlock(function_type)
  local unlock_mask = self:_GetUnlockFunctionDict(function_type)
  local unlock_mask_bit = self:_GetUnlockFunctionBit(function_type)
  local value = unlock_mask & 1 << unlock_mask_bit
  return value ~= 0
end

function HomelandModule:HandlePushLevelInfo(levelInfo)
  local deltaLevel = math.max(levelInfo.level - self.m_homeland_info.level, 0)
  self.m_homeland_info.level = levelInfo.level
  self.m_homeland_info.exp = levelInfo.exp
  self._homelandLevelData:OnLevelInfoChange(deltaLevel)
end

function HomelandModule:HandleHomelandVisitUpdate(msgInfo)
  self.m_homeland_info.visit_info = msgInfo.info
end

function HomelandModule:Update(curTick)
  if self.uiModule:IsRunning() then
    self.uiModule:Update(curTick)
  end
  if self.m_RequestGroup == nil and curTick - self._last_update_tick >= 1000 then
    self.m_RequestGroup = self:CheckTaskGroupTimeLine(self._task_group_timeline)
    if self.m_RequestGroup ~= nil then
      GameGlobal.TaskManager():StartTask(self._HandleHomelandUpdateTaskReq, self)
    elseif self:CheckTaskGroupTimeLine(self._task_group_close_timeline) ~= nil then
      GameGlobal.EventDispatcher():Dispatch(GameEventType.QuestUpdate)
    end
    self._last_update_tick = curTick
  end
end

function HomelandModule:GetHomelandInfo()
  return self.m_homeland_info
end

function HomelandModule:GetHomelandLevel()
  if not self.m_homeland_info then
    return 0
  end
  if not self.m_homeland_info.level then
    return 0
  end
  return self.m_homeland_info.level
end

function HomelandModule:GetBuildPstid(buildId)
  local architectureList = self.m_homeland_info.architecture_list.architecture_list
  for _, v in pairs(architectureList) do
    if v.asset_id == buildId then
      return v.pstid
    end
  end
  return 0
end

function HomelandModule:GetBuildSkinIds(buildId)
  local skinCfg = Cfg.cfg_item_architecture_skin({architecture_id = buildId})
  local skins = {}
  local buildCfg = Cfg.cfg_item_architecture[buildId]
  local defaultSkin = buildCfg.DefaultSkin
  if skinCfg then
    for k, v in pairs(skinCfg) do
      if defaultSkin ~= v.ID then
        skins[#skins + 1] = v.ID
      end
    end
  end
  table.sort(skins, function(a, b)
    local hasA = self:HasBuildSkin(a)
    local hasB = self:HasBuildSkin(b)
    if hasA == hasB then
      return a < b
    end
    if hasA then
      return true
    end
    return false
  end)
  if defaultSkin then
    table.insert(skins, 1, defaultSkin)
  end
  return skins
end

function HomelandModule:GetOwnBuildSkinIds(buildId)
  local skinCfg = Cfg.cfg_item_architecture_skin({architecture_id = buildId})
  local skins = {}
  local buildCfg = Cfg.cfg_item_architecture[buildId]
  local defaultSkin = buildCfg.DefaultSkin
  if skinCfg then
    for k, v in pairs(skinCfg) do
      if defaultSkin ~= v.ID and self:HasBuildSkin(v.ID) then
        skins[#skins + 1] = v.ID
      end
    end
  end
  table.sort(skins, function(a, b)
    local hasA = self:HasBuildSkin(a)
    local hasB = self:HasBuildSkin(b)
    if hasA == hasB then
      return a < b
    end
    if hasA then
      return true
    end
    return false
  end)
  if defaultSkin then
    table.insert(skins, 1, defaultSkin)
  end
  return skins
end

function HomelandModule:HasBuildSkin(skinId)
  if skinId == 0 then
    return true
  end
  local itemModule = GameGlobal.GetModule(ItemModule)
  local count = itemModule:GetItemCount(skinId)
  if not count then
    return false
  end
  return 0 < count
end

function HomelandModule:GetCurrentBuildSkin(buildId, pstId)
  local architecture = self.m_homeland_info.architecture_list.architecture_list[pstId]
  if not architecture then
    return 0
  end
  if not architecture.skin or 0 >= architecture.skin then
    local skinCfg = Cfg.cfg_item_architecture[buildId]
    if not skinCfg.DefaultSkin then
      return 0
    end
    return skinCfg.DefaultSkin
  end
  return architecture.skin
end

function HomelandModule:GetTreasureInfo()
  return self.m_homeland_info.trea_info
end

function HomelandModule:GetTreasureBirthInfo(birth_id)
  return self.m_homeland_info.trea_info.treasures[birth_id]
end

function HomelandModule:EnterHomeLand(TT, stateTable)
  local AsyncRes = AsyncRequestRes:New()
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventEnterHomelandReq)
  request.player_pstid = 0
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    AsyncRes:SetResult(HomeLandErrorType.E_HOME_LAND_UNLOCK)
    return AsyncRes
  end
  local replyEvent = reply.msg
  if replyEvent.nRet == HomeLandErrorType.E_HOME_LAND_TYPE_SUCCESS then
    self.m_homeland_info = replyEvent.data
    self.uiModule:SetEventInfo(replyEvent.can_trigger_event_list, replyEvent.can_trigger_event_num)
    AsyncRes:SetSucc(true)
    self:MergeTaskGroupTimeline(self._task_group_timeline, replyEvent.task_group_timeline)
    self:SetTaskGroupCloseTimeline(replyEvent.task_group_close_timeline)
    self:_UpdateRareFishingPosition()
  else
    AsyncRes:SetResult(replyEvent.nRet)
  end
  if stateTable and type(stateTable) == "table" then
    stateTable.homelandDataFinish = true
  end
  return AsyncRes, replyEvent
end

function HomelandModule:IsRecvGroupTaskReward(group_task_id)
  for key, value in pairs(self.m_group_id_set) do
    if value == group_task_id then
      return true
    end
  end
  if 4 < group_task_id then
    return false
  end
  local l_task_group = Cfg.cfg_homeland_task_group[group_task_id]
  if not l_task_group then
    return true
  end
  if not l_task_group.Reward then
    return true
  end
  local l_UnlockDrawingId = 0
  for _, value in pairs(l_task_group.Reward) do
    if value and value[1] and value[2] and value[2] == 1 then
      local l_item_id = value[1]
      local l_arch_unlock_item = Cfg.cfg_item[l_item_id]
      if l_arch_unlock_item and l_arch_unlock_item.ItemSubType == ItemSubType.ItemSubType_HomelandDrawingg then
        l_UnlockDrawingId = l_item_id
        break
      end
    end
  end
  if l_UnlockDrawingId == 0 then
    return true
  end
  local itemModule = GameGlobal.GetModule(ItemModule)
  local l_drawing_count = itemModule:GetItemCount(l_UnlockDrawingId)
  if 0 < l_drawing_count then
    return true
  end
  local l_architecture = Cfg.cfg_item_architecture({UnlockDrawing = l_UnlockDrawingId})
  if not l_architecture then
    return true
  end
  local l_arch_cfg_item = l_architecture[1]
  if not l_arch_cfg_item then
    return true
  end
  if not (self.m_homeland_info and self.m_homeland_info.forge_info) or not self.m_homeland_info.forge_info.unlock_architecture_list then
    return true
  end
  for l_ak, l_avar in pairs(self.m_homeland_info.forge_info.unlock_architecture_list) do
    if l_avar == l_arch_cfg_item.ID then
      return true
    end
  end
  return false
end

function HomelandModule:HandleUnlock(TT, architecture_id)
  local AsyncRes = AsyncRequestRes:New()
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventUnlockReq)
  request.architecture_id = architecture_id
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    AsyncRes:SetResult(HomeLandErrorType.E_HOME_LAND_UNLOCK)
    return AsyncRes
  end
  local replyEvent = reply.msg
  if replyEvent.nRet == HomeLandErrorType.E_HOME_LAND_TYPE_SUCCESS then
    self.m_homeland_info.forge_info.unlock_architecture_list = replyEvent.unlock_architecture_list
    AsyncRes:SetSucc(true)
  else
    AsyncRes:SetResult(replyEvent.nRet)
  end
  return AsyncRes, replyEvent.unlock_architecture_list
end

function HomelandModule:HandleOneClickUnlock(TT, architectur_ids)
  local AsyncRes = AsyncRequestRes:New()
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventOneClickUnlockReq)
  request.architecture_ids = architectur_ids
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    AsyncRes:SetResult(HomeLandErrorType.E_HOME_LAND_UNLOCK)
    return AsyncRes
  end
  local replyEvent = reply.msg
  if replyEvent.nRet == HomeLandErrorType.E_HOME_LAND_TYPE_SUCCESS then
    self.m_homeland_info.forge_info.unlock_architecture_list = replyEvent.unlock_architecture_list
    AsyncRes:SetSucc(true)
  else
    AsyncRes:SetResult(replyEvent.nRet)
  end
  return AsyncRes, replyEvent.unlock_architecture_list
end

function HomelandModule:HandleForge(TT, architecture_id, queue_index)
  local AsyncRes = AsyncRequestRes:New()
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventForgeReq)
  request.architecture_id = architecture_id
  request.queue_index = queue_index
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    AsyncRes:SetResult(HomeLandErrorType.E_HOME_LAND_UNLOCK)
    return AsyncRes
  end
  local replyEvent = reply.msg
  if replyEvent.nRet == HomeLandErrorType.E_HOME_LAND_TYPE_SUCCESS then
    self.m_homeland_info.forge_info.forge_list = replyEvent.forge_list
    AsyncRes:SetSucc(true)
  else
    AsyncRes:SetResult(replyEvent.nRet)
  end
  return AsyncRes, replyEvent.forge_list
end

function HomelandModule:HandleAccelerate(TT, queue_index, asset)
  local AsyncRes = AsyncRequestRes:New()
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventAccelerateReq)
  request.queue_index = queue_index
  request.item = asset
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    AsyncRes:SetResult(HomeLandErrorType.E_HOME_LAND_UNLOCK)
    return AsyncRes
  end
  local replyEvent = reply.msg
  if replyEvent.nRet == HomeLandErrorType.E_HOME_LAND_TYPE_SUCCESS then
    self.m_homeland_info.forge_info.forge_list = replyEvent.forge_list
    AsyncRes:SetSucc(true)
  else
    AsyncRes:SetResult(replyEvent.nRet)
  end
  return AsyncRes, replyEvent.forge_list
end

function HomelandModule:HandleCancel(TT, queue_index)
  local AsyncRes = AsyncRequestRes:New()
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventCancelReq)
  request.queue_index = queue_index
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    AsyncRes:SetResult(HomeLandErrorType.E_HOME_LAND_UNLOCK)
    return AsyncRes
  end
  local replyEvent = reply.msg
  if replyEvent.nRet == HomeLandErrorType.E_HOME_LAND_TYPE_SUCCESS then
    self.m_homeland_info.forge_info.forge_list = replyEvent.forge_list
    AsyncRes:SetSucc(true)
  else
    AsyncRes:SetResult(replyEvent.nRet)
  end
  return AsyncRes, replyEvent.forge_list, replyEvent.return_material
end

function HomelandModule:HandlPickUp(TT, queue_index)
  local AsyncRes = AsyncRequestRes:New()
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventPickUpReq)
  request.queue_index = queue_index
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    AsyncRes:SetResult(HomeLandErrorType.E_HOME_LAND_UNLOCK)
    return AsyncRes
  end
  local replyEvent = reply.msg
  if replyEvent.nRet == HomeLandErrorType.E_HOME_LAND_TYPE_SUCCESS then
    self.m_homeland_info.forge_info.forge_list = replyEvent.forge_list
    self.m_homeland_info.forge_info.already_forge_list = replyEvent.already_forge_list
    AsyncRes:SetSucc(true)
  else
    AsyncRes:SetResult(replyEvent.nRet)
  end
  return AsyncRes, replyEvent.forge_list, replyEvent.architecture
end

function HomelandModule:SetCurrentBuildSkin(TT, buildPstId, skinId)
  local AsyncRes = AsyncRequestRes:New()
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventSelectSkinReq)
  request.pstid = buildPstId
  request.skin_id = skinId
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    AsyncRes:SetResult(HomeLandErrorType.E_HOME_LAND_UNLOCK)
    return AsyncRes
  end
  local replyEvent = reply.msg
  if replyEvent.nRet == HomeLandErrorType.E_HOME_LAND_TYPE_SUCCESS then
    local id = replyEvent.architecture_info.pstid
    self.m_homeland_info.architecture_list.architecture_list[id] = replyEvent.architecture_info
    AsyncRes:SetSucc(true)
  else
    AsyncRes:SetResult(replyEvent.nRet)
  end
  return AsyncRes, replyEvent.architecture_info
end

function HomelandModule:HomelandBuild(TT, add_list, delete_list, update_list)
  local AsyncRes = AsyncRequestRes:New()
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventHomelandBuildReq)
  request.add_architectures = add_list
  request.delete_pstids = delete_list
  request.update_architectures = update_list
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    AsyncRes:SetSucc(false)
    AsyncRes:SetResult(-1)
    return AsyncRes
  end
  local replyEvent = reply.msg
  if replyEvent.nRet == HomeLandErrorType.E_HOME_LAND_TYPE_SUCCESS then
    for i, v in ipairs(replyEvent.update_architectures) do
      self.m_homeland_info.architecture_list.architecture_list[v.pstid] = v
    end
    for i, v in ipairs(replyEvent.delete_pstids) do
      self.m_homeland_info.architecture_list.architecture_list[v] = nil
    end
    for i, v in ipairs(replyEvent.add_architectures) do
      self.m_homeland_info.architecture_list.architecture_list[v.pstid] = v
    end
    AsyncRes:SetSucc(true)
  else
    AsyncRes:SetResult(replyEvent.nRet)
  end
  return AsyncRes, replyEvent.add_architectures
end

function HomelandModule:HomelandShopRefreshReq(TT)
  local AsyncRes = AsyncRequestRes:New()
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventHomelandShopRefreshReq)
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    AsyncRes:SetResult(HomeLandErrorType.E_HOME_LAND_UNLOCK)
    return AsyncRes
  end
  local replyEvent = reply.msg
  if replyEvent.nRet == HomeLandErrorType.E_HOME_LAND_TYPE_SUCCESS then
    AsyncRes:SetSucc(true)
    self.m_homeland_info.shop_info = replyEvent.shop_info
  else
    AsyncRes:SetResult(replyEvent.nRet)
  end
  return AsyncRes, self.m_homeland_info.shop_info
end

function HomelandModule:HomelandShopReq(TT, cfgId, num)
  local AsyncRes = AsyncRequestRes:New()
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventHomelandShopReq)
  request.id = cfgId
  request.num = num
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    AsyncRes:SetResult(HomeLandErrorType.E_HOME_LAND_UNLOCK)
    return AsyncRes
  end
  local replyEvent = reply.msg
  if replyEvent.nRet == HomeLandErrorType.E_HOME_LAND_TYPE_SUCCESS then
    AsyncRes:SetSucc(true)
    if self.m_homeland_info.shop_info.chs_map[cfgId] ~= nil then
      self.m_homeland_info.shop_info.chs_map[cfgId] = self.m_homeland_info.shop_info.chs_map[cfgId] + num
    else
      self.m_homeland_info.shop_info.chs_map[cfgId] = num
    end
  else
    AsyncRes:SetResult(replyEvent.nRet)
  end
  return AsyncRes, self.m_homeland_info.shop_info
end

function HomelandModule:HomelandSellReq(TT, id_num)
  local AsyncRes = AsyncRequestRes:New()
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventHomelandSellReq)
  request.id_num = id_num
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    AsyncRes:SetResult(HomeLandErrorType.E_HOME_LAND_UNLOCK)
    return AsyncRes
  end
  local replyEvent = reply.msg
  if replyEvent.nRet == HomeLandErrorType.E_HOME_LAND_TYPE_SUCCESS then
    AsyncRes:SetSucc(true)
  else
    AsyncRes:SetResult(replyEvent.nRet)
  end
  return AsyncRes, self.m_homeland_info.shop_info
end

function HomelandModule:HandleShopUpdate(msgInfo)
  self.m_homeland_info.shop_info = msgInfo.shop_info
  GameGlobal.EventDispatcher():Dispatch(GameEventType.HomelandShopUpdate)
end

function HomelandModule:HomelandGoodsReq(TT, id, isSell)
  local AsyncRes = AsyncRequestRes:New()
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventHomelandGoodsReq)
  request.id = id
  request.is_sell = isSell
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    AsyncRes:SetResult(HomeLandErrorType.E_HOME_LAND_UNLOCK)
    return AsyncRes
  end
  local replyEvent = reply.msg
  if replyEvent.nRet == HomeLandErrorType.E_HOME_LAND_TYPE_SUCCESS then
    AsyncRes:SetSucc(true)
    self.m_homeland_info.shop_info.goods_refresh_time = replyEvent.goods_refresh_time
    for i, v in pairs(replyEvent.goods_info) do
      self.m_homeland_info.shop_info.goods_info[i] = v
    end
  else
    AsyncRes:SetResult(replyEvent.nRet)
  end
  return AsyncRes, replyEvent.shop_info
end

function HomelandModule:GetHomelandDairyInfo()
  return self.m_homeland_info.dairy_info
end

function HomelandModule:HandleHomelandFixShabbyReq(TT, arch_pstid)
  local AsyncRes = AsyncRequestRes:New()
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventHomelandFixShabbyReq)
  request.arch_pstid = arch_pstid
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    AsyncRes:SetResult(HomeLandErrorType.E_HOME_LAND_TYPE_FAILURE)
    return AsyncRes
  end
  local replyEvent = reply.msg
  AsyncRes:SetResult(replyEvent.nRet)
  if replyEvent.nRet == HomeLandErrorType.E_HOME_LAND_TYPE_SUCCESS then
    self.m_homeland_info.architecture_list.architecture_list[arch_pstid] = replyEvent.architecture_info
    AsyncRes:SetSucc(true)
  end
  return AsyncRes
end

function HomelandModule:HandleHomelandReadedDairyReq(TT, read_dairy_id)
  local AsyncRes = AsyncRequestRes:New()
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventHomelandReadedDairyReq)
  request.nReadDairyId = read_dairy_id
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    AsyncRes:SetResult(HomeLandErrorType.E_HOME_LAND_TYPE_FAILURE)
    return AsyncRes
  end
  local replyEvent = reply.msg
  AsyncRes:SetResult(replyEvent.nRet)
  if replyEvent.nRet == HomeLandErrorType.E_HOME_LAND_TYPE_SUCCESS then
    local bHasID = false
    for index, value in ipairs(self.m_homeland_info.dairy_info.is_readed_dairy) do
      if value == read_dairy_id then
        bHasID = true
        break
      end
    end
    if not bHasID then
      table.insert(self.m_homeland_info.dairy_info.is_readed_dairy, read_dairy_id)
    end
    AsyncRes:SetSucc(true)
  end
  return AsyncRes
end

function HomelandModule:HandleHomelandTraceReq(TT, trace_type, trace_id)
  local AsyncRes = AsyncRequestRes:New()
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventHomelandTraceReq)
  request.trace_type = trace_type
  request.trace_id = trace_id
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    AsyncRes:SetResult(HomeLandErrorType.E_HOME_LAND_TYPE_FAILURE)
    return AsyncRes
  end
  local replyEvent = reply.msg
  AsyncRes:SetResult(replyEvent.nRet)
  if replyEvent.nRet == HomeLandErrorType.E_HOME_LAND_TYPE_SUCCESS then
    self.m_homeland_info.trace_info = replyEvent.trace_info
    AsyncRes:SetSucc(true)
  end
  return AsyncRes
end

function HomelandModule:GetHomeLandEventInfo()
  return self.m_homeland_info.event_info
end

function HomelandModule:HandleClientFinishEventReq(TT, finish_event_id)
  local AsyncRes = AsyncRequestRes:New()
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventClientFinishEventReq)
  request.finish_event_id = finish_event_id
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    AsyncRes:SetResult(HomeLandErrorType.E_HOME_LAND_TYPE_FAILURE)
    return AsyncRes
  end
  local replyEvent = reply.msg
  AsyncRes:SetResult(replyEvent.nRet)
  if replyEvent.nRet == HomeLandErrorType.E_HOME_LAND_TYPE_SUCCESS then
    self.m_homeland_info.event_info = replyEvent.event_info
    if replyEvent.wishing_coin_position ~= 0 then
      table.insert(self.m_homeland_info.fishing_data.append_wishingcoin_position, replyEvent.wishing_coin_position)
      GameGlobal.EventDispatcher():Dispatch(GameEventType.OnUIHomeEventTips, UIHomeEventTipsType.Tex, {
        StringTable.Get("str_homeland_new_fishing_position_tips")
      })
      GameGlobal.EventDispatcher():Dispatch(GameEventType.FishingRefreshFishingPosition)
    end
    AsyncRes:SetSucc(true)
  end
  return AsyncRes
end

function HomelandModule:HandleClientTriggerEventReq(TT, trigger_event_list)
  local AsyncRes = AsyncRequestRes:New()
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventClientTriggerEventReq)
  request.trigger_event_list = trigger_event_list
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    AsyncRes:SetResult(HomeLandErrorType.E_HOME_LAND_TYPE_FAILURE)
    return AsyncRes
  end
  local replyEvent = reply.msg
  AsyncRes:SetResult(replyEvent.nRet)
  if replyEvent.nRet == HomeLandErrorType.E_HOME_LAND_TYPE_SUCCESS then
    self.m_homeland_info.event_info = replyEvent.event_info
    AsyncRes:SetSucc(true)
  end
  return AsyncRes
end

function HomelandModule:HomelandGetNewTreasure(TT, birthId, expos)
  local AsyncRes = AsyncRequestRes:New()
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventHomelandTreasureReq)
  request.birth_id = birthId
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    AsyncRes:SetResult(HomeLandErrorType.E_HOME_LAND_UNLOCK)
    return AsyncRes
  end
  local replyEvent = reply.msg
  if replyEvent.nRet == HomeLandErrorType.E_HOME_LAND_TYPE_SUCCESS then
    self.m_homeland_info.trea_info = replyEvent.trea_info
    AsyncRes:SetSucc(true)
  else
    AsyncRes:SetResult(replyEvent.nRet)
  end
  return AsyncRes, replyEvent.trea_info
end

function HomelandModule:HomelandChangeTreasureState(TT, birthId, state)
  local AsyncRes = AsyncRequestRes:New()
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventHomelandTreasureStateReq)
  request.birth_id = birthId
  request.state = state
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    AsyncRes:SetResult(HomeLandErrorType.E_HOME_LAND_UNLOCK)
    return AsyncRes
  end
  local replyEvent = reply.msg
  if replyEvent.nRet == HomeLandErrorType.E_HOME_LAND_TYPE_SUCCESS then
    AsyncRes:SetSucc(true)
    local t = self.m_homeland_info.trea_info.treasures[birthId]
    if state == TreasureState.TS_GRAB then
      t.state = TreasureState.TS_DESTROY
    else
      t.state = state
    end
  else
    AsyncRes:SetResult(replyEvent.nRet)
  end
  return AsyncRes, replyEvent.assets
end

function HomelandModule:HandleTreasureUpdate(msgInfo)
  local delmap = {}
  for birthID, v in pairs(msgInfo.trea_info.treasures) do
    if v.state == TreasureState.TS_DESTROY then
      table.insert(delmap, birthID)
    end
  end
  self.m_homeland_info.trea_info = msgInfo.trea_info
  if #delmap <= 0 then
    return
  end
  GameGlobal.EventDispatcher():Dispatch(GameEventType.TreasureRemove, delmap)
end

function HomelandModule:HomelandVisitListReq(TT)
  local asyncRes = AsyncRequestRes:New()
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventHomelandVisitListReq)
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    asyncRes:SetResult(HomeLandErrorType.E_HOME_LAND_UNLOCK)
    return asyncRes
  end
  local replyEvent = reply.msg
  asyncRes:SetSucc(true)
  return asyncRes, replyEvent
end

function HomelandModule:HomelandVisitFriendReq(TT, peer_pstid)
  local asyncRes = AsyncRequestRes:New()
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventHomelandVisitFriendReq)
  request.pstid = peer_pstid
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    asyncRes:SetResult(HomeLandErrorType.E_HOME_LAND_UNLOCK)
    return asyncRes
  end
  local replyEvent = reply.msg
  if replyEvent.nRet == HomeLandErrorType.E_HOME_LAND_TYPE_SUCCESS then
    asyncRes:SetSucc(true)
  else
    asyncRes:SetResult(replyEvent.nRet)
  end
  return asyncRes, replyEvent
end

function HomelandModule:HomelandTakeItemReq(TT, host_pstid, index, item_pstid)
  local asyncRes = AsyncRequestRes:New()
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventHomelandTakeItemReq)
  request.pstid = host_pstid
  request.index = index
  request.item_pstid = item_pstid
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    asyncRes:SetResult(HomeLandErrorType.E_HOME_LAND_UNLOCK)
    return asyncRes
  end
  local replyEvent = reply.msg
  if replyEvent.nRet == HomeLandErrorType.E_HOME_LAND_TYPE_SUCCESS then
    table.insert(self.m_homeland_info.visit_info.item_list, host_pstid)
    asyncRes:SetSucc(true)
  else
    asyncRes:SetResult(replyEvent.nRet)
  end
  return asyncRes, replyEvent
end

function HomelandModule:HomelandAccForgeReq(TT, host_pstid)
  local asyncRes = AsyncRequestRes:New()
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventHomelandAccForgeReq)
  request.pstid = host_pstid
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    asyncRes:SetResult(HomeLandErrorType.E_HOME_LAND_UNLOCK)
    return asyncRes
  end
  local replyEvent = reply.msg
  if replyEvent.nRet == HomeLandErrorType.E_HOME_LAND_TYPE_SUCCESS then
    table.insert(self.m_homeland_info.visit_info.forge_list, host_pstid)
    asyncRes:SetSucc(true)
  else
    asyncRes:SetResult(replyEvent.nRet)
  end
  return asyncRes, replyEvent
end

function HomelandModule:HomelandAccCultivateReq(TT, host_pstid, land_pstid)
  local asyncRes = AsyncRequestRes:New()
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventHomelandAccCultivateReq)
  request.pstid = host_pstid
  request.land_pstid = land_pstid
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    asyncRes:SetResult(HomeLandErrorType.E_HOME_LAND_UNLOCK)
    return asyncRes
  end
  local replyEvent = reply.msg
  if replyEvent.nRet == HomeLandErrorType.E_HOME_LAND_TYPE_SUCCESS then
    table.insert(self.m_homeland_info.visit_info.cultivation_list, land_pstid)
    asyncRes:SetSucc(true)
  else
    asyncRes:SetResult(replyEvent.nRet)
  end
  return asyncRes, replyEvent
end

function HomelandModule:HomelandMoveItemReq(TT, index, item)
  local asyncRes = AsyncRequestRes:New()
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventHomelandMoveItemReq)
  request.item = item
  request.index = index
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    asyncRes:SetResult(HomeLandErrorType.E_HOME_LAND_UNLOCK)
    return asyncRes
  end
  local replyEvent = reply.msg
  if replyEvent.nRet == HomeLandErrorType.E_HOME_LAND_TYPE_SUCCESS then
    self.m_homeland_info.visit_int_info.item_map[index] = nil
    if item ~= nil then
      self.m_homeland_info.visit_int_info.item_map[index] = replyEvent.item
    end
    asyncRes:SetSucc(true)
  else
    asyncRes:SetResult(replyEvent.nRet)
  end
  return asyncRes, replyEvent
end

function HomelandModule:HomelandVisitLogReq(TT)
  local asyncRes = AsyncRequestRes:New()
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventHomelandVisitLogReq)
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    asyncRes:SetResult(HomeLandErrorType.E_HOME_LAND_UNLOCK)
    return asyncRes
  end
  local replyEvent = reply.msg
  asyncRes:SetSucc(true)
  return asyncRes, replyEvent
end

function HomelandModule:HandleForgeUpdate(msgInfo)
  self.m_homeland_info.forge_info.forge_list = msgInfo.forge_list
  self.m_homeland_info.visit_int_info.forge_acc_map = msgInfo.forge_time
end

function HomelandModule:HandleCultivationUpdate(msgInfo)
  if self.m_homeland_info == nil then
    return
  end
  self.m_homeland_info.cultivation_info = msgInfo.infos
  if msgInfo.cul_time and table.count(msgInfo.cul_time) > 0 then
    for pstId, visitHelpTimeInfo in pairs(self.m_homeland_info.visit_int_info.cul_acc_map) do
      if msgInfo.cul_time[pstId] ~= nil and visitHelpTimeInfo.help_surplus_time ~= msgInfo.cul_time[pstId].help_surplus_time then
        GameGlobal.EventDispatcher():Dispatch(GameEventType.HomelandFriendSpeed, pstId)
      end
    end
  end
  self.m_homeland_info.visit_int_info.cul_acc_map = msgInfo.cul_time
end

function HomelandModule:HandleVisitItemUpdate(msgInfo)
  if self.m_homeland_info.visit_int_info.item_map == nil then
    return
  end
  self.m_homeland_info.visit_int_info.item_map[msgInfo.index] = nil
end

function HomelandModule:PushFinishHomeChatId(petTemplateId, chatId)
  if petTemplateId == nil or chatId == nil or petTemplateId <= 0 or chatId <= 0 then
    return
  end
  local msg = NetMessageFactory:GetInstance():CreateMessage(CEventPushFinishHomeChatId)
  msg.pet_template_id = petTemplateId
  msg.finish_home_pet_chat_id = chatId
  self:Push(msg)
  local chatlist = self.m_homeland_info.complate_chat_ids[petTemplateId]
  if chatlist ~= nil then
    table.insert(chatlist, chatId)
  else
    self.m_homeland_info.complate_chat_ids[petTemplateId] = {chatId}
  end
end

function HomelandModule:GetPetComplatedChatList(petTemplateID)
  local chatlist = self.m_homeland_info.complate_chat_ids[petTemplateID]
  return chatlist
end

function HomelandModule:HideDialogNew(petTemplateID)
  local loginModule = GameGlobal.GetModule(LoginModule)
  return not LocalDB.HasKey("HideDialogNew2" .. loginModule:GetRoleShowID() .. tostring(petTemplateID))
end

function HomelandModule:OnOpenHideDialog(petTemplateID)
  local loginModule = GameGlobal.GetModule(LoginModule)
  LocalDB.SetInt("HideDialogNew2" .. loginModule:GetRoleShowID() .. tostring(petTemplateID), 1)
end

function HomelandModule:ChangeSkin(TT, architecture)
  return self:HomelandBuild(TT, {}, {}, {architecture})
end

function HomelandModule:HasSkinRedPoint(buildId)
  local skinIds = self:GetBuildSkinIds(buildId)
  for i = 1, #skinIds do
    local skinId = skinIds[i]
    if self:HasSkinRedPointBySkinId(skinId) then
      return true
    end
  end
  return false
end

function HomelandModule:HasSkinRedPointBySkinId(skinId)
  if skinId == 0 then
    return false
  end
  local itemModule = GameGlobal.GetModule(ItemModule)
  local items = itemModule:GetItemByTempId(skinId)
  if not items then
    return false
  end
  if 0 >= table.count(items) then
    return false
  end
  local item
  for k, v in pairs(items) do
    item = v
    break
  end
  local isNew = false
  if item:IsNewOverlay() then
    local cfg = Cfg.cfg_item[skinId]
    if cfg.ShowNew and cfg.ShowNew == 1 then
      isNew = true
    end
  end
  return isNew
end

function HomelandModule:SetSkinRedPointStatus(TT, skinId)
  local itemModule = GameGlobal.GetModule(ItemModule)
  local items = itemModule:GetItemByTempId(skinId)
  if not items then
    return
  end
  if table.count(items) <= 0 then
    return
  end
  local item
  for k, v in pairs(items) do
    item = v
    break
  end
  itemModule:SetItemUnnewOverlay(TT, item:GetID())
end

function HomelandModule:GetForgeData()
  if not self.forgeData then
    self.forgeData = UIForgeData:New()
  end
  return self.forgeData
end

function HomelandModule:GetHomelandBackpackData()
  if not self.homelandBackpackData then
    self.homelandBackpackData = UIHomelandBackpackData:New()
  end
  return self.homelandBackpackData
end

function HomelandModule:GetHomelandLevelData()
  if not self._homelandLevelData then
    self._homelandLevelData = UIHomelandLevelData:New()
  end
  return self._homelandLevelData
end

function HomelandModule:GetBuildArchitecture()
  return self.m_homeland_info.architecture_list.architecture_list
end

function HomelandModule:GetAmbientValue()
  local value = 0
  local archs = self:GetBuildArchitecture()
  for _, arch in pairs(archs) do
    if arch.status == ArchitectureStatus.AS_Normal then
      if 0 < arch.skin then
        if not Cfg.cfg_item_architecture_skin[arch.skin] then
          Log.fatal("cfg_item_architecture_skin中缺少配置:arch.skin")
        else
          value = value + Cfg.cfg_item_architecture_skin[arch.skin].LivableValue
        end
      else
        if not Cfg.cfg_item_architecture[arch.asset_id] then
          Log.fatal("cfg_item_architecture中缺少配置:arch.asset_id")
        end
        value = value + Cfg.cfg_item_architecture[arch.asset_id].LivableValue
      end
    end
  end
  local cfg_level = Cfg.cfg_homeland_level[self.m_homeland_info.level]
  value = cfg_level ~= nil and cfg_level.LivableValueMax ~= nil and value > cfg_level.LivableValueMax and cfg_level.LivableValueMax or value
  return value
end

function HomelandModule:HomelandFell(TT, tree_id, cur_fell_times)
  local AsyncRes = AsyncRequestRes:New()
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventHomelandFellReq)
  request.tree_id = tree_id
  request.feel_times = cur_fell_times
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    AsyncRes:SetResult(HomeLandErrorType.E_HOME_LAND_UNLOCK)
    return AsyncRes
  end
  local replyEvent = reply.msg
  if replyEvent.nRet == HomeLandErrorType.E_HOME_LAND_TYPE_SUCCESS then
    self.m_homeland_info.fell_info = replyEvent.fell_info
    AsyncRes:SetSucc(true)
  else
    AsyncRes:SetResult(replyEvent.nRet)
  end
  return AsyncRes, replyEvent.assets
end

function HomelandModule:HomelandGetFellInfo(TT)
  local AsyncRes = AsyncRequestRes:New()
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventFellInfoReq)
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    AsyncRes:SetResult(HomeLandErrorType.E_HOME_LAND_UNLOCK)
    return AsyncRes
  end
  local replyEvent = reply.msg
  if replyEvent.nRet == HomeLandErrorType.E_HOME_LAND_TYPE_SUCCESS then
    self.m_homeland_info.fell_info = replyEvent.fell_info
    AsyncRes:SetSucc(true)
  else
    AsyncRes:SetResult(replyEvent.nRet)
  end
  return AsyncRes
end

function HomelandModule:IsPopDormitoryTips()
  return self.m_homeland_info.dormitory_info.pop_tips
end

function HomelandModule:GetDormitoryNextRefreshStoryTime()
  return self.m_homeland_info.dormitory_info.next_refresh_story_time
end

function HomelandModule:DormitoryChangeName(TT, index, newName)
  local AsyncRes = AsyncRequestRes:New()
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventDormitoryChangeNameReq)
  request.index = index
  request.name = newName
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    AsyncRes:SetResult(HomeLandErrorType.E_HOME_LAND_UNLOCK)
    return AsyncRes
  end
  local replyEvent = reply.msg
  if replyEvent.nRet == HomeLandErrorType.E_HOME_LAND_TYPE_SUCCESS then
    self.m_homeland_info.dormitory_info.list[index].name = newName
    AsyncRes:SetSucc(true)
  else
    AsyncRes:SetResult(replyEvent.nRet)
  end
  return AsyncRes
end

function HomelandModule:DormitoryUpdatePet(TT, data)
  local AsyncRes = AsyncRequestRes:New()
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventDormitoryUpdatePetReq)
  request.updateData = data
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    AsyncRes:SetResult(HomeLandErrorType.E_HOME_LAND_UNLOCK)
    return AsyncRes
  end
  local replyEvent = reply.msg
  if replyEvent.nRet == HomeLandErrorType.E_HOME_LAND_TYPE_SUCCESS then
    local dormitoryInfo = self.m_homeland_info.dormitory_info
    for roomIndex, v in pairs(data) do
      local room = dormitoryInfo.list[roomIndex]
      for petIndex, petID in pairs(v) do
        room.petList[petIndex] = petID
      end
    end
    AsyncRes:SetSucc(true)
  else
    AsyncRes:SetResult(replyEvent.nRet)
  end
  return AsyncRes
end

function HomelandModule:GetAllDomitoryPets()
  local list = {}
  local petModule = GameGlobal.GetModule(PetModule)
  local dormitoryInfo = self.m_homeland_info.dormitory_info
  for roomIndex, v in pairs(dormitoryInfo.list) do
    local room = v
    for petIndex, pstid in pairs(room.petList) do
      local pet = petModule:GetPet(pstid)
      if pet then
        list[#list + 1] = pet
      end
    end
  end
  return list
end

function HomelandModule:GetPetSettledRoom(pstid)
  local dormitoryInfo = self.m_homeland_info.dormitory_info
  for roomIndex, v in pairs(dormitoryInfo.list) do
    local room = v
    for petIndex, petID in pairs(room.petList) do
      if petID == pstid then
        return roomIndex
      end
    end
  end
  return nil
end

function HomelandModule:PetCanSettle(petTmpID)
  local cfgs = Cfg.cfg_home_dormitory_nocheckin_pet({PetID = petTmpID})
  if cfgs and 0 < #cfgs then
    return false
  end
  return true
end

function HomelandModule:GetRoomIntimacySpeed(roomIdx)
  local ambient = self:GetAmbientValue()
  local tmp = Cfg.cfg_homeland_dormitory_favorability({})
  local cfgs = {}
  for _, value in pairs(tmp) do
    table.insert(cfgs, value)
  end
  table.sort(cfgs, function(a, b)
    return a.AtmosphereValue < b.AtmosphereValue
  end)
  local valuePerPet = 0
  for _, cfg in ipairs(cfgs) do
    if ambient <= cfg.AtmosphereValue then
      valuePerPet = cfg.SinglePetAddValue
      break
    end
  end
  if valuePerPet == 0 then
    valuePerPet = cfgs[#cfgs].SinglePetAddValue
  end
  local room = self.m_homeland_info.dormitory_info.list[roomIdx]
  local count = 0
  local settledPetCount = 0
  for _, pstid in ipairs(room.petList) do
    if pstid ~= 0 then
      settledPetCount = settledPetCount + 1
      local pet = self:GetModule(PetModule):GetPet(pstid)
      if pet:GetPetAffinityLevel() < pet:GetPetAffinityMaxLevel() then
        count = count + 1
      end
    end
  end
  if settledPetCount == 0 then
    return 0
  end
  if count == 0 then
    return 0
  end
  return math.floor(valuePerPet * settledPetCount / count)
end

function HomelandModule:ApplyFishBiteHook(TT, fishing_entry_type, fishing_postion_id, following_pets)
  Log.debug("fishing_entry_type : ", fishing_entry_type, "fishing_postion_id : ", fishing_postion_id)
  local AsyncRes = AsyncRequestRes:New()
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventHomelandFishBiteReq)
  request.fishing_position_id = fishing_postion_id
  request.fishing_entry_type = fishing_entry_type
  self._fishing_postion_id = fishing_postion_id
  request.follow_fishing_id = self:GetFollowFishingID(following_pets)
  Log.debug("HomelandModule:ApplyFishBiteHook GetFollowFishingID and  id = ", request.follow_fishing_id)
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    AsyncRes:SetSucc(false)
    AsyncRes:SetResult(-1)
    return AsyncRes
  end
  AsyncRes:SetSucc(true)
  AsyncRes:SetResult(reply.msg.nRet)
  self._bite_fish_id = reply.msg.result_fish_id
  Log.debug("HomelandModule:ApplyFishBiteHook reply.msg.result_fish_id : ", reply.msg.result_fish_id)
  return AsyncRes
end

function HomelandModule:GetFollowFishingID(following_pets)
  local cfgs = Cfg.cfg_homeland_follow_fishing({})
  for id, cfg in pairs(cfgs) do
    if self._fishing_postion_id == cfg.AvailablePositionID then
      for i = 1, #cfg.FollowingProperty do
        if self:FollowPetsHitProperty(following_pets, cfg.FollowingProperty[i]) then
          return cfg.ID
        end
      end
    end
  end
  return 0
end

function HomelandModule:FollowPetsHitProperty(following_pets, propertyTable)
  if #following_pets ~= #propertyTable then
    return false
  end
  for i = 1, #following_pets do
    local petID = following_pets[i]
    local pet_cfg = Cfg.cfg_pet({ID = petID})[1]
    if pet_cfg ~= nil and pet_cfg.PetProperty ~= propertyTable[i] then
      return false
    end
  end
  return true
end

function HomelandModule:GetCurrentBiteFishID()
  return self._bite_fish_id
end

function HomelandModule:ApplyConfirmFishingSuccess(TT, fishing_entry_type, following_pets)
  local AsyncRes = AsyncRequestRes:New()
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventHomelandFishingComfirmReq)
  request.fishing_entry_type = fishing_entry_type
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    AsyncRes:SetSucc(false)
    AsyncRes:SetResult(-1)
    return AsyncRes
  end
  AsyncRes:SetSucc(true)
  AsyncRes:SetResult(reply.msg.nRet)
  Log.debug("HomelandModule:ApplyConfirmFishingSuccess ret : ", reply.msg.nRet)
  self._bite_fish_id = -1
  return AsyncRes
end

function HomelandModule:ApplyFishPostionData(TT)
  local AsyncRes = AsyncRequestRes:New()
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventHomelandGetFishingDataReq)
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    AsyncRes:SetSucc(false)
    AsyncRes:SetResult(-1)
    return AsyncRes
  end
  AsyncRes:SetSucc(true)
  AsyncRes:SetResult(reply.msg.nRet)
  self.m_homeland_info.fishing_data.fishing_postions_data = reply.msg.fishing_postions
  self.m_homeland_info.fishing_data.append_wishingcoin_position = reply.msg.append_wishingcoin_position
  self.m_homeland_info.fishing_data.clue_submit_status = reply.msg.clue_submit_status
  self:_UpdateRareFishingPosition()
  return AsyncRes
end

function HomelandModule:GetFishingPostionData()
  return self.m_homeland_info.fishing_data.fishing_postions_data
end

function HomelandModule:GetWishingCoinPostionData()
  return self.m_homeland_info.fishing_data.append_wishingcoin_position
end

function HomelandModule:GetFishingPositionRandomPosition(positionId)
  if not self._fishingPositionCache then
    self._fishingPositionCache = {}
  end
  if self._fishingPositionCache[positionId] then
    return self._fishingPositionCache[positionId]
  end
  local cfg = HomelandFishingConst.GetFishingPositionCfg(positionId)
  if not cfg then
    return Vector3(0, 0, 0)
  end
  local posArray = cfg.Position
  local index = math.random(1, #posArray)
  local pos = Vector3(cfg.Position[index][1] / 1000, cfg.Position[index][2] / 1000, cfg.Position[index][3] / 1000)
  self._fishingPositionCache[positionId] = pos
  return pos
end

function HomelandModule:ApplyHomelandRefreshRarePosition(TT, rareClueID)
  local AsyncRes = AsyncRequestRes:New()
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventHomelandRefreshRarePositionReq)
  request.rare_clue_id = rareClueID
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    AsyncRes:SetSucc(false)
    AsyncRes:SetResult(-1)
    return AsyncRes
  end
  AsyncRes:SetSucc(true)
  AsyncRes:SetResult(reply.msg.nRet)
  self.m_homeland_info.fishing_data.clue_submit_status = reply.msg.clue_submit_status
  self.m_homeland_info.fishing_data.assets = reply.msg.assets
  self:_UpdateRareFishingPosition()
  return AsyncRes, reply.msg.assets
end

function HomelandModule:_UpdateRareFishingPosition()
  table.clear(self._RareFishingPosition)
  for k, v in pairs(self.m_homeland_info.fishing_data.clue_submit_status) do
    if v.rare_fishing_position ~= 0 then
      table.insert(self._RareFishingPosition, v.rare_fishing_position)
    end
  end
end

function HomelandModule:GetAllRareFishingClue()
  return self.m_homeland_info.fishing_data.clue_submit_status
end

function HomelandModule:GetAllRareFishingPosition()
  return self._RareFishingPosition
end

function HomelandModule:GetPetFishingReward()
  return self.m_homeland_info.fishing_data.assets
end

function HomelandModule:ApplyCollectItem(TT, item_id)
  local AsyncRes = AsyncRequestRes:New()
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventWishingPoolCollectReq)
  request.item_id = item_id
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    AsyncRes:SetSucc(false)
    AsyncRes:SetResult(-1)
    return AsyncRes
  end
  AsyncRes:SetSucc(true)
  AsyncRes:SetResult(reply.msg.nRet)
  self.m_homeland_info.wishing_pool_info.item_count = reply.msg.item_count
  self._wishing_reward = reply.msg.reward
  self.m_homeland_info.wishing_pool_info.wishing_coin_list = reply.msg.wishing_coin_list
  return AsyncRes
end

function HomelandModule:ApplyTakeOutFish(TT, fish_id)
  local AsyncRes = AsyncRequestRes:New()
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventWishingPoolTakeOutReq)
  request.item_id = fish_id
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    AsyncRes:SetSucc(false)
    AsyncRes:SetResult(-1)
    return AsyncRes
  end
  AsyncRes:SetSucc(true)
  AsyncRes:SetResult(reply.msg.nRet)
  self.m_homeland_info.wishing_pool_info.item_count = reply.msg.item_count
  return AsyncRes
end

function HomelandModule:ApplyUpdateWishingPoolAllFish(TT, fishTable)
  local AsyncRes = AsyncRequestRes:New()
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventWishingPoolUpdateFishReq)
  request.all_fish_num = fishTable
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    AsyncRes:SetSucc(false)
    AsyncRes:SetResult(-1)
    return AsyncRes
  end
  AsyncRes:SetSucc(true)
  AsyncRes:SetResult(reply.msg.nRet)
  self.m_homeland_info.wishing_pool_info.item_count = reply.msg.item_count
  return AsyncRes
end

function HomelandModule:ApplyUpdateFishTankAllFish(TT, tank_pstid, fishTable)
  local AsyncRes = AsyncRequestRes:New()
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventFishTankUpdateFishReq)
  request.tank_pst_id = tank_pstid
  request.fish2num = fishTable
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    AsyncRes:SetSucc(false)
    AsyncRes:SetResult(-1)
    return AsyncRes
  end
  AsyncRes:SetSucc(true)
  AsyncRes:SetResult(reply.msg.nRet)
  self.m_homeland_info.wishing_pool_info.fish_tank_item_count[tank_pstid] = reply.msg.fish_tank_item_count
  return AsyncRes
end

function HomelandModule:GetItem2CountMap()
  if not self.m_homeland_info.wishing_pool_info then
    return nil
  end
  return self.m_homeland_info.wishing_pool_info.item_count
end

function HomelandModule:GetWishingCoinList()
  return self.m_homeland_info.wishing_pool_info.wishing_coin_list
end

function HomelandModule:GetFishTankData()
  return self.m_homeland_info.wishing_pool_info.fish_tank_item_count
end

function HomelandModule:DeleteFishTankData(tank_pstid)
  self.m_homeland_info.wishing_pool_info.fish_tank_item_count[tank_pstid] = nil
end

function HomelandModule:GetFishsInBuilding(tplId)
  local placedCount = 0
  local items = self:GetItem2CountMap()
  if items then
    local itemModule = GameGlobal.GetModule(ItemModule)
    for k, v in pairs(items) do
      local tmpCfg = Cfg.cfg_item[k]
      if tmpCfg and tmpCfg.ItemSubType == ItemSubType.ItemSubType_Fish then
        local cfg = Cfg.cfg_item_homeland_fish[k]
        if cfg and cfg.Type == 2 and k == tplId then
          placedCount = placedCount + v
        end
      end
    end
  end
  local fishMapList = self:GetFishTankData()
  if fishMapList then
    local itemModule = GameGlobal.GetModule(ItemModule)
    for buildPstId, items in pairs(fishMapList) do
      for k, v in pairs(items) do
        local tmpCfg = Cfg.cfg_item[k]
        if tmpCfg then
          local cfg = Cfg.cfg_item_homeland_fish[k]
          if cfg and k == tplId then
            placedCount = placedCount + v
          end
        end
      end
    end
  end
  return placedCount
end

function HomelandModule:GetFishsInWishingBuilding()
  local items = self:GetItem2CountMap()
  if not items then
    return {}
  end
  local itemModule = GameGlobal.GetModule(ItemModule)
  local result = {}
  local need_update = false
  for k, v in pairs(items) do
    local tmpCfg = Cfg.cfg_item[k]
    if tmpCfg and tmpCfg.ItemSubType == ItemSubType.ItemSubType_Fish then
      local cfg = Cfg.cfg_item_homeland_fish[k]
      if cfg and cfg.Type == 2 then
        local maxCount = itemModule:GetItemCount(k)
        if v > maxCount then
          v = maxCount
          need_update = true
        end
        result[k] = v
      end
    end
  end
  if need_update then
    GameGlobal.TaskManager():StartTask(self.ApplyUpdateWishingPoolAllFish, self, result)
  end
  return result
end

function HomelandModule:GetFishsInAquarium()
  local fishMapList = self:GetFishTankData()
  if not fishMapList then
    return nil
  end
  local itemModule = GameGlobal.GetModule(ItemModule)
  local result = {}
  for buildPstId, items in pairs(fishMapList) do
    result[buildPstId] = {}
    local need_update = false
    for k, v in pairs(items) do
      local tmpCfg = Cfg.cfg_item[k]
      if tmpCfg then
        local cfg = Cfg.cfg_item_homeland_fish[k]
        if cfg then
          local maxCount = itemModule:GetItemCount(k)
          if v > maxCount then
            v = maxCount
            need_update = true
          end
          result[buildPstId][k] = v
        end
      end
      if need_update then
        GameGlobal.TaskManager():StartTask(self.ApplyUpdateFishTankAllFish, self, buildPstId, result[buildPstId])
      end
    end
  end
  return result
end

function HomelandModule:GetCurrentReward()
  local reward = self._wishing_reward
  self._wishing_reward = {}
  return reward
end

function HomelandModule:CheckTaskGroupTimeLine(group_timeline)
  if not self._svrTimeModule then
    self._svrTimeModule = GameGlobal.GameLogic():GetModule(SvrTimeModule)
  end
  if group_timeline == nil or #group_timeline <= 0 then
    return nil
  end
  local l_ret_group
  local svrTime = math.floor(self._svrTimeModule:GetServerTime() / 1000)
  if group_timeline[1] and svrTime >= group_timeline[1].valid_time + 1 then
    l_ret_group = group_timeline[1]
    table.remove(group_timeline, 1)
  end
  return l_ret_group
end

local EStoryViewStoryStatus = {
  IsView = 0,
  NotView = 1,
  NoStory = 2,
  QuestInvalid = 3
}
_enum("EStoryViewStoryStatus", EStoryViewStoryStatus)

function HomelandModule:CanViewGroupTaskStory(story_mask, quest_id)
  local l_quest_module = GameGlobal.GetModule(QuestModule)
  local pQuest = l_quest_module:GetQuest(quest_id)
  if not pQuest then
    return EStoryViewStoryStatus.QuestInvalid
  end
  local quest_info = pQuest:QuestInfo()
  local cur_story_mask = quest_info.grouptask_cond_cur_progress[EHomelandGroupTaskCond.EHomelandGroupTaskCond_ViewStory]
  if cur_story_mask == story_mask then
    return EStoryViewStoryStatus.IsView
  end
  local total_story_mask = quest_info.grouptask_cond_total_progress[EHomelandGroupTaskCond.EHomelandGroupTaskCond_ViewStory]
  if total_story_mask == nil or total_story_mask & story_mask ~= story_mask then
    return EStoryViewStoryStatus.NoStory
  end
  if cur_story_mask ~= nil and cur_story_mask & story_mask == story_mask then
    return EStoryViewStoryStatus.IsView
  else
    return EStoryViewStoryStatus.NotView
  end
end

function HomelandModule:GetHomelandGroupTaskInfo(questType)
  if questType < QuestType.QT_Homeland_Group_Rookie or 119 < questType then
    return nil
  end
  if not self._svrTimeModule then
    self._svrTimeModule = GameGlobal.GameLogic():GetModule(SvrTimeModule)
  end
  local svrTime = math.floor(self._svrTimeModule:GetServerTime() / 1000)
  local l_quest_module = GameGlobal.GetModule(QuestModule)
  local l_ret_table = {}
  local l_quest_array = l_quest_module:GetQuestByQuestType(questType)
  for index, value in ipairs(l_quest_array) do
    if value:Status() >= QuestStatus.QUEST_Accepted then
      local l_qinfo = value:QuestInfo()
      local l_homeland_task_info = Cfg.cfg_homeland_task[l_qinfo.quest_id]
      if l_homeland_task_info then
        local l_group_id = l_homeland_task_info.GroupID
        if self._task_group_close_time[l_group_id] == nil or self._task_group_close_time[l_group_id] <= 0 or svrTime < self._task_group_close_time[l_group_id] then
          if not l_ret_table[l_group_id] then
            l_ret_table[l_group_id] = {}
          end
          table.insert(l_ret_table[l_group_id], value)
        end
      end
    end
  end
  return l_ret_table
end

function HomelandModule:HandleHomelandTaskViewStoryReq(TT, nQuestId, nHomeLandGroupTaskStoryMask)
  local AsyncRes = AsyncRequestRes:New()
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventHomelandTaskViewStoryReq)
  request.nQuestCfgId = nQuestId
  request.nHomeLandGroupTaskStoryMask = nHomeLandGroupTaskStoryMask
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    AsyncRes:SetResult(HomeLandErrorType.E_HOME_LAND_TYPE_FAILURE)
    return AsyncRes
  end
  local replyEvent = reply.msg
  AsyncRes:SetResult(replyEvent.nRet)
  if replyEvent.nRet == HomeLandErrorType.E_HOME_LAND_TYPE_SUCCESS then
    AsyncRes:SetSucc(true)
  end
  return AsyncRes, replyEvent
end

function HomelandModule:_HandleHomelandUpdateTaskReq(TT)
  Log.info("HomelandModule:_HandleHomelandUpdateTaskReq()")
  local AsyncRes = AsyncRequestRes:New()
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventHomelandUpdateTaskReq)
  request.nGroupCfgIdVec = self.m_RequestGroup.task_group_list
  local reply = self:Call(TT, request)
  self.m_RequestGroup = nil
  if reply.res ~= CallResultType.Normal then
    AsyncRes:SetResult(HomeLandErrorType.E_HOME_LAND_TYPE_FAILURE)
    return AsyncRes
  end
  AsyncRes:SetResult(HomeLandErrorType.E_HOME_LAND_TYPE_SUCCESS)
  AsyncRes:SetSucc(true)
  return AsyncRes
end

function HomelandModule:_HandleHomelandForceUpdateTaskReq(TT, group_list)
  local AsyncRes = AsyncRequestRes:New()
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventHomelandUpdateTaskReq)
  request.nGroupCfgIdVec = group_list
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    AsyncRes:SetResult(HomeLandErrorType.E_HOME_LAND_TYPE_FAILURE)
    return AsyncRes
  end
  AsyncRes:SetResult(HomeLandErrorType.E_HOME_LAND_TYPE_SUCCESS)
  AsyncRes:SetSucc(true)
  return AsyncRes
end

function HomelandModule:HandleHomelandFinishTaskReq(TT, finish_quest_id)
  Log.info("HomelandModule:HandleHomelandFinishTaskReq() finish_quest_id = ", finish_quest_id)
  local AsyncRes = AsyncRequestRes:New()
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventHomelandFinishTaskReq)
  request.nQuestCfgId = finish_quest_id
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    AsyncRes:SetResult(HomeLandErrorType.E_HOME_LAND_TYPE_FAILURE)
    return AsyncRes
  end
  local replyEvent = reply.msg
  AsyncRes:SetResult(replyEvent.nRet)
  if replyEvent.nRet == HomeLandErrorType.E_HOME_LAND_TYPE_SUCCESS then
    AsyncRes:SetSucc(true)
  end
  return AsyncRes, replyEvent
end

function HomelandModule:HandleHomelandTaskGroupTakeReq(TT, group_id)
  Log.info("HomelandModule:HandleHomelandTaskGroupTakeReq() group_id = ", group_id)
  local AsyncRes = AsyncRequestRes:New()
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventHomelandTaskGroupTakeReq)
  request.nTaskGroupId = group_id
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    AsyncRes:SetResult(HomeLandErrorType.E_HOME_LAND_TYPE_FAILURE)
    return AsyncRes
  end
  local replyEvent = reply.msg
  AsyncRes:SetResult(replyEvent.nRet)
  if replyEvent.nRet == HomeLandErrorType.E_HOME_LAND_TYPE_SUCCESS then
    AsyncRes:SetSucc(true)
    table.insert(self.m_group_id_set, group_id)
  end
  return AsyncRes, replyEvent
end

function HomelandModule:HandleHomelandTaskQuestTakeReq(TT, quest_id)
  Log.info("HomelandModule:HandleHomelandTaskQuestTakeReq() quest_id = ", quest_id)
  local AsyncRes = AsyncRequestRes:New()
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventHomelandTaskQuestTakeReq)
  request.nQuestCfgId = quest_id
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    AsyncRes:SetResult(HomeLandErrorType.E_HOME_LAND_TYPE_FAILURE)
    return AsyncRes
  end
  local replyEvent = reply.msg
  AsyncRes:SetResult(replyEvent.nRet)
  if replyEvent.nRet == HomeLandErrorType.E_HOME_LAND_TYPE_SUCCESS then
    AsyncRes:SetSucc(true)
  else
    Log.error("HomelandModule:HandleHomelandTaskQuestTakeReq error nRet:", replyEvent.nRet, " quetid: ", quest_id, " quest_ret: ", replyEvent.nQuestRet)
  end
  return AsyncRes, replyEvent
end

function HomelandModule:HandleCultivation(TT, cultivation_info)
  local AsyncRes = AsyncRequestRes:New()
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventCultivationReq)
  request.cultivation_info = cultivation_info
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    AsyncRes:SetResult(HomeLandErrorType.E_HOME_LAND_UNLOCK)
    return AsyncRes
  end
  local replyEvent = reply.msg
  if replyEvent.nRet == HomeLandErrorType.E_HOME_LAND_TYPE_SUCCESS then
    self.m_homeland_info.cultivation_info = replyEvent.infos
    AsyncRes:SetSucc(true)
  else
    AsyncRes:SetResult(replyEvent.nRet)
  end
  return AsyncRes
end

function HomelandModule:HandleCancelCultivation(TT, land_pstid)
  local AsyncRes = AsyncRequestRes:New()
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventCultivationCancelReq)
  request.land_pstid = land_pstid
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    AsyncRes:SetResult(HomeLandErrorType.E_HOME_LAND_UNLOCK)
    return AsyncRes
  end
  local replyEvent = reply.msg
  if replyEvent.nRet == HomeLandErrorType.E_HOME_LAND_TYPE_SUCCESS then
    self.m_homeland_info.cultivation_info = replyEvent.infos
    AsyncRes:SetSucc(true)
  else
    AsyncRes:SetResult(replyEvent.nRet)
  end
  return AsyncRes
end

function HomelandModule:HandleAccelerateCultivation(TT, land_pstid, item_info)
  local AsyncRes = AsyncRequestRes:New()
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventCultivationAccelerateReq)
  request.land_pstid = land_pstid
  request.item_info = item_info
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    AsyncRes:SetResult(HomeLandErrorType.E_HOME_LAND_UNLOCK)
    return AsyncRes
  end
  local replyEvent = reply.msg
  if replyEvent.nRet == HomeLandErrorType.E_HOME_LAND_TYPE_SUCCESS then
    self.m_homeland_info.cultivation_info = replyEvent.infos
    AsyncRes:SetSucc(true)
  else
    AsyncRes:SetResult(replyEvent.nRet)
  end
  return AsyncRes
end

function HomelandModule:HandlePickupCultivation(TT, land_pstid)
  local AsyncRes = AsyncRequestRes:New()
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventCultivationPickUpReq)
  request.land_pstid = land_pstid
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    AsyncRes:SetResult(HomeLandErrorType.E_HOME_LAND_UNLOCK)
    return AsyncRes
  end
  local replyEvent = reply.msg
  if replyEvent.nRet == HomeLandErrorType.E_HOME_LAND_TYPE_SUCCESS then
    self.m_homeland_info.cultivation_info = replyEvent.infos
    AsyncRes:SetSucc(true)
  else
    AsyncRes:SetResult(replyEvent.nRet)
  end
  return AsyncRes, replyEvent.items, replyEvent.homeland_exp, replyEvent.is_first
end

function HomelandModule:HandDyeingTree(TT, tree_pstid, select_tree_id, dye_item_id)
  local AsyncRes = AsyncRequestRes:New()
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventDyeingTreeReq)
  request.architecture_pstid = tree_pstid
  request.select_tree_id = select_tree_id
  request.dye_item_id = dye_item_id
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    AsyncRes:SetSucc(true)
    AsyncRes:SetResult(-1)
    return AsyncRes
  end
  local replyEvent = reply.msg
  if replyEvent.nRet == HomeLandErrorType.E_HOME_LAND_TYPE_SUCCESS then
    self.m_homeland_info.architecture_list.architecture_list[replyEvent.arch_info.pstid] = replyEvent.arch_info
    AsyncRes:SetSucc(true)
  else
    AsyncRes:SetResult(replyEvent.nRet)
  end
  return AsyncRes, replyEvent.arch_info
end

function HomelandModule:HandleDormitoryUpdate(msgInfo)
  self.m_homeland_info.dormitory_info.list = msgInfo.list
end

function HomelandModule:HandlePushEventChange(msgInfo)
  self.m_homeland_info.event_info = msgInfo.event_info
  GameGlobal.EventDispatcher():Dispatch(GameEventType.HomeLandEventChange, msgInfo.erase_event_id, msgInfo.trigger_immediately_event)
end

function HomelandModule:HomelandMining(TT, mine_id, cur_times)
  local AsyncRes = AsyncRequestRes:New()
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventHomelandMiningReq)
  request.mine_id = mine_id
  request.mining_times = cur_times
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    AsyncRes:SetResult(HomeLandErrorType.E_HOME_LAND_UNLOCK)
    return AsyncRes
  end
  local replyEvent = reply.msg
  if replyEvent.nRet == HomeLandErrorType.E_HOME_LAND_TYPE_SUCCESS then
    self.m_homeland_info.mining_info = replyEvent.mining_info
    AsyncRes:SetSucc(true)
  else
    AsyncRes:SetResult(replyEvent.nRet)
  end
  return AsyncRes, replyEvent.assets
end

function HomelandModule:HomelandGetMiningInfo(TT)
  local AsyncRes = AsyncRequestRes:New()
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventMiningInfoReq)
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    AsyncRes:SetResult(HomeLandErrorType.E_HOME_LAND_UNLOCK)
    return AsyncRes
  end
  local replyEvent = reply.msg
  if replyEvent.nRet == HomeLandErrorType.E_HOME_LAND_TYPE_SUCCESS then
    self.m_homeland_info.mining_info = replyEvent.mining_info
    AsyncRes:SetSucc(true)
  else
    AsyncRes:SetResult(replyEvent.nRet)
  end
  return AsyncRes
end

function HomelandModule:HomelandSign(TT)
  local AsyncRes = AsyncRequestRes:New()
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventHomelandSignReq)
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    AsyncRes:SetResult(HomeLandErrorType.E_HOME_LAND_UNLOCK)
    return AsyncRes
  end
  local replyEvent = reply.msg
  if replyEvent.nRet == HomeLandErrorType.E_HOME_LAND_TYPE_SUCCESS then
    self.m_homeland_info.sign_info = replyEvent.info
    AsyncRes:SetSucc(true)
  else
    AsyncRes:SetResult(replyEvent.nRet)
  end
  return AsyncRes
end

function HomelandModule:HomelandLevelReward(TT, level)
  local AsyncRes = AsyncRequestRes:New()
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventHomelandLevelRewardReq)
  request.level = level
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    AsyncRes:SetResult(HomeLandErrorType.E_HOME_LAND_UNLOCK)
    return AsyncRes
  end
  local replyEvent = reply.msg
  if replyEvent.nRet == HomeLandErrorType.E_HOME_LAND_TYPE_SUCCESS then
    self.m_homeland_info.sign_info = replyEvent.info
    AsyncRes:SetSucc(true)
  else
    AsyncRes:SetResult(replyEvent.nRet)
  end
  return AsyncRes, replyEvent.assets
end

function HomelandModule:HomelandGetSignInfo(TT)
  local AsyncRes = AsyncRequestRes:New()
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventGetSignInfoReq)
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    AsyncRes:SetResult(HomeLandErrorType.E_HOME_LAND_UNLOCK)
    return AsyncRes
  end
  local replyEvent = reply.msg
  if replyEvent.nRet == HomeLandErrorType.E_HOME_LAND_TYPE_SUCCESS then
    self.m_homeland_info.sign_info = replyEvent.info
    AsyncRes:SetSucc(true)
  else
    AsyncRes:SetResult(replyEvent.nRet)
  end
  return AsyncRes
end

function HomelandModule:GetVisitErrorMsg(errorcode)
  Log.fatal("[VisitError] " .. errorcode)
  if errorcode < HomeLandErrorType.E_HET_VISIT_NO_FRIEND or errorcode > HomeLandErrorType.E_HET_VISIT_STATE_LOCK then
    return StringTable.Get("str_homeland_visit_errorcode_unknown", errorcode)
  elseif errorcode == HomeLandErrorType.E_HOME_LAND_TYPE_FAILURE then
    return StringTable.Get("str_homeland_visit_errorcode_622")
  end
  return StringTable.Get("str_homeland_visit_errorcode_" .. errorcode)
end

function HomelandModule:ClearNormalData()
end

function HomelandModule:GetLandEndTime(landInfo)
  local helpInfo = self.m_homeland_info.visit_int_info.cul_acc_map[landInfo.client_info.land_pstid]
  if helpInfo then
    return landInfo.end_time - helpInfo.offline_help_time
  end
  return landInfo.end_time
end

function HomelandModule:GetDomitoryByPstID(id)
  local info = self.m_homeland_info.dormitory_info
  for i = 1, 4 do
    local room = info.list[i]
    if room and room.bBulid and room.architectureID == id then
      return room
    end
  end
end

function HomelandModule:SetniqueTreeData(cultivation_data)
  self.m_homeland_info.cultivation_info = cultivation_data
end

function HomelandModule:SetForgeData(forge_data)
  self.m_homeland_info.forge_info = forge_data
end

function HomelandModule:SetMovieInfo(movie_info)
  self.m_homeland_info.movice_info = movie_info
end

function HomelandModule:SetVisitHelpData(visit_help_data)
  if not self.m_homeland_info.visit_int_info then
    self.m_homeland_info.visit_int_info = {}
  end
  self.m_homeland_info.visit_int_info.cul_acc_map = visit_help_data
end

function HomelandModule:GetUniqueTreeNum()
  if not self.m_homeland_info.cultivation_info then
    return 0
  end
  local cultivation_info = self.m_homeland_info.cultivation_info.land_cultivation_infos
  local time_mod = GameGlobal.GameLogic():GetModule(SvrTimeModule)
  if not time_mod then
    return false
  end
  local tm_now = math.modf(time_mod:GetServerTime() / 1000)
  local tree_num = 0
  for key, value in pairs(cultivation_info) do
    local end_time = self:GetLandEndTime(value)
    if tm_now >= end_time then
      tree_num = tree_num + 1
    end
  end
  return tree_num
end

function HomelandModule:GetForgeNum()
  if not self.m_homeland_info.forge_info then
    return 0
  end
  local forge_list = self.m_homeland_info.forge_info.forge_list
  local time_mod = GameGlobal.GameLogic():GetModule(SvrTimeModule)
  if not time_mod then
    return false
  end
  local tm_now = math.modf(time_mod:GetServerTime() / 1000)
  local forge_num = 0
  for index, value in ipairs(forge_list) do
    if tm_now >= value.end_time then
      forge_num = forge_num + 1
    end
  end
  return forge_num
end

function HomelandModule:GetMainRedCount()
  local forgeNumber = self:GetForgeNum()
  local treeNumber = self:GetUniqueTreeNum()
  local num = forgeNumber + treeNumber
  return num
end

function HomelandModule:GetAmbientCeiling()
  return Cfg.cfg_homeland_level[self.m_homeland_info.level].LivableValueMax
end

function HomelandModule:PlayTreeDyeAnimation(pstId)
  GameGlobal.TaskManager():StartTask(function(TT)
    local key = "HomelandModulePlayTreeDyeAnimation"
    GameGlobal.UIStateManager():Lock(key)
    local mUIHomeland = self:GetUIModule()
    local homelandClient = mUIHomeland:GetClient()
    local homeBuildManager = homelandClient:BuildManager()
    local tree
    local buildings = homeBuildManager:GetBuildings()
    for _, building in ipairs(buildings) do
      if building:GetBuildPstId() == pstId then
        tree = building
      end
    end
    local meshroot = "meshroot"
    local tran = tree:GetBoneNode(meshroot)
    local ma = tran:GetComponent(typeof(MaterialAnimation))
    if ma then
      ma:Play("effanim_jy_ProductPfb_tree_out")
    end
    YIELD(TT, 500)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.ResetOneBuilding, pstId, true)
    local tran = tree:GetBoneNode(meshroot)
    local ma = tran:GetComponent(typeof(MaterialAnimation))
    if ma then
      ma:Play("effanim_jy_ProductPfb_tree_in")
    end
    YIELD(TT, 1000)
    GameGlobal.UIStateManager():UnLock(key)
  end, self)
end

function HomelandModule:HomelandStoryTaskUnlockReq(TT, id)
  local asyncRes = AsyncRequestRes:New()
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventHomelandStoryTaskUnlockReq)
  request.id = id
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    asyncRes:SetResult(HomeLandErrorType.E_HOME_LAND_UNLOCK)
    return asyncRes
  end
  local replyEvent = reply.msg
  if replyEvent.nRet == HomeLandErrorType.E_HOME_LAND_TYPE_SUCCESS then
    table.insert(self.m_homeland_info.story_task_info.id_list, id)
    asyncRes:SetSucc(true)
  else
    asyncRes:SetResult(replyEvent.nRet)
  end
  return asyncRes, replyEvent
end

function HomelandModule:HomelandStoryTaskAutoOperateReq(TT, id)
  local asyncRes = AsyncRequestRes:New()
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventHomelandStoryTaskAutoOperateReq)
  request.id = id
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    asyncRes:SetResult(HomeLandErrorType.E_HOME_LAND_UNLOCK)
    return asyncRes
  end
  local replyEvent = reply.msg
  if replyEvent.nRet == HomeLandErrorType.E_HOME_LAND_TYPE_SUCCESS then
    if self.m_homeland_info.story_task_info.cfg_id == id then
      self.m_homeland_info.story_task_info.cfg_id = 0
    else
      self.m_homeland_info.story_task_info.cfg_id = id
    end
    asyncRes:SetSucc(true)
  else
    asyncRes:SetResult(replyEvent.nRet)
  end
  return asyncRes, replyEvent
end

function HomelandModule:HandleStoryTaskUpdate(msg)
  self.m_homeland_info.story_task_info = msg.info
  GameGlobal.EventDispatcher():Dispatch(GameEventType.HandleStoryTaskUpdate, msg.info)
end

function HomelandModule:HomelandStoryTaskMoudleUnlockReq(TT)
  local asyncRes = AsyncRequestRes:New()
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventHomelandStoryTaskMoudleUnlockReq)
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    asyncRes:SetResult(HomeLandErrorType.E_HOME_LAND_UNLOCK)
    return asyncRes
  end
  local replyEvent = reply.msg
  if replyEvent.nRet == HomeLandErrorType.E_HOME_LAND_TYPE_SUCCESS then
    self.m_homeland_info.story_task_info = replyEvent.info
    asyncRes:SetSucc(true)
  else
    asyncRes:SetResult(replyEvent.nRet)
  end
  return asyncRes, replyEvent
end

function HomelandModule:SetStoryTaskAutoReq(autoReq, id)
  self._storyTask_autoReq = autoReq
  if autoReq then
    self._storyTask_id = id
  end
end

function HomelandModule:HomelandStoryTaskAutoTraceReq(TT)
  local autoReq = self._storyTask_autoReq
  local id = self._storyTask_id
  self:SetStoryTaskAutoReq(false)
  if autoReq then
    local res = self:HomelandStoryTaskUnlockReq(TT, id)
    if self.m_homeland_info.story_task_info.cfg_id ~= self._storyTask_id then
      res = self:HomelandStoryTaskAutoOperateReq(TT, id)
    end
    if res:GetSucc() then
      GameGlobal.EventDispatcher():Dispatch(GameEventType.HandleStoryTaskUpdate)
    end
  end
end

function HomelandModule:HandleUnlockHangPoint(TT, pstid, hang_point_id)
  local AsyncRes = AsyncRequestRes:New()
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventUnlockFatherHangPointReq)
  request.pstid = pstid
  request.hang_point_id = hang_point_id
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    AsyncRes:SetResult(HomeLandErrorType.E_HOME_LAND_UNLOCK)
    return AsyncRes
  end
  local replyEvent = reply.msg
  if replyEvent.nRet == HomeLandErrorType.E_HOME_LAND_TYPE_SUCCESS then
    self.m_homeland_info.fater_arch_info.infos[replyEvent.data.id] = replyEvent.data
    AsyncRes:SetSucc(true)
  else
    AsyncRes:SetResult(replyEvent.nRet)
  end
  return AsyncRes
end

function HomelandModule:GetHangPointInfo(buildingID)
  local infos = self.m_homeland_info.fater_arch_info.infos
  local info = infos[buildingID]
  if info then
    return info.clean_hang_point
  end
  return {}
end

function HomelandModule:CheckEventFinished(eventID)
  if self.m_homeland_info.event_info.finish_event_list[eventID] then
    return true
  else
    return false
  end
end

function HomelandModule:HandleEnterMakingMovice(TT, movice_id)
  local AsyncRes = AsyncRequestRes:New()
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventEnterMakingMoviceReq)
  request.movice_id = movice_id
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    AsyncRes:SetResult(HomeLandErrorType.E_HOME_LAND_UNLOCK)
    return AsyncRes
  end
  local replyEvent = reply.msg
  if replyEvent.nRet == HomeLandErrorType.E_HOME_LAND_TYPE_SUCCESS then
    self.movice_pstid = replyEvent.pstid
    AsyncRes:SetSucc(true)
  else
    AsyncRes:SetResult(replyEvent.nRet)
  end
  return AsyncRes, replyEvent.pstid
end

function HomelandModule:HandleReuestScore(TT, movice_pstid, movice_info)
  local AsyncRes = AsyncRequestRes:New()
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventRequestScoreReq)
  request.pstid = movice_pstid
  request.record = movice_info
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    AsyncRes:SetResult(HomeLandErrorType.E_HOME_LAND_UNLOCK)
    return AsyncRes
  end
  local replyEvent = reply.msg
  if replyEvent.nRet == HomeLandErrorType.E_HOME_LAND_TYPE_SUCCESS then
    self.m_homeland_info.movice_info.movices[replyEvent.data.movice_id] = replyEvent.data
    AsyncRes:SetSucc(true)
  else
    AsyncRes:SetResult(replyEvent.nRet)
  end
  return AsyncRes, replyEvent
end

function HomelandModule:HandleSubmitRecordName(TT, movice_pstid, name)
  local AsyncRes = AsyncRequestRes:New()
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventSubmitRecordNameReq)
  request.pstid = movice_pstid
  request.name = name
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    AsyncRes:SetResult(HomeLandErrorType.E_HOME_LAND_UNLOCK)
    return AsyncRes
  end
  local replyEvent = reply.msg
  if replyEvent.nRet == HomeLandErrorType.E_HOME_LAND_TYPE_SUCCESS then
    AsyncRes:SetSucc(true)
  else
    AsyncRes:SetResult(replyEvent.nRet)
  end
  return AsyncRes
end

function HomelandModule:HandleSaveRecord(TT, cur_movice_pstid, replace_movice_pstid, arch_list)
  local AsyncRes = AsyncRequestRes:New()
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventSaveRecordReq)
  request.cur_record_pstid = cur_movice_pstid
  request.arch_list = arch_list
  request.replace_record_pstid = replace_movice_pstid
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    AsyncRes:SetResult(HomeLandErrorType.E_HOME_LAND_UNLOCK)
    return AsyncRes
  end
  local replyEvent = reply.msg
  if replyEvent.nRet == HomeLandErrorType.E_HOME_LAND_TYPE_SUCCESS then
    self.m_homeland_info.movice_info.movices[replyEvent.data.movice_id] = replyEvent.data
    AsyncRes:SetSucc(true)
  else
    AsyncRes:SetResult(replyEvent.nRet)
  end
  return AsyncRes
end

function HomelandModule:HandleRequesRecordArch(TT, pstid, movice_id)
  local AsyncRes = AsyncRequestRes:New()
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventRequestRecordArchReq)
  request.pstid = pstid
  request.movice_id = movice_id
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    AsyncRes:SetResult(HomeLandErrorType.E_HOME_LAND_UNLOCK)
    return AsyncRes
  end
  local replyEvent = reply.msg
  if replyEvent.nRet == HomeLandErrorType.E_HOME_LAND_TYPE_SUCCESS then
    AsyncRes:SetSucc(true)
  else
    AsyncRes:SetResult(replyEvent.nRet)
  end
  return AsyncRes, replyEvent.arch_list
end

function HomelandModule:HandleRefreshRarePositionUpdate(msg)
  self.m_homeland_info.fishing_data.clue_submit_status = msg.clue_submit_status
  self:_UpdateRareFishingPosition()
end

function HomelandModule:HandleFishMatchBegin(TT, match_main_id)
  local AsyncRes = AsyncRequestRes:New()
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventFishingChallengeReq)
  request.match_main_id = match_main_id
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    AsyncRes:SetResult(HomeLandErrorType.E_HOME_LAND_UNLOCK)
    return AsyncRes
  end
  local replyEvent = reply.msg
  if replyEvent.nRet == HomeLandErrorType.E_HOME_LAND_TYPE_SUCCESS then
    self.m_match_end_time = replyEvent.end_time
    self.m_pet_ability_id = replyEvent.pet_ability_id
    self.m_match_main_id = match_main_id
    AsyncRes:SetSucc(true)
  else
    AsyncRes:SetResult(replyEvent.nRet)
  end
  return AsyncRes
end

function HomelandModule:HandleFishMatchEnd(TT, pet_fish_num)
  local AsyncRes = AsyncRequestRes:New()
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventFishingChallengeEndReq)
  request.pet_fish_num = pet_fish_num
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    AsyncRes:SetResult(HomeLandErrorType.E_HOME_LAND_UNLOCK)
    return AsyncRes
  end
  local replyEvent = reply.msg
  if replyEvent.nRet == HomeLandErrorType.E_HOME_LAND_TYPE_SUCCESS then
    self.m_homeland_info.fishing_data.challenge_pet_times = replyEvent.challenge_pet_times
    self.m_match_end_time = 0
    self.m_pet_ability_id = 0
    self.m_match_main_id = 0
    AsyncRes:SetSucc(true)
  else
    AsyncRes:SetResult(replyEvent.nRet)
  end
  return AsyncRes, replyEvent.success, replyEvent.rewards
end

function HomelandModule:HandleFishMatchCancel(TT, match_main_id)
  local AsyncRes = AsyncRequestRes:New()
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventCancelFishingChallengeReq)
  request.match_main_id = match_main_id
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    AsyncRes:SetResult(HomeLandErrorType.E_HOME_LAND_UNLOCK)
    return AsyncRes
  end
  local replyEvent = reply.msg
  if replyEvent.nRet == HomeLandErrorType.E_HOME_LAND_TYPE_SUCCESS then
    self.m_match_end_time = 0
    self.m_pet_ability_id = 0
    self.m_match_main_id = 0
    AsyncRes:SetSucc(true)
  else
    AsyncRes:SetResult(replyEvent.nRet)
  end
  return AsyncRes
end

function HomelandModule:HandleGetAnonymousLetterReward(TT, anonymous_letter_id)
  local AsyncRes = AsyncRequestRes:New()
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventReceiveAnonymousLetterRewardReq)
  request.anonymous_letter_id = anonymous_letter_id
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    AsyncRes:SetResult(HomeLandErrorType.E_HOME_LAND_UNLOCK)
    return AsyncRes
  end
  local replyEvent = reply.msg
  if replyEvent.nRet == HomeLandErrorType.E_HOME_LAND_TYPE_SUCCESS then
    self.m_homeland_info.movice_info.anonymous_letter_reward = replyEvent.anonymous_letter_receive
    AsyncRes:SetSucc(true)
  else
    AsyncRes:SetResult(replyEvent.nRet)
  end
  return AsyncRes, replyEvent.rewards
end

function HomelandModule:GetAnonymousLetterRreward()
  return self.m_homeland_info.movice_info.anonymous_letter_reward
end
