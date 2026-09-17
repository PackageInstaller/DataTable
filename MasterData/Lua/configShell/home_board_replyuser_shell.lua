local this = class("home_board_replyuser_shell", G_BaseConfig)
local core = G_Tables.TDHomeBoardReplyuserTable.GetInstance()

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
  group = 1,
  message = 2,
  Path = 3,
  replyHeroId = 4
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getGroup(offset)
  return core:GetInt(offset, this.indexMap.group)
end

function this:_getMessage(offset)
  local langStr = G_TableMgrIns:GetLangStr("home_board_replyuser", core:GetVString(offset, this.indexMap.message))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "message")
end

function this:_getPath(offset)
  local str = core:GetVString(offset, this.indexMap.Path).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getReplyheroid(offset)
  return core:GetInt(offset, this.indexMap.replyHeroId)
end

this.keyToMethodsMap = {
  id = this._getId,
  group = this._getGroup,
  message = this._getMessage,
  Path = this._getPath,
  replyHeroId = this._getReplyheroid
}
return this
