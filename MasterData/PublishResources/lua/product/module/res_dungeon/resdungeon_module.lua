_class("ResDungeonModule", GameModule)
ResDungeonModule = ResDungeonModule

function ResDungeonModule:Constructor()
  self._alreadyReturnPowerResDungeonList = {}
  self._formationInfos = {}
  self._all_instance = {}
  self._openStatus = {}
  self._passed_instances = {}
  self._double_res_is_open = false
  self._clientResInstance = nil
end

function ResDungeonModule:GetClientResInstance()
  return self._clientResInstance
end

function ResDungeonModule:Init()
  self.caller:RegisterPushHandler(CEventPushResDungeonData, self.HandleResDungeonAllData, self)
  self.caller:RegisterPushHandler(CEventPushAlreadyReturnPowerDungeon, self.HandleAlreadyReturnPowerDungeon, self)
end

function ResDungeonModule:HandleResDungeonAllData(msg)
  self._openStatus = msg.open_status
  self._all_instance = msg.all_instance
  self._passed_instances = msg.passed_instance
  self._double_res_is_open = msg.double_res_state
end

function ResDungeonModule:HandleAlreadyReturnPowerDungeon(msg)
  for key, value in pairs(msg.ids) do
    self._alreadyReturnPowerResDungeonList[key] = value
  end
end

function ResDungeonModule:IsOpenDoubleRes()
  return false
end

function ResDungeonModule:SetDoubleResSwitch(TT, bIsOpen)
  if bIsOpen == self._double_res_is_open then
    return RES_DUNGEON_CODE.RES_DUNGEON_SUCCEED
  end
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventSetDoubleResStatus)
  request.open_switch_on = bIsOpen
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    return RES_DUNGEON_CODE.RES_DUNGEON_DOUBLE_RES_INVALID
  end
  if reply.msg.ret == RES_DUNGEON_CODE.RES_DUNGEON_SUCCEED then
    self._double_res_is_open = bIsOpen
  end
  return reply.msg.ret
end

function ResDungeonModule:GetOpenStatus(TT)
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventApplyDungeonStatus)
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    return {}
  end
  self._openStatus = reply.msg.open_status
  self._double_res_is_open = reply.msg.double_res_state
  return self._openStatus
end

function ResDungeonModule:GetCoinInstanceData(TT)
  local instance_data = {}
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventApplyDungeonData)
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    return OpenStatus.Dungeon_ReturnError, instance_data
  end
  local open_status = reply.msg.open_status[DungeonType.DungeonType_Coin]
  instance_data = reply.msg.all_instance[DungeonType.DungeonType_Coin]
  self:HandleResDungeonAllData(reply.msg)
  return open_status, instance_data
end

function ResDungeonModule:GetAircraftmaterialInstanceData(TT)
  local instance_data = {}
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventApplyDungeonData)
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    return OpenStatus.Dungeon_ReturnError, instance_data
  end
  local open_status = reply.msg.open_status[DungeonType.DungeonType_AircraftMaterial]
  instance_data = reply.msg.all_instance[DungeonType.DungeonType_AircraftMaterial]
  self:HandleResDungeonAllData(reply.msg)
  return open_status, instance_data
end

function ResDungeonModule:GetEquipInstanceData(TT)
  local instance_data = {}
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventApplyDungeonData)
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    return OpenStatus.Dungeon_ReturnError, instance_data
  end
  local open_status = reply.msg.open_status[DungeonType.DungeonType_equip]
  instance_data = reply.msg.all_instance[DungeonType.DungeonType_equip]
  self:HandleResDungeonAllData(reply.msg)
  return open_status, instance_data
end

function ResDungeonModule:GetExperienceInstanceData(TT)
  local instance_data = {}
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventApplyDungeonData)
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    return OpenStatus.Dungeon_ReturnError, instance_data
  end
  local open_status = reply.msg.open_status[DungeonType.DungeonType_Experience]
  instance_data = reply.msg.all_instance[DungeonType.DungeonType_Experience]
  self:HandleResDungeonAllData(reply.msg)
  return open_status, instance_data
end

function ResDungeonModule:StartMatchTask(TT, instance_id, formation_id)
  local game = GameGlobal.GetModule(GameMatchModule)
  local info = game:GetMatchCreateInfo(MatchType.MT_ResDungeon, instance_id)
  local res = game:StartMatchTask(TT, MatchType.MT_ResDungeon, formation_id, info)
  return res
end

function ResDungeonModule:GetInstanceDataList(mainType)
  return self._all_instance[mainType]
end

function ResDungeonModule:IsResDungeonUnlocked()
  return next(self._all_instance) ~= nil
end

function ResDungeonModule:IsResDungeonPassed(InstanceId)
  for _id, value in pairs(self._passed_instances) do
    if InstanceId == value then
      return true
    end
  end
  return false
end

function ResDungeonModule:GetEntryOpenStatus(mainType)
  return self._openStatus[mainType]
end

function ResDungeonModule:SetEnterInstanceId(id)
  self.enterInstanceId = id
end

function ResDungeonModule:GetEnterInstanceId()
  return self.enterInstanceId
end

function ResDungeonModule:GetResDungeonDetail(instanceId, colorStr)
  local cfg = Cfg.cfg_res_instance_detail[instanceId]
  local dungeonInfo = self:GetDungeonInfoByInstanceId(instanceId)
  local condition = dungeonInfo and dungeonInfo.passed_condition or {}
  local data = {}
  data.m_vecCondition = {}
  data.m_vecCondition[1] = self:ConvertCondition(condition, cfg.ThreeStarCondition1, colorStr)
  data.m_vecCondition[2] = self:ConvertCondition(condition, cfg.ThreeStarCondition2, colorStr)
  data.m_vecCondition[3] = self:ConvertCondition(condition, cfg.ThreeStarCondition3, colorStr)
  return data
end

function ResDungeonModule:ConvertCondition(vecPassCondition, nConditionID, colorStr)
  local data = {}
  data.m_nID = nConditionID
  data.m_stDest = self:GetConditionDesc(nConditionID, colorStr)
  data.m_bPass = self:IsConditionPass(vecPassCondition, nConditionID)
  return data
end

function ResDungeonModule:IsConditionPass(vecCondition, nConditionID)
  for _, conditionPass in pairs(vecCondition) do
    if conditionPass == nConditionID then
      return true
    end
  end
  return false
end

function ResDungeonModule:GetConditionDesc(condition_id, colorStr)
  local missionModule = self:GetModule(MissionModule)
  return missionModule:Get3StarConditionDesc(condition_id, colorStr)
end

function ResDungeonModule:GetDoubleResNum()
  local itemMd = self:GetModule(ItemModule)
  return itemMd:GetItemCount(RoleAssetID.RoleAssetDoubleRes)
end

function ResDungeonModule:GetDungeonInfoByInstanceId(instanceId)
  local cfg = Cfg.cfg_res_instance_detail[instanceId]
  if not cfg then
    return nil
  end
  local mainType = cfg.MainType
  local dataList = self:GetInstanceDataList(mainType)
  for index, value in ipairs(dataList) do
    if value.dungeon_id == instanceId then
      return value
    end
  end
  return nil
end

function ResDungeonModule:Module_ConvertMatchResult(recvResult)
  local uiMatchResult = UI_MatchResult:New()
  uiMatchResult.m_nMatchType = MatchType.MT_ResDungeon
  uiMatchResult.m_nID = recvResult.res_dungeon_id
  local cfg = Cfg.cfg_res_instance_detail[recvResult.res_dungeon_id]
  uiMatchResult.m_stShowName = StringTable.Get(cfg.Name)
  uiMatchResult.m_vecAwardNormal = recvResult.rewards
  local notInNormalRewarsIndex = {}
  for i, var in ipairs(recvResult.ext_rewards) do
    local isAdd = false
    for index, value in ipairs(uiMatchResult.m_vecAwardNormal) do
      if value.assetid == var.assetid then
        value.count = value.count + var.count
        isAdd = true
      end
    end
    if isAdd == false then
      notInNormalRewarsIndex[#notInNormalRewarsIndex + 1] = i
    end
  end
  for i, var in ipairs(notInNormalRewarsIndex) do
    uiMatchResult.m_vecAwardNormal[#uiMatchResult.m_vecAwardNormal + 1] = recvResult.ext_rewards[var]
  end
  uiMatchResult.m_vecExtAward = recvResult.ext_rewards_no_double
  uiMatchResult.m_vecDoubleExtAward = recvResult.double_ext_rewards
  uiMatchResult.m_matchResRolInfo = recvResult.match_result_role_info
  uiMatchResult.m_back_rewards = recvResult.res_help_component_rewards
  return uiMatchResult
end

function ResDungeonModule:Module_SweepConvertMatchResult(recvResult)
  local uiMatchResult = UI_MatchResult:New()
  uiMatchResult.m_nMatchType = MatchType.MT_ResDungeon
  uiMatchResult.m_nID = recvResult.res_dungeon_id
  local cfg = Cfg.cfg_res_instance_detail[recvResult.res_dungeon_id]
  uiMatchResult.m_stShowName = StringTable.Get(cfg.Name)
  uiMatchResult.m_vecAwardNormal = recvResult.rewards
  uiMatchResult.m_coin_ext_rewards = recvResult.ext_rewards
  uiMatchResult.m_vecExtAward = recvResult.ext_rewards_no_double
  uiMatchResult.m_vecDoubleExtAward = recvResult.double_ext_rewards
  uiMatchResult.m_matchResRolInfo = recvResult.match_result_role_info
  uiMatchResult.m_back_rewards = recvResult.res_help_component_rewards
  uiMatchResult.m_vecFirstPassAward = recvResult.first_rewards
  return uiMatchResult
end

function ResDungeonModule:AlreadyReturnedPower(id)
  for key, value in pairs(self._alreadyReturnPowerResDungeonList) do
    if id == value then
      return false
    end
  end
  return true
end

function ResDungeonModule:SetAllData(all_data)
  self._clientResInstance = ClientResInstance:New()
  self:HandleResDungeonAllData(all_data)
end

function ResDungeonModule:SetAlreadyReturnedMission(id_list)
  self._alreadyReturnPowerResDungeonList = id_list
end

function ResDungeonModule:GetTypeById(instance_id)
  local cfg_detail = Cfg.cfg_res_instance_detail[instance_id]
  if cfg_detail ~= nil then
    return cfg_detail.MainType
  else
    return -1
  end
end
