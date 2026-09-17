local this = class("pet_eggsize_shell", G_BaseConfig)
local core = G_Tables.TDPetEggsizeTable.GetInstance()

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
  size = 1,
  sizeRatio = 2
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getSize(offset)
  local langStr = G_TableMgrIns:GetLangStr("pet_eggsize", core:GetVString(offset, this.indexMap.size))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "size")
end

function this:_getSizeratio(offset)
  return core:GetInt(offset, this.indexMap.sizeRatio)
end

this.keyToMethodsMap = {
  id = this._getId,
  size = this._getSize,
  sizeRatio = this._getSizeratio
}
return this
