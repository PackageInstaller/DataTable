local GUIDE_CHECK_TYPE = {
  GCT_ITEM_COUNT_EQUAL_OR_GREATER = 1,
  GCT_MODULE_UNLOCK = 2,
  GCT_MISSION_PASS = 3,
  GCT_AIRCRAFT_ROOM_BUILD = 4,
  GCT_HOMELAND_FREE_BUIND = 5,
  GCT_WECHAT_TALKED = 6,
  GCT_HAS_PET = 7,
  GUIDE_CHECK_TYPE_END
}
_enum("GUIDE_CHECK_TYPE", GUIDE_CHECK_TYPE)
_class("GuideCheckParam", Object)

function GuideCheckParam:Constructor()
  self.CheckType = 0
  self.CheckParam1 = 0
  self.CheckParam2 = 0
  self.CheckParam3 = 0
  self.CheckParam4 = 0
end

_class("GuideCheck", Object)

function GuideCheck:Constructor(guideModule)
  self._guideModule = guideModule
end

function GuideCheck:CheckGuideStartCondition(guideID)
  local check_config = Cfg.cfg_guide_check[guideID]
  if check_config == nil then
    return true
  end
  local paramList = self:_Config2CheckParam(check_config.CheckStartCondition)
  for i = 1, paramList:Size() do
    local param = paramList:GetAt(i)
    if self:_Check(param) == false then
      return false
    end
  end
  return true
end

function GuideCheck:_Check(param)
  if param.CheckType == GUIDE_CHECK_TYPE.GCT_ITEM_COUNT_EQUAL_OR_GREATER then
    return self:_CheckItemCountEqualOrGreater(param)
  elseif param.CheckType == GUIDE_CHECK_TYPE.GCT_MODULE_UNLOCK then
    return self:_CheckModuleUnlock(param)
  elseif param.CheckType == GUIDE_CHECK_TYPE.GCT_MISSION_PASS then
    return self:_ChecMissionPassed(param)
  elseif param.CheckType == GUIDE_CHECK_TYPE.GCT_AIRCRAFT_ROOM_BUILD then
    return self:_ChecAircraftRoom(param)
  elseif param.CheckType == GUIDE_CHECK_TYPE.GCT_HOMELAND_FREE_BUIND then
    return self:_ChecHomelandFreeBuild(param)
  elseif param.CheckType == GUIDE_CHECK_TYPE.GCT_WECHAT_TALKED then
    return self:_CheckWeChatTalked(param)
  elseif param.CheckType == GUIDE_CHECK_TYPE.GCT_HAS_PET then
    return self:_CheckHasPet(param)
  else
    return false
  end
end

function GuideCheck:_Config2CheckParam(CheckStartCondition)
  local paramList = ArrayList:New()
  if CheckStartCondition == nil then
    return paramList
  end
  for _, condition in ipairs(CheckStartCondition) do
    local content = string.split(condition, ",")
    local param = GuideCheckParam:New()
    param.CheckType = tonumber(content[1])
    if content[2] ~= nil then
      param.CheckParam1 = tonumber(content[2])
    end
    if content[3] ~= nil then
      param.CheckParam2 = tonumber(content[3])
    end
    if content[4] ~= nil then
      param.CheckParam3 = tonumber(content[4])
    end
    if content[5] ~= nil then
      param.CheckParam4 = tonumber(content[5])
    end
    paramList:PushBack(param)
  end
  return paramList
end

function GuideCheck:_CheckItemCountEqualOrGreater(param)
  local itemModule = GameGlobal.GetModule(ItemModule)
  local itemCount = itemModule:GetItemCount(param.CheckParam1)
  if itemCount >= param.CheckParam2 then
    return true
  else
    return false
  end
end

function GuideCheck:_CheckModuleUnlock(param)
  local roleModule = GameGlobal.GetModule(RoleModule)
  local bUnlock = roleModule:CheckModuleUnlock(param.CheckParam1)
  if bUnlock then
    return true
  else
    return false
  end
end

function GuideCheck:_ChecMissionPassed(param)
  local missionModule = GameGlobal.GetModule(MissionModule)
  local bpassed = missionModule:IsPassMissionID(param.CheckParam1)
  if bpassed then
    return true
  else
    return false
  end
end

function GuideCheck:_ChecAircraftRoom(param)
  local airModule = GameGlobal.GetModule(AircraftModule)
  local spaceid = param.CheckParam1
  local roomid = param.CheckParam2
  local room = airModule:GetRoom(param.CheckParam1)
  if room == nil then
    return false
  end
  if room:RoomId() == roomid then
    return true
  else
    return false
  end
end

function GuideCheck:_ChecHomelandFreeBuild(param)
  local itemModule = GameGlobal.GetModule(ItemModule)
  local itemCount = itemModule:GetItemCount(param.CheckParam1)
  if itemCount < param.CheckParam2 then
    return false
  end
  local homelandModule = GameGlobal.GetUIModule(HomelandModule)
  local homelandClient = homelandModule:GetClient()
  local buildManager = homelandClient:BuildManager()
  local unPutCount = buildManager:GetBuildCount(param.CheckParam1)
  return unPutCount >= param.CheckParam2
end

function GuideCheck:_CheckWeChatTalked(param)
  local speakerId = param.CheckParam1
  local talkId = param.CheckParam2
  local questChatModule = GameGlobal.GetModule(QuestChatModule)
  local weChatProxy = questChatModule:GetWeChatProxy()
  local talks = weChatProxy:GetTalks(speakerId)
  if 0 < #talks then
    for _, value in pairs(talks) do
      if value.talkId == talkId then
        return false
      end
    end
  end
  return true
end

function GuideCheck:_CheckHasPet(param)
  local petModule = GameGlobal.GetModule(PetModule)
  return petModule:HasPet(param.CheckParam1)
end
