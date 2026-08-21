_class("MovieFatherSon", Object)
MovieFatherSon = MovieFatherSon

function MovieFatherSon:Constructor()
end

function MovieFatherSon:Dispose()
  self.testID = 1
  self.homeBuildManager = nil
end

function MovieFatherSon:GetBuildManager()
  if self.homeBuildManager == nil then
    self.mHomeland = GameGlobal.GetModule(HomelandModule)
    self.mUIHomeland = self.mHomeland:GetUIModule()
    self.homelandClient = self.mUIHomeland:GetClient()
    self.homeBuildManager = self.homelandClient:BuildManager()
  end
  return self.homeBuildManager
end

function MovieFatherSon:TestFn()
  local buildMgr = self:GetBuildManager()
  local fatherBuilding = buildMgr:FindBuildingByCfgID(5271001)
  if self.testID == nil then
    self.testID = 1
  end
  if self.testID == 1 then
    self.dataList = self:OnSavePlayback(fatherBuilding)
  elseif self.testID == 2 then
    self:OnClearFreeArea(fatherBuilding)
    self:OnClearMovie(fatherBuilding)
  elseif self.testID == 3 then
    self:OnRestoreHomeBuilding(fatherBuilding)
  end
  self.testID = self.testID + 1
end

function MovieFatherSon:OnEnterMovie(fatherBuilding)
  local restoreList = {}
  local children = fatherBuilding:GetAllChildren()
  for k, v in pairs(children) do
    if fatherBuilding:GetFreeChild(k) == nil then
      restoreList[k] = v
      v:ShowBuilding(false)
      fatherBuilding:RemoveChild(v)
    end
  end
  return restoreList
end

function MovieFatherSon:OnExitMovie(fatherBuilding, restoreList)
  local clearList = {}
  local children = fatherBuilding:GetAllChildren()
  for k, v in pairs(children) do
    if fatherBuilding:GetFreeChild(k) == nil then
      clearList[k] = v
    end
  end
  local buildMgr = self:GetBuildManager()
  for k, v in pairs(clearList) do
  end
  for k, v in pairs(restoreList) do
    v:ShowBuilding(true)
    fatherBuilding:AddChild(v)
  end
end

function MovieFatherSon:AddFixedBuilding(fatherBuilding, id)
  local childBuildingCfg = Cfg.cfg_item_son_architecture[id]
  local fatherSlot = childBuildingCfg.FatherSlot
  local cfg_fixed_position = Cfg.cfg_homeland_building_fixed_position({})[fatherSlot]
  if cfg_fixed_position == nil then
    BuildError("拍电影找不到固定家具位置cfg_homeland_building_fixed_position ：" .. fatherSlot)
    return
  end
  local theNearestFather = fatherBuilding
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
    replacedBuilding:Delete()
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
  local buildMgr = self:GetBuildManager()
  local building = buildMgr:_CreateBuilding(data)
  return building
end

function MovieFatherSon:RemoveBuilding(fatherBuilding, building)
  if fatherBuilding == nil then
    return
  end
  if building == nil then
    return
  end
  local buildMgr = self:GetBuildManager()
  fatherBuilding:RemoveChild(building)
  buildMgr:RemoveBuilding(building)
  building:Dispose()
end

function MovieFatherSon:OnShowFreeArea(fatherBuilding, isShow)
  local allFreeArea = fatherBuilding:GetAllFreeArea()
  local areaID = -1
  for k, v in pairs(allFreeArea) do
    areaID = v
    break
  end
  fatherBuilding:ShowBuildingArea(areaID, isShow, true)
end

function MovieFatherSon:OnClearFreeArea(fatherBuilding)
  local restoreList = {}
  local children = fatherBuilding:GetAllFreeChildren()
  for k, v in pairs(children) do
    restoreList[k] = v
  end
  local buildMgr = self:GetBuildManager()
  for k, v in pairs(restoreList) do
    fatherBuilding:RemoveChild(v)
    buildMgr:RemoveBuilding(v)
    v:Dispose()
  end
end

function MovieFatherSon:OnClearMovie(fatherBuilding)
  local restoreList = {}
  local children = fatherBuilding:GetAllChildren()
  for k, v in pairs(children) do
    if fatherBuilding:GetFreeChild(k) == nil then
      restoreList[k] = v
    end
  end
  local buildMgr = self:GetBuildManager()
  for k, v in pairs(restoreList) do
    fatherBuilding:RemoveChild(v)
    buildMgr:RemoveBuilding(v)
    v:Dispose()
  end
end

function MovieFatherSon:OnRestoreHomeBuilding(fatherBuilding)
  local buildMgr = self:GetBuildManager()
  buildMgr:refreshBuilding()
end

function MovieFatherSon:GetArchitecture(building)
  local archServer = building:GetArchitecture()
  local arch = Architecture:New()
  for k, v in pairs(archServer) do
    arch[k] = v
  end
  local buildingPos = building:Pos()
  local buildingYaw = building:RotY()
  arch.pos_x = BuildHelper.ToInt(buildingPos.x)
  arch.pos_y = BuildHelper.ToInt(buildingPos.y)
  arch.pos_z = BuildHelper.ToInt(buildingPos.z)
  arch.rot = buildingYaw
  arch.parent = building:GetParentAssetID()
  return arch
end

function MovieFatherSon:OnSavePlayback(fatherBuilding)
  local dataList = {}
  local father = self:GetArchitecture(fatherBuilding)
  local children = fatherBuilding:GetAllChildren()
  for k, v in pairs(children) do
    if not v:IsDelete() then
      local child = self:GetArchitecture(v)
      local data = Architecture:New()
      data.asset_id = child.asset_id
      data.skin = child.skin
      data.pos_x = child.pos_x - father.pos_x
      data.pos_y = child.pos_y - father.pos_y
      data.pos_z = child.pos_z - father.pos_z
      data.rot = child.rot - father.rot
      data.pstid = child.pstid
      data.status = child.status
      data.parent = child.parent
      table.insert(dataList, data)
    end
  end
  table.insert(dataList, father)
  return dataList
end

function MovieFatherSon:OnEnterPlayback(fatherBuilding, dataList)
  local buildMgr = self:GetBuildManager()
  local father = self:GetArchitecture(fatherBuilding)
  for k, v in pairs(dataList) do
    if v.asset_id == fatherBuilding:GetBuildId() then
    else
      local child = v
      local data = Architecture:New()
      data.asset_id = child.asset_id
      data.skin = child.skin
      data.pos_x = child.pos_x + father.pos_x
      data.pos_y = child.pos_y + father.pos_y
      data.pos_z = child.pos_z + father.pos_z
      data.rot = child.rot + father.rot
      data.pstid = child.pstid
      data.status = child.status
      data.parent = child.parent
      local building = buildMgr:_CreateBuilding(data)
    end
  end
end

function MovieFatherSon:OnExitPlayback(fatherBuilding)
end
