_class("N25IdolCollectionReddot", Object)
N25IdolCollectionReddot = N25IdolCollectionReddot

function N25IdolCollectionReddot:Constructor()
  self._idEndCG = 1
  self._idMemory = 2
  self._idAchieve = 3
  self._viewed = {
    [self._idEndCG] = {
      key = self:GetDBEndCGKey(),
      value = {}
    },
    [self._idMemory] = {
      key = self:GetDBMemoryKey(),
      value = {}
    },
    [self._idAchieve] = {
      key = self:GetDBAchieveKey(),
      value = {}
    }
  }
  self:PrivateLoadDB(self._idEndCG)
  self:PrivateLoadDB(self._idMemory)
  self:PrivateLoadDB(self._idAchieve)
  self._enableAchieveTitleReddot = false
  local campaignModule = self:GetModule(CampaignModule)
  local localProcess = campaignModule:GetCampaignLocalProcess(ECampaignType.CAMPAIGN_TYPE_N25)
  self._idolComponent = localProcess:GetComponent(ECampaignN25ComponentID.ECAMPAIGN_N25_IDOL)
  self:FlushUnlocked()
end

function N25IdolCollectionReddot:GetModule(gameModuleProto)
  return GameGlobal.GetModule(gameModuleProto)
end

function N25IdolCollectionReddot:GetIdolComponent()
  return self._idolComponent
end

function N25IdolCollectionReddot:GetDBEndCGKey()
  local key = "N25IdolCollectionReddot_EndCG_fk"
  local roleModule = self:GetModule(RoleModule)
  return roleModule:GetPstId() .. key
end

function N25IdolCollectionReddot:GetDBMemoryKey()
  local key = "N25IdolCollectionReddot_Memory_fk"
  local roleModule = self:GetModule(RoleModule)
  return roleModule:GetPstId() .. key
end

function N25IdolCollectionReddot:GetDBAchieveKey()
  local key = "N25IdolCollectionReddot_Achieve_fk"
  local roleModule = self:GetModule(RoleModule)
  return roleModule:GetPstId() .. key
end

function N25IdolCollectionReddot:PrivateLoadDB(sheetID)
  local viewed = self._viewed[sheetID]
  local content = LocalDB.GetString(viewed.key, "")
  local fnString = string.format("return {%s}", content)
  local fnTable = load(fnString)
  local dbData = fnTable()
  for k, v in pairs(dbData) do
    viewed.value[v] = v
  end
end

function N25IdolCollectionReddot:PrivateSaveDB(sheetID)
  local viewed = self._viewed[sheetID]
  local content = ""
  for k, v in pairs(viewed.value) do
    content = content .. string.format("%d, ", v)
  end
  LocalDB.SetString(viewed.key, content)
end

function N25IdolCollectionReddot:SaveDB()
  self:PrivateSaveDB(self._idEndCG)
  self:PrivateSaveDB(self._idMemory)
  self:PrivateSaveDB(self._idAchieve)
end

function N25IdolCollectionReddot:ClearDB()
  for k, v in pairs(self._viewed) do
    v.value = {}
  end
  self:PrivateSaveDB(self._idEndCG)
  self:PrivateSaveDB(self._idMemory)
  self:PrivateSaveDB(self._idAchieve)
end

function N25IdolCollectionReddot:ClearNew()
  local fnUnlock = {
    [self._idEndCG] = self.GetEndCGUnlocked,
    [self._idMemory] = self.GetMemoryUnlocked,
    [self._idAchieve] = self.GetAchieveUnlocked
  }
  for k, v in pairs(self._viewed) do
    local value = v.value
    local unlocked = fnUnlock[k](self)
    for k, v in pairs(unlocked) do
      value[k] = k
    end
  end
  self:PrivateSaveDB(self._idEndCG)
  self:PrivateSaveDB(self._idMemory)
  self:PrivateSaveDB(self._idAchieve)
end

function N25IdolCollectionReddot:AddViewed(sheetID, id, autoSaved)
  local viewed = self._viewed[sheetID]
  viewed.value[id] = id
  if autoSaved then
    self:PrivateSaveDB(sheetID)
  end
end

function N25IdolCollectionReddot:AddViewedEngCG(id, autoSaved)
  local unlocked = self:GetEndCGUnlocked()
  if unlocked[id] ~= nil then
    self:AddViewed(self._idEndCG, id, autoSaved)
  end
end

function N25IdolCollectionReddot:AddViewedMemory(id, autoSaved)
  self:AddViewed(self._idMemory, id, autoSaved)
end

function N25IdolCollectionReddot:AddViewedAchieve(id, autoSaved)
  self:AddViewed(self._idAchieve, id, autoSaved)
end

function N25IdolCollectionReddot:FlushUnlocked()
  local componentInfo = self._idolComponent:GetComponentInfo()
  local collectInfo = componentInfo.collect_info
  self._unlockedEnding = {}
  for k, v in pairs(collectInfo.ending_list) do
    self._unlockedEnding[v] = v
  end
  self._unlockedEvent = {}
  for k, v in pairs(collectInfo.agree_events) do
    self._unlockedEvent[v] = v
  end
  self._unlockedAchieve = {}
  for k, v in pairs(collectInfo.achieve_list) do
    self._unlockedAchieve[k] = v
  end
end

function N25IdolCollectionReddot:GetEndCGUnlocked()
  return self._unlockedEnding
end

function N25IdolCollectionReddot:GetMemoryUnlocked()
  return self._unlockedEvent
end

function N25IdolCollectionReddot:GetAchieveUnlocked()
  return self._unlockedAchieve
end

function N25IdolCollectionReddot:GetEndCGReddot()
  local allEnding = Cfg.cfg_component_idol_ending({})
  for k, v in pairs(allEnding) do
    if self:GetEndCGTitleReddot(k) then
      return true
    end
  end
  return false
end

function N25IdolCollectionReddot:GetMemoryReddot()
  local allEvents = Cfg.cfg_component_idol_event({})
  for k, v in pairs(allEvents) do
    if self:GetMemoryTitleReddot(k) then
      return true
    end
  end
  return false
end

function N25IdolCollectionReddot:GetAchieveReddot()
  local allAchieves = Cfg.cfg_component_idol_achieve({})
  for k, v in pairs(allAchieves) do
    if self:GetAchieveTitleReddot(k) then
      return true
    elseif self:GetAchieveRewardReddot(k) then
      return true
    end
  end
  return false
end

function N25IdolCollectionReddot:GetEndCGTitleReddot(id)
  local unlocked = self:GetEndCGUnlocked()
  if unlocked[id] == nil then
    return false
  end
  local viewed = self._viewed[self._idEndCG]
  return viewed.value[id] == nil
end

function N25IdolCollectionReddot:GetMemoryTitleReddot(id)
  local unlocked = self:GetMemoryUnlocked()
  if unlocked[id] == nil then
    return false
  end
  local viewed = self._viewed[self._idMemory]
  return viewed.value[id] == nil
end

function N25IdolCollectionReddot:GetAchieveTitleReddot(id)
  if not self._enableAchieveTitleReddot then
    return false
  end
  local unlocked = self:GetAchieveUnlocked()
  if unlocked[id] == nil then
    return false
  elseif unlocked[id] == IdolAchieveState.IdolAchieveState_Recved then
    return false
  end
  local viewed = self._viewed[self._idAchieve]
  return viewed.value[id] == nil
end

function N25IdolCollectionReddot:GetAchieveRewardReddot(id)
  local unlocked = self:GetAchieveUnlocked()
  if unlocked[id] == nil then
    return false
  end
  return unlocked[id] == IdolAchieveState.IdolAchieveState_CanRecv
end
