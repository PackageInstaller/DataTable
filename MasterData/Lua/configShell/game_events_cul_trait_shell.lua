local this = class("game_events_cul_trait_shell", G_BaseConfig)
local core = G_Tables.TDGameEventsCulTraitTable.GetInstance()

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
  traitID = 0,
  activityid = 1,
  traitName = 2,
  traitDesc = 3,
  rarity = 4,
  effect = 5,
  showtype = 6
}

function this:_getTraitid(offset)
  return core:GetInt(offset, this.indexMap.traitID)
end

function this:_getActivityid(offset)
  return core:GetInt(offset, this.indexMap.activityid)
end

function this:_getTraitname(offset)
  local langStr = G_TableMgrIns:GetLangStr("game_events_cul_trait", core:GetVString(offset, this.indexMap.traitName))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "traitName")
end

function this:_getTraitdesc(offset)
  local langStr = G_TableMgrIns:GetLangStr("game_events_cul_trait", core:GetVString(offset, this.indexMap.traitDesc))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "traitDesc")
end

function this:_getRarity(offset)
  return core:GetInt(offset, this.indexMap.rarity)
end

function this:_getEffect(offset)
  local str = core:GetVString(offset, this.indexMap.effect).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getShowtype(offset)
  return core:GetVString(offset, this.indexMap.showtype).value
end

this.keyToMethodsMap = {
  traitID = this._getTraitid,
  activityid = this._getActivityid,
  traitName = this._getTraitname,
  traitDesc = this._getTraitdesc,
  rarity = this._getRarity,
  effect = this._getEffect,
  showtype = this._getShowtype
}
return this
