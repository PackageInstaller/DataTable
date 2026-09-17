local this = class("stargift_shell", G_BaseConfig)
local core = G_Tables.TDStargiftTable.GetInstance()

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
  career = 2,
  heroId = 3,
  rarity = 4,
  attribute = 5,
  texture = 6,
  classicon = 7,
  note = 8
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getName(offset)
  local langStr = G_TableMgrIns:GetLangStr("stargift", core:GetVString(offset, this.indexMap.name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "name")
end

function this:_getCareer(offset)
  return core:GetInt(offset, this.indexMap.career)
end

function this:_getHeroid(offset)
  return core:GetInt(offset, this.indexMap.heroId)
end

function this:_getRarity(offset)
  return core:GetInt(offset, this.indexMap.rarity)
end

function this:_getAttribute(offset)
  local str = core:GetVString(offset, this.indexMap.attribute).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.dictionary, "number", "number")
end

function this:_getTexture(offset)
  local str = core:GetVString(offset, this.indexMap.texture).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getClassicon(offset)
  local str = core:GetVString(offset, this.indexMap.classicon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getNote(offset)
  local langStr = G_TableMgrIns:GetLangStr("stargift", core:GetVString(offset, this.indexMap.note))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "note")
end

this.keyToMethodsMap = {
  id = this._getId,
  name = this._getName,
  career = this._getCareer,
  heroId = this._getHeroid,
  rarity = this._getRarity,
  attribute = this._getAttribute,
  texture = this._getTexture,
  classicon = this._getClassicon,
  note = this._getNote
}
return this
