local this = class("kibo_duel_competition_rank_shell", G_BaseConfig)
local core = G_Tables.TDKiboDuelCompetitionRankTable.GetInstance()

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
  ID = 0,
  name = 1,
  levlUpExp = 2,
  vModulus = 3,
  fModulus = 4,
  fluxNum = 5,
  rankReset = 6,
  rankTip = 7,
  rankTipIcon = 8,
  numIcon = 9,
  icon = 10
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.ID)
end

function this:_getName(offset)
  local langStr = G_TableMgrIns:GetLangStr("kibo_duel_competition_rank", core:GetVString(offset, this.indexMap.name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "name")
end

function this:_getLevlupexp(offset)
  return core:GetInt(offset, this.indexMap.levlUpExp)
end

function this:_getVmodulus(offset)
  return core:GetInt(offset, this.indexMap.vModulus)
end

function this:_getFmodulus(offset)
  return core:GetInt(offset, this.indexMap.fModulus)
end

function this:_getFluxnum(offset)
  return core:GetInt(offset, this.indexMap.fluxNum)
end

function this:_getRankreset(offset)
  return core:GetInt(offset, this.indexMap.rankReset)
end

function this:_getRanktip(offset)
  local langStr = G_TableMgrIns:GetLangStr("kibo_duel_competition_rank", core:GetVString(offset, this.indexMap.rankTip))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "rankTip")
end

function this:_getRanktipicon(offset)
  local str = core:GetVString(offset, this.indexMap.rankTipIcon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getNumicon(offset)
  local str = core:GetVString(offset, this.indexMap.numIcon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getIcon(offset)
  local str = core:GetVString(offset, this.indexMap.icon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

this.keyToMethodsMap = {
  ID = this._getId,
  name = this._getName,
  levlUpExp = this._getLevlupexp,
  vModulus = this._getVmodulus,
  fModulus = this._getFmodulus,
  fluxNum = this._getFluxnum,
  rankReset = this._getRankreset,
  rankTip = this._getRanktip,
  rankTipIcon = this._getRanktipicon,
  numIcon = this._getNumicon,
  icon = this._getIcon
}
return this
