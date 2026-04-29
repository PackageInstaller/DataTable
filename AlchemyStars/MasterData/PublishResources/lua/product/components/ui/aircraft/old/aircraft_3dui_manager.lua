_class("Aircraft3DUIManager", Object)
Aircraft3DUIManager = Aircraft3DUIManager

function Aircraft3DUIManager:Constructor()
  self.canvasRoot = UnityEngine.GameObject.Find("Aircraft3DUICanvas").transform
  self.aircraftModule = GameGlobal.GetModule(AircraftModule)
  self.scale = 0.03
  self.uiDic = {}
  self._isShow = true
end

function Aircraft3DUIManager:Dispose()
  for _, ui in pairs(self.uiDic) do
    ui:OnDestroy()
  end
end

function Aircraft3DUIManager:RefreshUI(spaceId, roomData, roomGo)
  local ui = self.uiDic[spaceId]
  local state = self:GetUIState(spaceId)
  if ui then
    ui:Refresh(roomData, state)
  else
    ui = self:CreateUI(state, roomGo)
    ui:Show(roomData, state, spaceId)
    self.uiDic[spaceId] = ui
  end
end

function Aircraft3DUIManager:LoadUIAsset(roomGo)
  local box = roomGo:GetComponent(typeof(UnityEngine.BoxCollider))
  local pos = roomGo.transform.position + box.center - roomGo.transform.forward * (box.size.z / 2)
  local size = box.size
  local req = ResourceManager:GetInstance():SyncLoadAsset("RoomUIBase.prefab", LoadType.GameObject)
  req.Obj.transform:SetParent(self.canvasRoot)
  req.Obj.transform.position = pos
  req.Obj.transform.localScale = Vector3(1, 1, 1)
  req.Obj:SetActive(true)
  local rect = req.Obj:GetComponent(typeof(UnityEngine.RectTransform))
  rect.sizeDelta = Vector2(size.x / self.scale, size.y / self.scale)
  rect.eulerAngles = roomGo.transform.eulerAngles
  return req
end

function Aircraft3DUIManager:GetState(idx)
  return self.uiDic[idx]:GetState()
end

function Aircraft3DUIManager:OnEnterRoom(spaceID)
  self.uiDic[spaceID]:EnterRoom()
end

function Aircraft3DUIManager:OnExitRoom(spaceID)
  self.uiDic[spaceID]:ExitRoom()
end

function Aircraft3DUIManager:CreateUI(state, roomGo)
  local uiReq = self:LoadUIAsset(roomGo)
  return AircraftRoom3DUI:New(uiReq, roomGo)
end

function Aircraft3DUIManager:IsShow()
  return self._isShow
end

function Aircraft3DUIManager:SetUIActive(active)
  self.canvasRoot.gameObject:SetActive(active)
  self._isShow = active
end

function Aircraft3DUIManager:GetUIIndex(_uiGo)
  for i = 1, #self.uiViews do
    if self.uiViews[i] == _uiGo then
      return i
    end
  end
  return nil
end

function Aircraft3DUIManager:GetUIState(_idx)
  local spaceData = self.aircraftModule:GetSpaceInfo(_idx)
  local buildType = Cfg.cfg_aircraft_space[_idx].BuildType[1]
  if spaceData == nil then
    if buildType == nil then
      Log.fatal("[aircraft] space idx error: ", _idx)
      return nil
    end
    if buildType == AirRoomType.AisleRoom then
      return AirUIState.AisleNotOpen
    else
      return AirUIState.SpaceNotOpen
    end
  else
    local spaceState = spaceData.space_status
    local roomData = self.aircraftModule:GetRoom(_idx)
    local isAisle = buildType == AirRoomType.AisleRoom
    if isAisle then
      if spaceState == SpaceState.SpaceStateNeedClean then
        if self:CanConnectToSpace(_idx) then
          return AirUIState.AisleUnclean
        else
          return AirUIState.AisleNotOpen
        end
      elseif spaceState == SpaceState.SpaceStateCleaning then
        Log.exception("[Aircraft] 严重错误，过道状态为清理中")
      elseif spaceState == SpaceState.SpaceStateEmpty then
        return AirUIState.AisleUnbuild
      elseif spaceState == SpaceState.SpaceStateFull then
        return AirUIState.Aisle
      else
        Log.fatal("[aircraft] space state error: ", "Idx: ", _idx, " SpaceState: ", spaceState)
        return nil
      end
    elseif spaceState == SpaceState.SpaceStateNeedClean then
      if self:CanConnectToSpace(_idx) then
        return AirUIState.SpaceUnclean
      else
        return AirUIState.SpaceNotOpen
      end
    elseif spaceState == SpaceState.SpaceStateCleaning then
      return AirUIState.SpaceCleaning
    elseif spaceState == SpaceState.SpaceStateBuilding then
      return AirUIState.RoomBuilding
    elseif spaceState == SpaceState.SpaceStateEmpty then
      return AirUIState.SpaceUnbuild
    elseif spaceState == SpaceState.SpaceStateUpgrading then
      return AirUIState.RoomUpgrading
    elseif spaceState == SpaceState.SpaceStateDegrading then
      if 1 >= roomData:Level() then
        return AirUIState.RoomTearing
      else
        return AirUIState.RoomDegrading
      end
    elseif spaceState == SpaceState.SpaceStateFull then
      local roomType = roomData:GetRoomType()
      if roomType == AirRoomType.PurifyRoom then
        local purityState = roomData:PurifyStatus()
        if purityState == PurifyRoomStatus.EVIL_WITHOUT_PURIFY or purityState == PurifyRoomStatus.NO_EVIL then
          return AirUIState.RoomIdle
        elseif purityState == PurifyRoomStatus.PURIFING then
          return AirUIState.EvilClearing
        elseif purityState == PurifyRoomStatus.WAITING_COLLECT_AWARD then
          return AirUIState.EvilClearEnd
        else
          Log.fatal("[aircraft] purify room state error: state-->", purityState)
          return nil
        end
      elseif roomType == AirRoomType.MazeRoom or roomType == AirRoomType.PrismRoom or roomType == AirRoomType.TowerRoom then
        if roomData:CanCollectAward() then
          return AirUIState.CollectAward
        elseif roomData:HasNewTask() then
          return AirUIState.HaveNewTask
        else
          return AirUIState.RoomIdle
        end
      else
        return AirUIState.RoomIdle
      end
    else
      Log.fatal("[aircraft] space state error: ", "Idx: ", _idx, " state: ", spaceState)
      return nil
    end
  end
end

function Aircraft3DUIManager:CanConnectToSpace(spaceID)
  return true
end

function Aircraft3DUIManager:GetBtnGuide(spaceId)
  return self.uiDic[spaceId]:GetBtnGuide()
end
