local this = class("fish_rod_shell", G_BaseConfig)
local core = G_Tables.TDFishRodTable.GetInstance()

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
  fishRodName = 1,
  rarity = 2,
  description = 3,
  strengthNum = 4,
  buff = 5,
  buffInfo = 6,
  weaponId = 7,
  fishRodMod = 8,
  iconMain = 9
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getFishrodname(offset)
  local langStr = G_TableMgrIns:GetLangStr("fish_rod", core:GetVString(offset, this.indexMap.fishRodName))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "fishRodName")
end

function this:_getRarity(offset)
  return core:GetInt(offset, this.indexMap.rarity)
end

function this:_getDescription(offset)
  local langStr = G_TableMgrIns:GetLangStr("fish_rod", core:GetVString(offset, this.indexMap.description))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "description")
end

function this:_getStrengthnum(offset)
  return core:GetInt(offset, this.indexMap.strengthNum)
end

function this:_getBuff(offset)
  local str = core:GetVString(offset, this.indexMap.buff).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getBuffinfo(offset)
  local str = core:GetVString(offset, this.indexMap.buffInfo).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getWeaponid(offset)
  return core:GetInt(offset, this.indexMap.weaponId)
end

function this:_getFishrodmod(offset)
  local str = core:GetVString(offset, this.indexMap.fishRodMod).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getIconmain(offset)
  local str = core:GetVString(offset, this.indexMap.iconMain).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

this.keyToMethodsMap = {
  id = this._getId,
  fishRodName = this._getFishrodname,
  rarity = this._getRarity,
  description = this._getDescription,
  strengthNum = this._getStrengthnum,
  buff = this._getBuff,
  buffInfo = this._getBuffinfo,
  weaponId = this._getWeaponid,
  fishRodMod = this._getFishrodmod,
  iconMain = this._getIconmain
}
return this
