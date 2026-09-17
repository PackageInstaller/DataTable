local this = class("color_formula_shell", G_BaseConfig)
local core = G_Tables.TDColorFormulaTable.GetInstance()

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
  Id = 0,
  icon = 1,
  color1 = 2,
  color2 = 3,
  color3 = 4,
  color4 = 5,
  wardrobeId = 6,
  materialCfg = 7
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.Id)
end

function this:_getIcon(offset)
  local str = core:GetVString(offset, this.indexMap.icon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getColor1(offset)
  return core:GetVString(offset, this.indexMap.color1).value
end

function this:_getColor2(offset)
  return core:GetVString(offset, this.indexMap.color2).value
end

function this:_getColor3(offset)
  return core:GetVString(offset, this.indexMap.color3).value
end

function this:_getColor4(offset)
  return core:GetVString(offset, this.indexMap.color4).value
end

function this:_getWardrobeid(offset)
  return core:GetInt(offset, this.indexMap.wardrobeId)
end

function this:_getMaterialcfg(offset)
  return core:GetVString(offset, this.indexMap.materialCfg).value
end

this.keyToMethodsMap = {
  Id = this._getId,
  icon = this._getIcon,
  color1 = this._getColor1,
  color2 = this._getColor2,
  color3 = this._getColor3,
  color4 = this._getColor4,
  wardrobeId = this._getWardrobeid,
  materialCfg = this._getMaterialcfg
}
return this
