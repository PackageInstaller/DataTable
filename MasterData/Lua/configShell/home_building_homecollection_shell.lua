local this = class("home_building_homecollection_shell", G_BaseConfig)
local core = G_Tables.TDHomeBuildingHomecollectionTable.GetInstance()

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
  petSize = 4,
  isNeedPet = 5,
  frameTexture = 6,
  pixelIcon = 7,
  time = 8,
  revenuetime = 9,
  miniIcon = 10,
  icon = 11,
  name = 12,
  laborType = 13,
  upgradeDesc = 14,
  upgradeCondition = 15,
  technologyExp = 16,
  material = 17,
  products = 18,
  extraProducts = 19,
  productsTimeMutiple = 20,
  type = 21,
  petPosition = 22,
  petRotation = 23,
  cameraDistance = 24,
  cameraVerticalAngle = 25,
  cameraHorizontalAngle = 26,
  objectOffset = 27,
  storageMax = 28,
  decoration = 29,
  collectionlimit = 30,
  collectionlatticelimit = 31,
  collectiontype = 32
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

function this:_getPetsize(offset)
  local str = core:GetVString(offset, this.indexMap.petSize).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getIsneedpet(offset)
  return core:GetBool(offset, this.indexMap.isNeedPet)
end

function this:_getFrametexture(offset)
  return core:GetInt(offset, this.indexMap.frameTexture)
end

function this:_getPixelicon(offset)
  local str = core:GetVString(offset, this.indexMap.pixelIcon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getTime(offset)
  local str = core:GetVString(offset, this.indexMap.time).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getRevenuetime(offset)
  return core:GetInt(offset, this.indexMap.revenuetime)
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
  local langStr = G_TableMgrIns:GetLangStr("home_building_homecollection", core:GetVString(offset, this.indexMap.name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "name")
end

function this:_getLabortype(offset)
  return core:GetInt(offset, this.indexMap.laborType)
end

function this:_getUpgradedesc(offset)
  local langStrList = G_TableMgrIns:GetListLangStr("home_building_homecollection", core:GetVString(offset, this.indexMap.upgradeDesc))
  return G_ConfigParser.ParseConfigStr(langStrList, G_ConfigConst.ParseType.listLangstring, "home_building_homecollection")
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

function this:_getProducts(offset)
  local str = core:GetVString(offset, this.indexMap.products).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getExtraproducts(offset)
  local str = core:GetVString(offset, this.indexMap.extraProducts).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getProductstimemutiple(offset)
  local str = core:GetVString(offset, this.indexMap.productsTimeMutiple).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getType(offset)
  return core:GetInt(offset, this.indexMap.type)
end

function this:_getPetposition(offset)
  local str = core:GetVString(offset, this.indexMap.petPosition).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getPetrotation(offset)
  local str = core:GetVString(offset, this.indexMap.petRotation).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
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

function this:_getStoragemax(offset)
  return core:GetInt(offset, this.indexMap.storageMax)
end

function this:_getDecoration(offset)
  local str = core:GetVString(offset, this.indexMap.decoration).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "string")
end

function this:_getCollectionlimit(offset)
  return core:GetInt(offset, this.indexMap.collectionlimit)
end

function this:_getCollectionlatticelimit(offset)
  return core:GetInt(offset, this.indexMap.collectionlatticelimit)
end

function this:_getCollectiontype(offset)
  local str = core:GetVString(offset, this.indexMap.collectiontype).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

this.keyToMethodsMap = {
  id = this._getId,
  level = this._getLevel,
  groupId = this._getGroupid,
  petCapacity = this._getPetcapacity,
  petSize = this._getPetsize,
  isNeedPet = this._getIsneedpet,
  frameTexture = this._getFrametexture,
  pixelIcon = this._getPixelicon,
  time = this._getTime,
  revenuetime = this._getRevenuetime,
  miniIcon = this._getMiniicon,
  icon = this._getIcon,
  name = this._getName,
  laborType = this._getLabortype,
  upgradeDesc = this._getUpgradedesc,
  upgradeCondition = this._getUpgradecondition,
  technologyExp = this._getTechnologyexp,
  material = this._getMaterial,
  products = this._getProducts,
  extraProducts = this._getExtraproducts,
  productsTimeMutiple = this._getProductstimemutiple,
  type = this._getType,
  petPosition = this._getPetposition,
  petRotation = this._getPetrotation,
  cameraDistance = this._getCameradistance,
  cameraVerticalAngle = this._getCameraverticalangle,
  cameraHorizontalAngle = this._getCamerahorizontalangle,
  objectOffset = this._getObjectoffset,
  storageMax = this._getStoragemax,
  decoration = this._getDecoration,
  collectionlimit = this._getCollectionlimit,
  collectionlatticelimit = this._getCollectionlatticelimit,
  collectiontype = this._getCollectiontype
}
return this
