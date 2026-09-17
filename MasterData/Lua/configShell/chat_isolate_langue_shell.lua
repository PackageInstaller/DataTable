local this = class("chat_isolate_langue_shell", G_BaseConfig)
local core = G_Tables.TDChatIsolateLangueTable.GetInstance()

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
  isOpen = 1,
  isolateLangue = 2
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getIsopen(offset)
  return core:GetInt(offset, this.indexMap.isOpen)
end

function this:_getIsolatelangue(offset)
  local langStr = G_TableMgrIns:GetLangStr("chat_isolate_langue", core:GetVString(offset, this.indexMap.isolateLangue))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "isolateLangue")
end

this.keyToMethodsMap = {
  id = this._getId,
  isOpen = this._getIsopen,
  isolateLangue = this._getIsolatelangue
}
return this
