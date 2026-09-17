local this = class("costume_tab_shell", G_BaseConfig)
local core = G_Tables.TDCostumeTabTable.GetInstance()

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
  Id = 0,
  Name = 1,
  Icon = 2,
  key_1 = 3,
  key_2 = 4,
  text = 5
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.Id)
end

function this:_getName(offset)
  local langStr = G_TableMgrIns:GetLangStr("costume_tab", core:GetVString(offset, this.indexMap.Name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "Name")
end

function this:_getIcon(offset)
  return core:GetVString(offset, this.indexMap.Icon).value
end

function this:_getKey_1(offset)
  return core:GetVString(offset, this.indexMap.key_1).value
end

function this:_getKey_2(offset)
  return core:GetVString(offset, this.indexMap.key_2).value
end

function this:_getText(offset)
  local langStr = G_TableMgrIns:GetLangStr("costume_tab", core:GetVString(offset, this.indexMap.text))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "text")
end

this.keyToMethodsMap = {
  Id = this._getId,
  Name = this._getName,
  Icon = this._getIcon,
  key_1 = this._getKey_1,
  key_2 = this._getKey_2,
  text = this._getText
}
return this
