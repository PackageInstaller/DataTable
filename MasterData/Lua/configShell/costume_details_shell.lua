local this = class("costume_details_shell", G_BaseConfig)
local core = G_Tables.TDCostumeDetailsTable.GetInstance()

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
  Id = 0,
  Name = 1,
  Icon = 2,
  tab_ID = 3,
  gender = 4,
  path = 5,
  offset_1 = 6,
  offset_2 = 7,
  scale = 8
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.Id)
end

function this:_getName(offset)
  local langStr = G_TableMgrIns:GetLangStr("costume_details", core:GetVString(offset, this.indexMap.Name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "Name")
end

function this:_getIcon(offset)
  return core:GetVString(offset, this.indexMap.Icon).value
end

function this:_getTab_id(offset)
  return core:GetInt(offset, this.indexMap.tab_ID)
end

function this:_getGender(offset)
  return core:GetInt(offset, this.indexMap.gender)
end

function this:_getPath(offset)
  return core:GetVString(offset, this.indexMap.path).value
end

function this:_getOffset_1(offset)
  local str = core:GetVString(offset, this.indexMap.offset_1).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getOffset_2(offset)
  local str = core:GetVString(offset, this.indexMap.offset_2).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getScale(offset)
  local str = core:GetVString(offset, this.indexMap.scale).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

this.keyToMethodsMap = {
  Id = this._getId,
  Name = this._getName,
  Icon = this._getIcon,
  tab_ID = this._getTab_id,
  gender = this._getGender,
  path = this._getPath,
  offset_1 = this._getOffset_1,
  offset_2 = this._getOffset_2,
  scale = this._getScale
}
return this
