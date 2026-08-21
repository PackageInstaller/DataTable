_class("UIBuildComponentManager", Object)
UIBuildComponentManager = UIBuildComponentManager

function UIBuildComponentManager:Constructor(buildComponent)
  self._buildComponent = buildComponent
  self._buildComponentInfo = buildComponent:GetComponentInfo()
  local componentCfgId = self._buildComponent:GetComponentCfgId()
  self._buildItemData = UIBuildComponentBuildItemData:New(componentCfgId)
  self._picnicItemData = UIBuildComponentPicnicData:New(componentCfgId)
  self._buildingList = self:_InitBuildingList()
end

function UIBuildComponentManager:_InitBuildingList()
  local tb_out = self._buildItemData:GetBuildItemIdList()
  table.sort(tb_out, function(a, b)
    local data_a = self:GetBuildCurStatusData(a)
    local data_b = self:GetBuildCurStatusData(b)
    local layer_a = self._buildItemData:GetLayer(data_a)
    local layer_b = self._buildItemData:GetLayer(data_b)
    if layer_a ~= layer_b then
      return layer_a < layer_b
    end
    return a < b
  end)
  return tb_out
end

function UIBuildComponentManager:GetBuildCurStatus(buildItemId)
  local buildItemInfos = self._buildComponentInfo.build_item_infos
  local buildingInfo = buildItemInfos[buildItemId]
  if buildingInfo then
    local statusList = self._buildItemData:GetBuildItemStatusList(buildItemId)
    for i = #statusList, 1, -1 do
      if buildingInfo.mask & statusList[i] > 0 then
        return statusList[i]
      end
    end
  end
  return 0
end

function UIBuildComponentManager:GetBuildCurStatusData(buildItemId)
  local status = self:GetBuildCurStatus(buildItemId)
  return self._buildItemData:GetBuildItemData(buildItemId, status)
end

function UIBuildComponentManager:GetBuildNextStatus(buildItemId, status)
  local statusList = self._buildItemData:GetBuildItemStatusList(buildItemId)
  local cur = table.ikey(statusList, status)
  if cur and cur + 1 <= #statusList then
    return statusList[cur + 1]
  end
end

function UIBuildComponentManager:CheckBuildStatusComplete(buildItemId, targetStatus)
  local status = self:GetBuildCurStatus(buildItemId)
  return targetStatus <= status
end

function UIBuildComponentManager:CheckNextStatusComplete(buildItemId, status)
  local nextStatus = self:GetBuildNextStatus(buildItemId, status)
  return not nextStatus or self:CheckBuildStatusComplete(buildItemId, nextStatus)
end

function UIBuildComponentManager:CheckBuildStatusUnlock(buildItemId, status)
  local id, st = self._buildItemData:GetNeedBuildItemIdAndStatus(buildItemId, status)
  if id == 0 then
    return true
  end
  if st ~= UIBuildComponentBuildStatus.Init then
    return self:CheckBuildStatusComplete(id, st)
  else
    return self:CheckBuildStatusUnlock(id, st)
  end
end

function UIBuildComponentManager:IsNextStatusUnlock(buildItemId)
  local status = self:GetBuildCurStatus(buildItemId)
  local nextStatus = self:GetBuildNextStatus(buildItemId, status)
  if not nextStatus then
    Log.debug("UIBuildComponentManager:IsNextStatusUnlock() nextStatus = nil")
    return nil
  end
  return self:CheckBuildStatusUnlock(buildItemId, nextStatus)
end

function UIBuildComponentManager:HaveCanBuilding(itemCount)
  for _, v in pairs(self._buildingList) do
    local data = self:GetBuildCurStatus(v)
    if not self:IsAllStatusComplete(v) and self:IsNextStatusUnlock(v) then
      local cost = self:GetCostCount(data) or 0
      if itemCount >= cost then
        return true
      end
    end
  end
  return false
end

function UIBuildComponentManager:IsAllStatusComplete(buildItemId)
  local status = self:GetBuildCurStatus(buildItemId)
  local list = self._buildItemData:GetBuildItemStatusList(buildItemId)
  return status == list[#list]
end

function UIBuildComponentManager:IsAllBuildingComplete()
  for _, v in ipairs(self._buildingList) do
    if not self:IsAllStatusComplete(v) then
      return false
    end
  end
  return true
end

function UIBuildComponentManager:GetBuildRewardList()
  local tb_in = self._buildItemData:GetBuildItemDataMap()
  local tb_out = {}
  for buildItemId, statusMap in pairs(tb_in) do
    for status, cfg in pairs(statusMap) do
      local reward = self:GetBuildReward(buildItemId, status)
      if reward and 0 < #reward then
        table.insert(tb_out, {
          buildItemId = buildItemId,
          status = status,
          name = self:GetName(buildItemId),
          state = self:CheckBuildStatusComplete(buildItemId, status) and 2 or 1,
          reward = reward
        })
      end
    end
  end
  table.sort(tb_out, function(a, b)
    if a.state == b.state then
      return a.buildItemId == b.buildItemId and a.status < b.status or a.buildItemId < b.buildItemId
    else
      return a.state < b.state
    end
  end)
  return tb_out
end

function UIBuildComponentManager:CalcBuildUnlockStep(buildItemId, status)
  local status = self:GetBuildNextStatus(buildItemId, status)
  local step = 1
  while not self:CheckBuildStatusUnlock(buildItemId, status) do
    if status ~= UIBuildComponentBuildStatus.Init then
      step = step + 1
    end
    buildItemId, status = self._buildItemData:GetNeedBuildItemIdAndStatus(buildItemId, status)
  end
  return step
end

function UIBuildComponentManager:CalcBuildUnlockProgress()
  local tb_in = self._buildItemData:GetBuildItemDataMap()
  local all = 0
  local unlock = 0
  for buildItemId, statusMap in pairs(tb_in) do
    for status, cfg in pairs(statusMap) do
      if status ~= UIBuildComponentBuildStatus.Init then
        all = all + 1
        if self:CheckBuildStatusComplete(buildItemId, status) then
          unlock = unlock + 1
        end
      end
    end
  end
  return unlock, all
end

function UIBuildComponentManager:CheckCanPicnic(buildItemId)
  local complete = self:CheckPicnicStatusComplete(buildItemId)
  local noStory = not self:CheckPicnicHaveStory()
  local lockTime = self:CheckPicnicLockTime(buildItemId)
  local nextCfg = self:CheckPicnicHaveNextCfg()
  return complete and noStory and lockTime and nextCfg
end

function UIBuildComponentManager:CheckPicnicStatusComplete(buildItemId)
  return self:CheckBuildStatusComplete(buildItemId, UIBuildComponentBuildStatus.Picnic)
end

function UIBuildComponentManager:CheckPicnicStoryUnlock(seq)
  local cur = self:GetPicnicCurSeq()
  return seq <= cur
end

function UIBuildComponentManager:CheckPicnicHaveStory()
  return self._buildComponentInfo.m_picnic_info.m_have_story
end

function UIBuildComponentManager:CheckPicnicLockTime(buildItemId)
  local svrTimeModule = GameGlobal.GetModule(SvrTimeModule)
  local curTime = math.floor(svrTimeModule:GetServerTime() * 0.001)
  local nextFood = self._buildComponentInfo.m_picnic_info.m_next_food[buildItemId] or 0
  return curTime >= nextFood
end

function UIBuildComponentManager:CheckPicnicHaveNextCfg()
  local seq = self:GetPicnicCurSeq() + 1
  local cfg = self:GetPicnicData(seq)
  return cfg ~= nil
end

function UIBuildComponentManager:GetPicnicCurSeq()
  return self._buildComponentInfo.m_picnic_info.m_times
end

function UIBuildComponentManager:GetUnPlayStoryList()
  local tb_out = {}
  for buildItemId, buildingInfo in pairs(self._buildComponentInfo.build_item_infos) do
    local maskList = self._buildItemData:GetBuildItemStatusList(buildItemId)
    for i = 2, #maskList do
      local v1, v2 = maskList[i], maskList[i - 1]
      local mask = buildingInfo.mask
      local storyMask = buildingInfo.story_mask
      if 0 < mask & v1 and storyMask & v1 == 0 then
        local data = self._buildItemData:GetBuildItemData(buildItemId, v2)
        local storyType = self._buildItemData:GetStoryType(data)
        local storyId = self._buildItemData:GetStoryId(data)
        if storyId and 0 < storyId then
          table.insert(tb_out, {
            storyType,
            storyId,
            v2,
            buildItemId
          })
        end
      end
    end
  end
  return tb_out
end

function UIBuildComponentManager:GetCanReviewStory()
  local tb_out = {}
  for _, buildItemId in pairs(self._buildingList) do
    local status = self:GetBuildCurStatus(buildItemId)
    local maskList = self._buildItemData:GetBuildItemStatusList(buildItemId)
    for _, v in ipairs(maskList) do
      if v == status then
        break
      end
      local data = self._buildItemData:GetBuildItemData(buildItemId, v)
      local id = self._buildItemData:GetStoryReviewId(data)
      if id and 0 < id then
        table.insert(tb_out, id)
      end
    end
  end
  table.sort(tb_out, function(a, b)
    return a < b
  end)
  return tb_out
end

function UIBuildComponentManager:GetBuildDataStoryReviewIdMap()
  return self._buildItemData:GetBuildDataStoryReviewIdMap()
end

function UIBuildComponentManager:GetPicnicDataStoryReviewIdMap()
  return self._picnicItemData:GetPicnicDataStoryReviewIdMap()
end

function UIBuildComponentManager:IsFirstEnterBuilding()
  local key = self:GetFirstEnterBuildingKey()
  local value = UnityEngine.PlayerPrefs.GetInt(key, 0)
  return value == 0
end

function UIBuildComponentManager:EnterBuilding()
  local key = self:GetFirstEnterBuildingKey()
  UnityEngine.PlayerPrefs.SetInt(key, 1)
end

function UIBuildComponentManager:GetFirstEnterBuildingKey()
  local roleModule = GameGlobal.GetModule(RoleModule)
  local pstId = roleModule:GetPstId()
  local componentCfgId = self._buildComponent:GetComponentCfgId()
  local key = "UIBuildComponentManager_GetFirstEnterBuildingKey_" .. componentCfgId .. "_" .. pstId
  return key
end

function UIBuildComponentManager:GetBuildItemIdList()
  return self._buildingList
end

function UIBuildComponentManager:GetBuildItemIdList_Picnic()
  return self._buildItemData:GetBuildItemIdList_Picnic()
end

function UIBuildComponentManager:GetName(buildItemId)
  local data = self:GetBuildCurStatusData(buildItemId)
  return self._buildItemData:GetName(data)
end

function UIBuildComponentManager:GetStatusName(buildItemId)
  local data = self:GetBuildCurStatusData(buildItemId)
  return self._buildItemData:GetStatusName(data)
end

function UIBuildComponentManager:GetIcon(buildItemId)
  local data = self:GetBuildCurStatusData(buildItemId)
  return self._buildItemData:GetIcon(data)
end

function UIBuildComponentManager:GetSpine(buildItemId)
  local data = self:GetBuildCurStatusData(buildItemId)
  return self._buildItemData:GetSpine(data)
end

function UIBuildComponentManager:GetDes(buildItemId)
  local data = self:GetBuildCurStatusData(buildItemId)
  return self._buildItemData:GetDes(data)
end

function UIBuildComponentManager:GetCostItemId()
  return self._buildItemData:GetBuildDataItemId()
end

function UIBuildComponentManager:GetCostCount(buildItemId)
  local status = self:GetBuildCurStatus(buildItemId)
  local nextStatus = self:GetBuildNextStatus(buildItemId, status)
  local data = self._buildItemData:GetBuildItemData(buildItemId, nextStatus)
  return data and self._buildItemData:GetCostCount(data)
end

function UIBuildComponentManager:GetBuildReward(buildItemId, status)
  local data = self._buildItemData:GetBuildItemData(buildItemId, status)
  return data and self._buildItemData:GetBuildReward(data)
end

function UIBuildComponentManager:GetBuildStoryId(buildItemId, status)
  local data = self._buildItemData:GetBuildItemData(buildItemId, status)
  return data and self._buildItemData:GetStoryId(data)
end

function UIBuildComponentManager:GetCompleteStoryId(buildItemId)
  local data = self:GetBuildCurStatusData(buildItemId)
  return data and self._buildItemData:GetStoryId(data) or 0
end

function UIBuildComponentManager:GetCompleteStoryType(buildItemId)
  local data = self:GetBuildCurStatusData(buildItemId)
  return data and self._buildItemData:GetStoryType(data) or 0
end

function UIBuildComponentManager:GetWidgetDesPos(buildItemId)
  local data = self:GetBuildCurStatusData(buildItemId)
  return data and self._buildItemData:GetWidgetDesPos(data) or Vector2(0, 0)
end

function UIBuildComponentManager:GetWidgetPos(buildItemId)
  local data = self:GetBuildCurStatusData(buildItemId)
  return data and self._buildItemData:GetWidgetPos(data) or Vector2(0, 0)
end

function UIBuildComponentManager:GetIconPos(buildItemId)
  local data = self:GetBuildCurStatusData(buildItemId)
  return data and self._buildItemData:GetIconPos(data) or Vector2(0, 0)
end

function UIBuildComponentManager:GetIconWidth(buildItemId)
  local data = self:GetBuildCurStatusData(buildItemId)
  return data and self._buildItemData:GetIconWidth(data) or 0
end

function UIBuildComponentManager:GetIconHeight(buildItemId)
  local data = self:GetBuildCurStatusData(buildItemId)
  return data and self._buildItemData:GetIconHeight(data) or 0
end

function UIBuildComponentManager:GetIconRotate(buildItemId)
  local data = self:GetBuildCurStatusData(buildItemId)
  return data and self._buildItemData:GetIconRotate(data) or 0
end

function UIBuildComponentManager:GetTriggerPos(buildItemId)
  local data = self:GetBuildCurStatusData(buildItemId)
  return data and self._buildItemData:GetTriggerPos(data) or Vector2(0, 0)
end

function UIBuildComponentManager:GetTriggerWidth(buildItemId)
  local data = self:GetBuildCurStatusData(buildItemId)
  return data and self._buildItemData:GetTriggerWidth(data) or 0
end

function UIBuildComponentManager:GetTriggerHeight(buildItemId)
  local data = self:GetBuildCurStatusData(buildItemId)
  return data and self._buildItemData:GetTriggerHeight(data) or 0
end

function UIBuildComponentManager:GetTriggerRotate(buildItemId)
  local data = self:GetBuildCurStatusData(buildItemId)
  return data and self._buildItemData:GetTriggerRotate(data) or 0
end

function UIBuildComponentManager:GetEffectAreaPos(buildItemId)
  local data = self:GetBuildCurStatusData(buildItemId)
  return data and self._buildItemData:GetEffectAreaPos(data) or Vector2(0, 0)
end

function UIBuildComponentManager:GetEffectAreaScale(buildItemId)
  local data = self:GetBuildCurStatusData(buildItemId)
  return data and self._buildItemData:GetEffectAreaScale(data) or 1
end

function UIBuildComponentManager:GetLayer(buildItemId)
  local data = self:GetBuildCurStatusData(buildItemId)
  return data and self._buildItemData:GetLayer(data) or 0
end

function UIBuildComponentManager:IsShow(buildItemId)
  local data = self:GetBuildCurStatusData(buildItemId)
  return data and self._buildItemData:IsShow(data) or false
end

function UIBuildComponentManager:GetPicnicData(seq)
  return self._picnicItemData:GetPicnicData(seq)
end

function UIBuildComponentManager:GetPicnicFixedPetIdList(seq, count)
  return self._picnicItemData:GetPicnicFixedPetIdList(seq, count)
end

function UIBuildComponentManager:GetPicnicPet(seq)
  return self._picnicItemData:GetPicnicPet(seq)
end

function UIBuildComponentManager:GetPicnicRewardList(seq)
  return self._picnicItemData:GetPicnicRewardList(seq)
end

function UIBuildComponentManager:GetPicnicStory(seq)
  return self._picnicItemData:GetPicnicStory(seq)
end
