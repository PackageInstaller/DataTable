local this = class("reason_itemnum_change_shell", G_BaseConfig)
local core = G_Tables.TDReasonItemnumChangeTable.GetInstance()

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
  itemType = 1,
  itemSubtype = 2,
  form = 3
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getItemtype(offset)
  local str = core:GetVString(offset, this.indexMap.itemType).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getItemsubtype(offset)
  local str = core:GetVString(offset, this.indexMap.itemSubtype).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getForm(offset)
  return core:GetInt(offset, this.indexMap.form)
end

this.keyToMethodsMap = {
  id = this._getId,
  itemType = this._getItemtype,
  itemSubtype = this._getItemsubtype,
  form = this._getForm
}
return this
