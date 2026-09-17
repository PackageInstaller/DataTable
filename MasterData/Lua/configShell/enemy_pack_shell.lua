local this = class("enemy_pack_shell", G_BaseConfig)
local core = G_Tables.TDEnemyPackTable.GetInstance()

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
  enemyId = 1,
  ECampType = 2,
  levelPolicy = 3,
  levelParameter = 4,
  levelAreaParameter = 5,
  templateID = 6,
  slotTag = 7,
  dropId = 8,
  levelStepDrop = 9,
  uncatchableType = 10,
  levelpressureType = 11,
  specialCreateType = 12,
  bornElement = 13,
  propertyId = 14,
  fixPropertySkillList = 15,
  randPropertySkillCount = 16,
  randPropertySkillList = 17,
  worldDifDrop = 18
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getEnemyid(offset)
  return core:GetInt(offset, this.indexMap.enemyId)
end

function this:_getEcamptype(offset)
  return core:GetInt(offset, this.indexMap.ECampType)
end

function this:_getLevelpolicy(offset)
  return core:GetInt(offset, this.indexMap.levelPolicy)
end

function this:_getLevelparameter(offset)
  return core:GetInt(offset, this.indexMap.levelParameter)
end

function this:_getLevelareaparameter(offset)
  local str = core:GetVString(offset, this.indexMap.levelAreaParameter).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.dictionary, "number", "number")
end

function this:_getTemplateid(offset)
  return core:GetInt(offset, this.indexMap.templateID)
end

function this:_getSlottag(offset)
  return core:GetInt(offset, this.indexMap.slotTag)
end

function this:_getDropid(offset)
  local str = core:GetVString(offset, this.indexMap.dropId).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getLevelstepdrop(offset)
  local str = core:GetVString(offset, this.indexMap.levelStepDrop).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getUncatchabletype(offset)
  return core:GetInt(offset, this.indexMap.uncatchableType)
end

function this:_getLevelpressuretype(offset)
  return core:GetInt(offset, this.indexMap.levelpressureType)
end

function this:_getSpecialcreatetype(offset)
  return core:GetInt(offset, this.indexMap.specialCreateType)
end

function this:_getBornelement(offset)
  local str = core:GetVString(offset, this.indexMap.bornElement).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getPropertyid(offset)
  return core:GetInt(offset, this.indexMap.propertyId)
end

function this:_getFixpropertyskilllist(offset)
  local str = core:GetVString(offset, this.indexMap.fixPropertySkillList).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getRandpropertyskillcount(offset)
  return core:GetInt(offset, this.indexMap.randPropertySkillCount)
end

function this:_getRandpropertyskilllist(offset)
  local str = core:GetVString(offset, this.indexMap.randPropertySkillList).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.dictionary, "number", "number")
end

function this:_getWorlddifdrop(offset)
  return core:GetInt(offset, this.indexMap.worldDifDrop)
end

this.keyToMethodsMap = {
  id = this._getId,
  enemyId = this._getEnemyid,
  ECampType = this._getEcamptype,
  levelPolicy = this._getLevelpolicy,
  levelParameter = this._getLevelparameter,
  levelAreaParameter = this._getLevelareaparameter,
  templateID = this._getTemplateid,
  slotTag = this._getSlottag,
  dropId = this._getDropid,
  levelStepDrop = this._getLevelstepdrop,
  uncatchableType = this._getUncatchabletype,
  levelpressureType = this._getLevelpressuretype,
  specialCreateType = this._getSpecialcreatetype,
  bornElement = this._getBornelement,
  propertyId = this._getPropertyid,
  fixPropertySkillList = this._getFixpropertyskilllist,
  randPropertySkillCount = this._getRandpropertyskillcount,
  randPropertySkillList = this._getRandpropertyskilllist,
  worldDifDrop = this._getWorlddifdrop
}
return this
