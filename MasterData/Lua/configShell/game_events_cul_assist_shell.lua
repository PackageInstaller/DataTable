local this = class("game_events_cul_assist_shell", G_BaseConfig)
local core = G_Tables.TDGameEventsCulAssistTable.GetInstance()

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
  assistId = 0,
  systemId = 1,
  assisttype = 2,
  unlockdesc = 3
}

function this:_getAssistid(offset)
  return core:GetInt(offset, this.indexMap.assistId)
end

function this:_getSystemid(offset)
  return core:GetInt(offset, this.indexMap.systemId)
end

function this:_getAssisttype(offset)
  return core:GetInt(offset, this.indexMap.assisttype)
end

function this:_getUnlockdesc(offset)
  local langStr = G_TableMgrIns:GetLangStr("game_events_cul_assist", core:GetVString(offset, this.indexMap.unlockdesc))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "unlockdesc")
end

this.keyToMethodsMap = {
  assistId = this._getAssistid,
  systemId = this._getSystemid,
  assisttype = this._getAssisttype,
  unlockdesc = this._getUnlockdesc
}
return this
