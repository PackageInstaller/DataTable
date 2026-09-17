local this = class("common_player_information_shell", G_BaseConfig)
local core = G_Tables.TDCommonPlayerInformationTable.GetInstance()

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
  show = 3
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getName(offset)
  local langStr = G_TableMgrIns:GetLangStr("common_player_information", core:GetVString(offset, this.indexMap.name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "name")
end

function this:_getType(offset)
  local str = core:GetVString(offset, this.indexMap.type).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getShow(offset)
  return core:GetInt(offset, this.indexMap.show)
end

this.keyToMethodsMap = {
  id = this._getId,
  name = this._getName,
  type = this._getType,
  show = this._getShow
}
return this
