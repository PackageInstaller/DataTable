local this = class("tileMaker")

function this:ctor()
  self.gridCache = L_Struct.getLruCache()
  self.dungeonGrid = require(L_R.world.coreMgr .. "tilemaker.tilegrid")
  self.viewBound = require(L_R.world.coreMgr .. "tilemaker.tilebound").new()
  self.viewQueue = {}
end

function this:initialize(config, tileRoot)
  self:dispose()
  self:initConfig(config)
  self:initScene(tileRoot)
end

function this:initConfig(config)
  self.mapConfig = config
  self.viewBound.maxWidth = self.mapConfig.width
  self.viewBound.maxHeight = self.mapConfig.height
end

function this:initScene(tileRoot)
  self.tileRoot = tileRoot
end

function this:getMapConfig()
  return self.mapConfig
end

function this:getViewQueue()
  return self.viewQueue
end

function this:showOrHide(isShow)
  if self.tileRoot then
    self.tileRoot.gameObject:ActiveTrans(isShow)
  end
end

function this:dispose()
  self.viewQueue = {}
  self.gridCache:dispose()
  if L_CommonUtil.isValid(self.tileRoot) then
    C_BoundGameObject.Destroy(self.tileRoot.gameObject)
    self.tileRoot = nil
  end
end

function this:convertScenePosToGridPos(scenePos)
  local gridSize = self.mapConfig.gridSize
  local x = math.ceil(scenePos.x / gridSize.x)
  local y = math.ceil(scenePos.z / gridSize.y)
  return x, y
end

function this:convertGridPosToScenePos(x, y)
  local gridSize = self.mapConfig.gridSize
  return {
    x = (x - 0.5) * gridSize.x,
    y = 0,
    z = (y - 0.5) * gridSize.y
  }
end

function this:convertScenePosToGridID(scenePos)
  local x, y = self:convertScenePosToGridPos(scenePos)
  return self:convertGridPosToGridID(x, y)
end

function this:convertGridPosToGridID(x, y)
  return (y - 1) * self.mapConfig.width + x
end

function this:convertGridIDToScenePos(gridID)
  local x = (gridID - 1) % self.mapConfig.width + 1
  local y = math.ceil(gridID / self.mapConfig.width)
  return self:convertGridPosToScenePos(x, y)
end

function this:onceLoadGrid(tileLoadCompleted)
  self.gridCache:setMaxCount(self.mapConfig.width * self.mapConfig.height)
  self.viewBound:refresh(0, 0, self.mapConfig.width, self.mapConfig.height)
  local viewArea = self.viewBound:getDictionaryView()
  local curCount = 0
  local maxCount = self:getGridCountInView(viewArea)
  local _waitBuild
  
  function _waitBuild()
    curCount = curCount + 1
    if maxCount == curCount and tileLoadCompleted then
      tileLoadCompleted()
    end
  end
  
  self:refreshSceneInView(viewArea)
end

function this:dynamicLoadGrid(width, height)
  self.gridCache:setMaxCount(width * height * 2)
  self.viewBound:refresh(0, 0, width, height)
  self:refreshSceneInView()
end

function this:refreshPos(curPos)
  local x, y = self:convertScenePosToGridPos(curPos)
  if self.viewBound.x == x and self.viewBound.y == y then
    return
  end
  self.viewBound:refresh(x, y)
  self:refreshSceneInView()
end

function this:refreshSceneInView(view)
  view = view or self.viewBound:getDictionaryView()
  local outView = {}
  for gridID, v in pairs(self.viewQueue) do
    if view[gridID] then
      view[gridID] = nil
    else
      self:hideGrid(gridID)
      self.viewQueue[gridID] = nil
      outView[gridID] = gridID
    end
  end
  for gridID, v in pairs(view) do
    self.viewQueue[gridID] = view[gridID]
    self:showGrid(gridID)
  end
  return view, outView
end

function this:getGridCountInView(view)
  local tileCount = 0
  for _, gridID in pairs(view or self.viewQueue) do
    local config = self.mapConfig[gridID]
    if config and not table.isEmpty(config.tiles) then
      tileCount = tileCount + 1
    end
  end
  return tileCount
end

function this:getGridEntity(gridID, isCreate)
  local entity = self.gridCache:get(gridID)
  if not entity and isCreate then
    entity = self.dungeonGrid.new(self.mapConfig[gridID], self.tileRoot)
    self.gridCache:add(gridID, entity, function()
      entity:destroy()
    end)
  end
  return entity
end

function this:showGrid(gridID)
  if not self.mapConfig[gridID] then
    return
  end
  self:getGridEntity(gridID, true):show()
end

function this:hideGrid(gridID)
  local entity = self:getGridEntity(gridID)
  if entity then
    entity:hide()
  end
end

return this
