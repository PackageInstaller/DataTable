_class("UIActivityN33DateData", Object)
UIActivityN33DateData = UIActivityN33DateData

function UIActivityN33DateData:Constructor(campaign)
  self._campaign = campaign
  self._comp = self._campaign:GetComponent(ECampaignN33ComponentID.ECAMPAIGN_N33_SIMULATION_OPERATION)
  self._compInfo = self._campaign:GetComponentInfo(ECampaignN33ComponentID.ECAMPAIGN_N33_SIMULATION_OPERATION)
end

function UIActivityN33DateData:GetComponent()
  return self._comp
end

function UIActivityN33DateData:GetDatePetList()
  local map = {}
  local cfg = Cfg.cfg_component_simulation_operation_story({})
  for _, v in pairs(cfg) do
    if map[v.PetId] then
      table.insert(map[v.PetId], v)
    else
      map[v.PetId] = {}
      table.insert(map[v.PetId], v)
    end
  end
  return map
end

function UIActivityN33DateData:GetDateManualList()
  local map = self:GetDatePetList()
  local list = {}
  local unReadList = {}
  local unLockList = {}
  local allDoneList = {}
  local lockedList = {}
  for _, cfgs in pairs(map) do
    local hasRed = false
    local allOver = true
    local isOneOver = false
    for i, v in pairs(cfgs) do
      if 2 < i then
        break
      end
      local isOver = self:CheckStoryConditionIsOver(v.ID)
      local isRead = self:CheckStoryIsRead(v.ID)
      isOneOver = isOneOver or isOver
      if isOver then
        if not isRead then
          hasRed = true
          allOver = false
        end
      else
        allOver = false
      end
    end
    if allOver then
      table.insert(allDoneList, cfgs)
    elseif not isOneOver then
      table.insert(lockedList, cfgs)
    elseif hasRed then
      table.insert(unReadList, cfgs)
    else
      table.insert(unLockList, cfgs)
    end
  end
  table.sort(unReadList, function(a, b)
    return a[1].ID < b[1].ID
  end)
  table.sort(unLockList, function(a, b)
    return a[1].ID < b[1].ID
  end)
  table.sort(allDoneList, function(a, b)
    return a[1].ID < b[1].ID
  end)
  table.sort(lockedList, function(a, b)
    return a[1].ID < b[1].ID
  end)
  for _, v in pairs(unReadList) do
    table.insert(list, v)
  end
  for _, v in pairs(unLockList) do
    table.insert(list, v)
  end
  for _, v in pairs(allDoneList) do
    table.insert(list, v)
  end
  for _, v in pairs(lockedList) do
    table.insert(list, v)
  end
  return list
end

function UIActivityN33DateData:GetMapShowPetList()
  local res = {}
  local cfgs = Cfg.cfg_component_simulation_operation_story({})
  for _, cfg in pairs(cfgs) do
    local isContain = table.icontains(self._compInfo.story_list, cfg.ID)
    if not isContain then
      if cfg.PreStory then
        local isRead = false
        for i, v in pairs(cfg.PreStory) do
          isRead = self:CheckStoryIsRead(v) or isRead
        end
        if isRead then
          table.insert(res, cfg)
        end
      else
        local isOver = self:CheckStoryConditionIsOver(cfg.ID)
        if isOver then
          table.insert(res, cfg)
        end
      end
    end
  end
  return res
end

function UIActivityN33DateData:CheckStoryIsRead(storyId)
  return table.icontains(self._compInfo.story_list, storyId)
end

function UIActivityN33DateData:CheckBuildGetLevel(buildId, level)
  local isGetTargetLevel = level <= self._compInfo.arch_infos[buildId].level
  return isGetTargetLevel
end

function UIActivityN33DateData:CheckStoryConditionIsOver(storyId)
  local cfg = Cfg.cfg_component_simulation_operation_story[storyId]
  local buildConditions = cfg.PreCondition
  local storyConditions = cfg.PreStory
  local isStoryOver = true
  if storyConditions then
    for _, v in pairs(storyConditions) do
      local isInvited = table.icontains(self._compInfo.story_list, v)
      if not isInvited then
        isStoryOver = false
        break
      end
    end
  end
  local isBuildOver = true
  if buildConditions then
    for _, v in pairs(buildConditions) do
      local id = v[1]
      local needLevel = v[2]
      if not self:CheckBuildGetLevel(id, needLevel) then
        isBuildOver = false
        break
      end
    end
  end
  return isStoryOver and isBuildOver
end

function UIActivityN33DateData:GetArchInfos()
  return self._compInfo.arch_infos
end

function UIActivityN33DateData:OneSecondUpdate_GetArchInfos(TT, callFun)
  local res = AsyncRequestRes:New()
  local ret, archInfos = self._comp:HandleGetArchInfos(TT, res)
  if res:GetSucc() and callFun then
    callFun()
  end
end

function UIActivityN33DateData:OneSecondUpdate_PickUpCoin(TT, arch_id, callFun)
  local res = AsyncRequestRes:New()
  local ret = self._comp:HandlePickUpCoin(TT, res, arch_id)
  if res:GetSucc() and callFun then
    callFun()
  end
end

function UIActivityN33DateData:OneSecondUpdate_UpgradeArch(TT, arch_id, callFun)
  local res = AsyncRequestRes:New()
  local ret, rewards = self._comp:HandleUpgradeArch(TT, res, arch_id)
  local sortReward = self:SortReward(rewards)
  if res:GetSucc() and callFun then
    callFun(sortReward)
  end
end

function UIActivityN33DateData:CheckSimulationOperationIsOver()
  local closeTime = self._comp.m_component_info.m_close_time
  local svrTimeModule = GameGlobal.GetModule(SvrTimeModule)
  local curTime = math.floor(svrTimeModule:GetServerTime() * 0.001)
  if closeTime < curTime then
    return true
  else
    return false
  end
end

function UIActivityN33DateData:GetIsPlayFinalStory()
  local b = self._compInfo.final_story
  if b == 0 or b == false or b == nil then
    return false
  end
  return true
end

function UIActivityN33DateData:SortReward(data)
  local newList = {}
  if not data then
    return newList
  end
  for key, v in pairs(data) do
    local id = v[1]
    if id == RoleAssetID.RoleAssetSimulationOperationCoin then
      table.insert(newList, v)
    end
  end
  for key, v in pairs(data) do
    local id = v[1]
    if id ~= RoleAssetID.RoleAssetSimulationOperationCoin then
      table.insert(newList, v)
    end
  end
  return newList
end
