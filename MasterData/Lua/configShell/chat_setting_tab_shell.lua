local this = class("chat_setting_tab_shell", G_BaseConfig)
local core = G_Tables.TDChatSettingTabTable.GetInstance()

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
  sort = 2
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getName(offset)
  local langStr = G_TableMgrIns:GetLangStr("chat_setting_tab", core:GetVString(offset, this.indexMap.name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "name")
end

function this:_getSort(offset)
  return core:GetInt(offset, this.indexMap.sort)
end

this.keyToMethodsMap = {
  id = this._getId,
  name = this._getName,
  sort = this._getSort
}
return this
