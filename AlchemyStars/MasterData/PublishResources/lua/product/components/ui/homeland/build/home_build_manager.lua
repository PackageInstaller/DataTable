_class("HomeBuildManager", Object)
HomeBuildManager = HomeBuildManager

function HomeBuildManager:Constructor()
  local areaGO = UnityEngine.GameObject.Find("HomeArea")
  if not areaGO then
    BuildError("场景中没有HomeArea节点")
    return
  end
  local area = areaGO:GetComponent("HomeArea")
  if not area then
    BuildError("HomeArea节点上没有HomeArea组件")
    return
  end
  self._area = HomeBuildArea:New(area)
  self._curFatherBuildingArea = nil
  self._curFreeBuildingArea = nil
  self._sonBuildingRayOffset = Vector3(0, 10, 0)
  self._areaRaycastRecurStep = Vector3(0, -0.01, 0)
  self._module = GameGlobal.GetModule(HomelandModule)
  self._uiModule = GameGlobal.GetUIModule(HomelandModule)
  self._active = false
  self._mode = BuildEditorMode.None
  self._architectures = nil
  self._buildings = {}
  self._curMdf = nil
  self._mdfs = {}
  self._showGrid = false
  self._collider2Building = {}
  self._illegalBuildings = {}
  self._eventListners = {}
  self._obstacles = {}
  self._cdForge = {cdTick = 0, cdPeriod = 0}
  self:AttachEvent(GameEventType.ResetOneBuilding, self.ResetOneBuilding)
  self:AttachEvent(GameEventType.HomeLandFunctionUnlock, self.OnHomelandFunctionUnlock)
  self:AttachEvent(GameEventType.HomelandForgeUpdateSequence, self.OnHomelandForgeUpdateSequence)
end

function HomeBuildManager:_GetData()
  if self._isVisit then
    local visitInfo = self._uiModule:GetVisitInfo()
    return visitInfo.architecture_list.architecture_list
  else
    return self._module:GetBuildArchitecture()
  end
end

function HomeBuildManager:AttachEvent(eventType, func)
  if self._eventListners[eventType] then
    BuildError("不可添加重复的事件监听")
    return
  end
  local callback = GameHelper:GetInstance():CreateCallback(func, self)
  self._eventListners[eventType] = callback
  GameGlobal.EventDispatcher():AddCallbackListener(eventType, callback)
end

function HomeBuildManager:DetachEvent(eventType, func)
  local callback = self._eventListners[eventType]
  if callback then
    GameGlobal.EventDispatcher():RemoveCallbackListener(eventType, callback)
    self._eventListners[eventType] = nil
  end
end

function HomeBuildManager:Init(TT, client)
  self._client = client
  self._isVisit = self._client:IsVisit()
  self._architectures = self:_GetData()
  Log.debug("[homeland loading] HomeBuildManager:Init refreshBuilding start")
  self:refreshBuilding()
  Log.debug("[homeland loading] HomeBuildManager:Init BuildNavMesh start")
  local res = self._client:SceneManager():BuildNavMesh()
  while not res.isDone do
    YIELD(TT)
  end
  local circlePos = BuildConfig.MaxCircle.Center
  self._circlePos = Vector3(circlePos.x, self._area:GetHeight(), circlePos.y)
  self._circleRadius = BuildConfig.MaxCircle.Radius
  Log.debug("[homeland loading] HomeBuildManager:Init BuildNavMesh end")
end

function HomeBuildManager:OnModeChanged(TT, mode)
  if self._isVisit then
    BuildError("拜访家园不允许切换模式")
    return
  end
  if mode == HomelandMode.Build then
    self._active = true
    self._area:ShowArea(true)
    self:CollectObstacle()
    self._mode = BuildEditorMode.Normal
  elseif mode == HomelandMode.Normal and self._client:LastMode() == HomelandMode.Build then
    self._active = false
    self._area:ShowArea(false)
    GameGlobal.UIStateManager():Lock("WaitBuildNavMesh")
    local res = self._client:SceneManager():BuildNavMesh()
    while not res.isDone do
      YIELD(TT)
    end
    self._obstacles = {}
    GameGlobal.UIStateManager():UnLock("WaitBuildNavMesh")
    self._mode = BuildEditorMode.None
  end
end

function HomeBuildManager:SetBuildEditorMode(editorMode)
  self._mode = editorMode
end

function HomeBuildManager:GetBuildEditorMode()
  return self._mode
end

function HomeBuildManager:ShowArea(bShow)
  self._area:ShowArea(bShow)
end

function HomeBuildManager:BuildModeUpdate(dtMS)
  if not self._active then
    return
  end
  local y = self._client:CameraManager():GlobalCameraController():GetCamHeight()
  local height = y - self._area:GetHeight()
  local space = self._area:GetGridSpace()
  if height <= 15 then
    space = BuildGridSize.One
  elseif height <= 25 then
    space = BuildGridSize.Two
  elseif height <= 30 then
    space = BuildGridSize.Three
  end
  if self._area:GetGridSpace() ~= space then
    self._area:SetGridSpace(space)
  end
end

function HomeBuildManager:Update(dtMS)
  if self._client:CurrentMode() == HomelandMode.Build then
    self:BuildModeUpdate(dtMS)
  end
  if self._cdForge.cdPeriod > 0 then
    self._cdForge.cdTick = self._cdForge.cdTick + dtMS
    if self._cdForge.cdTick >= self._cdForge.cdPeriod then
      self:RefreshWhiteTowerHeadBoard()
    end
  end
end

function HomeBuildManager:GetArchitecture(pstid)
  return self._architectures[pstid]
end

function HomeBuildManager:RemoveBuilding(building)
  self._buildings[building:InsID()] = nil
end

function HomeBuildManager:Dispose()
  self:RevertAll()
  for key, building in pairs(self._buildings) do
    building:Dispose()
  end
  for k, v in pairs(self._eventListners) do
    GameGlobal.EventDispatcher():RemoveCallbackListener(k, v)
  end
  self._eventListners = nil
  BuildLog("家园建造析构完成")
end

function HomeBuildManager:RefreshBuildingCurrentAreaID(building)
  if self._curFatherBuildingArea and self._curFatherBuildingArea:GetBelongBuildingArea() then
    building.CurrentAreaID = self._curFatherBuildingArea:GetBelongBuildingArea():GetID()
  else
    building.CurrentAreaID = nil
  end
end

function HomeBuildManager:PickUp(building, notifyInput)
  local mdf = HomeBuildModifier:New(building)
  self._curMdf = mdf
  local preFreeBuildingArea = self._curFreeBuildingArea
  local gArea, gPosY, gBuilding = self:getBelowAreaAndHeight(building:Pos() + self._sonBuildingRayOffset)
  self:FlushCurFreeBuildingArea(gArea, gPosY, gBuilding)
  if self._curFreeBuildingArea ~= preFreeBuildingArea then
    self:DragBuildingFlushFreeChildParent(building, gArea, gPosY, gBuilding)
  end
  if building:GetBuildType() == ArchitectureSubType.Son_Architecture then
    self:ChangeCurFatherBuildingArea(gArea, gPosY, gBuilding)
    self:RefreshBuildingCurrentAreaID(building)
  else
    self:ChangeCurFatherBuildingArea(nil)
  end
  local legal, illegalType = self:CheckLegal()
  self._curMdf:Start(legal, illegalType)
  BuildLog("抬起建筑:", mdf:InsID())
  GameGlobal.EventDispatcher():Dispatch(GameEventType.HomeBuildOnSelectBuilding)
  if notifyInput then
    self._client:InputManager():GetControllerBuild():SetCurrentBuilding(building)
  end
  self:CheckBuildingArrow(building, true)
end

function HomeBuildManager:DropDown()
  local legal = self._curMdf:IsLegal()
  if not legal then
    if self._curMdf:GetIllegalType() == BuildEditIllegalType.SonNotOnFather then
      self:ShowChildBuildDropError(self._curMdf:Building():GetBuildId())
      BuildLog("子建筑不在父建筑区域范围内，不能放下")
    else
      if self._mode == BuildEditorMode.MakeMovieFree then
        ToastManager.ShowHomeToast(StringTable.Get("str_movie_homeland_build_location_error"))
      else
        ToastManager.ShowHomeToast(StringTable.Get("str_homeland_build_location_error"))
      end
      BuildLog("当前位置不合法，不能放下")
    end
    return false
  end
  BuildLog("放下建筑")
  local building = self._curMdf:Building()
  building:SetShowDeleteBtn(true)
  self._curMdf:Finish()
  self._curMdf:DropDown()
  self:CheckBuildingArrow(building, false)
  self._mdfs[#self._mdfs + 1] = self._curMdf
  self._curMdf = nil
  self:ChangeCurFatherBuildingArea(nil)
  self:ChangeCurFreeBuildingArea(nil)
  self._client:InputManager():GetControllerBuild():SetCurrentBuilding(nil)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.HomeBuildOnSelectBuilding)
  self:SetLinkBuildings()
  return true
end

function HomeBuildManager:getBuildingByRay(ray)
  if self._curMdf == nil then
    local castRes, hitInfo = UnityEngine.Physics.Raycast(ray, nil, 1000, 1 << HomeBuildLayer.Building)
    if castRes then
      local building = self._collider2Building[hitInfo.collider]
      if not building then
        BuildError("无效的建筑:", hitInfo.transform.gameObject.name)
      end
      return building, hitInfo.point
    end
  else
    local t = {}
    local results = UnityEngine.Physics.RaycastAll(ray, 1000, 1 << HomeBuildLayer.Building)
    if results and results.Length > 0 then
      for i = 1, results.Length do
        t[i] = results[i - 1]
      end
      table.sort(t, function(a, b)
        return a.distance < b.distance
      end)
    end
    if 0 < #t then
      for _, hitInfo in ipairs(t) do
        local building = self._collider2Building[hitInfo.collider]
        if building and building:InsID() == self._curMdf:Building():InsID() then
          return building, hitInfo.point
        end
      end
      return self._collider2Building[t[1].collider], t[1].point
    end
  end
  return nil
end

function HomeBuildManager:getBuildingArrowByRay(ray)
  local castRes, hitInfo = UnityEngine.Physics.Raycast(ray, nil, 1000, 1 << HomeBuildLayer.Arrow)
  if castRes then
    local go = hitInfo.collider.gameObject
    return tonumber(go.name)
  end
  return nil
end

function HomeBuildManager:getTouchPosByRay(ray)
  local castRes, hitInfo = UnityEngine.Physics.Raycast(ray, nil, 1000, 1 << HomeBuildLayer.Surface)
  if castRes then
    return hitInfo.point, hitInfo.transform
  end
end

function HomeBuildManager:getDragPosByRay(ray)
  local castRes, hitInfo = UnityEngine.Physics.Raycast(ray, nil, 1000, 1 << HomeBuildLayer.Drag)
  if castRes then
    return hitInfo.point
  end
end

function HomeBuildManager:getBelowAreaAndHeight(pos)
  local ray = Ray.New(Vector3.down, pos)
  local pos, trans = self:getTouchPosByRay(ray)
  if pos and trans then
    local area, building = self:GetFatherBuildingArea(trans)
    if area and not area:Contains(Vector2(pos.x, pos.z)) then
      return self:getBelowAreaAndHeight(pos + self._areaRaycastRecurStep)
    end
    return area, pos.y, building
  end
end

function HomeBuildManager:refreshBuilding()
  local new = {}
  local parentList = {}
  local childList = {}
  local commonRootTrans = self._client:SceneManager():BuildingRootTrans()
  for _, arch in pairs(self._architectures) do
    local building
    if next(self._buildings) then
      for insid, bd in pairs(self._buildings) do
        if arch.pstid == bd:GetArchitecture().pstid then
          bd:Transform():SetParent(commonRootTrans)
          bd:Reset(arch)
          building = bd
          self._buildings[insid] = nil
        end
      end
    end
    if not building then
      building = BuildHelper.CreateBuilding(arch)
      local colliders = building:GetColliders()
      for _, collider in pairs(colliders) do
        self._collider2Building[collider] = building
      end
    end
    new[building:InsID()] = building
    if building:GetBuildType() == ArchitectureSubType.Father_Architecture then
      parentList[building:GetBuildId()] = building
    elseif building:GetBuildType() == ArchitectureSubType.Son_Architecture then
      building:StartShakeAnimation(true)
      table.insert(childList, building)
    elseif building:GetParentAssetID() ~= 0 then
      table.insert(childList, building)
    end
  end
  if next(self._buildings) then
    for _, building in pairs(self._buildings) do
      building:Dispose()
    end
  end
  self._buildings = new
  for i = 1, #childList do
    local parentAssetID = childList[i]:GetParentAssetID()
    if parentAssetID and parentList[parentAssetID] then
      parentList[parentAssetID]:AddChild(childList[i])
    else
      BuildError("子建筑", childList[i]:GetBuildPstId(), "没有对应的父建筑数据")
    end
  end
  self:RefreshWhiteTowerHeadBoard()
  self:SetLinkBuildings()
end

function HomeBuildManager:RefreshWhiteTowerHeadBoard()
  local mHomeland = GameGlobal.GetModule(HomelandModule)
  local clientHomelandInfo = mHomeland:GetHomelandInfo()
  local forge_info = clientHomelandInfo.forge_info
  local forge_list = forge_info.forge_list
  local forgeState = ForgeSequenceState.Forging
  local theMinSecond = math.maxinteger
  for _, v in ipairs(forge_list) do
    local doneTimestamp = v.end_time
    local leftSecond = 0
    if 0 < doneTimestamp then
      leftSecond = UICommonHelper.CalcLeftSeconds(doneTimestamp)
    end
    if leftSecond == 0 then
      forgeState = ForgeSequenceState.Getable
    elseif 0 < leftSecond then
      theMinSecond = math.min(theMinSecond, leftSecond)
    end
  end
  for _, building in pairs(self._buildings) do
    local buildType = building:GetBuildType()
    if buildType == ArchitectureSubType.White_Tower then
      building:ShowInteractBoard(forgeState == ForgeSequenceState.Getable)
    end
  end
  if theMinSecond < math.maxinteger then
    self._cdForge.cdTick = 0
    self._cdForge.cdPeriod = theMinSecond * 1000
  else
    self._cdForge.cdTick = 0
    self._cdForge.cdPeriod = 0
  end
end

function HomeBuildManager:OnHomelandForgeUpdateSequence()
  self:RefreshWhiteTowerHeadBoard()
end

function HomeBuildManager:_NotifyAmbientChanged()
  local value = 0
  for _, building in pairs(self._buildings) do
    if not building:IsDelete() and not building:IsShabby() then
      local skin = building:SkinID()
      if 0 < skin then
        value = value + Cfg.cfg_item_architecture_skin[skin].LivableValue
      else
        value = value + Cfg.cfg_item_architecture[building:GetBuildId()].LivableValue
      end
    end
  end
  value = math.min(self._module:GetAmbientCeiling(), value)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.HomeBuildOnAmbientChanged, value)
end

function HomeBuildManager:isOutofArea(building)
  local points = building:GetPoints()
  for _, point in ipairs(points) do
    if not self._area:Contains(point) then
      return true
    end
  end
  local points = building:GetExtendPoints()
  for _, point in ipairs(points) do
    if not self._area:Contains(point) then
      return true
    end
  end
  return false
end

function HomeBuildManager:_CheckLegalFixedChild()
  local legal = true
  local illegalType = BuildEditIllegalType.None
  for _, legalBuilding in pairs(self._illegalBuildings) do
    legalBuilding:ShowArea(false, true)
  end
  self._illegalBuildings = {}
  return legal, illegalType
end

function HomeBuildManager:_CheckLegalFreeChild(building)
  local legal = true
  local illegalType = BuildEditIllegalType.None
  local illegalFree = false
  if building:GetBuildType() == ArchitectureSubType.Son_Architecture then
    illegalFree = true
  elseif building.Parent == nil then
    illegalFree = true
  elseif building.Parent:InFreeAreaBlackList(building:GetBuildId()) then
    illegalFree = true
  end
  if illegalFree then
    local legalBuildings = self._illegalBuildings
    self._illegalBuildings = {
      [building:InsID()] = building
    }
    for _, legalBuilding in pairs(legalBuildings) do
      legalBuilding:ShowArea(false, true)
    end
    for _, legalBuilding in pairs(self._illegalBuildings) do
      legalBuilding:ShowArea(true, false)
    end
    legal = false
  else
    legal = self:_CheckLegalCommon(building)
    if legal then
      legal = false
      local freeAreaID = self._curFreeBuildingArea:GetBelongBuildingArea():GetID()
      if building.Parent:CheckInArea(freeAreaID, building) then
        legal = true
      end
    end
  end
  return legal, illegalType
end

function HomeBuildManager:_CheckLegalCommon(building)
  local outside = self:isOutofArea(building)
  local overlaps = self:GetOverlapBuilding(building)
  local illegalType = BuildEditIllegalType.None
  for id, overlapBuilding in pairs(overlaps) do
    self._illegalBuildings[id] = nil
  end
  for _, legalBuilding in pairs(self._illegalBuildings) do
    legalBuilding:ShowArea(false, true)
  end
  local legal = not outside and next(overlaps) == nil
  if legal then
    local obs = self:GetOverlapObstacle(building)
    legal = not obs
  end
  if legal and building:GetBuildType() == ArchitectureSubType.Son_Architecture and not self:CheckChildBuildingLegal(building) then
    legal = false
    illegalType = BuildEditIllegalType.SonNotOnFather
  end
  if not legal then
    overlaps[building:InsID()] = building
  else
    building:ShowArea(true, true)
  end
  self._illegalBuildings = overlaps
  for _, legalBuilding in pairs(self._illegalBuildings) do
    legalBuilding:ShowArea(true, false)
  end
  return legal, illegalType
end

function HomeBuildManager:CheckLegal()
  local building = self._curMdf:Building()
  if building:IsFixedChild() then
    return self:_CheckLegalFixedChild(building)
  elseif self._curFreeBuildingArea ~= nil then
    return self:_CheckLegalFreeChild(building)
  else
    if self._mode == BuildEditorMode.MakeMovieFree then
      local legal = false
      local illegalType = BuildEditIllegalType.None
      return legal, illegalType
    end
    return self:_CheckLegalCommon(building)
  end
end

function HomeBuildManager:CheckChildBuildingLegal(building)
  local sonCfg = Cfg.cfg_item_son_architecture[building:GetBuildId()]
  local legal = false
  for _, area in ipairs(sonCfg.Areas) do
    if area == building.CurrentAreaID then
      legal = true
    end
  end
  if not legal then
    return false
  end
  for i = 1, #sonCfg.FatherArch do
    local fatherBuilding = self:FindBuildingByCfgID(sonCfg.FatherArch[i])
    if fatherBuilding and fatherBuilding:CheckInArea(building.CurrentAreaID, building) then
      return true
    end
  end
  return false
end

function HomeBuildManager:clampPos(pos)
  local x = pos.x - self._circlePos.x
  local z = pos.z - self._circlePos.z
  if x ^ 2 + z ^ 2 > self._circleRadius ^ 2 then
    local delta = Vector2(x, z)
    delta = delta:Normalize() * self._circleRadius
    return Vector3(self._circlePos.x + delta.x, pos.y, self._circlePos.z + delta.y), true
  end
  return pos, false
end

function HomeBuildManager:handleAdsorb()
  local building = self._curMdf:Building()
  for id, build in pairs(self._buildings) do
    if not build:IsDelete() and id ~= building:InsID() and not build:IsDefaultBuilding() and (build:RotY() - building:RotY()) % 90 == 0 then
      local dx = build:Pos().x - building:Pos().x
      local dz = build:Pos().z - building:Pos().z
      if dx * dx + dz * dz < (build:MaxDiagonal() / 2 + building:MaxDiagonal() / 2) ^ 2 then
        for _, sides in ipairs(building:GetSides()) do
          for i, side in ipairs(sides) do
            for __, tsides in ipairs(build:GetSides()) do
              for j, tside in ipairs(tsides) do
                local result, delta = side:CheckAdsorb(tside)
                if delta then
                  return Vector3(delta.x, 0, delta.y)
                end
              end
            end
          end
        end
      end
    end
  end
end

function HomeBuildManager:handleGridAdsorb()
  local building = self._curMdf:Building()
  if building:RotY() % 90 ~= 0 then
    return
  end
  local space = self._area:MinSpace()
  local sides = building:GetSides()[#building:GetSides()]
  local hor, ver
  if BuildHelper.Equal(sides[1].Start.x, sides[1].End.x) then
    hor = {
      sides[2],
      sides[4]
    }
    ver = {
      sides[1],
      sides[3]
    }
  else
    hor = {
      sides[1],
      sides[3]
    }
    ver = {
      sides[2],
      sides[4]
    }
  end
  local y = 99999
  for i = 1, 2 do
    local h = hor[i].Start.y
    local step = math.floor(h / space)
    local d = step * space - h
    if math.abs(d) < math.abs(y) then
      y = d
    end
  end
  local x = 99999
  for i = 1, 2 do
    local v = ver[i].Start.x
    local step = math.floor(v / space)
    local d = step * space - v
    if math.abs(d) < math.abs(x) then
      x = d
    end
  end
  return Vector3(x, 0, y)
end

function HomeBuildManager:_CreateBuilding(architecture, parentBuilding)
  local building = BuildHelper.CreateBuilding(architecture)
  local colliders = building:GetColliders()
  for _, collider in pairs(colliders) do
    self._collider2Building[collider] = building
  end
  self._buildings[building:InsID()] = building
  if architecture.parent ~= 0 and parentBuilding == nil then
    parentBuilding = self:_GetParentBuilding(architecture.parent)
  end
  if parentBuilding ~= nil then
    parentBuilding:AddChild(building)
  end
  return building
end

function HomeBuildManager:_GetParentBuilding(parentId)
  local parentBuilding
  for key, value in pairs(self._buildings) do
    if value:GetBuildType() == ArchitectureSubType.Father_Architecture and value:GetBuildId() == parentId and not value:IsDelete() then
      parentBuilding = value
      break
    end
  end
  return parentBuilding
end

function HomeBuildManager:AfterCreateChildBuilding(building)
  local colliders = building:GetColliders()
  for _, collider in pairs(colliders) do
    self._collider2Building[collider] = building
  end
  self._buildings[building:InsID()] = building
end

function HomeBuildManager:GetBuildHeight()
  return self._area:GetHeight()
end

function HomeBuildManager:RayTargetInCircle(ray)
  local pos = self:getTouchPosByRay(ray)
  if pos then
    local _, clamped = self:clampPos(pos)
    return not clamped
  end
  return false
end

function HomeBuildManager:SelectBuilding(ray)
  if self._mode == BuildEditorMode.MakeMovieClosing then
    return nil
  end
  if self._mode == BuildEditorMode.MakeMovieOther then
    HomelandMoviePrepareManager:GetInstance():HomelandMoviePrepareItemSelect(ray)
    return nil
  end
  if self._mode == BuildEditorMode.ChangeSkin then
    ToastManager.ShowHomeToast(StringTable.Get("str_homeland_build_cant_build"))
    return nil
  end
  local building = self:getBuildingByRay(ray)
  if not building then
    return self:SelectBuildingArrow(ray)
  end
  if not building then
  elseif not self._curMdf then
    if self._mode == BuildEditorMode.MakeMovieFree and not self:CheckSelectForMakeMovie(building) then
      return nil
    end
    self:PickUp(building, false)
  elseif self._curMdf:InsID() ~= building:InsID() then
    if self._mode == BuildEditorMode.MakeMovieFree and not self:CheckSelectForMakeMovie(building) then
      return nil
    end
    if self:DropDown() then
      self:PickUp(building, false)
    else
      return self._curMdf:Building()
    end
  elseif self._curMdf:InsID() == building:InsID() then
  end
  return building
end

function HomeBuildManager:SetFatherBuildingForMakeMovie(fatherBuilding)
  self.fatherBuilding = fatherBuilding
end

function HomeBuildManager:CheckSelectForMakeMovie(building)
  if self._mode ~= BuildEditorMode.MakeMovieFree then
    return true
  end
  local freeChild = self.fatherBuilding:GetFreeChild(building:InsID())
  return freeChild ~= nil
end

function HomeBuildManager:SelectBuildingArrow(ray)
  if not self._curMdf then
    return
  end
  local curBuilding = self._curMdf:Building()
  if not curBuilding then
    return
  end
  local dir = self:getBuildingArrowByRay(ray)
  if not dir then
    return
  end
  local architecture = curBuilding:GetArchitecture()
  local tran = curBuilding:Transform()
  local size = curBuilding:GetSize()
  local width = size.x
  local height = size.y
  local pos
  if dir == BuildArrowDirection.Forward then
    pos = curBuilding:Pos() + tran:TransformDirection(Vector3(0, 0, height))
  elseif dir == BuildArrowDirection.ForwardRight then
    pos = curBuilding:Pos() + tran:TransformDirection(Vector3(width, 0, height))
  elseif dir == BuildArrowDirection.Right then
    pos = curBuilding:Pos() + tran:TransformDirection(Vector3(width, 0, 0))
  elseif dir == BuildArrowDirection.BackRight then
    pos = curBuilding:Pos() + tran:TransformDirection(Vector3(width, 0, -height))
  elseif dir == BuildArrowDirection.Back then
    pos = curBuilding:Pos() + tran:TransformDirection(Vector3(0, 0, -height))
  elseif dir == BuildArrowDirection.BackLeft then
    pos = curBuilding:Pos() + tran:TransformDirection(Vector3(-width, 0, -height))
  elseif dir == BuildArrowDirection.Left then
    pos = curBuilding:Pos() + tran:TransformDirection(Vector3(-width, 0, 0))
  elseif dir == BuildArrowDirection.ForwardLeft then
    pos = curBuilding:Pos() + tran:TransformDirection(Vector3(-width, 0, height))
  end
  local building = self:AddBuildAtTransform(architecture.asset_id, pos, curBuilding:RotY())
  return building
end

function HomeBuildManager:PressBuilding(ray)
  if self._mode == BuildEditorMode.ChangeSkin then
    ToastManager.ShowHomeToast(StringTable.Get("str_homeland_build_cant_build"))
    return nil
  end
  local canMove
  local building, point = self:getBuildingByRay(ray)
  if building ~= nil then
    canMove = building:CanMove()
  end
  if canMove == false then
    ToastManager.ShowToast(StringTable.Get("str_homeland_build_fixed_move"))
  elseif canMove == true then
    self._area:SetDragHeight(point.y)
    local gArea, gPosY, gBuilding = self:getBelowAreaAndHeight(building:Pos() + self._sonBuildingRayOffset)
    self:FlushCurFreeBuildingArea(gArea, gPosY, gBuilding)
    if building:GetBuildType() == ArchitectureSubType.Son_Architecture then
      self:ChangeCurFatherBuildingArea(gArea, gPosY, gBuilding)
      self:RefreshBuildingCurrentAreaID(building)
    else
      self:ChangeCurFatherBuildingArea(nil)
    end
    if self._curMdf and point and building:InsID() == self._curMdf:InsID() then
      self._dragOffset = point - building:Pos()
    end
  end
  return building
end

function HomeBuildManager:DragBuilding(ray)
  if self._curMdf then
    local building = self._curMdf:Building()
    if building and building:CanMove() then
      local pos = self:getDragPosByRay(ray)
      local preFreeBuildingArea = self._curFreeBuildingArea
      local gArea, gPosY, gBuilding = self:getBelowAreaAndHeight(building:Pos() + self._sonBuildingRayOffset)
      self:FlushCurFreeBuildingArea(gArea, gPosY, gBuilding)
      if building:GetBuildType() == ArchitectureSubType.Son_Architecture then
        self:DragBuildingFlushCommonChildParent(building, gArea, gPosY, gBuilding)
      elseif self._curFreeBuildingArea ~= preFreeBuildingArea then
        self:DragBuildingFlushFreeChildParent(building, gArea, gPosY, gBuilding)
      elseif building ~= gBuilding and building:GetBuildType() ~= ArchitectureSubType.Father_Architecture then
        gPosY = gPosY or self:GetBuildHeight()
        if self._dragOffset ~= nil then
          local changeY = gPosY - building:Pos().y
          self._dragOffset.y = self._dragOffset.y - changeY
        end
      end
      if pos and self._dragOffset then
        self:Move(pos - self._dragOffset)
      end
    end
  end
end

function HomeBuildManager:DragBuildingFlushFreeChildParent(building, gArea, gPosY, gBuilding)
  if building.Parent then
    building.Parent:RemoveChild(building)
  end
  if gBuilding ~= nil and self._curFreeBuildingArea == gArea then
    gBuilding:AddChild(building)
  end
  gPosY = gPosY or self:GetBuildHeight()
  if self._dragOffset ~= nil then
    local changeY = gPosY - building:Pos().y
    self._dragOffset.y = self._dragOffset.y - changeY
  end
  local buildingPos = building:Pos()
  buildingPos.y = gPosY
  building:SetPos(buildingPos)
end

function HomeBuildManager:DragBuildingFlushCommonChildParent(building, gArea, gPosY, gBuilding)
  local buildingPos = building:Pos()
  local fatherBuildingArea, y, fatherBuilding = gArea, gPosY, gBuilding
  if self._curFatherBuildingArea ~= fatherBuildingArea then
    self:ChangeCurFatherBuildingArea(fatherBuildingArea)
    y = y or self:GetBuildHeight()
    self:RefreshBuildingCurrentAreaID(building)
    if building.Parent then
      building.Parent:RemoveChild(building)
    end
    if fatherBuilding then
      fatherBuilding:AddChild(building)
    end
    local changeY = y - buildingPos.y
    self._dragOffset.y = self._dragOffset.y - changeY
  end
end

function HomeBuildManager:ReleaseTouch()
  self._dragOffset = nil
end

function HomeBuildManager:Move(target)
  target = self:clampPos(target)
  self._curMdf:Move(target)
  if self._showGrid then
    local delta = self:handleGridAdsorb()
    if delta then
      self._curMdf:Move(target + delta)
    end
  else
    local delta = self:handleAdsorb()
    if delta then
      self._curMdf:SetAdsorb(true)
      self._curMdf:Move(target + delta)
    end
  end
  local building = self._curMdf:Building()
  self:CheckBuildingArrow(building, true)
  local legal, illegalType = self:CheckLegal()
  self._curMdf:SetLegal(legal, illegalType)
  self:SetLinkBuildings()
end

function HomeBuildManager:Rotate(y)
  self._curMdf:Rotate(y)
  local building = self._curMdf:Building()
  self:CheckBuildingArrow(building, true)
  local legal = self:CheckLegal()
  self._curMdf:SetLegal(legal)
end

function HomeBuildManager:Add(id, ray)
  if self._curMdf then
    BuildError("必须操作完成后才能新增建筑")
  end
  local childBuildingCfg = Cfg.cfg_item_son_architecture[id]
  local building
  if childBuildingCfg ~= nil and childBuildingCfg.FatherSlot ~= nil then
    building = self:AddFixedChildBuilding(id, ray, childBuildingCfg)
  elseif childBuildingCfg then
    building = self:AddChildBuilding(id, ray, childBuildingCfg)
  else
    building = self:AddBuilding(id, ray)
  end
  if building and building:GetBuildType() == ArchitectureSubType.Father_Architecture then
    self:CollectObstacle()
  end
  self:SetLinkBuildings()
end

function HomeBuildManager:AddBuilding(id, ray)
  local pos, areaTrans, fatherBuilding
  local dragAdd = false
  if ray then
    pos = self:getTouchPosByRay(ray)
    dragAdd = true
  else
    ray = self._client:CameraManager():GlobalCameraController():CameraFowardRay()
  end
  pos, areaTrans = self:getTouchPosByRay(ray)
  if pos == nil then
    pos = self._client:CameraManager():GlobalCameraController():GetFocusPos()
  end
  local data = Architecture:New()
  data.asset_id = id
  data.pos_x = BuildHelper.ToInt(pos.x)
  data.pos_z = BuildHelper.ToInt(pos.z)
  data.rot = 0
  data.pstid = 0
  if areaTrans then
    fatherBuilding = self:GetFatherBuilding(areaTrans)
    if fatherBuilding then
      data.pos_y = BuildHelper.ToInt(pos.y)
    end
  end
  local building = self:_CreateBuilding(data)
  building:SetShowDeleteBtn(false)
  building:SetPos(pos)
  self:PickUp(building, not dragAdd)
  self._curMdf:Add()
  self:_NotifyAmbientChanged()
  if dragAdd then
    self._area:SetDragHeight(self._area:GetHeight() + 0.5)
    local touchPos = self:getDragPosByRay(ray)
    if touchPos then
      self._dragOffset = touchPos - building:Pos()
    end
  end
  return building
end

function HomeBuildManager:AddFixedChildBuilding(id, ray, childBuildingCfg)
  local fatherSlot = childBuildingCfg.FatherSlot
  local cfg_fixed_position = Cfg.cfg_homeland_building_fixed_position({})[fatherSlot]
  if cfg_fixed_position == nil then
    BuildError("找不到固定家具位置cfg_homeland_building_fixed_position ：" .. fatherSlot)
    return
  end
  local homelandClient = self._uiModule:GetClient()
  local characterManager = homelandClient:CharacterManager()
  local playerTran = characterManager:GetCharacterTransform()
  local playerPosition = playerTran.position
  local lookFatherArch = {}
  for k, v in pairs(childBuildingCfg.FatherArch) do
    local findSlot = false
    local cfg_father_architecture = Cfg.cfg_item_father_architecture({})[v]
    local slotsCount = 0
    local fatherFixedSlots = cfg_father_architecture.FixedSlots
    if fatherFixedSlots ~= nil then
      slotsCount = #fatherFixedSlots
    end
    for i = 1, slotsCount do
      if fatherFixedSlots[i] == fatherSlot then
        findSlot = true
        break
      end
    end
    if findSlot then
      lookFatherArch[v] = v
    end
  end
  local theNearestFather
  local theMinDistance = math.maxinteger
  for key, value in pairs(self._buildings) do
    local isValid = value:GetBuildType() == ArchitectureSubType.Father_Architecture
    isValid = isValid and not value:IsDelete()
    isValid = isValid and lookFatherArch[value:GetBuildId()] ~= nil
    if isValid then
      local buildingPosition = value:Transform().position
      local distance3D = playerPosition - buildingPosition
      local distance1D = distance3D:SqrMagnitude()
      if theMinDistance > distance1D then
        theNearestFather = value
        theMinDistance = distance1D
      end
    end
  end
  if theNearestFather == nil then
    self:ShowChildBuildDropError(id)
    return
  end
  local fixedTransform
  local fatherTransform = theNearestFather:Transform()
  local fatherPosition = fatherTransform.position
  if cfg_fixed_position.FixedPosition ~= nil then
    fixedTransform = theNearestFather:FindRecursively(cfg_fixed_position.FixedPosition)
  end
  if fixedTransform == nil then
    fixedTransform = fatherTransform
  end
  local relationPosition = fixedTransform.position - fatherPosition
  local fatherYaw = fatherTransform.eulerAngles.y
  local relationYaw = fixedTransform.eulerAngles.y - fatherYaw
  local replacedBuilding = theNearestFather:GetFixedChild(fatherSlot)
  if replacedBuilding ~= nil then
    if replacedBuilding:IsDelete() then
      replacedBuilding = nil
    else
      replacedBuilding:Delete()
    end
  end
  local worldPosition = fatherPosition + relationPosition
  local worldYaw = fatherYaw + relationYaw
  local data = Architecture:New()
  data.asset_id = id
  data.parent = theNearestFather:GetBuildId()
  data.pos_x = BuildHelper.ToInt(worldPosition.x)
  data.pos_y = BuildHelper.ToInt(worldPosition.y)
  data.pos_z = BuildHelper.ToInt(worldPosition.z)
  data.rot = math.floor(worldYaw)
  data.pstid = 0
  local building = self:_CreateBuilding(data)
  building:SetShowDeleteBtn(false)
  self:PickUp(building, true)
  self._curMdf:FixedAdd(replacedBuilding)
  self:_NotifyAmbientChanged()
  local focusPoint = theNearestFather:ChangeSkinFocusPoint()
  self:FocusPoint(focusPoint, nil)
  return building
end

function HomeBuildManager:AddChildBuilding(id, ray, childBuildingCfg)
  local pos, areaTrans, fatherBuilding
  local dragAdd = false
  if ray then
    dragAdd = true
  else
    ray = self._client:CameraManager():GlobalCameraController():CameraFowardRay()
  end
  pos, areaTrans = self:getTouchPosByRay(ray)
  if pos == nil then
    pos = self._client:CameraManager():GlobalCameraController():GetFocusPos()
  end
  local data = Architecture:New()
  data.asset_id = id
  data.pos_x = BuildHelper.ToInt(pos.x)
  if areaTrans then
    fatherBuilding = self:GetFatherBuilding(areaTrans)
    if fatherBuilding then
      data.parent = fatherBuilding:GetBuildId()
      data.pos_y = BuildHelper.ToInt(pos.y)
    end
  end
  data.pos_z = BuildHelper.ToInt(pos.z)
  data.rot = 0
  data.pstid = 0
  local building = self:_CreateBuilding(data)
  building:SetShowDeleteBtn(false)
  self:PickUp(building, not dragAdd)
  if self._curFatherBuildingArea then
    pos.y = self._curFatherBuildingArea:GetHeight()
    building:SetPos(pos)
  end
  self._curMdf:Add()
  self:_NotifyAmbientChanged()
  if dragAdd then
    self._area:SetDragHeight(self._area:GetHeight() + 0.5)
    local touchPos = self:getDragPosByRay(ray)
    if touchPos then
      self._dragOffset = touchPos - building:Pos()
    end
  end
  return building
end

function HomeBuildManager:GetFatherBuilding(areaTrans)
  for key, building in pairs(self._buildings) do
    if building:GetBuildType() == ArchitectureSubType.Father_Architecture and building:HasArea(areaTrans) then
      return building
    end
  end
end

function HomeBuildManager:GetFatherBuildingArea(areaTrans)
  for key, building in pairs(self._buildings) do
    if building:GetBuildType() == ArchitectureSubType.Father_Architecture then
      local area = building:GetArea(areaTrans)
      if area then
        return area, building
      end
    end
  end
end

function HomeBuildManager:AddBuildAtTransform(id, pos, rot)
  local data = Architecture:New()
  data.asset_id = id
  data.pos_x = BuildHelper.ToInt(pos.x)
  data.pos_z = BuildHelper.ToInt(pos.z)
  data.rot = rot
  data.pstid = 0
  local building = self:_CreateBuilding(data)
  self:DropDown()
  self:PickUp(building, false)
  self._curMdf:Add()
  self:_NotifyAmbientChanged()
  return building
end

function HomeBuildManager:Delete()
  self:CheckBuildingArrow(self._curMdf:Building(), false)
  self._curMdf:Delete()
  self._mdfs[#self._mdfs + 1] = self._curMdf
  self._curMdf = nil
  self:ChangeCurFatherBuildingArea(nil)
  self:ChangeCurFreeBuildingArea(nil)
  self._client:InputManager():GetControllerBuild():SetCurrentBuilding(nil)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.HomeBuildOnSelectBuilding)
  self:_NotifyAmbientChanged()
  self:SetLinkBuildings()
end

function HomeBuildManager:RevertAll()
  BuildLog("回滚")
  local count = #self._mdfs
  if count == 0 then
    BuildLog("没有改动，不用回滚")
    return
  end
  if self._curMdf then
    BuildError("必须操作完成后才能回滚操作")
  end
  self:refreshBuilding()
  self._mdfs = {}
  self:_NotifyAmbientChanged()
end

function HomeBuildManager:Save(TT)
  if self._isVisit then
    BuildError("拜访家园不允许保存建筑")
    return
  end
  BuildLog("保存")
  local count = #self._mdfs
  if count == 0 then
    BuildLog("没有改动，不用保存")
    return
  end
  if self._curMdf then
    BuildError("必须操作完成后才能保存")
  end
  local update = {}
  local newadd = {}
  local delete = {}
  local deleteBuildings = {}
  local newBuildings = {}
  for _, building in pairs(self._buildings) do
    local data, isNew, isDelete = building:GetServerData()
    if isDelete then
      if isNew then
      else
        deleteBuildings[#deleteBuildings + 1] = building:GetBuildId()
        delete[#delete + 1] = building:GetArchitecture().pstid
      end
    elseif data == nil then
    elseif isNew then
      newadd[#newadd + 1] = data
      newBuildings[#newBuildings + 1] = data.asset_id
    else
      update[#update + 1] = data
    end
  end
  if #newadd == 0 and #delete == 0 and #update == 0 then
    BuildLog("实际的改动数据未空，不用保存")
    self._curMdf = nil
    self._mdfs = {}
    return
  elseif 400 < #newadd + #delete + #update then
    Log.fatal("达到了单次操作最大上限:", #newadd, ",", #delete, ",", #update)
    ToastManager.ShowHomeToast(StringTable.Get("str_homeland_build_error_max_operation"))
    return
  end
  GameGlobal.UIStateManager():Lock("BuildReqSave")
  local res = self._module:HomelandBuild(TT, newadd, delete, update)
  GameGlobal.UIStateManager():UnLock("BuildReqSave")
  self._architectures = self._module:GetBuildArchitecture()
  if res:GetSucc() then
    self:_OnSaveSuccess(update, delete)
  end
  self:refreshBuilding()
  self._curMdf = nil
  self._mdfs = {}
  if res:GetSucc() then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.HomeBuildOnSelectBuilding)
    ToastManager.ShowHomeToast(StringTable.Get("str_homeland_build_success"))
    self:SetLinkBuildings()
    GameGlobal.EventDispatcher():Dispatch(GameEventType.HomelandBuildOnSave, deleteBuildings, newBuildings)
    return true
  else
    local code = res:GetResult()
    if code == HomeLandErrorType.E_CONFIG_ERROR or code >= HomeLandErrorType.E_SCENE_NOT_ARCHITECTURE and code <= HomeLandErrorType.E_BUILD_MAX_LIMIT then
      ToastManager.ShowHomeToast(StringTable.Get("str_homeland_build_error" .. code))
    else
      ToastManager.ShowHomeToast(StringTable.Get("str_homeland_build_unknownerror", code))
    end
    return false
  end
end

function HomeBuildManager:ShowGrid(show)
  if self._showGrid == show then
    return
  end
  self._showGrid = show
  self._area:ShowGrid(show)
  if self._curFatherBuildingArea then
    self._curFatherBuildingArea:ShowGrid(show)
  end
end

function HomeBuildManager:GetCurrentBuilding()
  if self._curMdf then
    return self._curMdf:Building()
  end
end

function HomeBuildManager:HaveUnsavedModify()
  return self._curMdf ~= nil or next(self._mdfs) ~= nil
end

function HomeBuildManager:GetBuildings()
  local buildings = {}
  for id, building in pairs(self._buildings) do
    if not building:IsDelete() then
      buildings[#buildings + 1] = building
    end
  end
  return buildings
end

function HomeBuildManager:GetBuildingsFilter(filter)
  if not filter then
    return self:GetBuildings()
  end
  local buildings = {}
  for id, building in pairs(self._buildings) do
    if filter(building) then
      buildings[#buildings + 1] = building
    end
  end
  return buildings
end

function HomeBuildManager:GetBuildingBySubType(subtype)
  for _, building in pairs(self._buildings) do
    if building._buildType == subtype then
      return building
    end
  end
end

function HomeBuildManager:FindBuildingBySubType(subType)
  for _, building in pairs(self._buildings) do
    if building:GetBuildType() == subType then
      return building
    end
  end
end

function HomeBuildManager:FindBuildingByCfgID(cfgID)
  for _, building in pairs(self._buildings) do
    if building:GetBuildId() == cfgID and not building:IsDelete() then
      return building
    end
  end
end

function HomeBuildManager:RevertCurrent()
  if not self._curMdf then
    BuildError("当前没有抬起的建筑，不能取消操作")
    return false
  end
  for _, legalBuilding in pairs(self._illegalBuildings) do
    legalBuilding:ShowArea(false, false)
  end
  if self._curMdf:Type() & HomeBuildEditType.Add > 0 then
    self._buildings[self._curMdf:Building():InsID()] = nil
    self._curMdf:Finish()
    self._curMdf:Revert()
    self._curMdf = nil
    self:ChangeCurFatherBuildingArea(nil)
    self:ChangeCurFreeBuildingArea(nil)
    self._client:InputManager():GetControllerBuild():SetCurrentBuilding(nil)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.HomeBuildOnSelectBuilding)
    self:_NotifyAmbientChanged()
    self:SetLinkBuildings()
    return true
  elseif not self._curMdf:IsOriginLegal() then
    ToastManager.ShowHomeToast(StringTable.Get("str_homeland_build_location_error"))
    BuildLog("初始位置不合法，不能取消")
    return false
  else
    self._curMdf:Finish()
    self._curMdf:Revert()
    self._curMdf = nil
    self:ChangeCurFatherBuildingArea(nil)
    self:ChangeCurFreeBuildingArea(nil)
    self._client:InputManager():GetControllerBuild():SetCurrentBuilding(nil)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.HomeBuildOnSelectBuilding)
    self:_NotifyAmbientChanged()
    return true
  end
end

function HomeBuildManager:GetOverlapBuilding(building)
  local buildType = building:GetBuildType()
  local colliders = BuildHelper.GetOverlapColliders(building:GetColliders(), building:Transform(), HomeBuildLayer.Building)
  local targets = {}
  if next(colliders) then
    for collider, _ in pairs(colliders) do
      local other = self._collider2Building[collider]
      if other then
        local otherBuildType = other:GetBuildType()
        local isFatherSon = false
        if buildType == ArchitectureSubType.Father_Architecture then
          isFatherSon = building:GetChild(other:InsID()) ~= nil
        elseif otherBuildType == ArchitectureSubType.Father_Architecture then
          isFatherSon = other:GetChild(building:InsID()) ~= nil
        end
        if isFatherSon then
        elseif other:IsFixedChild() then
        elseif other:LocateLayer() == building:LocateLayer() and not targets[other:InsID()] then
          targets[other:InsID()] = other
        end
      end
    end
  end
  return targets
end

function HomeBuildManager:GetOverlapObstacle(building)
  if next(self._obstacles) then
    local colliders = BuildHelper.GetOverlapColliders(building:GetColliders(), building:Transform(), HomeBuildLayer.BuildObstacle)
    if next(colliders) then
      for collider, _ in pairs(colliders) do
        local obstacleType = self._obstacles[collider]
        if obstacleType == BuildObstacleType.Treasures then
          return true
        elseif obstacleType == BuildObstacleType.ParentBuildingObstacles then
          return building:GetBuildType() == ArchitectureSubType.Son_Architecture
        end
      end
    end
  end
  return false
end

function HomeBuildManager:CanPlaceGroundBrick(building, excludeBuildings)
  if self:GetBuildCount(building:GetBuildId()) <= 0 then
    return false
  end
  local outside = self:isOutofArea(building)
  if outside then
    return false
  end
  local obs = self:GetOverlapObstacle(building)
  if obs then
    return false
  end
  local targets = self:GetOverlapBuilding(building)
  if not targets then
    return true
  end
  targets[self._curMdf:Building():InsID()] = nil
  if 0 >= table.count(targets) then
    return true
  end
  if not excludeBuildings then
    return false
  end
  for i = 1, #excludeBuildings do
    local building = excludeBuildings[i]
    local instanceId = building:InsID()
    targets[instanceId] = nil
  end
  if 0 >= table.count(targets) then
    return true
  end
  return false
end

function HomeBuildManager:CheckBuildingArrow(building, status)
  if not building then
    return
  end
  if not building:HaveArrow() then
    return
  end
  if not status then
    building:ShowArrow(nil)
    return
  end
  if not self:CanPlaceGroundBrick(building) then
    building:ShowArrow(nil)
    return
  end
  local architecture = building:GetArchitecture()
  local data = Architecture:New()
  data.asset_id = architecture.asset_id
  data.pos_x = architecture.pos_x
  data.pos_z = architecture.pos_z
  data.rot = 0
  data.pstid = 0
  local tempBuilding = BuildHelper.CreateBuilding(data)
  tempBuilding:SetMeshVisible(false)
  tempBuilding:SetRotY(building:RotY())
  local tran = building:Transform()
  local size = building:GetSize()
  local width = size.x
  local height = size.y
  local arrows = {}
  local excludeBuilding = {}
  excludeBuilding[#excludeBuilding + 1] = building
  local pos = building:Pos() + tran:TransformDirection(Vector3(0, 0, height))
  tempBuilding:SetPos(pos)
  local canPlace = self:CanPlaceGroundBrick(tempBuilding, excludeBuilding)
  if canPlace then
    arrows[BuildArrowDirection.Forward] = true
  end
  pos = building:Pos() + tran:TransformDirection(Vector3(width, 0, height))
  tempBuilding:SetPos(pos)
  canPlace = self:CanPlaceGroundBrick(tempBuilding, excludeBuilding)
  if canPlace then
    arrows[BuildArrowDirection.ForwardRight] = true
  end
  pos = building:Pos() + tran:TransformDirection(Vector3(width, 0, 0))
  tempBuilding:SetPos(pos)
  canPlace = self:CanPlaceGroundBrick(tempBuilding, excludeBuilding)
  if canPlace then
    arrows[BuildArrowDirection.Right] = true
  end
  pos = building:Pos() + tran:TransformDirection(Vector3(width, 0, -height))
  tempBuilding:SetPos(pos)
  canPlace = self:CanPlaceGroundBrick(tempBuilding, excludeBuilding)
  if canPlace then
    arrows[BuildArrowDirection.BackRight] = true
  end
  pos = building:Pos() + tran:TransformDirection(Vector3(0, 0, -height))
  tempBuilding:SetPos(pos)
  canPlace = self:CanPlaceGroundBrick(tempBuilding, excludeBuilding)
  if canPlace then
    arrows[BuildArrowDirection.Back] = true
  end
  pos = building:Pos() + tran:TransformDirection(Vector3(-width, 0, -height))
  tempBuilding:SetPos(pos)
  canPlace = self:CanPlaceGroundBrick(tempBuilding, excludeBuilding)
  if canPlace then
    arrows[BuildArrowDirection.BackLeft] = true
  end
  pos = building:Pos() + tran:TransformDirection(Vector3(-width, 0, 0))
  tempBuilding:SetPos(pos)
  canPlace = self:CanPlaceGroundBrick(tempBuilding, excludeBuilding)
  if canPlace then
    arrows[BuildArrowDirection.Left] = true
  end
  pos = building:Pos() + tran:TransformDirection(Vector3(-width, 0, height))
  tempBuilding:SetPos(pos)
  canPlace = self:CanPlaceGroundBrick(tempBuilding, excludeBuilding)
  if canPlace then
    arrows[BuildArrowDirection.ForwardLeft] = true
  end
  tempBuilding:Dispose()
  building:ShowArrow(arrows)
end

function HomeBuildManager:GetHomeArea()
  return self._area
end

function HomeBuildManager:GetBuildCount(id)
  local count = 0
  local count = GameGlobal.GetModule(ItemModule):GetItemCount(id)
  for _, building in pairs(self._buildings) do
    if not building:IsDelete() and building:GetBuildId() == id then
      count = count - 1
    end
  end
  if count < 0 then
    count = 0
  end
  return count
end

function HomeBuildManager:GetBuildingByCollider(collider)
  return self._collider2Building[collider]
end

function HomeBuildManager:ResetOneBuilding(pstid, needUpdateNavmesh)
  if pstid then
    local architecture
    self._architectures = self:_GetData()
    for _, arch in pairs(self._architectures) do
      if arch.pstid == pstid then
        architecture = arch
        break
      end
    end
    if not architecture then
      BuildError("找不到要刷新的建筑数据:", pstid)
    end
    local building
    for _, value in pairs(self._buildings) do
      if value:PstID() == pstid then
        building = value
        break
      end
    end
    if building then
      local cs = building:GetColliders()
      for _, collider in pairs(cs) do
        self._collider2Building[collider] = nil
      end
      building:Reset(architecture)
      local cs = building:GetColliders()
      for _, collider in pairs(cs) do
        self._collider2Building[collider] = building
      end
    else
      Log.debug("创建1个本地没有的建筑")
      self:_CreateBuilding(architecture)
    end
    if needUpdateNavmesh then
      self._client:SceneManager():BuildNavMeshAsync()
    end
  end
end

function HomeBuildManager:StartChangeSkin()
  if self._mode == BuildEditorMode.Normal then
    BuildLog("开始换肤")
    self._mode = BuildEditorMode.ChangeSkin
  else
    BuildError("只能从建造模式开始换肤")
  end
end

function HomeBuildManager:SelectChangeSkinBuilding(building)
  if self._mode ~= BuildEditorMode.ChangeSkin then
    BuildError("不在换肤模式不能选中换肤建筑")
    return
  end
  if self._curMdf then
    BuildError("当前有选中的建筑，不能进入换肤模式")
    return
  end
  self._client:CameraManager():GlobalCameraController():Focus(building:ChangeSkinFocusPoint())
  if self._curMdf and self._curMdf:Building():InsID() ~= building:InsID() then
    self._curMdf:FinishChangeSkin()
    self._mdfs[#self._mdfs + 1] = self._curMdf
    self._curMdf = nil
  end
  self._curMdf = HomeBuildModifier:New(building)
  self._curMdf:StartChangeSkin()
end

function HomeBuildManager:ChangeSkin(skinID)
  if self._mode ~= BuildEditorMode.ChangeSkin then
    BuildError("不在换肤模式不能换肤")
    return
  end
  if not self._curMdf then
    BuildError("没有选中的建筑，不能换肤")
  end
  self._curMdf:ChangeSkin(skinID)
  self:_NotifyAmbientChanged()
end

function HomeBuildManager:FinishChangeSkin()
  if self._mode ~= BuildEditorMode.ChangeSkin then
    BuildError("不在换肤模式不能退出")
    return
  end
  if self._curMdf then
    self._curMdf:FinishChangeSkin()
    self._mdfs[#self._mdfs + 1] = self._curMdf
    self._curMdf = nil
  end
  self._mode = BuildEditorMode.Normal
  BuildLog("结束换肤")
end

function HomeBuildManager:RevertCurrentSkin()
  self._curMdf:Finish()
  self._curMdf:Revert()
  self._curMdf = nil
  self:_NotifyAmbientChanged()
end

function HomeBuildManager:_OnSaveSuccess(update, delete)
  local updateBuildings = {}
  local deleteBuildings = {}
  for _, building in pairs(self._buildings) do
    local found = false
    for _, arch in ipairs(update) do
      if building:GetBuildPstId() == arch.pstid then
        building:ResetInteractPos()
        table.insert(updateBuildings, building)
        found = true
        break
      end
    end
    if not found then
      for _, pstid in ipairs(delete) do
        if building:GetBuildPstId() == pstid then
          table.insert(deleteBuildings, building)
          found = true
          break
        end
      end
    end
  end
  GameGlobal.EventDispatcher():Dispatch(GameEventType.HomelandBuildOnSaveBuilding, updateBuildings, deleteBuildings)
end

function HomeBuildManager:CheckBuildingLock(subType)
  if self._isVisit then
    return false
  end
  if subType == ArchitectureSubType.White_Tower then
    return not self._module:CheckFunctionUnlock(HomelandUnlockType.E_HOMELAND_UNLOCK_MAIN_ARC_UI)
  elseif subType == ArchitectureSubType.Shop then
    return not self._module:CheckFunctionUnlock(HomelandUnlockType.E_HOMELAND_UNLOCK_SHOP_ARC_UI)
  elseif subType == ArchitectureSubType.Museum then
    return not self._module:CheckFunctionUnlock(HomelandUnlockType.E_HOMELAND_UNLOCK_PHOTO_UI)
  elseif subType == ArchitectureSubType.Wishing_Pool then
    return not self._module:CheckFunctionUnlock(HomelandUnlockType.E_HOMELAND_UNLOCK_WISHING_POOL_UI)
  elseif subType == ArchitectureSubType.Storage_Box then
    return not self._module:CheckFunctionUnlock(HomelandUnlockType.E_HOMELAND_UNLOCK_VISIT_BOX_UI)
  elseif subType == ArchitectureSubType.Album then
    return not self._module:CheckFunctionUnlock(HomelandUnlockType.E_HOMELAND_UNLOCK_ALBUM)
  elseif subType == ArchitectureSubType.Medal_Wall then
    return not self._module:CheckFunctionUnlock(HomelandUnlockType.E_HOMELAND_UNLOCK_MEDAL_WALL)
  end
end

function HomeBuildManager:OnHomelandFunctionUnlock(functionType)
  local targetBuildingSubType
  if functionType == HomelandUnlockType.E_HOMELAND_UNLOCK_MAIN_ARC_UI then
    targetBuildingSubType = ArchitectureSubType.White_Tower
  elseif functionType == HomelandUnlockType.E_HOMELAND_UNLOCK_SHOP_ARC_UI then
    targetBuildingSubType = ArchitectureSubType.Shop
  elseif functionType == HomelandUnlockType.E_HOMELAND_UNLOCK_PHOTO_UI then
    targetBuildingSubType = ArchitectureSubType.Museum
  elseif functionType == HomelandUnlockType.E_HOMELAND_UNLOCK_WISHING_POOL_UI then
    targetBuildingSubType = ArchitectureSubType.Wishing_Pool
  elseif functionType == HomelandUnlockType.E_HOMELAND_UNLOCK_VISIT_BOX_UI then
    targetBuildingSubType = ArchitectureSubType.Storage_Box
  elseif functionType == HomelandUnlockType.E_HOMELAND_UNLOCK_ALBUM then
    targetBuildingSubType = ArchitectureSubType.Album
  elseif functionType == HomelandUnlockType.E_HOMELAND_UNLOCK_MEDAL_WALL then
    targetBuildingSubType = ArchitectureSubType.Medal_Wall
  end
  if targetBuildingSubType then
    local building = self:GetBuildingBySubType(targetBuildingSubType)
    if building then
      building:Unlock()
    end
  end
end

function HomeBuildManager:CollectObstacle()
  self._obstacles = {}
  local treasureGos = {}
  local treasures = self._client:TreasureManager():GetAllTreasure()
  for _, treasure in pairs(treasures) do
    treasureGos[#treasureGos + 1] = treasure:GameObject()
  end
  for _, go in ipairs(treasureGos) do
    local collider = go:GetComponent(typeof(UnityEngine.Collider))
    if collider then
      go.layer = HomeBuildLayer.BuildObstacle
      self._obstacles[collider] = BuildObstacleType.Treasures
    end
  end
  local parentObstacleGos = {}
  for _, building in pairs(self._buildings) do
    if building:GetBuildType() == ArchitectureSubType.Father_Architecture then
      local list = building:GetObstacles()
      for _, go in ipairs(list) do
        parentObstacleGos[#parentObstacleGos + 1] = go
      end
    end
  end
  for _, go in ipairs(parentObstacleGos) do
    local collider = go:GetComponent(typeof(UnityEngine.Collider))
    if collider then
      go.layer = HomeBuildLayer.BuildObstacle
      self._obstacles[collider] = BuildObstacleType.ParentBuildingObstacles
    end
  end
end

function HomeBuildManager:ActiveAllBuilding(active)
  if self._buildings and next(self._buildings) then
    for _, building in pairs(self._buildings) do
      if not building:IsDefaultBuilding() then
        building:Active(active)
      end
    end
  end
end

function HomeBuildManager:ShowChildBuildDropError(buildAssetID)
  if not self._childBuildDropErrorStrList then
    self._childBuildDropErrorStrList = {}
  end
  if not self._childBuildDropErrorStrList[buildAssetID] then
    self._childBuildDropErrorStrList[buildAssetID] = self:GetChildBuildDropErrorStr(buildAssetID)
  end
  ToastManager.ShowHomeToast(self._childBuildDropErrorStrList[buildAssetID])
end

function HomeBuildManager:GetChildBuildDropErrorStr(buildAssetID)
  local sonCfg = Cfg.cfg_item_son_architecture[buildAssetID]
  local parentStr = ""
  for index, fatherAssetID in ipairs(sonCfg.FatherArch) do
    if 1 < index then
      parentStr = parentStr .. StringTable.Get("str_homeland_build_child_drop_error_seperator")
    end
    parentStr = parentStr .. StringTable.Get(Cfg.cfg_item[fatherAssetID].Name)
  end
  local errorStr = StringTable.Get("str_homeland_build_child_drop_error", StringTable.Get(Cfg.cfg_item[buildAssetID].Name), parentStr)
  return errorStr
end

function HomeBuildManager:IsFatherBuildingDisplayedArea(area)
  local buildingArea = area:GetBelongBuildingArea()
  local fatherBuilding
  if buildingArea ~= nil then
    fatherBuilding = buildingArea:GetFatherBuilding()
  end
  if fatherBuilding ~= nil then
    return fatherBuilding:IsShowBuildingArea(buildingArea:GetID())
  end
  return false
end

function HomeBuildManager:ChangeCurFatherBuildingArea(area)
  if self._curFatherBuildingArea == area then
    return
  end
  if self._curFatherBuildingArea then
    local showArea = self:IsFatherBuildingDisplayedArea(self._curFatherBuildingArea)
    self._curFatherBuildingArea:ShowArea(showArea)
  end
  self._curFatherBuildingArea = area
  if self._curFatherBuildingArea then
    self._curFatherBuildingArea:ShowArea(true)
    self._curFatherBuildingArea:ShowGrid(self._area:GetShowGrid())
    self._curFatherBuildingArea:SetGridSpace(self._area:GetGridSpace())
  end
end

function HomeBuildManager:ChangeCurFreeBuildingArea(area)
  if self._curFreeBuildingArea == area then
    return
  end
  if self._curFreeBuildingArea then
    local showArea = self:IsFatherBuildingDisplayedArea(self._curFreeBuildingArea)
    self._curFreeBuildingArea:ShowArea(showArea)
  end
  self._curFreeBuildingArea = area
  if self._curFreeBuildingArea then
    self._curFreeBuildingArea:ShowArea(true)
    self._curFreeBuildingArea:ShowGrid(self._area:GetShowGrid())
    self._curFreeBuildingArea:SetGridSpace(self._area:GetGridSpace())
  end
end

function HomeBuildManager:FlushCurFreeBuildingArea(area, posY, building)
  local freeArea
  if area ~= nil and building:GetBuildType() == ArchitectureSubType.Father_Architecture then
    local areaID = area:GetBelongBuildingArea():GetID()
    if building:IsFreeArea(areaID) then
      freeArea = area
    end
  end
  self:ChangeCurFreeBuildingArea(freeArea)
end

function HomeBuildManager:FocusAndOutline(cfgID)
  local building = self:FindBuildingByCfgID(cfgID)
  if not building then
    BuildError("找不到建筑" .. cfgID)
    return
  end
  GameGlobal.TaskManager():StartTask(self.FocusAndOutlineProc, self, building)
end

function HomeBuildManager:FocusAndOutlineProc(TT, building)
  GameGlobal.UIStateManager():Lock("HomeBuildManager:FocusAndOutlineProc")
  local focusTime = 0.5
  if not building:ChangeSkinFocusPoint() then
    GameGlobal.UIStateManager():UnLock("HomeBuildManager:FocusAndOutlineProc")
    return
  end
  self._client:CameraManager():GlobalCameraController():Focus(building:ChangeSkinFocusPoint(), focusTime)
  YIELD(TT, focusTime * 1000)
  local color = Color(0.23921568627450981, 0.5882352941176471, 1.0, 1)
  local flashTimes = 2
  local flashLength = 1000
  local currentTime = 0
  local totalTime = flashTimes * flashLength
  building:ShowOutline()
  while currentTime <= totalTime do
    local percent = 1 * (currentTime % flashLength) / flashLength
    color.a = DG.Tweening.DOVirtual.EasedValue(0, 1, percent, DG.Tweening.Ease.Flash)
    building:SetOutlineColor(color)
    YIELD(TT)
    currentTime = currentTime + GameGlobal:GetInstance():GetDeltaTime()
  end
  color.a = 1
  building:SetOutlineColor(color)
  building:HideOutline()
  GameGlobal.UIStateManager():UnLock("HomeBuildManager:FocusAndOutlineProc")
end

function HomeBuildManager:GetCouldLinkBuildings(oribuilding)
  local function checkfun(building)
    if Vector3.Distance(oribuilding:Pos(), building:Pos()) > building:GetCheckLinkDistance() then
      return false
    end
    if oribuilding:GetBuildId() ~= building:GetBuildId() then
      return false
    end
    if oribuilding:PstID() == building:PstID() then
      return false
    end
    if building:IsDelete() then
      return false
    end
    return true
  end
  
  local list = self:GetBuildingsFilter(checkfun)
  if #list <= oribuilding:GetLinkCount() then
    return list
  else
    local endList = {}
    
    local function sortFun(x, y)
      return Vector3.Distance(x:Pos(), oribuilding:Pos()) < Vector3.Distance(y:Pos(), oribuilding:Pos())
    end
    
    table.sort(list, sortFun)
    for i = 1, oribuilding:GetLinkCount() do
      table.insert(endList, list[i])
    end
    return endList
  end
end

function HomeBuildManager:SetLinkBuildings()
  local function checkfun(building)
    return building:CheckCanLink()
  end
  
  local list = self:GetBuildingsFilter(checkfun)
  for index, value in ipairs(list) do
    value:ClearLinkPointObj()
  end
  for index, value in ipairs(list) do
    local temps = self:GetCouldLinkBuildings(value)
    for i, v in ipairs(temps) do
      if value:GetLinkingCount() < value:GetLinkCount() and v:GetLinkingCount() < v:GetLinkCount() and not value:IsDelete() and not v:IsDelete() then
        value:SetLinkPointTransform(v)
      end
    end
  end
end

function HomeBuildManager:OnClickMedal(ray)
  local castRes, hitInfo = UnityEngine.Physics.Raycast(ray, nil, 1000, 1 << HomeBuildLayer.MedalWall)
  if castRes then
    local go = hitInfo.collider.gameObject
    GameGlobal.UIStateManager():ShowDialog("UIMedalTipsHomelandController", tonumber(go.name))
  end
end

function HomeBuildManager:FocusPoint(focusPoint, callback)
  if focusPoint == nil then
    if callback ~= nil then
      callback()
    end
    return
  end
  local focusTime = 0.5
  self._client:CameraManager():GlobalCameraController():Focus(focusPoint, focusTime, callback)
end

function HomeBuildManager:FocusPointDirect(focusPoint)
  self._client:CameraManager():GlobalCameraController():FocusDirect(focusPoint)
end
