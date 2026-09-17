local this = class("home_board_message_shell", G_BaseConfig)
local core = G_Tables.TDHomeBoardMessageTable.GetInstance()

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
  heroId = 1,
  day = 2,
  title = 3,
  text = 4,
  pic = 5,
  unlockCondi = 6,
  replyId = 7,
  replyUser = 8
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getHeroid(offset)
  return core:GetInt(offset, this.indexMap.heroId)
end

function this:_getDay(offset)
  return core:GetInt(offset, this.indexMap.day)
end

function this:_getTitle(offset)
  local langStr = G_TableMgrIns:GetLangStr("home_board_message", core:GetVString(offset, this.indexMap.title))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "title")
end

function this:_getText(offset)
  local langStr = G_TableMgrIns:GetLangStr("home_board_message", core:GetVString(offset, this.indexMap.text))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "text")
end

function this:_getPic(offset)
  local str = core:GetVString(offset, this.indexMap.pic).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getUnlockcondi(offset)
  local str = core:GetVString(offset, this.indexMap.unlockCondi).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getReplyid(offset)
  return core:GetInt(offset, this.indexMap.replyId)
end

function this:_getReplyuser(offset)
  return core:GetInt(offset, this.indexMap.replyUser)
end

this.keyToMethodsMap = {
  id = this._getId,
  heroId = this._getHeroid,
  day = this._getDay,
  title = this._getTitle,
  text = this._getText,
  pic = this._getPic,
  unlockCondi = this._getUnlockcondi,
  replyId = this._getReplyid,
  replyUser = this._getReplyuser
}
return this
