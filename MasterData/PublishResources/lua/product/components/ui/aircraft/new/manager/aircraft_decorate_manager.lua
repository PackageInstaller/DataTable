_class("AircraftDecorateManager", Object)
AircraftDecorateManager = AircraftDecorateManager

function AircraftDecorateManager:Constructor(main)
  self._main = main
  self._input = self._main:Input()
  self._module = GameGlobal.GetModule(AircraftModule)
  self._areas = {}
  self._mode = DecorateMode.FullView
  self._curMdf = nil
  self._dragging = false
  self._draggingFur = false
  self._curArea = nil
  self._dragGridPos = nil
  self._modifiers = {}
  local _grids = {}
  for i = 1, 4 do
    local surs = {}
    local cfgSurs = AircraftGrids[i]
    for id, cfgSur in pairs(cfgSurs) do
      local w = cfgSur.Width
      local h = cfgSur.Height
      local cfgTiles = cfgSur.Tiles
      local tiles = {}
      for i = 1, w do
        tiles[i] = {}
        for j = 1, h do
          local cfgTile = cfgTiles[i][j]
          if cfgTile then
            tiles[i][j] = AircraftTile:New(cfgTile)
          end
        end
      end
      surs[id] = tiles
    end
    _grids[i] = surs
  end
  
  function self._getTile(floor, surface, x, y)
    return _grids[floor][surface][x][y]
  end
  
  self._firstClickArea = nil
end

function AircraftDecorateManager:Init()
  self._camera = AircraftDecorateCamera:New(self._main:GetDecorateViewPoint())
  self._camera:Init(self._main:GetMainCamera(), self._input)
  self:_initAreas()
  self._occupyTip = AircraftOccupyTip:New()
end

function AircraftDecorateManager:msgBox(title, confirm)
  PopupManager.Alert("UICommonMessageBox", PopupPriority.Normal, PopupMsgBoxType.OkCancel, "", title, function(param)
    if confirm then
      confirm()
    end
  end, nil, function(param)
  end, nil)
end

function AircraftDecorateManager:OnDecorateUIShow(btnParant, camera)
  self._furTip = UIAircraftFurnitureTip:New(function()
    self:OnTipCancelClick()
  end, function(offset)
    self:OnTipRoteteClick(offset)
  end, function()
    self:OnTipConfirmClick()
  end, btnParant:GetComponent(typeof(UIView)), self._main:GetMainCamera())
end

function AircraftDecorateManager:OnDecorateUIClose()
  self._furTip:Dispose()
end

function AircraftDecorateManager:Open(spaceID)
  self._firstArea = nil
  self._camera:Reset()
  if spaceID then
    for i = 1, AircraftConst.DecorateAreaCount do
      if Cfg.cfg_aircraft_area[i].SpaceId == spaceID then
        AirLog("进入装扮模式：", spaceID)
        self._firstArea = i
        self._firstSpace = spaceID
        self:EnterArea(i)
        break
      end
    end
  else
    AirLog("进入装扮模式，全景")
    self._mode = DecorateMode.FullView
    self._camera:MoveToFar(function()
      self._firstClickArea = nil
      GameGlobal.UIStateManager():ShowDialog("UIAircraftDecorateTip", nil, function()
        self:Close(nil)
      end)
    end)
  end
  self._main:Set3DUIActive(false)
end

function AircraftDecorateManager:Back()
  self:dropDownFurniture(true, false)
  self:TryPopTip(function()
    GameGlobal.UIStateManager():CloseDialog("UIAircraftDecorateController")
    if self._curArea then
      self._areas[self._curArea]:OnExit()
    end
    if self._firstArea and self._firstArea == self._curArea then
      self:Close(self._firstSpace)
    else
      self._camera:MoveToFar(function()
        self._mode = DecorateMode.FullView
        self._firstClickArea = nil
        GameGlobal.UIStateManager():ShowDialog("UIAircraftDecorateTip", self._curArea, function()
          self:Close(nil)
        end)
        self._firstClickArea = self._curArea
        self._curArea = nil
        self._modifiers = {}
      end)
    end
  end)
end

function AircraftDecorateManager:Close(space)
  if self._furTip then
    self._furTip:Hide()
  end
  self._main:ChangeMode(AircraftMode.Normal)
  self._main:ResetMainCamera()
  if space then
    self._main:SelectSpace(space, false)
    self._main:SelectSpace(space, true)
  end
  self._curMdf = nil
  self._dragging = false
  self._draggingFur = false
  self._curArea = nil
  self._dragGridPos = nil
  self._grids = nil
end

function AircraftDecorateManager:OnTipCancelClick()
  if self._curMdf:Furniture():OprateType() ~= FurnitureOpration.Free then
    ToastManager.ShowToast(StringTable.Get("str_aircraft_cant_remove_this_fur"))
    return
  end
  self._curMdf:DropDown(false)
  self._curMdf:Delete()
  self._module:ChangeTempFurniture(self._curMdf:Furniture():CfgID(), -1)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.UIAircraftDecorateRefreshAtmosphere, self:calAmbient())
  self:editEnd()
  self._camera:SwitchCfg(self._areas[self._curArea]:CameraID())
  self:handleOverlapFurs()
end

function AircraftDecorateManager:OnTipRoteteClick(offset)
  local pos = offset + Vector2(300, 0)
  local hwidth = UnityEngine.Screen.width / 2
  local hheight = UnityEngine.Screen.height / 2
  local x = hwidth - 100 - 160
  local y = hheight - 160
  if x < pos.x then
    pos.x = offset.x - 300
  elseif pos.x < -x then
  elseif y < pos.y then
    pos.y = offset.y - 300
  elseif pos.y < -y then
    pos.y = offset.y + 300
  end
  GameGlobal.EventDispatcher():Dispatch(GameEventType.UIAircraftShowRotater, true, self._curMdf:RotY(), pos)
  self._furTip:Hide()
end

function AircraftDecorateManager:OnTipConfirmClick()
  self:dropDownFurniture(true, true)
  self._camera:SwitchCfg(self._areas[self._curArea]:CameraID())
end

function AircraftDecorateManager:RemoveAll()
  local function remove()
    if self._curArea == nil then
      AirLog("当前区域为空，不能移除所有家具")
      
      return
    end
    local allFurs = {}
    for _, mdf in pairs(self._modifiers) do
      allFurs[mdf:ID()] = true
      if not mdf:IsDeleted() and mdf:Furniture():OprateType() == FurnitureOpration.Free then
        mdf:Delete()
        self._module:ChangeTempFurniture(mdf:Furniture():CfgID(), -1)
      end
    end
    for id, fur in pairs(self._areas[self._curArea]:Furnitures()) do
      if fur:OprateType() == FurnitureOpration.Free and not allFurs[fur:InstanceID()] then
        allFurs[fur:InstanceID()] = true
        local mdf = self._modifiers[fur:InstanceID()]
        if not mdf then
          local surface = self._areas[self._curArea]:GetSurface(fur:SurfaceID())
          mdf = FurnitureModifier:New(self._curArea, surface, fur, false)
          self._modifiers[fur:InstanceID()] = mdf
        end
        if not mdf:IsDeleted() then
          mdf:Delete()
          self._module:ChangeTempFurniture(fur:CfgID(), -1)
        end
      end
    end
    GameGlobal.EventDispatcher():Dispatch(GameEventType.UIAircraftDecorateRefreshAtmosphere, self:calAmbient())
    self._furTip:Hide()
    self._occupyTip:Hide()
    GameGlobal.EventDispatcher():Dispatch(GameEventType.UIAircraftDecorateSwitchModel, true)
  end
  
  self:msgBox(StringTable.Get("str_aircraft_remove_all_fur_tip"), remove)
end

function AircraftDecorateManager:Revert()
  self:msgBox(StringTable.Get("str_aircraft_revert_operation"), function()
    self:revertAllModify()
  end)
end

function AircraftDecorateManager:revertAllModify()
  if not next(self._modifiers) then
    AirLog("没有编辑过的家具，不用回滚")
    return
  end
  for id, mdf in pairs(self._modifiers) do
    if mdf:IsNewAdd() then
      mdf:Revert()
    end
  end
  for id, mdf in pairs(self._modifiers) do
    mdf:Revert()
  end
  self._modifiers = {}
  self._module:ClearTempFurniture()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.UIAircraftDecorateRefreshAtmosphere, self:calAmbient())
  GameGlobal.EventDispatcher():Dispatch(GameEventType.UIAircraftDecorateSwitchModel, true)
end

function AircraftDecorateManager:Save()
  if not next(self._modifiers) then
    AirLog("没有编辑过的家具，不保存")
    return
  end
  if not self._curArea then
    AirLog("当前没有选中的区域")
    return
  end
  local datas = {}
  local furs = {}
  for _, mdf in pairs(self._modifiers) do
    furs[mdf:Furniture():InstanceID()] = true
    local data = mdf:GetSaveData()
    if data then
      datas[#datas + 1] = data
    end
    mdf:Dispose()
  end
  for id, fur in pairs(self._areas[self._curArea]:Furnitures()) do
    if not furs[fur:InstanceID()] then
      furs[fur:InstanceID()] = true
      local data = fur:GetSvrData()
      if data then
        datas[#datas + 1] = data
      end
    end
  end
  GameGlobal.TaskManager():StartTask(function(TT)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.AircraftUILock, true, "ChangeFurniture")
    local errorCode = self._module:ReqUpdateAreaFurniture(TT, self._curArea, datas)
    if errorCode == AircraftEventResult.AircraftEventResult_Succ then
      self._areas[self._curArea]:RefreshFurniture()
      ToastManager.ShowToast(StringTable.Get("str_aircraft_save_succ"))
      self._module:ClearTempFurniture()
    else
      ToastManager.ShowToast(self._module:GetErrorMsg(errorCode))
    end
    GameGlobal.EventDispatcher():Dispatch(GameEventType.AircraftUILock, false, "ChangeFurniture")
    self._modifiers = {}
    GameGlobal.EventDispatcher():Dispatch(GameEventType.UIAircraftDecorateRefreshAtmosphere, self:calAmbient())
    GameGlobal.EventDispatcher():Dispatch(GameEventType.UIAircraftDecorateSwitchModel, true)
  end)
end

function AircraftDecorateManager:OnRotate(angle)
  local surface = self._curMdf:Surface()
  local valid, grids = GridHelper.CanFurniturPlaceAt(surface, self._curMdf:Furniture(), self._curMdf:GridPosition(), angle)
  local pos, rot = GridHelper.GetFurniturePosRot(surface, self._curMdf:GridPosition(), angle)
  self._curMdf:ChangeRotY(angle, rot, grids, valid)
  local gpos, grot = GridHelper.GetGridsWorldPos(surface, grids)
  self._occupyTip:Show(gpos, grot, valid, grids)
  self:handleOverlapFurs(surface:Tiles(), valid, grids)
end

function AircraftDecorateManager:TryAddFurniture(id)
  for surID, sur in pairs(self._areas[self._curArea]:Surfaces()) do
    local found, pos = GridHelper.FindLocationOn(id, sur)
    if found then
      local fur = self:createFurniture(self._areas[self._curArea], surID, id, pos)
      local mdf = FurnitureModifier:New(self._curArea, sur, fur, true)
      self._modifiers[mdf:ID()] = mdf
      self:pickUpFurniture(fur)
      self._module:ChangeTempFurniture(fur:CfgID(), 1)
      GameGlobal.EventDispatcher():Dispatch(GameEventType.UIAircraftDecorateRefreshAtmosphere, self:calAmbient())
      return true
    end
  end
  return false
end

function AircraftDecorateManager:CurrentArea()
  return self._curArea
end

function AircraftDecorateManager:createFurniture(area, surfaceID, id, gridPos)
  local req = ResourceManager:GetInstance():SyncLoadAsset(id .. ".prefab", LoadType.GameObject)
  local furniture = AircraftFurniture:New(req, nil, area:Floor(), area:ID())
  gridPos = gridPos - furniture:Offset()
  local data = MobileFurnitureInfo:New()
  data.asset_id = id
  data.area_id = self._id
  data.surface = surfaceID
  data.pos_x = GridHelper.ToInt(gridPos.x)
  data.pos_z = GridHelper.ToInt(gridPos.y)
  data.rot = 0
  local surface = area:GetSurface(surfaceID)
  if surface == nil then
    Log.exception("严重错误！新增家具时找不到家具所在的面。区域:", self._id, "，", "家具ID：", id, "面ID:", surfaceID)
  end
  local fp, fr = GridHelper.GetFurniturePosRot(surface, gridPos, 0)
  furniture:SetDecorateData(data, true, fp, fr)
  local grids = GridHelper.FurnitureOccupyGrids(furniture, furniture:GridPosition(), furniture:GridRotY())
  local tiles = surface:Tiles()
  local otiles = {}
  for _, pos in ipairs(grids) do
    if tiles[pos.x] == nil then
      Log.error("找不到列")
    end
    local tile = tiles[pos.x][pos.y]
    if tile == nil then
      Log.exception("面上找不到家具占据的格子。", "面:", surface:ID(), "，家具:", data.asset_id, "，区域:", self._curArea, "，格子坐标:", pos.x, ",", pos.y)
    end
    otiles[#otiles + 1] = tile
  end
  furniture:SetTiles(otiles)
  furniture:OccupyTiles(true)
  return furniture
end

function AircraftDecorateManager:FocusFurniture(fur)
  local targetArea = self._areas[fur.area_id]
  local surface = targetArea:GetSurface(fur.surface)
  if self._curArea ~= fur.area_id then
    self._areas[self._curArea]:OnExit()
  end
  self._camera:SwitchCfg(targetArea:GetCameraCfg(surface:GridType()), surface:GridType(), function()
    if self._curArea ~= fur.area_id then
      self._curArea = fur.area_id
      self._modifiers = {}
      self._areas[self._curArea]:OnEnter()
      GameGlobal.EventDispatcher():Dispatch(GameEventType.UIAircraftDecorateRefreshRoomTitle)
    end
  end)
end

function AircraftDecorateManager:IsDirty()
  if next(self._modifiers) then
    for _, mdf in pairs(self._modifiers) do
      if mdf:IsDirty() then
        return true
      end
    end
  end
  return false
end

function AircraftDecorateManager:calAmbient()
  local ambient = self._module:CalFurnitureAmbient(true)
  local a, b = self._module:CalCentralPetWorkSkill()
  for _, mdf in pairs(self._modifiers) do
    local changed = math.floor(mdf:ChangedAmbient() * (1 + b)) + math.floor(a)
    ambient = ambient + changed
  end
  return math.max(ambient, 0)
end

function AircraftDecorateManager:ShowFurTip()
  self._furTip:Show(self._curMdf:Furniture())
end

function AircraftDecorateManager:_initAreas()
  local parent = UnityEngine.GameObject.Find("areas").transform
  for i = 0, parent.childCount - 1 do
    local id = i + 1
    local space = Cfg.cfg_aircraft_area[id].SpaceId
    local room
    if space then
      room = self._main:GetRoomBySpaceID(space)
    end
    self._areas[id] = AircraftArea:New(self._main, id, parent:GetChild(i).gameObject, room, self._getTile)
  end
end

function AircraftDecorateManager:Dispose()
  self._camera:Dispose()
  self._occupyTip:Dispose()
  self:revertAllModify()
  for _, area in ipairs(self._areas) do
    area:Dispose()
  end
end

function AircraftDecorateManager:Update(deltaTimeMS)
  local clicked, clickPos = self._input:GetClick()
  if clicked then
    local layers = AircraftLayer.Default | 1 << AircraftLayer.Furniture
    local results = self._camera:RaycastAll(clickPos, layers)
    if results then
      self:OnClick(results)
      return
    end
  end
  if self._mode == DecorateMode.FullView then
  elseif self._mode == DecorateMode.Edit then
    local dragging, dragStartPos, dragEndPos = self._input:GetDrag()
    if dragging then
      if not self._dragging then
        self._dragging = true
        if self._curMdf then
          local result = self._camera:Raycast(dragEndPos, 1 << AircraftLayer.Furniture)
          if result and self._curMdf:Furniture():IsThisGO(result.transform.gameObject) then
            self._draggingFur = true
            self:_dragStart(result.point)
            self._furTip:OnDragStart()
          end
        end
      end
      if self._draggingFur then
        self:_dragFurniture(dragEndPos)
      else
        self._camera:OnDrag(dragStartPos - dragEndPos)
      end
    elseif self._dragging then
      self._dragging = false
      self._draggingFur = false
      self._dragGridPos = nil
      if self._furTip then
        self._furTip:OnDragEnd()
      end
    end
    self._camera:OnScale()
  end
  self._camera:Update(deltaTimeMS)
  if self._furTip then
    self._furTip:Update()
  end
end

function AircraftDecorateManager:_dragStart(point)
  local area = self._areas[self._curArea]
  local surface = self._curMdf:Surface()
  surface:CreateDragPlane(point)
  self._dragGridPos = surface:PlaneLocalPos(point)
  self._dragStartPos = self._dragGridPos:Clone()
end

function AircraftDecorateManager:_dragFurniture(screenPos)
  local result = self._camera:RaycastAll(screenPos, 1 << AircraftLayer.Surface | 1 << AircraftLayer.DragLayer)
  if not result then
    return
  end
  local surface = self._curMdf:Surface()
  local dragOnPlane = false
  local dragOnCurSur = false
  local dragToOther = false
  local point
  for _, value in ipairs(result) do
    local go = value.transform.gameObject
    if surface:CheckDragPlane(go) then
      dragOnPlane = true
      point = value.point
    end
    if not dragOnPlane and surface:CheckSurface(go) then
      dragOnCurSur = true
      point = value.point
    end
    if not dragOnPlane and not dragOnCurSur then
      local found = false
      for id, sur in pairs(self._areas[self._curArea]:Surfaces()) do
        if sur:GridType() == self._curMdf:Furniture():LocationType() and id ~= surface:ID() and sur:CheckSurface(go) then
          dragToOther = id
          point = value.point
          found = true
          break
        end
      end
      if found then
        break
      end
    end
  end
  if dragOnPlane then
    local pos = surface:PlaneLocalPos(point)
    local offset = pos - self._dragGridPos
    if offset.x ~= 0 or offset.y ~= 0 then
      local gridPos = self._curMdf:GridPosition() + offset
      local y = self._curMdf:RotY()
      local surface = self._curMdf:Surface()
      local beyond, valid, grids = GridHelper.BeyondSurfaceEdge(surface, self._curMdf:Furniture(), gridPos, y)
      if beyond then
      else
        local wpos, wrot = GridHelper.GetFurniturePosRot(surface, gridPos, y)
        self._curMdf:ChangePos(gridPos, wpos, grids, valid)
        local gpos, grot = GridHelper.GetGridsWorldPos(surface, grids)
        self._occupyTip:Show(gpos, grot, valid, grids)
        self:handleOverlapFurs(surface:Tiles(), valid, grids)
        self._dragGridPos = pos
      end
    end
    return
  end
  if dragOnCurSur then
    return
  end
  if dragToOther then
    local other = self._areas[self._curArea]:GetSurface(dragToOther)
    self._curMdf:ChangeSurface(other)
    point.y = point.y + 0.3
    local originOffset = self._dragGridPos - self._curMdf:GridPosition()
    self:_dragStart(point)
    local furniture = self._curMdf:Furniture()
    local rotY = self._curMdf:RotY()
    local gridPos = self._dragGridPos - originOffset
    local pos, rot = GridHelper.GetFurniturePosRot(other, gridPos, rotY)
    local valid, grids = GridHelper.CanFurniturPlaceAt(other, furniture, gridPos, rotY)
    self._curMdf:ChangePos(gridPos, pos, grids, valid)
    local gpos, grot = GridHelper.GetGridsWorldPos(other, grids)
    self._occupyTip:Show(gpos, grot, valid, grids)
    self:handleOverlapFurs(other:Tiles(), valid, grids)
    return
  end
end

function AircraftDecorateManager:editEnd()
  self._curMdf = nil
  self._furTip:Hide()
  self._occupyTip:Hide()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.UIAircraftDecorateSwitchModel, true)
end

function AircraftDecorateManager:handleOverlapFurs(tiles, valid, grids)
  local furs = self._areas[self._curArea]:Furnitures()
  if self._curMdf then
    local layer = self._curMdf:Furniture():Layer()
    local overlaps = {}
    if not valid then
      for _, pos in pairs(grids) do
        if tiles[pos.x] then
          local tile = tiles[pos.x][pos.y]
          if tile then
            local ids = tile:GetFurnitureIDs(layer)
            if ids then
              for id, _ in pairs(ids) do
                if not overlaps[id] then
                  overlaps[id] = true
                end
              end
            end
          end
        end
      end
    end
    for insID, _ in pairs(self._overlapFurs) do
      if not overlaps[insID] then
        local fur = self:getOverlapFur(insID)
        if fur then
          fur:SetAreaGridValid(true)
          self._overlapFurs[insID] = nil
        end
      end
      overlaps[insID] = nil
    end
    local fur
    for insID, _ in pairs(overlaps) do
      local fur = self:getOverlapFur(insID)
      if fur then
        fur:SetAreaGridValid(false)
        self._overlapFurs[insID] = true
      end
    end
    self._curMdf:Furniture():SetAreaGridValid(valid)
  else
    for insID, _ in pairs(self._overlapFurs) do
      local fur = self:getOverlapFur(insID)
      if fur then
        fur:SetAreaGridValid(true)
      end
    end
    table.clear(self._overlapFurs)
  end
end

function AircraftDecorateManager:getOverlapFur(insID)
  local furs = self._areas[self._curArea]:Furnitures()
  if furs[insID] then
    return furs[insID]
  end
  if self._modifiers[insID] then
    return self._modifiers[insID]:Furniture()
  end
end

function AircraftDecorateManager:OnClick(results)
  if results == nil or #results == 0 then
    return
  end
  if self._mode == DecorateMode.FullView then
    local clickArea
    for _, result in ipairs(results) do
      local go = result.transform.gameObject
      for i, area in ipairs(self._areas) do
        if area:IsThis(go) then
          clickArea = i
          break
        end
      end
      if clickArea then
        if self._firstClickArea then
          if self._firstClickArea == clickArea then
            self:EnterArea(clickArea)
            GameGlobal.UIStateManager():CloseDialog("UIAircraftDecorateTip")
            break
          end
          self._firstClickArea = clickArea
          GameGlobal.EventDispatcher():Dispatch(GameEventType.AircraftSelectDecorateArea, clickArea)
          break
        end
        self._firstClickArea = clickArea
        GameGlobal.EventDispatcher():Dispatch(GameEventType.AircraftSelectDecorateArea, clickArea)
        break
      end
    end
  elseif self._mode == DecorateMode.Edit then
    local fur
    for _, result in ipairs(results) do
      local go = result.transform.gameObject
      for id, furniture in pairs(self._areas[self._curArea]:Furnitures()) do
        if furniture:IsThisGO(go) then
          fur = furniture
          break
        end
      end
      for _, mdf in pairs(self._modifiers) do
        if mdf:Furniture():IsThisGO(go) then
          fur = mdf:Furniture()
          break
        end
      end
      if fur then
        self:pickUpFurniture(fur)
        break
      end
    end
  end
end

function AircraftDecorateManager:dropDownFurniture(showUI, shake)
  if self._curMdf then
    self._curMdf:DropDown(shake)
    self._furTip:Hide()
    self._occupyTip:Hide()
    if showUI then
      GameGlobal.EventDispatcher():Dispatch(GameEventType.UIAircraftDecorateSwitchModel, true)
    end
    self:showAreaFurniturArea(false)
    self._curMdf:Furniture():SetAreaGridValid(true)
    self._curMdf = nil
    self:handleOverlapFurs()
  end
end

function AircraftDecorateManager:pickUpFurniture(fur)
  if self._curMdf then
    if self._curMdf:ID() == fur:InstanceID() then
      return
    else
      self:dropDownFurniture(false, true)
    end
  end
  local surface = self._areas[self._curArea]:GetSurface(fur:SurfaceID())
  self._curMdf = self._modifiers[fur:InstanceID()]
  if not self._curMdf then
    self._curMdf = FurnitureModifier:New(self._curArea, surface, fur, false)
    self._modifiers[self._curMdf:ID()] = self._curMdf
  end
  self:showAreaFurniturArea(true)
  self._curMdf:PickUp()
  self._furTip:Show(self._curMdf:Furniture())
  local gpos, grot = GridHelper.GetGridsWorldPos(surface, self._curMdf:GetGrids())
  GameGlobal.EventDispatcher():Dispatch(GameEventType.UIAircraftDecorateSwitchModel, false)
  local locateType = self._curMdf:Surface():GridType()
  self._camera:SwitchCfg(self._areas[self._curArea]:GetCameraCfg(locateType), locateType)
  self._overlapFurs = {}
  local valid1, grids = GridHelper.CanFurniturPlaceAt(self._curMdf:Surface(), self._curMdf:Furniture(), self._curMdf:GridPosition(), self._curMdf:RotY())
  local beyond, valid2, _ = GridHelper.BeyondSurfaceEdge(self._curMdf:Surface(), self._curMdf:Furniture(), self._curMdf:GridPosition(), self._curMdf:RotY())
  local valid = valid1 and valid2
  self._occupyTip:Show(gpos, grot, valid, self._curMdf:GetGrids())
  self:handleOverlapFurs(surface:Tiles(), valid, grids)
  self._curMdf:SetValidWhenPickup(valid)
end

function AircraftDecorateManager:showAreaFurniturArea(show)
  local setted = {}
  local curFur = self._curMdf:Furniture()
  for id, fur in pairs(self._areas[self._curArea]:Furnitures()) do
    if not setted[fur:InstanceID()] and fur:LocationType() == curFur:LocationType() then
      fur:ShowAreaAndFootprint(show, fur:InstanceID() == curFur:InstanceID())
      setted[fur:InstanceID()] = true
    end
  end
  for _, mod in pairs(self._modifiers) do
    local fur = mod:Furniture()
    if not setted[fur:InstanceID()] and fur:LocationType() == curFur:LocationType() then
      fur:ShowAreaAndFootprint(show, fur:InstanceID() == curFur:InstanceID())
      setted[fur:InstanceID()] = true
    end
  end
end

function AircraftDecorateManager:EnterArea(id)
  if self._curArea == id then
    return
  end
  if self._curArea then
    self._areas[self._curArea]:OnExit()
  end
  self._curArea = id
  self._modifiers = {}
  self._camera:SwitchCfg(self._areas[id]:CameraID(), nil, function()
    self._mode = DecorateMode.Edit
    self._areas[self._curArea]:OnEnter()
    GameGlobal.UIStateManager():ShowDialog("UIAircraftDecorateController", self)
  end)
end

function AircraftDecorateManager:SwitchArea(step)
  AirLog("切换装扮区域：", step)
  local id = self._curArea + step
  if id < 1 then
    id = id + AircraftConst.DecorateAreaCount
  elseif id > AircraftConst.DecorateAreaCount then
    id = id - AircraftConst.DecorateAreaCount
  end
  self:TryPopTip(function()
    self:EnterArea(id)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.UIAircraftDecorateRefreshRoomTitle)
  end)
end

function AircraftDecorateManager:TryPopTip(onEnter)
  if self:IsDirty() then
    local function func()
      self:revertAllModify()
      
      if self._curArea then
        for id, fur in pairs(self._areas[self._curArea]:Furnitures()) do
          fur:ShowAreaAndFootprint(false, false)
        end
      end
      if onEnter then
        onEnter()
      end
    end
    
    self:msgBox(StringTable.Get("str_aircraft_decorate_tip"), func)
  else
    onEnter()
  end
end

function AircraftDecorateManager:RefreshArea(spaceID)
  local room = self._main:GetRoomBySpaceID(spaceID)
  for _, area in ipairs(self._areas) do
    if area:SpaceID() == spaceID then
      area:Refresh(room)
      AirLog("刷新装修区域：", area:ID())
      return
    end
  end
  AirError("找不到空间：", spaceID)
end

function AircraftDecorateManager:RefreshAreaSurfaces(spaceID)
  local room = self._main:GetRoomBySpaceID(spaceID)
  for _, area in ipairs(self._areas) do
    if area:SpaceID() == spaceID then
      area:RefreshSurfaces(room)
      AirLog("刷新装修区域格子：", area:ID())
      return
    end
  end
  AirError("找不到空间：", spaceID)
end

function AircraftDecorateManager:GetFurnitureByID(id)
  for i = 1, AircraftConst.DecorateAreaCount do
    local f = self._areas[i]:GetFurniture(id)
    if f ~= nil then
      return f
    end
  end
  Log.exception("找不到家具:", id, debug.traceback())
end

function AircraftDecorateManager:GetFurnitureByType(type)
  for i = 1, AircraftConst.DecorateAreaCount do
    local fs = self._areas[i]:Furnitures()
    for ist, fur in pairs(fs) do
      if fur ~= nil and fur:Type() == type and fur:AvailableCount() > 0 then
        return fur
      end
    end
  end
  AirLog("找不到家具，类型:", type)
end

function AircraftDecorateManager:GetFurnitureBySpaceID(spaceID)
  local furs = {}
  for _, area in ipairs(self._areas) do
    if area:SpaceID() == spaceID then
      for id, fur in pairs(area:Furnitures()) do
        furs[#furs + 1] = fur
      end
      break
    end
  end
  return furs
end

function AircraftDecorateManager:GetFurnitureByKey(key)
  for i = 1, AircraftConst.DecorateAreaCount do
    local fs = self._areas[i]:Furnitures()
    for ist, fur in pairs(fs) do
      if fur:MatchKey(key) and fur:AvailableCount() > 0 then
        return fur
      end
    end
  end
end

function AircraftDecorateManager:GetFurnituresByArea(area)
  return self._areas[area]:Furnitures()
end
