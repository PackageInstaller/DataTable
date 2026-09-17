local this = class("game_events_cul_end_shell", G_BaseConfig)
local core = G_Tables.TDGameEventsCulEndTable.GetInstance()

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
  endingId = 0,
  systemId = 1,
  endingName = 2,
  trial = 3,
  endingDesc = 4,
  endingPic = 5,
  unlockTime = 6,
  condition = 7,
  unlockDesc = 8
}

function this:_getEndingid(offset)
  return core:GetInt(offset, this.indexMap.endingId)
end

function this:_getSystemid(offset)
  return core:GetInt(offset, this.indexMap.systemId)
end

function this:_getEndingname(offset)
  local langStr = G_TableMgrIns:GetLangStr("game_events_cul_end", core:GetVString(offset, this.indexMap.endingName))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "endingName")
end

function this:_getTrial(offset)
  return core:GetInt(offset, this.indexMap.trial)
end

function this:_getEndingdesc(offset)
  local langStr = G_TableMgrIns:GetLangStr("game_events_cul_end", core:GetVString(offset, this.indexMap.endingDesc))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "endingDesc")
end

function this:_getEndingpic(offset)
  local str = core:GetVString(offset, this.indexMap.endingPic).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 3)
end

function this:_getUnlocktime(offset)
  return core:GetVString(offset, this.indexMap.unlockTime).value
end

function this:_getCondition(offset)
  local str = core:GetVString(offset, this.indexMap.condition).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.listCondition)
end

function this:_getUnlockdesc(offset)
  local langStr = G_TableMgrIns:GetLangStr("game_events_cul_end", core:GetVString(offset, this.indexMap.unlockDesc))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "unlockDesc")
end

this.keyToMethodsMap = {
  endingId = this._getEndingid,
  systemId = this._getSystemid,
  endingName = this._getEndingname,
  trial = this._getTrial,
  endingDesc = this._getEndingdesc,
  endingPic = this._getEndingpic,
  unlockTime = this._getUnlocktime,
  condition = this._getCondition,
  unlockDesc = this._getUnlockdesc
}
return this
