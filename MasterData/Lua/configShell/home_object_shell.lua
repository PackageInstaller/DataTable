local this = class("home_object_shell", G_BaseConfig)
local core = G_Tables.TDHomeObjectTable.GetInstance()

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
  objName = 1,
  objResouce = 2,
  objIcon = 3,
  objType = 4,
  objDesc = 5,
  objLevel = 6,
  objRare = 7,
  homeItemSize = 8,
  objOffset = 9,
  objSize = 10,
  petAreaSize = 11,
  grassEraseSize = 12,
  objNameOffset = 13,
  locationStyle = 14,
  skillWorkTarget = 15,
  _desc = 16,
  buildingLens = 17,
  buildingLensMainUI = 18
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getObjname(offset)
  return core:GetVString(offset, this.indexMap.objName).value
end

function this:_getObjresouce(offset)
  return core:GetVString(offset, this.indexMap.objResouce).value
end

function this:_getObjicon(offset)
  local str = core:GetVString(offset, this.indexMap.objIcon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getObjtype(offset)
  local str = core:GetVString(offset, this.indexMap.objType).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getObjdesc(offset)
  return core:GetVString(offset, this.indexMap.objDesc).value
end

function this:_getObjlevel(offset)
  return core:GetInt(offset, this.indexMap.objLevel)
end

function this:_getObjrare(offset)
  return core:GetInt(offset, this.indexMap.objRare)
end

function this:_getHomeitemsize(offset)
  local str = core:GetVString(offset, this.indexMap.homeItemSize).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getObjoffset(offset)
  local str = core:GetVString(offset, this.indexMap.objOffset).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getObjsize(offset)
  local str = core:GetVString(offset, this.indexMap.objSize).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getPetareasize(offset)
  local str = core:GetVString(offset, this.indexMap.petAreaSize).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getGrasserasesize(offset)
  local str = core:GetVString(offset, this.indexMap.grassEraseSize).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getObjnameoffset(offset)
  local str = core:GetVString(offset, this.indexMap.objNameOffset).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getLocationstyle(offset)
  return core:GetInt(offset, this.indexMap.locationStyle)
end

function this:_getSkillworktarget(offset)
  local str = core:GetVString(offset, this.indexMap.skillWorkTarget).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_get_desc(offset)
  return core:GetVString(offset, this.indexMap._desc).value
end

function this:_getBuildinglens(offset)
  local str = core:GetVString(offset, this.indexMap.buildingLens).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getBuildinglensmainui(offset)
  local str = core:GetVString(offset, this.indexMap.buildingLensMainUI).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

this.keyToMethodsMap = {
  id = this._getId,
  objName = this._getObjname,
  objResouce = this._getObjresouce,
  objIcon = this._getObjicon,
  objType = this._getObjtype,
  objDesc = this._getObjdesc,
  objLevel = this._getObjlevel,
  objRare = this._getObjrare,
  homeItemSize = this._getHomeitemsize,
  objOffset = this._getObjoffset,
  objSize = this._getObjsize,
  petAreaSize = this._getPetareasize,
  grassEraseSize = this._getGrasserasesize,
  objNameOffset = this._getObjnameoffset,
  locationStyle = this._getLocationstyle,
  skillWorkTarget = this._getSkillworktarget,
  _desc = this._get_desc,
  buildingLens = this._getBuildinglens,
  buildingLensMainUI = this._getBuildinglensmainui
}
return this
