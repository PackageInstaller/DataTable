local this = class("world_buff_shell", G_BaseConfig)
local core = G_Tables.TDWorldBuffTable.GetInstance()

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
  buffIcon = 1,
  buffElementId = 2,
  condition = 3,
  duration_type = 4,
  duration = 5,
  group = 6,
  priority = 7,
  buffStrength = 8
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getBufficon(offset)
  local str = core:GetVString(offset, this.indexMap.buffIcon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getBuffelementid(offset)
  return core:GetInt(offset, this.indexMap.buffElementId)
end

function this:_getCondition(offset)
  local str = core:GetVString(offset, this.indexMap.condition).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getDuration_type(offset)
  return core:GetInt(offset, this.indexMap.duration_type)
end

function this:_getDuration(offset)
  return core:GetInt(offset, this.indexMap.duration)
end

function this:_getGroup(offset)
  return core:GetInt(offset, this.indexMap.group)
end

function this:_getPriority(offset)
  return core:GetInt(offset, this.indexMap.priority)
end

function this:_getBuffstrength(offset)
  return core:GetInt(offset, this.indexMap.buffStrength)
end

this.keyToMethodsMap = {
  id = this._getId,
  buffIcon = this._getBufficon,
  buffElementId = this._getBuffelementid,
  condition = this._getCondition,
  duration_type = this._getDuration_type,
  duration = this._getDuration,
  group = this._getGroup,
  priority = this._getPriority,
  buffStrength = this._getBuffstrength
}
return this
