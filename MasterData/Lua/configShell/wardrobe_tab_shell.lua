local this = class("wardrobe_tab_shell", G_BaseConfig)
local core = G_Tables.TDWardrobeTabTable.GetInstance()

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
  name2 = 1,
  icon1 = 2
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getName2(offset)
  local langStr = G_TableMgrIns:GetLangStr("wardrobe_tab", core:GetVString(offset, this.indexMap.name2))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "name2")
end

function this:_getIcon1(offset)
  local str = core:GetVString(offset, this.indexMap.icon1).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

this.keyToMethodsMap = {
  id = this._getId,
  name2 = this._getName2,
  icon1 = this._getIcon1
}
return this
