local this = class("chat_bg_shell", G_BaseConfig)
local core = G_Tables.TDChatBgTable.GetInstance()

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
  sort = 1,
  name = 2,
  desc = 3,
  specialDesc = 4,
  icon = 5,
  res = 6,
  resSmall = 7,
  showType = 8,
  showStartTime = 9,
  showEndTime = 10,
  rarity = 11,
  maxNum = 12,
  way = 13,
  wayDesc = 14,
  isDefault = 15
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getSort(offset)
  return core:GetInt(offset, this.indexMap.sort)
end

function this:_getName(offset)
  local langStr = G_TableMgrIns:GetLangStr("chat_bg", core:GetVString(offset, this.indexMap.name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "name")
end

function this:_getDesc(offset)
  local langStr = G_TableMgrIns:GetLangStr("chat_bg", core:GetVString(offset, this.indexMap.desc))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "desc")
end

function this:_getSpecialdesc(offset)
  local langStr = G_TableMgrIns:GetLangStr("chat_bg", core:GetVString(offset, this.indexMap.specialDesc))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "specialDesc")
end

function this:_getIcon(offset)
  local str = core:GetVString(offset, this.indexMap.icon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getRes(offset)
  local str = core:GetVString(offset, this.indexMap.res).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getRessmall(offset)
  local str = core:GetVString(offset, this.indexMap.resSmall).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getShowtype(offset)
  return core:GetInt(offset, this.indexMap.showType)
end

function this:_getShowstarttime(offset)
  return core:GetVString(offset, this.indexMap.showStartTime).value
end

function this:_getShowendtime(offset)
  return core:GetVString(offset, this.indexMap.showEndTime).value
end

function this:_getRarity(offset)
  return core:GetInt(offset, this.indexMap.rarity)
end

function this:_getMaxnum(offset)
  return core:GetInt(offset, this.indexMap.maxNum)
end

function this:_getWay(offset)
  local str = core:GetVString(offset, this.indexMap.way).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getWaydesc(offset)
  local langStrList = G_TableMgrIns:GetListLangStr("chat_bg", core:GetVString(offset, this.indexMap.wayDesc))
  return G_ConfigParser.ParseConfigStr(langStrList, G_ConfigConst.ParseType.listLangstring, "chat_bg")
end

function this:_getIsdefault(offset)
  return core:GetInt(offset, this.indexMap.isDefault)
end

this.keyToMethodsMap = {
  id = this._getId,
  sort = this._getSort,
  name = this._getName,
  desc = this._getDesc,
  specialDesc = this._getSpecialdesc,
  icon = this._getIcon,
  res = this._getRes,
  resSmall = this._getRessmall,
  showType = this._getShowtype,
  showStartTime = this._getShowstarttime,
  showEndTime = this._getShowendtime,
  rarity = this._getRarity,
  maxNum = this._getMaxnum,
  way = this._getWay,
  wayDesc = this._getWaydesc,
  isDefault = this._getIsdefault
}
return this
