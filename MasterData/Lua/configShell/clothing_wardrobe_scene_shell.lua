local this = class("clothing_wardrobe_scene_shell", G_BaseConfig)
local core = G_Tables.TDClothingWardrobeSceneTable.GetInstance()

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
  clothingOrder = 1,
  wardrobeOrder = 2,
  SkinOrder = 3,
  onShelves = 4,
  icon = 5,
  scenesName = 6,
  SceneResource = 7,
  mobileSceneResource = 8,
  SkinCameraLeft = 9,
  SkinCameraCenter = 10
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getClothingorder(offset)
  return core:GetInt(offset, this.indexMap.clothingOrder)
end

function this:_getWardrobeorder(offset)
  return core:GetInt(offset, this.indexMap.wardrobeOrder)
end

function this:_getSkinorder(offset)
  return core:GetInt(offset, this.indexMap.SkinOrder)
end

function this:_getOnshelves(offset)
  local str = core:GetVString(offset, this.indexMap.onShelves).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getIcon(offset)
  return core:GetVString(offset, this.indexMap.icon).value
end

function this:_getScenesname(offset)
  local langStr = G_TableMgrIns:GetLangStr("clothing_wardrobe_scene", core:GetVString(offset, this.indexMap.scenesName))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "scenesName")
end

function this:_getSceneresource(offset)
  return core:GetVString(offset, this.indexMap.SceneResource).value
end

function this:_getMobilesceneresource(offset)
  return core:GetVString(offset, this.indexMap.mobileSceneResource).value
end

function this:_getSkincameraleft(offset)
  local str = core:GetVString(offset, this.indexMap.SkinCameraLeft).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getSkincameracenter(offset)
  local str = core:GetVString(offset, this.indexMap.SkinCameraCenter).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

this.keyToMethodsMap = {
  id = this._getId,
  clothingOrder = this._getClothingorder,
  wardrobeOrder = this._getWardrobeorder,
  SkinOrder = this._getSkinorder,
  onShelves = this._getOnshelves,
  icon = this._getIcon,
  scenesName = this._getScenesname,
  SceneResource = this._getSceneresource,
  mobileSceneResource = this._getMobilesceneresource,
  SkinCameraLeft = this._getSkincameraleft,
  SkinCameraCenter = this._getSkincameracenter
}
return this
