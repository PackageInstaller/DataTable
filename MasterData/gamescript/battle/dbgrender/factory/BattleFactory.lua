local BattleFactory, Super = System.NewClass("BattleFactory")

function BattleFactory:ctor(factoryType)
  self.factoryType = factoryType
  self.poolObjData = {}
  self.usingObjData = {}
end

function BattleFactory:Dispose()
  for configId, objList in pairs(self.poolObjData) do
    for index, obj in ipairs(objList) do
      if obj.Dispose then
        obj:Dispose()
      end
    end
  end
  for configId, objList in pairs(self.usingObjData) do
    for index, obj in ipairs(objList) do
      if obj.Dispose then
        obj:Dispose()
      end
    end
  end
end

function BattleFactory:Tick(deltaTime)
  for configId, objList in pairs(self.usingObjData) do
    for index, obj in ipairs(objList) do
      obj:Tick(deltaTime)
    end
  end
end

function BattleFactory:GetObjClass()
  if self.factoryType == bc.BattleFactoryType.BattleAwakerClient then
    return BattleAwakerClient
  elseif self.factoryType == bc.BattleFactoryType.BattleSfx then
    return BattleSfx
  end
  return nil
end

function BattleFactory:Preload(config)
end

function BattleFactory:GenerateObj(config)
  local configId = config.configId
  if not self.poolObjData[configId] then
    self.poolObjData[configId] = {}
  end
  if not self.usingObjData[configId] then
    self.usingObjData[configId] = {}
  end
  local newObj
  if #self.poolObjData[configId] > 0 then
    newObj = table.remove(self.poolObjData[configId])
    newObj.rootNode:SetActive(true)
  else
    local objClass = self:GetObjClass()
    newObj = objClass(config)
  end
  newObj:Reset(config)
  table.insert(self.usingObjData[configId], newObj)
  return newObj
end

function BattleFactory:RecycleObj(oldObj)
  oldObj:Recycle()
  oldObj.rootNode:SetActive(false)
  oldObj.rootNode.transform:SetParent(bg.battleScene.factoryLayer, false)
  local configId = oldObj.configId
  local usingList = self.usingObjData[configId]
  for index = #usingList, 1, -1 do
    local testObj = usingList[index]
    if testObj == oldObj then
      table.remove(usingList, index)
    end
  end
  table.insert(self.poolObjData[configId], oldObj)
end

function BattleFactory:PrintDebugLog()
  Logger.Debug("-----#对象池工厂Debug信息：", self.factoryType)
  Logger.Debug("-----缓存池对象：")
  for configId, objList in pairs(self.poolObjData) do
    for index, obj in ipairs(objList) do
      Logger.Debug("-----#", configId, obj.uid, obj)
    end
  end
  Logger.Debug("-----使用中对象：")
  for configId, objList in pairs(self.usingObjData) do
    for index, obj in ipairs(objList) do
      Logger.Debug("-----#", configId, obj.uid, obj)
    end
  end
end

return BattleFactory
