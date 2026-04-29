_class("UIActivityLineMissionManager", Object)
UIActivityLineMissionManager = UIActivityLineMissionManager

function UIActivityLineMissionManager:Constructor()
  self._missionModule = GameGlobal.GetModule(MissionModule)
  self._componentInfo = nil
  self.nodes = {}
  self.lines = {}
  self._lineExtraCfg = {}
  self._lineCfg = {}
  self._unlockCfg = {}
  self._clearInfo = {}
  self._missionState = {}
  self.totalWidth = 0
end

function UIActivityLineMissionManager:GetNodes()
  return self.nodes
end

function UIActivityLineMissionManager:GetLines()
  return self.lines
end

function UIActivityLineMissionManager:GetTotalWidth()
  return self.totalWidth
end

function UIActivityLineMissionManager:GetScrollPos(missionId)
  if self._lineCfg[missionId] then
    return self._lineCfg[missionId].ScrollPos
  end
  return nil
end

function UIActivityLineMissionManager:GetLineExtraConfig()
  return self._lineExtraCfg
end

function UIActivityLineMissionManager:Init(componentInfo, componentId)
  self._componentInfo = componentInfo
  self:_MakeLineExtraConfig(componentId)
  self:_MakeLineConfig(componentId)
  self:_MakeUnlockConfig(self._lineCfg)
  self:Update()
end

function UIActivityLineMissionManager:Update()
  self:_UpdateMissionClearInfo(self._lineCfg)
  self:_UpdateMissionState(self._unlockCfg, self._clearInfo)
  self:_UpdateNodePos(self._lineCfg, self._missionState)
  self:_FillData_Nodes(self._lineCfg, self._missionState)
  self:_FillData_Lines(self.nodes, self._unlockCfg)
end

function UIActivityLineMissionManager:Update_Evesinsa(isShow, missionId)
  self:_UpdateMissionClearInfo(self._lineCfg)
  self:_UpdateMissionState(self._unlockCfg, self._clearInfo)
  if isShow then
    self._missionState[missionId] = {}
    self._missionState[missionId].State = DiscoveryStageState.Nomal
    self._missionState[missionId].StarCount = 0
  end
  self:_UpdateNodePos(self._lineCfg, self._missionState)
  self:_FillData_Nodes(self._lineCfg, self._missionState)
  self:_FillData_Lines(self.nodes, self._unlockCfg)
end

function UIActivityLineMissionManager:_MakeLineExtraConfig(componentId)
  local newConfig = {}
  local config = Cfg.cfg_component_line_mission_extra({ComponentID = componentId})
  for _, v in pairs(config) do
    newConfig._NodeWidthLeft = v.NodeWidthLeft or 0
    newConfig._NodeWidthRight = v.NodeWidthRight or 0
    newConfig._MarginLeft = v.MarginLeft or 0
    newConfig._MarginRight = v.MarginRight or 0
    newConfig._Scale = v.Scale or 1.0
  end
  self._lineExtraCfg = newConfig
end

function UIActivityLineMissionManager:_MakeLineConfig(componentId)
  local newConfig = {}
  local config = Cfg.cfg_component_line_mission({ComponentID = componentId})
  for _, v in ipairs(config) do
    newConfig[v.CampaignMissionId] = v
  end
  self._lineCfg = newConfig
end

function UIActivityLineMissionManager:_MakeUnlockConfig(lineCfg)
  local newConfig = {}
  for _, v in pairs(lineCfg) do
    local prev = v.NeedMissionId
    if not newConfig[prev] then
      newConfig[prev] = {}
    end
    local curr = v.CampaignMissionId
    if not newConfig[curr] then
      newConfig[curr] = {}
    end
    table.insert(newConfig[prev], curr)
  end
  self._unlockCfg = newConfig
end

function UIActivityLineMissionManager:_UpdateMissionClearInfo(lineCfg)
  local missionClear = self._componentInfo.m_pass_mission_info
  local newConfig = {}
  for _, v in pairs(lineCfg) do
    local prev = v.NeedMissionId
    if not newConfig[prev] then
      newConfig[prev] = missionClear[prev]
      local otherComponentId = v.NeedMissionComponentID
      if otherComponentId and otherComponentId ~= 0 and self:_IsMissionUnlockInOtherComponent(otherComponentId, prev) then
        local mission_tmp = cam_mission_info:New()
        newConfig[prev] = mission_tmp
      end
    end
    local curr = v.CampaignMissionId
    if not newConfig[curr] then
      newConfig[curr] = missionClear[curr]
    end
  end
  self._clearInfo = newConfig
end

function UIActivityLineMissionManager:_IsMissionUnlockInOtherComponent(otherComponentId, missionId)
  local campaignModule = GameGlobal.GetModule(CampaignModule)
  local campaignId, componentId, componentType = campaignModule:ParseCfgComponentID(otherComponentId)
  local component = campaignModule:GetComponentByComponentId(otherComponentId)
  local componentInfo = component:GetComponentInfo()
  if componentType == CampaignComType.E_CAMPAIGN_COM_TREE_MISSION then
    return component:IsPassCamMissionID(missionId)
  end
  return false
end

function UIActivityLineMissionManager:_UpdateMissionState(unlockCfg, clearInfo)
  local newConfig = {}
  for k, v in pairs(unlockCfg) do
    if k == 0 or clearInfo[k] then
      if k ~= 0 then
        if not newConfig[k] then
          newConfig[k] = {}
        end
        local count = 0
        local tb = {}
        count, tb = self._missionModule:ParseStarInfo(clearInfo[k].star)
        newConfig[k].State = DiscoveryStageState.Nomal
        newConfig[k].StarCount = count
      end
      for _, vv in ipairs(v) do
        if not newConfig[vv] then
          newConfig[vv] = {}
          newConfig[vv].State = DiscoveryStageState.CanPlay
          newConfig[vv].StarCount = 0
        end
      end
    end
  end
  self._missionState = newConfig
end

function UIActivityLineMissionManager:_UpdateNodePos(lineCfg, missionState)
  local minPosX, maxPosX
  for k, v in pairs(lineCfg) do
    if missionState[k] then
      if not minPosX or not maxPosX then
        minPosX, maxPosX = v.MapPosX, v.MapPosX
      end
      minPosX = math.min(minPosX, v.MapPosX)
      maxPosX = math.max(maxPosX, v.MapPosX)
    end
  end
  if not minPosX or not maxPosX then
    return
  end
  local marginLeft = self._lineExtraCfg._MarginLeft + self._lineExtraCfg._NodeWidthLeft
  local marginRight = self._lineExtraCfg._MarginRight + self._lineExtraCfg._NodeWidthRight
  local allNodeWidth = maxPosX - minPosX
  local totalWidth = allNodeWidth + marginLeft + marginRight
  local firstNodePosX = marginLeft - totalWidth / 2
  for k, v in pairs(lineCfg) do
    v.PosX = v.MapPosX - minPosX + firstNodePosX
    v.PosY = v.MapPosY
    v.ScrollPos = Vector2(-(v.PosX + totalWidth / 2), 0)
  end
  self.totalWidth = totalWidth
end

function UIActivityLineMissionManager:_FillData_Nodes(lineCfg, missionState)
  local newConfig = {}
  local config = Cfg.cfg_campaign_mission({})
  for _, v in pairs(config) do
    local id = v.CampaignMissionId
    if lineCfg[id] then
      local state
      local starCount = 0
      if missionState[id] then
        state = missionState[id].State
        starCount = missionState[id].StarCount
      end
      local newNode = UIActivityMissionNodeInfo:New()
      newNode:Init(id, lineCfg[id].PosX, lineCfg[id].PosY, v.Name, v.Title, v.Type, lineCfg[id].WayPointType == WayPointType.WayPointType_S, state, starCount)
      newConfig[id] = newNode
    end
  end
  self.nodes = newConfig
end

function UIActivityLineMissionManager:_FillData_Lines(nodes, unlockCfg)
  local newConfig = {}
  for k, v in pairs(unlockCfg) do
    if k ~= 0 and nodes[k] and not nodes[k].isSLevel then
      for _, vv in ipairs(v) do
        if not nodes[vv].isSLevel then
          table.insert(newConfig, {
            nodes[k],
            nodes[vv]
          })
        end
      end
    end
  end
  self.lines = newConfig
end
