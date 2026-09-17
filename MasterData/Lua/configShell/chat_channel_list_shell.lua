local this = class("chat_channel_list_shell", G_BaseConfig)
local core = G_Tables.TDChatChannelListTable.GetInstance()

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
  systemId = 2,
  show = 3
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getName(offset)
  local langStr = G_TableMgrIns:GetLangStr("chat_channel_list", core:GetVString(offset, this.indexMap.name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "name")
end

function this:_getSystemid(offset)
  return core:GetInt(offset, this.indexMap.systemId)
end

function this:_getShow(offset)
  return core:GetInt(offset, this.indexMap.show)
end

this.keyToMethodsMap = {
  id = this._getId,
  name = this._getName,
  systemId = this._getSystemid,
  show = this._getShow
}
return this
