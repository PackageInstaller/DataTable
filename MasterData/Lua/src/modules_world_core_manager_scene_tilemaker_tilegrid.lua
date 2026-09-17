local this = class("tileGrid")
this.event = {
  gridRefresh = "gridRefresh"
}

function this:ctor(gridConfig, root)
  self.gridConfig = gridConfig
  self.tileRoot = root
  self.tileObjBox = {}
end

function this:show()
  local curCount = 0
  local maxCount = #self.gridConfig.tiles
  
  local function _add()
    curCount = curCount + 1
    if maxCount == curCount then
    end
  end
  
  for i, config in ipairs(self.gridConfig.tiles) do
    local ins = self.tileObjBox[i]
    if ins then
      if ins.go then
        _add()
        ins.go:ActiveTrans(true)
      end
    else
      ins = {}
      self.tileObjBox[i] = ins
      L_ResPool:asyncGameObject(config.resPath, function(id, go)
        go.name = config.name
        ins.go = go
        if ins.isDestroy then
          self:destroySingle(i)
        else
          if ins.isShow == false then
            go:ActiveTrans(false)
          end
          local trans = go.transform
          trans.position = config.position
          trans.eulerAngles = config.rotation
          trans:SetParent(self.tileRoot)
          _add()
        end
      end)
    end
  end
end

function this:hide()
  for i, config in ipairs(self.gridConfig.tiles) do
    local ins = self.tileObjBox[i]
    if ins then
      if ins.go then
        ins.go:ActiveTrans(false)
      else
        ins.isShow = false
      end
    else
    end
  end
end

function this:destroy()
  for objId, v in pairs(self.tileObjBox) do
    self:destroySingle(objId)
  end
end

function this:destroySingle(objId)
  local item = self.tileObjBox[objId]
  if item == nil then
    return
  end
  if item.go then
    item.isDestroy = true
  else
    Unity.GameObject.Destroy(item.go)
    self.tileObjBox[objId] = nil
  end
end

return this
