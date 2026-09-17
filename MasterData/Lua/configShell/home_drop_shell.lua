local this = class("home_drop_shell", G_BaseConfig)
local core = G_Tables.TDHomeDropTable.GetInstance()

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
  itemType = 1,
  itemId = 2,
  isSurprise = 3,
  rate = 4,
  minValue = 5,
  maxValue = 6,
  dropTime = 7,
  technologyExp = 8,
  elementTypeId = 9,
  raceId = 10,
  dropPath = 11,
  _note = 12,
  home_exp = 13
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getItemtype(offset)
  return core:GetInt(offset, this.indexMap.itemType)
end

function this:_getItemid(offset)
  local str = core:GetVString(offset, this.indexMap.itemId).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getIssurprise(offset)
  return core:GetInt(offset, this.indexMap.isSurprise)
end

function this:_getRate(offset)
  return core:GetInt(offset, this.indexMap.rate)
end

function this:_getMinvalue(offset)
  return core:GetInt(offset, this.indexMap.minValue)
end

function this:_getMaxvalue(offset)
  return core:GetInt(offset, this.indexMap.maxValue)
end

function this:_getDroptime(offset)
  return core:GetInt(offset, this.indexMap.dropTime)
end

function this:_getTechnologyexp(offset)
  local str = core:GetVString(offset, this.indexMap.technologyExp).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.dictionary, "number", "number")
end

function this:_getElementtypeid(offset)
  return core:GetInt(offset, this.indexMap.elementTypeId)
end

function this:_getRaceid(offset)
  return core:GetInt(offset, this.indexMap.raceId)
end

function this:_getDroppath(offset)
  local str = core:GetVString(offset, this.indexMap.dropPath).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_get_note(offset)
  return core:GetVString(offset, this.indexMap._note).value
end

function this:_getHome_exp(offset)
  return core:GetInt(offset, this.indexMap.home_exp)
end

this.keyToMethodsMap = {
  id = this._getId,
  itemType = this._getItemtype,
  itemId = this._getItemid,
  isSurprise = this._getIssurprise,
  rate = this._getRate,
  minValue = this._getMinvalue,
  maxValue = this._getMaxvalue,
  dropTime = this._getDroptime,
  technologyExp = this._getTechnologyexp,
  elementTypeId = this._getElementtypeid,
  raceId = this._getRaceid,
  dropPath = this._getDroppath,
  _note = this._get_note,
  home_exp = this._getHome_exp
}
return this
