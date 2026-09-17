local this = class("situation_objects_shell", G_BaseConfig)
local core = G_Tables.TDSituationObjectsTable.GetInstance()

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
  objectsName = 1,
  objResource = 2,
  objIcon = 3,
  unlock = 4
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getObjectsname(offset)
  local langStr = G_TableMgrIns:GetLangStr("situation_objects", core:GetVString(offset, this.indexMap.objectsName))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "objectsName")
end

function this:_getObjresource(offset)
  return core:GetVString(offset, this.indexMap.objResource).value
end

function this:_getObjicon(offset)
  local str = core:GetVString(offset, this.indexMap.objIcon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getUnlock(offset)
  return core:GetInt(offset, this.indexMap.unlock)
end

this.keyToMethodsMap = {
  id = this._getId,
  objectsName = this._getObjectsname,
  objResource = this._getObjresource,
  objIcon = this._getObjicon,
  unlock = this._getUnlock
}
return this
