local this = class("template_herolevel_shell", G_BaseConfig)
local core = G_Tables.TDTemplateHerolevelTable.GetInstance()

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
  SkillLevel = 1,
  baseAttribute = 2,
  extraAttribute = 3,
  baseElement = 4,
  baseWeaponSkillList = 5,
  baseEquipSkillList = 6
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getSkilllevel(offset)
  return core:GetInt(offset, this.indexMap.SkillLevel)
end

function this:_getBaseattribute(offset)
  local str = core:GetVString(offset, this.indexMap.baseAttribute).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.dictionary, "number", "number")
end

function this:_getExtraattribute(offset)
  local str = core:GetVString(offset, this.indexMap.extraAttribute).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.dictionary, "number", "number")
end

function this:_getBaseelement(offset)
  local str = core:GetVString(offset, this.indexMap.baseElement).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getBaseweaponskilllist(offset)
  local str = core:GetVString(offset, this.indexMap.baseWeaponSkillList).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.dictionary, "number", "number")
end

function this:_getBaseequipskilllist(offset)
  local str = core:GetVString(offset, this.indexMap.baseEquipSkillList).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.dictionary, "number", "number")
end

this.keyToMethodsMap = {
  id = this._getId,
  SkillLevel = this._getSkilllevel,
  baseAttribute = this._getBaseattribute,
  extraAttribute = this._getExtraattribute,
  baseElement = this._getBaseelement,
  baseWeaponSkillList = this._getBaseweaponskilllist,
  baseEquipSkillList = this._getBaseequipskilllist
}
return this
