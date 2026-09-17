local this = class("char_voice_hero_tab_shell", G_BaseConfig)
local core = G_Tables.TDCharVoiceHeroTabTable.GetInstance()

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
  detailsVoice = 2,
  detailsDelay = 3,
  skillVoice = 4,
  skillDelay = 5,
  talentVoice = 6,
  talentDelay = 7,
  equipVoice = 8,
  equipDelay = 9,
  soulessenceVoice = 10,
  soulessenceDelay = 11,
  breakVoice = 12,
  breakDelay = 13,
  dataVoice = 14,
  dataDelay = 15
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getName(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_hero_tab", core:GetVString(offset, this.indexMap.name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "name")
end

function this:_getDetailsvoice(offset)
  return core:GetVString(offset, this.indexMap.detailsVoice).value
end

function this:_getDetailsdelay(offset)
  return core:GetInt(offset, this.indexMap.detailsDelay)
end

function this:_getSkillvoice(offset)
  return core:GetVString(offset, this.indexMap.skillVoice).value
end

function this:_getSkilldelay(offset)
  return core:GetInt(offset, this.indexMap.skillDelay)
end

function this:_getTalentvoice(offset)
  return core:GetVString(offset, this.indexMap.talentVoice).value
end

function this:_getTalentdelay(offset)
  return core:GetInt(offset, this.indexMap.talentDelay)
end

function this:_getEquipvoice(offset)
  return core:GetVString(offset, this.indexMap.equipVoice).value
end

function this:_getEquipdelay(offset)
  return core:GetInt(offset, this.indexMap.equipDelay)
end

function this:_getSoulessencevoice(offset)
  return core:GetVString(offset, this.indexMap.soulessenceVoice).value
end

function this:_getSoulessencedelay(offset)
  return core:GetInt(offset, this.indexMap.soulessenceDelay)
end

function this:_getBreakvoice(offset)
  return core:GetVString(offset, this.indexMap.breakVoice).value
end

function this:_getBreakdelay(offset)
  return core:GetInt(offset, this.indexMap.breakDelay)
end

function this:_getDatavoice(offset)
  return core:GetVString(offset, this.indexMap.dataVoice).value
end

function this:_getDatadelay(offset)
  return core:GetInt(offset, this.indexMap.dataDelay)
end

this.keyToMethodsMap = {
  id = this._getId,
  name = this._getName,
  detailsVoice = this._getDetailsvoice,
  detailsDelay = this._getDetailsdelay,
  skillVoice = this._getSkillvoice,
  skillDelay = this._getSkilldelay,
  talentVoice = this._getTalentvoice,
  talentDelay = this._getTalentdelay,
  equipVoice = this._getEquipvoice,
  equipDelay = this._getEquipdelay,
  soulessenceVoice = this._getSoulessencevoice,
  soulessenceDelay = this._getSoulessencedelay,
  breakVoice = this._getBreakvoice,
  breakDelay = this._getBreakdelay,
  dataVoice = this._getDatavoice,
  dataDelay = this._getDatadelay
}
return this
