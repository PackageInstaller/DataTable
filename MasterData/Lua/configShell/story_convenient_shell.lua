local this = class("story_convenient_shell", G_BaseConfig)
local core = G_Tables.TDStoryConvenientTable.GetInstance()

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
  story_id = 1,
  type = 2,
  Next_ID = 3,
  hero_id = 4,
  Speaker_Name = 5,
  Dialog_Detail = 6,
  Option1 = 7,
  Option1_GotoiD = 8,
  Option2 = 9,
  Option2_GotoiD = 10,
  Option3 = 11,
  Option3_GotoiD = 12,
  Option4 = 13,
  Option4_GotoiD = 14,
  Option5 = 15,
  Option5_GotoiD = 16,
  player_position = 17,
  player_rotation = 18,
  turn = 19,
  ForceDismount = 20,
  play_anim = 21,
  expandld = 22,
  expandParams = 23,
  tag_id = 24,
  type_callback = 25,
  VoiceEventId = 26,
  sound = 27,
  VoiceNpcType = 28,
  VoiceNpcId = 29
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getStory_id(offset)
  return core:GetInt(offset, this.indexMap.story_id)
end

function this:_getType(offset)
  return core:GetInt(offset, this.indexMap.type)
end

function this:_getNext_id(offset)
  return core:GetVString(offset, this.indexMap.Next_ID).value
end

function this:_getHero_id(offset)
  return core:GetVString(offset, this.indexMap.hero_id).value
end

function this:_getSpeaker_name(offset)
  local langStr = G_TableMgrIns:GetLangStr("story_convenient", core:GetVString(offset, this.indexMap.Speaker_Name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "Speaker_Name")
end

function this:_getDialog_detail(offset)
  local langStr = G_TableMgrIns:GetLangStr("story_convenient", core:GetVString(offset, this.indexMap.Dialog_Detail))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "Dialog_Detail")
end

function this:_getOption1(offset)
  local langStr = G_TableMgrIns:GetLangStr("story_convenient", core:GetVString(offset, this.indexMap.Option1))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "Option1")
end

function this:_getOption1_gotoid(offset)
  return core:GetInt(offset, this.indexMap.Option1_GotoiD)
end

function this:_getOption2(offset)
  local langStr = G_TableMgrIns:GetLangStr("story_convenient", core:GetVString(offset, this.indexMap.Option2))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "Option2")
end

function this:_getOption2_gotoid(offset)
  return core:GetInt(offset, this.indexMap.Option2_GotoiD)
end

function this:_getOption3(offset)
  local langStr = G_TableMgrIns:GetLangStr("story_convenient", core:GetVString(offset, this.indexMap.Option3))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "Option3")
end

function this:_getOption3_gotoid(offset)
  return core:GetInt(offset, this.indexMap.Option3_GotoiD)
end

function this:_getOption4(offset)
  local langStr = G_TableMgrIns:GetLangStr("story_convenient", core:GetVString(offset, this.indexMap.Option4))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "Option4")
end

function this:_getOption4_gotoid(offset)
  return core:GetInt(offset, this.indexMap.Option4_GotoiD)
end

function this:_getOption5(offset)
  local langStr = G_TableMgrIns:GetLangStr("story_convenient", core:GetVString(offset, this.indexMap.Option5))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "Option5")
end

function this:_getOption5_gotoid(offset)
  return core:GetInt(offset, this.indexMap.Option5_GotoiD)
end

function this:_getPlayer_position(offset)
  local str = core:GetVString(offset, this.indexMap.player_position).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getPlayer_rotation(offset)
  local str = core:GetVString(offset, this.indexMap.player_rotation).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getTurn(offset)
  return core:GetVString(offset, this.indexMap.turn).value
end

function this:_getForcedismount(offset)
  return core:GetInt(offset, this.indexMap.ForceDismount)
end

function this:_getPlay_anim(offset)
  return core:GetVString(offset, this.indexMap.play_anim).value
end

function this:_getExpandld(offset)
  return core:GetInt(offset, this.indexMap.expandld)
end

function this:_getExpandparams(offset)
  return core:GetVString(offset, this.indexMap.expandParams).value
end

function this:_getTag_id(offset)
  return core:GetInt(offset, this.indexMap.tag_id)
end

function this:_getType_callback(offset)
  return core:GetInt(offset, this.indexMap.type_callback)
end

function this:_getVoiceeventid(offset)
  return core:GetVString(offset, this.indexMap.VoiceEventId).value
end

function this:_getSound(offset)
  return core:GetVString(offset, this.indexMap.sound).value
end

function this:_getVoicenpctype(offset)
  return core:GetInt(offset, this.indexMap.VoiceNpcType)
end

function this:_getVoicenpcid(offset)
  local str = core:GetVString(offset, this.indexMap.VoiceNpcId).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

this.keyToMethodsMap = {
  id = this._getId,
  story_id = this._getStory_id,
  type = this._getType,
  Next_ID = this._getNext_id,
  hero_id = this._getHero_id,
  Speaker_Name = this._getSpeaker_name,
  Dialog_Detail = this._getDialog_detail,
  Option1 = this._getOption1,
  Option1_GotoiD = this._getOption1_gotoid,
  Option2 = this._getOption2,
  Option2_GotoiD = this._getOption2_gotoid,
  Option3 = this._getOption3,
  Option3_GotoiD = this._getOption3_gotoid,
  Option4 = this._getOption4,
  Option4_GotoiD = this._getOption4_gotoid,
  Option5 = this._getOption5,
  Option5_GotoiD = this._getOption5_gotoid,
  player_position = this._getPlayer_position,
  player_rotation = this._getPlayer_rotation,
  turn = this._getTurn,
  ForceDismount = this._getForcedismount,
  play_anim = this._getPlay_anim,
  expandld = this._getExpandld,
  expandParams = this._getExpandparams,
  tag_id = this._getTag_id,
  type_callback = this._getType_callback,
  VoiceEventId = this._getVoiceeventid,
  sound = this._getSound,
  VoiceNpcType = this._getVoicenpctype,
  VoiceNpcId = this._getVoicenpcid
}
return this
