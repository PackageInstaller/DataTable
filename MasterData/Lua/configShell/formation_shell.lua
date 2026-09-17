local this = class("formation_shell", G_BaseConfig)
local core = G_Tables.TDFormationTable.GetInstance()

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
  unitID = 0,
  formationScale = 1,
  formationPositionOffset = 2,
  formationRotation = 3,
  formationCollider = 4
}

function this:_getUnitid(offset)
  return core:GetInt(offset, this.indexMap.unitID)
end

function this:_getFormationscale(offset)
  return core:GetInt(offset, this.indexMap.formationScale)
end

function this:_getFormationpositionoffset(offset)
  local str = core:GetVString(offset, this.indexMap.formationPositionOffset).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getFormationrotation(offset)
  local str = core:GetVString(offset, this.indexMap.formationRotation).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getFormationcollider(offset)
  local str = core:GetVString(offset, this.indexMap.formationCollider).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

this.keyToMethodsMap = {
  unitID = this._getUnitid,
  formationScale = this._getFormationscale,
  formationPositionOffset = this._getFormationpositionoffset,
  formationRotation = this._getFormationrotation,
  formationCollider = this._getFormationcollider
}
return this
