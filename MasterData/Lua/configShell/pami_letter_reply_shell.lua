local this = class("pami_letter_reply_shell", G_BaseConfig)
local core = G_Tables.TDPamiLetterReplyTable.GetInstance()

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
  teamId = 1,
  choiceTitle = 2,
  recipient = 3,
  text = 4,
  sign = 5,
  pic = 6,
  textId = 7
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getTeamid(offset)
  return core:GetInt(offset, this.indexMap.teamId)
end

function this:_getChoicetitle(offset)
  local langStr = G_TableMgrIns:GetLangStr("pami_letter_reply", core:GetVString(offset, this.indexMap.choiceTitle))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "choiceTitle")
end

function this:_getRecipient(offset)
  local langStr = G_TableMgrIns:GetLangStr("pami_letter_reply", core:GetVString(offset, this.indexMap.recipient))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "recipient")
end

function this:_getText(offset)
  local langStr = G_TableMgrIns:GetLangStr("pami_letter_reply", core:GetVString(offset, this.indexMap.text))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "text")
end

function this:_getSign(offset)
  local langStr = G_TableMgrIns:GetLangStr("pami_letter_reply", core:GetVString(offset, this.indexMap.sign))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "sign")
end

function this:_getPic(offset)
  local str = core:GetVString(offset, this.indexMap.pic).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getTextid(offset)
  return core:GetInt(offset, this.indexMap.textId)
end

this.keyToMethodsMap = {
  id = this._getId,
  teamId = this._getTeamid,
  choiceTitle = this._getChoicetitle,
  recipient = this._getRecipient,
  text = this._getText,
  sign = this._getSign,
  pic = this._getPic,
  textId = this._getTextid
}
return this
