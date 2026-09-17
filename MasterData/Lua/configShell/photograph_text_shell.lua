local this = class("photograph_text_shell", G_BaseConfig)
local core = G_Tables.TDPhotographTextTable.GetInstance()

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
  textColor = 1,
  text = 2
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getTextcolor(offset)
  return core:GetVString(offset, this.indexMap.textColor).value
end

function this:_getText(offset)
  return core:GetVString(offset, this.indexMap.text).value
end

this.keyToMethodsMap = {
  id = this._getId,
  textColor = this._getTextcolor,
  text = this._getText
}
return this
