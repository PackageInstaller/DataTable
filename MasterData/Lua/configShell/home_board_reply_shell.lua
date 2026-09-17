local this = class("home_board_reply_shell", G_BaseConfig)
local core = G_Tables.TDHomeBoardReplyTable.GetInstance()

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
  heroId = 2,
  message = 3,
  delay = 4,
  pic = 5
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getGroup(offset)
  return core:GetInt(offset, this.indexMap.group)
end

function this:_getHeroid(offset)
  return core:GetInt(offset, this.indexMap.heroId)
end

function this:_getMessage(offset)
  local langStr = G_TableMgrIns:GetLangStr("home_board_reply", core:GetVString(offset, this.indexMap.message))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "message")
end

function this:_getDelay(offset)
  return core:GetInt(offset, this.indexMap.delay)
end

function this:_getPic(offset)
  local str = core:GetVString(offset, this.indexMap.pic).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

this.keyToMethodsMap = {
  id = this._getId,
  group = this._getGroup,
  heroId = this._getHeroid,
  message = this._getMessage,
  delay = this._getDelay,
  pic = this._getPic
}
return this
