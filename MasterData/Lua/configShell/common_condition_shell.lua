local this = class("common_condition_shell", G_BaseConfig)
local core = G_Tables.TDCommonConditionTable.GetInstance()

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
  name = 1,
  type = 2,
  system_unlock = 3,
  descShow = 4
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getName(offset)
  return core:GetVString(offset, this.indexMap.name).value
end

function this:_getType(offset)
  return core:GetInt(offset, this.indexMap.type)
end

function this:_getSystem_unlock(offset)
  return core:GetInt(offset, this.indexMap.system_unlock)
end

function this:_getDescshow(offset)
  local langStr = G_TableMgrIns:GetLangStr("common_condition", core:GetVString(offset, this.indexMap.descShow))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "descShow")
end

this.keyToMethodsMap = {
  id = this._getId,
  name = this._getName,
  type = this._getType,
  system_unlock = this._getSystem_unlock,
  descShow = this._getDescshow
}
return this
