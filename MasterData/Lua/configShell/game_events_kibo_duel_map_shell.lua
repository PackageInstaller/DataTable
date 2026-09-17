local this = class("game_events_kibo_duel_map_shell", G_BaseConfig)
local core = G_Tables.TDGameEventsKiboDuelMapTable.GetInstance()

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
  desc = 1,
  gameEventId = 2,
  icon = 3
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getDesc(offset)
  local langStr = G_TableMgrIns:GetLangStr("game_events_kibo_duel_map", core:GetVString(offset, this.indexMap.desc))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "desc")
end

function this:_getGameeventid(offset)
  return core:GetInt(offset, this.indexMap.gameEventId)
end

function this:_getIcon(offset)
  local str = core:GetVString(offset, this.indexMap.icon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

this.keyToMethodsMap = {
  id = this._getId,
  desc = this._getDesc,
  gameEventId = this._getGameeventid,
  icon = this._getIcon
}
return this
