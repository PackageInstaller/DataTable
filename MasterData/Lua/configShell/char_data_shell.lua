local this = class("char_data_shell", G_BaseConfig)
local core = G_Tables.TDCharDataTable.GetInstance()

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
  characterName = 1,
  characterBirthday = 2,
  characterGroup = 3,
  characterRace = 4,
  cvName = 5,
  cv_chs = 6,
  cv_jp = 7,
  cv_en = 8,
  cv_kr = 9,
  cv_cht = 10,
  introduction = 11,
  characterStory = 12,
  characterVoice = 13,
  characterPlot = 14
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getCharactername(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_data", core:GetVString(offset, this.indexMap.characterName))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "characterName")
end

function this:_getCharacterbirthday(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_data", core:GetVString(offset, this.indexMap.characterBirthday))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "characterBirthday")
end

function this:_getCharactergroup(offset)
  return core:GetInt(offset, this.indexMap.characterGroup)
end

function this:_getCharacterrace(offset)
  return core:GetInt(offset, this.indexMap.characterRace)
end

function this:_getCvname(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_data", core:GetVString(offset, this.indexMap.cvName))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "cvName")
end

function this:_getCv_chs(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_data", core:GetVString(offset, this.indexMap.cv_chs))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "cv_chs")
end

function this:_getCv_jp(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_data", core:GetVString(offset, this.indexMap.cv_jp))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "cv_jp")
end

function this:_getCv_en(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_data", core:GetVString(offset, this.indexMap.cv_en))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "cv_en")
end

function this:_getCv_kr(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_data", core:GetVString(offset, this.indexMap.cv_kr))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "cv_kr")
end

function this:_getCv_cht(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_data", core:GetVString(offset, this.indexMap.cv_cht))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "cv_cht")
end

function this:_getIntroduction(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_data", core:GetVString(offset, this.indexMap.introduction))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "introduction")
end

function this:_getCharacterstory(offset)
  local str = core:GetVString(offset, this.indexMap.characterStory).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getCharactervoice(offset)
  local str = core:GetVString(offset, this.indexMap.characterVoice).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getCharacterplot(offset)
  local str = core:GetVString(offset, this.indexMap.characterPlot).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

this.keyToMethodsMap = {
  id = this._getId,
  characterName = this._getCharactername,
  characterBirthday = this._getCharacterbirthday,
  characterGroup = this._getCharactergroup,
  characterRace = this._getCharacterrace,
  cvName = this._getCvname,
  cv_chs = this._getCv_chs,
  cv_jp = this._getCv_jp,
  cv_en = this._getCv_en,
  cv_kr = this._getCv_kr,
  cv_cht = this._getCv_cht,
  introduction = this._getIntroduction,
  characterStory = this._getCharacterstory,
  characterVoice = this._getCharactervoice,
  characterPlot = this._getCharacterplot
}
return this
