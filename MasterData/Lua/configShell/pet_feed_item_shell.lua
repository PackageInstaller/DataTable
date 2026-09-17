local this = class("pet_feed_item_shell", G_BaseConfig)
local core = G_Tables.TDPetFeedItemTable.GetInstance()

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
  param = 2,
  dnaParam = 3,
  homedropId = 4,
  isReuse = 5,
  bg = 6
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getType(offset)
  return core:GetInt(offset, this.indexMap.type)
end

function this:_getParam(offset)
  local str = core:GetVString(offset, this.indexMap.param).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getDnaparam(offset)
  return core:GetInt(offset, this.indexMap.dnaParam)
end

function this:_getHomedropid(offset)
  return core:GetInt(offset, this.indexMap.homedropId)
end

function this:_getIsreuse(offset)
  return core:GetBool(offset, this.indexMap.isReuse)
end

function this:_getBg(offset)
  local str = core:GetVString(offset, this.indexMap.bg).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

this.keyToMethodsMap = {
  id = this._getId,
  type = this._getType,
  param = this._getParam,
  dnaParam = this._getDnaparam,
  homedropId = this._getHomedropid,
  isReuse = this._getIsreuse,
  bg = this._getBg
}
return this
