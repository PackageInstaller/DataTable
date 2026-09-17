local this = class("gm_customizedtext_list_shell", G_BaseConfig)
local core = G_Tables.TDGmCustomizedtextListTable.GetInstance()

function this:getLineOffset(key)
  return core:GetRowOffset(key)
end

function this:getLen()
  return core.count or 0
end

function this:getKeys()
  return core:GetKeysEnumerator()
end

this.indexMap = {id = 0, functionName = 1}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getFunctionname(offset)
  local langStr = G_TableMgrIns:GetLangStr("gm_customizedtext_list", core:GetVString(offset, this.indexMap.functionName))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "functionName")
end

this.keyToMethodsMap = {
  id = this._getId,
  functionName = this._getFunctionname
}
return this
