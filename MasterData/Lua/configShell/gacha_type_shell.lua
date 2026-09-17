local this = class("gacha_type_shell", G_BaseConfig)
local core = G_Tables.TDGachaTypeTable.GetInstance()

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
  costItem = 2,
  order = 3,
  mark = 4,
  resourceBar = 5,
  showtime = 6
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getName(offset)
  local langStr = G_TableMgrIns:GetLangStr("gacha_type", core:GetVString(offset, this.indexMap.name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "name")
end

function this:_getCostitem(offset)
  return core:GetInt(offset, this.indexMap.costItem)
end

function this:_getOrder(offset)
  return core:GetInt(offset, this.indexMap.order)
end

function this:_getMark(offset)
  local langStr = G_TableMgrIns:GetLangStr("gacha_type", core:GetVString(offset, this.indexMap.mark))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "mark")
end

function this:_getResourcebar(offset)
  local str = core:GetVString(offset, this.indexMap.resourceBar).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getShowtime(offset)
  return core:GetInt(offset, this.indexMap.showtime)
end

this.keyToMethodsMap = {
  id = this._getId,
  name = this._getName,
  costItem = this._getCostitem,
  order = this._getOrder,
  mark = this._getMark,
  resourceBar = this._getResourcebar,
  showtime = this._getShowtime
}
return this
