local this = class("home_dorm_furniture_shell", G_BaseConfig)
local core = G_Tables.TDHomeDormFurnitureTable.GetInstance()

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
  heroId = 2,
  isLookatOpen = 3,
  isFurniture = 4,
  shopIcon = 5,
  shopPic = 6,
  objId = 7,
  interactIdleAnimateName = 8,
  furnitureMontageName = 9,
  interactPos = 10,
  pos = 11,
  cameraId = 12,
  interactWeight = 13,
  value = 14,
  type = 15,
  defaultFragId = 16,
  worldFragId = 17,
  editorId = 18,
  interactPoint = 19,
  sceneId = 20
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getName(offset)
  local langStr = G_TableMgrIns:GetLangStr("home_dorm_furniture", core:GetVString(offset, this.indexMap.name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "name")
end

function this:_getHeroid(offset)
  return core:GetInt(offset, this.indexMap.heroId)
end

function this:_getIslookatopen(offset)
  return core:GetBool(offset, this.indexMap.isLookatOpen)
end

function this:_getIsfurniture(offset)
  return core:GetBool(offset, this.indexMap.isFurniture)
end

function this:_getShopicon(offset)
  local str = core:GetVString(offset, this.indexMap.shopIcon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getShoppic(offset)
  local str = core:GetVString(offset, this.indexMap.shopPic).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getObjid(offset)
  return core:GetInt(offset, this.indexMap.objId)
end

function this:_getInteractidleanimatename(offset)
  return core:GetVString(offset, this.indexMap.interactIdleAnimateName).value
end

function this:_getFurnituremontagename(offset)
  return core:GetVString(offset, this.indexMap.furnitureMontageName).value
end

function this:_getInteractpos(offset)
  local str = core:GetVString(offset, this.indexMap.interactPos).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getPos(offset)
  local str = core:GetVString(offset, this.indexMap.pos).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getCameraid(offset)
  local str = core:GetVString(offset, this.indexMap.cameraId).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getInteractweight(offset)
  return core:GetInt(offset, this.indexMap.interactWeight)
end

function this:_getValue(offset)
  return core:GetInt(offset, this.indexMap.value)
end

function this:_getType(offset)
  return core:GetInt(offset, this.indexMap.type)
end

function this:_getDefaultfragid(offset)
  return core:GetInt(offset, this.indexMap.defaultFragId)
end

function this:_getWorldfragid(offset)
  return core:GetInt(offset, this.indexMap.worldFragId)
end

function this:_getEditorid(offset)
  return core:GetInt(offset, this.indexMap.editorId)
end

function this:_getInteractpoint(offset)
  local str = core:GetVString(offset, this.indexMap.interactPoint).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getSceneid(offset)
  return core:GetInt(offset, this.indexMap.sceneId)
end

this.keyToMethodsMap = {
  id = this._getId,
  name = this._getName,
  heroId = this._getHeroid,
  isLookatOpen = this._getIslookatopen,
  isFurniture = this._getIsfurniture,
  shopIcon = this._getShopicon,
  shopPic = this._getShoppic,
  objId = this._getObjid,
  interactIdleAnimateName = this._getInteractidleanimatename,
  furnitureMontageName = this._getFurnituremontagename,
  interactPos = this._getInteractpos,
  pos = this._getPos,
  cameraId = this._getCameraid,
  interactWeight = this._getInteractweight,
  value = this._getValue,
  type = this._getType,
  defaultFragId = this._getDefaultfragid,
  worldFragId = this._getWorldfragid,
  editorId = this._getEditorid,
  interactPoint = this._getInteractpoint,
  sceneId = this._getSceneid
}
return this
