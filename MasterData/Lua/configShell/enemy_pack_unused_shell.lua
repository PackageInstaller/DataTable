local this = class("enemy_pack_unused_shell", G_BaseConfig)
local core = G_Tables.TDEnemyPackUnusedTable.GetInstance()

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
  templateID = 5,
  slotTag = 6,
  dropId = 7,
  levelStepDrop = 8,
  uncatchableType = 9,
  specialCreateType = 10
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

function this:_getSpecialcreatetype(offset)
  return core:GetInt(offset, this.indexMap.specialCreateType)
end

this.keyToMethodsMap = {
  id = this._getId,
  enemyId = this._getEnemyid,
  ECampType = this._getEcamptype,
  levelPolicy = this._getLevelpolicy,
  levelParameter = this._getLevelparameter,
  templateID = this._getTemplateid,
  slotTag = this._getSlottag,
  dropId = this._getDropid,
  levelStepDrop = this._getLevelstepdrop,
  uncatchableType = this._getUncatchabletype,
  specialCreateType = this._getSpecialcreatetype
}
return this
