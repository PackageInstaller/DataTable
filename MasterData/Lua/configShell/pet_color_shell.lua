local this = class("pet_color_shell", G_BaseConfig)
local core = G_Tables.TDPetColorTable.GetInstance()

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
  starcolorId = 1,
  configId = 2,
  colorRgb1 = 3,
  colorRgb2 = 4,
  colorHsv = 5,
  FlowHsv = 6
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getStarcolorid(offset)
  return core:GetInt(offset, this.indexMap.starcolorId)
end

function this:_getConfigid(offset)
  local str = core:GetVString(offset, this.indexMap.configId).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getColorrgb1(offset)
  local str = core:GetVString(offset, this.indexMap.colorRgb1).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getColorrgb2(offset)
  local str = core:GetVString(offset, this.indexMap.colorRgb2).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getColorhsv(offset)
  local str = core:GetVString(offset, this.indexMap.colorHsv).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getFlowhsv(offset)
  local str = core:GetVString(offset, this.indexMap.FlowHsv).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

this.keyToMethodsMap = {
  id = this._getId,
  starcolorId = this._getStarcolorid,
  configId = this._getConfigid,
  colorRgb1 = this._getColorrgb1,
  colorRgb2 = this._getColorrgb2,
  colorHsv = this._getColorhsv,
  FlowHsv = this._getFlowhsv
}
return this
