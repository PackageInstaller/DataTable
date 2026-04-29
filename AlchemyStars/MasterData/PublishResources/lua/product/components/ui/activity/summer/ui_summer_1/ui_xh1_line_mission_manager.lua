_class("UIXH1LineMissionManager", Object)
UIXH1LineMissionManager = UIXH1LineMissionManager

function UIXH1LineMissionManager:Constructor()
  self._missionModule = GameGlobal.GetModule(MissionModule)
  self._componentInfo = nil
  self.nodes = {}
  self.lines = {}
  self._lineExtraCfg = {}
  self._lineCfg = {}
  self._unlockCfg = {}
  self._missionState = {}
  self.totalWidth = 0
end

function UIXH1LineMissionManager:GetNodes()
  return self.nodes
end

function UIXH1LineMissionManager:GetLines()
  return self.lines
end

function UIXH1LineMissionManager:GetTotalWidth()
  return self.totalWidth
end

function UIXH1LineMissionManager:GetScrollPos(missionId)
  if self._lineCfg[missionId] then
    return self._lineCfg[missionId].ScrollPos
  end
  return nil
end

function UIXH1LineMissionManager:GetLineExtraConfig()
  return self._lineExtraCfg
end

function UIXH1LineMissionManager:Init(componentInfo, componentId)
  self._componentInfo = componentInfo
  self:_MakeLineExtraConfig(componentId)
  self:_MakeLineConfig(componentId)
  self:_MakeUnlockConfig(self._lineCfg)
  self:Update()
end

function UIXH1LineMissionManager:Update()
  self:_UpdateMissionState(self._unlockCfg)
  self:_UpdateNodePos(self._lineCfg, self._missionState)
  self:_FillData_Nodes(self._lineCfg, self._missionState)
  self:_FillData_Lines(self.nodes, self._unlockCfg)
end

function UIXH1LineMissionManager:_MakeLineExtraConfig(componentId)
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

function UIXH1LineMissionManager:_MakeLineConfig(componentId)
  local newConfig = {}
  local config = Cfg.cfg_component_line_mission({ComponentID = componentId})
  for _, v in ipairs(config) do
    newConfig[v.CampaignMissionId] = v
  end
  self._lineCfg = newConfig
end

function UIXH1LineMissionManager:_MakeUnlockConfig(lineMission)
  local newConfig = {}
  for _, v in pairs(lineMission) do
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

function UIXH1LineMissionManager:_UpdateMissionState(unlockMission)
  local missionClear = self._componentInfo.m_pass_mission_info
  local newConfig = {}
  for k, v in pairs(unlockMission) do
    if k == 0 or missionClear[k] then
      if k ~= 0 then
        if not newConfig[k] then
          newConfig[k] = {}
        end
        local count = 0
        local tb = {}
        count, tb = self._missionModule:ParseStarInfo(missionClear[k].star)
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

function UIXH1LineMissionManager:_UpdateNodePos(lineMission, missionState)
  local minPosX, maxPosX
  for k, v in pairs(lineMission) do
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
  for k, v in pairs(lineMission) do
    v.PosX = v.MapPosX - minPosX + firstNodePosX
    v.PosY = v.MapPosY
    v.ScrollPos = Vector2(-(v.PosX + totalWidth / 2), 0)
  end
  self.totalWidth = totalWidth
end

function UIXH1LineMissionManager:_FillData_Nodes(lineMission, missionState)
  local newConfig = {}
  local config = Cfg.cfg_campaign_mission({})
  for _, v in pairs(config) do
    local id = v.CampaignMissionId
    if lineMission[id] then
      local state
      local starCount = 0
      if missionState[id] then
        state = missionState[id].State
        starCount = missionState[id].StarCount
      end
      local newNode = UIActivityMissionNodeInfo:New()
      newNode:Init(id, lineMission[id].PosX, lineMission[id].PosY, v.Name, v.Title, v.Type, lineMission[id].WayPointType == 4, state, starCount)
      newConfig[id] = newNode
    end
  end
  self.nodes = newConfig
end

function UIXH1LineMissionManager:_FillData_Lines(campaignMission, unlockMission)
  local newConfig = {}
  for k, v in pairs(unlockMission) do
    if k ~= 0 and not campaignMission[k].isSLevel then
      for _, vv in ipairs(v) do
        if not campaignMission[vv].isSLevel then
          table.insert(newConfig, {
            campaignMission[k],
            campaignMission[vv]
          })
        end
      end
    end
  end
  self.lines = newConfig
end

function UIXH1LineMissionManager:GetScrollSpliter()
  local posxs = {}
  for _, v in pairs(self.nodes) do
    posxs[#posxs + 1] = v.pos.x
  end
  table.sort(posxs)
  return posxs[11], posxs[12], posxs[19], posxs[20]
end
