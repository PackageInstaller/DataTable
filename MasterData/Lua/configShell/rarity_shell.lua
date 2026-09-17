local this = class("rarity_shell", G_BaseConfig)
local core = G_Tables.TDRarityTable.GetInstance()

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
  frameIcon = 2,
  colorAst = 3,
  colorCircle = 4,
  EquipmentColorAst = 5,
  equipFilter = 6,
  itemFilter = 7,
  rarityName = 8
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getName(offset)
  return core:GetVString(offset, this.indexMap.name).value
end

function this:_getFrameicon(offset)
  local str = core:GetVString(offset, this.indexMap.frameIcon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 7)
end

function this:_getColorast(offset)
  return core:GetVString(offset, this.indexMap.colorAst).value
end

function this:_getColorcircle(offset)
  return core:GetVString(offset, this.indexMap.colorCircle).value
end

function this:_getEquipmentcolorast(offset)
  return core:GetVString(offset, this.indexMap.EquipmentColorAst).value
end

function this:_getEquipfilter(offset)
  local langStr = G_TableMgrIns:GetLangStr("rarity", core:GetVString(offset, this.indexMap.equipFilter))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "equipFilter")
end

function this:_getItemfilter(offset)
  return core:GetVString(offset, this.indexMap.itemFilter).value
end

function this:_getRarityname(offset)
  local langStr = G_TableMgrIns:GetLangStr("rarity", core:GetVString(offset, this.indexMap.rarityName))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "rarityName")
end

this.keyToMethodsMap = {
  id = this._getId,
  name = this._getName,
  frameIcon = this._getFrameicon,
  colorAst = this._getColorast,
  colorCircle = this._getColorcircle,
  EquipmentColorAst = this._getEquipmentcolorast,
  equipFilter = this._getEquipfilter,
  itemFilter = this._getItemfilter,
  rarityName = this._getRarityname
}
return this
