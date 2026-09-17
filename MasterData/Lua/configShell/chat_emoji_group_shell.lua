local this = class("chat_emoji_group_shell", G_BaseConfig)
local core = G_Tables.TDChatEmojiGroupTable.GetInstance()

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
  groupId = 0,
  icon = 1,
  name = 2
}

function this:_getGroupid(offset)
  return core:GetInt(offset, this.indexMap.groupId)
end

function this:_getIcon(offset)
  local str = core:GetVString(offset, this.indexMap.icon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getName(offset)
  local langStr = G_TableMgrIns:GetLangStr("chat_emoji_group", core:GetVString(offset, this.indexMap.name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "name")
end

this.keyToMethodsMap = {
  groupId = this._getGroupid,
  icon = this._getIcon,
  name = this._getName
}
return this
