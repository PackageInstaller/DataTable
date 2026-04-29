_class("HomeBuildingFather", HomeBuilding)
HomeBuildingFather = HomeBuildingFather

function HomeBuildingFather:Constructor(insID, architecture, cfg)
  self._cfg = cfg
  self._cfgFatherArch = Cfg.cfg_item_father_architecture[cfg.ID]
  self._children = {}
  self._childrenFree = {}
  self._childrenFixed = {}
  self._fixedReplaceNode = {}
  self._dicFreeArea = {}
  self._dicFreeAreaBlackList = {}
  self._showBuildingArea = nil
  self:InitFixedReplaceNode()
  self:InitFreeArea()
end

function HomeBuildingFather:OnModelChanged()
  self._interactPointAreaMap = {}
  HomeBuildingFather.super.OnModelChanged(self)
end

function HomeBuildingFather:RefreshInteractPoint()
  HomeBuildingFather.super.RefreshInteractPoint(self)
  self._areaList = {}
  self._areaTrans = self._transform:Find("Area")
  local childCount = 0
  if self._areaTrans ~= nil then
    childCount = self._areaTrans.childCount
  end
  for i = 1, childCount do
    table.insert(self._areaList, HomeBuildingFatherArea:New(self._areaTrans:GetChild(i - 1), self))
  end
  for i = 1, #self._areaList do
    self._areaList[i]:RefreshInteractPoint()
    self._areaList[i]:RefreshObstacleUnlock()
  end
end

function HomeBuildingFather:ResetInteractPoint()
  if self._areaList then
    for i = 1, #self._areaList do
      self._areaList[i]:Dispose()
    end
    self._areaList = nil
  end
  HomeBuildingFather.super.ResetInteractPoint(self)
end

function HomeBuildingFather:RegisterInteractPoint(index, HomeBuildingFatherArea)
  self._interactPointAreaMap[index] = HomeBuildingFatherArea
end

function HomeBuildingFather:GetInteractPosition(index)
  local area = self._interactPointAreaMap[index]
  if not area then
    return HomeBuildingFather.super.GetInteractPosition(self, index)
  end
  return area:GetInteractPosition(index)
end

function HomeBuildingFather:Clean(index)
  local cfg = Cfg.cfg_archeticture_hangpoint[index]
  if not cfg then
    BuildError("cfg_archeticture_hangpoint中找不到id为", index, "的配置")
    return
  end
  local area = self._interactPointAreaMap[index]
  if not area then
    BuildError("找不到包含障碍物id为", index, "的区域")
    return
  end
  if cfg.Cost then
    self:CleanConfirm(index, cfg)
  else
    self:CleanEffect(index, cfg.FinishEffectId)
  end
end

function HomeBuildingFather:CleanConfirm(index, cfg)
  local costStr = ""
  for index, costs in ipairs(cfg.Cost) do
    if 1 < index then
      costStr = costStr .. StringTable.Get("str_homeland_build_child_drop_error_seperator")
    end
    costStr = costStr .. StringTable.Get(Cfg.cfg_item[costs[1]].Name) .. "*" .. costs[2]
  end
  local title
  local desc = StringTable.Get("str_homeland_build_clean", costStr)
  local leftBtn = {
    StringTable.Get("str_common_cancel"),
    function(param)
    end
  }
  local rightBtn = {
    StringTable.Get("str_common_ok"),
    function()
      self:CleanEffect(index, cfg.FinishEffectId)
    end
  }
  self:ShowDialog("UIHomelandMessageBox", title, desc, leftBtn, rightBtn, true)
end

function HomeBuildingFather:CleanEffect(hangPointID, FinishEffectId)
  if FinishEffectId then
    GameGlobal.UIStateManager():ShowDialog("UIHomelandTaskFinishEffect", FinishEffectId, nil, self:GetInteractPosition(hangPointID), function()
      GameGlobal.TaskManager():StartTask(self.CleanProc, self, hangPointID)
    end)
  else
    GameGlobal.TaskManager():StartTask(self.CleanProc, self, hangPointID)
  end
end

function HomeBuildingFather:CleanProc(TT, hangPointID)
  local area = self._interactPointAreaMap[hangPointID]
  if not area then
    BuildError("找不到包含障碍物id为", hangPointID, "的区域")
    return
  end
  GameGlobal.UIStateManager():Lock("HomeBuildingFather:Clean")
  local homelandModule = GameGlobal.GetModule(HomelandModule)
  local res = homelandModule:HandleUnlockHangPoint(TT, self:PstID(), hangPointID)
  if res:GetSucc() then
    self:EnableInteractPointByIndex(hangPointID, false)
    area:Clean(hangPointID)
    self:CreateChildBuildingByClean(TT, hangPointID)
    self._homelandClient:SceneManager():BuildNavMeshAsync()
    self:OnHangPointCleaned(hangPointID)
    local uiHomeModule = GameGlobal.GetUIModule(HomelandModule)
    self._client = uiHomeModule:GetClient()
    self._client:SceneManager():WaterDepthCmdUpdateAllRender()
  else
    BuildError("清理失败 错误码：", res:GetResult())
  end
  GameGlobal.UIStateManager():UnLock("HomeBuildingFather:Clean")
end

function HomeBuildingFather:OnHangPointCleaned(hangPointID)
end

function HomeBuildingFather:CreateChildBuildingByClean(TT, pointID)
  local area = self._interactPointAreaMap[pointID]
  if not area then
    BuildError("找不到包含障碍物id为", pointID, "的区域")
    return
  end
  local newAdd = {}
  local buildingList = {}
  local idTransListMap = area:GetHangPointChildBuilingNodes(pointID)
  for id, transList in pairs(idTransListMap) do
    local canBuildCount = self._homelandClient:BuildManager():GetBuildCount(id)
    if 0 < canBuildCount then
      local buildCount = #transList
      if canBuildCount < buildCount then
        buildCount = canBuildCount
        BuildError("解锁后所持默认子建筑" .. id .. "数量不足，无法全部自动摆放")
      end
      for i = 1, buildCount do
        local trans = transList[i]
        local pos = trans.position
        local data = Architecture:New()
        data.asset_id = id
        data.parent = self:GetBuildId()
        data.pos_x = BuildHelper.ToInt(pos.x)
        data.pos_y = BuildHelper.ToInt(pos.y)
        data.pos_z = BuildHelper.ToInt(pos.z)
        data.rot = math.floor(trans.eulerAngles.y)
        data.pstid = 0
        local building = BuildHelper.CreateBuilding(data)
        self:AddChild(building)
        buildingList[#buildingList + 1] = building
        newAdd[#newAdd + 1] = building:GetServerData()
      end
    end
  end
  if 0 < #newAdd then
    local res, resAddList = GameGlobal.GetModule(HomelandModule):HomelandBuild(TT, newAdd, {}, {})
    if res:GetSucc() then
      for i = 1, #buildingList do
        self._homelandClient:BuildManager():AfterCreateChildBuilding(buildingList[i])
        local serverData = buildingList[i]:GetArchitecture()
        for _, arch in ipairs(resAddList) do
          if serverData.asset_id == arch.asset_id and serverData.pos_x == arch.pos_x and serverData.pos_y == arch.pos_y and serverData.pos_z == arch.pos_z then
            serverData.pstid = arch.pstid
          end
        end
      end
    else
      local code = res:GetResult()
      if code == HomeLandErrorType.E_CONFIG_ERROR or code >= HomeLandErrorType.E_SCENE_NOT_ARCHITECTURE and code <= HomeLandErrorType.E_BUILD_MAX_LIMIT then
        ToastManager.ShowHomeToast(StringTable.Get("str_homeland_build_error" .. code))
      else
        ToastManager.ShowHomeToast(StringTable.Get("str_homeland_build_unknownerror", code))
      end
    end
  end
end

function HomeBuildingFather:HasArea(areaTrans)
  for i = 1, #self._areaList do
    if self._areaList[i]._trans == areaTrans then
      return true
    end
  end
  return false
end

function HomeBuildingFather:GetArea(areaTrans)
  for i = 1, #self._areaList do
    if self._areaList[i]._trans == areaTrans then
      return self._areaList[i]:GetHomeArea()
    end
  end
end

function HomeBuildingFather:GetHangPointPosByID(hangPointID)
  local area = self._interactPointAreaMap[hangPointID]
  if not area then
    BuildError("找不到包含障碍物id为", hangPointID, "的区域")
    return
  end
  return area:GetInteractPosition(hangPointID)
end

function HomeBuildingFather:GetObstacles()
  local obstacles = {}
  for i = 1, #self._areaList do
    local areaObs = self._areaList[i]:GetObstacles()
    for _, ob in ipairs(areaObs) do
      obstacles[#obstacles + 1] = ob
    end
  end
  return obstacles
end

function HomeBuildingFather:IsAreaCleaned(areaID)
  for i = 1, #self._areaList do
    local area = self._areaList[i]
    if area:GetID() == areaID then
      return area:IsAllCleaned()
    end
  end
  return false
end

function HomeBuildingFather:AddChild(building)
  self._children[building:InsID()] = building
  building.Parent = self
  building:SetParentAssetID(self:GetBuildId())
  building._transform:SetParent(self._transform, true)
  local sonCfg = Cfg.cfg_item_son_architecture[building:GetBuildId()]
  if sonCfg == nil then
    self._childrenFree[building:InsID()] = building
  else
    if sonCfg.FatherSlot ~= nil then
      self._childrenFixed[sonCfg.FatherSlot] = building
    else
    end
  end
  self:FlushFixedReplaceNode()
end

function HomeBuildingFather:RemoveChild(building)
  if building == nil then
    return
  end
  local sonCfg = Cfg.cfg_item_son_architecture[building:GetBuildId()]
  if sonCfg == nil then
    self._childrenFree[building:InsID()] = nil
  else
    if sonCfg.FatherSlot ~= nil then
      local fixedChild = self._childrenFixed[sonCfg.FatherSlot]
      if fixedChild == building then
        self._childrenFixed[sonCfg.FatherSlot] = nil
      end
    else
    end
  end
  self._children[building:InsID()] = nil
  building.Parent = nil
  building:SetParentAssetID(0)
  building._transform:SetParent(self._homelandClient:SceneManager():BuildingRootTrans(), true)
  self:FlushFixedReplaceNode()
end

function HomeBuildingFather:SetPos(pos)
  HomeBuildingFather.super.SetPos(self, pos)
  for _, childBuilding in pairs(self._children) do
    childBuilding:UpdatePos()
    childBuilding:UpdateAABB()
  end
end

function HomeBuildingFather:SetRotY(y)
  HomeBuildingFather.super.SetRotY(self, y)
  for _, childBuilding in pairs(self._children) do
    childBuilding:UpdatePos()
    childBuilding:UpdateRotY()
    childBuilding:UpdateAABB()
  end
end

function HomeBuildingFather:Delete()
  HomeBuildingFather.super.Delete(self)
  for _, childBuilding in pairs(self._children) do
    childBuilding:Delete()
  end
end

function HomeBuildingFather:ShowBuilding(show)
  self._go:SetActive(show)
  self._active = show
end

function HomeBuildingFather:CheckInArea(areaID, building)
  for i = 1, #self._areaList do
    if self._areaList[i]:GetID() == areaID then
      local area = self._areaList[i]:GetHomeArea()
      local points = building:GetPoints()
      for _, point in ipairs(points) do
        if not area:Contains(point) then
          return false
        end
      end
      return true
    end
  end
end

function HomeBuildingFather:InitFixedReplaceNode()
  local slotsCount = 0
  local fatherFixedSlots = self._cfgFatherArch.FixedSlots
  if fatherFixedSlots ~= nil then
    slotsCount = #fatherFixedSlots
  end
  local cfg_fixed_positions = Cfg.cfg_homeland_building_fixed_position({})
  for i = 1, slotsCount do
    local fatherSlot = fatherFixedSlots[i]
    local cfg_fixed_position = cfg_fixed_positions[fatherSlot]
    local replaceNode
    if cfg_fixed_position ~= nil then
      replaceNode = cfg_fixed_position.ReplaceNode
    end
    if replaceNode ~= nil then
      local replacedTransform = self:FindRecursively(replaceNode)
      self._fixedReplaceNode[fatherSlot] = replacedTransform
    end
  end
end

function HomeBuildingFather:FlushFixedReplaceNode()
  for k, v in pairs(self._fixedReplaceNode) do
    local fixedBuilding = self._childrenFixed[k]
    local isVisible = false
    if fixedBuilding == nil then
      isVisible = true
    elseif fixedBuilding:IsDelete() then
      isVisible = true
    end
    v.gameObject:SetActive(isVisible)
  end
end

function HomeBuildingFather:GetAllChildren()
  return self._children
end

function HomeBuildingFather:GetChild(insId)
  return self._children[insId]
end

function HomeBuildingFather:GetAllFreeChildren()
  return self._childrenFree
end

function HomeBuildingFather:GetFreeChild(insId)
  return self._childrenFree[insId]
end

function HomeBuildingFather:GetFixedChild(slotId)
  return self._childrenFixed[slotId]
end

function HomeBuildingFather:InitFreeArea()
  local count = 0
  local cfgFreeArea = self._cfgFatherArch.FreeArea
  local cfgFreeAreaBlackList = self._cfgFatherArch.FreeAreaBlackList
  if cfgFreeArea ~= nil then
    count = #cfgFreeArea
  else
    count = 0
  end
  for i = 1, count do
    local id = cfgFreeArea[i]
    self._dicFreeArea[id] = id
  end
  if cfgFreeAreaBlackList ~= nil then
    count = #cfgFreeAreaBlackList
  else
    count = 0
  end
  for i = 1, count do
    local id = cfgFreeAreaBlackList[i]
    self._dicFreeAreaBlackList[id] = id
  end
end

function HomeBuildingFather:IsFreeArea(areaID)
  return self._dicFreeArea[areaID] == areaID
end

function HomeBuildingFather:GetAllFreeArea()
  return self._dicFreeArea
end

function HomeBuildingFather:InFreeAreaBlackList(buildingId)
  return self._dicFreeAreaBlackList[buildingId] == buildingId
end

function HomeBuildingFather:ShowBuildingArea(areaId, isShow, showMindMesh)
  if self._showBuildingArea ~= nil then
    local homeArea = self._showBuildingArea:GetHomeArea()
    homeArea:ShowArea(false)
  end
  self._showBuildingArea = nil
  for k, v in pairs(self._areaList) do
    if v:GetID() == areaId then
      self._showBuildingArea = v
      break
    end
  end
  if self._showBuildingArea ~= nil then
    local homeArea = self._showBuildingArea:GetHomeArea()
    homeArea:ShowArea(isShow)
  end
  if not isShow then
    self._showBuildingArea = nil
  end
end

function HomeBuildingFather:IsShowBuildingArea(areaId)
  if self._showBuildingArea == nil then
    return false
  end
  return self._showBuildingArea:GetID() == areaId
end

function HomeBuildingFather:ShowMovieFreeAreaEffect(bShow)
  if not self.movieFreeObj then
    self.movieFreeObj = GameObjectHelper.FindChild(self._transform, "52710031-2")
  end
  if self.movieFreeObj then
    self.movieFreeObj.gameObject:SetActive(bShow)
  end
end

function HomeBuildingFather:GetPrepareMovieSceneFocusPoint()
  if not self._movieCamera01 then
    self._movieCamera01 = GameObjectHelper.FindChild(self._transform, "MovieCamera01")
  end
  return self._movieCamera01
end

function HomeBuildingFather:GetPrepareMoviePropFocusPoint()
  if not self._movieCamera02 then
    self._movieCamera02 = GameObjectHelper.FindChild(self._transform, "MovieCamera02")
  end
  return self._movieCamera02
end

function HomeBuildingFather:GetPrepareMovieActorFocusPoint()
  if not self._movieCamera03 then
    self._movieCamera03 = GameObjectHelper.FindChild(self._transform, "MovieCamera03")
  end
  return self._movieCamera03
end

function HomeBuildingFather:GetPrepareMovieResultFocusPoint()
  if not self._endCamera then
    self._endCamera = GameObjectHelper.FindChild(self._transform, "EndingCamera")
  end
  return self._endCamera
end
