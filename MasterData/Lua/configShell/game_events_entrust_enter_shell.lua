local this = class("game_events_entrust_enter_shell", G_BaseConfig)
local core = G_Tables.TDGameEventsEntrustEnterTable.GetInstance()

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
  artName = 2,
  gameEventId = 3,
  buttonIcon = 4
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getName(offset)
  local langStr = G_TableMgrIns:GetLangStr("game_events_entrust_enter", core:GetVString(offset, this.indexMap.name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "name")
end

function this:_getArtname(offset)
  local langStrList = G_TableMgrIns:GetListLangStr("game_events_entrust_enter", core:GetVString(offset, this.indexMap.artName))
  return G_ConfigParser.ParseConfigStr(langStrList, G_ConfigConst.ParseType.listLangstring, "game_events_entrust_enter")
end

function this:_getGameeventid(offset)
  return core:GetInt(offset, this.indexMap.gameEventId)
end

function this:_getButtonicon(offset)
  return core:GetVString(offset, this.indexMap.buttonIcon).value
end

this.keyToMethodsMap = {
  id = this._getId,
  name = this._getName,
  artName = this._getArtname,
  gameEventId = this._getGameeventid,
  buttonIcon = this._getButtonicon
}
return this
