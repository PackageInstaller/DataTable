local this = class("game_events_double_drop_shell", G_BaseConfig)
local core = G_Tables.TDGameEventsDoubleDropTable.GetInstance()

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
  entrustTypeid = 2,
  materialTypeid = 3,
  upTime = 4,
  param = 5
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getName(offset)
  local langStr = G_TableMgrIns:GetLangStr("game_events_double_drop", core:GetVString(offset, this.indexMap.name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "name")
end

function this:_getEntrusttypeid(offset)
  local str = core:GetVString(offset, this.indexMap.entrustTypeid).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getMaterialtypeid(offset)
  local str = core:GetVString(offset, this.indexMap.materialTypeid).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getUptime(offset)
  return core:GetInt(offset, this.indexMap.upTime)
end

function this:_getParam(offset)
  return core:GetInt(offset, this.indexMap.param)
end

this.keyToMethodsMap = {
  id = this._getId,
  name = this._getName,
  entrustTypeid = this._getEntrusttypeid,
  materialTypeid = this._getMaterialtypeid,
  upTime = this._getUptime,
  param = this._getParam
}
return this
