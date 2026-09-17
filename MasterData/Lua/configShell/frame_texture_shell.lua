local this = class("frame_texture_shell", G_BaseConfig)
local core = G_Tables.TDFrameTextureTable.GetInstance()

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
  frameImage = 1,
  column = 2,
  row = 3,
  frameNum = 4,
  fps = 5
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getFrameimage(offset)
  local str = core:GetVString(offset, this.indexMap.frameImage).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getColumn(offset)
  return core:GetInt(offset, this.indexMap.column)
end

function this:_getRow(offset)
  return core:GetInt(offset, this.indexMap.row)
end

function this:_getFramenum(offset)
  return core:GetInt(offset, this.indexMap.frameNum)
end

function this:_getFps(offset)
  return core:GetInt(offset, this.indexMap.fps)
end

this.keyToMethodsMap = {
  id = this._getId,
  frameImage = this._getFrameimage,
  column = this._getColumn,
  row = this._getRow,
  frameNum = this._getFramenum,
  fps = this._getFps
}
return this
