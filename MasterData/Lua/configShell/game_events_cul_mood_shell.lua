local this = class("game_events_cul_mood_shell", G_BaseConfig)
local core = G_Tables.TDGameEventsCulMoodTable.GetInstance()

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
  moodLevel = 1,
  systemId = 2,
  moodName = 3,
  moodDesc = 4,
  moodModifier = 5,
  iconBg = 6,
  iconEmoji = 7,
  iconArrow = 8
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getMoodlevel(offset)
  return core:GetInt(offset, this.indexMap.moodLevel)
end

function this:_getSystemid(offset)
  return core:GetInt(offset, this.indexMap.systemId)
end

function this:_getMoodname(offset)
  local langStr = G_TableMgrIns:GetLangStr("game_events_cul_mood", core:GetVString(offset, this.indexMap.moodName))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "moodName")
end

function this:_getMooddesc(offset)
  local langStr = G_TableMgrIns:GetLangStr("game_events_cul_mood", core:GetVString(offset, this.indexMap.moodDesc))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "moodDesc")
end

function this:_getMoodmodifier(offset)
  return core:GetInt(offset, this.indexMap.moodModifier)
end

function this:_getIconbg(offset)
  local str = core:GetVString(offset, this.indexMap.iconBg).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getIconemoji(offset)
  local str = core:GetVString(offset, this.indexMap.iconEmoji).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getIconarrow(offset)
  local str = core:GetVString(offset, this.indexMap.iconArrow).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

this.keyToMethodsMap = {
  id = this._getId,
  moodLevel = this._getMoodlevel,
  systemId = this._getSystemid,
  moodName = this._getMoodname,
  moodDesc = this._getMooddesc,
  moodModifier = this._getMoodmodifier,
  iconBg = this._getIconbg,
  iconEmoji = this._getIconemoji,
  iconArrow = this._getIconarrow
}
return this
