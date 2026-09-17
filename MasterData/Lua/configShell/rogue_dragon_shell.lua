local this = class("rogue_dragon_shell", G_BaseConfig)
local core = G_Tables.TDRogueDragonTable.GetInstance()

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
  _common = 1,
  name = 2,
  quality = 3,
  order = 4,
  needCarpTypeNum = 5,
  newneedCarpTypeNum = 6,
  needCarpType = 7,
  needCarpNum = 8,
  cost = 9,
  simpleDesc = 10,
  newsimpleDesc = 11,
  fullDesc = 12,
  newfullDesc = 13,
  buffid = 14,
  newbuffid = 15,
  monsterbuffid = 16,
  littleicon = 17,
  newlittleicon = 18,
  bigicon = 19,
  newbigicon = 20,
  battleInfoId = 21,
  battleInfoValue = 22,
  battleInfoPercentValue = 23
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_get_common(offset)
  return core:GetVString(offset, this.indexMap._common).value
end

function this:_getName(offset)
  local langStr = G_TableMgrIns:GetLangStr("rogue_dragon", core:GetVString(offset, this.indexMap.name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "name")
end

function this:_getQuality(offset)
  return core:GetInt(offset, this.indexMap.quality)
end

function this:_getOrder(offset)
  return core:GetInt(offset, this.indexMap.order)
end

function this:_getNeedcarptypenum(offset)
  local str = core:GetVString(offset, this.indexMap.needCarpTypeNum).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getNewneedcarptypenum(offset)
  local str = core:GetVString(offset, this.indexMap.newneedCarpTypeNum).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getNeedcarptype(offset)
  return core:GetInt(offset, this.indexMap.needCarpType)
end

function this:_getNeedcarpnum(offset)
  local str = core:GetVString(offset, this.indexMap.needCarpNum).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getCost(offset)
  local str = core:GetVString(offset, this.indexMap.cost).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getSimpledesc(offset)
  local langStr = G_TableMgrIns:GetLangStr("rogue_dragon", core:GetVString(offset, this.indexMap.simpleDesc))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "simpleDesc")
end

function this:_getNewsimpledesc(offset)
  local langStrList = G_TableMgrIns:GetListLangStr("rogue_dragon", core:GetVString(offset, this.indexMap.newsimpleDesc))
  return G_ConfigParser.ParseConfigStr(langStrList, G_ConfigConst.ParseType.listLangstring, "rogue_dragon")
end

function this:_getFulldesc(offset)
  local langStr = G_TableMgrIns:GetLangStr("rogue_dragon", core:GetVString(offset, this.indexMap.fullDesc))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "fullDesc")
end

function this:_getNewfulldesc(offset)
  local langStrList = G_TableMgrIns:GetListLangStr("rogue_dragon", core:GetVString(offset, this.indexMap.newfullDesc))
  return G_ConfigParser.ParseConfigStr(langStrList, G_ConfigConst.ParseType.listLangstring, "rogue_dragon")
end

function this:_getBuffid(offset)
  return core:GetInt(offset, this.indexMap.buffid)
end

function this:_getNewbuffid(offset)
  local str = core:GetVString(offset, this.indexMap.newbuffid).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getMonsterbuffid(offset)
  local str = core:GetVString(offset, this.indexMap.monsterbuffid).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getLittleicon(offset)
  local str = core:GetVString(offset, this.indexMap.littleicon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getNewlittleicon(offset)
  local str = core:GetVString(offset, this.indexMap.newlittleicon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceListStr)
end

function this:_getBigicon(offset)
  local str = core:GetVString(offset, this.indexMap.bigicon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getNewbigicon(offset)
  local str = core:GetVString(offset, this.indexMap.newbigicon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceListStr)
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
  _common = this._get_common,
  name = this._getName,
  quality = this._getQuality,
  order = this._getOrder,
  needCarpTypeNum = this._getNeedcarptypenum,
  newneedCarpTypeNum = this._getNewneedcarptypenum,
  needCarpType = this._getNeedcarptype,
  needCarpNum = this._getNeedcarpnum,
  cost = this._getCost,
  simpleDesc = this._getSimpledesc,
  newsimpleDesc = this._getNewsimpledesc,
  fullDesc = this._getFulldesc,
  newfullDesc = this._getNewfulldesc,
  buffid = this._getBuffid,
  newbuffid = this._getNewbuffid,
  monsterbuffid = this._getMonsterbuffid,
  littleicon = this._getLittleicon,
  newlittleicon = this._getNewlittleicon,
  bigicon = this._getBigicon,
  newbigicon = this._getNewbigicon,
  battleInfoId = this._getBattleinfoid,
  battleInfoValue = this._getBattleinfovalue,
  battleInfoPercentValue = this._getBattleinfopercentvalue
}
return this
