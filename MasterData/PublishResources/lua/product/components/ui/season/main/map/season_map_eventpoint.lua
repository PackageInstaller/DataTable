require("season_map_eventpoint_base")
_class("SeasonMapEventPoint", SeasonMapEventPointBase)
SeasonMapEventPoint = SeasonMapEventPoint

function SeasonMapEventPoint:Constructor(owner, cfgMission, cfgEventPoint)
  self._isLastMainLevelGroup = false
  self._isLastStory = false
  self._isLastMechanism = false
  self._isLastBox = false
  self:_CalcAllLast()
end

function SeasonMapEventPoint:_OnSwitchDiff()
  self:_CalcAllLast()
end

function SeasonMapEventPoint:_OnSwitchMapMode()
  self:_CalcAllLast()
end

function SeasonMapEventPoint:IsLastMainLevelGroup()
  return self._isLastMainLevelGroup
end

function SeasonMapEventPoint:IsLastStory()
  return self._isLastStory
end

function SeasonMapEventPoint:IsLastMechanism()
  return self._isLastMechanism
end

function SeasonMapEventPoint:IsLastBox()
  return self._isLastBox
end

function SeasonMapEventPoint:_CalcAllLast()
  self:_CalcLastGroup()
  self:_CalcLastStory()
  self:_CalcLastMechanism()
  self:_CalcLastBox()
end

function SeasonMapEventPoint:_CalcLastGroup()
  self._isLastMainLevelGroup = self:_CalcLastMain()
end

function SeasonMapEventPoint:_CalcLastStory()
  self._isLastStory = self:_CalcLast(SeasonEventPointType.MainStory, SeasonExpressType.Story)
end

function SeasonMapEventPoint:_CalcLastMechanism()
  self._isLastMechanism = self:_CalcLast(SeasonEventPointType.Mechanism, nil)
end

function SeasonMapEventPoint:_CalcLastBox()
  self._isLastBox = self:_CalcLast(SeasonEventPointType.Box, SeasonExpressType.Reward)
end

function SeasonMapEventPoint:_CalcLastMain()
  if self:_IsMainLink() then
    local map = self._componentInfo.m_stage_info
    if map[self._id] then
      return false
    else
      local needMissionID = tonumber(self._cfgMission.NeedMission)
      if (needMissionID and map[needMissionID] or not needMissionID) and self._isUnlock and self:DiffAble() and self:ModeAble() and self._curProgressExpress then
        if self._eventPointType == SeasonEventPointType.MainLevel then
          return self._curProgressExpress:ContainExpress(SeasonExpressType.Level)
        elseif self._eventPointType == SeasonEventPointType.MainStory then
          return self._curProgressExpress:ContainExpress(SeasonExpressType.Story) or self._curProgressExpress:ContainExpress(SeasonExpressType.Story3D)
        elseif self._eventPointType == SeasonEventPointType.Box then
          return self._curProgressExpress:ContainExpress(SeasonExpressType.Reward)
        end
        return true
      end
    end
  end
  return false
end

function SeasonMapEventPoint:_IsMainLink()
  return self._eventPointType == SeasonEventPointType.MainLevel or self._eventPointType == SeasonEventPointType.MainStory or self._eventPointType == SeasonEventPointType.Box or self._eventPointType == SeasonEventPointType.Mechanism
end

function SeasonMapEventPoint:_CalcLast(eventPointType, expressType)
  if self._eventPointType == eventPointType then
    local map = self._componentInfo.m_stage_info
    if map[self._id] then
      return false
    else
      local cfgs = Cfg.cfg_component_season({
        ComponentID = self._component:GetComponentCfgId()
      })
      if not cfgs then
        return false
      end
      local lastID
      for _, cfg in pairs(cfgs) do
        local missiconCfg = Cfg.cfg_season_mission[cfg.MissionID]
        if missiconCfg and missiconCfg.Type == eventPointType then
          local id = missiconCfg.ID
          if not map[id] then
            if not lastID then
              lastID = id
            elseif id < lastID then
              lastID = id
            end
          end
        end
      end
      if self._isUnlock and self._id == lastID and self._curProgressExpress then
        if expressType then
          return self._curProgressExpress:ContainExpress(expressType)
        else
          return true
        end
      end
    end
  end
  return false
end
