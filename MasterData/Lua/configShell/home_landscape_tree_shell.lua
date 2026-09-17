local this = class("home_landscape_tree_shell", G_BaseConfig)
local core = G_Tables.TDHomeLandscapeTreeTable.GetInstance()

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
  landscapeTreeStage = 1,
  landscapeName = 2,
  upNeedschedule = 3,
  landscapeLayer = 4,
  otherResource = 5,
  storyId = 6
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getLandscapetreestage(offset)
  return core:GetInt(offset, this.indexMap.landscapeTreeStage)
end

function this:_getLandscapename(offset)
  local langStr = G_TableMgrIns:GetLangStr("home_landscape_tree", core:GetVString(offset, this.indexMap.landscapeName))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "landscapeName")
end

function this:_getUpneedschedule(offset)
  return core:GetInt(offset, this.indexMap.upNeedschedule)
end

function this:_getLandscapelayer(offset)
  return core:GetVString(offset, this.indexMap.landscapeLayer).value
end

function this:_getOtherresource(offset)
  local str = core:GetVString(offset, this.indexMap.otherResource).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getStoryid(offset)
  return core:GetInt(offset, this.indexMap.storyId)
end

this.keyToMethodsMap = {
  id = this._getId,
  landscapeTreeStage = this._getLandscapetreestage,
  landscapeName = this._getLandscapename,
  upNeedschedule = this._getUpneedschedule,
  landscapeLayer = this._getLandscapelayer,
  otherResource = this._getOtherresource,
  storyId = this._getStoryid
}
return this
