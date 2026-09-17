local this = class("wardrobe_tab_second_shell", G_BaseConfig)
local core = G_Tables.TDWardrobeTabSecondTable.GetInstance()

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
  name = 1,
  icon2 = 2
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.Id)
end

function this:_getName(offset)
  local langStr = G_TableMgrIns:GetLangStr("wardrobe_tab_second", core:GetVString(offset, this.indexMap.name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "name")
end

function this:_getIcon2(offset)
  local str = core:GetVString(offset, this.indexMap.icon2).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

this.keyToMethodsMap = {
  Id = this._getId,
  name = this._getName,
  icon2 = this._getIcon2
}
return this
