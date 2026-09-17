local this = class("world_city_shell", G_BaseConfig)
local core = G_Tables.TDWorldCityTable.GetInstance()

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
  city = 1,
  type = 2,
  cityStory = 3,
  mountAvailable = 4,
  defaultTime = 5,
  timePassAvailable = 6,
  lobbyUsers = 7,
  sceneRebornTime = 8,
  exploreSwitch = 9,
  formationSence = 10,
  charge = 11,
  bgm = 12,
  amb = 13,
  artScene = 14,
  playModule = 15,
  featureBlockList = 16,
  EnterPoint = 17,
  defaultHeightLimit = 18,
  isBigWorld = 19,
  resReadMode = 20,
  backgroundTexturePath = 21,
  backgroundTextureSize = 22,
  backgroundCenterOffset = 23
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getCity(offset)
  local langStr = G_TableMgrIns:GetLangStr("world_city", core:GetVString(offset, this.indexMap.city))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "city")
end

function this:_getType(offset)
  return core:GetInt(offset, this.indexMap.type)
end

function this:_getCitystory(offset)
  local str = core:GetVString(offset, this.indexMap.cityStory).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getMountavailable(offset)
  return core:GetInt(offset, this.indexMap.mountAvailable)
end

function this:_getDefaulttime(offset)
  return core:GetInt(offset, this.indexMap.defaultTime)
end

function this:_getTimepassavailable(offset)
  return core:GetInt(offset, this.indexMap.timePassAvailable)
end

function this:_getLobbyusers(offset)
  return core:GetInt(offset, this.indexMap.lobbyUsers)
end

function this:_getScenereborntime(offset)
  return core:GetInt(offset, this.indexMap.sceneRebornTime)
end

function this:_getExploreswitch(offset)
  return core:GetInt(offset, this.indexMap.exploreSwitch)
end

function this:_getFormationsence(offset)
  return core:GetVString(offset, this.indexMap.formationSence).value
end

function this:_getCharge(offset)
  return core:GetInt(offset, this.indexMap.charge)
end

function this:_getBgm(offset)
  return core:GetVString(offset, this.indexMap.bgm).value
end

function this:_getAmb(offset)
  return core:GetVString(offset, this.indexMap.amb).value
end

function this:_getArtscene(offset)
  return core:GetVString(offset, this.indexMap.artScene).value
end

function this:_getPlaymodule(offset)
  return core:GetVString(offset, this.indexMap.playModule).value
end

function this:_getFeatureblocklist(offset)
  local str = core:GetVString(offset, this.indexMap.featureBlockList).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getEnterpoint(offset)
  local str = core:GetVString(offset, this.indexMap.EnterPoint).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.dictionary, "number", "number")
end

function this:_getDefaultheightlimit(offset)
  return core:GetInt(offset, this.indexMap.defaultHeightLimit)
end

function this:_getIsbigworld(offset)
  return core:GetInt(offset, this.indexMap.isBigWorld)
end

function this:_getResreadmode(offset)
  return core:GetInt(offset, this.indexMap.resReadMode)
end

function this:_getBackgroundtexturepath(offset)
  return core:GetVString(offset, this.indexMap.backgroundTexturePath).value
end

function this:_getBackgroundtexturesize(offset)
  return core:GetVString(offset, this.indexMap.backgroundTextureSize).value
end

function this:_getBackgroundcenteroffset(offset)
  return core:GetVString(offset, this.indexMap.backgroundCenterOffset).value
end

this.keyToMethodsMap = {
  id = this._getId,
  city = this._getCity,
  type = this._getType,
  cityStory = this._getCitystory,
  mountAvailable = this._getMountavailable,
  defaultTime = this._getDefaulttime,
  timePassAvailable = this._getTimepassavailable,
  lobbyUsers = this._getLobbyusers,
  sceneRebornTime = this._getScenereborntime,
  exploreSwitch = this._getExploreswitch,
  formationSence = this._getFormationsence,
  charge = this._getCharge,
  bgm = this._getBgm,
  amb = this._getAmb,
  artScene = this._getArtscene,
  playModule = this._getPlaymodule,
  featureBlockList = this._getFeatureblocklist,
  EnterPoint = this._getEnterpoint,
  defaultHeightLimit = this._getDefaultheightlimit,
  isBigWorld = this._getIsbigworld,
  resReadMode = this._getResreadmode,
  backgroundTexturePath = this._getBackgroundtexturepath,
  backgroundTextureSize = this._getBackgroundtexturesize,
  backgroundCenterOffset = this._getBackgroundcenteroffset
}
return this
