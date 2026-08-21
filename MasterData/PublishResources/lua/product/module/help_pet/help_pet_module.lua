_class("HelpPetModule", GameModule)
HelpPetModule = HelpPetModule

function HelpPetModule:Constructor()
  self.m_nHelpPetKey = 0
  self.m_supportInfo = CEventHelpPet_SupportInfoAsw:New()
  self.m_listPetType = {
    ElementType.ElementType_Blue,
    ElementType.ElementType_Red,
    ElementType.ElementType_Green,
    ElementType.ElementType_Yellow
  }
  self.m_mapVecHelpData = {}
  self.m_nCurFreshTeamID = 0
  self._lastRefreshTime = 0
  self:_InitHelpList()
end

function HelpPetModule:Dispose()
end

function HelpPetModule:Init()
end

function HelpPetModule:Update(deltaTimeMS)
end

function HelpPetModule:_Request_Packet(TT, packetRequest)
  local res = AsyncRequestRes:New()
  local reply = self:Call(TT, packetRequest)
  if reply.res ~= CallResultType.Normal then
    if reply.msg then
      res:SetResult(reply.msg.m_nResult)
    else
      res:SetResult(ErrorCode_HelpPet.E_Error_HelpPet_Fail)
    end
    return nil, res
  end
  res:SetSucc(true)
  return reply.msg, res
end

function HelpPetModule:RequestHelpPet_SupportInfo(TT)
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventHelpPet_SupportInfoReq)
  local replyMsg, res = self:_Request_Packet(TT, request)
  if replyMsg and ErrorCode_HelpPet.E_Error_HelpPet_Succ == replyMsg.m_nResult then
    self.m_supportInfo = replyMsg
  end
  return res
end

function HelpPetModule:RequestHelpPet_SupportSet(TT, nTemplateID, bAddSupport)
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventHelpPet_SupportSetReq)
  request.m_bAddSupport = bAddSupport or 1
  request.m_nTemplateID = nTemplateID
  local replyMsg, res = self:_Request_Packet(TT, request)
  if replyMsg and ErrorCode_HelpPet.E_Error_HelpPet_Succ == replyMsg.m_nResult then
    if bAddSupport then
      self.m_supportInfo.m_mapPetSupport[replyMsg.m_nPetType] = replyMsg.m_supportPetData
    else
      self.m_supportInfo.m_mapPetSupport[replyMsg.m_nPetType] = nil
    end
  end
  return res
end

function HelpPetModule:RequestHelpPet_HelpRefresh(TT, nPetType, nTeamID, match_type, component_id, mission_component_id)
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventHelpPet_HelpRefreshReq)
  request.m_nPetType = nPetType
  request.m_nTeamID = nTeamID
  local petType = math.floor(self.m_nHelpPetKey / 256)
  local nPetIndex = self.m_nHelpPetKey % 256
  local selectHelpPet = self:_FindtHelpPetData(petType, nPetIndex)
  if selectHelpPet then
    request.m_nSelectHelpPet = selectHelpPet.m_nPstID
  end
  if match_type ~= nil then
    request.m_from_battle_type = match_type
  end
  request.m_component_id = component_id
  request.m_mission_component_id = mission_component_id
  local replyMsg, res = self:_Request_Packet(TT, request)
  if replyMsg and ErrorCode_HelpPet.E_Error_HelpPet_Succ == replyMsg.m_nResult then
    for nRecvPetType, listHelpData in pairs(replyMsg.m_mapVecHelpData) do
      if nil == self.m_mapVecHelpData[nRecvPetType] then
        self.m_mapVecHelpData[nRecvPetType] = {}
      end
      self.m_mapVecHelpData[nRecvPetType] = listHelpData
      if selectHelpPet and nRecvPetType == petType then
        nPetIndex = #listHelpData
        self.m_nHelpPetKey = petType * 256 + nPetIndex
      end
    end
    self.m_nCurFreshTeamID = nTeamID
  end
  return res
end

function HelpPetModule:RequestHelpPet_HelpInitData(TT, nData)
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventHelpPet_InitData)
  request.m_nData = nData
  self:Push(request)
end

function HelpPetModule:RequestHelpPet_HelpList(TT, nTeamID)
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventHelpPet_HelpListReq)
  request.m_nTeamID = nTeamID
  self.m_nCurFreshTeamID = 0
  local replyMsg, res = self:_Request_Packet(TT, request)
  if replyMsg and ErrorCode_HelpPet.E_Error_HelpPet_Succ == replyMsg.m_nResult then
    self.m_nCurFreshTeamID = nTeamID
    for key, nPetType in pairs(self.m_listPetType) do
      self.m_mapVecHelpData[nPetType] = {}
      local listRecvPet = replyMsg.m_mapVecHelpData[nPetType]
      if listRecvPet and 0 < table.count(listRecvPet) then
        self.m_mapVecHelpData[nPetType] = listRecvPet
      end
    end
  end
  return res
end

function HelpPetModule:ComputePetSortData(nLevel, nAwake, nGrade, nRefineLevel, nEquipLevel)
  local nSortData = nGrade * 1000000 + nRefineLevel * 100000 + nEquipLevel * 10000 + nLevel
  return nSortData
end

function HelpPetModule:_FindtHelpPetData(nPetType, nPetIndex)
  local pFindHelpPetList = self.m_mapVecHelpData[nPetType]
  if nil == pFindHelpPetList then
    return nil
  end
  return pFindHelpPetList[nPetIndex]
end

function HelpPetModule:_FindtHelpPetDataByPstId(nPetType, pstId)
  local pFindHelpPetList = self.m_mapVecHelpData[nPetType]
  if nil == pFindHelpPetList then
    return nil
  end
  local data, index
  for i, value in ipairs(pFindHelpPetList) do
    if value.m_nPstID == pstId then
      data = value
      index = i
      break
    end
  end
  return data, index
end

function HelpPetModule:_InitHelpList()
  for key, value in pairs(self.m_listPetType) do
    self.m_mapVecHelpData[value] = {}
  end
  self.m_nCurFreshTeamID = 0
end

function HelpPetModule:UI_FindSupportPet(nPetType)
  local pFindSupportPet = self.m_supportInfo.m_mapPetSupport[nPetType]
  return pFindSupportPet
end

function HelpPetModule:UI_FindHelpPet(nPetType)
  local pFindHelpPetList = self.m_mapVecHelpData[nPetType]
  return pFindHelpPetList
end

function HelpPetModule:UI_EnumHelpPet(nPetType)
  local pFindHelpPetList = self.m_mapVecHelpData[nPetType]
  if nil == pFindHelpPetList then
    return nil
  end
  return self:UI_ReSort(pFindHelpPetList)
end

function HelpPetModule:UI_ReSort(pFindHelpPetList)
  local sortList = SortedArray:New(Algorithm.COMPARE_CUSTOM, function(dataA, dataB)
    if dataA.m_nSourceType ~= dataB.m_nSourceType then
      if EnumHelpSourceType.E_HelpSource_Default == dataA.m_nSourceType then
        return -1
      elseif EnumHelpSourceType.E_HelpSource_Default == dataB.m_nSourceType then
        return 1
      else
        return dataA.m_nSourceType - dataB.m_nSourceType
      end
    else
      local nSortDataA = self:ComputePetSortData(dataA.m_nLevel, dataA.m_nAwake, dataA.m_nGrade, dataA.m_nEquipRefineLevel, dataA.m_nEquipLevel)
      local nSortDataB = self:ComputePetSortData(dataB.m_nLevel, dataB.m_nAwake, dataB.m_nGrade, dataB.m_nEquipRefineLevel, dataB.m_nEquipLevel)
      return nSortDataA - nSortDataB
    end
  end)
  sortList:AllowDuplicate()
  for key, value in pairs(pFindHelpPetList) do
    sortList:Insert(value)
  end
  return sortList
end

function HelpPetModule:UI_SetSelectHelpPet(nPetType, nPetIndex)
  self.m_nHelpPetKey = 0
  local pFindHelpPet = self:_FindtHelpPetData(nPetType, nPetIndex)
  if nil == pFindHelpPet then
    return nil
  end
  self.m_nHelpPetKey = nPetType * 256 + nPetIndex
  return
end

function HelpPetModule:UI_SetSelectHelpPetPstId(nPetType, PstId)
  self.m_nHelpPetKey = 0
  local pFindHelpPet, index = self:_FindtHelpPetDataByPstId(nPetType, PstId)
  if nil == pFindHelpPet then
    return nil
  end
  self.m_nHelpPetKey = nPetType * 256 + index
  return
end

function HelpPetModule:UI_GetSelectConstructHelpPet()
  local data = self:UI_GetTeamMaxPet()
  local tempData = pet_data:New()
  tempData.template_id = data.m_nTemplateID
  tempData.current_skin = data.m_nSkinID
  local pet = Pet:New(tempData)
  tempData.grade = data.m_nGrade
  tempData.level = data.m_nLevel
  tempData.awakening = data.m_nAwake
  tempData.equip_lv = data.m_nEquipLevel
  tempData.equip_refine_lv = data.m_nEquipRefineLevel
  tempData.awake_lock = data.m_nAwakeLock
  pet:SetData(tempData)
  pet:CalAttr()
  return pet
end

function HelpPetModule:UI_GetTeamMaxMatchPet()
  local _module = self:GetModule(MissionModule)
  local petModule = self:GetModule(PetModule)
  local ctx = _module:TeamCtx()
  local _teams = ctx.teams
  local maxPet
  if _teams then
    local curTeamId = ctx:GetCurrTeamId()
    local team = _teams:Get(curTeamId)
    if team then
      local maxLevel = 0
      local list = {}
      for index, pstid in ipairs(team:GetPets()) do
        if index < 5 then
          local pet = petModule:GetPet(pstid)
          table.insert(list, pet)
        end
      end
      table.sort(list, function(a, b)
        if a:GetPetGrade() == b:GetPetGrade() then
          return a:GetPetLevel() > b:GetPetLevel()
        else
          return a:GetPetGrade() > b:GetPetGrade()
        end
      end)
      maxPet = list[1]
    end
  end
  return maxPet
end

function HelpPetModule:UI_GetTeamMaxPet()
  local maxPet = self:UI_GetTeamMaxMatchPet()
  local data = self:UI_GetSelectHelpPet(maxPet)
  return data
end

function HelpPetModule:UI_GetSelectHelpPet(maxTeamPet)
  local nPetType = math.floor(self.m_nHelpPetKey / 256)
  local nPetIndex = self.m_nHelpPetKey % 256
  local pFindHelpPet = self:_FindtHelpPetData(nPetType, nPetIndex)
  return self:ConvertDataByMaxPet(pFindHelpPet, maxTeamPet)
end

function HelpPetModule:ConvertDataByMaxPet(pFindHelpPet, maxTeamPet, ui)
  local bOriginal = true
  if bOriginal then
    return pFindHelpPet
  end
  local petDataReturn = DHelpPet_PetData:New()
  petDataReturn.m_nPlayerID = pFindHelpPet.m_nPlayerID
  petDataReturn.m_nTemplateID = pFindHelpPet.m_nTemplateID
  petDataReturn.m_nPstID = pFindHelpPet.m_nPstID
  petDataReturn.m_nSkinID = pFindHelpPet.m_nSkinID
  petDataReturn.m_nSourceType = pFindHelpPet.m_nSourceType
  petDataReturn.m_nAwakeLock = pFindHelpPet.m_nAwakeLock
  if not maxTeamPet then
    petDataReturn.m_nAwake = pFindHelpPet.m_nAwake
    petDataReturn.m_nGrade = pFindHelpPet.m_nGrade
    petDataReturn.m_nLevel = pFindHelpPet.m_nLevel
  else
    local maxPetGrade = maxTeamPet:GetPetGrade()
    petDataReturn.m_nAwake = pFindHelpPet.m_nAwake
    if maxPetGrade > pFindHelpPet.m_nGrade then
      petDataReturn.m_nGrade = pFindHelpPet.m_nGrade
      petDataReturn.m_nLevel = pFindHelpPet.m_nLevel
    elseif maxPetGrade == pFindHelpPet.m_nGrade then
      petDataReturn.m_nGrade = pFindHelpPet.m_nGrade
      local maxPetLevel = maxTeamPet._data.level
      if maxPetLevel < pFindHelpPet.m_nLevel then
        petDataReturn.m_nLevel = maxPetLevel
      else
        petDataReturn.m_nLevel = pFindHelpPet.m_nLevel
      end
    elseif maxPetGrade < pFindHelpPet.m_nGrade then
      petDataReturn.m_nGrade = maxTeamPet._data.grade
      petDataReturn.m_nLevel = maxTeamPet._data.level
    end
  end
  local nMaxEquipLevel = Cfg.cfg_global.help_pet_max_equip_level.IntValue
  if nMaxEquipLevel and 0 < nMaxEquipLevel then
    if nMaxEquipLevel <= pFindHelpPet.m_nEquipLevel then
      petDataReturn.m_nEquipLevel = nMaxEquipLevel
    else
      petDataReturn.m_nEquipLevel = pFindHelpPet.m_nEquipLevel
    end
  else
    petDataReturn.m_nEquipLevel = pFindHelpPet.m_nEquipLevel
  end
  return petDataReturn
end

function HelpPetModule:UI_GetHelpPetKey()
  return self.m_nHelpPetKey
end

function HelpPetModule:UI_ClearHelpPet()
  self.m_nHelpPetKey = 0
end

function HelpPetModule:UI_GetSupportInfo()
  return self.m_supportInfo
end

function HelpPetModule:UI_GetCurFreshTeamID()
  return self.m_nCurFreshTeamID
end

function HelpPetModule:UI_GetLastRefreshTime()
  return self._lastRefreshTime
end

function HelpPetModule:UI_SetLastRefreshTime(time)
  self._lastRefreshTime = time
end

function HelpPetModule:GetErrorMsg(nErrorCode)
  local vecErrorMsg = {
    [ErrorCode_QuestChat.E_Error_HelpPet_Fail] = StringTable.Get("str_help_pet_error_Fail"),
    [ErrorCode_QuestChat.E_Error_HelpPet_Succ] = StringTable.Get("str_help_pet_error_Succ"),
    [ErrorCode_QuestChat.E_Error_HelpPet_Sql] = StringTable.Get("str_help_pet_error_Sql"),
    [ErrorCode_QuestChat.E_Error_HelpPet_DB] = StringTable.Get("str_help_pet_error_DB"),
    [ErrorCode_QuestChat.E_Error_HelpPet_Pet] = StringTable.Get("str_help_pet_error_Pet"),
    [ErrorCode_QuestChat.E_Error_HelpPet_PetType] = StringTable.Get("str_help_pet_error_PetType"),
    [ErrorCode_QuestChat.E_Error_HelpPet_ModuleLock] = StringTable.Get("str_help_pet_error_ModuleLock"),
    [ErrorCode_QuestChat.E_Error_HelpPet_RefreshLimit] = StringTable.Get("str_chat_error_code_frequency_limit")
  }
  local stErrorMsg = vecErrorMsg[nErrorCode]
  if nil == stErrorMsg then
    return "Unknown ErrorCode"
  end
  return stErrorMsg
end
