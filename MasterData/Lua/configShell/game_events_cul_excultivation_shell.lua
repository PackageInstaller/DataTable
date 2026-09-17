local this = class("game_events_cul_excultivation_shell", G_BaseConfig)
local core = G_Tables.TDGameEventsCulExcultivationTable.GetInstance()

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
  eventsid = 1,
  type = 2,
  lvl = 3,
  unlockcondition = 4,
  UXtype = 5,
  desc = 6,
  showcharid = 7,
  icon = 8,
  cost = 9,
  effect = 10,
  unlockdesc = 11,
  name = 12
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getEventsid(offset)
  return core:GetInt(offset, this.indexMap.eventsid)
end

function this:_getType(offset)
  return core:GetInt(offset, this.indexMap.type)
end

function this:_getLvl(offset)
  return core:GetInt(offset, this.indexMap.lvl)
end

function this:_getUnlockcondition(offset)
  local str = core:GetVString(offset, this.indexMap.unlockcondition).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.listCondition)
end

function this:_getUxtype(offset)
  return core:GetInt(offset, this.indexMap.UXtype)
end

function this:_getDesc(offset)
  local langStr = G_TableMgrIns:GetLangStr("game_events_cul_excultivation", core:GetVString(offset, this.indexMap.desc))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "desc")
end

function this:_getShowcharid(offset)
  return core:GetInt(offset, this.indexMap.showcharid)
end

function this:_getIcon(offset)
  local str = core:GetVString(offset, this.indexMap.icon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getCost(offset)
  local str = core:GetVString(offset, this.indexMap.cost).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getEffect(offset)
  local str = core:GetVString(offset, this.indexMap.effect).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getUnlockdesc(offset)
  local langStr = G_TableMgrIns:GetLangStr("game_events_cul_excultivation", core:GetVString(offset, this.indexMap.unlockdesc))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "unlockdesc")
end

function this:_getName(offset)
  local langStr = G_TableMgrIns:GetLangStr("game_events_cul_excultivation", core:GetVString(offset, this.indexMap.name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "name")
end

this.keyToMethodsMap = {
  id = this._getId,
  eventsid = this._getEventsid,
  type = this._getType,
  lvl = this._getLvl,
  unlockcondition = this._getUnlockcondition,
  UXtype = this._getUxtype,
  desc = this._getDesc,
  showcharid = this._getShowcharid,
  icon = this._getIcon,
  cost = this._getCost,
  effect = this._getEffect,
  unlockdesc = this._getUnlockdesc,
  name = this._getName
}
return this
