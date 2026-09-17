local cls = class("uiModelMgr")

function cls:ctor()
end

function cls:LoadHeroScenePrefabAsync(heroEnvironmentPath, cbk)
  if self.loadHeroScenePrefab == heroEnvironmentPath then
    if L_CommonUtil.isValid(self.heroEnvironment) then
      L_CommonUtil.setObjActive(self.heroEnvironment, true)
      if cbk then
        cbk(self.heroEnvironment)
      end
    end
    return
  end
  self.loadHeroScenePrefab = heroEnvironmentPath
  local instanceId
  instanceId = C_UIMgr.uiLoader:SpawnAsync(heroEnvironmentPath, function(instanceId, go)
    if not L_CommonUtil.isValid(go) then
      errorf("cant load asset from " .. heroEnvironmentPath)
      return
    end
    if not self.loadHeroScenePrefab or self.loadHeroScenePrefab ~= heroEnvironmentPath then
      C_PrefabManager:RecycleByLoader(instanceId)
      return
    end
    self:RecycleHeroEnvironment()
    self.heroEnvironmentInstanceId = instanceId
    self.heroEnvironment = go
    self.loadHeroScenePrefab = heroEnvironmentPath
    L_Vector3.setPos(go.transform, C_UIMgr.SceneLoadDefaultPosition)
    L_Vector3.setRot(go.transform, L_Vector3.zero)
    L_Vector3.setSize(go.transform, 1)
    if cbk then
      cbk(go)
    end
  end, C_LuaUtility.GetRootNode(), true, C_EAssetOperationModule.Lua, C_AssetLoadPriority.GetPriority(C_AssetLoadPriority.UI_Page))
end

function cls:RecycleHeroEnvironment()
  self.loadHeroScenePrefab = nil
  if self.heroEnvironmentInstanceId then
    C_PrefabManager:RecycleByLoader(self.heroEnvironmentInstanceId)
    self.heroEnvironmentInstanceId = nil
  end
  self.heroEnvironment = nil
end

function cls:LoadHeroModelAsync(heroPath, initPos, initRotate, initScale, cbk, parent)
  self.mainHeroInitPos = initPos
  self.mainHeroInitRotate = initRotate
  self.mainHeroInitScale = initScale
  if self.bLoadMainHero == heroPath then
    if L_CommonUtil.isValid(self.heroObj) then
      L_CommonUtil.setObjActive(self.heroObj, true)
      L_Vector3.setLocalPos(self.heroObj.transform, self.mainHeroInitPos or L_Vector3.zero)
      L_Vector3.setRot(self.heroObj.transform, self.mainHeroInitRotate or L_Vector3.zero)
      L_Vector3.setScale(self.heroObj.transform, self.mainHeroInitScale or L_Vector3.one)
      if cbk then
        cbk(self.heroObj)
      end
    end
    return
  end
  self.bLoadMainHero = heroPath
  local instanceId = 0
  instanceId = C_UIMgr.uiLoader:SpawnAsync(heroPath, function(instanceId, go)
    if not L_CommonUtil.isValid(go) then
      errorf("cant load asset from " .. heroPath)
      return
    end
    if not self.bLoadMainHero or self.bLoadMainHero ~= heroPath then
      C_PrefabManager:RecycleByLoader(instanceId)
      return
    end
    self:RecycleHeroModel()
    self.heroInstanceId = instanceId
    self.bLoadMainHero = heroPath
    L_Vector3.setLocalPos(go.transform, self.mainHeroInitPos or L_Vector3.zero)
    L_Vector3.setRot(go.transform, self.mainHeroInitRotate or L_Vector3.zero)
    L_Vector3.setScale(go.transform, self.mainHeroInitScale or L_Vector3.one)
    self.heroObj = go
    if cbk then
      cbk(go)
    end
  end, parent, true, C_EAssetOperationModule.Lua, C_AssetLoadPriority.GetPriority(C_AssetLoadPriority.UI_Page))
end

function cls:RecycleHeroModel()
  if self.heroInstanceId then
    C_PrefabManager:RecycleByLoader(self.heroInstanceId)
    self.heroInstanceId = nil
  end
  self.bLoadMainHero = nil
  self.heroObj = nil
end

function cls:LoadViceHeroModelAsync(heroPath, initPos, initRotate, initScale, cbk, parent)
  self.viceHeroInitPos = initPos
  self.viceHeroInitRotate = initRotate
  self.viceHeroInitScale = initScale
  if self.bLoadViceHero == heroPath then
    if L_CommonUtil.isValid(self.heroViceObj) then
      L_CommonUtil.setObjActive(self.heroViceObj, true)
      L_Vector3.setLocalPos(self.heroViceObj.transform, self.viceHeroInitPos or L_Vector3.zero)
      L_Vector3.setRot(self.heroViceObj.transform, self.viceHeroInitRotate or L_Vector3.zero)
      L_Vector3.setSize(self.heroViceObj.transform, self.viceHeroInitScale.x or 1)
      if cbk then
        cbk(self.heroViceObj)
      end
    end
    return
  end
  self.bLoadViceHero = heroPath
  local instanceId
  instanceId = C_UIMgr.uiLoader:SpawnAsync(heroPath, function(instanceId, go)
    if not L_CommonUtil.isValid(go) then
      errorf("cant load asset from " .. heroPath)
      return
    end
    if not self.bLoadViceHero or self.bLoadViceHero ~= heroPath then
      C_PrefabManager:RecycleByLoader(instanceId)
      return
    end
    self:RecycleViceHeroModel()
    self.heroViceInstanceId = instanceId
    self.bLoadViceHero = heroPath
    L_Vector3.setLocalPos(go.transform, self.viceHeroInitPos or L_Vector3.zero)
    L_Vector3.setRot(go.transform, self.viceHeroInitRotate or L_Vector3.zero)
    L_Vector3.setSize(go.transform, self.viceHeroInitScale.x or 1)
    self.heroViceObj = go
    if cbk then
      cbk(go)
    end
  end, parent, true, C_EAssetOperationModule.Lua, C_AssetLoadPriority.GetPriority(C_AssetLoadPriority.UI_Page))
end

function cls:RecycleViceHeroModel()
  self.bLoadViceHero = nil
  if self.heroViceInstanceId then
    C_PrefabManager:RecycleByLoader(self.heroViceInstanceId)
    self.heroViceInstanceId = nil
  end
  self.heroViceObj = nil
end

function cls:GetHeroEnvironmentObj()
  if L_CommonUtil.isValid(self.heroEnvironment) then
    return self.heroEnvironment
  end
  return nil
end

function cls:GetHeroObj()
  if L_CommonUtil.isValid(self.heroObj) then
    return self.heroObj
  end
  return nil
end

function cls:EnableHeroModel(bShow)
  L_CommonUtil.setObjActive(self.heroObj, bShow)
end

function cls:EnableViceHeroModel(bShow)
  L_CommonUtil.setObjActive(self.heroViceObj, bShow)
end

function cls:EnableHeroEnvironment(bShow)
  L_CommonUtil.setObjActive(self.heroEnvironment, bShow)
end

return cls
