local this = class("talent_rune_compose_shell", G_BaseConfig)
local core = G_Tables.TDTalentRuneComposeTable.GetInstance()

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
  items = 1,
  condition = 2
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getItems(offset)
  local str = core:GetVString(offset, this.indexMap.items).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getCondition(offset)
  local str = core:GetVString(offset, this.indexMap.condition).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.listCondition)
end

this.keyToMethodsMap = {
  id = this._getId,
  items = this._getItems,
  condition = this._getCondition
}
return this
