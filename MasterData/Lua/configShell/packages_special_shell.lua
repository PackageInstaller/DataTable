local this = class("packages_special_shell", G_BaseConfig)
local core = G_Tables.TDPackagesSpecialTable.GetInstance()

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
  rewardPreview = 2,
  drops = 3,
  desc = 4,
  specialDesc = 5,
  icon = 6
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getName(offset)
  local langStr = G_TableMgrIns:GetLangStr("packages_special", core:GetVString(offset, this.indexMap.name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "name")
end

function this:_getRewardpreview(offset)
  local str = core:GetVString(offset, this.indexMap.rewardPreview).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getDrops(offset)
  return core:GetInt(offset, this.indexMap.drops)
end

function this:_getDesc(offset)
  local langStr = G_TableMgrIns:GetLangStr("packages_special", core:GetVString(offset, this.indexMap.desc))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "desc")
end

function this:_getSpecialdesc(offset)
  local langStr = G_TableMgrIns:GetLangStr("packages_special", core:GetVString(offset, this.indexMap.specialDesc))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "specialDesc")
end

function this:_getIcon(offset)
  local str = core:GetVString(offset, this.indexMap.icon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

this.keyToMethodsMap = {
  id = this._getId,
  name = this._getName,
  rewardPreview = this._getRewardpreview,
  drops = this._getDrops,
  desc = this._getDesc,
  specialDesc = this._getSpecialdesc,
  icon = this._getIcon
}
return this
