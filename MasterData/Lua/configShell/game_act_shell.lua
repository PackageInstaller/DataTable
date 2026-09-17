local this = class("game_act_shell", G_BaseConfig)
local core = G_Tables.TDGameActTable.GetInstance()

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
  desc = 2,
  type = 3,
  timeType = 4,
  joinStart = 5,
  joinDuration = 6,
  condition = 7,
  sort = 8,
  value = 9
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getName(offset)
  local langStr = G_TableMgrIns:GetLangStr("game_act", core:GetVString(offset, this.indexMap.name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "name")
end

function this:_getDesc(offset)
  local langStr = G_TableMgrIns:GetLangStr("game_act", core:GetVString(offset, this.indexMap.desc))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "desc")
end

function this:_getType(offset)
  return core:GetInt(offset, this.indexMap.type)
end

function this:_getTimetype(offset)
  return core:GetInt(offset, this.indexMap.timeType)
end

function this:_getJoinstart(offset)
  return core:GetVString(offset, this.indexMap.joinStart).value
end

function this:_getJoinduration(offset)
  return core:GetVString(offset, this.indexMap.joinDuration).value
end

function this:_getCondition(offset)
  local str = core:GetVString(offset, this.indexMap.condition).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getSort(offset)
  return core:GetInt(offset, this.indexMap.sort)
end

function this:_getValue(offset)
  return core:GetVString(offset, this.indexMap.value).value
end

this.keyToMethodsMap = {
  id = this._getId,
  name = this._getName,
  desc = this._getDesc,
  type = this._getType,
  timeType = this._getTimetype,
  joinStart = this._getJoinstart,
  joinDuration = this._getJoinduration,
  condition = this._getCondition,
  sort = this._getSort,
  value = this._getValue
}
return this
