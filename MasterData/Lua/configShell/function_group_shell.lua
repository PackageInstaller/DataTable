local this = class("function_group_shell", G_BaseConfig)
local core = G_Tables.TDFunctionGroupTable.GetInstance()

function this:getLineOffset(key)
  return core:GetRowOffset(key)
end

function this:getLen()
  return core.count or 0
end

function this:getKeys()
  return core:GetKeysEnumerator()
end

this.indexMap = {groupID = 0, functionIds = 1}

function this:_getGroupid(offset)
  return core:GetInt(offset, this.indexMap.groupID)
end

function this:_getFunctionids(offset)
  local str = core:GetVString(offset, this.indexMap.functionIds).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

this.keyToMethodsMap = {
  groupID = this._getGroupid,
  functionIds = this._getFunctionids
}
return this
