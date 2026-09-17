local this = class("fish_event_shell", G_BaseConfig)
local core = G_Tables.TDFishEventTable.GetInstance()

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
  limit = 2,
  type = 3,
  perId = 4,
  reward = 5,
  icon = 6,
  desc = 7,
  param = 8
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getName(offset)
  local langStr = G_TableMgrIns:GetLangStr("fish_event", core:GetVString(offset, this.indexMap.name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "name")
end

function this:_getLimit(offset)
  return core:GetInt(offset, this.indexMap.limit)
end

function this:_getType(offset)
  return core:GetInt(offset, this.indexMap.type)
end

function this:_getPerid(offset)
  return core:GetInt(offset, this.indexMap.perId)
end

function this:_getReward(offset)
  local str = core:GetVString(offset, this.indexMap.reward).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getIcon(offset)
  local str = core:GetVString(offset, this.indexMap.icon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getDesc(offset)
  local langStr = G_TableMgrIns:GetLangStr("fish_event", core:GetVString(offset, this.indexMap.desc))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "desc")
end

function this:_getParam(offset)
  return core:GetInt(offset, this.indexMap.param)
end

this.keyToMethodsMap = {
  id = this._getId,
  name = this._getName,
  limit = this._getLimit,
  type = this._getType,
  perId = this._getPerid,
  reward = this._getReward,
  icon = this._getIcon,
  desc = this._getDesc,
  param = this._getParam
}
return this
