local this = class("keycode_shell", G_BaseConfig)
local core = G_Tables.TDKeyCodeTable.GetInstance()

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
  keyCode = 1,
  note = 2,
  keyName = 3,
  shortKey = 4,
  canBeUsed = 5
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getKeycode(offset)
  return core:GetVString(offset, this.indexMap.keyCode).value
end

function this:_getNote(offset)
  local langStr = G_TableMgrIns:GetLangStr("keyCode", core:GetVString(offset, this.indexMap.note))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "note")
end

function this:_getKeyname(offset)
  local langStr = G_TableMgrIns:GetLangStr("keyCode", core:GetVString(offset, this.indexMap.keyName))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "keyName")
end

function this:_getShortkey(offset)
  return core:GetVString(offset, this.indexMap.shortKey).value
end

function this:_getCanbeused(offset)
  return core:GetInt(offset, this.indexMap.canBeUsed)
end

this.keyToMethodsMap = {
  id = this._getId,
  keyCode = this._getKeycode,
  note = this._getNote,
  keyName = this._getKeyname,
  shortKey = this._getShortkey,
  canBeUsed = this._getCanbeused
}
return this
