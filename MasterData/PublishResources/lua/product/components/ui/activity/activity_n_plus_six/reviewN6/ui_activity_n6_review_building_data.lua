_class("UIActivityN6ReviewBuildingStatusData", Object)
UIActivityN6ReviewBuildingStatusData = UIActivityN6ReviewBuildingStatusData

function UIActivityN6ReviewBuildingStatusData:Constructor(cfg, localProcess)
  if not cfg then
    return
  end
  self._localProcess = localProcess
  self._status = cfg.BuildStatus
  self._condition = UIActivityN6ReviewBuildingCondition:New(cfg, self._localProcess)
  self._cost = cfg.BuildCost
  self._storyId = cfg.StoryId
  self._storyType = cfg.StoryType
  self._storyReviewId = cfg.StoryReviewId
  self._statusName = ""
  if cfg.StatusName then
    self._statusName = StringTable.Get(cfg.StatusName)
  end
  self._des = ""
  if cfg.Des then
    self._des = StringTable.Get(cfg.Des)
  end
  self._icon = ""
  if cfg.Icon then
    self._icon = cfg.Icon
  end
  self._name = StringTable.Get(cfg.Name)
  self._isShow = cfg.IsShow == 1
  local widgetPos = cfg.WidgetPos
  self._widgetPos = Vector2(widgetPos[1], widgetPos[2])
  local iconConfig = cfg.IconConfig
  self._iconPos = Vector2(iconConfig[1], iconConfig[2])
  self._iconWidth = iconConfig[3]
  self._iconHeight = iconConfig[4]
  self._iconRotate = iconConfig[5]
  local triggerArea = cfg.TriggerArea
  self._triggerPos = Vector2(triggerArea[1], triggerArea[2])
  self._triggerWidth = triggerArea[3]
  self._triggerHeight = triggerArea[4]
  self._triggerRotate = triggerArea[5]
  local widgetDesPos = cfg.WidgetDesPos
  self._widgetDesPos = Vector2(widgetDesPos[1], widgetDesPos[2])
  self._layer = cfg.Layer
  self._tipsIcon = cfg.TipsIcon
end

function UIActivityN6ReviewBuildingStatusData:GetWidgetDesPos()
  return self._widgetDesPos
end

function UIActivityN6ReviewBuildingStatusData:GetWidgetPos()
  return self._widgetPos
end

function UIActivityN6ReviewBuildingStatusData:GetIconPos()
  return self._iconPos
end

function UIActivityN6ReviewBuildingStatusData:GetIconWidth()
  return self._iconWidth
end

function UIActivityN6ReviewBuildingStatusData:GetIconHeight()
  return self._iconHeight
end

function UIActivityN6ReviewBuildingStatusData:GetIconRotate()
  return self._iconRotate
end

function UIActivityN6ReviewBuildingStatusData:GetTriggerPos()
  return self._triggerPos
end

function UIActivityN6ReviewBuildingStatusData:GetTriggerWidth()
  return self._triggerWidth
end

function UIActivityN6ReviewBuildingStatusData:GetTriggerHeight()
  return self._triggerHeight
end

function UIActivityN6ReviewBuildingStatusData:GetTriggerRotate()
  return self._triggerRotate
end

function UIActivityN6ReviewBuildingStatusData:GetLayer()
  return self._layer
end

function UIActivityN6ReviewBuildingStatusData:GetStatus()
  return self._status
end

function UIActivityN6ReviewBuildingStatusData:GetCondition()
  return self._condition
end

function UIActivityN6ReviewBuildingStatusData:GetCost()
  return self._cost
end

function UIActivityN6ReviewBuildingStatusData:GetStoryId()
  return self._storyId
end

function UIActivityN6ReviewBuildingStatusData:GetStoryType()
  return self._storyType
end

function UIActivityN6ReviewBuildingStatusData:GetStoryReviewId()
  return self._storyReviewId
end

function UIActivityN6ReviewBuildingStatusData:GetStatusName()
  return self._statusName
end

function UIActivityN6ReviewBuildingStatusData:GetDes()
  return self._des
end

function UIActivityN6ReviewBuildingStatusData:GetIcon()
  return self._icon
end

function UIActivityN6ReviewBuildingStatusData:GetName()
  return self._name
end

function UIActivityN6ReviewBuildingStatusData:IsShow()
  return self._isShow
end

function UIActivityN6ReviewBuildingStatusData:IsUnLock(buildingDatas)
  if not self._condition then
    return true
  end
  return self._condition:IsUnLock(buildingDatas)
end

function UIActivityN6ReviewBuildingStatusData:GetTipsIcon()
  return self._tipsIcon
end

_class("UIActivityN6ReviewBuildingData", Object)
UIActivityN6ReviewBuildingData = UIActivityN6ReviewBuildingData

function UIActivityN6ReviewBuildingData:Constructor(buildingDatas, buildingId, cfgs, localProcess)
  if cfgs == nil then
    return
  end
  self._localProcess = localProcess
  self._buildComponent = self._localProcess:GetComponent(ECampaignReviewN6ComponentID.BUILD)
  self._buildComponentInfo = self._localProcess:GetComponentInfo(ECampaignReviewN6ComponentID.BUILD)
  self._buildingDatas = buildingDatas
  self._buildingId = buildingId
  self._statusDatas = {}
  for k, v in pairs(cfgs) do
    self._statusDatas[#self._statusDatas + 1] = UIActivityN6ReviewBuildingStatusData:New(v, self._localProcess)
  end
  table.sort(self._statusDatas, function(a, b)
    return a:GetStatus() < b:GetStatus()
  end)
  local status = self._statusDatas[1]:GetStatus()
  local buildItemInfos = self._buildComponentInfo.build_item_infos
  local buildingInfo = buildItemInfos[buildingId]
  if buildingInfo then
    local mask = buildingInfo.mask
    if mask == 0 then
      status = UIActivityNPlusSixBuildingStatus.CleanUp
    elseif 0 < mask & 4 then
      status = UIActivityNPlusSixBuildingStatus.DecorateComplete
    elseif 0 < mask & 2 then
      status = UIActivityNPlusSixBuildingStatus.RepairComplete
    elseif mask & 1 > 0 then
      status = UIActivityNPlusSixBuildingStatus.CleanUpComplete
    end
  end
  self._currentStatus = nil
  self._currentStatusIndex = 0
  for i = 1, #self._statusDatas do
    if self._statusDatas[i]:GetStatus() == status then
      self._currentStatusIndex = i
      self._currentStatus = self._statusDatas[i]
      break
    end
  end
end

function UIActivityN6ReviewBuildingData:GetUnPlayStoryList()
  local storyList = {}
  local buildItemInfos = self._buildComponentInfo.build_item_infos
  local buildingInfo = buildItemInfos[self._buildingId]
  if buildingInfo then
    local mask = buildingInfo.mask
    local storyMask = buildingInfo.story_mask
    if mask & 4 > 0 and storyMask & 4 == 0 then
      local statusData = self:GetStatusByStatusType(UIActivityNPlusSixBuildingStatus.RepairComplete)
      local storyType = statusData:GetStoryType()
      local storyId = statusData:GetStoryId()
      if storyId and 0 < storyId then
        storyList[#storyList + 1] = {
          storyType,
          storyId,
          UIActivityNPlusSixBuildingStatus.RepairComplete,
          self._buildingId
        }
      end
    end
    if 0 < mask & 2 and storyMask & 2 == 0 then
      local statusData = self:GetStatusByStatusType(UIActivityNPlusSixBuildingStatus.CleanUpComplete)
      local storyType = statusData:GetStoryType()
      local storyId = statusData:GetStoryId()
      if storyId and 0 < storyId then
        storyList[#storyList + 1] = {
          storyType,
          storyId,
          UIActivityNPlusSixBuildingStatus.CleanUpComplete,
          self._buildingId
        }
      end
    end
    if 0 < mask & 1 and storyMask & 1 == 0 then
      local statusData = self:GetStatusByStatusType(UIActivityNPlusSixBuildingStatus.CleanUp)
      local storyType = statusData:GetStoryType()
      local storyId = statusData:GetStoryId()
      if storyId and 0 < storyId then
        storyList[#storyList + 1] = {
          storyType,
          storyId,
          UIActivityNPlusSixBuildingStatus.CleanUp,
          self._buildingId
        }
      end
    end
  end
  return storyList
end

function UIActivityN6ReviewBuildingData:GetBuildingComponent()
  return self._buildComponent
end

function UIActivityN6ReviewBuildingData:GetBuildingComponentInfo()
  return self._buildComponentInfo
end

function UIActivityN6ReviewBuildingData:GetBuildingId()
  return self._buildingId
end

function UIActivityN6ReviewBuildingData:IsUnLockStatus(status)
  return status <= self:GetStatusType()
end

function UIActivityN6ReviewBuildingData:GetStatusType()
  return self._currentStatus:GetStatus()
end

function UIActivityN6ReviewBuildingData:GetStatus()
  return self._currentStatus
end

function UIActivityN6ReviewBuildingData:GetStatusData()
  if #self._statusDatas <= 0 then
    return nil
  end
  return self._statusDatas[self._currentStatusIndex]
end

function UIActivityN6ReviewBuildingData:CanBuild()
  if #self._statusDatas <= 0 then
    return false
  end
  return self._currentStatusIndex < #self._statusDatas
end

function UIActivityN6ReviewBuildingData:IsComplete()
  if #self._statusDatas <= 0 then
    return true
  end
  return self._currentStatusIndex >= #self._statusDatas
end

function UIActivityN6ReviewBuildingData:GetName()
  if not self._currentStatus then
    return ""
  end
  return self._currentStatus:GetName()
end

function UIActivityN6ReviewBuildingData:GetStatusName()
  if not self._currentStatus then
    return ""
  end
  return self._currentStatus:GetStatusName()
end

function UIActivityN6ReviewBuildingData:GetIcon()
  if not self._currentStatus then
    return ""
  end
  return self._currentStatus:GetIcon()
end

function UIActivityN6ReviewBuildingData:GetDes()
  if not self._currentStatus then
    return ""
  end
  return self._currentStatus:GetDes()
end

function UIActivityN6ReviewBuildingData:GetCost()
  local nextStatusData = self:GetNextStatusData()
  if not nextStatusData then
    return nil
  end
  return nextStatusData:GetCost()
end

function UIActivityN6ReviewBuildingData:GetCompleteStoryId()
  if not self._currentStatus then
    return 0
  end
  return self._currentStatus:GetStoryId()
end

function UIActivityN6ReviewBuildingData:GetCompleteStoryType()
  if not self._currentStatus then
    return 0
  end
  return self._currentStatus:GetStoryType()
end

function UIActivityN6ReviewBuildingData:IsShow()
  if not self._currentStatus then
    return false
  end
  if self._currentStatus:IsUnLock(self._buildingDatas) then
    return true
  end
  return self._currentStatus:IsShow()
end

function UIActivityN6ReviewBuildingData:IsUnLock()
  if not self._currentStatus then
    return true
  end
  return self._currentStatus:IsUnLock(self._buildingDatas)
end

function UIActivityN6ReviewBuildingData:IsNextStatusUnLock()
  local nextStatusData = self:GetNextStatusData()
  if not nextStatusData then
    return nil
  end
  return nextStatusData:IsUnLock(self._buildingDatas)
end

function UIActivityN6ReviewBuildingData:GetNextStatusData()
  if #self._statusDatas <= 0 then
    return nil
  end
  if self._currentStatusIndex >= #self._statusDatas then
    return nil
  end
  return self._statusDatas[self._currentStatusIndex + 1]
end

function UIActivityN6ReviewBuildingData:GetNextStatus()
  local status = self:GetNextStatusData()
  if not status then
    return nil
  end
  return status:GetStatus()
end

function UIActivityN6ReviewBuildingData:BuildingLevelUp()
  if #self._statusDatas <= 0 then
    return
  end
  if self._currentStatusIndex >= #self._statusDatas then
    return
  end
  self._currentStatusIndex = self._currentStatusIndex + 1
  self._currentStatus = self._statusDatas[self._currentStatusIndex]
end

function UIActivityN6ReviewBuildingData:GetStatusByStatusType(status)
  for i = 1, #self._statusDatas do
    if self._statusDatas[i]:GetStatus() == status then
      return self._statusDatas[i]
    end
  end
  return nil
end

function UIActivityN6ReviewBuildingData:GetCanReviewStory()
  local ids = {}
  for i = 1, self._currentStatusIndex - 1 do
    local id = self._statusDatas[i]:GetStoryReviewId()
    if id and 0 < id then
      ids[#ids + 1] = id
    end
  end
  return ids
end

function UIActivityN6ReviewBuildingData:GetWidgetDesPos()
  if not self._currentStatus then
    return Vector2(0, 0)
  end
  return self._currentStatus:GetWidgetDesPos()
end

function UIActivityN6ReviewBuildingData:GetWidgetPos()
  if not self._currentStatus then
    return Vector2(0, 0)
  end
  return self._currentStatus:GetWidgetPos()
end

function UIActivityN6ReviewBuildingData:GetIconPos()
  if not self._currentStatus then
    return Vector2(0, 0)
  end
  return self._currentStatus:GetIconPos()
end

function UIActivityN6ReviewBuildingData:GetIconWidth()
  if not self._currentStatus then
    return 0
  end
  return self._currentStatus:GetIconWidth()
end

function UIActivityN6ReviewBuildingData:GetIconHeight()
  if not self._currentStatus then
    return 0
  end
  return self._currentStatus:GetIconHeight()
end

function UIActivityN6ReviewBuildingData:GetIconRotate()
  if not self._currentStatus then
    return 0
  end
  return self._currentStatus:GetIconRotate()
end

function UIActivityN6ReviewBuildingData:GetTriggerPos()
  if not self._currentStatus then
    return Vector2(0, 0)
  end
  return self._currentStatus:GetTriggerPos()
end

function UIActivityN6ReviewBuildingData:GetTriggerWidth()
  if not self._currentStatus then
    return 0
  end
  return self._currentStatus:GetTriggerWidth()
end

function UIActivityN6ReviewBuildingData:GetTriggerHeight()
  if not self._currentStatus then
    return 0
  end
  return self._currentStatus:GetTriggerHeight()
end

function UIActivityN6ReviewBuildingData:GetTriggerRotate()
  if not self._currentStatus then
    return 0
  end
  return self._currentStatus:GetTriggerRotate()
end

function UIActivityN6ReviewBuildingData:GetLayer()
  if not self._currentStatus then
    return 0
  end
  return self._currentStatus:GetLayer()
end

_class("UIActivityN6ReviewBuildingDatas", Object)
UIActivityN6ReviewBuildingDatas = UIActivityN6ReviewBuildingDatas

function UIActivityN6ReviewBuildingDatas:Constructor(componentId, localProcess)
  self._localProcess = localProcess
  self._buildingList = {}
  local cfgs = Cfg.cfg_component_build_item({ComponentID = componentId})
  if not cfgs then
    return
  end
  if table.count(cfgs) <= 0 then
    return
  end
  local buildingCfgs = {}
  for k, v in pairs(cfgs) do
    local buildingId = v.BuildItemId
    local buildingCfg = buildingCfgs[buildingId]
    if not buildingCfg then
      buildingCfg = {}
      buildingCfgs[buildingId] = buildingCfg
    end
    buildingCfg[#buildingCfg + 1] = v
  end
  for k, v in pairs(buildingCfgs) do
    self._buildingList[k] = UIActivityN6ReviewBuildingData:New(self, k, v, self._localProcess)
  end
end

function UIActivityN6ReviewBuildingDatas:GetBuildingList()
  return self._buildingList
end

function UIActivityN6ReviewBuildingDatas:GetBuilding(buildingId)
  return self._buildingList[buildingId]
end

function UIActivityN6ReviewBuildingDatas:IsUnLock(buildingId)
  local buildingData = self._buildingList[buildingId]
  return buildingData:IsUnLock()
end

function UIActivityN6ReviewBuildingDatas:GetUnPlayStoryList()
  local storyList = {}
  for k, v in pairs(self._buildingList) do
    local storys = v:GetUnPlayStoryList()
    for j = 1, #storys do
      storyList[#storyList + 1] = storys[j]
    end
  end
  return storyList
end

function UIActivityN6ReviewBuildingDatas:HaveCanBuilding(itemCount)
  for k, v in pairs(self._buildingList) do
    local buildingData = v
    if buildingData:CanBuild() and buildingData:IsUnLock() and buildingData:IsNextStatusUnLock() then
      local costCfg = buildingData:GetCost()
      local cost = 0
      if costCfg and costCfg[1] and costCfg[1][2] then
        cost = costCfg[1][2]
      end
      if itemCount >= cost then
        return true
      end
    end
  end
  return false
end

function UIActivityN6ReviewBuildingDatas:IsAllBuildingComplete()
  for k, v in pairs(self._buildingList) do
    local buildingData = v
    if not buildingData:IsComplete() then
      return false
    end
  end
  return true
end

function UIActivityN6ReviewBuildingDatas:IsFirstEnterBuilding()
  local key = self:GetFirstEnterBuildingKey()
  local value = UnityEngine.PlayerPrefs.GetInt(key, 0)
  return value == 0
end

function UIActivityN6ReviewBuildingDatas:EnterBuilding()
  local key = self:GetFirstEnterBuildingKey()
  UnityEngine.PlayerPrefs.SetInt(key, 1)
end

function UIActivityN6ReviewBuildingDatas:GetFirstEnterBuildingKey()
  local roleModule = GameGlobal.GetModule(RoleModule)
  local pstId = roleModule:GetPstId()
  local key = pstId .. "FirstEnterN6ReviewBuilding"
  return key
end

function UIActivityN6ReviewBuildingDatas:GetCanReviewStory()
  local results = {}
  for k, v in pairs(self._buildingList) do
    local ids = v:GetCanReviewStory()
    for i = 1, #ids do
      results[#results + 1] = ids[i]
    end
  end
  table.sort(results, function(a, b)
    return a < b
  end)
  return results
end
