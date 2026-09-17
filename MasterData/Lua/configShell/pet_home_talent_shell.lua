local this = class("pet_home_talent_shell", G_BaseConfig)
local core = G_Tables.TDPetHomeTalentTable.GetInstance()

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
  sizeType = 1,
  laborType = 2,
  laborScoreLimit = 3,
  laborScoreUpperLimit = 4,
  talentGroupId = 5,
  croplandTalentRadius = 6,
  homeSkillList = 7,
  homeNormalSkillList = 8,
  homePetRestSkill = 9,
  homePetRunSkill = 10,
  farmProducts = 11,
  satietyScore = 12,
  waterSpeed = 13,
  feedSpeed = 14,
  moveSpeed = 15,
  isRecommend = 16,
  technologyExp = 17,
  farm_exp = 18
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getSizetype(offset)
  return core:GetInt(offset, this.indexMap.sizeType)
end

function this:_getLabortype(offset)
  local str = core:GetVString(offset, this.indexMap.laborType).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getLaborscorelimit(offset)
  local str = core:GetVString(offset, this.indexMap.laborScoreLimit).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getLaborscoreupperlimit(offset)
  local str = core:GetVString(offset, this.indexMap.laborScoreUpperLimit).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getTalentgroupid(offset)
  local str = core:GetVString(offset, this.indexMap.talentGroupId).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getCroplandtalentradius(offset)
  local str = core:GetVString(offset, this.indexMap.croplandTalentRadius).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getHomeskilllist(offset)
  local str = core:GetVString(offset, this.indexMap.homeSkillList).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.dictionary, "number", "number")
end

function this:_getHomenormalskilllist(offset)
  local str = core:GetVString(offset, this.indexMap.homeNormalSkillList).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.dictionary, "number", "number")
end

function this:_getHomepetrestskill(offset)
  local str = core:GetVString(offset, this.indexMap.homePetRestSkill).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getHomepetrunskill(offset)
  local str = core:GetVString(offset, this.indexMap.homePetRunSkill).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getFarmproducts(offset)
  local str = core:GetVString(offset, this.indexMap.farmProducts).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getSatietyscore(offset)
  return core:GetInt(offset, this.indexMap.satietyScore)
end

function this:_getWaterspeed(offset)
  return core:GetInt(offset, this.indexMap.waterSpeed)
end

function this:_getFeedspeed(offset)
  return core:GetInt(offset, this.indexMap.feedSpeed)
end

function this:_getMovespeed(offset)
  return core:GetInt(offset, this.indexMap.moveSpeed)
end

function this:_getIsrecommend(offset)
  return core:GetBool(offset, this.indexMap.isRecommend)
end

function this:_getTechnologyexp(offset)
  local str = core:GetVString(offset, this.indexMap.technologyExp).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.dictionary, "number", "number")
end

function this:_getFarm_exp(offset)
  return core:GetInt(offset, this.indexMap.farm_exp)
end

this.keyToMethodsMap = {
  id = this._getId,
  sizeType = this._getSizetype,
  laborType = this._getLabortype,
  laborScoreLimit = this._getLaborscorelimit,
  laborScoreUpperLimit = this._getLaborscoreupperlimit,
  talentGroupId = this._getTalentgroupid,
  croplandTalentRadius = this._getCroplandtalentradius,
  homeSkillList = this._getHomeskilllist,
  homeNormalSkillList = this._getHomenormalskilllist,
  homePetRestSkill = this._getHomepetrestskill,
  homePetRunSkill = this._getHomepetrunskill,
  farmProducts = this._getFarmproducts,
  satietyScore = this._getSatietyscore,
  waterSpeed = this._getWaterspeed,
  feedSpeed = this._getFeedspeed,
  moveSpeed = this._getMovespeed,
  isRecommend = this._getIsrecommend,
  technologyExp = this._getTechnologyexp,
  farm_exp = this._getFarm_exp
}
return this
