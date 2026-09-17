local this = class("home_dorm_furniture_interactpoint_shell", G_BaseConfig)
local core = G_Tables.TDHomeDormFurnitureInteractpointTable.GetInstance()

function this:getLineOffset(key)
  return core:GetRowOffset(key)
end

function this:getLen()
  return core.count or 0
end

function this:getKeys()
  return core:GetKeysEnumerator()
end

this.indexMap = {
  id = 0,
  type = 1,
  collider = 2,
  interactAnimateName = 3,
  furnitureInteractMontageName = 4,
  dormPerform = 5,
  blackin = 6,
  blackout = 7,
  clickText = 8,
  drawMaxText = 9,
  fragid = 10,
  stockingFragId = 11,
  startStockingFragId = 12,
  lastStockingFragId = 13,
  endStocking = 14
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getType(offset)
  return core:GetInt(offset, this.indexMap.type)
end

function this:_getCollider(offset)
  return core:GetVString(offset, this.indexMap.collider).value
end

function this:_getInteractanimatename(offset)
  return core:GetVString(offset, this.indexMap.interactAnimateName).value
end

function this:_getFurnitureinteractmontagename(offset)
  return core:GetVString(offset, this.indexMap.furnitureInteractMontageName).value
end

function this:_getDormperform(offset)
  local str = core:GetVString(offset, this.indexMap.dormPerform).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getBlackin(offset)
  return core:GetFloat(offset, this.indexMap.blackin)
end

function this:_getBlackout(offset)
  return core:GetFloat(offset, this.indexMap.blackout)
end

function this:_getClicktext(offset)
  return core:GetInt(offset, this.indexMap.clickText)
end

function this:_getDrawmaxtext(offset)
  return core:GetInt(offset, this.indexMap.drawMaxText)
end

function this:_getFragid(offset)
  return core:GetInt(offset, this.indexMap.fragid)
end

function this:_getStockingfragid(offset)
  return core:GetInt(offset, this.indexMap.stockingFragId)
end

function this:_getStartstockingfragid(offset)
  return core:GetInt(offset, this.indexMap.startStockingFragId)
end

function this:_getLaststockingfragid(offset)
  return core:GetInt(offset, this.indexMap.lastStockingFragId)
end

function this:_getEndstocking(offset)
  return core:GetInt(offset, this.indexMap.endStocking)
end

this.keyToMethodsMap = {
  id = this._getId,
  type = this._getType,
  collider = this._getCollider,
  interactAnimateName = this._getInteractanimatename,
  furnitureInteractMontageName = this._getFurnitureinteractmontagename,
  dormPerform = this._getDormperform,
  blackin = this._getBlackin,
  blackout = this._getBlackout,
  clickText = this._getClicktext,
  drawMaxText = this._getDrawmaxtext,
  fragid = this._getFragid,
  stockingFragId = this._getStockingfragid,
  startStockingFragId = this._getStartstockingfragid,
  lastStockingFragId = this._getLaststockingfragid,
  endStocking = this._getEndstocking
}
return this
