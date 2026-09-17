local this = class("talent_rune_shell", G_BaseConfig)
local core = G_Tables.TDTalentRuneTable.GetInstance()

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
  runeItem = 1,
  equipRuneThroughCoin = 2,
  equipRuneCoin = 3,
  equipRuneCost = 4,
  runeAttribute = 5,
  runeSkill = 6,
  runeTypeName = 7,
  runeTypeEngName = 8,
  isDrop = 9
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getRuneitem(offset)
  return core:GetInt(offset, this.indexMap.runeItem)
end

function this:_getEquiprunethroughcoin(offset)
  return core:GetInt(offset, this.indexMap.equipRuneThroughCoin)
end

function this:_getEquiprunecoin(offset)
  local str = core:GetVString(offset, this.indexMap.equipRuneCoin).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getEquiprunecost(offset)
  local str = core:GetVString(offset, this.indexMap.equipRuneCost).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getRuneattribute(offset)
  local str = core:GetVString(offset, this.indexMap.runeAttribute).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.dictionary, "number", "number")
end

function this:_getRuneskill(offset)
  local str = core:GetVString(offset, this.indexMap.runeSkill).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getRunetypename(offset)
  local langStr = G_TableMgrIns:GetLangStr("talent_rune", core:GetVString(offset, this.indexMap.runeTypeName))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "runeTypeName")
end

function this:_getRunetypeengname(offset)
  return core:GetVString(offset, this.indexMap.runeTypeEngName).value
end

function this:_getIsdrop(offset)
  return core:GetInt(offset, this.indexMap.isDrop)
end

this.keyToMethodsMap = {
  id = this._getId,
  runeItem = this._getRuneitem,
  equipRuneThroughCoin = this._getEquiprunethroughcoin,
  equipRuneCoin = this._getEquiprunecoin,
  equipRuneCost = this._getEquiprunecost,
  runeAttribute = this._getRuneattribute,
  runeSkill = this._getRuneskill,
  runeTypeName = this._getRunetypename,
  runeTypeEngName = this._getRunetypeengname,
  isDrop = this._getIsdrop
}
return this
