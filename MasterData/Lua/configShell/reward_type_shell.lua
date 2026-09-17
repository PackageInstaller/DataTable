local this = class("reward_type_shell", G_BaseConfig)
local core = G_Tables.TDRewardTypeTable.GetInstance()

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
  tableName = 1,
  desc = 2
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getTablename(offset)
  return core:GetVString(offset, this.indexMap.tableName).value
end

function this:_getDesc(offset)
  local langStr = G_TableMgrIns:GetLangStr("reward_type", core:GetVString(offset, this.indexMap.desc))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "desc")
end

this.keyToMethodsMap = {
  id = this._getId,
  tableName = this._getTablename,
  desc = this._getDesc
}
return this
