local this = class("pet_skin_shell", G_BaseConfig)
local core = G_Tables.TDPetSkinTable.GetInstance()

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
  kiboId = 1,
  isNormal = 2,
  unitSuffix = 3,
  animatorSuffix = 4,
  name = 5,
  desc = 6,
  icon = 7,
  itemDesc = 8,
  rarity = 9,
  tag = 10,
  skinTabPic = 11,
  skinGetBg = 12,
  skinBuyWay = 13,
  unitPositionGet = 14,
  unitRotationGet = 15,
  unitScale = 16
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getKiboid(offset)
  return core:GetInt(offset, this.indexMap.kiboId)
end

function this:_getIsnormal(offset)
  return core:GetBool(offset, this.indexMap.isNormal)
end

function this:_getUnitsuffix(offset)
  return core:GetVString(offset, this.indexMap.unitSuffix).value
end

function this:_getAnimatorsuffix(offset)
  return core:GetVString(offset, this.indexMap.animatorSuffix).value
end

function this:_getName(offset)
  local langStr = G_TableMgrIns:GetLangStr("pet_skin", core:GetVString(offset, this.indexMap.name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "name")
end

function this:_getDesc(offset)
  local langStr = G_TableMgrIns:GetLangStr("pet_skin", core:GetVString(offset, this.indexMap.desc))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "desc")
end

function this:_getIcon(offset)
  local str = core:GetVString(offset, this.indexMap.icon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getItemdesc(offset)
  local langStr = G_TableMgrIns:GetLangStr("pet_skin", core:GetVString(offset, this.indexMap.itemDesc))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "itemDesc")
end

function this:_getRarity(offset)
  return core:GetInt(offset, this.indexMap.rarity)
end

function this:_getTag(offset)
  local langStrList = G_TableMgrIns:GetListLangStr("pet_skin", core:GetVString(offset, this.indexMap.tag))
  return G_ConfigParser.ParseConfigStr(langStrList, G_ConfigConst.ParseType.listLangstring, "pet_skin")
end

function this:_getSkintabpic(offset)
  local str = core:GetVString(offset, this.indexMap.skinTabPic).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getSkingetbg(offset)
  local str = core:GetVString(offset, this.indexMap.skinGetBg).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getSkinbuyway(offset)
  return core:GetInt(offset, this.indexMap.skinBuyWay)
end

function this:_getUnitpositionget(offset)
  local str = core:GetVString(offset, this.indexMap.unitPositionGet).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getUnitrotationget(offset)
  local str = core:GetVString(offset, this.indexMap.unitRotationGet).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getUnitscale(offset)
  return core:GetInt(offset, this.indexMap.unitScale)
end

this.keyToMethodsMap = {
  id = this._getId,
  kiboId = this._getKiboid,
  isNormal = this._getIsnormal,
  unitSuffix = this._getUnitsuffix,
  animatorSuffix = this._getAnimatorsuffix,
  name = this._getName,
  desc = this._getDesc,
  icon = this._getIcon,
  itemDesc = this._getItemdesc,
  rarity = this._getRarity,
  tag = this._getTag,
  skinTabPic = this._getSkintabpic,
  skinGetBg = this._getSkingetbg,
  skinBuyWay = this._getSkinbuyway,
  unitPositionGet = this._getUnitpositionget,
  unitRotationGet = this._getUnitrotationget,
  unitScale = this._getUnitscale
}
return this
