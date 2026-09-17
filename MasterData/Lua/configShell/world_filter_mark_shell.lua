local this = class("world_filter_mark_shell", G_BaseConfig)
local core = G_Tables.TDWorldFilterMarkTable.GetInstance()

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
  markType = 2,
  bossType = 3,
  specialType = 4,
  worldId = 5,
  worldmapId = 6,
  showIf = 7,
  icon = 8,
  playableFinishPerform = 9,
  iconBg = 10,
  des = 11,
  posId = 12,
  bossPosId = 13,
  rewardShow = 14,
  angle = 15,
  param = 16,
  mapMaskIcon = 17,
  mapMaskLock = 18,
  unlockCondition = 19,
  trackType = 20
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getName(offset)
  local langStr = G_TableMgrIns:GetLangStr("world_filter_mark", core:GetVString(offset, this.indexMap.name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "name")
end

function this:_getMarktype(offset)
  return core:GetInt(offset, this.indexMap.markType)
end

function this:_getBosstype(offset)
  return core:GetInt(offset, this.indexMap.bossType)
end

function this:_getSpecialtype(offset)
  return core:GetInt(offset, this.indexMap.specialType)
end

function this:_getWorldid(offset)
  return core:GetInt(offset, this.indexMap.worldId)
end

function this:_getWorldmapid(offset)
  return core:GetInt(offset, this.indexMap.worldmapId)
end

function this:_getShowif(offset)
  return core:GetInt(offset, this.indexMap.showIf)
end

function this:_getIcon(offset)
  local str = core:GetVString(offset, this.indexMap.icon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getPlayablefinishperform(offset)
  return core:GetInt(offset, this.indexMap.playableFinishPerform)
end

function this:_getIconbg(offset)
  local str = core:GetVString(offset, this.indexMap.iconBg).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getDes(offset)
  local langStr = G_TableMgrIns:GetLangStr("world_filter_mark", core:GetVString(offset, this.indexMap.des))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "des")
end

function this:_getPosid(offset)
  return core:GetInt(offset, this.indexMap.posId)
end

function this:_getBossposid(offset)
  return core:GetInt(offset, this.indexMap.bossPosId)
end

function this:_getRewardshow(offset)
  local str = core:GetVString(offset, this.indexMap.rewardShow).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getAngle(offset)
  return core:GetFloat(offset, this.indexMap.angle)
end

function this:_getParam(offset)
  return core:GetInt(offset, this.indexMap.param)
end

function this:_getMapmaskicon(offset)
  local str = core:GetVString(offset, this.indexMap.mapMaskIcon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getMapmasklock(offset)
  return core:GetInt(offset, this.indexMap.mapMaskLock)
end

function this:_getUnlockcondition(offset)
  local str = core:GetVString(offset, this.indexMap.unlockCondition).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.listCondition)
end

function this:_getTracktype(offset)
  return core:GetInt(offset, this.indexMap.trackType)
end

this.keyToMethodsMap = {
  id = this._getId,
  name = this._getName,
  markType = this._getMarktype,
  bossType = this._getBosstype,
  specialType = this._getSpecialtype,
  worldId = this._getWorldid,
  worldmapId = this._getWorldmapid,
  showIf = this._getShowif,
  icon = this._getIcon,
  playableFinishPerform = this._getPlayablefinishperform,
  iconBg = this._getIconbg,
  des = this._getDes,
  posId = this._getPosid,
  bossPosId = this._getBossposid,
  rewardShow = this._getRewardshow,
  angle = this._getAngle,
  param = this._getParam,
  mapMaskIcon = this._getMapmaskicon,
  mapMaskLock = this._getMapmasklock,
  unlockCondition = this._getUnlockcondition,
  trackType = this._getTracktype
}
return this
