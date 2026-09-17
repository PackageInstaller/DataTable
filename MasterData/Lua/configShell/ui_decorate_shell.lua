local this = class("ui_decorate_shell", G_BaseConfig)
local core = G_Tables.TDUiDecorateTable.GetInstance()

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
  chinese = 1,
  decoEnglish = 2
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getChinese(offset)
  local langStr = G_TableMgrIns:GetLangStr("ui_decorate", core:GetVString(offset, this.indexMap.chinese))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "chinese")
end

function this:_getDecoenglish(offset)
  return core:GetVString(offset, this.indexMap.decoEnglish).value
end

this.keyToMethodsMap = {
  id = this._getId,
  chinese = this._getChinese,
  decoEnglish = this._getDecoenglish
}
return this
