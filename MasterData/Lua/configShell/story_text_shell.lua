local this = class("story_text_shell", G_BaseConfig)
local core = G_Tables.TDStoryTextTable.GetInstance()

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
  Type = 1,
  Speaker_Name = 2,
  Dialog_Detail = 3,
  VoiceEventId = 4,
  Option0 = 5,
  Option1 = 6,
  Option2 = 7,
  Option3 = 8,
  Option4 = 9,
  Option5 = 10,
  Option6 = 11,
  Option7 = 12
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getType(offset)
  return core:GetInt(offset, this.indexMap.Type)
end

function this:_getSpeaker_name(offset)
  local langStr = G_TableMgrIns:GetLangStr("story_text", core:GetVString(offset, this.indexMap.Speaker_Name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "Speaker_Name")
end

function this:_getDialog_detail(offset)
  local langStr = G_TableMgrIns:GetLangStr("story_text", core:GetVString(offset, this.indexMap.Dialog_Detail))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "Dialog_Detail")
end

function this:_getVoiceeventid(offset)
  return core:GetVString(offset, this.indexMap.VoiceEventId).value
end

function this:_getOption0(offset)
  local langStr = G_TableMgrIns:GetLangStr("story_text", core:GetVString(offset, this.indexMap.Option0))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "Option0")
end

function this:_getOption1(offset)
  local langStr = G_TableMgrIns:GetLangStr("story_text", core:GetVString(offset, this.indexMap.Option1))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "Option1")
end

function this:_getOption2(offset)
  local langStr = G_TableMgrIns:GetLangStr("story_text", core:GetVString(offset, this.indexMap.Option2))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "Option2")
end

function this:_getOption3(offset)
  local langStr = G_TableMgrIns:GetLangStr("story_text", core:GetVString(offset, this.indexMap.Option3))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "Option3")
end

function this:_getOption4(offset)
  local langStr = G_TableMgrIns:GetLangStr("story_text", core:GetVString(offset, this.indexMap.Option4))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "Option4")
end

function this:_getOption5(offset)
  local langStr = G_TableMgrIns:GetLangStr("story_text", core:GetVString(offset, this.indexMap.Option5))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "Option5")
end

function this:_getOption6(offset)
  local langStr = G_TableMgrIns:GetLangStr("story_text", core:GetVString(offset, this.indexMap.Option6))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "Option6")
end

function this:_getOption7(offset)
  local langStr = G_TableMgrIns:GetLangStr("story_text", core:GetVString(offset, this.indexMap.Option7))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "Option7")
end

this.keyToMethodsMap = {
  id = this._getId,
  Type = this._getType,
  Speaker_Name = this._getSpeaker_name,
  Dialog_Detail = this._getDialog_detail,
  VoiceEventId = this._getVoiceeventid,
  Option0 = this._getOption0,
  Option1 = this._getOption1,
  Option2 = this._getOption2,
  Option3 = this._getOption3,
  Option4 = this._getOption4,
  Option5 = this._getOption5,
  Option6 = this._getOption6,
  Option7 = this._getOption7
}
return this
