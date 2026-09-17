local this = class("pc_button_hint_shell", G_BaseConfig)
local core = G_Tables.TDPcButtonHintTable.GetInstance()

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
  text = 1,
  type = 2,
  order = 3
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getText(offset)
  local langStr = G_TableMgrIns:GetLangStr("pc_button_hint", core:GetVString(offset, this.indexMap.text))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "text")
end

function this:_getType(offset)
  return core:GetInt(offset, this.indexMap.type)
end

function this:_getOrder(offset)
  return core:GetInt(offset, this.indexMap.order)
end

this.keyToMethodsMap = {
  id = this._getId,
  text = this._getText,
  type = this._getType,
  order = this._getOrder
}
return this
