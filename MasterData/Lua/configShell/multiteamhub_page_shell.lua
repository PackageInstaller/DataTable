local this = class("multiteamhub_page_shell", G_BaseConfig)
local core = G_Tables.TDMultiteamhubPageTable.GetInstance()

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
  open = 2,
  systemUnlockID = 3,
  resourceBar = 4
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getName(offset)
  local langStr = G_TableMgrIns:GetLangStr("multiteamhub_page", core:GetVString(offset, this.indexMap.name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "name")
end

function this:_getOpen(offset)
  return core:GetInt(offset, this.indexMap.open)
end

function this:_getSystemunlockid(offset)
  return core:GetInt(offset, this.indexMap.systemUnlockID)
end

function this:_getResourcebar(offset)
  local str = core:GetVString(offset, this.indexMap.resourceBar).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

this.keyToMethodsMap = {
  id = this._getId,
  name = this._getName,
  open = this._getOpen,
  systemUnlockID = this._getSystemunlockid,
  resourceBar = this._getResourcebar
}
return this
