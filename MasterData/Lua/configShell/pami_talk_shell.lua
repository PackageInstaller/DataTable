local this = class("pami_talk_shell", G_BaseConfig)
local core = G_Tables.TDPamiTalkTable.GetInstance()

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
  type = 1,
  order = 2,
  weight = 3,
  startTime = 4,
  endTime = 5,
  text = 6,
  desc = 7
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getType(offset)
  return core:GetInt(offset, this.indexMap.type)
end

function this:_getOrder(offset)
  return core:GetInt(offset, this.indexMap.order)
end

function this:_getWeight(offset)
  return core:GetInt(offset, this.indexMap.weight)
end

function this:_getStarttime(offset)
  return core:GetInt(offset, this.indexMap.startTime)
end

function this:_getEndtime(offset)
  return core:GetInt(offset, this.indexMap.endTime)
end

function this:_getText(offset)
  local langStr = G_TableMgrIns:GetLangStr("pami_talk", core:GetVString(offset, this.indexMap.text))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "text")
end

function this:_getDesc(offset)
  local langStr = G_TableMgrIns:GetLangStr("pami_talk", core:GetVString(offset, this.indexMap.desc))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "desc")
end

this.keyToMethodsMap = {
  id = this._getId,
  type = this._getType,
  order = this._getOrder,
  weight = this._getWeight,
  startTime = this._getStarttime,
  endTime = this._getEndtime,
  text = this._getText,
  desc = this._getDesc
}
return this
