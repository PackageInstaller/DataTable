local this = class("accessory_shell", G_BaseConfig)
local core = G_Tables.TDAccessoryTable.GetInstance()

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
  rarity = 2,
  type = 3,
  headRank = 4,
  position = 5,
  setId = 6,
  mainAttr = 7,
  elementAttr = 8,
  subAttr = 9,
  subParameter = 10,
  exp = 11,
  smelt_point = 12,
  refreshCost1 = 13,
  refreshCost2 = 14,
  texture = 15,
  commonItemId = 16,
  provideLaborExp = 17,
  desc = 18,
  way = 19,
  wayDesc = 20,
  smeltReturn = 21
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getName(offset)
  local langStr = G_TableMgrIns:GetLangStr("accessory", core:GetVString(offset, this.indexMap.name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "name")
end

function this:_getRarity(offset)
  return core:GetInt(offset, this.indexMap.rarity)
end

function this:_getType(offset)
  return core:GetInt(offset, this.indexMap.type)
end

function this:_getHeadrank(offset)
  return core:GetInt(offset, this.indexMap.headRank)
end

function this:_getPosition(offset)
  return core:GetInt(offset, this.indexMap.position)
end

function this:_getSetid(offset)
  return core:GetInt(offset, this.indexMap.setId)
end

function this:_getMainattr(offset)
  return core:GetInt(offset, this.indexMap.mainAttr)
end

function this:_getElementattr(offset)
  return core:GetInt(offset, this.indexMap.elementAttr)
end

function this:_getSubattr(offset)
  return core:GetInt(offset, this.indexMap.subAttr)
end

function this:_getSubparameter(offset)
  return core:GetInt(offset, this.indexMap.subParameter)
end

function this:_getExp(offset)
  return core:GetInt(offset, this.indexMap.exp)
end

function this:_getSmelt_point(offset)
  return core:GetInt(offset, this.indexMap.smelt_point)
end

function this:_getRefreshcost1(offset)
  local str = core:GetVString(offset, this.indexMap.refreshCost1).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getRefreshcost2(offset)
  local str = core:GetVString(offset, this.indexMap.refreshCost2).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getTexture(offset)
  local str = core:GetVString(offset, this.indexMap.texture).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 3)
end

function this:_getCommonitemid(offset)
  return core:GetInt(offset, this.indexMap.commonItemId)
end

function this:_getProvidelaborexp(offset)
  return core:GetInt(offset, this.indexMap.provideLaborExp)
end

function this:_getDesc(offset)
  local langStr = G_TableMgrIns:GetLangStr("accessory", core:GetVString(offset, this.indexMap.desc))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "desc")
end

function this:_getWay(offset)
  local str = core:GetVString(offset, this.indexMap.way).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getWaydesc(offset)
  local langStrList = G_TableMgrIns:GetListLangStr("accessory", core:GetVString(offset, this.indexMap.wayDesc))
  return G_ConfigParser.ParseConfigStr(langStrList, G_ConfigConst.ParseType.listLangstring, "accessory")
end

function this:_getSmeltreturn(offset)
  local str = core:GetVString(offset, this.indexMap.smeltReturn).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

this.keyToMethodsMap = {
  id = this._getId,
  name = this._getName,
  rarity = this._getRarity,
  type = this._getType,
  headRank = this._getHeadrank,
  position = this._getPosition,
  setId = this._getSetid,
  mainAttr = this._getMainattr,
  elementAttr = this._getElementattr,
  subAttr = this._getSubattr,
  subParameter = this._getSubparameter,
  exp = this._getExp,
  smelt_point = this._getSmelt_point,
  refreshCost1 = this._getRefreshcost1,
  refreshCost2 = this._getRefreshcost2,
  texture = this._getTexture,
  commonItemId = this._getCommonitemid,
  provideLaborExp = this._getProvidelaborexp,
  desc = this._getDesc,
  way = this._getWay,
  wayDesc = this._getWaydesc,
  smeltReturn = this._getSmeltreturn
}
return this
