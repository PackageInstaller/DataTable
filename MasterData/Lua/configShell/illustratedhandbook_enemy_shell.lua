local this = class("illustratedhandbook_enemy_shell", G_BaseConfig)
local core = G_Tables.TDIllustratedhandbookEnemyTable.GetInstance()

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
  timetag = 1,
  name = 2,
  desc = 3,
  unitId = 4,
  handbookenemytype = 5,
  handbookenemyScale = 6,
  handbookenemyPositionOffset = 7,
  handbookenemyRotation = 8
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getTimetag(offset)
  return core:GetVString(offset, this.indexMap.timetag).value
end

function this:_getName(offset)
  local langStr = G_TableMgrIns:GetLangStr("illustratedhandbook_enemy", core:GetVString(offset, this.indexMap.name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "name")
end

function this:_getDesc(offset)
  local langStr = G_TableMgrIns:GetLangStr("illustratedhandbook_enemy", core:GetVString(offset, this.indexMap.desc))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "desc")
end

function this:_getUnitid(offset)
  return core:GetInt(offset, this.indexMap.unitId)
end

function this:_getHandbookenemytype(offset)
  return core:GetInt(offset, this.indexMap.handbookenemytype)
end

function this:_getHandbookenemyscale(offset)
  return core:GetInt(offset, this.indexMap.handbookenemyScale)
end

function this:_getHandbookenemypositionoffset(offset)
  local str = core:GetVString(offset, this.indexMap.handbookenemyPositionOffset).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getHandbookenemyrotation(offset)
  local str = core:GetVString(offset, this.indexMap.handbookenemyRotation).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

this.keyToMethodsMap = {
  id = this._getId,
  timetag = this._getTimetag,
  name = this._getName,
  desc = this._getDesc,
  unitId = this._getUnitid,
  handbookenemytype = this._getHandbookenemytype,
  handbookenemyScale = this._getHandbookenemyscale,
  handbookenemyPositionOffset = this._getHandbookenemypositionoffset,
  handbookenemyRotation = this._getHandbookenemyrotation
}
return this
