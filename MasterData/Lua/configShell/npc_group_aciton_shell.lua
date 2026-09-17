local this = class("npc_group_aciton_shell", G_BaseConfig)
local core = G_Tables.TDNpcGroupAcitonTable.GetInstance()

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
  performType = 1,
  npcList = 2,
  paramList = 3
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getPerformtype(offset)
  return core:GetInt(offset, this.indexMap.performType)
end

function this:_getNpclist(offset)
  local str = core:GetVString(offset, this.indexMap.npcList).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getParamlist(offset)
  local str = core:GetVString(offset, this.indexMap.paramList).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "string")
end

this.keyToMethodsMap = {
  id = this._getId,
  performType = this._getPerformtype,
  npcList = this._getNpclist,
  paramList = this._getParamlist
}
return this
