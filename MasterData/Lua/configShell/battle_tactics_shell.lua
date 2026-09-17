local this = class("battle_tactics_shell", G_BaseConfig)
local core = G_Tables.TDBattleTacticsTable.GetInstance()

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
  content = 2,
  _ = 3
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getName(offset)
  local langStr = G_TableMgrIns:GetLangStr("battle_tactics", core:GetVString(offset, this.indexMap.name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "name")
end

function this:_getContent(offset)
  local langStr = G_TableMgrIns:GetLangStr("battle_tactics", core:GetVString(offset, this.indexMap.content))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "content")
end

function this:_get_(offset)
  return core:GetVString(offset, this.indexMap._).value
end

this.keyToMethodsMap = {
  id = this._getId,
  name = this._getName,
  content = this._getContent,
  _ = this._get_
}
return this
