local this = class("star_manual_level_shell", G_BaseConfig)
local core = G_Tables.TDStarManualLevelTable.GetInstance()

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
  starManualId = 1,
  uiType = 2,
  position = 3,
  show = 4,
  order = 5,
  name = 6,
  desc = 7,
  cost = 8,
  doubleTime = 9,
  doubleDesc = 10,
  open = 11,
  openDesc = 12,
  unlockCondition = 13,
  unlockConditionText = 14,
  system = 15,
  point = 16,
  pic = 17,
  picBoss = 18,
  item = 19,
  monsterId = 20
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getStarmanualid(offset)
  return core:GetInt(offset, this.indexMap.starManualId)
end

function this:_getUitype(offset)
  return core:GetInt(offset, this.indexMap.uiType)
end

function this:_getPosition(offset)
  return core:GetInt(offset, this.indexMap.position)
end

function this:_getShow(offset)
  return core:GetInt(offset, this.indexMap.show)
end

function this:_getOrder(offset)
  return core:GetInt(offset, this.indexMap.order)
end

function this:_getName(offset)
  local langStr = G_TableMgrIns:GetLangStr("star_manual_level", core:GetVString(offset, this.indexMap.name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "name")
end

function this:_getDesc(offset)
  local langStr = G_TableMgrIns:GetLangStr("star_manual_level", core:GetVString(offset, this.indexMap.desc))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "desc")
end

function this:_getCost(offset)
  return core:GetInt(offset, this.indexMap.cost)
end

function this:_getDoubletime(offset)
  local str = core:GetVString(offset, this.indexMap.doubleTime).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getDoubledesc(offset)
  local langStr = G_TableMgrIns:GetLangStr("star_manual_level", core:GetVString(offset, this.indexMap.doubleDesc))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "doubleDesc")
end

function this:_getOpen(offset)
  local str = core:GetVString(offset, this.indexMap.open).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getOpendesc(offset)
  local langStr = G_TableMgrIns:GetLangStr("star_manual_level", core:GetVString(offset, this.indexMap.openDesc))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "openDesc")
end

function this:_getUnlockcondition(offset)
  local str = core:GetVString(offset, this.indexMap.unlockCondition).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getUnlockconditiontext(offset)
  local langStr = G_TableMgrIns:GetLangStr("star_manual_level", core:GetVString(offset, this.indexMap.unlockConditionText))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "unlockConditionText")
end

function this:_getSystem(offset)
  return core:GetInt(offset, this.indexMap.system)
end

function this:_getPoint(offset)
  return core:GetVString(offset, this.indexMap.point).value
end

function this:_getPic(offset)
  local str = core:GetVString(offset, this.indexMap.pic).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getPicboss(offset)
  local str = core:GetVString(offset, this.indexMap.picBoss).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getItem(offset)
  local str = core:GetVString(offset, this.indexMap.item).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getMonsterid(offset)
  return core:GetInt(offset, this.indexMap.monsterId)
end

this.keyToMethodsMap = {
  id = this._getId,
  starManualId = this._getStarmanualid,
  uiType = this._getUitype,
  position = this._getPosition,
  show = this._getShow,
  order = this._getOrder,
  name = this._getName,
  desc = this._getDesc,
  cost = this._getCost,
  doubleTime = this._getDoubletime,
  doubleDesc = this._getDoubledesc,
  open = this._getOpen,
  openDesc = this._getOpendesc,
  unlockCondition = this._getUnlockcondition,
  unlockConditionText = this._getUnlockconditiontext,
  system = this._getSystem,
  point = this._getPoint,
  pic = this._getPic,
  picBoss = this._getPicboss,
  item = this._getItem,
  monsterId = this._getMonsterid
}
return this
