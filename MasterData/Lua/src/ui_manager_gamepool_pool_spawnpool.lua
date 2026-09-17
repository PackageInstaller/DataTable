local this = class("spawnPool")

function this:ctor(despawnRoot, threshold)
  self.waitingArea = {}
  self.usingArea = {}
  self:setThreshold(threshold)
  self:setRoot(despawnRoot)
end

function this:setRoot(root)
  self.autoDestroyRoot = root == nil
  if root == nil then
    root = Unity.GameObject("[objectPool]").transform
  else
    self.despawnRoot = root
  end
end

function this:setThreshold(threshold)
  threshold = math.ceil((threshold or 10) * 1.2)
  self.threshold = threshold
end

function this:preload(path, num)
  for i = 1, num do
    local go = C_UIMgr.uiLoader:Spawn(path)
    self:putInWaitingArea(path, go)
  end
end

function this:asyncPreload(path, num, callBack)
  local index = 0
  
  local function _asyncHandle(instanceId, go)
    self:putInWaitingArea(path, go)
    index = index + 1
    if index == num and callBack then
      callBack()
    end
  end
  
  for i = 1, num do
    C_UIMgr.uiLoader:SpawnAsync(path, _asyncHandle)
  end
end

function this:spawn(path)
  local waiting = self:getWaiting(path)
  local go
  if table.isEmpty(waiting) then
    go = C_UIMgr.uiLoader:Spawn(path, self.despawnRoot)
  else
    go = table.remove(waiting)
    go:SetActive(true)
  end
  self.usingArea[go] = path
  return go
end

function this:asyncSpawn(path, callBack, parent, defaultActive, operationModule, priority, instantiateAsync, setOriginAnchoredPosition)
  defaultActive = defaultActive or true
  operationModule = operationModule or C_EAssetOperationModule.Lua
  priority = priority or C_LoadPriority.High
  instantiateAsync = instantiateAsync or false
  setOriginAnchoredPosition = setOriginAnchoredPosition or false
  local waiting = self:getWaiting(path)
  local go
  
  local function _callBack(instanceId, go)
    self.usingArea[go] = path
    if callBack then
      callBack(go)
    end
  end
  
  if table.isEmpty(waiting) then
    return nil, C_UIMgr.uiLoader:SpawnAsync(path, _callBack, parent, defaultActive, operationModule, priority, instantiateAsync, setOriginAnchoredPosition)
  else
    go = table.remove(waiting)
    go:SetActive(true)
    _callBack(nil, go)
  end
  return go
end

function this:destroyGo(go)
  if go == nil then
    error("[objectpool] : destroy go is null")
  end
  local path = self.usingArea[go]
  if path then
    self.usingArea[go] = nil
    C_BoundGameObject.Destroy(go)
  end
end

function this:despawn(go)
  if go == nil then
    errorf("[objectpool] : despawn go is null")
  end
  local path = self.usingArea[go]
  if path then
    self:putInWaitingArea(path, go)
    self.usingArea[go] = nil
  end
end

function this:putInWaitingArea(path, go)
  if self.threshold == 0 then
    C_BoundGameObject.Destroy(go)
    return
  end
  local count = self:getWaitingCount()
  if count >= self.threshold then
    self:removeWaiting(math.ceil((self.threshold + 1) * 0.2))
  end
  local waiting = self:getWaiting(path, true)
  table.insert(waiting, go)
  go.transform:SetParent(self.despawnRoot)
  go:ActiveTrans(false)
end

function this:getUsing(go)
  return self.usingArea[go]
end

function this:getWaiting(path, isCreate)
  local waiting = self.waitingArea[path]
  if waiting == nil and isCreate then
    waiting = {}
    self.waitingArea[path] = waiting
  end
  return waiting
end

function this:removeWaiting(count)
  if count then
    local index = 0
    for _, waiting in pairs(self.waitingArea) do
      for i = #waiting, 1, -1 do
        if count <= index then
          return
        else
          C_BoundGameObject.Destroy(waiting[i])
          table.remove(waiting, i)
          index = index + 1
        end
      end
    end
  else
    self.waitingArea = {}
  end
end

function this:getWaitingCount()
  local count = 0
  for _, v in pairs(self.waitingArea) do
    count = count + #v
  end
  return count
end

function this:dispose()
  if self.autoDestroyRoot then
    C_BoundGameObject.Destroy(self.despawnRoot)
  end
  self.waitingArea = {}
  self.usingArea = {}
end

return this
