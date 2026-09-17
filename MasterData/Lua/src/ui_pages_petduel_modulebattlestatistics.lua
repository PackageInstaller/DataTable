local this = class("moduleBattleStatistics", G_UIModuleBase)
local kiBoDuelTpl = L_GameTpl:getKiboDuelTpl()

function this.bind()
  return {
    statisticsActive = true,
    statisticsToggleIsOn = false,
    statisticsList = {
      moduleName = "pages/petDuel/cellTopStatistics"
    },
    statisticsSmallList = {
      moduleName = "pages/petDuel/cellTopStatisticsSmall"
    },
    tabList = {
      moduleName = "modulePages/tabList/moduleNewCommonTabList"
    }
  }
end

function this.methods()
  return {
    onClick_fold = function(self)
      self.bind.statisticsToggleIsOn = false
      self:setContentInfo(false)
    end,
    onClick_expend = function(self)
      self.bind.statisticsToggleIsOn = true
      self:setContentInfo(true)
    end
  }
end

function this:open()
  self.enemyPets = {}
  self.playerPets = {}
  self.statisticsData = {
    enemyData = {},
    playerData = {}
  }
  L_ShortCutManager:addListener(L_ShortCutConst.event.PetDuelStatistics, self.onPetDuelStatistics, self)
  self.restartKiBoDuelHandler = handler(self, self.restartKiBoDuel)
  C_KiboDuelSystemMgr:RegisterEvent(C_EKiboDuelEvent.RestartKiBoDuel, self.restartKiBoDuelHandler)
  self.onRefreshStatisticsHandler = handler(self, self.onRefreshStatistics)
  C_KiboDuelSystemMgr:RegisterEvent(C_EKiboDuelEvent.RefreshStatistics, self.onRefreshStatisticsHandler)
  local tabList = {
    L_Const.commonTag.INFO_DAMAGE,
    L_Const.commonTag.INFO_TAKEN,
    L_Const.commonTag.INFO_HEAL
  }
  self.modules.tabList:setData(tabList, handler(self, self.onSelectTabId))
  if not C_KiboDuelSystemMgr:IsInNestCoop() then
    self.petGuids = C_KiboDuelSystemMgr:GetPetGuids()
    self.duelId = L_PetDuelStore:getCurChallengeLevelId()
    local tpl = kiBoDuelTpl:getTplById(self.duelId)
    self.enemies = kiBoDuelTpl:getEnemy(tpl)
  end
  self.pets = {}
  self.timer = Timer.repeated(0.5, function()
    CS.UnityEngine.Profiling.Profiler.BeginSample("Timer:moduleBattleStatistics.update")
    self:update()
    CS.UnityEngine.Profiling.Profiler.EndSample()
  end, self)
  self.bind.statisticsToggleIsOn = C_KiboDuelSystemMgr:GetIsShowStatistics()
end

function this:show()
end

function this:close()
  L_ShortCutManager:removeListener(L_ShortCutConst.event.PetDuelStatistics, self.onPetDuelStatistics, self)
  C_KiboDuelSystemMgr:UnregisterEvent(C_EKiboDuelEvent.RestartKiBoDuel, self.restartKiBoDuelHandler)
  C_KiboDuelSystemMgr:UnregisterEvent(C_EKiboDuelEvent.RefreshStatistics, self.onRefreshStatisticsHandler)
  self:disposeTimer()
end

function this:disposeTimer()
  if self.timer ~= nil then
    Timer.remove(self.timer)
    self.timer = nil
  end
end

function this:refreshInfo()
  if not self.isBind then
    return
  end
  if C_KiboDuelSystemMgr:IsInNestCoop() then
    self:refreshNestInfo()
  else
    self:refreshStatisticsData()
  end
  local bind = self.bind
  self.isExpend = self.isExpend or bind.statisticsToggleIsOn
  CS.UnityEngine.Profiling.Profiler.BeginSample("statisticsList")
  local pets = self.pets
  if self.isExpend then
    local statisticsList = bind.statisticsList
    if #statisticsList == #pets then
      for i = 1, #statisticsList do
        statisticsList:change(i, pets[i])
      end
    else
      statisticsList:clear()
      statisticsList:insert_array(pets)
    end
  else
    local statisticsSmallList = bind.statisticsSmallList
    if #statisticsSmallList == #pets then
      for i = 1, #statisticsSmallList do
        statisticsSmallList:change(i, pets[i])
      end
    else
      statisticsSmallList:clear()
      statisticsSmallList:insert_array(pets)
    end
  end
  CS.UnityEngine.Profiling.Profiler.EndSample()
  if not self.tabId then
    self.tabId = L_Const.commonTag.INFO_DAMAGE
  end
  self.modules.tabList:setSelectTabId(self.tabId)
end

function this:onRefreshStatistics(e, v)
  self.refreshDirty = true
end

function this:refreshStatisticsData()
  local tabId = self.tabId
  local dataType = self:getDataType(tabId)
  self.statisticsData = C_KiboDuelSystemMgr:GetPetStatistics(dataType, 9999999, self.statisticsData)
  local playerMaxDamge, playerMaxDamgeTaken, playerMaxHealing = self:getMaxValues(self.statisticsData.playerData)
  local enemyMaxDamge, enemyMaxDamgeTaken, enemyMaxHealing = self:getMaxValues(self.statisticsData.enemyData)
  local maxDamge = playerMaxDamge + enemyMaxDamge
  local maxDamgeTaken = playerMaxDamgeTaken + enemyMaxDamgeTaken
  local maxHealing = playerMaxHealing + enemyMaxHealing
  local playerPets = {}
  self.playerPets = playerPets
  local playerData = self.statisticsData.playerData
  for i = 0, playerData.Count - 1 do
    local v = playerData[i]
    playerPets[v.guid] = v
  end
  local enemyPets = {}
  self.enemyPets = enemyPets
  local enemyData = self.statisticsData.enemyData
  for i = 0, enemyData.Count - 1 do
    local v = enemyData[i]
    table.insert(enemyPets, v)
  end
  local pets = {}
  self.pets = pets
  local petGuids = self.petGuids
  for i = 0, petGuids.Count - 1 do
    local v = petGuids[i]
    local item = {
      isPlayer = true,
      slotId = v.slotId,
      guid = v.guid,
      is_trial = v.is_trial or false,
      id = v.id,
      value = 0,
      tag = self.tabId
    }
    table.insert(pets, item)
    for _, pet in pairs(playerPets) do
      if pet.guid == item.guid then
        item.value = self:getValue(pet)
      end
    end
    if tabId == L_Const.commonTag.INFO_DAMAGE then
      item.maxValue = maxDamge
    elseif tabId == L_Const.commonTag.INFO_TAKEN then
      item.maxValue = maxDamgeTaken
    elseif tabId == L_Const.commonTag.INFO_HEAL then
      item.maxValue = maxHealing
    end
  end
  local selectedPets = {}
  for configId, _ in pairs(self.enemies) do
    local item = {
      isPlayer = false,
      is_trial = false,
      id = configId,
      value = 0,
      tag = tabId
    }
    table.insert(pets, item)
    for k, pet in pairs(enemyPets) do
      if not table.containsValue(selectedPets, k) and pet.petConfigId == configId then
        item.value = self:getValue(pet)
        item.guid = pet.guid
        table.insert(selectedPets, k)
      end
    end
    if tabId == L_Const.commonTag.INFO_DAMAGE then
      item.maxValue = maxDamge
    elseif tabId == L_Const.commonTag.INFO_TAKEN then
      item.maxValue = maxDamgeTaken
    elseif tabId == L_Const.commonTag.INFO_HEAL then
      item.maxValue = maxHealing
    end
  end
  table.sort(self.pets, function(a, b)
    return a.value > b.value
  end)
  for k, v in ipairs(self.pets) do
    v.index = k
  end
end

function this:getValue(pet)
  if self.tabId == L_Const.commonTag.INFO_DAMAGE then
    return pet.damgeValue
  elseif self.tabId == L_Const.commonTag.INFO_TAKEN then
    return pet.damgeTakenValue
  elseif self.tabId == L_Const.commonTag.INFO_HEAL then
    return pet.healingValue
  end
  return 0
end

function this:getMaxValues(data)
  local maxDamge, maxDamgeTaken, maxHealing = C_KiboDuelSystemMgr:GetMaxValues(data)
  return maxDamge, maxDamgeTaken, maxHealing
end

function this:getDataType(tabId)
  local dataType = C_ERecordValueType.Damage
  if tabId == L_Const.commonTag.INFO_DAMAGE then
    dataType = C_ERecordValueType.Damage
  elseif tabId == L_Const.commonTag.INFO_TAKEN then
    dataType = C_ERecordValueType.ReceiveDamage
  elseif tabId == L_Const.commonTag.INFO_HEAL then
    dataType = C_ERecordValueType.Heal
  end
  return dataType
end

function this:restartKiBoDuel(e, v)
  self.tabId = nil
  C_KiboDuelSystemMgr:SetIsShowStatistics(self.bind.statisticsToggleIsOn)
end

function this:onSelectTabId(tabId)
  if self.tabId == tabId then
    return
  end
  self.tabId = tabId
  self:refreshInfo()
end

function this:onPetDuelStatistics()
  self.bind.statisticsToggleIsOn = not self.bind.statisticsToggleIsOn
  self:setContentInfo(self.bind.statisticsToggleIsOn)
end

function this:setContentInfo(isOn)
  self.isExpend = isOn
  if isOn then
    self.tabId = self.tabId or L_Const.commonTag.INFO_DAMAGE
    self.bind.statisticsList:clear()
    self:refreshInfo()
  else
    self.bind.statisticsSmallList:clear()
    self:refreshInfo()
  end
  self.refreshDirty = false
end

function this:showStatistics(isShow)
  self.bind.statisticsActive = isShow
end

function this:update()
  if self.refreshDirty then
    self.refreshDirty = false
    self:refreshInfo()
  end
end

function this:refreshNestInfo()
  self.pets = {}
  if not self.tabId then
    self.tabId = L_Const.commonTag.INFO_DAMAGE
  end
  local tabId = self.tabId
  local dataType = self:getDataType(tabId)
  local nestData = C_KiboDuelSystemMgr:GetNestPetStatistics(dataType)
  for i = 0, nestData.Count - 1 do
    local data = nestData[i]
    local item = {
      isNest = true,
      guid = data.guid,
      is_trial = false,
      petConfigId = data.petConfigId,
      tag = self.tabId,
      value = self:getValue(data),
      special = data.special,
      nestPos = data.nestPos
    }
    if tabId == L_Const.commonTag.INFO_DAMAGE then
      item.maxValue = data.maxDamge
    elseif tabId == L_Const.commonTag.INFO_TAKEN then
      item.maxValue = data.maxDamgeTaken
    elseif tabId == L_Const.commonTag.INFO_HEAL then
      item.maxValue = data.maxHealing
    end
    table.insert(self.pets, item)
  end
end

return this
