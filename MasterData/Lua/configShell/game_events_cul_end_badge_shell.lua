local this = class("game_events_cul_end_badge_shell", G_BaseConfig)
local core = G_Tables.TDGameEventsCulEndBadgeTable.GetInstance()

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
  badgeId = 0,
  endingId = 1,
  badgeName = 2,
  badgeDesc = 3,
  condition = 4,
  unlockDesc = 5,
  badgeIcon = 6
}

function this:_getBadgeid(offset)
  return core:GetInt(offset, this.indexMap.badgeId)
end

function this:_getEndingid(offset)
  return core:GetInt(offset, this.indexMap.endingId)
end

function this:_getBadgename(offset)
  local langStr = G_TableMgrIns:GetLangStr("game_events_cul_end_badge", core:GetVString(offset, this.indexMap.badgeName))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "badgeName")
end

function this:_getBadgedesc(offset)
  local langStr = G_TableMgrIns:GetLangStr("game_events_cul_end_badge", core:GetVString(offset, this.indexMap.badgeDesc))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "badgeDesc")
end

function this:_getCondition(offset)
  local str = core:GetVString(offset, this.indexMap.condition).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.listCondition)
end

function this:_getUnlockdesc(offset)
  local langStr = G_TableMgrIns:GetLangStr("game_events_cul_end_badge", core:GetVString(offset, this.indexMap.unlockDesc))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "unlockDesc")
end

function this:_getBadgeicon(offset)
  local str = core:GetVString(offset, this.indexMap.badgeIcon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 0)
end

this.keyToMethodsMap = {
  badgeId = this._getBadgeid,
  endingId = this._getEndingid,
  badgeName = this._getBadgename,
  badgeDesc = this._getBadgedesc,
  condition = this._getCondition,
  unlockDesc = this._getUnlockdesc,
  badgeIcon = this._getBadgeicon
}
return this
