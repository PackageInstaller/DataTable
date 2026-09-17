local this = class("world_hud_shell", G_BaseConfig)
local core = G_Tables.TDWorldHudTable.GetInstance()

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
  hudType = 1,
  resource = 2,
  text = 3,
  imagePath = 4,
  attachedBone = 5,
  posOffset = 6,
  rotOffset = 7,
  scale = 8,
  slots = 9,
  priority = 10,
  ignoreAlpha = 11,
  stringParams = 12
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getHudtype(offset)
  return core:GetInt(offset, this.indexMap.hudType)
end

function this:_getResource(offset)
  return core:GetVString(offset, this.indexMap.resource).value
end

function this:_getText(offset)
  local langStr = G_TableMgrIns:GetLangStr("world_hud", core:GetVString(offset, this.indexMap.text))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "text")
end

function this:_getImagepath(offset)
  return core:GetVString(offset, this.indexMap.imagePath).value
end

function this:_getAttachedbone(offset)
  return core:GetVString(offset, this.indexMap.attachedBone).value
end

function this:_getPosoffset(offset)
  local str = core:GetVString(offset, this.indexMap.posOffset).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getRotoffset(offset)
  local str = core:GetVString(offset, this.indexMap.rotOffset).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getScale(offset)
  local str = core:GetVString(offset, this.indexMap.scale).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getSlots(offset)
  return core:GetInt(offset, this.indexMap.slots)
end

function this:_getPriority(offset)
  return core:GetInt(offset, this.indexMap.priority)
end

function this:_getIgnorealpha(offset)
  return core:GetInt(offset, this.indexMap.ignoreAlpha)
end

function this:_getStringparams(offset)
  local str = core:GetVString(offset, this.indexMap.stringParams).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "string")
end

this.keyToMethodsMap = {
  id = this._getId,
  hudType = this._getHudtype,
  resource = this._getResource,
  text = this._getText,
  imagePath = this._getImagepath,
  attachedBone = this._getAttachedbone,
  posOffset = this._getPosoffset,
  rotOffset = this._getRotoffset,
  scale = this._getScale,
  slots = this._getSlots,
  priority = this._getPriority,
  ignoreAlpha = this._getIgnorealpha,
  stringParams = this._getStringparams
}
return this
