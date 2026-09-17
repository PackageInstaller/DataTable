local this = class("pet_level_decay_shell", G_BaseConfig)
local core = G_Tables.TDPetLevelDecayTable.GetInstance()

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
  lvDif = 1,
  normalSkillFail = 2,
  normalAttriDown = 3,
  eliteSkillFail = 4,
  eliteAttriDown = 5,
  bossSkillFail = 6,
  bossAttriDown = 7,
  normalCatchDeacy = 8,
  elitelCatchDeacy = 9,
  bossCatchDeacy = 10
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getLvdif(offset)
  return core:GetInt(offset, this.indexMap.lvDif)
end

function this:_getNormalskillfail(offset)
  return core:GetInt(offset, this.indexMap.normalSkillFail)
end

function this:_getNormalattridown(offset)
  return core:GetInt(offset, this.indexMap.normalAttriDown)
end

function this:_getEliteskillfail(offset)
  return core:GetInt(offset, this.indexMap.eliteSkillFail)
end

function this:_getEliteattridown(offset)
  return core:GetInt(offset, this.indexMap.eliteAttriDown)
end

function this:_getBossskillfail(offset)
  return core:GetInt(offset, this.indexMap.bossSkillFail)
end

function this:_getBossattridown(offset)
  return core:GetInt(offset, this.indexMap.bossAttriDown)
end

function this:_getNormalcatchdeacy(offset)
  return core:GetInt(offset, this.indexMap.normalCatchDeacy)
end

function this:_getElitelcatchdeacy(offset)
  return core:GetInt(offset, this.indexMap.elitelCatchDeacy)
end

function this:_getBosscatchdeacy(offset)
  return core:GetInt(offset, this.indexMap.bossCatchDeacy)
end

this.keyToMethodsMap = {
  id = this._getId,
  lvDif = this._getLvdif,
  normalSkillFail = this._getNormalskillfail,
  normalAttriDown = this._getNormalattridown,
  eliteSkillFail = this._getEliteskillfail,
  eliteAttriDown = this._getEliteattridown,
  bossSkillFail = this._getBossskillfail,
  bossAttriDown = this._getBossattridown,
  normalCatchDeacy = this._getNormalcatchdeacy,
  elitelCatchDeacy = this._getElitelcatchdeacy,
  bossCatchDeacy = this._getBosscatchdeacy
}
return this
