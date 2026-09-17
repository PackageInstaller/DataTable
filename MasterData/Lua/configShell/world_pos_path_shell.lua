local this = class("world_pos_path_shell", G_BaseConfig)
local core = G_Tables.TDWorldPosPathTable.GetInstance()

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
  sceneId = 1,
  type = 2,
  areaType = 3,
  posPoint = 4,
  posRot = 5,
  areaPos = 6,
  vertices = 7,
  pathPoint = 8,
  group = 9,
  index = 10
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getSceneid(offset)
  return core:GetInt(offset, this.indexMap.sceneId)
end

function this:_getType(offset)
  return core:GetInt(offset, this.indexMap.type)
end

function this:_getAreatype(offset)
  return core:GetInt(offset, this.indexMap.areaType)
end

function this:_getPospoint(offset)
  local str = core:GetVString(offset, this.indexMap.posPoint).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getPosrot(offset)
  local str = core:GetVString(offset, this.indexMap.posRot).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getAreapos(offset)
  local str = core:GetVString(offset, this.indexMap.areaPos).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getVertices(offset)
  local str = core:GetVString(offset, this.indexMap.vertices).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getPathpoint(offset)
  local str = core:GetVString(offset, this.indexMap.pathPoint).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getGroup(offset)
  return core:GetInt(offset, this.indexMap.group)
end

function this:_getIndex(offset)
  return core:GetInt(offset, this.indexMap.index)
end

this.keyToMethodsMap = {
  id = this._getId,
  sceneId = this._getSceneid,
  type = this._getType,
  areaType = this._getAreatype,
  posPoint = this._getPospoint,
  posRot = this._getPosrot,
  areaPos = this._getAreapos,
  vertices = this._getVertices,
  pathPoint = this._getPathpoint,
  group = this._getGroup,
  index = this._getIndex
}
return this
