local this = class("optiondata_display_shell", G_BaseConfig)
local core = G_Tables.TDOptionDataDisplayTable.GetInstance()

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
  horizontalPixels = 1,
  verticalPixels = 2,
  displayType = 3
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getHorizontalpixels(offset)
  return core:GetInt(offset, this.indexMap.horizontalPixels)
end

function this:_getVerticalpixels(offset)
  return core:GetInt(offset, this.indexMap.verticalPixels)
end

function this:_getDisplaytype(offset)
  return core:GetInt(offset, this.indexMap.displayType)
end

this.keyToMethodsMap = {
  id = this._getId,
  horizontalPixels = this._getHorizontalpixels,
  verticalPixels = this._getVerticalpixels,
  displayType = this._getDisplaytype
}
return this
