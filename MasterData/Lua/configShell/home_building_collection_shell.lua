local this = class("home_building_collection_shell", G_BaseConfig)
local core = G_Tables.TDHomeBuildingCollectionTable.GetInstance()

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
  level = 1,
  groupId = 2,
  petCapacity = 3,
  frameTexture = 4,
  buffParamsId = 5,
  pixelIcon = 6,
  miniIcon = 7,
  icon = 8,
  name = 9,
  upgradeDesc = 10,
  upgradeCondition = 11,
  technologyExp = 12,
  material = 13,
  type = 14,
  cameraDistance = 15,
  cameraVerticalAngle = 16,
  cameraHorizontalAngle = 17,
  objectOffset = 18,
  decoration = 19
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getLevel(offset)
  return core:GetInt(offset, this.indexMap.level)
end

function this:_getGroupid(offset)
  return core:GetInt(offset, this.indexMap.groupId)
end

function this:_getPetcapacity(offset)
  return core:GetInt(offset, this.indexMap.petCapacity)
end

function this:_getFrametexture(offset)
  return core:GetInt(offset, this.indexMap.frameTexture)
end

function this:_getBuffparamsid(offset)
  local str = core:GetVString(offset, this.indexMap.buffParamsId).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getPixelicon(offset)
  local str = core:GetVString(offset, this.indexMap.pixelIcon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getMiniicon(offset)
  local str = core:GetVString(offset, this.indexMap.miniIcon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getIcon(offset)
  local str = core:GetVString(offset, this.indexMap.icon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getName(offset)
  local langStr = G_TableMgrIns:GetLangStr("home_building_collection", core:GetVString(offset, this.indexMap.name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "name")
end

function this:_getUpgradedesc(offset)
  local langStrList = G_TableMgrIns:GetListLangStr("home_building_collection", core:GetVString(offset, this.indexMap.upgradeDesc))
  return G_ConfigParser.ParseConfigStr(langStrList, G_ConfigConst.ParseType.listLangstring, "home_building_collection")
end

function this:_getUpgradecondition(offset)
  local str = core:GetVString(offset, this.indexMap.upgradeCondition).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.listCondition)
end

function this:_getTechnologyexp(offset)
  local str = core:GetVString(offset, this.indexMap.technologyExp).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.dictionary, "number", "number")
end

function this:_getMaterial(offset)
  local str = core:GetVString(offset, this.indexMap.material).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getType(offset)
  return core:GetInt(offset, this.indexMap.type)
end

function this:_getCameradistance(offset)
  return core:GetFloat(offset, this.indexMap.cameraDistance)
end

function this:_getCameraverticalangle(offset)
  return core:GetFloat(offset, this.indexMap.cameraVerticalAngle)
end

function this:_getCamerahorizontalangle(offset)
  return core:GetFloat(offset, this.indexMap.cameraHorizontalAngle)
end

function this:_getObjectoffset(offset)
  local str = core:GetVString(offset, this.indexMap.objectOffset).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getDecoration(offset)
  local str = core:GetVString(offset, this.indexMap.decoration).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "string")
end

this.keyToMethodsMap = {
  id = this._getId,
  level = this._getLevel,
  groupId = this._getGroupid,
  petCapacity = this._getPetcapacity,
  frameTexture = this._getFrametexture,
  buffParamsId = this._getBuffparamsid,
  pixelIcon = this._getPixelicon,
  miniIcon = this._getMiniicon,
  icon = this._getIcon,
  name = this._getName,
  upgradeDesc = this._getUpgradedesc,
  upgradeCondition = this._getUpgradecondition,
  technologyExp = this._getTechnologyexp,
  material = this._getMaterial,
  type = this._getType,
  cameraDistance = this._getCameradistance,
  cameraVerticalAngle = this._getCameraverticalangle,
  cameraHorizontalAngle = this._getCamerahorizontalangle,
  objectOffset = this._getObjectoffset,
  decoration = this._getDecoration
}
return this
