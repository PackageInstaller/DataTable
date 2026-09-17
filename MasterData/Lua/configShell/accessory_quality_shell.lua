local this = class("accessory_quality_shell", G_BaseConfig)
local core = G_Tables.TDAccessoryQualityTable.GetInstance()

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
  value = 2
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getName(offset)
  local langStr = G_TableMgrIns:GetLangStr("accessory_quality", core:GetVString(offset, this.indexMap.name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "name")
end

function this:_getValue(offset)
  return core:GetInt(offset, this.indexMap.value)
end

this.keyToMethodsMap = {
  id = this._getId,
  name = this._getName,
  value = this._getValue
}
return this
