local this = class("rogue_carp_shell", G_BaseConfig)
local core = G_Tables.TDRogueCarpTable.GetInstance()

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
  carpid = 1,
  level = 2,
  levelupID = 3,
  _common = 4,
  name = 5,
  simpleName = 6,
  cost = 7,
  type = 8,
  sect = 9,
  quality = 10,
  simpleDesc = 11,
  fullDesc = 12,
  littleicon = 13,
  bigicon = 14,
  buffid = 15,
  monsterbuffid = 16,
  battleInfoId = 17,
  battleInfoValue = 18,
  battleInfoPercentValue = 19
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getCarpid(offset)
  return core:GetInt(offset, this.indexMap.carpid)
end

function this:_getLevel(offset)
  return core:GetInt(offset, this.indexMap.level)
end

function this:_getLevelupid(offset)
  return core:GetInt(offset, this.indexMap.levelupID)
end

function this:_get_common(offset)
  return core:GetVString(offset, this.indexMap._common).value
end

function this:_getName(offset)
  local langStr = G_TableMgrIns:GetLangStr("rogue_carp", core:GetVString(offset, this.indexMap.name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "name")
end

function this:_getSimplename(offset)
  local langStr = G_TableMgrIns:GetLangStr("rogue_carp", core:GetVString(offset, this.indexMap.simpleName))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "simpleName")
end

function this:_getCost(offset)
  local str = core:GetVString(offset, this.indexMap.cost).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getType(offset)
  return core:GetInt(offset, this.indexMap.type)
end

function this:_getSect(offset)
  return core:GetInt(offset, this.indexMap.sect)
end

function this:_getQuality(offset)
  return core:GetInt(offset, this.indexMap.quality)
end

function this:_getSimpledesc(offset)
  local langStr = G_TableMgrIns:GetLangStr("rogue_carp", core:GetVString(offset, this.indexMap.simpleDesc))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "simpleDesc")
end

function this:_getFulldesc(offset)
  local langStr = G_TableMgrIns:GetLangStr("rogue_carp", core:GetVString(offset, this.indexMap.fullDesc))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "fullDesc")
end

function this:_getLittleicon(offset)
  local str = core:GetVString(offset, this.indexMap.littleicon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getBigicon(offset)
  local str = core:GetVString(offset, this.indexMap.bigicon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getBuffid(offset)
  return core:GetInt(offset, this.indexMap.buffid)
end

function this:_getMonsterbuffid(offset)
  local str = core:GetVString(offset, this.indexMap.monsterbuffid).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getBattleinfoid(offset)
  local str = core:GetVString(offset, this.indexMap.battleInfoId).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getBattleinfovalue(offset)
  local str = core:GetVString(offset, this.indexMap.battleInfoValue).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getBattleinfopercentvalue(offset)
  local str = core:GetVString(offset, this.indexMap.battleInfoPercentValue).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

this.keyToMethodsMap = {
  id = this._getId,
  carpid = this._getCarpid,
  level = this._getLevel,
  levelupID = this._getLevelupid,
  _common = this._get_common,
  name = this._getName,
  simpleName = this._getSimplename,
  cost = this._getCost,
  type = this._getType,
  sect = this._getSect,
  quality = this._getQuality,
  simpleDesc = this._getSimpledesc,
  fullDesc = this._getFulldesc,
  littleicon = this._getLittleicon,
  bigicon = this._getBigicon,
  buffid = this._getBuffid,
  monsterbuffid = this._getMonsterbuffid,
  battleInfoId = this._getBattleinfoid,
  battleInfoValue = this._getBattleinfovalue,
  battleInfoPercentValue = this._getBattleinfopercentvalue
}
return this
