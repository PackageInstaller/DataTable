local this = class("char_voice_words_pet_shell", G_BaseConfig)
local core = G_Tables.TDCharVoiceWordsPetTable.GetInstance()

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
  AceReady = 2,
  ResponseBreak = 3,
  ResponseLowHP = 4,
  ResponseSkill = 5,
  PassiveSkill = 6,
  PuzzleTalk = 7,
  PuzzleElement = 8,
  InDanger = 9,
  Dying = 10,
  IntoBattle = 11,
  ResponseCharge = 12
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getName(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_pet", core:GetVString(offset, this.indexMap.name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "name")
end

function this:_getAceready(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_pet", core:GetVString(offset, this.indexMap.AceReady))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "AceReady")
end

function this:_getResponsebreak(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_pet", core:GetVString(offset, this.indexMap.ResponseBreak))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "ResponseBreak")
end

function this:_getResponselowhp(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_pet", core:GetVString(offset, this.indexMap.ResponseLowHP))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "ResponseLowHP")
end

function this:_getResponseskill(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_pet", core:GetVString(offset, this.indexMap.ResponseSkill))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "ResponseSkill")
end

function this:_getPassiveskill(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_pet", core:GetVString(offset, this.indexMap.PassiveSkill))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "PassiveSkill")
end

function this:_getPuzzletalk(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_pet", core:GetVString(offset, this.indexMap.PuzzleTalk))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "PuzzleTalk")
end

function this:_getPuzzleelement(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_pet", core:GetVString(offset, this.indexMap.PuzzleElement))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "PuzzleElement")
end

function this:_getIndanger(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_pet", core:GetVString(offset, this.indexMap.InDanger))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "InDanger")
end

function this:_getDying(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_pet", core:GetVString(offset, this.indexMap.Dying))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "Dying")
end

function this:_getIntobattle(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_pet", core:GetVString(offset, this.indexMap.IntoBattle))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "IntoBattle")
end

function this:_getResponsecharge(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_pet", core:GetVString(offset, this.indexMap.ResponseCharge))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "ResponseCharge")
end

this.keyToMethodsMap = {
  id = this._getId,
  name = this._getName,
  AceReady = this._getAceready,
  ResponseBreak = this._getResponsebreak,
  ResponseLowHP = this._getResponselowhp,
  ResponseSkill = this._getResponseskill,
  PassiveSkill = this._getPassiveskill,
  PuzzleTalk = this._getPuzzletalk,
  PuzzleElement = this._getPuzzleelement,
  InDanger = this._getIndanger,
  Dying = this._getDying,
  IntoBattle = this._getIntobattle,
  ResponseCharge = this._getResponsecharge
}
return this
