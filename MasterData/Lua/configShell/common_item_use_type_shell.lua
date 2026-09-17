local this = class("common_item_use_type_shell", G_BaseConfig)
local core = G_Tables.TDCommonItemUseTypeTable.GetInstance()

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
  desc = 1,
  name = 2,
  useType = 3
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getDesc(offset)
  return core:GetVString(offset, this.indexMap.desc).value
end

function this:_getName(offset)
  local langStr = G_TableMgrIns:GetLangStr("common_item_use_type", core:GetVString(offset, this.indexMap.name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "name")
end

function this:_getUsetype(offset)
  return core:GetInt(offset, this.indexMap.useType)
end

this.keyToMethodsMap = {
  id = this._getId,
  desc = this._getDesc,
  name = this._getName,
  useType = this._getUsetype
}
return this
