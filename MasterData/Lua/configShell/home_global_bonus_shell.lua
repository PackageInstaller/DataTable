local this = class("home_global_bonus_shell", G_BaseConfig)
local core = G_Tables.TDHomeGlobalBonusTable.GetInstance()

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
  additionType = 1,
  additionName = 2,
  additionLevel = 3,
  additonAttribute = 4,
  addtionValue = 5,
  needMaterials = 6,
  bulidTyps = 7
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getAdditiontype(offset)
  return core:GetInt(offset, this.indexMap.additionType)
end

function this:_getAdditionname(offset)
  local langStr = G_TableMgrIns:GetLangStr("home_global_bonus", core:GetVString(offset, this.indexMap.additionName))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "additionName")
end

function this:_getAdditionlevel(offset)
  return core:GetInt(offset, this.indexMap.additionLevel)
end

function this:_getAdditonattribute(offset)
  return core:GetInt(offset, this.indexMap.additonAttribute)
end

function this:_getAddtionvalue(offset)
  return core:GetInt(offset, this.indexMap.addtionValue)
end

function this:_getNeedmaterials(offset)
  local str = core:GetVString(offset, this.indexMap.needMaterials).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getBulidtyps(offset)
  return core:GetInt(offset, this.indexMap.bulidTyps)
end

this.keyToMethodsMap = {
  id = this._getId,
  additionType = this._getAdditiontype,
  additionName = this._getAdditionname,
  additionLevel = this._getAdditionlevel,
  additonAttribute = this._getAdditonattribute,
  addtionValue = this._getAddtionvalue,
  needMaterials = this._getNeedmaterials,
  bulidTyps = this._getBulidtyps
}
return this
