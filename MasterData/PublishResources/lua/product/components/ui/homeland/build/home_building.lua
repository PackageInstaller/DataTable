_class("HomeBuilding", BuildBase)
HomeBuilding = HomeBuilding

function HomeBuilding:Constructor(insID, architecture, cfg)
  self._insID = insID
  self._aabb = BuildAABB:New()
  self._npcRes = nil
  self._npcGO = nil
  self._nameBoardGO = nil
  self._interactGO = nil
  self.Parent = nil
  self:Reset(architecture)
  self._interactEffectReq = {}
  self._interactEffectObj = {}
  self._animationStates = {}
  self._interactVisible = true
  self._showDeleteBtn = true
  self._interactingPetList = {}
  self._interactObjects = {}
  self._holdlinkBuildingList = {}
end

function HomeBuilding:Reset(architecture)
  self._architecture = architecture
  if self._cfgID ~= architecture.asset_id then
    self._cfgID = architecture.asset_id
    self._cfg = Cfg.cfg_item_architecture[self._cfgID]
    self._buildingName = StringTable.Get(self._cfg.Name)
    self._buildType = self._cfg.SubType
    self._locateLayer = self._cfg.BuildLayer
    self._isFreePos = false
    local defaultBuildingCfgs = Cfg.cfg_default_architecture({
      ArchitectureId = self._cfgID
    })
    if defaultBuildingCfgs and 0 < #defaultBuildingCfgs and defaultBuildingCfgs[1].Slot then
      self._isFreePos = true
    end
  end
  self._isLock = self._homelandClient:BuildManager():CheckBuildingLock(self._buildType)
  self._parent = 0
  if self._isFreePos then
    local slotName = Cfg.cfg_default_architecture({
      ArchitectureId = self._cfgID
    })[1].Slot
    local slot = UnityEngine.GameObject.Find(slotName)
    if not slot then
      BuildError("场景中找不到默认建筑的挂点:", slotName, "，建筑id:", self._cfgID)
    end
    local pos = slot.transform.position:Clone()
    self._pos = Vector3(BuildHelper.ToFloat(BuildHelper.ToInt(pos.x)), pos.y, BuildHelper.ToFloat(BuildHelper.ToInt(pos.z)))
    self._rotY = slot.transform.eulerAngles.y
  else
    local posY
    if self._architecture.parent ~= 0 then
      self._parent = self._architecture.parent
      posY = BuildHelper.ToFloat(self._architecture.pos_y)
    else
      posY = self._homelandClient:BuildManager():GetBuildHeight()
    end
    self._pos = Vector3(BuildHelper.ToFloat(self._architecture.pos_x), posY, BuildHelper.ToFloat(self._architecture.pos_z))
    self._rotY = architecture.rot
  end
  local prefab
  local skinID = self._architecture.skin
  if skinID and 0 < skinID then
    prefab = skinID
  else
    prefab = self:GetBuildId()
  end
  if self:IsShabby() then
    prefab = prefab .. "_ps.prefab"
  else
    prefab = prefab .. ".prefab"
  end
  if self._prefabName ~= prefab then
    self:_DestroyView()
    self._skinID = architecture.skin
    self._req = ResourceManager:GetInstance():SyncLoadAsset(prefab, LoadType.GameObject)
    if not self._req then
      BuildError("建筑资源不存在:", prefab)
    end
    self._prefabName = prefab
    self._go = self._req.Obj
    self:OnModelChanged()
  else
    self._transform.position = self._pos
    self._transform.eulerAngles = Vector3(0, self._rotY, 0)
    self:UpdateAABB()
  end
  local cfg = Cfg.cfg_item_architecture_link[self._cfgID]
  self._linkCfg = cfg
  self:ShowBuilding(true)
end

function HomeBuilding:OnModelChanged()
  self._transform = self._go.transform
  self._transform:SetParent(self._homelandClient:SceneManager():BuildingRootTrans())
  self._go.layer = HomeBuildLayer.Building
  self._transform.position = self._pos
  self._transform.eulerAngles = Vector3(0, self._rotY, 0)
  self._go.name = self._go.name .. "," .. self._insID
  self._animation = self._go:GetComponentInChildren(typeof(UnityEngine.Animation))
  self._colliders = {}
  self._sides = {}
  if self:IsDefaultBuilding() then
    self._size = Vector2.zero
  else
    local colliders = self._go:GetComponents(typeof(UnityEngine.BoxCollider))
    local count = colliders.Length
    if count == 0 then
      BuildError("建筑没有碰撞盒:", self:GetBuildId())
    end
    for i = 0, count - 1 do
      self._colliders[#self._colliders + 1] = colliders[i]
      self._sides[i + 1] = {
        BuildRectSide:New(),
        BuildRectSide:New(),
        BuildRectSide:New(),
        BuildRectSide:New()
      }
    end
    local size = self._colliders[1].size
    self._size = Vector2(size.x, size.z)
  end
  self:UpdateAABB()
  self:InitArrow()
  self:ShowArrow(false)
  if self._cfg.SubType == ArchitectureSubType.Land then
    self:InitBreedLand(self._architecture)
  elseif self._cfg.SubType == ArchitectureSubType.FishTank then
    self:InitAquarium(self._architecture)
  elseif Cfg.cfg_homeland_swimming_pool[self:GetBuildId()] then
    self:InitSwimmingPool(self._architecture)
  elseif self._cfg.SubType == ArchitectureSubType.Medal_Wall then
    self:InitMedalWall(self._architecture)
  end
  self:ResetInteractPoint()
  self:RefreshInteractPoint()
  self:InitNpc()
  if Cfg.cfg_homeland_building_water_depth[self:GetBuildId()] then
    self._homelandClient:SceneManager():AddWaterDepthTarget(self._go)
  end
  if self._buildType == ArchitectureSubType.Wishing_Pool then
    if self._homelandClient:IsVisit() then
      self:RefreshWishingFish()
    else
      self:ClearWishing()
      self:InitWishing()
    end
  end
  local focusPoint = GameObjectHelper.FindChild(self._transform, "ChangeSkinCamera")
  if focusPoint then
    self._changeSkinFocusPoint = focusPoint.transform
  end
  if self._isFreePos and not self._changeSkinFocusPoint then
    BuildError("换肤建筑找不到像机聚焦点:", self._cfgID)
  end
  self:InitLinkPoint()
end

function HomeBuilding:InitBreedLand()
  Log.exception("HomelandBreedLand必须重写该方法")
end

function HomeBuilding:InitAquarium()
  Log.exception("HomelandAquarium必须重写该方法")
end

function HomeBuilding:InitMedalWall()
  Log.exception("HomelandMedalWall必须重写该方法")
end

function HomeBuilding:InitWishing()
  if self._buildType ~= ArchitectureSubType.Wishing_Pool then
    return
  end
  self:InitWishingFish()
  self:InitCoin()
end

function HomeBuilding:ClearWishing()
  if self._buildType ~= ArchitectureSubType.Wishing_Pool then
    return
  end
  if self._wishingFishs then
    for k, v in pairs(self._wishingFishs) do
      v:Destroy()
    end
  end
  self._coinTrans = {}
  self._currentCoinIndex = 1
  self._coinObjs = {}
  self:RemoveEvents()
end

function HomeBuilding:GetBuildType()
  return self._buildType
end

function HomeBuilding:RemoveEvents()
  if self._addCoinCallback then
    GameGlobal.EventDispatcher():RemoveCallbackListener(GameEventType.WishingAddCollectCoin, self._addCoinCallback)
    self._addCoinCallback = nil
  end
  if self._addWashingFishCallback then
    GameGlobal.EventDispatcher():RemoveCallbackListener(GameEventType.WishingAddFish, self._addWashingFishCallback)
    self._addWashingFishCallback = nil
  end
  if self._removeWahsingFishCallback then
    GameGlobal.EventDispatcher():RemoveCallbackListener(GameEventType.WishingRemoveFish, self._removeWahsingFishCallback)
    self._removeWahsingFishCallback = nil
  end
  if self._refreshWashingFishCallback then
    GameGlobal.EventDispatcher():RemoveCallbackListener(GameEventType.WishingRefreshFish, self._refreshWashingFishCallback)
    self._refreshWashingFishCallback = nil
  end
end

function HomeBuilding:InitWishingFish()
  if self._addWashingFishCallback == nil then
    self._addWashingFishCallback = GameHelper:GetInstance():CreateCallback(self.AddWishingFish, self)
    GameGlobal.EventDispatcher():AddCallbackListener(GameEventType.WishingAddFish, self._addWashingFishCallback)
  end
  if self._removeWahsingFishCallback == nil then
    self._removeWahsingFishCallback = GameHelper:GetInstance():CreateCallback(self.RemoveWishingFish, self)
    GameGlobal.EventDispatcher():AddCallbackListener(GameEventType.WishingRemoveFish, self._removeWahsingFishCallback)
  end
  if self._refreshWashingFishCallback == nil then
    self._refreshWashingFishCallback = GameHelper:GetInstance():CreateCallback(self.RefreshWishingFish, self)
    GameGlobal.EventDispatcher():AddCallbackListener(GameEventType.WishingRefreshFish, self._refreshWashingFishCallback)
  end
  self:RefreshWishingFish()
end

function HomeBuilding:AddWishingFish(id, fishInstanceId)
  if self._wishingFishs[fishInstanceId] then
    return
  end
  self._wishingFishs[fishInstanceId] = UIBuildRaiseFishModel:New(self._transform, id, fishInstanceId)
end

function HomeBuilding:RemoveWishingFish(fishInstanceId)
  if self._wishingFishs[fishInstanceId] then
    self._wishingFishs[fishInstanceId]:Destroy()
    self._wishingFishs[fishInstanceId] = nil
  end
end

function HomeBuilding:RefreshWishingFish()
  if self._wishingFishs then
    for k, v in pairs(self._wishingFishs) do
      v:Destroy()
    end
  end
  self._wishingFishs = {}
  local raiseFishs = self._homelandClient:IsVisit() and HomelandVisitHelper.GetRaiseFishList() or HomelandWishingConst.GetRaiseFishList()
  for i = 1, #raiseFishs do
    local raiseFish = raiseFishs[i]
    self._wishingFishs[raiseFish.InstanceId] = UIBuildRaiseFishModel:New(self._transform, raiseFish.ID, raiseFish.InstanceId)
  end
end

function HomeBuilding:InitCoin()
  if self._addCoinCallback == nil then
    self._addCoinCallback = GameHelper:GetInstance():CreateCallback(self.AddCoin, self)
    GameGlobal.EventDispatcher():AddCallbackListener(GameEventType.WishingAddCollectCoin, self._addCoinCallback)
  end
  local root = self._transform:Find("CoinRoot")
  self._coinTrans = {}
  if not root then
    return
  end
  for i = 0, root.childCount - 1 do
    self._coinTrans[#self._coinTrans + 1] = root:GetChild(i)
  end
  self._coinObjs = {}
  self._currentCoinIndex = 1
  local coins = HomelandWishingConst.GetCollectedCoins()
  for i = 1, #coins do
    self:AddCoin(coins[i])
  end
end

function HomeBuilding:AddCoin(coinId)
  if self._currentCoinIndex > #self._coinTrans then
    Log.error("位置不足")
    return
  end
  local coinCfg = Cfg.cfg_item_wishing_coin[coinId]
  local prefabName = coinCfg.Model .. ".prefab"
  local req = ResourceManager:GetInstance():SyncLoadAsset(prefabName, LoadType.GameObject)
  if not req then
    BuildError("找不到硬币:" .. prefabName)
    return
  end
  local parent = self._coinTrans[self._currentCoinIndex]
  self._currentCoinIndex = self._currentCoinIndex + 1
  self._coinObjs[#self._coinObjs + 1] = req
  req.Obj:SetActive(true)
  local tran = req.Obj.transform
  tran:SetParent(parent)
  tran.localPosition = Vector3(0, 0, 0)
  tran.localRotation = Quaternion.identity
end

function HomeBuilding:InitArrow()
  local arrow = self._transform:Find("Arrow")
  if not arrow then
    return
  end
  self._arrowParent = arrow
  self._arrows = {}
  for i = 0, arrow.childCount - 1 do
    local child = arrow:GetChild(i)
    self._arrows[i + 1] = child
    child.gameObject.layer = HomeBuildLayer.Arrow
  end
end

function HomeBuilding:GetSize()
  return self._size
end

function HomeBuilding:Dispose()
  if self.Parent then
    self.Parent:RemoveChild(self)
  end
  self:ShowBuilding(false)
  self:ClearWishing()
  self:RemoveEvents()
  self:ResetInteractPoint()
  self:_DestroyView()
  self._go = nil
  self._transform = nil
  self._architecture = nil
  self._areaMRs = nil
  self._coinObjs = nil
  table.clear(self._interactObjects)
  if self._switchAnimationTask then
    GameGlobal.TaskManager():KillTask(self._switchAnimationTask)
    self._switchAnimationTask = nil
  end
  self:ClearLinkPointObj()
end

function HomeBuilding:GetCfg()
  return self._cfg
end

function HomeBuilding:GetArchitecture()
  return self._architecture
end

function HomeBuilding:GetParentAssetID()
  return self._parent
end

function HomeBuilding:SetParentAssetID(assetID)
  self._parent = assetID
end

function HomeBuilding:InsID()
  return self._insID
end

function HomeBuilding:Pos()
  return self._pos
end

function HomeBuilding:RotY()
  return math.floor(self._rotY)
end

function HomeBuilding:SkinID()
  return self._skinID
end

function HomeBuilding:Transform()
  return self._transform
end

function HomeBuilding:SetPos(pos)
  self._pos = pos
  self._transform.position = pos
  self:UpdateAABB()
end

function HomeBuilding:UpdatePos()
  self._pos = self._transform.position
end

function HomeBuilding:SetRotY(y)
  self._rotY = y
  self._transform.eulerAngles = Vector3(0, y, 0)
  self:UpdateAABB()
end

function HomeBuilding:UpdateRotY()
  self._rotY = self._transform.eulerAngles.y
end

function HomeBuilding:ShowBuilding(show)
  self._go:SetActive(show)
  self._active = show
  if self.Parent ~= nil then
    self.Parent:FlushFixedReplaceNode()
  end
  if show then
    self:RefreshMinimapIcon()
  else
    self:DeleteMinimapIcon()
  end
end

function HomeBuilding:Delete()
  self:HideOutline()
  self:ShowArea(false)
  self:ShowBuilding(false)
end

function HomeBuilding:Active(active)
  self._go:SetActive(active)
  self:ShowEffectGo(active)
end

function HomeBuilding:RefreshMinimapIcon()
  local type2Icon = {
    [ArchitectureSubType.Museum] = HomelandMapIconType.CommonBuild,
    [ArchitectureSubType.Wishing_Pool] = HomelandMapIconType.CommonBuild,
    [ArchitectureSubType.Storage_Box] = HomelandMapIconType.StorageBox,
    [ArchitectureSubType.White_Tower] = HomelandMapIconType.WhiteTower,
    [ArchitectureSubType.Land] = HomelandMapIconType.BreedLand,
    [ArchitectureSubType.Shop] = HomelandMapIconType.Shop,
    [ArchitectureSubType.Dormitory] = HomelandMapIconType.Domitory,
    [ArchitectureSubType.Album] = HomelandMapIconType.CommonBuild,
    [ArchitectureSubType.Medal_Wall] = HomelandMapIconType.CommonBuild
  }
  local iconType = type2Icon[self._cfg.SubType]
  if iconType then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.MinimapRemoveIcon, iconType, self._insID)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.MinimapAddIcon, iconType, self._insID, self._transform, self)
  end
end

function HomeBuilding:DeleteMinimapIcon()
  local type2Icon = {
    [ArchitectureSubType.Museum] = HomelandMapIconType.CommonBuild,
    [ArchitectureSubType.Wishing_Pool] = HomelandMapIconType.CommonBuild,
    [ArchitectureSubType.Storage_Box] = HomelandMapIconType.StorageBox,
    [ArchitectureSubType.White_Tower] = HomelandMapIconType.WhiteTower,
    [ArchitectureSubType.Land] = HomelandMapIconType.BreedLand,
    [ArchitectureSubType.Shop] = HomelandMapIconType.Shop,
    [ArchitectureSubType.Dormitory] = HomelandMapIconType.Domitory,
    [ArchitectureSubType.Album] = HomelandMapIconType.CommonBuild,
    [ArchitectureSubType.Medal_Wall] = HomelandMapIconType.CommonBuild
  }
  local iconType = type2Icon[self._cfg.SubType]
  if iconType then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.MinimapRemoveIcon, iconType, self._insID)
  end
end

function HomeBuilding:SetMeshVisible(status)
  for i = 0, self._transform.childCount - 1 do
    local child = self._transform:GetChild(i)
    child.gameObject:SetActive(status)
  end
end

function HomeBuilding:IsDelete()
  return not self._active
end

function HomeBuilding:UpdateAABB()
  self._points = {}
  if not self:IsDefaultBuilding() then
    local angle = self:RotY()
    for i, colli in ipairs(self._colliders) do
      local p1, p2, p3, p4 = BuildHelper.GetColliderPoints(colli, self._transform.position, angle)
      self._points[#self._points + 1] = p1
      self._points[#self._points + 1] = p2
      self._points[#self._points + 1] = p3
      self._points[#self._points + 1] = p4
      self._sides[i][1]:Reset(p1, p2, angle + 0)
      self._sides[i][2]:Reset(p2, p3, angle + 90)
      self._sides[i][3]:Reset(p3, p4, angle + 180)
      self._sides[i][4]:Reset(p4, p1, angle + 270)
    end
    self._aabb:OnChange(self._points)
  end
  local stepLength = 3
  self._extendPoints = {}
  if #self._points == 4 then
    self:UpdateExtendAABB(self._points[1], self._points[4], stepLength)
    self:UpdateExtendAABB(self._points[1], self._points[2], stepLength)
    self:UpdateExtendAABB(self._points[2], self._points[3], stepLength)
    self:UpdateExtendAABB(self._points[3], self._points[4], stepLength)
  end
end

function HomeBuilding:UpdateExtendAABB(pt1, pt2, stepLength)
  local segmentLength = Vector2.Distance(pt1, pt2)
  if stepLength >= segmentLength then
    return
  end
  local splitCount = math.ceil(segmentLength / stepLength)
  for i = 1, splitCount - 1 do
    local dt = i / splitCount
    local pt = pt1 + (pt2 - pt1) * dt
    table.insert(self._extendPoints, pt)
  end
end

function HomeBuilding:GetServerData()
  local arch
  local isNew = false
  local isDelete = false
  if self._active then
    local data = Architecture:New()
    data.asset_id = self:GetBuildId()
    if self._isFreePos then
      data.pos_x = self._architecture.pos_x
      data.pos_z = self._architecture.pos_z
      data.rot = self._architecture.rot
    else
      data.pos_x = BuildHelper.ToInt(self._pos.x)
      data.pos_z = BuildHelper.ToInt(self._pos.z)
      data.rot = self:RotY()
    end
    local parent = self:GetParentAssetID()
    if parent ~= 0 then
      data.parent = parent
      data.pos_y = BuildHelper.ToInt(self._pos.y)
    end
    data.pstid = self._architecture.pstid
    data.skin = self._skinID
    if data.pos_x ~= self._architecture.pos_x or data.pos_z ~= self._architecture.pos_z or data.rot ~= self._architecture.rot or data.pstid == 0 or data.skin ~= self._architecture.skin or data.parent ~= self._architecture.parent or data.parent ~= 0 and data.pos_y ~= self._architecture.pos_y then
      arch = data
    end
    isNew = data.pstid == 0
    isDelete = false
  else
    isNew = self._architecture.pstid == 0
    isDelete = true
  end
  return arch, isNew, isDelete
end

function HomeBuilding:CanShowArea()
  if self.Parent == nil then
    return true
  end
  return not self:IsFixedChild()
end

function HomeBuilding:ShowArea(show, illegal)
  if not self:CanShowArea() then
    return
  end
  if show then
    if not self._areaReqs then
      self._areaReqs = {}
      self._areaMRs = {}
      for i, collider in ipairs(self._colliders) do
        local req = ResourceManager:GetInstance():SyncLoadAsset("HomeBuildingArea.prefab", LoadType.GameObject)
        local go = req.Obj
        local tr = go.transform
        tr:SetParent(self._transform)
        tr.localPosition = Vector3(collider.center.x, 0, collider.center.z)
        tr.localRotation = Quaternion.identity
        tr.localScale = Vector3(collider.size.x, 1, collider.size.z)
        local mr = go:GetComponentInChildren(typeof(UnityEngine.MeshRenderer))
        self._areaReqs[i] = req
        self._areaMRs[i] = mr
      end
    end
    for i, mr in ipairs(self._areaMRs) do
      if illegal then
        mr.material.color = Color(0.23137254901960785, 0.23137254901960785, 0.7254901960784313, 0.20392156862745098)
      else
        mr.material.color = Color(0.8, 0.17647058823529413, 0.17647058823529413, 0.20392156862745098)
      end
      self._areaReqs[i].Obj:SetActive(true)
    end
  elseif self._areaReqs then
    for _, req in ipairs(self._areaReqs) do
      req.Obj:SetActive(false)
    end
  end
end

function HomeBuilding:GetPoints()
  return self._points
end

function HomeBuilding:GetExtendPoints()
  return self._extendPoints
end

function HomeBuilding:GetColliders()
  return self._colliders
end

function HomeBuilding:IsNewAdd()
  return self._architecture.pstid == 0
end

function HomeBuilding:GetSides()
  return self._sides
end

function HomeBuilding:MaxDiagonal()
  return self._aabb:DiagonalLength()
end

function HomeBuilding:ShowArrow(arrowList)
  if not self._arrowParent then
    return
  end
  if not arrowList then
    self._arrowParent.gameObject:SetActive(false)
    return
  end
  self._arrowParent.gameObject:SetActive(true)
  for k, v in pairs(self._arrows) do
    v.gameObject:SetActive(arrowList[k] == true)
  end
end

function HomeBuilding:HaveArrow()
  return self._arrowParent ~= nil
end

function HomeBuilding:CanMove()
  if self._cfg == nil then
    return false
  end
  if self:IsFixedChild() then
    return false
  end
  return self._cfg.CanMove
end

function HomeBuilding:CanRotate()
  if self._cfg == nil then
    return false
  end
  if self:IsFixedChild() then
    return false
  end
  return true
end

function HomeBuilding:InteractPointOccupyRange()
  if self._cfg and self._cfg.InteractPointOccupyRange then
    return self._cfg.InteractPointOccupyRange
  else
    return 0
  end
end

function HomeBuilding:PlayInteractEffect(name, holder)
  if not name then
    return
  end
  local bone = self:GetBoneNode(holder)
  local req = ResourceManager:GetInstance():SyncLoadAsset(name .. ".prefab", LoadType.GameObject)
  if req then
    local effect = req.Obj
    effect:SetActive(true)
    effect.transform:SetParent(bone)
    effect.transform.localPosition = Vector3.zero
    effect.transform.localRotation = Quaternion.Euler(0, 0, 0)
    table.insert(self._interactEffectReq, req)
    table.insert(self._interactEffectObj, req.Obj)
  end
end

function HomeBuilding:StopInteractEffect()
  if self._interactEffectReq then
    for _, _req in pairs(self._interactEffectReq) do
      _req:Dispose()
    end
    table.clear(self._interactEffectReq)
    table.clear(self._interactEffectObj)
  end
end

function HomeBuilding:SetInteractVisible(visible)
  self._interactVisible = visible
  if self._interactEffectObj then
    for _, gameObject in pairs(self._interactEffectObj) do
      gameObject:SetActive(self._interactVisible)
    end
  end
  for _, animationState in pairs(self._animationStates) do
    if animationState then
      if self._interactVisible then
        if animationState.name == self._curAnimationName and not self._animation.isPlaying then
          self._animation:Play(self._curAnimationName)
        end
        animationState.speed = 1
      else
        animationState.speed = 0
      end
    end
  end
end

function HomeBuilding:PlayAnimation(name, petID, interactAnimationType)
  if not name or not self._animation then
    return
  end
  self:_HandleInteractAnim(petID)
  self._animation:Play(name)
  self._curAnimationName = name
  if not self._firstAnimationName then
    self._firstAnimationName = name
  end
  self._homelandInteractAnimationType = interactAnimationType
  self._animationStates[name] = self._animation:get_Item(name)
  if self._animationStates[name] then
    if self._interactVisible then
      self._animationStates[name].speed = 1
    else
      self._animationStates[name].speed = 0
    end
  end
end

function HomeBuilding:GetCurAnimationState()
  return self._curAnimationName and self._animation:get_Item(self._curAnimationName)
end

function HomeBuilding:GetCurAnimationType()
  return self._homelandInteractAnimationType
end

function HomeBuilding:StopAnimation(id)
  if self._animation and #self._interactObjects <= 0 then
    self._animation:Stop()
    self._curAnimationName = nil
    self._firstAnimationName = nil
    self._interactVisible = true
    for _, animationState in pairs(self._animationStates) do
      if animationState and not tolua.isnull(animationState) then
        animationState.speed = 1
      end
    end
    table.clear(self._animationStates)
  end
end

function HomeBuilding:SetAnimTime(anim, normalizedTime)
  if self._animation then
    local animState = self._animation:get_Item(anim)
    if animState then
      self._animation:Play(anim)
      self._animation:Rewind()
      animState.normalizedTime = normalizedTime
      self._animation:Sample()
    end
  end
end

function HomeBuilding:TryStopAnimation()
  if not self._interactObjects[1] then
    if self._firstAnimationName then
      self:SetAnimTime(self._firstAnimationName, 0)
    end
    self:StopInteractEffect()
    self:StopAnimation()
  end
end

function HomeBuilding:GetBoneNode(name)
  return GameObjectHelper.FindChild(self._transform, name) or self._transform
end

function HomeBuilding:GetBoneNodeNoRoot(name)
  return GameObjectHelper.FindChild(self._transform, name)
end

function HomeBuilding:ShowOutline()
  if self._outline == nil then
    local meshroot = GameObjectHelper.FindChild(self._transform, "meshroot")
    self._outline = nil
    if meshroot then
      self._outline = meshroot.gameObject:AddComponent(typeof(OutlineComponent))
    else
      BuildError("建筑没有meshroot节点:" .. self._go.name)
      self._outline = self._go:AddComponent(typeof(OutlineComponent))
    end
    self._outline.downSample = 1
    self._outline.blurNum = 3
    self._outline.outlinColor = Color(0.23921568627450981, 0.5882352941176471, 1.0, 1)
    self._outline.intensity = 3.5
    self._outline.outlineSize = 1.93
    self._outline.blendType = OutlineComponent.BlendType.Blend
  end
  self._outline.enabled = true
end

function HomeBuilding:SetOutlineColor(color)
  self._outline.outlinColor = color
end

function HomeBuilding:HideOutline()
  if self._outline then
    self._outline.enabled = false
  end
end

function HomeBuilding:RevertSkin(skinID)
  self:ChangeSkin(skinID)
end

function HomeBuilding:ChangeSkin(skinID)
  if self._skinID == skinID then
    return
  end
  self._skinID = skinID
  self._prefabName = self._skinID .. ".prefab"
  self._go:SetActive(false)
  self:_DestroyView()
  self._req = ResourceManager:GetInstance():SyncLoadAsset(self._prefabName, LoadType.GameObject)
  self._go = self._req.Obj
  self:OnModelChanged()
  self._go:SetActive(true)
  self._active = true
  self:RefreshMinimapIcon()
end

function HomeBuilding:PstID()
  return self._architecture.pstid
end

function HomeBuilding:LocateLayer()
  return self._locateLayer
end

function HomeBuilding:ChangeSkinFocusPoint()
  return self._changeSkinFocusPoint
end

function HomeBuilding:InitNpc()
  if self._homelandClient:IsVisit() and self:IsShabby() then
    return
  end
  if not self._transform then
    return
  end
  local npcParent = self._transform:Find("npc")
  if not npcParent then
    return
  end
  local npcRoot = npcParent:GetChild(0)
  if npcRoot then
    self._npcRes = ResourceManager:GetInstance():SyncLoadAsset(npcRoot.name .. ".prefab", LoadType.GameObject)
    self._npcGO = self._npcRes.Obj
    self._npcGO.transform:SetParent(npcRoot, false)
    self._npcGO:SetActive(not self._isLock)
    self._homelandClient:CharacterManager():RegisterNpc(self._npcGO)
    if self._buildType == ArchitectureSubType.White_Tower then
      local rootBoard = self._npcGO.transform:Find("NameRoot")
      self._nameBoardGO = self._homelandClient:Home3DUIManager():AddNameBoard(rootBoard, "N17_base_npc_tower", "str_homeland_npc_white_tower")
      if not self._homelandClient:IsVisit() then
        self._interactGO = self._homelandClient:Home3DUIManager():AddInteractBoard(rootBoard)
        self._homelandClient:BuildManager():RefreshWhiteTowerHeadBoard()
      end
    elseif self._buildType == ArchitectureSubType.Museum then
      self._homelandClient:Home3DUIManager():AddNameBoard(self._npcGO.transform:Find("NameRoot"), "N17_base_npc_museum", "str_homeland_npc_museum")
    elseif self._buildType == ArchitectureSubType.Shop then
      self._homelandClient:Home3DUIManager():AddNameBoard(self._npcGO.transform:Find("NameRoot"), "N17_base_npc_shop", "str_homeland_npc_shop")
    end
  end
end

function HomeBuilding:ShowInteractBoard(inShow)
  if self._nameBoardGO == nil or self._interactGO == nil then
    return
  end
  if self._nameBoardGO.activeSelf ~= not inShow then
    self._nameBoardGO:SetActive(not inShow)
  end
  if self._interactGO.activeSelf ~= inShow then
    self._interactGO:SetActive(inShow)
  end
end

function HomeBuilding:NpcTurn()
  if not self._npcGO then
    return
  end
  local charPos = self._homelandClient:CharacterManager():MainCharacterController():Position()
  local toward = charPos - self._npcGO.transform.position
  toward.y = 0
  self._npcGO.transform.forward = toward
end

function HomeBuilding:OnInteract(interactType)
  if self._buildType == ArchitectureSubType.White_Tower then
    self:NpcTurn()
  elseif self._buildType == ArchitectureSubType.Museum then
    self:NpcTurn()
  elseif self._buildType == ArchitectureSubType.Shop then
    self:NpcTurn()
  end
end

function HomeBuilding:SetShowDeleteBtn(show)
  self._showDeleteBtn = show
end

function HomeBuilding:ShowDeleteBtn()
  return self._showDeleteBtn
end

function HomeBuilding:IsShabby()
  return self._architecture.status == ArchitectureStatus.AS_Shabby
end

function HomeBuilding:IsDefaultBuilding()
  return self._isFreePos
end

function HomeBuilding:GetName()
  return self._buildingName
end

function HomeBuilding:_DestroyView()
  if self._npcRes then
    self._homelandClient:CharacterManager():UnRegisterNpc(self._npcGO)
    self._npcGO = nil
    self._npcRes:Dispose()
    self._npcRes = nil
  end
  if self._interatAnimReq then
    self._interatAnimReq:Dispose()
    self._interatAnimReq = nil
    self._withPet = nil
  end
  self._outline = nil
  if self._areaReqs then
    for _, req in ipairs(self._areaReqs) do
      req:Dispose()
    end
    self._areaReqs = nil
  end
  if self._req then
    if Cfg.cfg_homeland_building_water_depth[self:GetBuildId()] then
      self._homelandClient:SceneManager():RemoveWaterDepthTarget(self._go)
    end
    self._req:Dispose()
    self._req = nil
  end
  self:ClearLinkPointObj()
end

function HomeBuilding:Unlock()
  self._isLock = false
  if self._npcGO then
    self._npcGO:SetActive(true)
  end
  self:RefreshInteractPoint()
end

function HomeBuilding:_HandleInteractAnim(petID)
  if petID and self._withPet ~= petID then
    if self._interatAnimReq then
      local anim = self._interatAnimReq.Obj:GetComponent(typeof(UnityEngine.Animation))
      HelperProxy:GetInstance():RemoveAnimTo(anim, self._animation)
      self._interatAnimReq:Dispose()
      self._interatAnimReq = nil
    end
    local name = self:GetBuildId() .. "_" .. petID .. ".prefab"
    local req = ResourceManager:GetInstance():SyncLoadAsset(name, LoadType.GameObject)
    if req then
      if self._interatAnimReq then
        self._interatAnimReq:Dispose()
      end
      local anim = req.Obj:GetComponent(typeof(UnityEngine.Animation))
      HelperProxy:GetInstance():AddAnimTo(anim, self._animation)
      self._interatAnimReq = req
      self._withPet = petID
    else
      Log.fatal("找不到建筑与星灵对应的动作资源:", name)
    end
  end
end

function HomeBuilding:GetInteractingPetList()
  return self._interactingPetList
end

function HomeBuilding:AddInteractingPet(pet)
  table.insert(self._interactingPetList, pet)
end

function HomeBuilding:RemoveInteractingPet(pet)
  table.removev(self._interactingPetList, pet)
end

function HomeBuilding:GetInteractingPetCount()
  return table.count(self._interactingPetList)
end

function HomeBuilding:InitInteractingPetCountMax()
  self._interactingPetCountMax = 0
  local interact = self._transform:Find("Interact")
  for i = 0, interact.childCount - 1 do
    local child = interact:GetChild(i)
    if string.find(child.name, "pet_interact") then
      self._interactingPetCountMax = self._interactingPetCountMax + 1
    end
  end
  if self._interactingPetCountMax == 0 then
    self._interactingPetCountMax = 1
  end
end

function HomeBuilding:GetInteractingPetCountMax()
  if not self._interactingPetCountMax then
    self:InitInteractingPetCountMax()
  end
  return self._interactingPetCountMax
end

function HomeBuilding:Interactable()
  if self._cfg and self._cfg.SingleInteract then
    return self._interactObjects[1] == nil
  end
  return true
end

function HomeBuilding:IsFirstInteractObject(id)
  return self._interactObjects[1] and self._interactObjects[1].id == id
end

function HomeBuilding:IsLastInteractObject(id)
  local length = #self._interactObjects
  if length == 1 then
    return self._interactObjects[length] and self._interactObjects[length].id == id
  end
  return false
end

function HomeBuilding:AddInteractObject(id, animationName)
  for _, value in pairs(self._interactObjects) do
    if value.id == id then
      return
    end
  end
  local t = {}
  t.id = id
  t.animationName = animationName
  table.insert(self._interactObjects, t)
end

function HomeBuilding:UpdateInteractObject(id, animationName)
  for _, value in pairs(self._interactObjects) do
    if value.id == id then
      value.animationName = animationName
    end
  end
end

function HomeBuilding:RemoveInteractObject(id)
  if not id then
    return
  end
  local isFirst = false
  local removeSuccess = false
  for key, value in pairs(self._interactObjects) do
    if value.id == id then
      if key == 1 then
        isFirst = true
      end
      table.remove(self._interactObjects, key)
      removeSuccess = true
      break
    end
  end
  if not self._interactObjects[1] and self._switchAnimationTask then
    GameGlobal.TaskManager():KillTask(self._switchAnimationTask)
    self._switchAnimationTask = nil
  end
  if removeSuccess and isFirst and self._interactObjects[1] then
    self._switchAnimationTask = GameGlobal.TaskManager():StartTask(function(TT)
      if not self._curAnimationName or not self._animation then
        return
      end
      self._homelandInteractAnimationType = HomelandInteractAnimationType.Loop
      local animationState = self._animation:get_Item(self._curAnimationName)
      local offset = 0
      if animationState then
        offset = animationState.time
      end
      self:_HandleInteractAnim(self._interactObjects[1].id)
      YIELD(TT)
      local deltaTime = GameGlobal:GetInstance():GetDeltaTime()
      self._curAnimationName = self._interactObjects[1].animationName
      if self._curAnimationName then
        self._animation:Play(self._curAnimationName)
        self._animationStates[self._curAnimationName] = self._animation:get_Item(self._curAnimationName)
        if self._animationStates[self._curAnimationName] then
          if self._interactVisible then
            self._animationStates[self._curAnimationName].speed = 1
          else
            self._animationStates[self._curAnimationName].speed = 0
          end
        end
      end
      YIELD(TT)
      if self._curAnimationName then
        animationState = self._animation:get_Item(self._curAnimationName)
        if animationState then
          deltaTime = deltaTime + GameGlobal:GetInstance():GetDeltaTime()
          animationState.time = offset + deltaTime * 0.001
        end
      end
    end)
  end
end

function HomeBuilding:IsMultiInteract()
  return #self._interactObjects > 1
end

function HomeBuilding:ContainInteractObject(id)
  for _, value in pairs(self._interactObjects) do
    if value.id == id then
      return true
    end
  end
  return false
end

function HomeBuilding:FindRecursively(findName, trRoot)
  if self ~= nil then
    trRoot = self:Transform()
  end
  if trRoot.name == findName then
    return trRoot
  end
  local trFind = trRoot:Find(findName)
  if trFind ~= nil then
    return trFind
  end
  local childCount = trRoot.childCount
  for i = 0, childCount - 1 do
    local trFind = trRoot:GetChild(i)
    trFind = HomeBuilding.FindRecursively(nil, findName, trFind)
    if trFind ~= nil then
      return trFind
    end
  end
end

function HomeBuilding:StartShakeAnimation(start)
  if self:GetBuildType() ~= ArchitectureSubType.Son_Architecture then
    return
  end
  local sonCfg = Cfg.cfg_item_son_architecture[self:GetBuildId()]
  if not sonCfg.Areas or sonCfg.Areas[1] ~= 52710011 then
    return
  end
  self._trans = self._go.transform:Find("model")
  if start then
    local to = self._moveUp and 0.01 or -0.01
    self._trans:DOLocalMoveY(to, 0.8):OnComplete(function()
      self:_ShakeComplete()
    end)
  else
    self._trans:DOPause()
    self._go.transform = Vector3(0, 0, 0)
  end
end

function HomeBuilding:_ShakeComplete()
  self._moveUp = not self._moveUp
  self:StartShakeAnimation(true)
end

function HomeBuilding:InitLinkPoint()
  self._linkPoint = GameObjectHelper.FindChild(self._transform, "linkpoint")
  self._linkTargets = {}
end

function HomeBuilding:GetLinkPoint()
  return self._linkPoint
end

function HomeBuilding:CheckCanLink()
  if self._linkPoint and self._linkCfg then
    return self._linkCfg.LinkCount > 0
  end
  return false
end

function HomeBuilding:GetLinkCount()
  local count = self._linkCfg and self._linkCfg.LinkCount or 0
  return count
end

function HomeBuilding:GetCheckLinkDistance()
  local distance = self._linkCfg and self._linkCfg.Distance or 10
  return distance
end

function HomeBuilding:GetLinkingCount()
  return #self._holdlinkBuildingList
end

function HomeBuilding:SetLinkPointObj(building)
  if not self:CheckCanLink() then
    return
  end
  table.insert(self._holdlinkBuildingList, building)
end

function HomeBuilding:ShowEffectGo(show)
  if self._effectList and next(self._effectList) then
    for key, value in pairs(self._effectList) do
      value:SetActive(show)
    end
  end
end

function HomeBuilding:SetLinkPointTransform(tar)
  if not self._linkListReq then
    self._linkListReq = {}
  end
  if not self._effectList then
    self._effectList = {}
  end
  local effectReq = ResourceManager:GetInstance():SyncLoadAsset("hl_pfb_5241020_line.prefab", LoadType.GameObject)
  local effectObj = effectReq.Obj
  table.insert(self._linkListReq, effectReq)
  table.insert(self._effectList, effectObj)
  effectObj:SetActive(true)
  self:SetLinkPointObj(tar)
  tar:SetLinkPointObj(self)
  local renderers = effectObj:GetComponentsInChildren(typeof(UnityEngine.LineRenderer), true)
  for i = 0, renderers.Length - 1 do
    renderers[i]:SetPosition(0, self:GetLinkPoint().transform.position)
    renderers[i]:SetPosition(1, tar:GetLinkPoint().transform.position)
  end
end

function HomeBuilding:ClearLinkPointObj()
  self._effectList = {}
  if self._linkListReq then
    for _, req in ipairs(self._linkListReq) do
      req:Dispose()
    end
  end
  self._linkListReq = {}
  self._holdlinkBuildingList = {}
end

function HomeBuilding:IsFreeChild()
  if self.Parent == nil then
    return false
  end
  local freeChild = self.Parent:GetFreeChild(self:InsID())
  return freeChild == self
end

function HomeBuilding:IsFixedChild()
  if self.Parent == nil then
    return false
  end
  if self:GetBuildType() ~= ArchitectureSubType.Son_Architecture then
    return false
  end
  local sonCfg = Cfg.cfg_item_son_architecture[self:GetBuildId()]
  if sonCfg.FatherSlot == nil then
    return false
  end
  local fixedChild = self.Parent:GetFixedChild(sonCfg.FatherSlot)
  return fixedChild == self
end

function HomeBuilding:IsMaxInteractable()
  return #self._interactObjects >= self:GetInteractableCount()
end

function HomeBuilding:GetNpcHangPointTransform(index)
  local tran = self._transform:Find("NpcPath/" .. index .. "/HangPoint")
  if not tran then
    return nil
  end
  return tran
end
