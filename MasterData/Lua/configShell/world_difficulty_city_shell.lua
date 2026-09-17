local this = class("world_difficulty_city_shell", G_BaseConfig)
local core = G_Tables.TDWorldDifficultyCityTable.GetInstance()

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
  mapid = 1,
  difficultLv = 2,
  name = 3,
  modifierTitle = 4,
  desc = 5,
  condition = 6,
  dnaPoolList = 7,
  addPet = 8,
  petAbilityTop = 9
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getMapid(offset)
  return core:GetInt(offset, this.indexMap.mapid)
end

function this:_getDifficultlv(offset)
  return core:GetInt(offset, this.indexMap.difficultLv)
end

function this:_getName(offset)
  local langStr = G_TableMgrIns:GetLangStr("world_difficulty_city", core:GetVString(offset, this.indexMap.name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "name")
end

function this:_getModifiertitle(offset)
  local langStrList = G_TableMgrIns:GetListLangStr("world_difficulty_city", core:GetVString(offset, this.indexMap.modifierTitle))
  return G_ConfigParser.ParseConfigStr(langStrList, G_ConfigConst.ParseType.listLangstring, "world_difficulty_city")
end

function this:_getDesc(offset)
  local langStr = G_TableMgrIns:GetLangStr("world_difficulty_city", core:GetVString(offset, this.indexMap.desc))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "desc")
end

function this:_getCondition(offset)
  local str = core:GetVString(offset, this.indexMap.condition).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.listCondition)
end

function this:_getDnapoollist(offset)
  local str = core:GetVString(offset, this.indexMap.dnaPoolList).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getAddpet(offset)
  local str = core:GetVString(offset, this.indexMap.addPet).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getPetabilitytop(offset)
  local str = core:GetVString(offset, this.indexMap.petAbilityTop).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

this.keyToMethodsMap = {
  id = this._getId,
  mapid = this._getMapid,
  difficultLv = this._getDifficultlv,
  name = this._getName,
  modifierTitle = this._getModifiertitle,
  desc = this._getDesc,
  condition = this._getCondition,
  dnaPoolList = this._getDnapoollist,
  addPet = this._getAddpet,
  petAbilityTop = this._getPetabilitytop
}
return this
