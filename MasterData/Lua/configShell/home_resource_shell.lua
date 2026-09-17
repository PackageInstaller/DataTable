local this = class("home_resource_shell", G_BaseConfig)
local core = G_Tables.TDHomeResourceTable.GetInstance()

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
  icon = 1,
  output = 2,
  drop = 3
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getIcon(offset)
  local str = core:GetVString(offset, this.indexMap.icon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getOutput(offset)
  local str = core:GetVString(offset, this.indexMap.output).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getDrop(offset)
  local str = core:GetVString(offset, this.indexMap.drop).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

this.keyToMethodsMap = {
  id = this._getId,
  icon = this._getIcon,
  output = this._getOutput,
  drop = this._getDrop
}
return this
