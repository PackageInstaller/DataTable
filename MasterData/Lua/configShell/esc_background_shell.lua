local this = class("esc_background_shell", G_BaseConfig)
local core = G_Tables.TDEscBackgroundTable.GetInstance()

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
  resType = 1,
  name = 2,
  showType = 3,
  heroId = 4,
  soulEssenceId = 5,
  skinId = 6,
  quality = 7,
  storyUsm = 8,
  kiboId = 9,
  illustName = 10,
  resourceType = 11,
  icon = 12,
  unlockCondi = 13,
  timelimit = 14
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getRestype(offset)
  return core:GetInt(offset, this.indexMap.resType)
end

function this:_getName(offset)
  local langStr = G_TableMgrIns:GetLangStr("esc_background", core:GetVString(offset, this.indexMap.name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "name")
end

function this:_getShowtype(offset)
  return core:GetInt(offset, this.indexMap.showType)
end

function this:_getHeroid(offset)
  return core:GetInt(offset, this.indexMap.heroId)
end

function this:_getSoulessenceid(offset)
  return core:GetInt(offset, this.indexMap.soulEssenceId)
end

function this:_getSkinid(offset)
  return core:GetInt(offset, this.indexMap.skinId)
end

function this:_getQuality(offset)
  return core:GetInt(offset, this.indexMap.quality)
end

function this:_getStoryusm(offset)
  return core:GetVString(offset, this.indexMap.storyUsm).value
end

function this:_getKiboid(offset)
  return core:GetInt(offset, this.indexMap.kiboId)
end

function this:_getIllustname(offset)
  return core:GetVString(offset, this.indexMap.illustName).value
end

function this:_getResourcetype(offset)
  return core:GetInt(offset, this.indexMap.resourceType)
end

function this:_getIcon(offset)
  local str = core:GetVString(offset, this.indexMap.icon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getUnlockcondi(offset)
  local str = core:GetVString(offset, this.indexMap.unlockCondi).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.listCondition)
end

function this:_getTimelimit(offset)
  return core:GetInt(offset, this.indexMap.timelimit)
end

this.keyToMethodsMap = {
  id = this._getId,
  resType = this._getRestype,
  name = this._getName,
  showType = this._getShowtype,
  heroId = this._getHeroid,
  soulEssenceId = this._getSoulessenceid,
  skinId = this._getSkinid,
  quality = this._getQuality,
  storyUsm = this._getStoryusm,
  kiboId = this._getKiboid,
  illustName = this._getIllustname,
  resourceType = this._getResourcetype,
  icon = this._getIcon,
  unlockCondi = this._getUnlockcondi,
  timelimit = this._getTimelimit
}
return this
