local this = class("pet_egg_shell", G_BaseConfig)
local core = G_Tables.TDPetEggTable.GetInstance()

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
  rare = 2,
  affixweight = 3,
  affixquantityweight = 4,
  petBuilderRuleId = 5,
  eggse = 6,
  probList = 7,
  desc = 8,
  specialDesc = 9,
  element = 10,
  eggImg = 11,
  PetEggSpinePrefab = 12,
  unitId = 13,
  worldItemId = 14,
  incubateGroup = 15,
  eggScale = 16,
  exchange = 17,
  petProb = 18,
  incubatePerform = 19,
  product = 20,
  rarity = 21,
  tag = 22,
  maxNum = 23,
  stackNum = 24,
  existType = 25,
  existNum = 26,
  useType = 27,
  bagType = 28,
  eggTime = 29,
  technologyExp = 30,
  satietyScore = 31
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getName(offset)
  local langStr = G_TableMgrIns:GetLangStr("pet_egg", core:GetVString(offset, this.indexMap.name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "name")
end

function this:_getRare(offset)
  return core:GetInt(offset, this.indexMap.rare)
end

function this:_getAffixweight(offset)
  local str = core:GetVString(offset, this.indexMap.affixweight).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getAffixquantityweight(offset)
  local str = core:GetVString(offset, this.indexMap.affixquantityweight).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getPetbuilderruleid(offset)
  return core:GetInt(offset, this.indexMap.petBuilderRuleId)
end

function this:_getEggse(offset)
  local str = core:GetVString(offset, this.indexMap.eggse).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getProblist(offset)
  return core:GetInt(offset, this.indexMap.probList)
end

function this:_getDesc(offset)
  local langStr = G_TableMgrIns:GetLangStr("pet_egg", core:GetVString(offset, this.indexMap.desc))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "desc")
end

function this:_getSpecialdesc(offset)
  local langStr = G_TableMgrIns:GetLangStr("pet_egg", core:GetVString(offset, this.indexMap.specialDesc))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "specialDesc")
end

function this:_getElement(offset)
  return core:GetInt(offset, this.indexMap.element)
end

function this:_getEggimg(offset)
  local str = core:GetVString(offset, this.indexMap.eggImg).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 3)
end

function this:_getPeteggspineprefab(offset)
  local str = core:GetVString(offset, this.indexMap.PetEggSpinePrefab).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getUnitid(offset)
  return core:GetInt(offset, this.indexMap.unitId)
end

function this:_getWorlditemid(offset)
  return core:GetInt(offset, this.indexMap.worldItemId)
end

function this:_getIncubategroup(offset)
  return core:GetInt(offset, this.indexMap.incubateGroup)
end

function this:_getEggscale(offset)
  return core:GetInt(offset, this.indexMap.eggScale)
end

function this:_getExchange(offset)
  local str = core:GetVString(offset, this.indexMap.exchange).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getPetprob(offset)
  local str = core:GetVString(offset, this.indexMap.petProb).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.dictionary, "number", "number")
end

function this:_getIncubateperform(offset)
  local str = core:GetVString(offset, this.indexMap.incubatePerform).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getProduct(offset)
  return core:GetInt(offset, this.indexMap.product)
end

function this:_getRarity(offset)
  return core:GetInt(offset, this.indexMap.rarity)
end

function this:_getTag(offset)
  local langStrList = G_TableMgrIns:GetListLangStr("pet_egg", core:GetVString(offset, this.indexMap.tag))
  return G_ConfigParser.ParseConfigStr(langStrList, G_ConfigConst.ParseType.listLangstring, "pet_egg")
end

function this:_getMaxnum(offset)
  return core:GetInt(offset, this.indexMap.maxNum)
end

function this:_getStacknum(offset)
  return core:GetInt(offset, this.indexMap.stackNum)
end

function this:_getExisttype(offset)
  return core:GetInt(offset, this.indexMap.existType)
end

function this:_getExistnum(offset)
  return core:GetInt(offset, this.indexMap.existNum)
end

function this:_getUsetype(offset)
  return core:GetInt(offset, this.indexMap.useType)
end

function this:_getBagtype(offset)
  return core:GetInt(offset, this.indexMap.bagType)
end

function this:_getEggtime(offset)
  return core:GetInt(offset, this.indexMap.eggTime)
end

function this:_getTechnologyexp(offset)
  local str = core:GetVString(offset, this.indexMap.technologyExp).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getSatietyscore(offset)
  return core:GetInt(offset, this.indexMap.satietyScore)
end

this.keyToMethodsMap = {
  id = this._getId,
  name = this._getName,
  rare = this._getRare,
  affixweight = this._getAffixweight,
  affixquantityweight = this._getAffixquantityweight,
  petBuilderRuleId = this._getPetbuilderruleid,
  eggse = this._getEggse,
  probList = this._getProblist,
  desc = this._getDesc,
  specialDesc = this._getSpecialdesc,
  element = this._getElement,
  eggImg = this._getEggimg,
  PetEggSpinePrefab = this._getPeteggspineprefab,
  unitId = this._getUnitid,
  worldItemId = this._getWorlditemid,
  incubateGroup = this._getIncubategroup,
  eggScale = this._getEggscale,
  exchange = this._getExchange,
  petProb = this._getPetprob,
  incubatePerform = this._getIncubateperform,
  product = this._getProduct,
  rarity = this._getRarity,
  tag = this._getTag,
  maxNum = this._getMaxnum,
  stackNum = this._getStacknum,
  existType = this._getExisttype,
  existNum = this._getExistnum,
  useType = this._getUsetype,
  bagType = this._getBagtype,
  eggTime = this._getEggtime,
  technologyExp = this._getTechnologyexp,
  satietyScore = this._getSatietyscore
}
return this
