local this = class("world_spawner_shell", G_BaseConfig)
local core = G_Tables.TDWorldSpawnerTable.GetInstance()

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
  type = 2,
  scale = 3,
  basicType = 4,
  objectType = 5,
  openBoxReward = 6,
  resourceId = 7,
  spawnerReborn = 8,
  RefreshCondition = 9,
  property = 10,
  aiTree = 11,
  blueprint = 12,
  fsm = 13,
  interactOps = 14,
  interactParams = 15,
  weight = 16,
  worldDifficultyObjLevel = 17,
  disappearTime = 18,
  objHeight = 19,
  icon = 20,
  sievingType = 21,
  scanIcon = 22,
  scanEleType = 23,
  entityTip = 24,
  aoiRange = 25,
  getLimit = 26,
  expandParams = 27,
  aoiHeight = 28,
  collisionType = 29,
  damageSourceElements = 30
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getName(offset)
  local langStr = G_TableMgrIns:GetLangStr("world_spawner", core:GetVString(offset, this.indexMap.name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "name")
end

function this:_getType(offset)
  return core:GetInt(offset, this.indexMap.type)
end

function this:_getScale(offset)
  return core:GetFloat(offset, this.indexMap.scale)
end

function this:_getBasictype(offset)
  return core:GetInt(offset, this.indexMap.basicType)
end

function this:_getObjecttype(offset)
  return core:GetInt(offset, this.indexMap.objectType)
end

function this:_getOpenboxreward(offset)
  local str = core:GetVString(offset, this.indexMap.openBoxReward).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getResourceid(offset)
  return core:GetInt(offset, this.indexMap.resourceId)
end

function this:_getSpawnerreborn(offset)
  local str = core:GetVString(offset, this.indexMap.spawnerReborn).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getRefreshcondition(offset)
  local str = core:GetVString(offset, this.indexMap.RefreshCondition).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.listCondition)
end

function this:_getProperty(offset)
  return core:GetInt(offset, this.indexMap.property)
end

function this:_getAitree(offset)
  return core:GetInt(offset, this.indexMap.aiTree)
end

function this:_getBlueprint(offset)
  return core:GetInt(offset, this.indexMap.blueprint)
end

function this:_getFsm(offset)
  return core:GetInt(offset, this.indexMap.fsm)
end

function this:_getInteractops(offset)
  local str = core:GetVString(offset, this.indexMap.interactOps).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getInteractparams(offset)
  local str = core:GetVString(offset, this.indexMap.interactParams).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "string")
end

function this:_getWeight(offset)
  return core:GetInt(offset, this.indexMap.weight)
end

function this:_getWorlddifficultyobjlevel(offset)
  return core:GetInt(offset, this.indexMap.worldDifficultyObjLevel)
end

function this:_getDisappeartime(offset)
  return core:GetFloat(offset, this.indexMap.disappearTime)
end

function this:_getObjheight(offset)
  return core:GetFloat(offset, this.indexMap.objHeight)
end

function this:_getIcon(offset)
  local str = core:GetVString(offset, this.indexMap.icon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getSievingtype(offset)
  return core:GetInt(offset, this.indexMap.sievingType)
end

function this:_getScanicon(offset)
  return core:GetVString(offset, this.indexMap.scanIcon).value
end

function this:_getScaneletype(offset)
  return core:GetInt(offset, this.indexMap.scanEleType)
end

function this:_getEntitytip(offset)
  return core:GetInt(offset, this.indexMap.entityTip)
end

function this:_getAoirange(offset)
  return core:GetFloat(offset, this.indexMap.aoiRange)
end

function this:_getGetlimit(offset)
  local str = core:GetVString(offset, this.indexMap.getLimit).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getExpandparams(offset)
  local str = core:GetVString(offset, this.indexMap.expandParams).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.dictionary, "string", "string")
end

function this:_getAoiheight(offset)
  return core:GetBool(offset, this.indexMap.aoiHeight)
end

function this:_getCollisiontype(offset)
  return core:GetInt(offset, this.indexMap.collisionType)
end

function this:_getDamagesourceelements(offset)
  local str = core:GetVString(offset, this.indexMap.damageSourceElements).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

this.keyToMethodsMap = {
  id = this._getId,
  name = this._getName,
  type = this._getType,
  scale = this._getScale,
  basicType = this._getBasictype,
  objectType = this._getObjecttype,
  openBoxReward = this._getOpenboxreward,
  resourceId = this._getResourceid,
  spawnerReborn = this._getSpawnerreborn,
  RefreshCondition = this._getRefreshcondition,
  property = this._getProperty,
  aiTree = this._getAitree,
  blueprint = this._getBlueprint,
  fsm = this._getFsm,
  interactOps = this._getInteractops,
  interactParams = this._getInteractparams,
  weight = this._getWeight,
  worldDifficultyObjLevel = this._getWorlddifficultyobjlevel,
  disappearTime = this._getDisappeartime,
  objHeight = this._getObjheight,
  icon = this._getIcon,
  sievingType = this._getSievingtype,
  scanIcon = this._getScanicon,
  scanEleType = this._getScaneletype,
  entityTip = this._getEntitytip,
  aoiRange = this._getAoirange,
  getLimit = this._getGetlimit,
  expandParams = this._getExpandparams,
  aoiHeight = this._getAoiheight,
  collisionType = this._getCollisiontype,
  damageSourceElements = this._getDamagesourceelements
}
return this
