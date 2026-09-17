local this = class("pet_home_size_shell", G_BaseConfig)
local core = G_Tables.TDPetHomeSizeTable.GetInstance()

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
  sizeType = 0,
  sizeName = 1,
  icon = 2
}

function this:_getSizetype(offset)
  return core:GetInt(offset, this.indexMap.sizeType)
end

function this:_getSizename(offset)
  local langStr = G_TableMgrIns:GetLangStr("pet_home_size", core:GetVString(offset, this.indexMap.sizeName))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "sizeName")
end

function this:_getIcon(offset)
  local str = core:GetVString(offset, this.indexMap.icon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

this.keyToMethodsMap = {
  sizeType = this._getSizetype,
  sizeName = this._getSizename,
  icon = this._getIcon
}
return this
