local this = class("photo_space_case_shell", G_BaseConfig)
local core = G_Tables.TDPhotoSpaceCaseTable.GetInstance()

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
  caseName = 1,
  defaultParam = 2,
  unlock = 3
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getCasename(offset)
  local langStr = G_TableMgrIns:GetLangStr("photo_space_case", core:GetVString(offset, this.indexMap.caseName))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "caseName")
end

function this:_getDefaultparam(offset)
  return core:GetInt(offset, this.indexMap.defaultParam)
end

function this:_getUnlock(offset)
  local str = core:GetVString(offset, this.indexMap.unlock).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.listCondition)
end

this.keyToMethodsMap = {
  id = this._getId,
  caseName = this._getCasename,
  defaultParam = this._getDefaultparam,
  unlock = this._getUnlock
}
return this
