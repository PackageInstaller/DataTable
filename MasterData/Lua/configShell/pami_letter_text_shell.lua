local this = class("pami_letter_text_shell", G_BaseConfig)
local core = G_Tables.TDPamiLetterTextTable.GetInstance()

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
  letterId = 1,
  recipient = 2,
  text = 3,
  sign = 4,
  reward = 5,
  pic = 6,
  voice = 7,
  time = 8,
  jumpId = 9,
  jumpText = 10,
  teamId = 11,
  isEnd = 12
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getLetterid(offset)
  return core:GetInt(offset, this.indexMap.letterId)
end

function this:_getRecipient(offset)
  local langStr = G_TableMgrIns:GetLangStr("pami_letter_text", core:GetVString(offset, this.indexMap.recipient))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "recipient")
end

function this:_getText(offset)
  local langStr = G_TableMgrIns:GetLangStr("pami_letter_text", core:GetVString(offset, this.indexMap.text))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "text")
end

function this:_getSign(offset)
  local langStr = G_TableMgrIns:GetLangStr("pami_letter_text", core:GetVString(offset, this.indexMap.sign))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "sign")
end

function this:_getReward(offset)
  local str = core:GetVString(offset, this.indexMap.reward).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getPic(offset)
  local str = core:GetVString(offset, this.indexMap.pic).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getVoice(offset)
  return core:GetVString(offset, this.indexMap.voice).value
end

function this:_getTime(offset)
  return core:GetInt(offset, this.indexMap.time)
end

function this:_getJumpid(offset)
  return core:GetInt(offset, this.indexMap.jumpId)
end

function this:_getJumptext(offset)
  local langStr = G_TableMgrIns:GetLangStr("pami_letter_text", core:GetVString(offset, this.indexMap.jumpText))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "jumpText")
end

function this:_getTeamid(offset)
  return core:GetInt(offset, this.indexMap.teamId)
end

function this:_getIsend(offset)
  return core:GetInt(offset, this.indexMap.isEnd)
end

this.keyToMethodsMap = {
  id = this._getId,
  letterId = this._getLetterid,
  recipient = this._getRecipient,
  text = this._getText,
  sign = this._getSign,
  reward = this._getReward,
  pic = this._getPic,
  voice = this._getVoice,
  time = this._getTime,
  jumpId = this._getJumpid,
  jumpText = this._getJumptext,
  teamId = this._getTeamid,
  isEnd = this._getIsend
}
return this
