local this = class("accessory_main_shell", G_BaseConfig)
local core = G_Tables.TDAccessoryMainTable.GetInstance()

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
  groupId = 1,
  mainAttrId = 2,
  AttrType = 3,
  level = 4,
  battleInfo = 5,
  battleInfoName = 6,
  value = 7,
  patternId = 8
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getGroupid(offset)
  return core:GetInt(offset, this.indexMap.groupId)
end

function this:_getMainattrid(offset)
  return core:GetInt(offset, this.indexMap.mainAttrId)
end

function this:_getAttrtype(offset)
  return core:GetInt(offset, this.indexMap.AttrType)
end

function this:_getLevel(offset)
  return core:GetInt(offset, this.indexMap.level)
end

function this:_getBattleinfo(offset)
  local str = core:GetVString(offset, this.indexMap.battleInfo).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getBattleinfoname(offset)
  local langStr = G_TableMgrIns:GetLangStr("accessory_main", core:GetVString(offset, this.indexMap.battleInfoName))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "battleInfoName")
end

function this:_getValue(offset)
  return core:GetInt(offset, this.indexMap.value)
end

function this:_getPatternid(offset)
  return core:GetInt(offset, this.indexMap.patternId)
end

this.keyToMethodsMap = {
  id = this._getId,
  groupId = this._getGroupid,
  mainAttrId = this._getMainattrid,
  AttrType = this._getAttrtype,
  level = this._getLevel,
  battleInfo = this._getBattleinfo,
  battleInfoName = this._getBattleinfoname,
  value = this._getValue,
  patternId = this._getPatternid
}
return this
