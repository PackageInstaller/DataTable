local this = class("home_buff_count_shell", G_BaseConfig)
local core = G_Tables.TDHomeBuffCountTable.GetInstance()

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
  buffId = 1,
  condition = 2,
  desc = 3,
  type = 4
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getBuffid(offset)
  return core:GetInt(offset, this.indexMap.buffId)
end

function this:_getCondition(offset)
  local str = core:GetVString(offset, this.indexMap.condition).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getDesc(offset)
  local langStr = G_TableMgrIns:GetLangStr("home_buff_count", core:GetVString(offset, this.indexMap.desc))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "desc")
end

function this:_getType(offset)
  return core:GetInt(offset, this.indexMap.type)
end

this.keyToMethodsMap = {
  id = this._getId,
  buffId = this._getBuffid,
  condition = this._getCondition,
  desc = this._getDesc,
  type = this._getType
}
return this
